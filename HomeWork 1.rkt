;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |HomeWork 1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
;; #reader(lib "htdp-beginner-reader.ss" "lang")((modname HW01-funkce-a-konstanty) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Domácí úkol

; Vlastník kina v malém městě vás poprosil o přípravu
; programu, který mu pomůže odhadnout výdělky z prodeje
; vstupenek.

; Toto kino má ve městě monopol - vlastník může nastavit
; cenu lístků libovolně. Čím dražší lístky ale jsou,
; tím méně lidí do kina chodí.
; Vlastník nedávno provedl experiment, ve kterém určil
; závislost ceny lístků a průměrné návštěvnosti.

; Při ceně 180Kč za lístek přijde v průměru 120 lidí.
; Za každou změnu o 10Kč se návštěvnost změní o 15 lidí,
; tedy při ceně 190Kč přijde 105 lidí a při ceně 170Kč
; přijde 135 lidí.

; Toto lze zapsat jako matematický vzorec:
; průměrná návštěvnost = 120 lidí - ((změna ceny)Kč / 10Kč) * 15 lidí

; Zvýšená návštěvnost ale také provází zvýšené náklady na
; údržbu kina. Každé promítání stojí fixně 16000Kč a navíc
; 8Kč za každého diváka.

; Napište program, který z ceny lístku odhadne celkový profit.
; Tento program rozdělte na více funkcí, každá funkce bude
; počítat právě jednu věc.

; Hint:
; Potřebujete určit následující:
; - průměrný počet diváků podle ceny lístku
; - výdělek z prodeje lístků podle ceny lístku a počtu diváků
; - náklady na promítání podle počtu diváků
; - profit podle výdělků a nákladů
; Pro každý tento bod napište separátní funkci.
; Váš kód by neměl obsahovat magické hodnoty.


;; - 120, 180, 10 a 15 - stále by šly klasifikovat jako magické konstanty
(define (numberOfPeople price)
  (- 120 (* (/ (- price 180) 10) 15)))

(define (productFromSoldTickets price)
  (* (numberOfPeople price) price))

(define (screeningCosts price fixExpenses expensesForEachPerson)
  (+ (* (numberOfPeople price) expensesForEachPerson) fixExpenses))

;; předání jako parametr je v pořádku, lze ale i zavést jako konstanty na top-levelu
(define (profit price fixExpenses expensesForEachPerson)
  (- (productFromSoldTickets price) (screeningCosts price fixExpenses expensesForEachPerson)))


; Řešení lze zapsat pomocí jediné funkce a magických hodnot:
(define (profitMagic price)
  (- (* (+ 120
           (* (/ 15 10)
              (- 180 price)))
        price)
     (+ 16000
        (* 8
           (+ 120
              (* (/ 15 10)
                 (- 180 price)))))))

(profit 140 16000 8)
(profitMagic 140)

;; hezké řešení :)
; hledat tento profit budu vyhledáváním derivace funkce, a bod při y = 0 bude vrcholkem naše funkce
; (120 + (15 / 10) * (180 - price)) * price - (fixExpenses + expensesForEachPerson * (120 + (15 / 10) * (180 - price)))
; derivace funkce f'(price) = 390 + 1.5 * expensesForEachPerson - 3 * price (řešení jsem dal do svého githubu, ale asi ho potřebovat nebudete)
(define (biggestProfit expensesForEachPerson)
  (+ 130 (* 0.5 expensesForEachPerson)))

(biggestProfit 8) ; nejvýhodnější cena
(profit (biggestProfit 8) 16000 8) 

; Ujistěte se, že vaše řešení produkuje stejné výsledky jako
; tato funkce - vyzkoušejte hodnoty ceny 120, 130, 140, 150, ..., 200.

; Zkuste určit (s přesností na koruny) nejvýhodnější cenu
; lístků pro vlastníka - kdy bude mít největší profit?


; Po bližším zkoumání nákladu se majiteli kina podařilo
; snížit náklady na údržbu - fixní cena je nyní pouze 2000,
; ale za každého diváka je nyní cena 80 Kč.

(define (newProfitMagic price)
  (- (* (+ 120
           (* (/ 15 10)
              (- 180 price)))
        price)
     (+ 2000
        (* 80
           (+ 120
              (* (/ 15 10)
                 (- 180 price)))))))

(profit 140 2000 80)
(newProfitMagic 140)

(biggestProfit 80) ; nejvýhodnější cena
(profit (biggestProfit 80) 2000 80) 

; Modifikujte obě implementace (váš kód i funkci profit-magic),
; upravené verze nazvěte například
#;profit-magic.v2
; a opět vyzkoušejte, jestli dávají stejné výsledky.