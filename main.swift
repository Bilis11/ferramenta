import Foundation

print("Insira o caminho do arquivo: ")

if let pathFile = readLine() {
  do {
    var file = try String(contentsOfFile: pathFile, encoding: .utf8)
    
    while true {
      options()
      var interrupt = false

      if let option = readLine() {
        switch option {
        case "1":
          displayText(file)
        case "2":
          countWords(file)
        case "3":
          file = replaceWord(file)
        case "4":
          file = deleteWord(file)
        case "5":
          displayRepeatedWords(file)
        case "6":
          print("Saindo...")
          interrupt = true
        default:
          print("Opção inválida\n")
        }
      }

      if interrupt {
        break
      }
    }

  } catch {
    print("Erro")
  }
} else {
  print("Erro ao ler o caminho do arquivo")
}

func options() {
  print("Escolha uma das opções: ")
  print("1 - Exibir texto")
  print("2 - Contar palavras")
  print("3 - Substituir alguma palavra específica")
  print("4 - Deletar alguma palavra específica")
  print("5 - Mostrar palavras repetidas e suas quantidades")
  print("6 - Sair")
}

func displayText(_ file: String) {
  print("Texto: \n \(file)\n")
}

func countWords(_ file: String) {
  let words = getWords(file)
  print("Quantidade de palavras: \(words.count)\n")
}

func replaceWord(_ file: String) -> String {
  print("Insira a palavra que você quer substituir: ")

  if let word = readLine() {
    let words = getWords(file)
    let verify = verifyWord(words, word)
    if verify {
      print("Insira a palavra que você quer colocar no lugar: ")

      if let newWord = readLine() {
        let newFile = file.replacingOccurrences(of: word, with: newWord)
        print("Texto atualizado: \n \(newFile)\n")

        return newFile
      } else {
        print("Erro substituir a palavra\n")
      }
    } else {
      print("Palavra não encontrada\n")
    }

  } else {
    print("Erro ao ler a palavra\n")
  }

  return file
}

func deleteWord(_ file: String) -> String {
  print("Insira a palavra que você quer deletar: ")
  
  if let word = readLine() {
    let words = getWords(file)
    let verify = verifyWord(words, word)

    if verify {
      let newFile = file.replacingOccurrences(of: word, with: " ")
      print("Texto atualizado: \n \(newFile)\n")

      return newFile
    } else {
      print("Palavra não encontrada\n")
    }

  } else {
    print("Erro ao ler a palavra\n")
  }

  return file
}

func displayRepeatedWords(_ file: String) {
  let words = getWords(file)
  var wordCount: [String: Int] = [:]

  for word in words {
    wordCount[word, default: 0] += 1
  }

  let repeatedWords = wordCount.filter { $0.value > 1 }
  
  if repeatedWords.isEmpty {
    print("Não há palavras repetidas no texto.\n")
  } else {
    print("Palavras repetidas e suas quantidades:")
    for (word, count) in repeatedWords {
      print("\(word): \(count)")
    }
    print()
  }
}

func verifyWord(_ words: [String], _ wordToVerify: String) -> Bool {
  return words.contains(wordToVerify)
}

func getWords(_ file: String) -> [String] {
  let pattern = "\\b[a-zA-Z]+\\b"
  let regex = try? NSRegularExpression(pattern: pattern)

  let words = (regex?.matches(in: file, range: NSRange(file.startIndex..., in: file)) ?? []).map { match in
    String(file[Range(match.range, in: file)!])
  }

  return words
}
