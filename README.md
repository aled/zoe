# zoe
Record the battery status of a Renault Zoe and write to a database

To make this work, you'll need a computer running 24/7 to query the Renault API.

Once the queries are being stored in the database, it is simple to connect Grafana to it.

Use this query to show the charge level on a graph

```
SELECT
  requesttimestamp AS "time",
  'chargelevel' AS metric,
  chargelevel::int
FROM vw_zeserviceslog
WHERE
  $__timeFilter(requesttimestamp) AND
  chargelevel is not null
ORDER BY 1,2
```
