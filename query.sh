#/bin/sh

curl -H "Content-Type: application/json" -X GET -d '
{
    "query": {
        "multi_match": {
            "query": "packaging modules",
            "fields": ["title.search^2", "body.search"]
        }
    },
    "highlight": {
        "fields": {
            "body": {}
        }  
    }
}
' http://localhost:9200/_search
