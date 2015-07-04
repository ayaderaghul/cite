;; this small program helps to cite academic papers in Harvard style. it produces latex syntax (in a .txt file).
;; reference of sources (and link to the harvard style of citation) can be found at the end of this file.

(require racket/gui/base)
;; cite in havard style
(define frame (new frame% [label "cite"]
		   [min-width 500]))

;; callback of tab

(define (delete-a-child a-pane a-child)
  (send a-pane delete-child a-child))

(define (delete-children a-pane children-list)
  (map (lambda (x) (delete-a-child a-pane x)) children-list))

(define (add-a-child a-pane a-child-list a-posn)
  (send a-pane add-child
	(list-ref a-child-list a-posn)))
(define (add-children a-pane a-child-list a-posn-list)
  (map (lambda (x) (add-a-child a-pane a-child-list x)) a-posn-list))

(define (show-content a-pane a-child-list a-posn-list)
  (begin
    (delete-children a-pane (send a-pane get-children))
    (add-children a-pane a-child-list a-posn-list)))

;; file name

(define file-name
  (new text-field%
       [parent frame]
       [label "Enter file-name here: "]
       [init-value "trial.txt"]
       [callback (lambda (b e) (set! temp-file (current-file)))]
       ))

(define temp-file "trial.txt")
(define (current-file) (send file-name get-value))
;; choice

(define tab (new tab-panel%
		 [parent frame]
		 [choices (list "Print Materials"
				"Online Materials"
				"Images & Sound")]
		 [callback (lambda (b e)
			     (show-content radio-pane radio-list
					   (list (send tab get-selection))))]))


(define radio-pane (new horizontal-pane%
			   [parent tab]))
(define print-materials (new radio-box%
		   [label ""]
		   [parent radio-pane]
		   [choices (list "Journal"
				  "Newspaper"
				  "Book: contribution"
				  "Book"
				  "Conference paper"
				  "Patent"
				  "Report"
				  "Thesis")]
		   [callback (lambda (b e)
			       (activate 0
					 (send print-materials get-selection)))]))

(define online (new radio-box%
		   [label ""]
		   [parent radio-pane]
		   [style '(vertical deleted)]
		   [choices (list "Journal"
				  "Newspaper/Magazine"
				  "Digital map"
				  "E-book"
				  "Report"
				  "Online Photo"
				  "Webpage")]
		   [callback (lambda (b e)
			       (activate 1
					 (send online get-selection)))] ))

(define multi (new radio-box%
		   [label ""]
		   [parent radio-pane]
		   [style '(vertical deleted)]
		   [choices (list "Film"
				  "Youtube.."
				  "Social media"
				  "TV")]
		   [callback (lambda (b e)
			       (activate 2
					 (send multi get-selection)))]))

(define radio-list
  (list print-materials online multi))
;; citing in text



(define example-list
  (list
  (list "Kennedy, R.R., 2009. The power of in-class debates. Active learning in higher education, 10 (3), 225-236."

"Aldrick, P., 2011. Christmas cheer for high street amid recession warning. The Daily Telegraph , 21 December 2011, 3."

"Briassoulis, H., 2004. Crete: endowed by nature? In: Bramwell, B., ed. Coastal mass tourism. Clevedon: Channel View, 48-67."

"Woods, P., 1999. Successful writing for qualitative researchers. London: Routledge."

"Granger, S., 1994. The hacker ethic. In: Kizza, J.M., ed. Ethics in the Computer Age, 11-13 November 1994 Tennessee. New York: ACM Press, 7-9."

"Mavin, G. and Stevenson, T., (Portola Packaging Limited), 2007. Container closure. UK patent application 2428669 A. 7 February 2007."

"Kinnersly, R., 2013 . Signing up to the Convention on Biological Diversity. Peterborough: Nature Conservation Committee. Report 489."

"Young, V. E., 1997. Special collections in the year 2015: a Delphi study . Thesis (PhD). University of Alabama."
)
  (list
   "Kennedy, R.R., 2009. The power of in-class debates. Active learning in higher education [online], 10 (3), 225-236."

"Harrison, N., 2013. Marks & Spencer hires Dame Helen Mirren. Retail Week [online], 19 August 2013. Available from: http://www.retail-week.com/... [Accessed 20 August 2013]."

"Ordnance Survey, 2013. Wimborne Minster, 1:1250, [map]. Edinburgh: EDINA. Available from: http://digimap.edina.ac.uk [Accessed 15 August 2013]."

"Drummond, S. and McMahon-Beattie, U., eds. 2004. Festival and events management [online]. Oxford: Elsevier Butterworth-Heinemann."

"Mintel, 2013. Holiday property  UK May 2013 [online]. London: Mintel Group."

"Downer, C., 2009. Charles van Raalte memorial [photograph]. Dorset: geography.org.uk. Available from: http://commons.wikimedia.org/wiki/File.jpg [Accessed 19 July 2013]."

"BBC News Dorset, 2011. Boscombe surf reef attracts '100 species' [online]. BBC News. Available from: http://www.bbc.co.uk/news/.. [Accessed 19 August 2013].")
  (list
   "The Matrix, 1999. [film, DVD]. Directed by Andy Wachowski and Lana Wachowski. USA: Warner Bros."

"Bournemouth University, 2013. Intro to BU Library [video, online]. Available from: https://www.youtube.com/watch?v=.. [Accessed 9 July 2013]."

"Bournemouth Uni., 2012. Good luck to all. Twitter bournemouthuni [online]. 15 August 2012. Available from: https://twitter.com/bournemouthuni.. [Accessed 20 August 2012]."

"Blair, Tony, 2003. Interview. In: BBC Six o'clock News [television programme]. BBC1. 29 February 2003. 18:23.")))

(define citing-example (new message%
			    [parent frame]
			    [stretchable-width #t]
			    [label (first (first example-list))]))
;; text-fields
(define field-pane
  (new vertical-pane%
       [parent frame]
       ))

;; cite keys
(define cite-key
  (new text-field%
       [parent field-pane]
       [label "Citation key: "]
       [init-value ""]
       [stretchable-width #t]
       ))

;; author's name
(define author
  (new text-field%
       [parent field-pane]
       [label "Surname, INITIALS.: "]
       [init-value ""]
       [stretchable-width #t]
       ))

;; title
(define title
  (new text-field%
       [parent field-pane]
       [label "Title: "]
       [init-value ""]
       [stretchable-width #t]))

(define editor
  (new text-field%
       [parent field-pane]
       [label "Editor: "]
       [init-value ""] [style '(single deleted)]
       [stretchable-width #t]))

;; publisher.
(define publisher
  (new text-field%
       [parent field-pane]
       [label "Publisher: School: "]
       [init-value ""] [style '(single deleted)]
       [stretchable-width #t]))


;; journal
(define journal
  (new text-field%
       [parent field-pane]
       [label "Journal: "]
       [init-value ""]
       [stretchable-width #t]))

(define edition-or-patent
  (new text-field%
       [parent field-pane]
       [label "Edition/Patent series/Type: "]
       [init-value ""] [style '(single deleted)]
       [stretchable-width #t]))

;; d-m-y
(define dmy
  (new text-field%
       [parent field-pane]
       [label "DMY: "]
       [init-value ""] [style '(single deleted)]
       [stretchable-width #t]))

;; volume number and part number
(define volume
  (new text-field%
       [parent field-pane]
       [label "Volume: "]
       [init-value ""]
       [stretchable-width #t]))



;; page numbers
(define pages
  (new text-field%
       [parent field-pane]
       [label "Pages: "]
       [init-value ""]
       [stretchable-width #t]))

;; year.
(define year
  (new text-field%
       [parent field-pane]
       [label "Year: "]
       [init-value ""]
       [stretchable-width #t]))
;; Available from:
(define url
  (new text-field%
       [parent field-pane]
       [label "Url: "]
       [init-value ""] [style '(single deleted)]
       [stretchable-width #t]))
;; [Accessed ...].
(define accessed
  (new text-field%
       [parent field-pane]
       [label "Accessed: "]
       [init-value ""] [style '(single deleted)]
       [stretchable-width #t]))

;; list
(define field-list
  (list author ; 0
	title ; 1
	editor ; book-contribution
	publisher
        journal ; 4
	edition-or-patent ; book-contribution
	dmy ; 6
	volume ; 7
       	pages ; 8
        year ; 9
	url
	accessed
        cite-key ; 12
))


;; task for callback of print

(define content-list
  (list
   (list '(12 0 1 4 7 8 9)
	 '(12 0 1 4 6 7 8)
	 '(12 0 1 4 2 3 8 9)
	 '(12 0 1 3 9)
	 '(12 0 1 5 6 3 8 9)
	 '(12 0 1 4 5 6)
	 '(12 0 1 3 8 9)
	 '(12 0 1 5 3 9))
   (list
    '(12 0 1 4 7 8 9)
    '(12 0 1 4 6 10 11)
    '(12 0 1 5 3 10 11 9)
    '(12 0 1 3 9)
    '(12 0 1 3 9)
    '(12 0 1 3 10 11 9)
    '(12 0 1 3 10 11 9))
   (list
    '(12 1 6 7 3)
    '(12 0 1 10 11 9)
    '(12 0 1 4 6 10 11)
    '(12 0 1 4 5 6))))

(define (show-content-in-field-pane tab-posn radio-posn)
  (show-content field-pane field-list
		(list-ref (list-ref content-list tab-posn)
			  radio-posn)))


(define (set-example tab-posn radio-posn)
  (send citing-example set-label
	(list-ref
	 (list-ref example-list tab-posn) radio-posn)))


(define (activate tab-posn radio-posn)
  (begin
    (set-example tab-posn radio-posn)
    (show-content-in-field-pane tab-posn radio-posn)))

;; ADD
(define button-pane (new horizontal-pane% [parent frame]))

(define (current-data a-text-field)
  (send a-text-field get-value))

(define add
  (new button%
       [parent button-pane]
       [label "Add"]
       [callback
	(lambda (b e)
	  (export-data (send tab get-selection)
		       (send
			(first (send radio-pane get-children))
			get-selection)))]))


;; task for callback of add

(define citation-template
  (list
   (list
    "\\bibitem{~a} ~a, ~a. \\emph{~a}. ~a, ~a, ~a. \n"
    "\\bibitem{~a} ~a, ~a. \\emph{~a}. ~a, ~a, ~a. \n"
    "\\bibitem{~a} ~a, ~a. In: \\emph{~a}, ed. ~a. ~a, ~a, ~a. \n"
    "\\bibitem{~a} ~a. \\emph{~a}. ~a, ~a. \n"
    "\\bibitem{~a} ~a, ~a. \\emph{~a}. ~a, ~a, ~a, ~a. \n"
    "\\bibitem{~a} ~a, ~a. \\emph{~a}. In: ~a, ~a. ~a, ~a. \n"
    "\\bibitem{~a} ~a, ~a. \\emph{~a}. ~a. ~a. \n"
    "\\bibitem{~a} ~a, ~a. ~a. ~a. ~a. \n"
    "\\bibitem{~a} ~a, ~a. \\emph{~a}. ~a. ~a. \n")
   (list
    "\\bibitem{~a} ~a, ~a. \\emph{~a} [online], ~a, ~a, ~a. \n"
    "\\bibitem{~a} ~a, ~a. \\emph{~a} [online], ~a. Available from: \\url{~a} [Accessed ~a]. \n"
    "\\bibitem{~a} ~a, ~a. \\emph{~a}, ~a, [map]. ~a. Available from: \\url{~a} [Accessed ~a], ~a. \n"
    "\\bibitem{~a} ~a. \\emph{~a} [online]. ~a, ~a. \n"
    "\\bibitem{~a} ~a, ~a [online]. ~a, ~a. \n"
    "\\bibitem{~a} ~a, ~a [photograph]. ~a. Available from: \\url{~a} [Accessed ~a], ~a. \n"
    "\\bibitem{~a} ~a. \\emph{~a} [online]. ~a. Available from: \\url{~a} [Accessed ~a], ~a. \n")
   (list
    "\\bibitem{~a} \\emph{~a}, ~a. ~a. ~a. \n"
    "\\bibitem{~a} ~a, \\emph{~a}. Available from: \\url{~a} [Accessed ~a], ~a. \n"
    "\\bibitem{~a} ~a, ~a. \\emph{~a}. ~a. Available from: \\url{~a} [Accessed ~a]. \n"
    "\\bibitem{~a} ~a, ~a. In: \\emph{~a}. ~a, ~a. \n")))


(define (create-sentence tab-posn radio-posn)
  (eval (append (list 'format (list-ref (list-ref citation-template tab-posn) radio-posn))
		(map current-data (send field-pane get-children)))))


(define (export-data tab-posn radio-posn)
  (with-output-to-file temp-file
    (lambda ()
      (printf (create-sentence tab-posn radio-posn)))
    #:exists 'append))


(define (blank-out a-text-field)
  (send a-text-field set-value ""))

(define reset
  (new button%
       [parent button-pane]
       [label "Reset"]
       [callback
	(lambda (b e)
	  (map blank-out (send field-pane get-children)))]))

(send frame show #t)



; Reference:

; Bournemouth Uni., 2014. {\emph{How to cite references: BU Harvard Style}} [online]. Bournemouth University. Available from: \url{http://www.bournemouth.ac.uk/library/how-to/citing-refs-harvard.html} [Accessed 3 July 2014].
