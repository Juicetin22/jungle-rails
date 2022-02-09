# Jungle

Welcome to Jungle! This is a mini e-commerce application built with Rails 4.2 where you can browse through and purchase unique and peculiar items. See if you can find a gift perfect for friends and family, or even yourself, with this intuitive and easy-to-use application!

## Final Product

!["Screenshot of homepage"](https://github.com/Juicetin22/jungle-rails/blob/master/docs/homepage.png)

!["Screenshot of a product's details page"](https://github.com/Juicetin22/jungle-rails/blob/master/docs/product-details.png)

!["Screenshot of 'My Cart' page"](https://github.com/Juicetin22/jungle-rails/blob/master/docs/my-cart.png)


## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe

## Setup

1. Install all dependencies (using the `bundle install` command).
2. Create `config/database.yml` by copying `config/database.example.yml`.
3. In `config/database.yml`, uncomment the username and password from the development section, and replace their values with `labber` instead of `development`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`.
4. In `config/secrets.yml`, add a test section with the same keys and values as `development`.
4. Run `bin/rake db:reset` to create, load and seed the database.
5. Create .env file based on .env.example and fill with required info.
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env variables. Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.
8. Run `bin/rails s -b 0.0.0.0` to start the server. It will be served at `localhost:3000/`.

## Getting Started in the App

- Once you are on the site, you will have the homepage displayed with all the products available.
- You can also register and login as a new user, although guests can also purchase items without the need to.
- Click on the product image, name, or details button on the bottom-right of the product card to display information about that single product.
- Click on the 'Add' button if you want to purchase that item.
- Clicking on your cart in the top right corner of the navigation bar will direct you to a checkout screen where you can make your purchase.
- I hope you enjoy our products!