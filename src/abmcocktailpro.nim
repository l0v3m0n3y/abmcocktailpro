import asyncdispatch, httpclient, json

const api = "https://abmcocktailpro.com/api"
var headers = newHttpHeaders({
  "Connection": "keep-alive", 
  "Host": "abmcocktailpro.com",
  "Content-Type": "application/json", 
  "accept": "application/json", 
  "user-agent": "okhttp/4.12.0"
})

proc get_recipes_list*(page:int=1,filters:string="",keywords:string=""): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    var jsonBody = %*{
      "per_page": 12,
      "page": $page,
      "filters": newJArray(),
      "keywords": newJArray(),
      "pageFilter": newJObject()
    }
    
    if filters != "":
      jsonBody["filters"] = %*[filters]
    
    if keywords != "":
      jsonBody["keywords"] = %*[keywords]
    
    let response = await client.post(api & "/recipes",body= $jsonBody)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc search_req*(q:string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let json = %*{"keyword": q}
    let response = await client.post(api & "/keywords",body= $json)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_recipes_by_id*(id:int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/recipes/" & $id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_products_list*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/products")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_products_by_id*(id:int=1): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/products/" & $id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_data*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/get-data")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()
