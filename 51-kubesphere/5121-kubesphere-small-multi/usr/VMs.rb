VMs = {
    main1: {
        :eth1 => "10.1.1.11",
        :cpu => "4", :cpu_cap => 0.5,
        :mem => "6144",  # IF worked as both master and node, the minimum amount of memory is 6G
        :ports => { 30880 => 30880 }
    },
    node1: {
        :eth1 => "10.1.1.21",
        :cpu => "2", :cpu_cap => 0.33,
        :mem => "3072"
    }
}
