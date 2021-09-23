# The VM Nodes defination
VMs = {
    leader: {
        :eth1 => "10.1.1.10",
        :cpu => "1",
        :mem => "1024",
        :ports => { 80 => 58080 }
    },
    node1: {
        :eth1 => "10.1.1.11",
        :cpu => "1",
        :mem => "512"
    },
    node2: {
        :eth1 => "10.1.1.12",
        :cpu => "1",
        :mem => "512"
    }
}
