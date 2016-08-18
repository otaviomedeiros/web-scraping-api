# web-scraping-api

## Requirements

Docker toolbox in mac or docker in linux


## Running on mac with docker toolbox

Create the virtual machine...

`docker-machine create --driver virtualbox scraping-api`

`eval $(docker-machine env scraping-api)`

Build app container...

`docker-compose build`

Run containers...

`docker-compose up`

Get virtual machine ip...

`docker-machine ip scraping-api`



## Running on linux

Build app container...

`docker-compose build`

Run containers...

`docker-compose up`


## Using the api

`curl -X GET http://<your vm ip>:3000/api/page-info?link=https://12factor.net/`

Result...

`{  
   "title":"The Twelve-Factor App",
   "description":"A methodology for building modern, scalable, maintainable software-as-a-service apps.",
   "image":""
}`

