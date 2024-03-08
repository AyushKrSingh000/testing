import * as admin from 'firebase-admin'

admin.initializeApp()

const db = admin.firestore()
const firebaseAuth = admin.auth()
const messaging = admin.messaging()

export { admin, db, firebaseAuth, messaging }
