class Usuario {
  /// Atributos da classe
  int id;
  String nome;
  String data;
  String email;
  String telefone;
  int situacao; // 0 - pendente, 1 - concluído
  String url;

  /// Construtor da classe
  Usuario(
      {required this.id,
      required this.nome,
      required this.data,
      required this.email,
      required this.telefone,
      this.situacao = 0,
      required this.url});
}
