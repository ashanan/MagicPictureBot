# MagicPictureBot
[@MagicPictureBot](https://twitter.com/magicpicturebot)

This is a simple Twitter bot.  It searches the [Digital Public Library of America](https://dp.la/)'s image collection for "magic" and posts a random image every night at midnight (when else would it post?).

Because of reasons I've put the bot behind sinatra and schedule it using cron.  Sample cronfile:
```
@midnight curl localhost:4567/random
