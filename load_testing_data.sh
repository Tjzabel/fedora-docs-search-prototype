#!/bin/sh

# Mappings:

curl -H "Content-Type: application/json" -X PUT -d '
{
  "mappings": {
    "page": { 
      "properties": { 
        "title": { 
            "type": "text",
            "fields": {
                "search": {
                    "type": "text",
                    "analyzer": "english"
                }
            }
        }, 
        "body": { 
            "type": "text",
            "fields": {
                "search": {
                    "type": "text",
                    "analyzer": "english"
                }
            }
        }
      }
    }
  }
}
' http://localhost:9200/fedora-docs

# Data:

curl -H "Content-Type: application/json" -X POST -d '
{
    "title": "About modularity",
    "url": "/modularity/",
    "component": {
        "name": "Modularity"
    },
    "body": "Multiple versions of packages in Fedora with the qualities expected from a Linux distribution: transparently built and delivered, actively maintained, and easy to install."
}
' http://localhost:9200/fedora-docs/page/1

curl -H "Content-Type: application/json" -X POST -d '
{
    "title": "Creating modules",
    "url": "/modularity/creating-modules/",
    "component": {
        "name": "Modularity"
    },
    "body": "Creating modules is quite easy. Write your modulemd and other things and done!"
}
' http://localhost:9200/fedora-docs/page/2

curl -H "Content-Type: application/json" -X POST -d '
{
    "title": "Another page",
    "url": "/modularity/creating-modules/",
    "component": {
        "name": "Modularity"
    },
    "body": "Modularity and creating modules is super cool"
}
' http://localhost:9200/fedora-docs/page/3
