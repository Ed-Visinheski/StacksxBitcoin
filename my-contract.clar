;; title: my-contract
;; version:
;; summary:
;; description:

;; traits
;;

;; token definitions
;; 

;; constants
;;

;; data vars
;;
(define-data-var last-user-id uint u0)
;; data maps
(define-map users {id: uint} {username: (string-ascii 20), password: (string-ascii 20)})
(define-map usernames-to-ids {username: (string-ascii 20)} {id: uint})
(define-public (doSomethingWithAddress (testnetAddress (buff 40)))
  ;; Your code logic here
)


(define-map messages {username: (string-ascii 20), message: (string-ascii 200),message-id: (uint)})
(define-data-var message-counter uint u0)
;; public functions
;;


(define-public (post-message (username (string-ascii 20)) (message (string-ascii 200)))
  (let ((message-id (var-get message-counter)))
    (var-set message-counter (+ message-id u1))
    (map-set messages 
      {message-id: message-id} 
      {username: username, message: message})
    (ok message-id)
  )
)

(define-read-only (get-message (message-id uint))
  (map-get? messages {message-id: message-id})
)

(define-map chatrooms
  ((chatroom-id uint)) 
  ((owner (string-ascii 20)) (name (string-ascii 20)))
)

(define-data-var chatroom-counter uint u0)

(define-public (create-chatroom (username (string-ascii 20)) (password (string-ascii 64)) (name (string-ascii 20)))
  (let ((user-opt (map-get? users {username: username})))
    (if (is-none user-opt)
      (err "User not found")
      (if (is-eq (get password user) password)
        (let ((chatroom-id (var-get chatroom-counter)))
          (var-set chatroom-counter (+ chatroom-id u1))
          (map-set chatrooms 
            {chatroom-id: chatroom-id} 
            {owner: username, name: name})
          (ok chatroom-id)
        )
        (err "Invalid password")
      )
    )
  )
)