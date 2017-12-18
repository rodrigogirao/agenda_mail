**Agenda Mail**
----

Aplicação para troca de mensagens entre usuários.

Possui usuario master , que pode visualizar todas as mensangens , inclusive arquivadas.

Usuario Master:

email: master@email.com<br />
password: 123456

**API**
----

`METHOD` | `URL` | `PARAMS`

* **URL**

  https://agendamail.herokuapp.com/api/v1

* **Required**

  `token=[string]` get your token in profile page<br />
  It's a constant value for master token

* **Permission**


  `permission=master` If is a admin request

----

* **Messages**

    `GET` | `/messages`<br />
    example: curl 'https://agendamail.herokuapp.com/api/v1/messages?token=XXX'

* **Create Message**

  `POST` | `/messages` | `message[title]=string&message[content]=string`<br />
  example: curl -X POST 'https://agendamail.herokuapp.com/api/v1/messages' -d 'message[receiver_email]=matheus@email.com&message[title]=APITEST&message[content]=CONTEUDO&token=XXX'

* **Sent**

    `GET` | `/messages/sent`<br />
    example: curl 'https://agendamail.herokuapp.com/api/v1/messages/sent?token=XXX'

* **Archived**

  `GET` | `/messages/archived` | `permision=master`<br />
  example: curl 'https://agendamail.herokuapp.com/api/v1/messages/archived?token=XXXX&permission=master'

* **Show Message**

  `GET` | `/messages/:id`<br />
  example: curl 'https://agendamail.herokuapp.com/api/v1/messages/1?token=XXX'<br />
  OR curl 'https://agendamail.herokuapp.com/api/v1/messages/1?token=XXX&permission=master'

* **Archive Message**

  `PATCH` | `/messages/:id/archive`<br />
  example: curl -X PATCH 'https://agendamail.herokuapp.com/api/v1/messages/1/archive?token=XXX'

* **Archive Multiples**

  `GET` | `/messages/archive_multiple` | `message_ids[]`<br />
  example: curl -g -X PATCH 'https://agendamail.herokuapp.com/api/v1/messages/archive_multiple?token=XXX&message_ids[]=1&message_ids[]=2'

----

* **Users**

  `GET` | `/users` | `permision=master`<br />
  example: curl 'https://agendamail.herokuapp.com/api/v1/users?token=XXX&permission=master'

* **User Messages*

  `GET` | `/users/:id/messages` | `permision=master`<br />
  curl 'https://agendamail.herokuapp.com/api/v1/users/1/messages?token=XXX&permission=master'

* **Update Profile**

  `PATCH` | `/users/:id` | `user[name]=string&user[email]=string&user[password]=string&user[password_confirmation]=string`<br />
  example: curl -g -X PATCH 'https://agendamail.herokuapp.com/api/v1/users/1?token=XXX&user[name]=Mateus'

----
**Clone**
Dowload the project and then

```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

Create a `config/application.yml'

```
development:
  api_key: XXXX
```
**Test**

`bundle exec rspec`
