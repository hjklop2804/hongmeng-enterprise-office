import router from '@ohos.router'
@Entry
@Component
struct Index {
  @State time: number = 3
  timer: number = -1
  aboutToAppear() {
    this.timer = setInterval(() => {
      if (this.time == 1) {
        this.enter()
        return
      }
      this.time--
    }, 1000)
  }
  aboutToDisappear() {
    clearInterval(this.timer)
  }
  enter() {
    router.replaceUrl({
      url: "pages/Login/Login"
    })
  }
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Stack({ alignContent: Alignment.TopEnd }) {
        Image($rawfile("index/launch-screen.png"))
        Row() {
          Text(`${this.time}`)
            .textAlign(TextAlign.Center)
            .fontColor(Color.Gray)
            .fontSize(30)
            .width('100%')
        }
        .width(50)
        .height(50)
        .borderRadius(50)
        .margin({
          right: 15,
          top: 15
        })
        .backgroundColor(Color.White)
      }
      Button() {
      }
      .onClick(() => {
        this.enter()
      })
      .width(200)
      .height(50)
      .margin({
        bottom: 88
      })
      .backgroundColor(Color.Transparent)
    }
    .height('100%')
  }
}