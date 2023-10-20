# Info

This is a fully functional website made with Ruby on Rails.The frontend is written in simple html and javascript. Postgresql is used as a database system for user handling and storing data. The website is hosted on Heroku and is made as a part of a CaptureTheFlag competition in that it has a bug which allows a user to abuse functionality and gain access to a certain product. 

The full CTF is hosted at https://tryhackme.com/jr/revworks and the website itself can be checked out at https://revworks-4e7c9d83d182.herokuapp.com/. The writeup/solution of the CTF is available at https://github.com/Zeeshan12340/writeups/blob/main/revworks.md.

Try to solve the CTF yourself before looking at the solution and let me know if you have any questions or suggestions.

# Setup
To run this website yourself, you need to setup a couple of things like ruby,rails,postgresql etc., which are listed below.

You can also use `docker` to set it up without any issues.
```bash
docker build -t revworks .
docker run -d -p 3000:3000 --name revworks revworks
```
Takes 3-5 mins for the container to start up. It will show an error page until it is ready. You can also pull it if you don't want to build it yourself.
```bash
docker pull zeeshan12340/revworks
```

## Ruby
You need to install ruby on your system. You can do this by following the instructions at https://www.ruby-lang.org/en/documentation/installation/.

## Rails
You need to install rails and other gems needed by the website on your system. You can do this by running the following command in your terminal:
```bash
gem install rails bundle
bundle install
```

## Postgresql
You need to install postgresql on your system. You can do this by following the instructions at https://www.postgresql.org/download/.
You will have to setup a user along with a password and a database for the website. You can do this by running the following commands in your terminal:
```bash
sudo -u postgres createuser -s revworks
sudo -u postgres psql
\password revworks
```
Make sure to set the matching one in `config/database.yml`.

## Running the website
You can run the website by running the following command in your terminal:
```bash
bin/rails db:create
bin/rails db:migrate
rails server
```

# Issues
If you find any bugs or have any suggestions, feel free to open an issue or a pull request. Any contributions are welcome.