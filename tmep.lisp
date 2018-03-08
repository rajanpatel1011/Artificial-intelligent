(defvar *kb* (make-hash-table :TEST #'equal)
"creating hash table for the storage.]")
 
(defun ask-and-tell (statement)
(let ( (n (get-name statement))
(v (get-valence statement))
(o (get-object statement))
(the-reply NIL))
(cond ( (question statement) (setf the-reply (reply n v o)))
( (already-known n v o) (setf the-reply "I KNOW THAT ALREADY."))
( (contradictory n v o)
(if (they-are-sure)
(and (delete-entry n (invert v) o) (add-entry n v o)))
(setf the-reply "OK."))
(t (add-entry n v o) (setf the-reply "OK.")))
the-reply))
 
 
(defun get-name (statement)
(cond ((question statement) (second statement))
(t (first statement))))
 
(defun get-valence (statement)
(cond ((question statement) (third statement))
(t (second statement))))
 
(defun get-object (statement)
(cond ((question statement) (fourth statement))
(t (third statement))))
 
(defun question (statement)
(eq (first statement) 'does))
 
 
(defun not-known (name)
(not (gethash name *kb*)))
 
(defun likes (name)
(car (gethash name *kb*)))
 
(defun dislikes (name)
(cadr (gethash name *kb*)))
 
(defun make-new-entry (name)
(setf (gethash name *kb*) '(nil nil)))
 
(defun add-entry (name valence object)
(progn
(if (not-known name) (setf (gethash name *kb*) '(nil nil)))
(cond ( (eq valence 'likes)
(setf (gethash name *kb*) (list (cons object (likes name))
(dislikes name))))
( (eq valence 'dislikes)
(setf (gethash name *kb*) (list (likes name)
(cons object (dislikes name))))))))
 
(defun delete-entry (name valence object)
(cond ( (eq valence 'likes)
(setf (gethash name *kb*) (list (delete object (likes name))
(dislikes name))))
( (eq valence 'dislikes)
(setf (gethash name *kb*) (list (likes name)
(delete object (dislikes name)))))))
 
 
(defun a (name valence object)
(if (eq valence 'likes) (member object (likes name))
(member object (dislikes name))))
 
(defun already-known (name valence object)
(cond ( (eq valence 'likes) (member object (likes name)))
( (eq valence 'dislikes) (member object (dislikes name)))))
 
(defun contradictory (name valence object)
(cond ( (eq valence 'likes) (member object (dislikes name)))
( (eq valence 'dislikes) (member object (likes name)))))
 
 
(defun reply (name valence object)
(cond ( (not-( name) "I DON'T KNOW")
( (and (eq valence 'like) (member object (likes name)))
"YES.")
( (and (eq valence 'like) (member object (dislikes name)))
"NO.")
( (and (eq valence 'dislike) (member object (dislikes name)))
"YES.")
( (and (eq valence 'dislike) (member object (likes name)))
"NO.")
(t "I DON'T KNOW.")))
 
 
(defun they-are-sure ()
(let (response)
(princ "YOU'VE CHANGED YOUR MIND. ARE YOU SURE? ")
(setf response (read))
(cond ((eq response 'yes) t)
(t nil))))
 
(defun invert (v)
(if (eq v 'likes) 'dislikes 'likes))