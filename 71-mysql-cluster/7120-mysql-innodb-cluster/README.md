# MySQL InnoDB Cluster



## Reference

- https://dev.mysql.com/doc/refman/8.0/en/mysql-innodb-cluster-introduction.html
- https://dev.mysql.com/doc/connector-j/8.0/en/connector-j-reference-jdbc-url-format.html



- https://jeremyxu2010.github.io/2019/05/mysql-innodb-cluster%E5%AE%9E%E6%88%98/

## Maintenance

### Connection

```shell
InnoDB Cluster 'mycluster' can be reached by connecting to:

## MySQL Classic protocol

- Read/Write Connections: localhost:6446
- Read/Only Connections:  localhost:6447

## MySQL X protocol

- Read/Write Connections: localhost:6448
- Read/Only Connections:  localhost:6449

```

So connect to a node with:

```shell
mysql -hmysql-host1 -p6446 -uroot -p123456
```

### Mysql shell basic

Execute mysql shell:

```shell
mysqlsh
```

mysqlsh javascrip - get cluster status:

```javascript
shell.connect('root@localhost:3306', '123456')
dba.getCluster('mycluster').status()
```

mysqlsh javascrip - reboot cluster(After all nodes reboot):

```javascript
shell.connect('root@localhost:3306', '123456')
dba.getCluster('mycluster').status() //Raise Error: Dba.getCluster: This function is not available through a session to a standalone instance (metadata exists, instance belongs to that metadata, but GR is not active) (MYSQLSH 51314)
dba.rebootClusterFromCompleteOutage('mycluster')
```

### Shell scripts

Show cluster status:

```shell
/vagrant/mysql/cluster/cluster-status.sh
```

