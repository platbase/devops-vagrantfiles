VMs = {
    main1: {
        :eth1 => "10.1.1.11",
        :cpu => "2", :cpu_cap => 0.5,
        :mem => "4096",
        :ports => { 30880 => 30880 }
    },
    node1: {
        :eth1 => "10.1.1.21",
        :cpu => "2", :cpu_cap => 0.33,
        :mem => "2048"
    },
    node2: {
        :eth1 => "10.1.1.22",
        :cpu => "2", :cpu_cap => 0.33,
        :mem => "2048"
    }
}