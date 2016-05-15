
This repository is designed to provide a quick way to start projects
with Drupal using robo as the build tool and docker to host the
environment.

To use, copy all files to an empty directory with something like:

```
mkdir test
cd test
cp -r ../docker_drupal8/* .
```

The setup then requires and enter any additional
requirements into composer.json and run:

```
composer install
```

To get the initial codebase setup.

The next step is to start the docker environment with:

```
./start.sh
```

Then login and build the base for Drupal

```
./dsh.sh
robo dev:rebuild-scaffold
```

There is one change that needs to be made to the Drupal autoloader, do this with:

```
sed -i "s/\/vendor\//\.\/\.\.\/vendor\//g" app/autoload.php
```

The change in the app/autoload.php is:

Before:
return require __DIR__ . '/vendor/autoload.php';

After:
return require __DIR__ . './../vendor/autoload.php';


Things are now ready for a normal Drupal setup, though you may want to make changes
to the config.default.json before performing:

```
robo build
```
