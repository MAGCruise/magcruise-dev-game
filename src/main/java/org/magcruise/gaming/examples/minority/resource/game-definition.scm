(define (def:setup-game-builder builder ::GameBuilder)
  (builder:addDefContext
   (def:context org.magcruise.gaming.examples.minority.actor.MinorityGameContext))
  (builder:addDefPlayers
    (def:player 'HumanPlayer1 'human org.magcruise.gaming.examples.minority.actor.MinorityGamePlayer)
    (def:player 'HumanPlayer2 'human org.magcruise.gaming.examples.minority.actor.MinorityGamePlayer)
    (def:player 'HumanPlayer3 'human org.magcruise.gaming.examples.minority.actor.MinorityGamePlayer))

  (builder:addDefRounds
    (def:rounds 2
      (def:parallel-stage 'vote
        (def:task 'HumanPlayer1 'vote)
        (def:task 'HumanPlayer2 'vote)
        (def:task 'HumanPlayer3 'vote))
      (def:stage 'dist
        (def:task 'distribution)))))

(define items '("アイテムX" "アイテムY"))


(define (distribution ctx ::Context)
  (define select-first (filter (lambda (p ::Player) (eqv? (p:get 'item) (items 0))) (ctx:players:asLList)))
  (define select-second (filter (lambda (p ::Player) (eqv? (p:get 'item) (items 1))) (ctx:players:asLList)))
  (define minority
    (if (< (length select-first) (length select-second)) select-first select-second))
  (ctx:showMessageToAll
    (html:p "結果は以下です"
      (apply html:ul
        (map
          (lambda (p ::Player) (to-string p:name "→" (p:get 'item) ", "))
          (ctx:players:asLList)))))
  (log:debug (ln) minority)
  (for-each
    (lambda (p ::Player)
        (ctx:showMessageToAll (to-string p:name "が" (p:get 'item) "を手に入れました．")))
    minority)
  (ctx:showMessageToAll (to-string "ラウンド" ctx:roundnum "が終了しました")))
