import router from '@ohos.router'
@Entry
@Component
export struct Work {
  @Builder buildTop() {
    Row() {
      Text("我的办公")
        .fontSize('30sp')
        .fontColor(Color.White)
        .fontWeight(800)
      Row() {
        Column() {
          Text("8℃")
            .fontColor(Color.White)
            .fontWeight(800)
          Text("12月8日")
            .fontColor(Color.White)
            .margin({ top: 5 })
        }
        Image($rawfile("work/weather.png"))
          .height(50)
          .width(50)
      }
    }
    .padding({ left: 20, right: 20, bottom: 10 })
    .height('100vp')
    .width('100%')
    .alignItems(VerticalAlign.Bottom)
    .justifyContent(FlexAlign.SpaceBetween)
    .borderColor({ bottom: '#6a6cb2' })
    .borderWidth({ bottom: 1 })
    .backgroundColor('#4749a1')
  }
  @Builder buildTip() {
    Row() {
      Column() {
        Text('待审批')
          .fontSize(16)
          .fontColor('#8888cd')
        Text('15')
          .fontSize(26)
          .fontColor(Color.White)
          .fontWeight(800)
          .margin({ top: 15 })
      }
      Column() {
        Text('会议提醒')
          .fontSize(16)
          .fontColor('#8888cd')
        Text('2')
          .fontSize(26)
          .fontColor(Color.White)
          .fontWeight(800)
          .margin({ top: 15 })
      }
      Column() {
        Text('周报')
          .fontSize(16)
          .fontColor('#8888cd')
        Text('1')
          .fontSize(26)
          .fontColor(Color.White)
          .fontWeight(800)
          .margin({ top: 15 })
      }
      Column() {
        Text('工作汇报')
          .fontSize(16)
          .fontColor('#8888cd')
        Text('5')
          .fontSize(26)
          .fontColor(Color.White)
          .fontWeight(800)
          .margin({ top: 15 })
      }
    }
    .padding({
      top: 30
    })
    .alignItems(VerticalAlign.Top)
    .justifyContent(FlexAlign.SpaceEvenly)
    .backgroundColor('#4749a1')
    .height(200)
    .width('100%')
  }
  // 构建App每一项
  @Builder buildAppItem(image: ResourceStr, text: string, url?: string) {
    Column() {
      Image(image)
        .width(50)
        .height(50)
      Text(text)
        .margin({
          top: 10
        })
    }
    .width('25%')
    .margin({
      bottom: 20
    })
    .onClick(() => {

      if (url) {
        router.pushUrl({
          url: url
        })
      }
    })
  }
  // 构建App容器（使用Grid组件）
@Builder buildAppContainer() {
  Grid() {
    GridItem() {
      this.buildAppItem($rawfile("work/process.png"), "请假申请")
    }
    GridItem() {
      this.buildAppItem($rawfile("work/clock.png"), "考勤打卡")
    }
    GridItem() {
      this.buildAppItem($rawfile("work/report.png"), "汇报")
    }
    GridItem() {
      this.buildAppItem($rawfile("work/approve.png"), "OA审批")
    }
    GridItem() {
      this.buildAppItem($rawfile("work/card.png"), "补卡申请")
    }
    GridItem() {
      this.buildAppItem($rawfile("work/salary.png"), "工资单")
    }
    GridItem() {
      this.buildAppItem($rawfile("work/notice.png"), "公司公告")
    }
    GridItem() {
      this.buildAppItem($rawfile("work/rule.png"), "规章制度")
    }
  }
  .rowsGap(20)
  .columnsTemplate("1fr 1fr 1fr 1fr")
  .padding({
  top: 20,
  bottom: 20
})
}
// 构建App容器（使用Flex组件）
@Builder buildAppContainer2() {
  Flex({ wrap: FlexWrap.Wrap, alignContent: FlexAlign.SpaceBetween }) {
    this.buildAppItem($rawfile("work/process.png"), "请假申请")
    this.buildAppItem($rawfile("work/clock.png"), "考勤打卡")
    this.buildAppItem($rawfile("work/report.png"), "汇报")
    this.buildAppItem($rawfile("work/approve.png"), "OA审批")
    this.buildAppItem($rawfile("work/card.png"), "补卡申请")
    this.buildAppItem($rawfile("work/salary.png"), "工资单", "pages/Salary/Salary")
    this.buildAppItem($rawfile("work/notice.png"), "公司公告", "pages/Notice/Notice")
    this.buildAppItem($rawfile("work/rule.png"), "规章制度", "pages/Rule/Rule")
  }
  .padding({
    left: 15,
    right: 15,
    top: 20,
    bottom: 20
  })
}
@Builder buildAppManagement() {
  Column() {
    Row() {
      Row() {
        Image($rawfile("work/menu.png"))
          .width(26)
          .height(26)
        Text("应用管理")
          .margin({ left: 5 })
          .fontSize(20)
          .fontWeight(600)
          .fontColor('#101010')
      }
      Row() {
        Text("自定义")
          .fontColor('#7f6666')
          .fontSize(16)
        Image($rawfile("my/leave.png"))
          .width(20)
          .height(20)
      }
    }
    .padding({ left: 10, right: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
    .height(60)
    .width('100%')
    .borderColor({ bottom: '#efefef' })
    .borderWidth({ bottom: 1 })
    // this.buildAppContainer()
    this.buildAppContainer2()
  }
  .height(280)
  .width('94%')
  .backgroundColor(Color.White)
  .borderRadius(10)
  .offset({ y: -180 })
}
@Builder buildApplyFor() {
  Column() {
    Row() {
      Row() {
        Image($rawfile("work/badge.png"))
          .width(22)
          .height(22)
        Text("我的申请")
          .margin({ left: 5 })
          .fontSize(20)
          .fontWeight(600)
          .fontColor('#101010')
      }
      Row() {
        Text("更多")
          .fontColor('#7f6666')
          .fontSize(16)
        Image($rawfile("my/leave.png"))
          .width(20)
          .height(20)
      }
      .onClick(()=>{

      })
    }
    .padding({ left: 10, right: 10 })
    .justifyContent(FlexAlign.SpaceBetween)
    .height(60)
    .width('100%')
    Row() {
      Row() {
        Text()
          .width(20)
          .height(20)
          .borderRadius(10)
          .backgroundColor('#4749a1')
          .margin({ top: 33 })
      }
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width(40)
      Column() {
        Text("请假申请")
          .fontSize(20)
          .fontWeight(600)
        Text("2025/11/23 至 2025/11/24 共2天")
        Row() {
          Text('申请时间：2020-11-22 16:50')
          Text("待审批").fontColor('#ff935d')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ right: 20 })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceEvenly)
      .layoutWeight(1)
      .height(130)
    }
    .width('100%')
    .height(160)
    .borderColor({ top: '#efefef' })
    .borderWidth({ top: 1 })
    Row() {
      Row() {
      Text()
        .width(20)
        .height(20)
        .borderRadius(10)
        .backgroundColor('#4749a1')
        .margin({ top: 33 })
    }
    .alignItems(VerticalAlign.Top)
    .justifyContent(FlexAlign.Center)
    .height('100%')
    .width(40)
      Column() {
        Text("请假申请")
          .fontSize(20)
          .fontWeight(600)
        Text("2020/11/23 至 2020/11/24 共2天")
        Row() {
          Text('申请时间：2020-11-22 16:50')
          Text("正在审批中")
            .fontColor('#53cbae')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ right: 20 })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceEvenly)
      .layoutWeight(1)
      .height(130)
    }
    .width('100%')
    .height(160)
    .borderColor({ top: '#efefef' })
    .borderWidth({ top: 1 })
  }
  .margin({
    top: -145,
    bottom: 15
  })
  .width('94%')
  .backgroundColor(Color.White)
  .borderRadius(10)
}
build() {
  Stack({ alignContent: Alignment.TopStart }) {
    // 构建头部
    this.buildTop()
    List() {
      // 提示信息
      this.buildTip()
      // 应用管理
      this.buildAppManagement()
      // 我的申请6.2、办公模块中我的申请
      this.buildApplyFor()
    }
    .alignListItem(ListItemAlign.Center)
    .width('100%')
    .height('100%')
    .padding({
      top: 100
    })
  }
  .width('100%')
  .height('100%')
  .backgroundColor('#f5f5f5')
}
}