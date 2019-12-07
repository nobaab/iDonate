

class User {
  String _userName;
  String _userEmail;
  String _userBio;
  String _userProfilePic;

  User( this._userName, this._userEmail, this._userBio,
      this._userProfilePic);

  User.map(dynamic obj){
    this._userName = obj['userName'];
    this._userBio = obj['userBio'];
    this._userEmail = obj['userEmail'];
    this._userProfilePic =obj['userProfilePic'];
  }

  String get userProfilePic => _userProfilePic;

  String get userBio => _userBio;

  String get userEmail => _userEmail;

  String get userName => _userName;




  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['userName'] = _userName;
    map['userEmail'] = _userEmail;
    map['userBio'] = _userBio;
    map['userProfilePic'] = _userProfilePic;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._userName = map['userName'];
    this._userEmail = map['userEmail'];
    this._userBio = map['userBio'];
    this._userProfilePic = map['userProfilePic'];
  }



}
