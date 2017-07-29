# TSlider
İOS Basic Image &amp; Title Slider

![alt tag](https://user-images.githubusercontent.com/16580898/28749155-d440adf0-74c6-11e7-875b-cb1fd0f900b3.png)

![Xcode 8.3+](https://img.shields.io/badge/xcode-8.3%2B-blue.svg)
![iOS 9.0+](https://img.shields.io/badge/İOS-9.0%2B-brightgreen.svg)
![Swift 3.0+](https://img.shields.io/badge/Swift-3.0%2B-orange.svg)
[![License](https://img.shields.io/cocoapods/l/Hero.svg?style=flat)](https://github.com/lkzhao/Hero/blob/master/LICENSE?raw=true)
[![@uikenan](https://img.shields.io/badge/twitter-%40uikenan-red.svg)](http://twitter.com/uikenan)
[![contact](https://img.shields.io/badge/contact-www-orange.svg)](http://kenanatmaca.com)

## Advantages
- [X] Simply use.
- [X] Beautiful animated.
- [X] Less code.
- [X] Designable.

<p align="center">
  <img src="https://user-images.githubusercontent.com/16580898/28749159-134aec90-74c7-11e7-831b-f7204ee5aa4c.png">
</p>

## Use

```Swift
    TSlider.images = [c1,c2,c3]
    TSlider.titles = ["1.picture","2.picture","3.picture"]
        
        TSlider.skip = {
            // code
            print("close")
        }
    
    TSlider.add(to: self.view)
        
    TSlider.mode = .dark
    TSlider.duration = 0.5
    TSlider.animation = .blur
```

#### Animates & Themes

```Swift
    // Animates
    
    .none
    .top
    .swipe
    .blur
```

```Swift
    // Themes
    
    .white
    .gray
    .black
```

### License
Usage is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for the full details.
