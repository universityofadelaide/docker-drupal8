
This repository is designed to provide a quick way to start projects
with Drupal using [robo](http://robo.li/) as the build tool and [docker](https://www.docker.com/) to host the
environment.

# Getting started

It is assumed that you have docker installed. For __OS X__ and __Windows__ users you will need to install the [docker toolbox](https://www.docker.com/products/docker-toolbox).
This will give you required tools to run docker through a vm layer ( docker-machine ).

We follow the docker philosophy, meaning one container per application process. Because of this we use `docker-compose` to define all our containers.

# Initial setup

To use for your own projects, check out this repository and then remove the .git folder with:
```bash
$ git clone git@github.com:universityofadelaide/docker_drupal8.git
$ cd docker_drupal8
$ rm -rf .git
```

The next step is to start the docker environment with:
```bash
$ ./start.sh
```

Docker will download and extract all of the required dependencies.
This script will build the following containers :
- web
- memcache
- mysql
- mail

To view all the running containers you have just built:
```bash
$ docker ps
```

__Mac OS X users__:

If you see this :
```bash
$ Cannot connect to the Docker daemon. Is the docker daemon running on this host?
```

You need to `eval` the docker-machine environment running. To find the name of the docker-machine(s) you are running :

```bash
$ docker-machine ls
```

```bash
$ eval $(docker-machine env DOCKERMACHINE_NAME_GOES_HERE)
```

## Accessing the 'utility' container

Then stand the docker 'utility' container for the rest of the steps
```bash
$ ./dsh.sh
```

If you get an error about your client being newer or incorrect version, try running `docker-machine upgrade`

### Building a Drupal 8 Application
__Note__ these commands are run from the utility container.

The setup then requires you to enter any additional
requirements into composer.json and run:
```bash
$ composer install
```

Then you can build the drupal site with
```bash
$ robo dev:rebuild-scaffold
```

There is one change that needs to be made to the Drupal autoloader, do this with:
```bash
$ sed -i "s/\/vendor\//\.\/\.\.\/vendor\//g" app/autoload.php
```

The change in the app/autoload.php is:

__Before__:
```php
return require __DIR__ . '/vendor/autoload.php';
```

__After__:
```php
return require __DIR__ . './../vendor/autoload.php';
```

Things are now ready for a normal Drupal setup, though you may want to make changes
to the config.default.json before performing:
```bash
$ robo build
```

## Working with the containers

Working on the project can be stopped with:
```bash
$ ./stop.sh
```

And removing the containers can be done with:
```bash
$ ./purge.sh
```
