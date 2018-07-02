# Overview
This is a simple command line Hangman game.

# Future Directions
Extend UI to web and mobile.

# How to run the game.
1. Clone the repository to your local machine.
2. Then run the game like so:
ruby lib/hangman.rb

# How to run tests.
bundle exec rspec

# Troubleshooting
To change log level, change value of `LOG_STATUS` constant in lib/logging.rb:
```
  LOG_LEVEL = Logger::DEBUG
```