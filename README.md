# Firebase iOS SDKs
Sending a notification.

Read more at https://firebase.google.com/docs/cloud-messaging/server

# Integration Instructions

# Using Terminal.
    1. Open the Terminal
    2. Enter the command below
        curl -H "Content-type: application/json" -H "Authorization:key=AAAAHcBzoBU:APA91bH9LhYsaV5Di8GTY6mL19SoaafJQ_LtXP3jvGnES7bF9SFzzJX1bONuKLfEpqUYl_eZdHKrwK4wkXTaiBEkVgPxZvYnICqcsu4tclPmWKrHfXQHX-PrDC7JcwHdrfUZbmw5lcGyxI3CtncoQ2IyqkpbkcHuOw"  -X POST -d '
        { 
        "notification": {
        "title": "Welcome",
        "body": "You received this message from a REST Service",
        "click_action" : "https://www.minhyen.com"
        },

        "to" : "dxCF-jZQTUc:APA91bFyZEuaXqUM3Jqlaz60-MZpxXq6GeBTWpdF_c3QAS4Rue2GYQE4WqVmwWuQ7soSU4zaASUcv1yj3ZMr0IY3wY5aefnTfL9sQIJgZNTr9cpWCtu_B33uHF4cBHaqU7bCWBNhXKkv"

        }
        ' https://fcm.googleapis.com/fcm/send



///////
curl -H "Content-type: application/json" -H "Authorization:key=AAAAHcBzoBU:APA91bH9LhYsaV5Di8GTY6mL19SoaafJQ_LtXP3jvGnES7bF9SFzzJX1bONuKLfEpqUYl_eZdHKrwK4wkXTaiBEkVgPxZvYnICqcsu4tclPmWKrHfXQHX-PrDC7JcwHdrfUZbmw5lcGyxI3CtncoQ2IyqkpbkcHuOw"  -X POST -d '
{ 
"notification": {
"title": "Welcome",
"body": "You received this message from a REST Service",
"click_action" : "https://www.minhyen.com"
},

"to" : "fdl2ygr8or4:APA91bEZptGA3bBzrvK373vhpJc1nyo_jDFLu9qpFy4qDYk4o9YkKY2CWI-Mduxu3Tvv6CAAaFj1TFvqjypFkQjhGxOcjr9HyGCTaMnND5kPbo_vPmdPQQmmEIK7hMMjx0BGRc6PB2i5"
}
' https://fcm.googleapis.com/fcm/send
