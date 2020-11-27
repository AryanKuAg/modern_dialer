import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  Future<List<Contact>> getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    return _contacts;
  }

  @override
  void dispose() {
    super.dispose();
    _searchController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
      future: getAllContacts(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Lottie.asset('assets/dance_loading.json'));
        }
        return Column(
          children: [
            Neumorphic(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    hintText:
                        'Search in ${(snapshot.data as List).length} Contact(s)'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: (snapshot.data as List<Contact>).length,
                  itemBuilder: (ctx, i) {
                    Contact myContact = snapshot.data[i];

                    return ListTile(
                      leading: (myContact?.avatar != null &&
                              myContact.avatar.length > 0)
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(myContact.avatar),
                            )
                          : myContact.initials().length > 0
                              ? (Neumorphic(
                                  padding: const EdgeInsets.all(12),
                                  style: NeumorphicStyle(
                                    boxShape: NeumorphicBoxShape.circle(),
                                    shape: NeumorphicShape.convex,
                                  ),
                                  child: Text(myContact?.initials()),
                                ))
                              : Image.asset('assets/profile.png'),
                      title: Text(
                        myContact?.displayName != null
                            ? myContact.displayName
                            : 'Contact',
                      ),
                      subtitle: Text(myContact.phones.length > 0
                          ? myContact.phones.elementAt(0).value
                          : ''),
                    );
                  }),
            ),
          ],
        );
      },
    ));
  }
}
