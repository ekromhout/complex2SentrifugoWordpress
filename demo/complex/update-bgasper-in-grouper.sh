docker cp update-bgasper-in-grouper.gsh complex_grouper_daemon_1:/tmp/
docker exec complex_grouper_daemon_1 bash -c "/opt/grouper/grouper.apiBinary/bin/gsh /tmp/update-bgasper-in-grouper.gsh"
