BudgetBuddy Documentation
=========================

Welcome to the Budget Manager app "Budget Buddy"! I am Diogo Ferreira, and this app was designed with my personal needs in mind so there are features that you might not use, and some that might be missing, but I am currently working on adding more. for more info you can contact me at:
[Github](https://www.github.com/diogo-febra-ferreira/) or 
[Linkedin](https://www.linkedin.com/in/diogo-febra-ferreira/).

Transactions
============

Transactions are considered withdrawals when the amount is negative (e. -4, -2.12,-2938.23) and income when the amount is positive.

Accounts
========

Currently, a user cannot have many accounts with the same name to avoid confusion.

Admin endpoints
===============

There are 4 backend endpoints designed to clean the database or manipulate it for testing and administration purposes:

*   /drop-tables = will drop all the tables
*   /create-tables = will create all the needed tables and add an admin user with id 1
*   /insert-dummy-data = will add a few more users with accounts, transactions and categories, and will attribute the admin a few investments already filled out.

Buttons to interact with these are available to the admin in his user page.

CSV import
==========

**Currently**, CSV import is static, and the file must be in the following format: Recipient,amount,date,category,notes,account The first line should contain all the categories, followed by each transaction in a different line. for example, a file could look like this:

*   Recipient,amount,date,category,notes,account
*   Coffe Shop,-1.65,2023-12-01,socializing,coffee,VISA
*   Lidl,-3.66,2023-12-02,groceries,,VISA
*   ABC,-1.33,2023-12-02,,chocolate cake,cash
*   Lidl,-9.91,2023-12-03,groceries,,revolut

In the current implementation, categories/accounts will be created when they are not found in the database, in case they are found, they will be associated with the existing one. However, this might change in the future, as dynamic selection of lines in the CSV is planned.

Investments
===========

An investment, when created, will only take:

*   a ticker symbol (e. APPL, GOOGL, VUSA, VOO)
*   Owned shares (which accepts fractional shares)
*   Average purchase price

From there, it will use a yahoo finance API to obtain the current value, more information about the holding, and calculate your profit/loss. For this you need to refresh the API with the respective button, do notice that you will need to create an account and get your own API key in this site, then add it to the .env file: https://rapidapi.com/apidojo/api/yh-finance/ Also note that **refreshes per month are limited to 500**, after that, you'll have to wait another month, or pay. The obtained price of the stock might be inaccurate, inaccuracies up to 0.1 have been noted, normally due to rounding errors. Right now, investment statistics are being calculated assuming that all investments are in the same currency, this might change in the future.

Currency conversion
===================

Currency conversion is done through the free API from: https://www.exchangerate-api.com/ It does have a daily limit, but when reached, after around 20mins the IP block will be reset, and you will be able to use it again.

Initial configurations (.env files)
===================================

There are 2 .env files, one for the frontend and one for the backend. the backend one contains:

*   PORT = which port will be used by the backend, defaults to 5000 in case it is not declared or left empty
*   JWT\_SECRET\_KEY = this is the secret key that will be used to generate tokens to maintain user sessions, can be filled with any password the user deems strong enough, if not declared, will be set by default
*   CONNECTION\_LIMIT = how many users can use the application simultaneously, defaults to 10 if not defined
*   DB\_PASSWORD= the password that the backend uses to connect with the database, should be the same as the "MYSQL\_ROOT\_PASSWORD" declared in the docker-compose.yml
*   ADMIN\_PASSWORD=the password the app administrator can login with, with the respective email "admin1@mail.com", if left blank, will default to 'password'
*   MYSQL\_MODE= if set to "docker", will assume it is being run on a docker container, and will try to connect to a running docker image of MySQL instead of a local instance of one (localhost), if set to "local", will try to connect to a local instance instead, defaults to "docker" to be able to run a docker container without a .env for ease of use

the frontend one contains:

*   BACKEND\_API\_BASE\_PATH = url to make calls to the backend API, will be default to "http://localhost:5000" if not filled

How to run
==========

There are 2 ways of running the project, development mode, and production(docker) mode: 
* Production mode is for everyday use, and only needs a working docker installation, and the filling of the frontend and backend **.env** files as instructed in the respective chapter of the documentation. After which, one only need to run the **docker-compose up** command on a terminal in the root directory. 
* Development mode is run with the script **run\_dev\_environment.cmd** on Windows as an administrator, and uses a local installation of SQL (even though with some tweaking to the script, it can be ran using a docker one) and runs the frontend in development mode, allowing hot reloads for simplified development. **Node (npm)** must also be installed, as it also installs all dependencies directly into the folder which might cause compatibility problems depending on your operating system, as the app was developed using Windows 10, this is the recommended environment. The script uses **nvm** to make sure that the node version is the correct one used during development, so this should be installed too, unless you only have the correct version installed, in which case you only need to comment that line

Development
===========

For the frontend, these technologies were used:

*   Vue.js 3
*   Tailwind
*   Nuxt 3 (with Pinia and Nuxt UI)

As for the backed, it was made with:

*   Node.js (Express.js)
*   JavaScript libraries for csv imports (csv-parse), JSON web token use (jsonwebtoken), database connection (mysql2), among others.
*   MySQL

Some problems encountered for future development:

*   Make sure to convert dates received from the server to the local time zone, if not, data might be inaccurate, sometimes by a full day on the case of removing an hour at midnight, making the associated day **24 at 23:00**, instead of **25 at 00:00**, for example.