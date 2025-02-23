namespace java com.github.jsix.go2o.rpc
namespace csharp com.github.jsix.go2o.rpc
namespace go go2o.core.service.auto_gen.rpc.order_service
include "ttype.thrift"


// 销售服务
service OrderService {
    // 批发购物车接口
    ttype.Result WholesaleCartV1(1:i64 memberId,2:string action,3:map<string,string> data)
    // 普通购物车接口
    ttype.Result NormalCartV1(1:i64 memberId,2:string action,3:map<string,string> data)
    // 提交订单
    map<string,string> SubmitOrderV1(1:i64 buyerId,2:i32 cartType,3:map<string,string> data)
    // 获取订单信息
    SComplexOrder GetOrder(1:string order_no,2:bool sub_order)
    // 获取订单和商品项信息
    SComplexOrder GetOrderAndItems(1:string order_no,2:bool sub_order)
    // 获取子订单
    SComplexOrder GetSubOrder(1:i64 id)
    // 根据订单号获取子订单
    SComplexOrder GetSubOrderByNo(1:string orderNo)
    // 获取订单商品项
    list<SComplexItem> GetSubOrderItems(1:i64 subOrderId)

    // 提交交易订单
    ttype.Result SubmitTradeOrder(1:SComplexOrder o,2:double rate)
    // 交易单现金支付
    ttype.Result TradeOrderCashPay(1:i64 orderId)
    // 上传交易单发票
    ttype.Result TradeOrderUpdateTicket(1:i64 orderId,2:string img)
}


/** 订单状态 */
enum EOrderState{
	/****** 在履行前,订单可以取消申请退款  ******/
	/** 等待支付 */
	StatAwaitingPayment = 1
	/** 等待确认 */
	StatAwaitingConfirm = 2
	/** 等待备货 */
	StatAwaitingPickup = 3
	/** 等待发货 */
	StatAwaitingShipment = 4

	/****** 订单取消 ******/

	/** 系统取消 */
	StatCancelled = 11
	/** 买家申请取消,等待卖家确认 */
	StatAwaitingCancel = 12
	/** 卖家谢绝订单,由于无货等原因 */
	StatDeclined = 13
	/** 已退款,完成取消 */
	StatRefunded = 14

	/****** 履行后订单只能退货或换货 ******/

	/** 部分发货(将订单商品分多个包裹发货) */
	PartiallyShipped = 5
	/** 完成发货 */
	StatShipped = 6
	/** 订单已拆分 */
	StatBreak = 7
	/** 订单完成 */
	StatCompleted = 8

	/****** 售后状态 ******/

	/** 已退货 */
	StatGoodsRefunded = 15
}

// 订单项
struct SComplexItem {
    1: i64 ID
    2: i64 OrderId
    3: i64 ItemId
    4: i64 SkuId
    5: i64 SnapshotId
    6: i32 Quantity
    7: i32 ReturnQuantity
    8: double Amount
    9: double FinalAmount
    10: i32 IsShipped
    11: map<string,string> Data
}

// 子订单
struct SComplexOrder {
    1: i64 OrderId
    2: i64 SubOrderId
    3: i32 OrderType
    4: string OrderNo
    5: i64 BuyerId
    6: i32 VendorId
    7: i32 ShopId
    8: string Subject
    9: double ItemAmount
    10: double DiscountAmount
    11: double ExpressFee
    12: double PackageFee
    13: double FinalAmount
    14: string ConsigneePerson
    15: string ConsigneePhone
    16: string ShippingAddress
    17: string BuyerComment
    18: i32 IsBreak
    19: i32 State
    20: i64 CreateTime
    21: i64 UpdateTime
    22: list<SComplexItem> Items
    // 扩展信息
    23: map<string,string> Data
    // 是否为子订单
    24:bool SubOrder
}
