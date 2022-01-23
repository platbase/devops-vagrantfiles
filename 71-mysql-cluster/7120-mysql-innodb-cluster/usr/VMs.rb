VMs = {
    "mysql-host1": {
        :eth1 => "10.1.1.11",
        :cpu => "1", :cpu_cap => 0.5,
        :mem => "2048",
        :ports => { 6446 => 6446 }
    },
    "mysql-host2": {
        :eth1 => "10.1.1.12",
        :cpu => "1", :cpu_cap => 0.5,
        :mem => "2048",
        :ports => { 6446 => 6447 }
    },
    "mysql-host3": {
        :eth1 => "10.1.1.13",
        :cpu => "1", :cpu_cap => 0.5,
        :mem => "2048",
        :ports => { 6446 => 6448 }
    }
}
