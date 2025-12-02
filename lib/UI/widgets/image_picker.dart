import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoMaker extends StatelessWidget {
  final VoidCallback onTap;
  final XFile? selectedImage;
  const PhotoMaker({super.key, required this.onTap, this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
onTap: onTap,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Container(
              child: Text('Photo',style: TextStyle(color: Colors.white),),
              alignment: Alignment.center,
              width: 80,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )
              ),
            ),
            Expanded(child: Text(selectedImage==null? "No photo is selected":selectedImage!.name,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
            ),),
          ],
        ),
      ),
    );
  }
}
