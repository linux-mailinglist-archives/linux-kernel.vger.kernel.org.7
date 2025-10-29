Return-Path: <linux-kernel+bounces-877104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4CEC1D337
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382303BBDE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBFA363375;
	Wed, 29 Oct 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XbMc9UO5"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8B36334F;
	Wed, 29 Oct 2025 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769708; cv=fail; b=iVoK2IBcUaxwBsIDyVAJM7W22s7vdIpWmZ3ix/ieuhj01MoVlz8NebFWZRb45pRQZ5xyUrV5kyp5TKZHph1sLTxzGJG/XROGK6ywUF5PFjULzJHnpzhG2yE/9SfzT0h6k+U33pvMszGJd3TgxmlcbsWLlrjSkLIH7Pc0uuk167c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769708; c=relaxed/simple;
	bh=DqIEoOJTkd7ZwTnAiU4dLX7Avp24mc4fCEze7aP4Wn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQqNDdLwRF419Qu/aT2bTVoilph/P2/CZ91Ab6QQgz9LckwUzyMynRNLJh1ZMyAjJtTllL1fDIXClkLXTy7utwwA/LP96Vw7FaXvnI5vPI8vnSrNciCFHzCG5teVL6lUBvBVcm5R3khWwxACXlo0QtEwGbMcDvyuhtuVHhpHOKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XbMc9UO5; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTAvM2aFgrOuIFENj3TRKNQG6kBTMrl1hSDX75vW8k3AbWMk0Zl6kBaKwzeIBJHFf7PWucQYPzJF39pQkIfcSiaeQOulFRhfCC3xRmHYjc7RGcAVprDs5JDdTY/aBCafIQBD2lSaP4YbJxbbtKuI5gilZ3I3W9GIRr0YiKYAp/gdp+F+R4lWQ6452RzMMNmkzr02ao++Wsq13RYqedbhmHZM/pfMzH58AzS38Z9lKO12vNSPZ66jzjJ4TIrRUqJSXt8lX2DInQsQWlLhsZivtOO0/hy906+EcAehirlR+bH2Yb/QABEmErtOAaEziaJKxQpcgL1JVI8aoa1pPwQWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGOwNA4TzIkfAG/U32WhV1iTw+xHgm8ft0euHqiTz2Q=;
 b=w/vXtH5wgYtbfBiA7JaLQOwbWGx0V+f4RyXMzvB76qrGVW5YoECbgeAzpWa67y1aREwh1Ubm3QlvHVPP/A+08CXj6f1sIWsMVbfYugaxRUSlQ4A65K6oR+uvBimAsbk48xj75VezaorGEc1lrCUjLp+6sPPHaWvJyyZ9tSwcEncF7lCszWgv7rLPQlv+FER1+YkU63OfSTaHLZEWzatHLQUwgU20A7o22Lof2HJmZ3N5vU/luAVl2w9cuNQfS7vvo0/HiHJOVM7ScBNqm9TzCy5hIDAhdhQJaovkTP98oG93CITBEvwCNYbV1NR+iwFvkJqyraGZyqFQ7p0HsVrWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGOwNA4TzIkfAG/U32WhV1iTw+xHgm8ft0euHqiTz2Q=;
 b=XbMc9UO50hhlX4Ad0hRS2Y7uFnL2iLYFieOrgnp9OyobTkMcrQEJ0+1aBwT+4szRcmYnI8uEZBaZdhvxo74QKMKpotls4BGejJO2IgVDpBkX1EB+SoR6igYQlpkB3AMQUyE45mJZY/uMBMti0CkGZRjPPYqJ+wlSFClCVQeihCmTfrRkxYtfO7/707pJti6T1PNchAvhR584UbGKWUjIPMpFQQ8lkJbwOFHDRCEE+wbVdNKAaYRf+mJzqckOQPtsSd33bWcx2GdVrF+22zu/WTqVph5YKdrTpni6zYrJ98oQNll59JNp9U2VMCQnj0J+AOSIGoMkkpRCV0vMK55ydQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 29 Oct
 2025 20:28:25 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 20:28:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC32XX SOC SUPPORT),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 3/5] ARM: dts: lpc3250-ea3250: add key- prefix for gpio-keys
Date: Wed, 29 Oct 2025 16:27:59 -0400
Message-Id: <20251029202801.3963952-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029202801.3963952-1-Frank.Li@nxp.com>
References: <20251029202801.3963952-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: c132fa8c-3394-44b8-b3e5-08de1729b62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?poWoDhntt3yUIWavZLW5NSDGlFeKFtd/EmHLpUUb/oJSNHJfDlHzc9w1Qbc9?=
 =?us-ascii?Q?w8GljzRNsaPyZEUDYb/njfdb05vsLvEVFrkZw5CXVLekUsPIYThSyp1DJgzm?=
 =?us-ascii?Q?oBDFv1WicAweRxMxB0pZTOR5I4m2u+fvuWn6bF36EF/9Z26bUK/35uTLhZYv?=
 =?us-ascii?Q?2N3okR2ABNHzLHtmVf+mI6bDWmrprcEwfbEjbG/8DtqnfudOZK9DyW5BRj0b?=
 =?us-ascii?Q?y5VIZUghDMjQtw6sxhftESLi+MtnNW9t8HyyKdjdYH7q1XoFHq23/XnM9mQq?=
 =?us-ascii?Q?xh0Q5yU0Mq7zw8EEVihYqyzZvdP6/363v1NQN8XI8l8N0IzvL+I6yfuTS1xr?=
 =?us-ascii?Q?DcehNBF4Onkncu7DDLHzgu3Dk+OF3FZyvZaA0ONSudu5cQB7uL+Qh4Huah2H?=
 =?us-ascii?Q?XUe9vTNqV6t8mxw74msWFsHaoZO3VpSN7XU5dMnjKlg7Kdkypwe5bA+oOWg8?=
 =?us-ascii?Q?ofg8Lp4AJuA+qiJNc7z2zKU83CJhUFdbHxohHljjctKtpfjwXUHHrwFgG4y2?=
 =?us-ascii?Q?sAhKOVbe2a+xsbvjKi9Fpl9OZwTzVy1fndYfaCE49Vm3UDf4S/F/Ez/nMWyf?=
 =?us-ascii?Q?h9j8MSgVZLBYPWSMZJHSQ7+wRJUnat50OnZkUu7qpM/BkvELsxdBfX9Bjh2Z?=
 =?us-ascii?Q?VttNmGyfYhBJ/CAePycA39NKtgVkdn6/aRC4fCBjmqb1qTvPRyq+1uCc1RTI?=
 =?us-ascii?Q?x7zPmTePAWYQTpxDh7KrNGJAaFRvKKOGzsMywSYGuJdBrvPXxH7fbG/lzKNe?=
 =?us-ascii?Q?UC2sAWfbkZHnyJEqSfS836+1+faJjkc/5KkeOauQf/3L8XRZp+BSwfd52LUL?=
 =?us-ascii?Q?BOOIn4xm0+IbbcVyW4OhBE+lqB3juepS774RPlbjrDH1vpGWltzFVPKt5OVp?=
 =?us-ascii?Q?F08nk8RGX+xx8XwBY1voe+OVTBNAwHbeQoo7nk6Zdgky9Kx5g5nmr4NsnjmU?=
 =?us-ascii?Q?o86q6/v3moS3E/RAj9lQ631NRwkXyZ5jDMayAQSfqunXmqiOQxZGYXpABzBt?=
 =?us-ascii?Q?q4qsdRpjOOWO4XnVbP824PhCEEhuw4zKyw5GxOEbeAFn1fJVF3giIO97/qqr?=
 =?us-ascii?Q?q+hZ0zXp38mBMvWth+p1VVk5j/j5McyZJ0KY3UeAqVvItX0J3zv5d3MQLO8d?=
 =?us-ascii?Q?EnNqwcUzZeVnbBV/jQyts7XJpeLHkzAqx8NnruN++PSjl6sJaQp/c9g4foXv?=
 =?us-ascii?Q?/d4CLINZTIFS0bKA9/GnarQ17X8AdTYI7jHwRluVeabi+t4yQdSL/tZLvWJ8?=
 =?us-ascii?Q?Pe8sjQRNSSkbTb5XkLXtUXrDsN1SUDVPlwm/bxhtrTRmKcOjGB6vspVznkzU?=
 =?us-ascii?Q?lxSwUS05N8kJytg11ZeO6/eL/Fg0d1ITtfxxsq0sbay8mvdqsWyGV4UzxiyI?=
 =?us-ascii?Q?LoblpJL+snxGcEr/o1fFMRYXzFVh3bQKqrebbRCNJEK+IDHPoWib0Jh2PAzr?=
 =?us-ascii?Q?qvdiBJydu9shOTKekNk0Q9tv+KokKntKOZO5/+H2vD0cUZ2VkmAI/+BZxl2x?=
 =?us-ascii?Q?ufNq5S+jikTzsHZn+8kVjwPE8UJwSUA3ezyI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0C28dt8EBAqgsbH+UE28KLmoDivCmfCKxvBnCztYbAj5UZFSEOocSsULqKI+?=
 =?us-ascii?Q?+ZMOJ11ymTo6aS9Pd5o7BNzxw47E1vlHZDvLbYJvZHPM8anNdV6vt9M22ivI?=
 =?us-ascii?Q?2JJjzUFDLcVAGvNniUqPScaFK8c48KqCMA8KrorR1tXhSGADZBJasdH04cby?=
 =?us-ascii?Q?fCLfy5LAXw5yW3TBeJ3zlM9nSJxT0ULYIRKmrNqlO0W4tlO3LjuMo2JFYUGI?=
 =?us-ascii?Q?W6OLgZnC2thTWMtQdqiBgFD2hGySGDEMGxkSfnXy1/fpbNoMp0mdBeNvN7FJ?=
 =?us-ascii?Q?XfhCuFoZu6o7VaxzdL8Y3V6+aCAuE0v7qS41p070nQIPDknz9HPFvXNQ/uha?=
 =?us-ascii?Q?1xiKtTfSARK7vuCAgnd091pNzIt1f2D8w4wyfaw5oFLKfvEsCwdWXA3uja5B?=
 =?us-ascii?Q?xRfAxPoN8/T5zXtvQNIZgFfRIttCvZ/xBDqR5B4THs3bMwpqtl5odGOs9JBX?=
 =?us-ascii?Q?3eGwEav1BGZeGtvwZO1H/zK5cesND2OaGGOfQDEvP6Rp/jCHxkGlqaf2sqS3?=
 =?us-ascii?Q?53z4q7twkB3gsLi+4euNPZr3ZUKWLB8BMF3D4vCnlceCqMysGt0KtE0ea7+8?=
 =?us-ascii?Q?L/ar+8IL6srGpLdFlIpyUDMyCZKAsx5WIkCdOBx5nHSLyON5Oc7/UYrtWFqJ?=
 =?us-ascii?Q?Pa/8dgLO6ABC6njuQH1yK3Wm1eUZ7xwvyph438RcWE7gzw3SZdr4Vo3hi4nt?=
 =?us-ascii?Q?gYSBG8u85RAxxjr2CDs4PoqJkgw1edAK4gvAdePduaBN12GVzjzTn575LlSz?=
 =?us-ascii?Q?90CH1pqC28cEcpYOJ8RXU5Av+bsaZ7uz5LOM3T488IFQZ62/fccE/1ba8K/o?=
 =?us-ascii?Q?wqao82EPXYWEDmxHo1cmQtE8eZiTtbWFCnWsGZvI/8fgUQKB/XO3YL9dkvxj?=
 =?us-ascii?Q?Ifw3Lw8KZ4rKpAduTvWERlJ+PJEtyd3Wkdaxk/aoD/6qhgDenMI4w5M0C2iK?=
 =?us-ascii?Q?RllQYjPYp9yMvgZ3pwv6+oMmEOHBVdIhWXktx6Lh7anlrvHozyoUx7QnCC58?=
 =?us-ascii?Q?8h1vdgNlpcP5u446XscTzeA2m7oxI5XATZ8ABg+DEwtTpAp5OAtmuHo9Kl4B?=
 =?us-ascii?Q?42hAsVKa/LOPk0/srag6xVa+xL8V3lVkHoYWQ0zV/d5pbKHAwFn+aaaSCgxp?=
 =?us-ascii?Q?DANAgrVnoN4oim1+j6VTQFSQwEz+ZiQrk1DVALeERx410gAhUf8tTwriUifW?=
 =?us-ascii?Q?9Yyq0Qxc/eZXFA2E24GW9PAlCtfNsbhcfNPs9FqhYGZGRmMPhMp4R0bdvc60?=
 =?us-ascii?Q?YKofU+VyNNO5n/QXe4MgvNmBh9QyBhLnVnO6gJLh6TDz0ScEmFQab/QFbF06?=
 =?us-ascii?Q?01LWgTW2XNbOsABhmKovp5mvVW1CRiivxAmmcR1G7AyThVRm9hHRzP0mozY5?=
 =?us-ascii?Q?mle3Bxbmprwy7ZMEEjLmVl2hyA3IV2m/KVIm+MqGPk2ONEffuSbs9j1x08IF?=
 =?us-ascii?Q?c1ZPoZOUoyvqwxCDmAj2UQX4B7gvf/HY/9wCOC7fA5njRmki+49N1290vo8O?=
 =?us-ascii?Q?zqgFQz2NVpcrdvwwX6fiR/aCa7Mohm8wrORtDKe0/W9GZJOxoVa9id6oSmPV?=
 =?us-ascii?Q?KtRR0mKVi3BUU5lod2o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c132fa8c-3394-44b8-b3e5-08de1729b62b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:28:25.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNvbEswP4zilIAocT359R2Gm8HgNSPnclOSEABKFCJy2L8NFS8dDbR2YfLPhKWvBce3UlMDxvy2L8tluLPa/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870

Add key- prefix to fix below CHECK_DTB warning:
  arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dtb: gpio-keys (gpio-keys): 'joy0', ... do not match any of the regexes: '^(button|...)$', 'pinctrl-[0-9]+

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dts | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dts b/arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dts
index 63c6f17bb7c9f..837a3cfa8e7c8 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dts
+++ b/arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dts
@@ -27,55 +27,55 @@ button {
 			gpios = <&gpio 4 1 0>; /* GPI_P3 1 */
 		};
 
-		key1 {
+		key-1 {
 			label = "KEY1";
 			linux,code = <1>;
 			gpios = <&pca9532 0 0>;
 		};
 
-		key2 {
+		key-2 {
 			label = "KEY2";
 			linux,code = <2>;
 			gpios = <&pca9532 1 0>;
 		};
 
-		key3 {
+		key-3 {
 			label = "KEY3";
 			linux,code = <3>;
 			gpios = <&pca9532 2 0>;
 		};
 
-		key4 {
+		key-4 {
 			label = "KEY4";
 			linux,code = <4>;
 			gpios = <&pca9532 3 0>;
 		};
 
-		joy0 {
+		key-joy0 {
 			label = "Joystick Key 0";
 			linux,code = <10>;
 			gpios = <&gpio 2 0 0>; /* P2.0 */
 		};
 
-		joy1 {
+		key-joy1 {
 			label = "Joystick Key 1";
 			linux,code = <11>;
 			gpios = <&gpio 2 1 0>; /* P2.1 */
 		};
 
-		joy2 {
+		key-joy2 {
 			label = "Joystick Key 2";
 			linux,code = <12>;
 			gpios = <&gpio 2 2 0>; /* P2.2 */
 		};
 
-		joy3 {
+		key-joy3 {
 			label = "Joystick Key 3";
 			linux,code = <13>;
 			gpios = <&gpio 2 3 0>; /* P2.3 */
 		};
 
-		joy4 {
+		key-joy4 {
 			label = "Joystick Key 4";
 			linux,code = <14>;
 			gpios = <&gpio 2 4 0>; /* P2.4 */
-- 
2.34.1


