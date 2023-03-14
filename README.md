# BTC Price Tracker App

## Setup

1. Install and Setup Docker if not already
2. Clone Repo `https://github.com/da-vinci-noob/crypto-price-alert.git`
3. Rename `.env.sample` to `.env`.
4. Change Environment Variables as per your configuration (Env vars explaination below).
```
DEVISE_JWT_SECRET_KEY: As the name says this is the key used for Devise JWT Secret. you can use "rake secret" to generate the key, copy and paste the generated key here.
HTTP_BASIC_AUTH_USERNAME: Username used for Sidekiq and Swagger UI
HTTP_BASIC_AUTH_PASSWORD: Password used for Sidekiq and Swagger UI
SITE_HOST: Default host for the rails production environment.
FROM_EMAIL_ADDRESS: Default From Email Address for ActionMailer
SMTP_ADDRESS= SMTP address
SMTP_PORT: SMTP PORT
SMTP_USERNAME: SMTP USERNAME
SMTP_PASSWORD: SMTP PASSWORD
CRYPTO_PRICE_ALERT_DATABASE_HOST: Postgres DB Host address
CRYPTO_PRICE_ALERT_DATABASE_USERNAME: Postgres Username
CRYPTO_PRICE_ALERT_DATABASE_PASSWORD: Postgres Password
RAILS_ENV: Rails Environment
REDIS_URL: Redis URL

```
5. RUN `docker-compose up` to start services.

## Setup If using without Docker.
> ### Prerequisite
> > Redis Server, Postgres Database, Ruby 3.2.1
1. Setup Prerequisites.
2. Clone Repo
3. Changes ENV's as mentioned above.
4. RUN `./bin/setup` to setup Project DB's and installations
5. RUN `bundle exec rails s` to run the server.
6. RUN `bundle exec sidekiq -C config/sidekiq.yml` to run sidekiq background jobs


## Features
* User Accounts
* Target Price Alerts Creation for Individual Users.
* Users Can Delete Created Alerts
* Show All Created Alerts.
* Filter Alerts Based on their Status [Created, Triggered, Deleted]
* Sending Mails on the Price Trigger.
* Prices are checked from the Binance Websocket.
> ### This Project uses SWAGGER for the API Documentation.
1. Goto `/api-docs` for the complete documentation and test.
2. Login, Get the Bearer Token from the Response Headers
3. Scroll Top, Click on Authorize, Add the Copied Bearer token to Value and click on authorize button.
4. Test the Endpoints
## Endpoints Below.
1. Sign In - `users/sign_in`
```
curl -X 'POST' \
  'http://localhost:3000/users/sign_in' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "user": {
    "email": "test@test.com",
    "password": "test@test.com"
  }
}'
```
2. Sign Up - `/users/`
```
curl -X 'POST' \
  'http://localhost:3000/users/' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "user": {
    "email": "test@test.com",
    "password": "test@test.com"
  }
}'
```
3. Sign Out - `/users/sign_out`
```
curl -X 'DELETE' \
  'http://localhost:3000/users/sign_out' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer TOKEN'
```
4. Create Alert - `/alerts/create`
```
curl -X 'POST' \
  'http://localhost:3000/alerts/create' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer TOKEN' \
  -H 'Content-Type: application/json' \
  -d '{
  "alert": {
    "target_price": "22100"
  }
}'
```
5. Delete Alert - `/alerts/delete`
```
curl -X 'POST' \
  'http://localhost:3000/alerts/delete' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer TOKEN' \
  -H 'Content-Type: application/json' \
  -d '{
  "alert": {
    "target_price": "22100"
  }
}'
```
6. Fetch All Alerts with params - `/alerts/all_alerts`
```
curl -X 'GET' \
  'http://localhost:3000/alerts/all_alerts?page=1&status=deleted' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer TOKEN'
```
---
## To Contribute (Add new Feature, Improve Something )

- Fork the project repository
- Clone your fork
- Navigate to your local repository
- Check that your fork is the 'origin' remote by:
  > `git remote -v`
  - if not add 'origin' remote by:
    > `git remote add origin <URL_OF_YOUR_FORK>`
- Add the project repository as the 'upstream' remote by:
  > `git remote add upstream <URL_OF_THIS_PROJECT>`
- Check that you now have two remotes: an origin that points to your fork, and an upstream that points to the project repository by:
  > `git remote -v`
- Pull the latest changes from upstream into your local repository.
  > `git pull upstream main`
- Create a new branch
  > `git checkout -b BRANCH_NAME`
- Make changes in your local repository
- Commit your changes
- Push your changes to your fork
  > `git push origin BRANCH_NAME`
- Create Pull Request
  > baseRepo - base:main <- yourRepo - compare:BRANCH_NAME
- Add Your description, Add any Images/Videos if required and Submit PR.
- You can add more commits/comments to the PR.
- You can delete the Branch (BRANCH_NAME) after your PR has been accepted and merged
- Sync your local Fork Repo to Updated Project Repo.

  > `git pull upstream main`

  > `git push origin main`

---

Made with :heart: and ![Ruby](https://img.shields.io/badge/-Ruby-000000?style=flat&logo=ruby)
