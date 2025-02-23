/**
 * Copyright 2015 @ at3.net.
 * name : client.go
 * author : jarryliu
 * date : 2016-11-13 12:32
 * description :
 * history :
 */
package thrift

import (
	"github.com/apache/thrift/lib/go/thrift"
	"go2o/core/service/auto_gen/rpc/finance_service"
	"go2o/core/service/auto_gen/rpc/foundation_service"
	"go2o/core/service/auto_gen/rpc/item_service"
	"go2o/core/service/auto_gen/rpc/mch_service"
	"go2o/core/service/auto_gen/rpc/member_service"
	"go2o/core/service/auto_gen/rpc/message_service"
	"go2o/core/service/auto_gen/rpc/order_service"
	"go2o/core/service/auto_gen/rpc/payment_service"
	"go2o/core/service/auto_gen/rpc/shipment_service"
	"go2o/core/service/auto_gen/rpc/shop_service"
	"go2o/core/service/auto_gen/rpc/status_service"
	"go2o/core/service/auto_gen/rpc/wallet_service"
	"log"
	"os"
	"time"
)

var (
	factory *ClientFactory
)

func init() {
	factory = NewClientFactory("localhost:1427", false, "", "")
}

// 设置Thrift地址
func Configure(server string) *ClientFactory {
	if server == "" {
		server = factory.thriftServer
	}
	log.Println("[ Go2o][ RPC]: connecting go2o rpc server...")
	factory = NewClientFactory(server, false, "", "")
	var retryTimes = 10
	for i := 0; i < retryTimes; i++ {
		trans, _, err := StatusServeClient()
		if err == nil {
			trans.Close()
			break
		} else if i == retryTimes-1 {
			log.Println("[ Go2o][ RPC]: can't connect go2o rpc server! ", err.Error())
			os.Exit(1)
		}
		time.Sleep(time.Second * 2)
	}
	return factory
}

// 状态客户端
func StatusServeClient() (thrift.TTransport, *status_service.StatusServiceClient, error) {
	trans, cli, err := factory.GetClient("merchant")
	return trans, status_service.NewStatusServiceClient(cli), err
}

// 商户客户端
func MerchantServeClient() (thrift.TTransport, *mch_service.MerchantServiceClient, error) {
	trans, cli, err := factory.GetClient("merchant")
	return trans, mch_service.NewMerchantServiceClient(cli), err
}

// 会员客户端
func MemberServeClient() (thrift.TTransport, *member_service.MemberServiceClient, error) {
	trans, cli, err := factory.GetClient("member")
	return trans, member_service.NewMemberServiceClient(cli), err
}

// 基础服务
func FoundationServeClient() (thrift.TTransport, *foundation_service.FoundationServiceClient, error) {
	trans, cli, err := factory.GetClient("foundation")
	return trans, foundation_service.NewFoundationServiceClient(cli), err
}

// 消息客户端
func MessageServeClient() (thrift.TTransport, *message_service.MessageServiceClient, error) {
	trans, cli, err := factory.GetClient("message")
	return trans, message_service.NewMessageServiceClient(cli), err
}

// 支付服务
func PaymentServeClient() (thrift.TTransport, *payment_service.PaymentServiceClient, error) {
	trans, cli, err := factory.GetClient("payment")
	return trans, payment_service.NewPaymentServiceClient(cli), err
}

// 钱包服务
func WalletClient() (thrift.TTransport, *wallet_service.WalletServiceClient, error) {
	trans, cli, err := factory.GetClient("wallet")
	return trans, wallet_service.NewWalletServiceClient(cli), err
}

// 订单服务
func OrderServeClient() (thrift.TTransport, *order_service.OrderServiceClient, error) {
	trans, cli, err := factory.GetClient("order")
	return trans, order_service.NewOrderServiceClient(cli), err
}

// 物流服务
func ShipmentServeClient() (thrift.TTransport, *shipment_service.ShipmentServiceClient, error) {
	trans, cli, err := factory.GetClient("shipment")
	return trans, shipment_service.NewShipmentServiceClient(cli), err
}

// 商品服务
func ItemServeClient() (thrift.TTransport, *item_service.ItemServiceClient, error) {
	trans, cli, err := factory.GetClient("item")
	return trans, item_service.NewItemServiceClient(cli), err
}

// 商店服务
func ShopServeClient() (thrift.TTransport, *shop_service.ShopServiceClient, error) {
	trans, cli, err := factory.GetClient("shop")
	return trans, shop_service.NewShopServiceClient(cli), err
}

// 财务服务
func FinanceServeClient() (thrift.TTransport, *finance_service.FinanceServiceClient, error) {
	trans, cli, err := factory.GetClient("finance")
	return trans, finance_service.NewFinanceServiceClient(cli), err
}
