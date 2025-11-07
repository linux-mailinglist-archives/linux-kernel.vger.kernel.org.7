Return-Path: <linux-kernel+bounces-890266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4625EC3FA77
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FD3A4F2331
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885B31E0F0;
	Fri,  7 Nov 2025 11:08:44 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2111.outbound.protection.partner.outlook.cn [139.219.17.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D71320A1F;
	Fri,  7 Nov 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513724; cv=fail; b=mQz95/iYnp5YppyaKisQO6Ys+N/7k98rQpBQdC1IIssCr5Hqgs3kz9RSJjhg0g7UdMYcvqbuANtT7rK1P88Nra8G2Kch+kzZGGr1RbzW1up5fb6fy5xZ38EuZbxeHUlvuRCfi8Lyqe8xKiYPHnq8CQPtO+7byn94ODU/kQDc54A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513724; c=relaxed/simple;
	bh=RehCo4sUZSnk9AjckI+Hgps8mXiLtcQD3wq7+ccZv0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IgXHchGFsX+DmLEV9vM4XZO/nKNHIdfHjv+BIv6GXfzWTypKy1ah1Qu7BAfTBE+rgXzSaQkysZnNl6WWaMrnkEAWvfpfpasGvnXC149ZE1zquhOOQwGTvge9bE9mpITKEyDOJMzXWh7KzZpr3XMk7KmQ1u3/WdOwD51Hw/12SOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) by NT0PR01MB1309.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:54:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW3wXH20sU3xNoS1Ap1Ja66CG5GzjI3Jb/qsXn9UFMeuUNO9dJ6P4HGxyRm6FNjDLk/w4Ls52AOGKyJd+2+Veucpdsg/Wp66A4PRktiOIS8KDd69OlC/OfbmULXM0LDrP6Wt5ipdBG3tyA81ZGn6doXLvgItfKfr3Tjm7ArzrXOq64sqj3Sg+OYkbpI9qUIyqJ5aR3M13PK5W80DK3NwI5+XEXK3kEgK1XTZsifclnGjpBCqz9CmklTxeX8YVvGJiagHoUDqVDFLzt9+QgqyOGko6nEov5mPG/7uQGJ+t7zv/Osxe9eyyctuDTP+IEkqVJA3gB2jG4gHpp0FfVLpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkGAzpKBcoDhRWb5kotsVESWZoSUPUUsZEuVHZgFVLs=;
 b=alh8AW5NxyWi++sR86aTN4RCctM4QQ6yRaBRpMAzAuXMA+Kqok01b0BAFoMT0Gmdvm/8cv9kcK06sI/ykJZnOnaddZMsjezWYsYZe+l022AGF+V5Q49LrbGFt8EbvZAw/XgGXoxn6QyVdv4siJk6MgMYjYoc9LOqmi1vXHR68VMx+QHKMSCeGB6oCVMUeaY3G4/8S6XkYi8X67bcixGTH7+9sXJc5EevSxZBzhJsECHcqoMd4dngoqOtUAtUgiN8auFCMNAH6xEbDyxWhqMTfTRv6xzwOtl+pxU3xugEsSK3gdWof2pOHSRpwHScvudO69vfi8bKQFmNiHzNJ2G4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:55:45 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:55:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] riscv: dts: starfive: Add common board dtsi for JH7110s and VisionFive 2 Lite variants
Date: Fri,  7 Nov 2025 17:55:28 +0800
Message-ID: <20251107095530.114775-7-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251107095530.114775-1-hal.feng@starfivetech.com>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn (10.2.0.83)
 To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn (10.2.1.78)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	ZQ2PR01MB1307:EE_|ZQ2PR01MB1305:EE_|NT0PR01MB1309:EE_
X-MS-Office365-Filtering-Correlation-Id: b061be4a-8630-481e-2e0b-08de1de3d1f7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 DALQ5wrCOkgDc1ksNLUQHRjwfX/sMUSEcA5LdWfwdQIW4SlHsKWO7JLu8eeu4p8VYVRgi7ysBCdfyVjBt8Oe9aw6k5ZttIl6RBZOFPjdWoKoHdTd490+rr8gAxbnDoi95LqgvCNnzn1gghzy1eJE8YfwcgH2jVDqpCP5VPmqIlu+S4W8pONPyNd3EDon8uhkwpSc/nyt6oipHlncpjMu2FUQ2U9quhGPJpEW6smOWba9j6ubGE0peJLYsgFffPeggZ+PeDpHQR2k+IDwew1TZHyXG98HXPqXVo7qKP30uvH+khQtFDiRzsZV0vY704ilkre15jTT7/SGsCg7dbVf4GOiWW3/D4ktHNfeaUcCcpMxz1fGoxR59ovlHoo1LjO16sQFDyqcGGcSIk6btY0WsJ/MdlmLa/wuQ5Py19/6ofDEzRkVI7NhlbcL9ngiZmNZtnhPVoLJpvPuE9oDCl0yRlhwjn5ueHD96vh9MbnLbHmEP3hbhK5GQujl8JsruNqwBFUpBVaDl6w4zREbHrJawmWWRfddn3Neo6boZap0UTJWd0B48q37+6dugQb+WtaBAEnYbh32kYcwXrHYWWWqLDHq1FRiFNyzJ3B60WB8tK0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?QHpY78J8pC522GslMm4T0/3oYbYtQgtQRWUbmg+CZcG3pUqgiRED8Y8R6PFz?=
 =?us-ascii?Q?4N6G9GjxYr26gz2SDCP1D/JSYu+41VTeuQ8kkQCMUsi7pkDAwG6KksVuz+sf?=
 =?us-ascii?Q?EV0+NZg6FZZE2OLwqLxHRPrzGwt2cP8WseEzOkJqbyLipHV5HI8X1rdOhFW2?=
 =?us-ascii?Q?bPymD4JUqODB4ZRjbids05BT2WuAiixBTMOMns9h9r7yPxw5a5MCZfKboZ5t?=
 =?us-ascii?Q?liwU2EEP77IFAFIB4a6Onc30PQF+aYUsV/S95ag5wvCcUhE05N2eDHGUj+WT?=
 =?us-ascii?Q?0UwEGjStUnnj/lLlmMModkCCbK048827imY4FKarBhtzP09ZuX/+FCy4XuYJ?=
 =?us-ascii?Q?GduLpeaSBnjQD/+AWpRnHZ34GjxsFphU+SdGu7/meh8OICsaxIqEb1LShQ7J?=
 =?us-ascii?Q?aN1Ovbng+AJR5fl5bk7b9WUzAb1nwvPKn3o/WyBQTcAVHfzuiU0J6Dy5L2Sw?=
 =?us-ascii?Q?lN2IC2GlHXH2StO02FjE6QaQtqi9S/prwmHsx0nTFeB1OqtaTwBi0NbGFD8J?=
 =?us-ascii?Q?Cpkxlp3MwO/eaHf2W/VSXvMJqNpqway+0SVZ66FNmsyQbmx53AITVV7x5nVd?=
 =?us-ascii?Q?SBwvYYJyFgTFe7JkAvGpGkQ0CYnr06GLOKi5QqUh3ftW2sIuupOiu9aML5Jf?=
 =?us-ascii?Q?uxVIna7sFexf1KP3uDXv+b4lBtFcZ9LZPEXbnJ6TKzN9t+XMxTyFNItMZr78?=
 =?us-ascii?Q?Wbs0tLxwAI64516TqjzsOiAYP3/yh0L+9gXkcMcTAEKfBxWK/GJrj2NWlz7S?=
 =?us-ascii?Q?4V9hTinH7EIXqqEMG4sXFXUDFVYFq01vRGbbOCkq3zFZnxDmWxt3V2Cqq++B?=
 =?us-ascii?Q?mK7LiIav/kf0FGj3C9gI6Bq1UdHXl5EyQfLfN16nKsq9Js+p0FKT0vAtV8oA?=
 =?us-ascii?Q?EoodiCc6bbt0+Zn1qMoDrHs3KFzDm36LIgc1zzr1fqI2ZQ+t/NHeY59NMwfQ?=
 =?us-ascii?Q?cwJ/aCSs6q2krH18StquMxUdV/EhdCHcKAtI3KfCgvjPYfmDCcVVmFs3sWy6?=
 =?us-ascii?Q?uAWnU9uQetFeG6jBTRPpHyX40GXdjqdSqdrSre4PeiB4VxOrcoq4FVHlxtjU?=
 =?us-ascii?Q?vw32PCskHrS7H/PkChAEkSmfEMq6FMX1axRu4zOOKiR4mB70bg4Hd3xq8c2K?=
 =?us-ascii?Q?kyiEOJooZlguiodk/3CjCBtJ5BLaF2hGp2QOJaBi7tOxiXKKR/BofwSu9QYG?=
 =?us-ascii?Q?jUYzXrWBn0cojiO14bbWKxc6gqg7LVBF+brGsdVujxLAJxohMHUvMc9vsliQ?=
 =?us-ascii?Q?l6ODgprJAR1FdWCQKjB/5gQrRvRQkrARZFeH6665w+AT8MQZX7tARp8DaWb1?=
 =?us-ascii?Q?+BuD5XVVNgvEtWJBHS9y4SsmkYo/SBMitU7RlSqlX2B7R/4lOenKiz02Gcmx?=
 =?us-ascii?Q?ZRqNKpmysEWsBemm28T1FUCuFU7k8XvRdryFxUfG8pZpkyr3zZKpE30otyoT?=
 =?us-ascii?Q?JODt67QI73iIzcnLoRNCFH9NKkidNasClcHF8mIPb+dKsOsU8Nt6sj5gHgwx?=
 =?us-ascii?Q?8Cr4Vvj/zAVhEKfsoAPF1Mse/bzmUKB5hWFlOQOXbaWY/tDi4kVKb+UviYAe?=
 =?us-ascii?Q?6u+Q8Rcd8i+17yK/5mPFnSt+JNmgSg8hMQaKrr7qHr4F06Gn1k81GhgJ3q62?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b061be4a-8630-481e-2e0b-08de1de3d1f7
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:55:45.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mS6G2gyhlF4kVwx4fMnsiKV8FqIXfd1GlcMeDUfeQBMXIO/uNFgcgvomyN1y96UEyvEhVvleDruAUlO3v9PITpDp5g8pd/Sw61hEMPOniM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1305
X-OriginatorOrg: starfivetech.com

Add common board dtsi for use by JH7110s based boards and
VisionFive 2 Lite variants.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../boot/dts/starfive/jh7110s-common.dtsi     |  27 ++++
 .../jh7110s-starfive-visionfive-2-lite.dtsi   | 126 ++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-common.dtsi
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh7110s-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110s-common.dtsi
new file mode 100644
index 000000000000..ad0d54d44123
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110s-common.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 StarFive Technology Co., Ltd.
+ * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
+ */
+
+/dts-v1/;
+#include "jh711x-common.dtsi"
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
diff --git a/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi
new file mode 100644
index 000000000000..747fb806034d
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 StarFive Technology Co., Ltd.
+ * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
+ */
+
+/dts-v1/;
+#include "jh7110s-common.dtsi"
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
+
+		switch-pins {
+			pinmux = <GPIOMUX(62, GPOUT_LOW,
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


