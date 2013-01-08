# Coins

Coins is a simple, no-frills microcurrency server written in Ruby. It is based on
the [treasury-server](https://github.com/twuni/treasury-server) project and the
Twuni Digital Cash API.

## Specification

There are four basic operations:

### Create: POST / (parameters: `value`=n)

This is an administrative task, which creates a new coin of the given `value`.

### Evaluate: GET /`id`

This validates the worth of a given coin.

### Split: PUT /`id`/split/`value`

This splits a coin into two coins of lesser value.
For instance, you might split a **5.00** coin into **2.25** and **2.75** coins
to pay bus fare.

### Merge: PUT /`id1`/merge/`id2`

This combines two coins into a single coin of greater value.
For instance, you might combine a **10.00** coin from a friend with the **74.25**
coin in your wallet to get a **84.25** coin for your wallet.

## License

This project is public domain. Use it, fork it, sell it, in whole or in part.
