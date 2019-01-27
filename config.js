module.exports = {
        scanInterval : process.env.BLUETOOTH_SCAN_INTERVAL || 30000, // Interval between Bluetooth scans
        scanTimeout : process.env.BLUETOOTH_SCAN_TIMEOUT || 30000, // the timeout of each bluetooth scan
        gladysUrl : process.env.GLADYS_URL || 'http://192.168.0.44:8080', // the URL of your main Gladys Instance
        token : process.env.GLADYS_TOKEN || 'aed02d3ab8bf1dbfa291127fdaaa8475bdb4f2a8', // your gladys security token. You can find it in Gladys Dashboard "Parameters" => "Security".
        gladysHouseId : process.env.GLADYS_HOUSE_ID || 1, // the ID of the house where this Bluetooth Scanner is located
        services : 'bluetooth,miflora,xiaomiht,flowerpower', // the name of devices services (bluetooth by default).
};
