
This repository is designed to provide a quick way to start projects
with Drupal using robo as the build tool and docker to host the
environment.

To use, copy all files to an empty directory and enter any additional
requirements into composer.json and run:

```composer install```

To get the initial codebase setup.

The next step is to start the docker environment with:

```./start.sh```

Then login and build the base for Drupal

```
./dsh.sh
robo dev:rebuild-scaffold
```
