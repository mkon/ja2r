# JA2R

[![Gem Version](https://badge.fury.io/rb/ja2r.svg)](https://badge.fury.io/rb/ja2r)
![](https://github.com/mkon/ja2r/workflows/Test/badge.svg?branch=master)
[![Depfu](https://badges.depfu.com/badges/c63f1c5b6394bba4eb73d3b1063cc0be/overview.svg)](https://depfu.com/github/mkon/ja2r?project_id=5963)

JASON-API to Ruby Object

Converts a JSON-API payload into a ruby object which supports navigation over relationships.

## Usage

```ruby
json = <<-JSON
{
   "data":{
      "id":"1001",
      "type":"persons",
      "attributes":{
         "name":"Bart"
      },
      "relationships":{
         "sister":{
            "data":{
               "id":"1002",
               "type":"persons"
            }
         }
      }
   },
   "included":[
      {
         "id":"1002",
         "type":"persons",
         "attributes":{
            "name":"Lisa"
         }
      }
   ]
}
JSON
bart = JA2R.parse(JSON.parse(json))
bart.sister.name # Lisa
```

## Options

You can pass options to `JA2R#parse` as second argument. Currently the only supported options are:

| Name          | Type    | Description                                                                                                            |
|---------------|---------|------------------------------------------------------------------------------------------------------------------------|
| safe_traverse | boolean | When setting this option to true, unknown relationships or attributes will return nil instead of raising NoMethodError |

Example:

```ruby
bart = JA2R.parse(hash, safe_traverse: true)
bart.uncle&.name # nil
```
