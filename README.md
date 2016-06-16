About this container
---
This container runs a NZBGet Usenet downloader. More about NZBGet can be found at:

  http://nzbget.net/


If you're running this container for the first time, the default login details are:

 * user: nzbget
 * pass: tegbzn6789


Building the container
---
Before building, there are two localtions to verify variable to ensure is correct
for your setup.

1) In the `Dockerfile`, check:

* VERSION - version of NZBGet that will be fetched

2) In `vars` check:

* `NZBGET_VERSION` - version of NZBGet that will be tagged
* `LOCAL_DATA_DIR` - location on your hosts filesystem to mount the nzbget
application (data) directory.
* `LOCAL_DOWNLOAD_DIR` - location on your hosts filesystem to mount the
nzbget download directory (could be within the data directory).

With this configured correctly for your setup, the following Docker build
command will create the container image manually. Or, below that, an example
of how you can run the `build.sh` script.

```
$ docker build -t cturra/nzbget .

```
OR
```
$ ./build.sh
```

Running the container
---
The following example Docker run command mounts one volume, used to persistently
store the NZBGet data (configurations, etc). Or, you can use the `run.sh` script
which will load the appropriate environment details from the `vars` file and launch
your nzbget container.

```
$ docker run --name=nzbget -v /data/nzbget:/data:rw -p 6789:6789 -d cturra/nzbget
```

OR
```
$ ./run.sh
```
