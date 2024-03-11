class DataModal{

  String Url;
  DataModal({required this.Url});

  static ModalFunction(Map<String , dynamic> imageMap){
    return DataModal(Url: (imageMap['src'])['portrait']);
  }



}

//
// create a new modal for category
class catmodal{
  String url;
  String name;
  catmodal({
    required this.url, required this.name
});
 static modalfunction(Map<String, dynamic> category){
    return catmodal(url: category['imageurl'], name: category['catename']);
  }
}