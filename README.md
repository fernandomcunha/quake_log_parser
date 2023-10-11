# Software Engineer Test

Test developed for the software engineer position at CloudWalk.

# Steps to setup and run project

1. For this project, Ruby version 3.1.4 was used. I recommend using [Go Rails](https://gorails.com/guides) to setup and configure this version of Ruby.

2. With Ruby installed navigate to project folder, run bundle install to install gems and execute the IRB requiring the log_parser.rb file:

```bash
cd <path-to-project>

bundle install

irb -r ./log_parser.rb
```

3. After that, create a new instance of class LogParser and then call the public method parse_log:

```bash
parser = LogParser.new

parser.parse_log
```

4. You should be able to see an hash output with all grouped information required for the test, something like this:

```json
"game_21": {
  "total_kills": 131,
  "players": ["Isgalamido", "Oootsimo", "Dono da Bola", "Assasinu Credi", "Zeh", "Mal"],
  "kills": {
    "Isgalamido": 17, 
    "Oootsimo": 22, 
    "Dono da Bola": 14, 
    "Assasinu Credi": 19,
    "Zeh": 19,
    "Mal": 6
  },
  "kills_by_means": {
    "MOD_ROCKET": 37,
    "MOD_TRIGGER_HURT": 14,
    "MOD_RAILGUN": 9,
    "MOD_ROCKET_SPLASH": 60,
    "MOD_MACHINEGUN": 4,
    "MOD_SHOTGUN": 4,
    "MOD_FALLING": 3
  },
  "ranking": {
    "1": "Oootsimo",
    "2": "Assasinu Credi",
    "3": "Zeh",
    "4": "Isgalamido",
    "5": "Dono da Bola",
    "6": "Mal"
  }
}
```
