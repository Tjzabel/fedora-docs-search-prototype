from lxml import html
import requests
import re
import json

elasticsearch_url = "https://vpc-fedora-docs-enuwbzv7m2egpp4dl3vndqy5ne.us-east-1.es.amazonaws.com"

def get_sitemaps(url):
    page = requests.get(url)
    tree = html.fromstring(page.content)
    return tree.xpath('//sitemapindex/sitemap/loc/text()')

def get_pages(url):
    page = requests.get(url)
    tree = html.fromstring(page.content)
    return tree.xpath('//urlset/url/loc/text()')

def get_data(url):
    page = requests.get(url)
    tree = html.fromstring(page.content)
    data = {}
    data["title"] = re.sub(r'\W+', ' ', tree.xpath('//h1/text()')[0])
    data["body"] = re.sub(r'\W+', ' ', tree.xpath('/html/body/div/main/article')[0].text_content())
    data["component"] = {}
    data["component"]["name"] = tree.xpath('/html/body/div/div/aside/div/div[1]/nav/h3/a/text()')[0]
    data["url"] = url
    return data

def main():
    url = "http://docs.horsefunerals.co.uk/en-US/sitemap.xml"

    sitemaps = get_sitemaps(url)

    print ("#!/bin/sh")

    print ("""
# Mappings:

curl -H "Content-Type: application/json" -X PUT -d '
{{
  "mappings": {{
    "page": {{ 
      "properties": {{ 
        "title": {{ 
            "type": "text",
            "store": true,
            "fields": {{
                "search": {{
                    "type": "text",
                    "analyzer": "english"
                }}
            }}
        }}, 
        "body": {{ 
            "type": "text",
            "store": true,
            "fields": {{
                "search": {{
                    "type": "text",
                    "analyzer": "english"
                }}
            }}
        }}
      }}
    }}
  }}
}}
' {url}/fedora-docs
""".format(url=elasticsearch_url))


    for sitemap in sitemaps:
        pages = get_pages(sitemap)

        for page in pages:
            try:
                data = get_data(page)
                print ("curl -H \"Content-Type: application/json\" -X POST -d '")
                print (json.dumps(data))
                print ("' {}/fedora-docs/page".format(elasticsearch_url))
            except:
                continue
  
if __name__== "__main__":
    main()
