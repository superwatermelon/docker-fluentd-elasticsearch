#!/usr/bin/env bats

@test "fluentd runs ok" {
  run docker run --rm $IMAGE fluentd --help
  [ "$status" -eq 0 ]
}

@test "fluentd-plugin-elasticsearch is installed" {
  # To test installation probably need to run fluentd with
  # a config that uses it, have been unable to introspect
  # fluentd to query plugins
  container="$(docker create --interactive $IMAGE /bin/sh)"
  docker start "$container"
  docker exec --interactive "$container" /bin/sh -c 'cat - >/fluentd/fluent.conf' <<EOF
<match *>
  @type elasticsearch
</match>
EOF
  run docker exec "$container" fluentd --dry-run --config /fluentd/fluent.conf
  docker rm -f "$container"
  [ "$status" -eq 0 ]
}
