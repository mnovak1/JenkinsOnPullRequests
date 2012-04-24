#! /bin/bash

# Build Name Setter plugin

JENKINS_JOB_URL=http://localhost:8080/job/githubPULLS/

# GitHub pull numbers start with 1 ;-)
# setting to 0 also not a problem because we only consider 'open' pulls
lastPullNumber=0

lastJenkinsRunData=`curl --silent --fail $JENKINS_JOB_URL/lastBuild/api/xml?xpath=//shortDescription`
echo Last Jenkins run description: $lastJenkinsRunData

if [[ $lastJenkinsRunData =~ *GitHub-Pull=[0-9]*  ]]; then
    echo GitHub pull matches!
    lastPullNumber=`echo $lastJenkinsRunData | cut -f 2 -d '=' | cur -f 1 -d '<'`
fi

exit 0

curl --silent https://api.github.com/repos/hornetq/hornetq/pulls | while read line
do
    content=`echo $line | tr -s " "`
    if [[ $content =~ \"number\"\: ]]; then
        number=`echo $content | cut -d ':' -f 2 | tr -d ' '`
        if [[ -z "$minOpenPull" ]]; then
            echo "setting minOpenPull to $number"
            minOpenPull=$number
        elif [[ "$number" -lt "$minOpenPull"]]; then
            minOpenPull=$number
        fi
    fi
done

if [[ -z "$minOpenPull" ]]; then
    exit 1
elif [[ "$minOpenPull" -gt "$lastPullNumber" ]]; then
    exit 0
fi

exit 1
