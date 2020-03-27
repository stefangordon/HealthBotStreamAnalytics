This example query is in two phases.  

1. Parse the custom dimensions array and flatten it through aggregation.
2. Insert the two primary record types `messages` and `steps` into their own SQL tables.

You may choose to omit `messages` as `steps` are a superior format.

```
WITH STEPS AS
(    
    SELECT 
       min(cast(A.internal.data.id AS NVARCHAR(MAX))) as Id,
       min(cast(GetArrayElement(A.event,0).name AS NVARCHAR(MAX))) as eventType,
       min(cast(dim.ArrayValue.conv_id AS NVARCHAR(MAX))) as convId,
       min(cast(dim.ArrayValue.tenantName AS NVARCHAR(MAX))) as tenantName,
       min(cast(dim.ArrayValue.tenantId AS NVARCHAR(MAX))) as tenantId,
       min(cast(dim.ArrayValue.channelId AS NVARCHAR(MAX))) as channelId,       
       min(cast(dim.ArrayValue.user_id AS NVARCHAR(MAX))) as userId,
       min(cast(dim.ArrayValue.correlation_id AS NVARCHAR(MAX))) as correlationId,
       min(cast(dim.ArrayValue.speaker AS NVARCHAR(MAX))) as speaker,
       UDF.Parse(min(cast(dim.ArrayValue.step AS NVARCHAR(MAX)))) as step,
       min(cast(dim.ArrayValue.text AS NVARCHAR(MAX))) as text,
       min(cast(dim.ArrayValue.dialogName AS NVARCHAR(MAX))) as dialogName,
       min(cast(A.context.location.country AS NVARCHAR(MAX))) as country,
       min(cast(A.context.location.province AS NVARCHAR(MAX))) as province,
       min(cast(A.context.location.city AS NVARCHAR(MAX))) as city,
       min(cast(A.context.location.clientip AS NVARCHAR(MAX))) as clientIp,
       min(cast(A.context.data.eventTime AS datetime)) as eventTime
    FROM cdcblobs A PARTITION BY BlobName
    CROSS APPLY GetElements(A.context.custom.dimensions) as dim
    GROUP BY System.Timestamp, A.internal.data.id
    HAVING eventType = 'StepExecuted' OR eventType = 'Message'
)

SELECT
    Id,
    eventTime,
    convId,
    tenantName,
    tenantId,
    channelId,
    userId,
    correlationId,
    speaker,
    step.id as stepId,
    step.label as stepLabel,
    step.text as stepText,
    step.response.[index] as stepResponseIndex,
    COALESCE(step.response.entity, step.response.state) as stepResponseEntity,
    dialogName,
    country,
    province,
    city,
    clientIp
INTO
    StepOutput
FROM STEPS PARTITION BY ConvId
WHERE eventType = 'StepExecuted'

SELECT
    Id,
    eventTime,
    convId,
    tenantName,
    tenantId,
    channelId,
    userId,
    correlationId,
    speaker,
    text,
    dialogName,
    country,
    province,
    city,
    clientIp
INTO
    MessageOutput
FROM STEPS PARTITION BY ConvId
WHERE eventType = 'Message'
```
