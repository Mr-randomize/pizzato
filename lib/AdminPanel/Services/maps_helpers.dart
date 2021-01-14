import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsHelpers with ChangeNotifier {
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  initMarker(coll, collId) {
    var docMarkerId = collId;
    final MarkerId markerId = MarkerId(docMarkerId);
    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(coll['location'].latitude, coll['location'].longitude),
      infoWindow: InfoWindow(title: 'Order', snippet: coll['address']),
    );
    markers[markerId] = marker;
  }

  Future getMarkerData(String collection) async {
    FirebaseFirestore.instance.collection(collection).get().then((docData) {
      if (docData.docs.isNotEmpty) {
        for (int i = 0; i < docData.docs.length; i++) {
          initMarker(docData.docs[i].data(), docData.docs[i].id);
        }
      }
    });
  }

  showGoogleMap(BuildContext context, DocumentSnapshot documentSnapshot) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      compassEnabled: true,
      initialCameraPosition: CameraPosition(
        zoom: 15.0,
        target: LatLng(
          documentSnapshot.data()['location'].latitude,
          documentSnapshot.data()['location'].longitude,
        ),
      ),
      onMapCreated: (GoogleMapController mapController) {
        googleMapController = mapController;
        notifyListeners();
      },
    );
  }
}
