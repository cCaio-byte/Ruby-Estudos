# LER OS LIVROS DO BANCO DE DADOS E CRIA OBJETOS DA CLASSE LIVROS. 

def carregar_livros
  livros = []
  File.open("banco_de_dados_livros.txt") do |file|
    file.each do |line| 
      id, genero, titulo, autor, paginas, precos = line.chomp.split("|")
      livros << Livro.new(id.to_i, genero, titulo, autor, paginas.to_i, precos.to_f)
    end 
  end
  return livros
end


# ADICIONA NOVOS LIVROS NO BANCO

def adicionar_livros_banco_de_dados
  while true
    print "Por favor, informe o id do livro:"
    id = gets.chomp.to_i
    print "Por favor, informe o gênero do livro:"
    genero = gets.chomp
    print "Por favor, informe o título do livro:"
    titulo = gets.chomp
    print "Por favor, informe o autor do livro:"
    autor = gets.chomp
    print "Por favor, informe o número de páginas do livro:"
    paginas = gets.chomp.to_i
    print "Por favor, informe o preço do livro:"
    preco = gets.chomp.to_f

    File.open("banco_de_dados_livros.txt", "a") do |arquivo|
      arquivo.puts("#{id}|#{genero}|#{titulo}|#{autor}|#{paginas}|#{preco}")
    end
    
    puts "Livro adicionado com sucesso!"
    puts "Você deseja adicionar mais livros?"
    puts "Se você não deseja adicionar mais livros, digite 'N'."
    if gets.chomp.upcase == 'N'
      break
    end
  end
end 

# Calcula o frete e soma com o subtotal

def calcular_frete(subtotal)
  puts "ESCOLHA SEU FRETE"
  print """\n[1] PAC >> 10 - 15 DIAS PARA ENTREGA | R$25,00
[2] SEDEX >> 2 - 6 DIAS PARA ENTREGA | R$40,00 
FRETE: """
  opção_frete_cliente = validar_entrada(2)
  if opção_frete_cliente == 1
    total = 25 + subtotal
    puts "                                                                                      [TOTAL = R$#{total}]"
  else 
    total = 40 + subtotal
    puts "                                                                                      [TOTAL = R$#{total}]"
  end 
  return total 
end 


def validar_entrada (numero_de_opcoes_validas) 
  opções = (1..numero_de_opcoes_validas).to_a
  escolha_usuario = gets.chomp.strip.to_i
  while true do   
    if opções.include? escolha_usuario
        return escolha_usuario

    else
      puts "\nOPÇÃO INVÁLIDA"
      print "ESCOLHA ENTRE AS OPÇÕES VÁLIDAS #{opções}: "
      escolha_usuario = gets.chomp.strip.to_i
    end 
  end 
end 

def validar_id (lista_de_livros)
  escolha_usuario_id = gets.chomp.strip.to_i
  while true do
    for livro in lista_de_livros
      if livro.id == escolha_usuario_id
        return escolha_usuario_id
      end 
    end 
    puts "\nOPÇÃO INVÁLIDA -- LIVRO NÃO FAZ PARTE DA LISTA"
    print "\nINSIRA OUTRO ID : "
    escolha_usuario_id = gets.chomp.strip.to_i
  end 
end 


