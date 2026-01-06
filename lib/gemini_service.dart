class GeminiService {
  Future<String> sendMessage(String userMessage) async {
    // 🔴 API DISABLED TEMPORARILY (NO NETWORK CALL)
    return _localMentorReply(userMessage);
  }
}

String _localMentorReply(String input) {
  final msg = input.toLowerCase();

  if (msg.contains("career")) {
    return "That’s a great thought 👍\nFirst, tell me your current class or degree.";
  } else if (msg.contains("engineering")) {
    return "Engineering has many paths.\nDo you like coding, machines, or problem-solving?";
  } else if (msg.contains("money") || msg.contains("job")) {
    return "Money matters, but skills matter more first.\nLet’s build skills step by step.";
  } else if (msg.contains("confused")) {
    return "It’s okay to feel confused 😊\nLet’s start with what you enjoy doing daily.";
  } else {
    return "I’m listening 👂\nTell me more about your interests or worries.";
  }
}
