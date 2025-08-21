Return-Path: <linux-kernel+bounces-779531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E2AB2F543
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB517A12DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729702F5483;
	Thu, 21 Aug 2025 10:25:12 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86C2EFD90;
	Thu, 21 Aug 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771911; cv=fail; b=iBi/OBMF1GoHhIiQTLkbnMrlP6pdGhr9ZJD+hGYE54XQkNToI7iDodyVzNCJHUnlV7Y4szqz3C7OMgXdhagwefRMFmmFQkiuvw/lr0S7qIn2fBNOxxcxbg6TClMrtls8s42sRd596cOBds2eXsBJtTlLkpkEX4VQVaGyeO/jJqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771911; c=relaxed/simple;
	bh=SFwK9lbgvdO+UmM+vQPH/ljEtwtxhYS168U8zIA2z4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1wwFup+yLNWGFC+M7tA2PXbbE1beHzDWYt3e8sm8KIBKWCJiKXCANN7bmyV0H3vWFhvPooNvikmsisLRwAkh5B4n8MFJ2gmSxjdfitMzqrc5juyL9YhEod7nrwiVT0dVkWuNCEnWVIYtJn1gzzGYkBToIzzMfWs5KBcECDhzCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOPgPar/2Rm8Y5JpmOI29kB/l/JaMKW0j+xfcjC3WBbo8KRIipgiBFSwkYL2aXObpaiOvI2BoRQ6kNthmYvjwU/mWG1RCI0Ga/mkzRxpGD+UJDBN63e598Bq/OoW8Q1aXYl0QND2WdKOuKWxEi+Fod764CFfBBLfwFewfmA89APLVDYIG/fQ/n56JV29H6WuCHBNM3raAU6wC5WflWal55cSYghv+WDtBjSrOsQn5bkPxJD1EDn7DhN53zqG18oFwCbSnrcZJe7q1syi4zbZZbpo0tCGfe29wcnc7rA2XSfxFjIsUxtDd8QKj/TL8sUiYFaZCGu4H2sC8/Vt24RIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njPGtlf333KflOdix/2U2vpFvzc+OOkByBpCgK/NXdw=;
 b=jnEgJmAK18Pv5MiYGWsdqHZOBUDZMBDHTF1KfdBAQ7oNLG1aKeFmUJ9wz3sO4CZkEKTyXyTNsjpwSUCLdJCO8Ki52cOVmQ5OnijcRJ7x1Gt3FsjsruZCUuoqf+eVUOrK0OlGT0e2C9EGUMAAFYHjfYGpz4ii0CybHEFHIVH/vn2drLzEJH7XcxE+mv9F1RJmMwQITijm7cZFYIKydTcGZn+ou9q/f28V3r7i4YWpvpGg13Lio3xujRQ9E/E9pQKpHlvZ5fdreHqk7tJ4RZ8KSCNxP/D2+rFASnGoNc0w1Z+POfgI5ZrJjdg7H8NebKHFrG9bWesdo9BkJ/hx4Re8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 10:10:30 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 10:10:30 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 3/3] riscv: dts: starfive: Add VisionFive 2 Lite board device tree
Date: Thu, 21 Aug 2025 18:09:30 +0800
Message-ID: <20250821100930.71404-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250821100930.71404-1-hal.feng@starfivetech.com>
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0057.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::24) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1241:EE_
X-MS-Office365-Filtering-Correlation-Id: f918c672-2bc7-41b4-c0f2-08dde09af566
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|41320700013|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	GdEcJN4cI0JOiY6za/0OCAxxzHZU0I1CX4Iqf+eAaaVwESr3WrOybSoDH6D2iR1cGYa0XCdrKIa71onBRt2JZ+/V8PVxmvBy1mUwM+VMTl2n0h1UyJbChULXOqxWl8GqJUd1u8REHtOXu1B2u371PS+x5n+wXA8KHwcVZH/WrI321CPtUgRCEki9O+tw24ReEwaKt3KL3rWWJdJ9Bo9bWm7Z4bvDsJbOzoAMvz2rNHOpWYaxYSJJ4p3aLuDDlvDD8tEAoc2TIlqvoav3NgoYzOUU9Or42+tYz1FvabmkEAe8dAUufFkK6Z9974wg1IcyITB5ipkXbTgqhmF0vPKajMYNKgI3mT9MiSkjGPp+9qy8R7vME/jtNBvlntYApgnpOdY8hAS3ncmuK9i7qKpHdc8NTLHcV8GeHcKrXWh8n3SfvAHBQLAagLRovcFj5k6vxTilf33cqBE32HDfwu7eaK1SCQa92SDaxKm1g1zJ8/NuPtvrh5qOlJxtLtG7CJjZf73vQeR2PDRrNrMw3673I8Y+CgEqfm6Fitl2yf110UxRDNrPSTanT+ej5343pTVlV068C4T2sdLua9qv5zgjRmuBppMnpa3VZien77svEOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(41320700013)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vVI9yAQgO4J/6OGn9Rk8E7kKr77raNDclurWiUWPfXNOvDmrgPuFndoZhloY?=
 =?us-ascii?Q?+VZAFl/pMYl2br2cN6vE12dOvTbqrBS9y/9I0aTd8OiHs/YsHBSEXVUhJX3/?=
 =?us-ascii?Q?i+z/J8qDlW8qhrTS53NdgBsN4wTKP8Mj9LXGPsrh64NvtBzXtP0odPs/fwgV?=
 =?us-ascii?Q?UepUzGLSg42ukZuocbPOlOUUBHmr2rhlem0Wa0GWs/MJFrDiYigZz3brVqK2?=
 =?us-ascii?Q?KXFhUuoMiHDOKguSW4jur82CCCfSIDgVLdQNTskGqSFS6yVyvLEBypSVYKUq?=
 =?us-ascii?Q?OS+d++i6QuBsDdATbcQqWMyf+2DKkNs2T0C9+92ieCc+iNCqJfhNrDED1C86?=
 =?us-ascii?Q?h/WPxRUnjPDT0F9qSsMW2LXs2qtEUN5sXrvo3LNRAcJ80UNVJGnq6cS9WNFA?=
 =?us-ascii?Q?01cL27ybW1zKsZ6RlpQMVri0PEu2OUN8/d8jt2Hv1Kv/VOSI3R6tu4pkD0j+?=
 =?us-ascii?Q?8b+7MG+2dGBLq97pqtCCEo326IbyXzesX694YU9OnXbdbHl6C5wiXs124xy5?=
 =?us-ascii?Q?ux/3SIxt0+pD/LyxRX386AUluoQQrSl3xourycgLb31Ut/GQltP/yf+bysW2?=
 =?us-ascii?Q?6Mgk67v0gJ48YbaLu744IoPcuUc3LJnCqPvGAuPAsnseKJSo8NblgITDMNYE?=
 =?us-ascii?Q?psPD6rs12uHwmn4O6QN6ShBSuLE0QbEOYI6C/YIjW2/B4rxODZCC2BWsVyof?=
 =?us-ascii?Q?63dODnR42Qqypo2967sSFiXcC3nvdyg3XODhblcNYWebHMe35joHBP2JNggZ?=
 =?us-ascii?Q?NH6vBEj7pWxA8MGdlxgWlWLgiYWwnTxJkvkl1NJGA9KDfekF1w37NLSvsGyH?=
 =?us-ascii?Q?nEvNKc+iyb1aAqWk3azDmzXw7rGNhPj6ZmfcQmIPEVzBj+qm3VUQhCjzh14O?=
 =?us-ascii?Q?U0e7h5ySs6HGwps+rUXyO7hnbb6W2I8etWC78+OjHRun0xfwffKx/pd+V7PW?=
 =?us-ascii?Q?1wtgXNJBPGLBaMlfDNDGgoteINgIsRRfLGciEBbJkuhHbJA+BIpSeRa2F7s4?=
 =?us-ascii?Q?68CsyPFFwpUesb6kf3F2TkJRLDHfwH1ZzdS9Dx3ygksFp/s7UBCia060eDav?=
 =?us-ascii?Q?wfepJeFE50Zx9+MqCNEUxWDp7jeRrViXba/0zHYTO94g52zW4iUqLiwOYFeP?=
 =?us-ascii?Q?1AuhJxqd21rdq+Wdvz86PFeIZzYABeOp93hGA1UFTDfsLefqCJtFlGWUfbWU?=
 =?us-ascii?Q?emrKYd5OQAOZ4grsNBJBRLERlh7SHpfFBKDnFAgLfI13FWznYVZWjXQnr7AS?=
 =?us-ascii?Q?JEgExPQKltTOtk6I4v1lvm9GCDgcmwb7xXW1Gw8L1l8ArZlieRwva1dLmuG/?=
 =?us-ascii?Q?eU+Fb/ol821PMeyJRmbTKxbXlGGJFuXpAUyh6WxQTkqrz5LYCvXpNAkcQAy7?=
 =?us-ascii?Q?B+plFIQvnCdfh81r+M45fm/mmEBfVZ1y+nOK/2wPj/PQNPjujAsiU31Myc6K?=
 =?us-ascii?Q?h8O/KC+JVbKnjE4r9VzVuwodCseyXb2ycvQSL3sJpwB0Iz3l8EqITxmySsOD?=
 =?us-ascii?Q?kmeITQrcX0NKG5mwsDIgk+EA1fqeaCW711siMzpJTKpBBDvn37TtqVcI3ltD?=
 =?us-ascii?Q?pJR47bdY9mGkZKRZy0Ja7Qd9F54UPTIvwoTBVIQcIPPxQerb26mnlG7gy6Dh?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f918c672-2bc7-41b4-c0f2-08dde09af566
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 10:10:30.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+YEGT/9mKq0xLB2MUeqRy4ru9ghL0Mp0mlBfFBm34OMQwdxibfJGhV6iUNQ/gDStia+wqI9dm+gZDG58YG7pyEBSJ7tufY9kFXhZzvEQtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.

Board features:
- JH7110S SoC
- 2/4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 1x USB 3.0 host port
- 3x USB 2.0 host port
- 1x M.2 M-Key (size: 2242)
- 1x MicroSD slot (optional non-removable eMMC)
- 1x QSPI Flash
- 1x I2C EEPROM
- 1x 1Gbps Ethernet port
- SDIO-based Wi-Fi & UART-based Bluetooth
- 1x HDMI port
- 1x 2-lane DSI
- 1x 2-lane CSI

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/Makefile         |   2 +
 .../jh7110s-starfive-visionfive-2-lite.dts    | 152 ++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index b3bb12f78e7d..7265c363e2a9 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -13,3 +13,5 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
+
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110s-starfive-visionfive-2-lite.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
new file mode 100644
index 000000000000..a0cb9912eb80
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 StarFive Technology Co., Ltd.
+ * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+	model = "StarFive VisionFive 2 Lite";
+	compatible = "starfive,visionfive-2-lite", "starfive,jh7110s";
+};
+
+&cpu_opp {
+	opp-312500000 {
+		opp-hz = /bits/ 64 <312500000>;
+		opp-microvolt = <800000>;
+	};
+	opp-417000000 {
+		opp-hz = /bits/ 64 <417000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-625000000 {
+		opp-hz = /bits/ 64 <625000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-1250000000 {
+		opp-hz = /bits/ 64 <1250000000>;
+		opp-microvolt = <1000000>;
+	};
+};
+
+&gmac0 {
+	starfive,tx-use-rgmii-clk;
+	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
+	disable-wp;
+	cap-sd-highspeed;
+};
+
+&mmc1 {
+	max-frequency = <50000000>;
+	keep-power-in-suspend;
+	non-removable;
+};
+
+&pcie1 {
+	enable-gpios = <&sysgpio 27 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&phy0 {
+	motorcomm,tx-clk-adj-enabled;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+};
+
+&pwm {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&syscrg {
+	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1250000000>;
+};
+
+&sysgpio {
+	uart1_pins: uart1-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(22, GPOUT_SYS_UART1_TX,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(23, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_RX)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+
+		cts-pins {
+			pinmux = <GPIOMUX(24, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_CTS)>;
+			input-enable;
+		};
+
+		rts-pins {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_UART1_RTS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-enable;
+		};
+	};
+
+	usb0_pins: usb0-0 {
+		power-pins {
+			pinmux = <GPIOMUX(26, GPOUT_HIGH,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-disable;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	status = "okay";
+};
+
+&usb_cdns3 {
+	phys = <&usbphy0>, <&pciephy0>;
+	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
+};
-- 
2.43.2


