## LLN_rozkladNormalnyWzrostu:

Implementacja LLN dla rozkładu normalnego.

### Ustawienie parametrów:
- mu - średnia rozkładu normalnego.
- sigma - odchylenie standardowe rozkładu normalnego.
- n - liczba próbek.

### Losowanie próbek:
Używa funkcji rnorm() do losowego generowania n próbek z rozkładu normalnego o średniej mu i odchyleniu standardowym sigma.

### Wykonywanie symulacji i tworzenie wykresu:
Podobnie jak w poprzednim kodzie, symuluje LLN, ale tym razem dla rozkładu normalnego.
Tworzy wykres zależności średniej próbki od liczby próbek (n).
Dodaje linie łączące punkty na wykresie.
Dodaje linię reprezentującą wartość oczekiwaną (mu).


## LLN_rzutKostka:

Ten kod implementuje symulację prawa wielkich liczb (LLN) dla kostki sześciennej. Prawo to mówi, że średnia próbkowa z próby o rozmiarze n zbiega prawie na pewno do wartości oczekiwanej zmiennej losowej (w tym przypadku średniej z wyników rzutów kostką), gdy n dąży do nieskończoności.

### Ustawienie parametrów:
- p - prawdopodobieństwo dla każdej strony kostki (1/6 w przypadku kostki sześciennej).
- xi - możliwe wyniki od 1 do 6.
- mu - wartość oczekiwana (średnia) liczona jako suma każdego możliwego wyniku pomnożonego przez prawdopodobieństwo.
- n - liczba próbek.

### Inicjalizacja pustej listy na średnie próbek (x_bar_seq).

### Zakres liczby próbek (n_seq):
Generuje sekwencję wartości n od 10 do 10000 z krokiem 100.

### Wykonanie symulacji:
W pętli dla każdej wartości n z n_seq:
- Losuje n próbek z rozkładu xi z równomiernymi prawdopodobieństwami (sample()).
- Oblicza średnią z próbek (x_bar) za pomocą funkcji mean().
- Zapisuje x_bar do listy x_bar_seq.

### Wykres:
- Tworzy wykres zależności średniej próbki od liczby próbek (n).
- Dodaje linie łączące punkty na wykresie.
- Dodaje linię reprezentującą wartość oczekiwaną (mu).

===

### Podsumowanie teoretyczne:
Oba kody implementują prawo wielkich liczb dla różnych rozkładów. W pierwszym przypadku badamy średnią wyników z kostki sześciennej, a w drugim średnią próbkę z rozkładu normalnego.

### Różnice:
- W pierwszym kodzie badamy wyniki dyskretne (wyniki kostki sześciennej), a w drugim kodzie badamy wyniki ciągłe (z rozkładu normalnego).
- W pierwszym kodzie używamy funkcji sample() do losowego wyboru próbek z rozkładu dyskretnego, a w drugim kodzie używamy funkcji rnorm() do losowego generowania próbek z rozkładu normalnego.
- Oba kody ilustrują zbieżność średniej próbki do wartości oczekiwanej w miarę zwiększania liczby próbek, co jest główną ideą praw wielkich liczb.

## Rozkład dyskretny:
Rozkład dyskretny jest to rodzaj rozkładu prawdopodobieństwa, w którym zmienna losowa może przyjmować tylko skończoną lub przeliczalną liczbę wartości. Oznacza to, że prawdopodobieństwo wystąpienia każdej z tych wartości jest określone i nie ma wartości pomiędzy nimi.
Przykłady rozkładów dyskretnych to np. rozkład jednostajny (np. wyniki rzutu kostką), rozkład dwumianowy (np. liczba sukcesów w ciągu n prób w eksperymencie Bernoulliego), rozkład Poissona (np. liczba zdarzeń w danym przedziale czasowym) itp.
W kontekście kodu, którego fragment został przedstawiony, rozkład dyskretny odnosi się do wyników możliwych rzutów kostką sześcinną, gdzie możliwe wyniki to liczby od 1 do 6. Każda z tych wartości ma równe prawdopodobieństwo wystąpienia (1/6), co czyni ten rozkład dyskretnym.
