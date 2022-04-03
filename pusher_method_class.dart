import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ClientRequest {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  Future<void> initPusher({
    required String apiKey,
    required String cluster,
  }) async {
    try {
      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );
    } catch (e) {
      log("ERROR: $e");
    }
  }

  Future<void> subscribeToPusherChannel({required String channelName}) async {
    // dispose(channelName);
    await pusher.subscribe(channelName: channelName);
  }

  Future<void> connectToPusher() async {
    await pusher.connect();
  }

  Future<void> createAnEventToPusher(
      String channelName, String eventName, Map<String, dynamic> data) async {
    try {
      pusher.trigger(PusherEvent(
          channelName: channelName, eventName: eventName, data: data));
    } catch (e) {
      log(e.toString());
    }
  }

  void dispose({required List<String> channelNames}) {
    channelNames.forEach((element) {
      pusher.unsubscribe(channelName: element);
    });
    pusher.disconnect();
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    log("onEvent: $event");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {
      "auth": "foo:bar",
      "channel_data": '{"user_id": 1}',
      "shared_secret": "foobar"
    };
  }
}


