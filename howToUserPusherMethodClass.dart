class HowToUsePusherMethodClass extends StatefulWidget {
  HowToUsePusherMethodClass({Key? key}) : super(key: key);

  @override
  State<HowToUsePusherMethodClass> createState() =>
      _HowToUsePusherMethodClassState();
}

class _HowToUsePusherMethodClassState extends State<HowToUsePusherMethodClass> {
  // instance of ClientRequest
  ClientRequest clientRequest = ClientRequest();

  @override
  void initState() {
// init your pusher client
    clientRequest.initPusher(
      apiKey: 'api_key_that_you_get_from_app_key_on_your_pusher_dashboard',
      cluster:
          'Cluster_that_you_get_from_app_key_on_your_pusher_dashboard ex: eu ',
    );

    // Multiple channel subscriptions
    clientRequest.subscribeToPusherChannel(channelName: 'my-channel');
    clientRequest.subscribeToPusherChannel(channelName: 'my-test');
// connect to your server
    clientRequest.connectToPusher();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // Your screen and returned data from onEvent method in ClientRequest class
        );
  }

  @override
  void dispose() {
    // unsubscribe and disconnect from pusher
    clientRequest.dispose(channelNames: ['my-channel', 'my-test']);
    super.dispose();
  }
}
