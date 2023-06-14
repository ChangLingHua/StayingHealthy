import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/sedentary.dart';
import 'package:flutter_project/vandf.dart';



class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: H(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class H extends StatefulWidget{
  const H({Key? key}) : super(key: key);

  @override
  State<H> createState() => _HState();

}

class _HState extends State<H> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 150,),
            Image.asset('assets/health.jpg'),
            SizedBox(height: 250,),

            //button
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(15.0),
                    width: 150,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Vandf()));
                        });
                      },
                      icon: Icon(Icons.grass,size: 25,color: Colors.white,),
                      label: Text('蔬果記錄',style: TextStyle(fontSize: 20,color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen[600]
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(15.0),
                    width: 150,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (MenuItem) => Sedentary()));
                        });
                      },
                      icon: Icon(Icons.airline_seat_recline_normal,size: 25,color: Colors.white,),
                      label: Text('久坐提醒',style: TextStyle(fontSize: 20,color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent
                      ),
                    ),
                  ),
                ],
              ),

          ],
        ),
      ),

    );
  }
}
