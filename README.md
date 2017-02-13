# gce-pd-prometheus-exporter

Exports statistics for GCE persistent disks in prometheus text-format.

Prometheus node-exporter doesn't pick up statistics for GCE persistent disks that don't have a partition table.

This image periodically runs itself and exports GCE persistent disk stats. Unfortunately, it is necessary that
this image spawns a new container, otherwise statistics of disks that weren't attached and mounted when the image was run can't 
be exported.

```
docker run \
  --net="host" \
  -e UPDATE_INTERVAL=30 \
  -e OUTFILE=/tmp/prometheus/gce_pd.prom \
  -v /usr/bin/docker:/usr/bin/docker \
  -v /var/run/docker.sock:/var/run/docker.sock \
  quay.io/ferdi/gce-pd-prometheus-exporter
```