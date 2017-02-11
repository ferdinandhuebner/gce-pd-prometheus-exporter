# gce-pd-prometheus-exporter

Exports statistics for GCE persistent disks in prometheus text-format.

Prometheus node-exporter doesn't pick up statistics for GCE persistent disks that don't have a partition table.

```
docker run \
  --net="host" \
  -e ROOTFS="/rootfs" \
  -e UPDATE_INTERVAL=30 \
  -e OUTFILE=/tmp/prometheus/gce_pd.prom \
  -v /:/rootfs:ro \
  -v /tmp/prometheus:/tmp/prometheus \
  quay.io/ferdi/gce-pd-prometheus-exporter
```