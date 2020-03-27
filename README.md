# HealthBot Stream Analytics

Use Stream Analytics to move Health Bot App Insights data to SQL

This `readme.md` is incomplete.  Please reference [related documentation](https://docs.microsoft.com/en-us/azure/azure-monitor/app/code-sample-export-sql-stream-analytics) for the basics of configuring
Application Insights and Stream Analytics, then use this repository for the schemas specific to HealthBot.

## Stream Analytics Query
A [Stream Analytics query](stream_analytics_query.md) is provided which can parse blobs from Application Insights continuous delivery
and push them into SQL tables.

## Table Creation Scripts
SQL scripts are provided to create tables that can serve as Stream Analytics Outputs

