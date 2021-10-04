# KubeSphere two node cluster(without HA)

## Abstract

This cluster includes two nodes:

- `main1`: Master node, and Worker node also.
- `node1`: Worker node.

## External ElasticSearch

### Start the build-in external ElasticSearch server

Cluster use external ElasticSearch server, a build in ElasticSearch docker-compose file could be found here: [@compose-services/elasticsearch-single.yml](./@compose-services/elasticsearch-single.yml) (Run `dc-start elasticsearch-single` command in current directory to start, see https://github.com/platbase/devops-dockerfiles/blob/master/develop-tools/shell-scripts/README.md for detail).

Following is the ElasticSearch server starting example:

> <div style="font-size:11px">
> <pre><font color="#4E9A06"><b>u01@ubuntu-pc</b></font>:<font color="#3465A4"><b>~/***/devops-vagrantfiles/51-kubesphere/5121-kubesphere-small-multi</b></font>$ dc-start elasticsearch-single
> <font color="#3465A4"><b>NOTE:</b></font> Read docker-compose definition(@compose-services/*.yml) from <font color="#4E9A06"><b>.:/home/~/.platbase-devops-docker:/media/~/***/docker</b></font>
> <font color="#3465A4"><b>NOTE:</b></font> Docker-compose found in <font color="#4E9A06"><b>/home/~/***/devops-vagrantfiles/51-kubesphere/5121-kubesphere-small-multi/@compose-services/elasticsearch-single.yml</b></font>
> <font color="#3465A4"><b>NOTE:</b></font> (recommended) to store container&apos;s runtime data in <font color="#4E9A06"><b>/home/~/***/devops-vagrantfiles/51-kubesphere/5121-kubesphere-small-multi/@compose-services/elasticsearch-single/H.....devops-vagrantfiles.51-kubesphere.5121-kubesphere-small-multi</b></font>
> tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      -                   
> tcp6       0      0 :::8080                 :::*                    LISTEN      -                   
> tcp        0      0 0.0.0.0:18080           0.0.0.0:*               LISTEN      -                   
> tcp6       0      0 :::18080                :::*                    LISTEN      -                   
> <font color="#3465A4"><b>NOTE:</b></font> Avaliable ports: <font color="#4E9A06"><b>8081</b></font>, <font color="#4E9A06"><b>18081</b></font> and <font color="#4E9A06"><b>28080</b></font>
> Building with native build. Learn about native build in Compose here: https://docs.docker.com/go/compose-native-build/
> <font color="#C4A000">WARNING</font>: Found orphan containers (compose-services_frontend-test_1) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up.
> Creating compose-services_elasticsearch-single_1       ... <font color="#4E9A06">done</font>
> Creating compose-services_volume-permissions-manager_1 ... <font color="#4E9A06">done</font>
> Attaching to compose-services_elasticsearch-single_1, compose-services_volume-permissions-manager_1
> <font color="#C4A000">volume-permissions-manager_1  |</font> changed ownership of &apos;/usr/share/elasticsearch/data&apos; to 1000:1000
> <font color="#C4A000">compose-services_volume-permissions-manager_1 exited with code 0</font>
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:15,818Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.n.Node&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;version[7.14.1], pid[7], build[default/docker/66b55ebfa59c92c15db3f69a335d500018b3331e/2021-08-26T09:01:05.390870785Z], OS[Linux/5.11.0-34-generic/amd64], JVM[Eclipse Foundation/OpenJDK 64-Bit Server VM/16.0.2/16.0.2+7]&quot; }
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:15,822Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.n.Node&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;JVM home [/usr/share/elasticsearch/jdk], using bundled JDK [true]&quot; }
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:15,823Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.n.Node&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;JVM arguments [-Xshare:auto, -Des.networkaddress.cache.ttl=60, -Des.networkaddress.cache.negative.ttl=10, -XX:+AlwaysPreTouch, -Xss1m, -Djava.awt.headless=true, -Dfile.encoding=UTF-8, -Djna.nosys=true, -XX:-OmitStackTraceInFastThrow, -XX:+ShowCodeDetailsInExceptionMessages, -Dio.netty.noUnsafe=true, -Dio.netty.noKeySetOptimization=true, -Dio.netty.recycler.maxCapacityPerThread=0, -Dio.netty.allocator.numDirectArenas=0, -Dlog4j.shutdownHookEnabled=false, -Dlog4j2.disable.jmx=true, -Djava.locale.providers=SPI,COMPAT, --add-opens=java.base/java.io=ALL-UNNAMED, -XX:+UseG1GC, -Djava.io.tmpdir=/tmp/elasticsearch-12865045190144817778, -XX:+HeapDumpOnOutOfMemoryError, -XX:HeapDumpPath=data, -XX:ErrorFile=logs/hs_err_pid%p.log, -Xlog:gc*,gc+age=trace,safepoint:file=logs/gc.log:utctime,pid,tags:filecount=32,filesize=64m, -Des.cgroups.hierarchy.override=/, -Xms256m, -Xmx512m, -XX:MaxDirectMemorySize=268435456, -XX:G1HeapRegionSize=4m, -XX:InitiatingHeapOccupancyPercent=30, -XX:G1ReservePercent=15, -Des.path.home=/usr/share/elasticsearch, -Des.path.conf=/usr/share/elasticsearch/config, -Des.distribution.flavor=default, -Des.distribution.type=docker, -Des.bundled_jdk=true]&quot; }
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:20,435Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.p.PluginsService&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;loaded module [aggs-matrix-stats]&quot; }
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:20,435Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.p.PluginsService&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;loaded module [analysis-common]&quot; }
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:20,435Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.p.PluginsService&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;loaded module [constant-keyword]&quot; }
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:20,436Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.p.PluginsService&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;loaded module [frozen-indices]&quot; }
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:20,436Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.p.PluginsService&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;loaded module [ingest-common]&quot; }
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:20,436Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.p.PluginsService&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;loaded module [ingest-geoip]&quot; }
> <font color="#06989A">elasticsearch-single_1        |</font> {&quot;type&quot;: &quot;server&quot;, &quot;timestamp&quot;: &quot;2021-10-03T07:28:20,437Z&quot;, &quot;level&quot;: &quot;INFO&quot;, &quot;component&quot;: &quot;o.e.p.PluginsService&quot;, &quot;cluster.name&quot;: &quot;docker-cluster&quot;, &quot;node.name&quot;: &quot;66801cfc82dc&quot;, &quot;message&quot;: &quot;loaded module [ingest-user-agent]&quot; }
> ... ...
> </pre>
> </div>

### Config ElasticSearch Url in KubeSphere

In VirtualBox NAT default, the value of `spce.common.es.externalElasticsearchUrl` in [kubesphere/config-vagrant.yaml](./kubesphere/config-vagrant.yaml) is `10.0.2.2` , if your VirtualBox configuration is different, try to modify this value.

### Monitor Index

When build-in ElasticSearch server started, navigate to http://localhost:9200/_cat/indices?v&pretty . for example:

> <div style="font-size:11px">
> <pre><font color="#4E9A06"><b>u01@ubuntu-pc</b></font>:<font color="#3465A4"><b>~/***/devops-vagrantfiles/51-kubesphere/5121-kubesphere-small-multi</b></font>$ curl &quot;http://localhost:9200/_cat/indices?v&amp;pretty&quot;
> health status index                           uuid                   pri rep docs.count docs.deleted store.size pri.store.size
> yellow open   ks-logstash-log-2021.10.03      ZMDGc10lTxeefdC_igTNvA   1   1     325417            0     60.8mb         60.8mb
> yellow open   ks-logstash-events-2021.10.04   3YxZqsmSTZWyCJoNfE3zvw   1   1         78            0     75.4kb         75.4kb
> green  open   .geoip_databases                9D3OggpeT2eXTrXOG8tB5w   1   0         43            0     41.1mb         41.1mb
> yellow open   ks-logstash-events-2021.10.03   rCwCrOtvRX2YTwle9dS3_g   1   1      11145            0      4.6mb          4.6mb
> yellow open   ks-logstash-auditing-2021.10.03 g1XC3ww6Q1ax1TtzAAW_mA   1   1        101            0    249.6kb        249.6kb
> yellow open   ks-logstash-log-2021.10.04      wM3CQBk0RQ6d51lTPm3-Pg   1   1        107            0    271.2kb        271.2kb
> yellow open   ks-logstash-auditing-2021.10.04 n8Tpqb3sSuW-GwPKKMTdMA   1   1          1            0     16.8kb         16.8kb
> </pre>
> </div>

