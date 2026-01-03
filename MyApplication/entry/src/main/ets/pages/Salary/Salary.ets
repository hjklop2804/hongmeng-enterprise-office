import router from '@ohos.router'

// 1. 定义薪资明细项的类
class SalaryDetail {
  label: string
  value: string
  type: string // 'income' | 'expense'

  constructor(label: string, value: string, type: string) {
    this.label = label
    this.value = value
    this.type = type
  }
}

// 2. 定义工资单数据的类
class SalaryModel {
  month: string
  realPay: number
  details: SalaryDetail[]

  constructor(month: string, realPay: number, details: SalaryDetail[]) {
    this.month = month
    this.realPay = realPay
    this.details = details
  }
}

@Entry
@Component
struct Salary {
  // 3. 使用明确的 SalaryModel 类型，并使用构造函数初始化数据
  @State salaryData: SalaryModel = new SalaryModel(
    '2025年11月',
    13200.00,
    [
      new SalaryDetail('基本工资', '10000.00', 'income'),
      new SalaryDetail('岗位绩效', '3000.00', 'income'),
      new SalaryDetail('交通补贴', '500.00', 'income'),
      new SalaryDetail('社保个人部分', '-800.00', 'expense'),
      new SalaryDetail('公积金个人部分', '-500.00', 'expense'),
      new SalaryDetail('个人所得税', '-200.00', 'expense')
    ]
  )

  build() {
    Column() {
      // 1. 顶部导航栏
      Row() {
        Image($rawfile("common/back.png"))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text("工资单详情")
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

      // 2. 头部总金额卡片
      Column() {
        Text(this.salaryData.month)
          .fontSize(16)
          .fontColor(Color.White)
          .opacity(0.8)
        Text(this.salaryData.realPay.toFixed(2))
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 10 })
        Text("实发工资 (元)")
          .fontSize(14)
          .fontColor(Color.White)
          .opacity(0.8)
          .margin({ top: 5 })
      }
      .width('100%')
      .height(180)
      .backgroundColor('#4749a1')
      .justifyContent(FlexAlign.Center)

      // 3. 薪资明细列表
      List() {
        // 4. 这里的 item 类型明确为 SalaryDetail
        ForEach(this.salaryData.details, (item: SalaryDetail) => {
          ListItem() {
            Row() {
              Text(item.label)
                .fontSize(16)
                .fontColor('#333333')
              Text(item.value)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                // 判断类型设置颜色
                .fontColor(item.type === 'income' ? '#e64545' : '#1e9c1e')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({ left: 20, right: 20, top: 15, bottom: 15 })
            .backgroundColor(Color.White)
            .border({ width: { bottom: 1 }, color: '#f0f0f0' })
          }
        })
      }
      .width('94%')
      .layoutWeight(1)
      .margin({ top: -30 })
      .borderRadius(10)
      .backgroundColor(Color.White)
      .shadow({ radius: 10, color: '#1a000000', offsetY: 5 })

      // 底部提示
      Text("如有疑问，请联系人力资源部")
        .fontSize(12)
        .fontColor('#999999')
        .margin({ bottom: 20, top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}