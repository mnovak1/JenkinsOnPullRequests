#! /bin/bash

# GitHub pull numbers start with 1 ;-)
# setting to 0 also not a problem because we only consider 'open' pulls
lastPullNumber=0

echo Using JOB_URL=$JOB_URL

# Get the description of the last build (empty string if none)
lastJenkinsRunData=`curl --silent --fail $JOB_URL/lastBuild/api/xml?xpath=//shortDescription`
echo Last Jenkins run description: $lastJenkinsRunData

# Get a number from the last description if any
if [[ $lastJenkinsRunData =~ *PullNumber=[0-9]*  ]]; then
    echo GitHub pull matches!
    lastPullNumber=`echo $lastJenkinsRunData | cut -f 2 -d '=' | cur -f 1 -d '<'`
fi

# Get all open pull-requests from GitHub
curl --silent https://api.github.com/repos/$GITHUB_USER_PROJECT/pulls | while read line
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
    if [[ $1 == "--patch" ]]; then
        pwd
        git log -1
    fi
    exit 0
fi

exit 1
