#/bin/sh

curl -H "Content-Type: application/json" -X GET -d '
{
    "query": {
        "multi_match": {
            "query": "modules",
            "fields": ["title.search^2", "body.search"]
        }
    },
    "highlight": {
        "fields": {
            "body.search": {}
        }  
    }
}
' http://localhost:9200/_search
