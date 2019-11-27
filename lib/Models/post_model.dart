class Post {
  String _postName;
  String _postDetails;
  String _postCat;

  Post(this._postName, this._postDetails, this._postCat);

  Post.map(dynamic obj) {
    this._postName = obj['postName'];
    this._postDetails = obj['postDetails'];
    this._postCat = obj['postCat'];
  }

  String get postName => _postName;

  String get postDetails => _postDetails;

  String get postCat => _postCat;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['postName'] = _postName;
    map['postDetails'] = _postDetails;
    map['postCat'] = _postCat;
    return map;
  }

  Post.fromMap(Map<String, dynamic> map) {
    this._postName = map['postName'];
    this._postDetails = map['postDetails'];
    this._postCat = map['postCat'];
  }
}
