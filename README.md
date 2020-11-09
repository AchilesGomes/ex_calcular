# CalculatorApi

To start your Phoenix server:
  ### build docker
  `docker-compose build`

  ### Opening vm
  `docker-compose run --rm --service-ports api bash`
  
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

  ### You can use postman request CalculatorApi.postman_collection.json
  * Create a user
  * Make a login
  * Take token and put on request authorization
  * You can calculate and retrieve calculate data

