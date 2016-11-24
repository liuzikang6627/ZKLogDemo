# ZKLogDemo
真机调试打印log日志-ZKLog

博客:http://blog.sina.com.cn/s/blog_752f11650102wgrl.html

最近跟风升级到了Xcode8，然后大家都发现了——真机调试NSLog不再会往编译器上打印log了<br>
有很多人脑洞大开，比如封装了一个c里的`printf函数`的方法，又比如直接用HUD打印出来等。可是我想说，麻烦死了，不如直接打印到真机的屏幕上吧<br>
于是就出现了现在这个库<br>

使用只需要一句
```Object-C
[ZKLog log:@"%@：Hello world!", @"me"];
```

代码：https://github.com/liuzikang6627/ZKLogDemo <br>
ps：这个库依附在当前的主窗口上的，请初始化好窗口以后使用；

有图有真相：（里面数据均是测试用的假数据）<br>
![](http://s12.sinaimg.cn/mw690/00293dkxzy76FiFk2E3ab&690)
