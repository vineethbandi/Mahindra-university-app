import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahindra_university/Utlis/CommonStyle.dart';
import 'package:mahindra_university/Utlis/colors.dart';

class MapView extends StatefulWidget {
  final LatLng? latLng;
  const MapView({Key? key,this.latLng}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.borderColor,
          title: Text("Map View",style: CommonStyle.commonBoldTextStyle(),),
        ),
        body: Container(
          height: height,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latLng!.latitude, widget.latLng!.longitude),
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("1"),
                  position: LatLng(widget.latLng!.latitude, widget.latLng!.longitude),
              ),
            },
            // markers: markerList,
            onTap: (LatLng value) {},
          ),
        ),
     /*   GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            // _controller.complete(controller);
          },
        ),*/
      ),
    );
  }
}
