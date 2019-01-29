module.exports = {
        scanInterval : process.env.BLUETOOTH_SCAN_INTERVAL || 30000, // Interval between Bluetooth scans
        scanTimeout : process.env.BLUETOOTH_SCAN_TIMEOUT || 30000, // the timeout of each bluetooth scan
        gladysUrl : process.env.GLADYS_URL || 'http://10.3.141.153:8080', // the URL of your main Gladys Instance
        token : process.env.GLADYS_TOKEN || '63f58f7391e837b86d1409851d49a96799033df8', // your gladys security token. You can find it in Gladys Dashboard "Parameters" => "Security".
        gladysHouseId : process.env.GLADYS_HOUSE_ID || 1, // the ID of the house where this Bluetooth Scanner is located
        services : 'bluetooth,miflora,xiaomiht,flowerpower', // the name of devices services (bluetooth by default).
};
