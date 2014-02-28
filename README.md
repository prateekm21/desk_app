# Welcome

* **Author:**  Prateek Mehrotra
* **Contact:** prateek123 at gmail dot com


***

UI is bare minimum and can be enhanced. I dont have exposure to Angular so I used rails view and simple JS to render

[UI work flow](https://github.com/prateekm21/desk_app/wiki/UI-work-flow)

***

**Heroku** | [http://pm-desk-app.herokuapp.com/](http://pm-desk-app.herokuapp.com/)

***


**Clone app**
```
$ git clone https://prateekm21@bitbucket.org/prateekm21/desk_app.git
```

**PREP**
```
bundle install
```

**Run Specs**
```
bundle exec rspec -fd
```

***

### API ###


> **GET /desk/cases**

  * When cases cannot be retrived
  * response `status code: 422`

        {
          error: "Could not retrieve case info"
        }

  * When cases can be retrieved
  * response `status code: 200`

        [
         {
            id: 1,
            external_id: null,
            blurb: "Thanks for trying Desk.com"
            subject: "Welcome to Desk.com",
            ...
         },
         {......}
        ]


> **GET /desk/retrive_labels**

  * When labels cannot be retrived
  * response `status code: 422`

        {
          error: "Could not retrieve labels info"
        }

  * When labels can be retrieved
  * response `status code: 200`

        [
         {
           name: "Abandoned Chats",
           description: "Abandoned Chats"
         },
         {
           name: "Escalated",
           description: "Escalated"
         },
         { .... }
        ]


> **POST /desk/create_label**

  * options:

         {
          label:  "",
          description: "",
          type: [case, macro, or article]
          color:[default, blue, white, yellow, red, orange, green, black, purple, brown, grey, pink]
         }


  * When labels cannot be added
  * response `status code: 422`
        
         {
           "error": {
           "message": "Validation Failed",
           "errors": {
             "name": [
                 "taken"
              ]
            }
          }
         }

  * When labels addition is success
  * response `status code: 200`

        {
          success: "label added"
        }
        
     
