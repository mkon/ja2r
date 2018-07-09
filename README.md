# JA2R

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
