import router from '@ohos.router'

// 1. 定义规章制度数据模型
class RuleModel {
  id: number
  title: string
  category: string // '行政' | '人事' | '财务' | '其他'
  date: string
  readCount: number

  constructor(id: number, title: string, category: string, date: string, readCount: number) {
    this.id = id
    this.title = title
    this.category = category
    this.date = date
    this.readCount = readCount
  }
}

@Entry
@Component
struct Rule {
  // 2. 模拟制度数据
  @State allRules: RuleModel[] = [
    new RuleModel(1, '员工日常行为规范手册 (2025版)', '人事', '2025-01-01', 1205),
    new RuleModel(2, '公司差旅费报销管理制度', '财务', '2024-12-15', 890),
    new RuleModel(3, '办公用品申领及使用规定', '行政', '2024-11-20', 450),
    new RuleModel(4, '员工考勤与休假管理办法', '人事', '2024-10-01', 3200),
    new RuleModel(5, '信息安全与保密协议', '行政', '2024-09-10', 1500),
    new RuleModel(6, '固定资产管理办法', '财务', '2024-08-05', 300)
  ]

  // 当前选中的 Tab 索引
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()

  // 自定义 TabBar 样式
  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? '#4749a1' : '#666666')
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
      Divider()
        .strokeWidth(2)
        .color('#4749a1')
        .opacity(this.currentIndex === index ? 1 : 0)
        .width('40%')
        .margin({ top: 5 })
    }
    .width('100%')
  }

  // 渲染列表内容的方法
  @Builder RuleList(categoryFilter: string) {
    List({ space: 12 }) {
      ForEach(this.allRules.filter(item => categoryFilter === '全部' || item.category === categoryFilter), (item: RuleModel) => {
        ListItem() {
          Row() {
            // 左侧图标
            Image($rawfile("work/rule.png"))
              .width(40)
              .height(40)
              .padding(8)
              .backgroundColor('#f0f2f5')
              .borderRadius(8)
              .margin({ right: 15 })

            // 中间文本信息
            Column() {
              Text(item.title)
                .fontSize(16)
                .fontColor('#333333')
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .fontWeight(FontWeight.Medium)

              Row() {
                Text(item.category)
                  .fontSize(12)
                  .fontColor('#4749a1')
                  .backgroundColor('#eef0f4')
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  .borderRadius(4)
                  .margin({ right: 10 })

                Text(item.date)
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .margin({ top: 8 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            // 右侧箭头或阅读量
            Column() {
              Text(`${item.readCount} 阅读`)
                .fontSize(11)
                .fontColor('#bbbbbb')
            }
          }
          .width('100%')
          .padding(15)
          .backgroundColor(Color.White)
          .borderRadius(10)
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 15, right: 15, top: 15, bottom: 15 })
  }

  build() {
    Column() {
      // --- 顶部导航栏 ---
      Row() {
        Image($rawfile("common/back.png"))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text("规章制度")
          .fontSize(20)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin({ right: 24 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#4749a1')
      .padding({ left: 15, right: 15 })
      .alignItems(VerticalAlign.Center)

      // --- 分类标签页 ---
      // [修复] 这里将 BarPosition.Top 修改为 BarPosition.Start
      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        TabContent() {
          this.RuleList('全部')
        }.tabBar(this.TabBuilder(0, '全部'))

        TabContent() {
          this.RuleList('行政')
        }.tabBar(this.TabBuilder(1, '行政'))

        TabContent() {
          this.RuleList('人事')
        }.tabBar(this.TabBuilder(2, '人事'))

        TabContent() {
          this.RuleList('财务')
        }.tabBar(this.TabBuilder(3, '财务'))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth('100%')
      .barHeight(50)
      .animationDuration(300)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}