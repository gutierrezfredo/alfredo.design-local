---
layout: post
title: "My alternative solution for reverting the mouse zooming scroll direction when switching between Figma and Adobe XD"
microblog: false
guid: http://alfredo.micro.blog/2022/05/01/my-alternative-solution-for-reverting.html
post_id: 5682170
custom_summary: false
summary: ""
date: 2022-05-01T10:09:00-0600
lastmod: 2025-12-28T15:57:59-0600
type: post
categories:
- "blogs"
thumbnail: https://s3.amazonaws.com/micro.blog/thumbnails/2025/12/27/alfredo.design/9e8fb73d90df97db0cc7e34a42b50a8b.png
opengraph:
  title: "Alfredo - My alternative solution for reverting the mouse zooming scroll direction when switching between Figma and Adobe XD"
  image: https://s3.amazonaws.com/micro.blog/opengraph/2025/12/26/5682170.png
images:
- https://alfredo.design/uploads/2025/final-1030x681.jpg
- https://alfredo.design/uploads/2025/webp.net-resizeimage-opt.png
photos:
- https://alfredo.design/uploads/2025/final-1030x681.jpg
photos_with_metadata:
- url: https://alfredo.design/uploads/2025/final-1030x681.jpg
  width: 0
  height: 0
url: "/2022/05/01/my-alternative-solution-for-reverting.html"
---

![final-1030x681.jpg](https://alfredo.design/uploads/2025/final-1030x681.jpg)

I use Adobe XD regularly for my full-time job, while Figma is my go-to for personal projects. Consequently, I’m eternally oscillating between these two apps on a daily basis.

Having spent the whole day on Adobe XD, transitioning to Figma is somewhat peculiar due to the contrasting scrolling direction for zoom-in and zoom-out operations. Although neither direction seems inherently correct or incorrect, for some reason, Figma’s method appears more intuitive to me.

However, after a [much extensive search](https://community.adobe.com/t5/adobe-xd-discussions/mouse-zooming-scroll-direction-is-reversed/td-p/11513112) for a solution, it was disheartening to discover that neither of the applications offers the option to customize the zoom scrolling direction. The sole work-around I could find was to alternately enable or disable the scrolling direction on my Mac.

![Webp.net-resizeimage_opt.png](https://alfredo.design/uploads/2025/webp.net-resizeimage-opt.png)

But going to “Preferences > Mouse settings” every time I needed to make the switch was a tedious process.

While wishing there was a quicker way to switch the mouse scrolling direction on my mac, I did some research and I found a tool called: [UnnaturalScrollWheels](https://github.com/ther0n/UnnaturalScrollWheels) which exists as a solution for those who want to set the natural scrolling direction on the trackpad while maintaining the regular scrolling direction on the mouse. (Because for some reason, when toggling the “Scroll direction: Natural” option on a mac, it also changes the Trackpad scrolling direction).

With this tool installed, now I simply click the icon on the menu bar > Preferences and check or uncheck the invert vertical scrolling every time I switch from AdobeXD to Figma.

I hope this is found useful for those UX designers, who like me, are constantly using both apps.
