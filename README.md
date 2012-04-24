# Jenkins builds on GitHub pull requests

Scripts to run a Jenkins CI build against every open pull request of a GitHub project.

## Requirements

It requires the following Jenkins plugins:
- Description Setter https://wiki.jenkins-ci.org/display/JENKINS/Description+Setter+Plugin
- XTrigger http://wiki.jenkins-ci.org/display/JENKINS/XTrigger+Plugin

It obviously also requires Git and GitHub plugins at Jenkins. It also uses shell-scripts, so your Jenkins environment better have access to bash.

## Instructions

1. Enable ```[ScriptTrigger] - Poll with a shell or batch script``` and use the contents of ```pullChecker.sh```. Set a suitable checking period.

2. Enable ```Set build description```, using ```GitHub-Pull=[0-9]*``` for regular expression.


