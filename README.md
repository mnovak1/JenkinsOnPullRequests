# Jenkins builds on GitHub pull requests

Scripts to run a Jenkins CI build against every open pull request of a GitHub project.

## Requirements

It requires the following Jenkins plugins:
- Description Setter https://wiki.jenkins-ci.org/display/JENKINS/Description+Setter+Plugin
- XTrigger http://wiki.jenkins-ci.org/display/JENKINS/XTrigger+Plugin

It obviously also requires Git and GitHub plugins at Jenkins. It also uses shell-scripts, so your Jenkins environment better have access to bash.

## Instructions

0. Enable ```Prepare an environment for the run``` and add your project's URL to ```Properties Content```:

```
GITHUB_USER_PROJECT=FranciscoBorges/JenkinsOnPullRequests
GITHUB_PROJECT_URL=https://github.com/FranciscoBorges/JenkinsOnPullRequests
```

1. Enable ```[ScriptTrigger] - Poll with a shell or batch script``` and use the contents of ```pullChecker.sh```. Set a suitable checking period (e.g. ```*/5 * * * *```).

2. Enable ```Set build description```, using ```PullNumber=[0-9]*``` for regular expression.


