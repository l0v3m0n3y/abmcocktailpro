# abmcocktailpro
api for abmcocktailpro android app for cocktail recipes
# Example
```nim
import asyncdispatch, abmcocktailpro, json, strutils

let data = waitFor get_data()
for recipe in data["products"]:
  echo recipe["id"]
  echo recipe["title"].getStr()
  echo recipe["featured_image"].getStr()
  echo "." .repeat(40)
```

# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
