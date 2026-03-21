# Changelog

## 1.2.1 2026-03-xx

- Changed the `Hetu#gender_neutral?` method to always return `false` because the
  originally planned government proposal GP 132/2022 (HE 132/2022) did not
  become a law.
- Removed the excess logic from the `Hetu#gender` method to not check
  `gender_neutral?` since it is unnecessary after the previous change.

## 1.2.0 2022-10-xx

Added new punctuation marks that will be added to identity codes in 2023.

Added gender_neutral? method. Using gender methods on gender neutral
identity codes will raise an exception. Gender neutral identity codes will
be introduced in 2027. Gender methods will still be available for pins using
the old punctuation.

## 1.1.0 - 2019-04-xx

Removed the lock down from the dependent gems in order to make the gem
compatible with Active Model 5.x.x and Bundler 2.x.x.

## 1.0.2 - 2018-11-14

- Added `Hetu.generate` method for valid random PIN generation
- Code cleanup and refactoring

## 1.0.1 - Unreleased

Added dependency constraints for the `minitest`, `timecop` and `activemodel`
gems.

## 1.0.0 - 2015-10-08

Initial release.
