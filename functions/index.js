/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const nodemailer = require("nodemailer");
const admin = require("./firebaseAdmin");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

/**
 * LOGIC FOR EMAIL VERIFICATION
 */

const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  secure: false,
  auth: {
    user: "splash.app.team@gmail.com",
    pass: "lapw zbuh ulbg mqrj",
  },
},
);

exports.sendVerificationEmail = functions.https.onCall(async (data, context)=> {
  // Ensure the function is called with correct parameters
  // if (!(typeof email === 'string')) {
  //     throw new functions.https.HttpsError('invalid-argument',
  // 'The function must be called with a string argument "email".');
  // }

  // Generate a random verification code
  const verificationCode = Math.floor(Math.random() * 1000000).toString();
  const db = admin.firestore();

  const emailAddr = data.email;

  // Send an email using nodemailer
  const mailOptions = {
    from: "splash.app.team@gmail.com",
    to: emailAddr,
    subject: "Your Splash Verification Code",
    text: `Hello,\n\nYour verification code is: ${verificationCode}`,
  };

  await transporter.sendMail(mailOptions);

  // Store the verification code in Firestore
  await db.collection("email_verification").add({
    email: emailAddr,
    code: verificationCode,
    status: "unverified",
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  });

  return {success: true};
});
