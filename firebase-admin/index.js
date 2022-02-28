const FCM = require("fcm-node");
const serverKey =
  "AAAAZS14Edc:APA91bGOxnLUA8NrnSr-G5cwft2USWHMVyoBo_FxI8--j-B7f_ZXXgBXPfYjLZoalul8wun7tcYi3wkHYbk8oCcSTPw46Y7A54jeJr0K1nXfkNgFp14BmfpjIqqQYvKDG2BLfxVPyHwI";

const fcm = FCM(serverKey);

const sendApprovalNotification = (deviceToken) => {
  const message = {
    to: "APA91bHDg1uHc8qq37YBZWAwD9JwRLpbTfn8p8Xl7fObaB9KIFLnz2ZgwxKVSqkp2lXRGWIeafXe-D-Om-zDAAmVvvl97sssuYv8h-muKQ1lGnEwKfdCUbNg-4TOd6Bi48DWTT1f-_",
    notification: {
      title: "TEST NOTIFICATION",
      body: "APPROVE THE LISTINGS",
    },

    data: {
      //you can send only notification or only data(or include both)
      title: "ok cdfsdsdfsd",
      body: '{"name" : "okg ooggle ogrlrl","product_id" : "123","final_price" : "0.00035"}',
    },
  };
};
