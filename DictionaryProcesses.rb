#require 'turkish_support'
#using TurkishSupport
#require 'parallel'

class DictionaryProcesses

	# Temel CharSets
	@@alphabetSet_eng = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o', 'p','q','r','s', 't','u','v','w','x','y','z']
	@@alphabetSet_tr = ['a','b','c','ç','d','e','f','g','ğ','h','ı','i','j','k','l','m','n','o', 'ö', 'p','r','s', 'ş', 't','u','ü','v','y','z']
	@@numberSet = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
	@@symbolSet = ['@', '!','>','\'','£','^','#', '+', '$', '%', '½', '&', '¾', '/', '(', '{', ')', '=', '?', '\\', '_', '|', '<', '>', 'é']


	# Combine Charsets
	@@alphabetSet_tureng = ['a','b','c','ç','d','e','f','g','ğ','h','ı','i','j','k','l','m','n','o', 'ö', 'p','q','r','s','ş','t','u','ü','v','w','x','y','z']
	@@alphaNumberSet_eng = @@alphabetSet_eng + @@numberSet 
	@@alphaNumberSet_tr = @@alphabetSet_tr + @@numberSet 
	@@alphaNumberSet_tureng = @@alphabetSet_tureng + @@numberSet 
	
	@@alphaSymbolSet_eng = @@alphabetSet_eng + @@symbolSet 
	@@alphaSymbolSet_tr = @@alphabetSet_tr + @@symbolSet 
	@@alphaSymbolSet_tureng = @@alphabetSet_tureng + @@symbolSet 
	
	@@numberSymbolSet = @@numberSet + @@symbolSet 
	@@alphaNumberSymbolSet_eng = @@alphabetSet_eng + @@numberSet + @@symbolSet 
	@@alphaNumberSymbolSet_tr = @@alphabetSet_tr + @@numberSet + @@symbolSet
	@@alphaNumberSymbolSet_tureng = @@alphabetSet_tureng + @@numberSet + @@symbolSet



	def self.helpMenu
		puts 
		puts
		puts "Usage" 
		puts "------------------------"
		puts "./lugat -m <min> -M <max> -c <charset> -l <lang> -o <fileName>"
		puts 
		puts
		puts "Parameters"
		puts "------------------------"
		puts "-m <min>       : Minimum character length of passwords"
		puts "-M <max>       : Maximum character length of passwords"
		puts "-c <charset>   : Character set which will be used"
		puts "-l <lang>      : Alphabet of A Specific Language "
		puts "-o <fileName>  : Output file name"
		puts "-p <pattern>   : All possible passwords based on given pattern"
		puts
		puts
		puts "Charset Keywords"
		puts "------------------------"
		puts "alphabetSet         : Just Letters"
		puts "numberSet           : Just Numbers"
		puts "specialCharacterSet : Just Special Characters"
		puts "alphaAndNumSet      : Letters and Numbers"
		puts "alphaAndSpecSet     : Letters and Special Characters"
		puts "numAndSpecSet       : Numbers and Special Characters"
		puts "alphaNumAndSpecSet  : Letters, Numbers and Special Characters"
		puts
		puts
		puts "Language Modes"
		puts "------------------------"
		puts "tur                 : Uses Turkish Alphabet"
		puts "eng                 : Uses English Alphabet"
		puts "tureng              : Uses Both Turkish and English Alphabet"
		puts
		puts
		puts "Examples"
		puts "------------------------"
		puts "./lugat -m 4 -M 4"
		puts "./lugat -m 1 -M 3 -c alphaAndNumSet -o wordlist.txt"
		puts "./lugat -p 1*3*8"
		puts "./lugat -p 1*3*8 -c alphaNumAndSpecSet -o wordlist.txt"
		puts
		puts
		puts "Report bugs"
		puts "------------------------"
		puts "hefese@hotmail.com.tr"
		puts
		puts
		exit
	end




	def self.minMaxComparisonError
		error = "\n\n#############################################################"
		error += "\n\nminimum length cannot be bigger than maximum length!"
		error += "\n\n#############################################################\n\n"
	
		return error
	end



	def self.wrongCharSetError
		error = "\n\n#############################################################"
		error += "\n\nWrong charset selection! The valid states as follows:\n"
		error += "\n-c alphabetSet            : For Just Letters"
		error += "\n-c numberSet              : For Just Numbers"
		error += "\n-c specialCharacterSet    : For Just Special Characters"
		error += "\n-c alphaAndNumSet         : For Letters and Numbers"
		error += "\n-c alphaAndSpecSet        : For Letters and Special Characters"
		error += "\n-c numAndSpecSet          : For Numbers and Special Characters"
		error += "\n-c alphaNumAndSpecSet     : For Letters, Numbers and Special Characters"
		error += "\n\n#############################################################\n\n"
	
		return error
	end



	def self.wrongLangModeError
		error = "\n\n#############################################################"
		error += "\n\nWrong language selection! The valid states as follows:\n"
		error += "\n-l tur       : For Turkish Wordlist"
		error += "\n-l eng       : For English Wordlist"
		error += "\n-l tureng    : For (Tur)kish and (eng)lish Wordlist (2 in 1)"
		error += "\n\n#############################################################\n\n"

		return error
	end		







	def self.createWordlist(file, min, max, charset, lang)
		min = min.to_i
		max = max.to_i

		output = ""


		if charset == "alphabetSet"
			if lang == "eng"

				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.	
				while min <= max

					start = 'a' * min
					final = 'z' * min

					("#{start}".."#{final}").each { |word| file.puts word }

					min += 1
				end

			elsif lang == "tur"

				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.	
				while min <= max
					
					generate_combinations(min, "alphabetSet_tr", file)

					min += 1

				end

			elsif lang == "tureng"
				
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.	
				while min <= max

					generate_combinations(min, "alphabetSet_tureng", file)
					min += 1
				end

			else
				puts wrongLangModeError
			end
		elsif charset == "numberSet"

			# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
			while min <= max
				start = '0' * min
				final = '9' * min

				("#{start}".."#{final}").each { |word| file.puts word }

				min += 1
			end

		elsif charset == "specialCharacterSet"
			# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
			while min <= max

				generate_combinations(min, "symbolSet", file)

				min += 1
			end
		elsif charset == "alphaAndNumSet"
			if lang == "eng"
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
				while min <= max

					generate_combinations(min, "alphaNumberSet_eng", file)

					min += 1
				end
			elsif lang == "tur"
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
				while min <= max

					generate_combinations(min, "alphaNumberSet_tr", file)

					min += 1
				end
			elsif lang == "tureng"
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
				while min <= max

					generate_combinations(min, "alphaNumberSet_tureng", file)

					min += 1
				end
			else
				puts wrongLangModeError
			end
		elsif charset == "alphaAndSpecSet"
			if lang == "eng"
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
				while min <= max

					generate_combinations(min, "alphaSymbolSet_eng", file)

					min += 1
				end
			elsif lang == "tur"
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
				while min <= max

					generate_combinations(min, "alphaSymbolSet_tr", file)

					min += 1
				end
			elsif lang == "tureng"
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
				while min <= max

					generate_combinations(min, "alphaSymbolSet_tureng", file)

					min += 1
				end
			else
				puts wrongLangModeError
			end
		elsif charset == "numAndSpecSet"
			# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
			while min <= max

				generate_combinations(min, "numberSymbolSet", file)

				min += 1
			end
		
		elsif charset == "alphaNumAndSpecSet"
			if lang == "eng"
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
				while min <= max

					generate_combinations(min, "alphaNumberSymbolSet_eng", file)

					min += 1
				end
			elsif lang == "tur"
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
				while min <= max

					generate_combinations(min, "alphaNumberSymbolSet_tr", file)

					min += 1
				end
			elsif lang == "tureng"
				# Her iterasyonda min değeri uzunluğundaki tüm olası kelimeler dosyaya eklenir.
				while min <= max

					generate_combinations(min, "alphaNumberSymbolSet_tureng", file)

					min += 1
				end
			else
				puts wrongLangModeError
			end
		else
			puts wrongCharSetError
		end
			
	end





	def self.generate_combinations(charLengthOfWord, type, file)
		# Karakter sayısı ne kadar for loop'una ihtiyacımız olduğunu söyler.
		forNumber = charLengthOfWord.to_i

		# Dinamik olarak oluşturulacak değişken sayıda for loop'larının counter değişken 
		# isimleri en fazla 500 karaktere sahip olabilir. Dolayısıyla for sayısı eğer belli
		# bir değeri aşarsa for değişkenlerinin kullanabileceği counter ismi tükenmiş olur ve
		# counter isim karmaşasıyla program beklenmedik şekilde çalışır.
		limit = 500
		

		# En içteki for loop'unun ihtiyaç duyacağı counter değişkeninin isminin karakter sayısını tutacaktır.
		maxCharNumOfCounter = nil



		# Ne kadar for loop'u varsa o kadar counter, yani o kadar değişken adı lazımdır. Bu değişken adları
		# for loop'ların sayısına göre a , b , c , ... şeklinde olabileceği gibi for loop sayısının fazla 
		# olması durumunda a , b , c , ... , aa , ab , ac , ... şeklinde de olabilir. Aşağıda en fazla ne kadar
		# karakterliye kadar değişken ismine ihtiyaç varı tespit ediyoruz.  

		# for loopu sayısı alfabedeki harf sayısından küçükse ya da eşitse 
		# bu durumda for loop'larına tek karakterlik sayaç kafi gelecektir.
		if forNumber - @@alphabetSet_eng.length <= 0
			maxCharNumOfCounter = 1
		# for loop'u sayısı alfabadeki harf sayısına bölündüğünde bölüm değeri değeri bize kaç kere 
		# yanyana kullanılması gerektiğini söyleyecektir.
		else   
			maxCharNumOfCounter = forNumber / @@alphabetSet_eng.length
		end


		minCounterVariableName = 'a'
		maxCounterVariableName = 'z' * maxCharNumOfCounter     

		i=0
		counterNames = []

		("#{minCounterVariableName}".."#{maxCounterVariableName}").each do |char|
			counterNames[i] = char
			i +=1
		end
		


		dynamicCode = ""
		forHeader = ""
		forBody = ""
		forFooter = ""


		i = 0
	

		if type == "alphabetSet_tr"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphabetSet_tr.length.times do |" + counterNames[i] + "|\n" 

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphabetSet_tr[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphabetSet_tr[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

		elsif type == "alphabetSet_tureng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphabetSet_tureng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphabetSet_tureng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphabetSet_tureng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "symbolSet"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@symbolSet.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@symbolSet[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@symbolSet[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

			
		elsif type == "alphaNumberSet_eng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSet_eng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSet_eng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSet_eng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "alphaNumberSet_tr"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSet_tr.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSet_tr[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSet_tr[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "alphaNumberSet_tureng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSet_tureng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSet_tureng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSet_tureng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "alphaSymbolSet_eng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaSymbolSet_eng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaSymbolSet_eng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaSymbolSet_eng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "alphaSymbolSet_tr"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaSymbolSet_tr.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaSymbolSet_tr[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaSymbolSet_tr[" + counterNames[i] + "].to_s\n"
				end

				i += 1 
			end
			
		elsif type == "alphaSymbolSet_tureng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaSymbolSet_tureng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaSymbolSet_tureng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaSymbolSet_tureng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "numberSymbolSet"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@numberSymbolSet.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@numberSymbolSet[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@numberSymbolSet[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "alphaNumberSymbolSet_eng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSymbolSet_eng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSymbolSet_eng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSymbolSet_eng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "alphaNumberSymbolSet_tr"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSymbolSet_tr.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSymbolSet_tr[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSymbolSet_tr[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "alphaNumberSymbolSet_tureng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSymbolSet_tureng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "file.puts "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSymbolSet_tureng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSymbolSet_tureng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		end

		# NOT:
		# forNumber ile counterNames'in indisi senkronizedir. Yani
		# 	for loops  	    :	1  2  3      26  27  28  29 30 31    
		# 	counterNames 	: 	a  b  c  ...  x   y   z  aa ab ac ..
		# Dolayısıyla counterNames[i] kullanarak ilgili for döngüsüne ait counter adını seçebiliriz.	


		i = 0

		# Ne kadar for loop'u tanımlanmışsa o kadar end komutuyla kapatılması gerekir.
		# Bu yüzden aşağıdaki kod ile for loop'u sayısınca end komutu forFooter'a eklenir.
		while i < forNumber
			forFooter = forFooter + "end\n"
			i += 1
		end

		# Başı, gövdesi ve sonu tamamlanmış for tanımlamaları birleştirilir.
		dynamicCode = forHeader + forBody + forFooter

		# String olarak tanımlanan tüm for döngüleri ruby kodu olarak çalıştırılır.
		eval(dynamicCode)
	end




	def self.createWordlistByUsingRegExp(file, regExp, charset, lang)


		# ALGORİTMA
		# -------------------------
		# arr = "1*9*2".split('')
		# guesses = [00, 01, 02, ... , 99]
		#
		# 			00   arr = 1090   anlamına gelir
		#   		01   arr = 1091   anlamına gelir
		#   		02   arr = 1092   anlamına gelir
		#
		#   		...     ...			...
		# 
		#   		99   arr = 1999   anlamına gelir.
		#	
		# 		arr'a tüm guesses'lar sırasıyla yerleştirildiği takdirde şöyle bir matris elde edilir:
		# 	
		# 			row 1	1,0,9,0
		# 			row 2	1,0,9,1
		# 		 	...	  ...
		# 			row n   1,9,9,9
		#
		# 		Yani 00'dan 99'a kadar satır olacağından arrWithGuesses'te guesses.length kadar satır olacaktır ilişkisini kurarız.
		# 		Her satırda da bir dizi olacağından aşağıdaki tanımlama yapılır.
		#
		# arrWithGuesses[guesses.length] = []
		# 
		# 		arr'ın sabit sayı index'leri ve * karakterine sahip index'leri ayrı ayrı dizilere eklenir.
		# 		Ardından arrWithGuesses[][]'deki tüm satırlara sabit sayılar index'leri referans alarak yerleştirilir. 
		#  		Son olarak da tüm satırlara * yerine kombinasyonlar sırasıyla yerleştirilerek arrWithGuesses matrisimizde
		# 		aldığımız regExp'e göre olabilecek tüm kombinasyonları toplamış oluruz.

		if charset == "alphabetSet"
			if lang == "eng"

				generate_combinations_based_on_regexp(file, regExp, "alphabetSet_eng")

			elsif lang == "tur"

				generate_combinations_based_on_regexp(file, regExp, "alphabetSet_tr")

			elsif lang == "tureng"
				
				generate_combinations_based_on_regexp(file, regExp, "alphabetSet_tureng")

			else
				puts wrongLangModeError
			end
		elsif charset == "numberSet"

			generate_combinations_based_on_regexp(file, regExp, "numberSet")

		elsif charset == "specialCharacterSet"
			
			generate_combinations_based_on_regexp(file, regExp, "symbolSet")

		elsif charset == "alphaAndNumSet"
			if lang == "eng"

				generate_combinations_based_on_regexp(file, regExp, "alphaNumberSet_eng")

			elsif lang == "tur"

				generate_combinations_based_on_regexp(file, regExp, "alphaNumberSet_tr")

			elsif lang == "tureng"

				generate_combinations_based_on_regexp(file, regExp, "alphaNumberSet_tureng")

			else
				puts wrongLangModeError
			end
		elsif charset == "alphaAndSpecSet"
			if lang == "eng"

				generate_combinations_based_on_regexp(file, regExp, "alphaSymbolSet_eng")

			elsif lang == "tur"

				generate_combinations_based_on_regexp(file, regExp, "alphaSymbolSet_tr")

			elsif lang == "tureng"

				generate_combinations_based_on_regexp(file, regExp, "alphaSymbolSet_tureng")

			else
				puts wrongLangModeError
			end
		elsif charset == "numAndSpecSet"

			generate_combinations_based_on_regexp(file, regExp, "numberSymbolSet")
		
		elsif charset == "alphaNumAndSpecSet"
			if lang == "eng"

				generate_combinations_based_on_regexp(file, regExp, "alphaNumberSymbolSet_eng")

			elsif lang == "tur"

				generate_combinations_based_on_regexp(file, regExp, "alphaNumberSymbolSet_tr")

			elsif lang == "tureng"

				generate_combinations_based_on_regexp(file, regExp, "alphaNumberSymbolSet_tureng")

			else
				puts wrongLangModeError
			end
		else
			puts wrongCharSetError
		end


	end # end method




	def self.generate_combinations_based_on_regexp(file, regExp, type)

		 
		arr = regExp.split('')
		asteriskIndex = []
		constantDigitIndex = []
		arrWithGuess = []


		# Detect constant and changeable points in regExp
		arr.length.times do |i|
			constantDigitIndex.push(i) if arr[i] != '*'
			asteriskIndex.push(i) if arr[i] == '*'
		end


		# Asterisk sayısı ne kadar for loop'una ihtiyacımız olacağını söyler.
		forNumber = asteriskIndex.length.to_i


		# En içteki for loop'unun ihtiyaç duyacağı counter değişkeninin isminin karakter sayısını tutacaktır.
		maxCharNumOfCounter = nil


		
		# Ne kadar for loop'u varsa o kadar counter, yani o kadar değişken adı lazımdır. Bu değişken adları
		# for loop'ların sayısına göre a , b , c , ... şeklinde olabileceği gibi for loop sayısının fazla 
		# olması durumunda a , b , c , ... , aa , ab , ac , ... şeklinde de olabilir. Aşağıda en fazla ne kadar
		# karakterliye kadar değişken ismine ihtiyaç varı tespit ediyoruz.  

		# for loopu sayısı alfabedeki harf sayısından küçükse ya da eşitse 
		# bu durumda for loop'larına tek karakterlik sayaç kafi gelecektir.
		if forNumber - @@alphabetSet_eng.length <= 0
			maxCharNumOfCounter = 1
		# for loop'u sayısı alfabadeki harf sayısına bölündüğünde bölüm değeri değeri bize kaç kere 
		# yanyana kullanılması gerektiğini söyleyecektir.
		else   
			maxCharNumOfCounter = forNumber / @@alphabetSet_eng.length
		end


		minCounterVariableName = 'a'
		maxCounterVariableName = 'z' * maxCharNumOfCounter     

		i=0
		counterNames = []

		("#{minCounterVariableName}".."#{maxCounterVariableName}").each do |char|
			counterNames[i] = char
			i +=1
		end


		forHeader = ""
		forBody = ""
		forFooter = ""
		dynamicCode = ""
		i = 0



		if type == "alphabetSet_eng"
			from = 'a' * asteriskIndex.length
			to = 'z' * asteriskIndex.length


			# Find all combinations as much as number of changeable points in regExp
			("#{from}".."#{to}").each do |combination|  

				# Set constants
				constantDigitIndex.length.times do |i| 
					arrWithGuess[constantDigitIndex[i]] = arr[constantDigitIndex[i]]
				end


				# Set combinations
				asteriskIndex.length.times do |i|
					arrWithGuess[asteriskIndex[i]] = combination.split('')[i]
				end


				# Output word
				file.puts arrWithGuess.join('')


				# RESET
				arrWithGuess = nil
				arrWithGuess = []
			end

			# e.g.
			#
			#   regExp  	 = 1*9*2
			#   arr     	 = [1,*,9,*,2]
			# 	arrWithGuess = [1, 'a', 9, 'a', '2']
			# 				   [1, 'a', 9, 'b', '2']
			#   			   [1, 'a', 9, 'c', '2']
			# 				   [1, 'a', 9, 'd', '2']
			#  							...
			#  							...
			#  							...
			#
			#   file.puts 
			#   				1a9a2
			#  					1a9b2
			#  					1a9c2
			#  					 ...
			#  					 ...
			#  					 ...
			#  					1z9x2
			#  					1z9y2
			#  					1z9z2

			exit

		elsif type == "alphabetSet_tr"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphabetSet_tr.length.times do |" + counterNames[i] + "|\n" 

				i += 1
			end


			i = 0
			forBody = "combination =  "

			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphabetSet_tr[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphabetSet_tr[" + counterNames[i] + "].to_s\n"
				end 

				i += 1

			end

		elsif type == "alphabetSet_tureng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphabetSet_tureng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphabetSet_tureng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphabetSet_tureng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

		elsif type == "symbolSet"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@symbolSet.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@symbolSet[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@symbolSet[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

		# Bu koşulda for loop'larına ihtiyaç olmadan iş halledilebilmektedir.

		elsif type == "numberSet"

			from = '0' * asteriskIndex.length
			to = '9' * asteriskIndex.length 


			("#{from}".."#{to}").each do |combination|  

				# Set constants
				constantDigitIndex.length.times do |i| 
					arrWithGuess[constantDigitIndex[i]] = arr[constantDigitIndex[i]]
				end


				# Set combinations
				asteriskIndex.length.times do |i|
					arrWithGuess[asteriskIndex[i]] = combination.split('')[i]
				end


				# Output word
				file.puts arrWithGuess.join('')


				# RESET
				arrWithGuess = nil
				arrWithGuess = []
			end

			exit

		elsif type == "alphaNumberSet_eng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSet_eng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSet_eng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSet_eng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

		elsif type == "alphaNumberSet_tr"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSet_tr.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSet_tr[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSet_tr[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

		elsif type == "alphaNumberSet_tureng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSet_tureng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSet_tureng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSet_tureng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

		elsif type == "alphaSymbolSet_eng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaSymbolSet_eng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaSymbolSet_eng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaSymbolSet_eng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

		elsif type == "alphaSymbolSet_tr"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaSymbolSet_tr.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaSymbolSet_tr[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaSymbolSet_tr[" + counterNames[i] + "].to_s\n"
				end

				i += 1 
			end
			
		elsif type == "alphaSymbolSet_tureng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaSymbolSet_tureng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaSymbolSet_tureng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaSymbolSet_tureng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

		elsif type == "numberSymbolSet"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@numberSymbolSet.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@numberSymbolSet[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@numberSymbolSet[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end

		elsif type == "alphaNumberSymbolSet_eng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSymbolSet_eng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSymbolSet_eng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSymbolSet_eng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "alphaNumberSymbolSet_tr"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSymbolSet_tr.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSymbolSet_tr[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSymbolSet_tr[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		elsif type == "alphaNumberSymbolSet_tureng"
			# Her iterasyonda bir tane for döngüsü açan string forHeader'a eklenir. 
			# İterasyonlar sonucunda iç içe for döngüleri elde edilir.
			while i < forNumber
				forHeader = forHeader + "@@alphaNumberSymbolSet_tureng.length.times do |" + counterNames[i] + "|\n"

				i += 1
			end


			i = 0
			forBody = "combination =  "


			# Yukarıdaki açılan for loop'larının en içerisindekinin içine girilecek kod string
			# olarak forBody'ye eklenir.
			while i < forNumber
				if i != forNumber - 1
					forBody = forBody + "@@alphaNumberSymbolSet_tureng[" + counterNames[i] + "].to_s + "
				else
					forBody = forBody + "@@alphaNumberSymbolSet_tureng[" + counterNames[i] + "].to_s\n"
				end 

				i += 1
			end
			
		end


		# NOT:
		# ----------------------------------------------------------------------
		# forNumber ile counterNames'in indisi senkronizedir. Yani forNumber tane for loop olacağına göre;
		# 	for loops  	    :	1  2  3      26  27  28  29 30 31    
		# 	counterNames 	: 	a  b  c  ...  x   y   z  aa ab ac ..
		# Dolayısıyla counterNames[i] kullanarak ilgili for döngüsüne ait counter adını seçebiliriz.
		# ----------------------------------------------------------------------	



		# Buraya kadar gelinen noktada aşağıdakine benzer bir template oluşacaktır:
		# ----------------------------------------------------------------------
		# @@alphabetSet_tr.length.times do |i|
		# 	@@alphabetSet_tr.length.times do |j|
		# 		@@alphabetSet_tr.length.times do |k|
		# 			combination = @@alphabetSet_tr[i] + alphabetSet_tr[j] + alphabetSet_tr[k]
		#
		# ----------------------------------------------------------------------



		# En içteki for loop'unun içine ilgili kombinasyonu sözlük dosyasına yazdıracak kodlar ilave edilir. 
		forBody = forBody + "
						\n\n

						# Set constants
						constantDigitIndex.length.times do |i| 
							arrWithGuess[constantDigitIndex[i]] = arr[constantDigitIndex[i]]
						end


						# Set combinations
						asteriskIndex.length.times do |i|
							arrWithGuess[asteriskIndex[i]] = combination.split('')[i]
						end


						# Output word
						file.puts arrWithGuess.join('')


						# RESET	
						# ----------------------------------------------------------------------------	
						# Bu bölümün olması sözlük oluşturma hızını ciddi oranda düşürüyor. Bu bölüme zaten 
						# gerek de yok. arrWithGuess dizisi yukarıda overwrite edilerek reset işlemine hacet
						# bırakmıyor. Peki burası halen niye var der gibisin. Bunun nedeni performansa
						# böylesi bir resetlemenin nasıl etki ettiğini bilesin diyedir. Tıpkı aynı şekilde alan
						# tahsisi yapan bu fonksiyonların arasındaki performans farkında olduğu gibi. malloc yer tahsisi
						# yaparken tahsis ettiği hücreleri resetlemezken calloc tahsis ettiği hücreleri resetlediği için 
						# malloc calloc'dan daha hızlı çalışır. Bu durum burada da aynıdır. Reset varsa performans düşer.
						#
						# arrWithGuess = nil
						# arrWithGuess = []
						# ----------------------------------------------------------------------------

					"


		i = 0

		# Dosyaya yazdırma kodlarından sonra ne kadar for loop'u tanımlanmışsa o kadar end komutuyla bu for'ların
		# kapatılması gerekir. Bu yüzden aşağıdaki kod ile for loop'u sayısınca end komutu forFooter'a eklenir.
		while i < forNumber
			forFooter = forFooter + "end\n"
			i += 1
		end

		# Başı, gövdesi ve sonu tamamlanmış for tanımlamaları birleştirilir.
		dynamicCode = forHeader + forBody + forFooter

		# String olarak tanımlanan tüm for döngüleri ruby kodu olarak çalıştırılır ve sözlük dosyası oluşturulur.
		eval(dynamicCode)

	end # end method

end # end class
