Return-Path: <linux-kernel+bounces-829638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A9CB97835
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7F84A527B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0930B505;
	Tue, 23 Sep 2025 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YmPYIiXU"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42342065;
	Tue, 23 Sep 2025 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660100; cv=fail; b=X/FG2fKP9GXFzcaC9Z6Jvaf+Ts1keGV0S6oeOtpluEb2fncw+gVhmduz+BNYMMrSxfmfixNvjrwNW9Fq0A/NonT52h5gya0NQaoeqAaNve/GLoCK5Jbzr7AcJUI/ny/JFTGKx15QYIjBB2HjXrjyGfonKQ/37/EbcXSQQVp8d88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660100; c=relaxed/simple;
	bh=i/lP8n7xlUYnNWYeP6k2LK3PqVsc30rgOXW51BDTkAI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=I8D+zrkO0A6/zlEZwDdXb027XjTXpjmsHnikf0mYCB12cJ4506FM0SR/qEahZMAchXhyKAdltNk4bO+S8FfgbdnRWERpBnrW8/sdbkims/mVVHSgSo4AbxfoEaLLCUe9wI9/3COb6B5fqMj9XK6zbLJ6834oWMDbK5qUKpKPQ40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YmPYIiXU; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDaOTxvGZAKU9iTqKFsvhzTl5CnpMkc7O3jetgrmwlru2VfPH/VwbFP5Q5OmL9nyXMzEPCmxYGqWWBbi17szNb4s4S8atSaS4dBEOsWfzHUJAXjeGmLiTmcBITBV1wJBFzpqwuedLbmUucKumJawH41krqiqXpcVrvEU92EFcpqQ8FwWEAWe2eM8V/R5s2o2LcQmP7ny4epUOSpOT9oLImdqDWhwL/wNJFoHyXw3xRdARyA29spttAGWP6TuXg4W8quGxN7P2nxzZ/v1G3Qge6Sdc2XJcEZ6Z+NgJL6j7GW8STy+s3vXvSlJ5r5SBxTVLbVnuB4LulA/rWUB2Vqc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRs1jWFJgGX6nvGFelSdanF8HoBXRM7c+L+zg4sNzrY=;
 b=cU3IzbgSnXqZq/hpUk+vm4xARMNP1A4Ulv75pbet5+pxFlutfmyYpaQVUXjZ+CCe75rlbm1f5HCbUmMsfFh0d0pZo6Ajif1H8O5xgknLNXLjKu7wAH84868fi3lvd1Es8x3mFCSj5szIElcfAwgrTqtY7qFW3MbtI6OCsUXH5AYhjRlOmu+b7O+VoxIGS6WTJ87Q4EFFDzj7ZcAWS5/j9q9Tmfonth6Bc6vPpgDYLhkwecwHWAa0xTgsyS776DEWuy6t0M+rJUqnOK4ldg6OZA6r0CbJxbZGZS/8ePe/Nrv5SMlKs3FDsBfWQAKwqCf10X0CWjhgTt8KJCeBghHseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRs1jWFJgGX6nvGFelSdanF8HoBXRM7c+L+zg4sNzrY=;
 b=YmPYIiXUFKuWU0oVCg66zAn/7mb41Klz7tCEzRP8vuDCKS7iHgRNruCTYCiaspU4P70+GVMGpuXUUiyu1/XNfSG9j5eAqBfWJuOlKzO+PIMuR3TbGMBqEd9iUbtUjq9wRwsLBjKAtoX9u4M9565QI4GVdYddksZ3QCiz+qblsVxr6Qk2/Rga6eq7gzE298B/bBfecmwPmoUj8NwzHebsVLGwyt6NatKlnp7Tz8rnb2w+m0Wk0/aXBmUcY27IAaA3posxq80b9necRyoLkCNGY1pQWhYALmiSXMItwK9Bqxbp0mS4V9oCJ5VTwsIa1heKCoYqYov30qU82RwECP5ldg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 20:41:35 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 20:41:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Michal Simek <michal.simek@amd.com>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	Wensheng Wang <wenswang@yeah.net>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kever Yang <kever.yang@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [2nd RESENT v3 1/1] dt-bindings: trivial-devices: Add compatible string synaptics,synaptics_i2c
Date: Tue, 23 Sep 2025 16:41:18 -0400
Message-Id: <20250923204120.197796-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::9) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM8PR04MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 297c5a7b-5a02-4658-a53f-08ddfae19627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cmrj2U6le1lZWTsEGJO6Ob4r3ZNYaESHpCcAAKWemigBSA5pgoRKiIF72gVO?=
 =?us-ascii?Q?ztRtaxEtC1+eRhLvwtxEBoVCxJ6g2Y4MKbs+TrFyqWYW/6OvEpIRHoHnLhzw?=
 =?us-ascii?Q?3q10kgScsGbID9KpOblMHuTgwbjloXV06G8BnCYsg1Hg+3fV+W1C9a/QLM/5?=
 =?us-ascii?Q?yjZlxWPkOiq5UPo79J0HHA0Sr671QD5ZgHdRdf0119m3Qjhya132HiC7n51a?=
 =?us-ascii?Q?KTlDYMPb/6+dE7vgnZkPBpbsZAOP9MMyZwywJ/LRw+K5VvXXHWv9vkGecV4T?=
 =?us-ascii?Q?AGZqLDmAFzUC1N7F/d/K1hpd50WXgVFrDcmviz6pmEHi7jAXaiv2qPRoHLZs?=
 =?us-ascii?Q?apJLXyrrbVweCrUds9K8705Z1u7MKYwxOwFdiN8hMV1HRRSz8f6qtKWmdgt5?=
 =?us-ascii?Q?YtUl58QlSr0l9BRCMAsRVUxc/RQYKfmR4MWS2+MkOdebyGHDdJ8+5K4xI9FS?=
 =?us-ascii?Q?JLGTsZ1dJ0m8rPJ1aikUgNf+eAbLPBgINhvyC/l+EtxBapjyuMSzTUxnfHpX?=
 =?us-ascii?Q?lQU1gsmihASTXjPL/mL1YNQaCswmKHYPmRr0mITNu/5WavdRg6PG45jvih/x?=
 =?us-ascii?Q?To0I2t2T3qc+Io9yv3oUclAc5flNOkMp4NdB9wpnDYs4hu4KiDnBVAdUnYB4?=
 =?us-ascii?Q?GiTvWrfRu9enIW8+g02SYjgX2oWTmAzjYaNsEQddRzY4EsFlDF1KhkppPEWS?=
 =?us-ascii?Q?aJDr+ABwhrGG2fR+COTQ3CgrxSt2xkSYj2uVLHub1Kx8z5mRTQYqpV8uKI6B?=
 =?us-ascii?Q?o39lG8SV+Z7Qt8o3fF82z05NQPLXZJ3vSuvcecPfjuL8hBaD734SueTtJ1nn?=
 =?us-ascii?Q?lns+9wrCUpSxqX1JmPWA+3LIk50rtWh6lfihBULX45EeT9F+EwoLaa2R8lO0?=
 =?us-ascii?Q?73A3rO7c4/u+OdIcYgNHhHnERfuEx2mVWoNdDQwq1yg+0VENAidfyMmW+iZg?=
 =?us-ascii?Q?xe6eRMBrf3DWHroFl/9ZTki8TFc3+31cl7FB+wxpaatsxXomvcIUXswbfDmU?=
 =?us-ascii?Q?nz1JdirrBbltOb898jz6lmjG7RVqyWLfdomaGdGJIved6X2gvwXr2b/1WxfL?=
 =?us-ascii?Q?3kbeFdLhyUzJTMh2SgOMM/52nBztU71/BpmE0OjkWQeF33Sn2WHXdUyD/KaU?=
 =?us-ascii?Q?fyfFx1X+BBXLx0AQN36D3fKH4YJLj4ymn5F3cTVmRNG4p2iJcUzy1qvKWmOh?=
 =?us-ascii?Q?usSgTgtBzC23+drAd5imxnZpRBCZ2bNyAS6GevbQRl/5n9Rf77v/KqwbX3mc?=
 =?us-ascii?Q?1o/ZmyZGoeVlDAcLQn5UomZOLFe9wooyW4c1/JNPo1GJPV9zYAuVgJtvpwCY?=
 =?us-ascii?Q?tRqVyrYqLymFifKuKF93zKjCZxYNQItRFmmtI/Zw7NcvjIQBoysIPycOp256?=
 =?us-ascii?Q?O75PT9FBsbqVwPCzjv3kdgoeITefXDyDl+h7TpGHdYIjkvrrnUa/EFK6MdIg?=
 =?us-ascii?Q?NP8zcFhfe8Xs4ZbWyfYdvMprR+9UZY7V2ACvTf1bEukS58LV0rEbcKpQ9dbG?=
 =?us-ascii?Q?4VvGyOFLXr+pkV4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0XCN3tr6Vm50ULWfx0IZ7PBGAh352rkOvCFcCZDbg5M5BzkbBWrUwcFbo49?=
 =?us-ascii?Q?8TH/mpjyM52sngvlxjsyb3zBaogS/Cz8265o4n+HsUsgyifdskaVclQcrM6k?=
 =?us-ascii?Q?f6IVIaVfTph7F4R/nLpcqlOx6PgBVa6yXqrLhobANWQcAkQQqIqJMB2xVM78?=
 =?us-ascii?Q?06O4IZSM5kyHcUSBIR7vHl/+GUktZdELE8irdBsYE07vQSMBhhkZuIVjV9dv?=
 =?us-ascii?Q?uE12V8Y/uTOaH1pkQlDSr5QCBYcI7uhJ0Eimtf/ictzEEQ3uAN7HurHDwjkr?=
 =?us-ascii?Q?IsPf7vtDrjC0bmOCtkDJWg9dx5iZ+kbCk1FUXULD68t+EIAHXga447QLV+x3?=
 =?us-ascii?Q?ijNacOf/G1yEFPHQX8jvT/m3mRZzYdbXqV/Zx/rPd5N3jB6xRHGZ75gR8vZr?=
 =?us-ascii?Q?NYZSva/m3xZpeXfbHbX7vqYcP/MWH51gzJo3lUhJmvjxZsECzsVE6yl7P8Ch?=
 =?us-ascii?Q?jA6kDf7FDJXe7RipCmMAu6zFc7Cx5/vKqWuerK/g+L0QG8ADF9G+A5hVNQP8?=
 =?us-ascii?Q?TZEHq/PnGQdf2x1o0XfnVS358TXQi8ocP3FT0PGJvwDIzRdFJTIcqPvOOoL3?=
 =?us-ascii?Q?c4Nw+GKLd+YQ33Md3QzH3NdxJr70Lbt+l5uKtaasY6JN5SvH0jgltP2y5Ib+?=
 =?us-ascii?Q?Z1L3qJMpS4Y2sxTOW5oJFM0gvqIE21IY4j3LLx669BsSw06cCdCEHVH/L1+K?=
 =?us-ascii?Q?jc5TcTGnVMcQsPhSG6/2QB6+MQ1OhBYtE1pgbVciSR0ZpD7jjBY76m5BjsHR?=
 =?us-ascii?Q?AP5yRHdpvA3zL9CJMs/rCzrRlrvN+xkOi12ibGkcxdHfZcHr6XV3SR2hXt2/?=
 =?us-ascii?Q?LBHzkUEhsGk4SQsuFO3AU1TGuaWwqsqozB+ybXtetGj3fuY4+DZ767R0Cqid?=
 =?us-ascii?Q?P1eurkFM1jjaYvLKfHJLNPWPR4UW+Al2740FS58KVgCDHQCVeZ3bx2M0VhJu?=
 =?us-ascii?Q?gSeBJaUzxZmoiCs0OUxfJKvHZYDYkyHTtPEnMM+U/5dePQ3dD/G17kqBG97a?=
 =?us-ascii?Q?Wv91XUaOHru2NhLIiUXUx2bgFYblKAZQvxod+tdi+sPJnCqdprEJXIOmkHHs?=
 =?us-ascii?Q?GXJno9KCbX7Irl/WuZZBhvfhcIlgujwuf8cDG0d7b3eIZYoOnEzKsbJoktXY?=
 =?us-ascii?Q?TAFpdsGQ0xgaOlcwqGXC5gDeLvJMFxoa2E5pg0WtGmnw1lMuyqCDGVMf1mFj?=
 =?us-ascii?Q?xc3v6Q/2HGKuU0MEHlc7BLymdxY/uPyfnQp5b6UNve7wlfKdEMSu09rJXlBY?=
 =?us-ascii?Q?INKLSBkXI8EHZo7Qfl/jbbJvsolgCaKoXtLpvTascLXkeYOXExrkgiKc4XK4?=
 =?us-ascii?Q?VC60YW4mNgGeByNgccLd4vUL66Bb/J3x33p8GZ4aTShKQWV3lqRXVuM/yzvS?=
 =?us-ascii?Q?OarxTzonhsCrrYcBGQSmFsY2LhpE5iuxXYgKoOiV5a3IaT4+iBCMPYFQScb1?=
 =?us-ascii?Q?Ak1BcLJrFyofpkM/vQrMCx96w2M4b3mEljhtJktaeRAC/+4MI70zvioTx3MV?=
 =?us-ascii?Q?kd0ZUC7y7OxrmaQCW1cmz+O6B2m/rpfdAAUb2NtZuWqXOZax0hGMm34mN04b?=
 =?us-ascii?Q?eeuosHYfjkMmm2SIlv3+0K0ePh/lF/WACHjsFu8O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297c5a7b-5a02-4658-a53f-08ddfae19627
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 20:41:35.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiNC8lFHVtcegQRyCCH2TsYxWzchYBEU3iZae78HG+dpZSeBDxH7W18tIaMgddM+QGwj/JcHq+YMZudzhSoS5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890

Add compatible string synaptics,synaptics_i2c for synaptics touch pad. It
match existed driver drivers/input/mouse/synaptics_i2c.c.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Resend v3 include Krzysztof Kozlowski's review tag

change in v3
- fix order in vendor-prefixes
change in v2
- update vendor-prefixes
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7609acaa752d5..6275eaa74452d 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -406,6 +406,8 @@ properties:
           - sparkfun,qwiic-joystick
             # Sierra Wireless mangOH Green SPI IoT interface
           - swir,mangoh-iotport-spi
+            # Synaptics I2C touchpad
+          - synaptics,synaptics_i2c
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
             # Digital PWM System Controller PMBus
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 202c2f6d5942e..623543e3b0904 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1568,6 +1568,9 @@ patternProperties:
     description: Sierra Wireless
   "^syna,.*":
     description: Synaptics Inc.
+  "^synaptics,.*":
+    description: Synaptics Inc.
+    deprecated: true
   "^synology,.*":
     description: Synology, Inc.
   "^synopsys,.*":
-- 
2.34.1


