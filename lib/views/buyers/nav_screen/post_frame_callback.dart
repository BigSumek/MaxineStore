import 'package:flutter/material.dart';
import 'package:multi_store/views/buyers/main_sceen.dart';

class PostFrameCallbackSample extends StatefulWidget {
  const PostFrameCallbackSample({Key? key}) : super(key: key);

  @override
  State<PostFrameCallbackSample> createState() =>
      _PostFrameCallbackSampleState();
}

class _PostFrameCallbackSampleState extends State<PostFrameCallbackSample> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          titlePadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.network(
                'https://scontent.fbkk8-2.fna.fbcdn.net/v/t1.6435-9/163283960_4072194789485666_6117900255474653560_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeGD7sf2-_2xzNxqw4kdWqUbW4kZXlnUZHZbiRleWdRkdtmXen_yCp8Kpe2n_LYkpLEsjCAdZviV_Le0dPJ4c895&_nc_ohc=PISve7Y2E2oAX_qp9Um&_nc_ht=scontent.fbkk8-2.fna&oh=00_AfBo8uwt5ULZ8zi6Y_S6jIUhYdpQXM1BoQUxQfMMBVdJgw&oe=64575C39',
                height: MediaQuery.of(context).size.width - 20,
                width: MediaQuery.of(context).size.width - 20,

                // fit: BoxFit.cover,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Accept'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
