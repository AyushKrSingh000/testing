import * as functions from "firebase-functions";exports.onDmMessageCreated = functions

import {onDmMessageCreated} from "./triggers/dm_message";




exports.onDmMessageCreated = functions
    .region('asia-south1')
    .firestore
    .document("message/1")
    .onUpdate(onDmMessageCreated);
