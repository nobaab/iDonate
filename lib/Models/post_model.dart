class Post{
  String _title;
  String _desc;
  String _postdate;
  String _posttype;

  Post(this._title,this._desc,this._postdate,this._posttype);

  Post.map(dynamic obj){
    this._title = obj['title'];
    this._desc = obj['desc'];
    this._postdate = obj['postdate'];
    this._posttype = obj['posttype'];
  }

  String get  title=> _title;
  String get desc => _desc;
  String get postdate => _postdate;
  String get posttype => _posttype;

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();
    map['title']=_title;
    map['desc'] = _desc;
    map['postdate'] = _postdate;
    map['postype'] = _posttype;
    return map;


  }

  Post.fromMap(Map<String,dynamic> map){
    this._title = map['title'];
    this._desc = map['desc'];
    this._postdate = map['postdate'];
    this._posttype = map['posttype'];
  }
}