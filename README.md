About this container
---
This container runs a NZBGet Usenet downloader. More about NZBGet can be found at:

  http://nzbget.net/


If you're running this container for the first time, the default login details are:

 * user: nzbget
 * pass: tegbzn6789


Building the container
---
Before building, there is one environment variable to ensure is correct
for your setup. In the `Dockerfile`, check:

* VERSION - version of NZBGet that will be fetched

With this configured correctly for your setup, the following Docker build
command will create the container image:

```
$ docker build -t cturra/nzbget .
```


Running the container
---
The following example Docker run command mounts one volume, used to persistently
store the NZBGet data (configurations, etc).

```
$ docker run --name=nzbget -v /data/nzbget:/data:rw -p 6789:6789 -d cturra/nzbget
```
