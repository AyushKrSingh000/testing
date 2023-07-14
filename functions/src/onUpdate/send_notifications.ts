// import {db, messaging} from "../config/firebase";
// type MessageDetail = {
//   message: boolean | undefined;
//   users: Array<string> | undefined;
// };

// type UserDetail = {
//   userName: string | undefined;
//   profilePicUrl: string | undefined;
//   fcmId: string | undefined;
//   userId: string | undefined;
// };
const onDmMessageCreated = async () => {
  console.log("kdjsfkjdfs");
  // const isChanged = (
  //   (await db.collection("message").doc("1").get()).data() as MessageDetail
  // ).message;
  // console.log("hi skdjs");
  // if (isChanged) {
  //   console.log(isChanged);
  //   const usersList = (
  //     (await db.collection("message").doc("1").get()).data() as MessageDetail
  //   ).users;

  //   if (usersList) {
  //     // prepare list of all FCM tokens
  //     const fcmTokens = [];

  //     for (let i = 0; i < usersList.length; ++i) {
  //       const userId = usersList[i];
  //       const userData = (
  //         await db.collection("users").doc(userId).get()
  //       ).data() as UserDetail;

  //       // check if this user is not the sender
  //       if (userData) {
  //         // send notification to the user
  //         const fcmToken = userData.fcmId;
  //         if (fcmToken) {
  //           fcmTokens.push(fcmToken);
  //         }
  //       }
  //     }

  //     if (fcmTokens) {
  //       const text = "hi Ayush this side";
  //       // NOTE: multicast message can only be sent to a max of 500 tokens
  //       await messaging.sendMulticast({
  //         tokens: fcmTokens,
  //         notification: {
  //           title: "ayush singh",
  //           message: text,
  //         },
  //         android: {
  //           notification: {
  //             channelId: "new-message",
  //             priority: "max",
  //           },
  //         },
  //         data: {
  //           click_action: "com.testing.NEW_EVENT",
  //         },
  //       });
  //     }
  //   }
  // }
};

export {onDmMessageCreated};
