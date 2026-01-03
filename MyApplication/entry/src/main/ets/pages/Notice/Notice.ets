import router from '@ohos.router'

// 1. 定义公告数据模型
class NoticeModel {
  id: number
  title: string
  publisher: string
  date: string
  type: string // 'urgent' | 'normal' | 'new'

  constructor(id: number, title: string, publisher: string, date: string, type: string) {
    this.id = id
    this.title = title
    this.publisher = publisher
    this.date = date
    this.type = type
  }
}

@Entry
@Component
struct Notice {
  // 2. 模拟公告数据
  @State noticeList: NoticeModel[] = [
    new NoticeModel(1, '关于2025年春节放假安排的通知', '行政部', '2025-01-15', 'urgent'),
    new NoticeModel(2, '2024年度优秀员工评选结果公示', '人力资源部', '2025-01-10', 'new'),
    new NoticeModel(3, '关于开展年度绩效考核的通知', '人力资源部', '2024-12-28', 'normal'),
    new NoticeModel(4, '园区食堂用餐时间调整通知', '后勤部', '2024-12-20', 'normal'),
    new NoticeModel(5, '新员工入职培训安排（12月期）', '培训中心', '2024-12-05', 'normal'),
    new NoticeModel(6, '关于加强冬季办公区域防火安全的提示', '安保部', '2024-11-30', 'normal')
  ]

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
        Text("公司公告")
          .fontSize(20)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin({ right: 24 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#4749a1') // 保持统一的主题色
      .padding({ left: 15, right: 15 })
      .alignItems(VerticalAlign.Center)

      // --- 公告列表 ---
      List({ space: 10 }) {
        ForEach(this.noticeList, (item: NoticeModel) => {
          ListItem() {
            Column() {
              Row() {
                // 标题和标签
                if (item.type === 'urgent') {
                  Text("紧急")
                    .fontSize(10)
                    .fontColor(Color.White)
                    .backgroundColor('#e64545')
                    .padding({ left: 5, right: 5, top: 2, bottom: 2 })
                    .borderRadius(3)
                    .margin({ right: 8 })
                } else if (item.type === 'new') {
                  Text("最新")
                    .fontSize(10)
                    .fontColor(Color.White)
                    .backgroundColor('#4749a1')
                    .padding({ left: 5, right: 5, top: 2, bottom: 2 })
                    .borderRadius(3)
                    .margin({ right: 8 })
                }

                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')
                  .layoutWeight(1)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // 底部信息：发布部门 + 时间
              Row() {
                Text(item.publisher)
                  .fontSize(12)
                  .fontColor('#999999')
                Text(item.date)
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 8 })
            }
            .padding(15)
            .backgroundColor(Color.White)
            .borderRadius(8)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 15, right: 15, top: 15, bottom: 15 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}