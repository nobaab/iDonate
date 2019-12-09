
class UserStore {
  String _uid;
  String _userName;
  String _userEmail;
  String _userBio;
  String _userProfilePic;

  UserStore( this._uid,this._userName, this._userEmail, this._userBio,
      this._userProfilePic);

  UserStore.map(dynamic obj){
    this._uid=obj['uid'];
    this._userName = obj['userName'];
    this._userBio = obj['userBio'];
    this._userEmail = obj['userEmail'];
    this._userProfilePic =obj['userProfilePic'];
  }

  String get uid => _uid;

  String get userProfilePic => _userProfilePic;

  String get userBio => _userBio;

  String get userEmail => _userEmail;

  String get userName => _userName;




  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['uid'] = _uid;
    map['userName'] = _userName;
    map['userEmail'] = _userEmail;
    map['userBio'] = _userBio;
    map['userProfilePic'] = _userProfilePic;
    return map;
  }

  UserStore.fromMap(Map<String, dynamic> map) {
    this._uid = map['uid'];
    this._userName = map['userName'];
    this._userEmail = map['userEmail'];
    this._userBio = map['userBio'];
    this._userProfilePic = map['userProfilePic'];
  }



}
