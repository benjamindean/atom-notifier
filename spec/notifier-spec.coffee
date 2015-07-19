path = require 'path'
fs = require 'fs'

describe 'atom notifier', ->
    beforeEach ->
        waitsForPromise ->
            atom.packages.activatePackage('notifications')
            atom.packages.activatePackage('atom-notifier')

    it 'shoud find an icon', ->
        image = path.resolve(__dirname, '..', 'images', 'atom.png')
        expect(image).toBeTruthy
        expect(fs.readFileSync(image)).toBeTruthy
