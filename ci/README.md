# Tutorial's own CI pipeline


```
fly -t ${fly_target} set-pipeline -p concourse-tutorial -c ci/pipeline.yml -l ci/credentials.yml
fly -t ${fly_target} unpause-pipeline -p concourse-tutorial
```
