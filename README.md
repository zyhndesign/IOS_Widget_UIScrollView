IOS_Widget_UIScrollView
=======================
this project reveal a UIScrollView which save memory in runtime. in some requirement, we will scroll view page by page.
but if every page have many images which is big. so if app have many many page ,the app will crash in runtime.because one 
app limited by about 30M memeory on ios plantform.
in the projrct we will maintain a hashtable of three capacity.at any time , the scrollView only have three subview, the 
current view ,former view and behind view.when roll the scroll view, judge the hashtable . below show:

i - 2, i - 1, i, i + 1, i + 2

i is current page, i plus one and i minus one will in the scrollView, i plus two and i minus two is remove from scroll view,
i, i plus 1, i minus 1 is add in hashtable.

========================

then we will add asynchronous loading image from network or local storage.
add animation when flip over page

========================
