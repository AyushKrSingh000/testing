import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
import { onNotificationAdded } from './triggers/notification'

exports.onNotificationAdded = functions
  .region('asia-south1')
  .firestore.document('users/{userId}')
  .onCreate(onNotificationAdded)
