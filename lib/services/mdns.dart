import 'dart:async';
import 'dart:io';
import 'package:bonsoir/bonsoir.dart';

Future<String?> lookupHost(String hostname) async {
  try {
    final results = await InternetAddress.lookup(hostname);
    for (final addr in results) {
      if (addr.type == InternetAddressType.IPv4) {
        return addr.address;
      }
    }
  } on SocketException catch (e) {
    print('Lookup failed: $e');
  }
}

Future<String?> getmDnsAddr() async {
  final completer = Completer<String?>();
  // This is the type of service we're looking for :
  String type = '_dazeInk._tcp';
  late String? hostname;
  late String? addr;

  // Once defined, we can start the discovery :
  BonsoirDiscovery discovery = BonsoirDiscovery(type: type);
  await discovery.initialize();

  // If you want to listen to the discovery :
  discovery.eventStream!.listen((event) {
    // `eventStream` is not null as the discovery instance is "ready" !
    switch (event) {
      case BonsoirDiscoveryServiceFoundEvent():
        print('Service found : ${event.service.toJson()}');
        event.service.resolve(
          discovery.serviceResolver,
        ); // Should be called when the user wants to connect to this service.
        break;
      case BonsoirDiscoveryServiceResolvedEvent():
        print('Service resolved : ${event.service.toJson()}');
        hostname = event.service.host;
        break;
      case BonsoirDiscoveryServiceUpdatedEvent():
        print('Service updated : ${event.service.toJson()}');
        break;
      case BonsoirDiscoveryServiceLostEvent():
        print('Service lost : ${event.service.toJson()}');
        break;
      default:
        print('Another event occurred : $event.');
        break;
    }
  });

  // Start the discovery **after** listening to discovery events :
  await discovery.start();

  // Give it up to 5 seconds to resolve
  await completer.future.timeout(
    const Duration(seconds: 5),
    onTimeout: () => null,
  );

  if (hostname != null) {
    addr = await lookupHost(hostname!);
  }

  // Then if you want to stop the discovery :
  await discovery.stop();
  print(addr);
  return addr;
}
