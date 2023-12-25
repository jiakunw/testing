import 'package:flutter/material.dart';

// Global background color
const Color kBackgroundColor = Color(0xFF0D0D0D);

const double defaultButtonHeight = 60.0;

enum MatchRequestStatus { open, cancelled, success }

enum MatchEventStatus { established, complete, cancelled }

String getMRStatus(MatchRequestStatus s) {
  if (s == MatchRequestStatus.open) {
    return "open";
  } else if (s == MatchRequestStatus.cancelled) {
    return "cancelled";
  } else {
    return "complete";
  }
}

// Function to get 20% of screen height
double twentyPercentOfScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height * 0.20;
}

double eightyPercentOfScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.80;
}

double anyPercentOfScreenWidth(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.width * percentage;
}

double anyPercentOfScreenHeight(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.height * percentage;
}

// ... Add other constants as needed