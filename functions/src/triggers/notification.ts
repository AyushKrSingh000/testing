import { QueryDocumentSnapshot } from '@google-cloud/firestore'
import { EventContext } from 'firebase-functions'
import { db, messaging, admin } from '../config/firebase'

const onNotificationAdded = async (
  snapshot: QueryDocumentSnapshot,
  context: EventContext
) => {
  const newValue = snapshot.data()
  const documentId = context.params.documentId // Automatically gets the document ID
  const notificationPayload: admin.messaging.MessagingPayload = {
    notification: {
      title: 'New Document Added',
      body: `A new document has been added to the collection with ID: ${documentId}.`,
    },
  }

  try {
    const querySnapshot = await admin.firestore().collection('users').get()
    const tokens: string[] = []
    querySnapshot.forEach((doc) => {
      const userToken = doc.data().fcmToken
      if (userToken) {
        tokens.push(userToken)
      }
    })

    // Send notifications to all FCM tokens
    await messaging.sendToDevice(tokens, notificationPayload)
  } catch (error) {
    console.error('Error sending notifications:', error)
  }
}

export { onNotificationAdded }
