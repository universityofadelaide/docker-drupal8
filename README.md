
This repository is designed to provide a quick way to start projects
with Drupal using robo as the build tool and docker to host the
environment.

To use for your own projects, check out this repository and the remove the .git folder with:
```
git clone git@github.com:universityofadelaide/docker_drupal8.git
cd docker_drupal8
rm -rf .git
```

The next step is to start the docker environment with:
```
./start.sh
```

If you get an error about the image it may have changed recently. The image is configured within `docker-compose.yml`.

Docker will download and extract all of the required dependencies.

Then stand the docker 'utility' container for the rest of the steps
```
./dsh.sh
```

If you get an error about your client being newer or incorrect version, try running `docker-machine upgrade`

The setup then requires you to enter any additional
requirements into composer.json and run:
```
composer install
```

To get the initial codebase setup.

Then you can build the drupal site with
```
robo dev:rebuild-scaffold
```

There is one change that needs to be made to the Drupal autoloader, do this with:
```
sed -i "s/\/vendor\//\.\/\.\.\/vendor\//g" app/autoload.php
```

The change in the app/autoload.php is:

Before:
```
return require __DIR__ . '/vendor/autoload.php';
```

After:
```
return require __DIR__ . './../vendor/autoload.php';
```

Things are now ready for a normal Drupal setup, though you may want to make changes
to the config.default.json before performing:
```
robo build
```

Working on the project can be stopped with:
```
./stop.sh
```

And removing the mysql db and containers can be done with:
```
./purge.sh
```
