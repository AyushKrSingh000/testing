import * as functions from "firebase-functions";
import {onDmMessageCreated} from "./onUpdate/send_notifications";

exports.onDmMessageCreated = functions
  .region("asia-south1")
  .firestore.document("message")
  .onUpdate(onDmMessageCreated);
