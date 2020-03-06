# Directions

The orders are currently held in memory. You can access them through the CLI using pry, it has been added after all the orders should have been collected.

### Setup and Runner File

Rather than trying to pass the FastSpring API username and password as command line arguements, I added a runner file to contain this information. Add your FastSpring API username and password to the runner file in place of my test credentials.

The default limit is set to 1000, pass another value in the runner file if you would like a different limit.

### Running the Script

 - Clone the repo
 - Enter the directory
 - Make changes to the runner file
 - Type `ruby runner.rb` into the command line
 - Press `Enter`
