**Agenda Mail**
----

Aplicação para troca de mensagens entre usuários.

**API**
----

`METHOD` | `URL` | `PARAMS`

* **URL**

  https://agendamail.herokuapp.com/api/v1

* **Required**

  `token=[string]`

* **Permission**


  `permission=master` If is a admin request

----

* **Messages**

    `GET` | `/messages`

* **Create Message**

  `POST` | `/messages` | `message[title]=string&message[content]=string`

* **Sent**

    `GET` | `/messages/sent`

* **Archived**

  `GET` | `/messages/archived` | `permision=master`

* **Show Message**

  `GET` | `/messages/:id`

* **Archive Message**

  `PATCH` | `/messages/:id/archive`

* **Archive Multiples**

  `GET` | `/messages/archive_multiple` | `message_ids[]`

----

* **Users**

  `GET` | `/users` | `permision=master`

* **User Messages*

  `GET` | `/users/:id/messages` | `permision=master`

* **Update Profile**

  `PATCH` | `/users/:id` | `user[name]=string&user[email]=string&user[password]=string&user[password_confirmation]=string`



