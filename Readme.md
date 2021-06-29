* To run the application
1. `bundle install`
2. `ruby index.rb`
3. open in browser `localhost:4567`

* To run the tests
1. run tests by `rake test`


* Decisions taken
Incoming requests from web/api are handled by `Actions`
`Actions` use `Interactos` to perform individual tasks
`Interactos` holds business logic, and can use other interactors to perform complex tasks
`Interactos` take `RequestModel` as input and output `ResponseModel`
`Models` are used for persistence
