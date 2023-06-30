import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_el/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isProcessing = false; // Flag variable to track the processing state of a scan
  String? lastScannedData; // Variable to store the last scanned QR code data

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                    )
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          child: FutureBuilder<bool?>(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return Text('Flash: ${snapshot.data}');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!isProcessing && lastScannedData != scanData.code) {
        lastScannedData = scanData.code; // Update the last scanned QR code data
        isProcessing = true;
        _processScannedQRCode(scanData.code);

        Future.delayed(Duration(seconds: 2), () {
          isProcessing = false;
          lastScannedData = null; // Reset the last scanned QR code data after the cooldown period
        });
      }
    });
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Attendance registered successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _processScannedQRCode(String? qrCodeData) async {
    if (qrCodeData != null) {
      final ap = Provider.of<AuthProvider>(context, listen: false);

      if (qrCodeData == 'Gym Elite Attendance') {
        try {
          final attendanceData = {
            'Member Name': ap.userModel.name,
            'userId': ap.uid,
            'timestamp': DateTime.now(),
          };

          // Check if the attendance data already exists in Firestore
          final existingAttendance = await FirebaseFirestore.instance
              .collection('attendance')
              .where('userId', isEqualTo: ap.uid)
              .where('timestamp', isEqualTo: attendanceData['timestamp'])
              .get();

          if (existingAttendance.docs.isEmpty) {
            // Attendance data doesn't exist, add it to Firestore
            await FirebaseFirestore.instance
                .collection('attendance')
                .add(attendanceData);
            _showSuccessSnackBar();
          } else {
            // Attendance data already exists, show a message or perform any desired action
            _showErrorSnackBar('Attendance already registered');
          }
        } catch (error) {
          print('Error registering attendance: $error');
          _showErrorSnackBar('Error registering attendance');
        }
      } else if (qrCodeData == 'Other Entry') {
        // Handle the other entry type
        // Perform any desired action or add the corresponding data to Firestore
        _showSuccessSnackBar();
      } else {
        _showErrorSnackBar('Invalid QR code');
      }
    } else {
      _showErrorSnackBar('Invalid QR code');
    }

    isProcessing = false; // Reset the flag to false after processing the QR code
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
