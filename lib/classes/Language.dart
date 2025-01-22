class Language{
  final int id;
  final String name;
  final String flag;
  final String lang_code;

  Language(this.id, this.name, this.flag, this.lang_code);

  static List<Language> lang_list(){
    return <Language>[
      Language(1,'English','🇺🇸','en'),
      Language(2,'বাংলা','🇧🇩','bn'),
    ];
  }
}