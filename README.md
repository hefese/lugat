# lugat
Sözlük saldırılarında kullanılmak üzere sözlük oluşturucu bir tool'dur. 
Geniş charset opsiyonuna ve kısmi RegExp desteğine sahiptir. Kullanılışı
şu şekildedir:

Usage
------------------------
./lugat -m &lt;min&gt; -M &lt;max&gt; -c &lt;charset&gt; -l &lt;lang&gt; -o &lt;fileName&gt;


Parameters
------------------------
-m &lt;min&gt;       : Minimum character length of passwords

-M &lt;max&gt;       : Maximum character length of passwords

-c &lt;charset&gt;   : Character set which will be used

-l &lt;lang&gt;      : Alphabet of A Specific Language 

-o &lt;fileName&gt;  : Output file name

-p &lt;pattern&gt;   : All possible passwords based on given pattern


Charset Keywords
------------------------
alphabetSet         : Just Letters

numberSet           : Just Numbers

specialCharacterSet : Just Special Characters

alphaAndNumSet      : Letters and Numbers

alphaAndSpecSet     : Letters and Special Characters

numAndSpecSet       : Numbers and Special Characters

alphaNumAndSpecSet  : Letters, Numbers and Special Characters


Language Modes
------------------------
tur                 : Uses Turkish Alphabet

eng                 : Uses English Alphabet

tureng              : Uses Both Turkish and English Alphabet


Examples
------------------------
./lugat -m 4 -M 4

./lugat -m 1 -M 3 -c alphaAndNumSet -o wordlist.txt

./lugat -p 1\*3\*8

./lugat -p 1\*3\*8 -c alphaNumAndSpecSet -o wordlist.txt


Report bugs
------------------------
fatih.simsek@tubitak.gov.tr
