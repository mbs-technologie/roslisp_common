
(in-package :cl-tf)

(defclass transform-listener (transformer)
  ((subscriber)))

(defgeneric destroy (obj))

(defmethod initialize-instance :after ((tf transform-listener) &key)
  (setf (slot-value tf 'subscriber)
        (subscribe "/tf" "tf/tfMessage" (lambda (msg) (tf-listener-callback tf msg)))))

(defun tf-listener-callback (tf msg)
  (mapc (lambda (transform)
          (set-transform tf transform))
        (tf-message->transforms msg)))

(defmethod destroy ((tf transform-listener))
  ;; (roslisp:unsubscribe (slot-value tf 'subscriber))
  nil)