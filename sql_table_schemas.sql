CREATE TABLE Steps(
   id                 VARCHAR(40) NOT NULL PRIMARY KEY
  ,eventtime          DATETIME  NOT NULL
  ,convid             VARCHAR(80) NOT NULL
  ,tenantname         VARCHAR(100)
  ,tenantid           VARCHAR(100)
  ,channelid          VARCHAR(100)
  ,userid             VARCHAR(100)
  ,correlationid      VARCHAR(40)
  ,speaker            VARCHAR(100)
  ,stepid             VARCHAR(100)
  ,steplabel          VARCHAR(200)
  ,steptext           VARCHAR(1000)
  ,stepresponseindex  INTEGER
  ,stepresponseentity VARCHAR(1000)
  ,dialogname         VARCHAR(100)
  ,country            VARCHAR(100)
  ,province           VARCHAR(100)
  ,city               VARCHAR(100)
  ,clientip           VARCHAR(7)
);

CREATE TABLE Messages(
   id            VARCHAR(40) NOT NULL PRIMARY KEY
  ,eventtime     VARCHAR(28) NOT NULL
  ,convid        VARCHAR(100) NOT NULL
  ,tenantname    VARCHAR(100)
  ,tenantid      VARCHAR(40)
  ,channelid     VARCHAR(100)
  ,userid        VARCHAR(100)
  ,correlationid VARCHAR(40)
  ,speaker       VARCHAR(100)
  ,text          VARCHAR(2000)
  ,dialogname    VARCHAR(100)
  ,country       VARCHAR(100)
  ,province      VARCHAR(100)
  ,city          VARCHAR(100)
  ,clientip      VARCHAR(20)
);
