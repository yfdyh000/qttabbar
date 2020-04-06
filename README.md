# 软件介绍
QTTabBar是一款可以让你在Windows资源管理器中使用Tab多标签功能的小工具。从此以后工作时不再遍布文件夹窗口，还有给力的文件夹预览功能，大大提高了你工作的效率。就像IE 7和Firefox、Opera那样的。QTTabBar还提供了一些功能插件，如：文件操作工具、树型目录、显示状态栏等等。
https://indiff.github.io/qttabbar/

# 版本更新
- 1.4(2020) 调整版本信息，修复热键冲突问题；实现创建空文件；默认自动加载两个插件
- 1.3 更新插件实现去重，排序功能

# 下载地址
* https://github.com/indiff/qttabbar/releases/tag/1.4

# 使用方法
- 运行安装包文件，安装QTTabBar 
- 资源管理器->查看->选项->(QTTabbar & Buttons )      【win10】
- 资源管理器中，组织—>布局—>菜单栏  【win10以下】
- 右键菜单栏右方的空白地区—>勾选QTTabBar等工具栏—>按Alt+M—>重启explorer或重启计算机
![图片](https://user-images.githubusercontent.com/501276/72576075-907fb980-3909-11ea-9dc2-9a1ea0ca2f8e.png)


# 编译
* 打开 https://wixtoolset.org/releases/ 下载安装 wix 本体和所需版本的 Visual Studio 扩展
* 安装 visual studio 2010   https://pan.baidu.com/s/1sldAQmD#list/path=%2FVS%E4%BE%BF%E6%90%BA%E7%B2%BE%E7%AE%80%E7%89%88%E5%90%88%E9%9B%86
* 拉取代码安装插件 NotifyPropertyWeaverVsPackage.vsix
* Qttabbar项目 添加引用 Ricciolo.Controls.TreeListView, 路径 QTTabBar\Resources\Ricciolo.Controls.TreeListView.dll

# 多图预览

* https://github.com/indiff/qttabbar/issues/3
