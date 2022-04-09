# luftinspektor.hr

Welcome to the repository of my personal blog. The idea is to use this pet project as a sandbox for learning and storing information I pick up along the way.

🛠️ Built with Rails 7 and Tailwind CSS for now 🛠️

### Steps followed to create this app

0. Assume ruby is installed, otherwise why are we here :D
1. Ensure rails is installed `gem install rails`
2. Ensure recent version of bundler is installed `gem install bundler`
3. Ensure libpq is installed `brew install libpq` and added to path `export PATH="/opt/homebrew/opt/libpq/bin:$PATH" >> ~/.zshrc`
4. Create the new rails app `rails new luftinspektor --css tailwind --database=postgresql`
5. Ensure postgres is installed and running `brew install postgresql`, `brew services start postgresql`
6. Create the database `bin/rails db:create`
7. Run the rails server and tailwind JIT compiler `bin/dev`
