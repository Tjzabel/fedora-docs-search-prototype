#!/bin/sh

# Mappings:

curl -H "Content-Type: application/json" -X PUT -d '
{
  "mappings": {
    "page": { 
      "properties": { 
        "title": { 
            "type": "text",
            "store": true,
            "fields": {
                "search": {
                    "type": "text",
                    "analyzer": "english"
                }
            }
        }, 
        "body": { 
            "type": "text",
            "store": true,
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
    "body": "Multiple versions of packages in Fedora with the qualities expected from a Linux distribution: transparently built and delivered, actively maintained, and easy to install. Modularity introduces a new optional repository to Fedora called Modular (often referred to as the Application Stream or AppStream for short) that ships additional versions of software on independent life cycles. This enables users to keep their operating system up-to-date while having the right version of an application for their use case, even when the default version in the distribution changes."
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

curl -H "Content-Type: application/json" -X POST -d '{"title": "Updating modules in Fedora", "body": " Updating modules in Fedora This page will guide you through the process of updating an existing module Updating RPM Packages Pushing new sources Updating the Module Pushing a new version of the modulemd Module Build Module is built as a unit No individual package builds are done Publishing the Module Submitting a Bodhi update Updating RPM Packages Update your RPM packages the same way you would do traditionally except submitting individual package builds Useful resources Fedora Packaging Guidelines Fedora Package Maintenance Guide Updating the Module Even when you don t need to make any changes to the modulemd you still need to push a new commit to build a new version fedpkg clone modules NAME cd NAME fedpkg switch branch BRANCH git commit allow empty m update git push NAME name of the module BRANCH name of the stream branch of the module Module Build NOTE With Modularity you no longer build individual packages Instead you need to submit a module build Submitting module builds is done using fedpkg and is covered in the Building modules section Publishing the Module To make your module available to users submit submit as an update to Fedora Bodhi Make sure you are logged in and then click on Create New Update at the top right corner Fill out the following fields Candidate Builds MODULE_BUILD_ID Update notes notes for the users Final details check what applies One way of getting the MODULE_BUILD_ID is running the same command as in the previous step fedpkg module build info BUILD_ID and changing the koji tag value in the following way module nodejs 10 20180607142235 6c81f848 koji tag nodejs 10 20180607142235 6c81f848 MODULE_BUILD_ID that is removing the module part at the beginning and replacing the last with a ", "component": {"name": "Modularity"}, "url": "https://docs.fedoraproject.org/en-US/modularity/making-modules/updating-modules/"}' http://localhost:9200/fedora-docs/page/4