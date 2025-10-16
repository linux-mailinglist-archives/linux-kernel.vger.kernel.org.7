Return-Path: <linux-kernel+bounces-855726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF166BE21D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A84F8256
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A43054C2;
	Thu, 16 Oct 2025 08:17:08 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2120.outbound.protection.partner.outlook.cn [139.219.146.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEFC304963;
	Thu, 16 Oct 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602627; cv=fail; b=cxeTy9odx8Ry82JaVwHNIsDjfoPJrMQbnoDqy2TY/wWfiOmtuy5ogw4HKssNlg3d4tHRCo6bYR7h82Z0963jS/as3hMBTateurvMifqZz09wkqdXKBRpi/xsue9oZx0MV5hvpQB1c4QoFgCdJfNEO6u66OoPSD/wYzAG0RwIiY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602627; c=relaxed/simple;
	bh=LdzGWsjgm4jXXnlQXRUj6UffMOY0qPHGD+wceV3zsmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBAEH6IZa/3bJcJ8mA35SSocPggiQq1RfCjaBEKTYEnusfwl+BQMILPPamxAtEn1bD37nRdhrf7CKTzo5rqQjEAtGkp4VTPVuCtachPEtoRKBcV4PvIdXw4HH2dPlsCaODtGy+WO4TQLJLupQFroDCL6h5LBX0MrrI+FjhqIt1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXOtTPC0l3V1I6e6fAnSzxjl/YolHkv1c63zTG6ETlbPWLI0X5ezGJB8qBAFD8LegHqq0hjjoTfbk4XW70k32xjyUjzYeB3B7JytOt057+X5KKpt1xEj+rvrPGAYx9SO/LLalJB0/YCj/GZDhFkeVcEgt9dB16I/E0fBRGW9E2diHj13Tbt03/njc55YxEX910BrMxv7BWdAkqweRuMY1ZdAeTM7YMyhQegiIOkTTswxOA1FaPrenB+q7JWIM2JN8Y2pUdS0Xeqi6qXTLFV1jwJH4WjCj1bxZNS9it4wSXYS1lvdmJTQg/1gcTgEFY0AqYMrzJbHoalI5SpykaVyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf4kqQuHDbwJ71Sfz0JWkfJUsoJ8ZnctFfRDLAakt5c=;
 b=Wt6Ul0+h8wCHRRS12Spgbf7XrqZmg+UsJZWWrQJ+Y3LWkp3b3Y3RlRK4qIvXSo97GTAXw+ZemsJqT+G5WC8zQKEjDHqfkRFiOlRQQi6bws/YtOkxMgNgBBvrPOw10dU+3yp7AUGsJ0w3pg2yOBDoiOZnqozDZ208DxxqrtMrDnly82XpwSzCLels9YrUSDskAsc1Xpd0sIq2TpXtBqkTQHCnxjBeX7FuKZ9r7YYEtyXTtLmHWMvpGUZQ5dDwZgcTYgdjn3jnq9K6FTqOhDv87yH0lWnViOsZ5VNwdHe4BSGb9SO3J+05zyPxc5c+9GfBUi5d3bvn38E5oMuTh8aEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Thu, 16 Oct
 2025 08:01:09 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9182.020; Thu, 16 Oct 2025
 08:01:09 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/7] riscv: dts: starfive: Add VisionFive 2 Lite board device tree
Date: Thu, 16 Oct 2025 16:00:53 +0800
Message-ID: <20251016080054.12484-7-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251016080054.12484-1-hal.feng@starfivetech.com>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1308:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c919e7f-b620-4f11-c25d-08de0c8a2ad8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|41320700013|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	Agw7eGtjcwSTocQLpHTmT4WDLDxSey4Ow4JShNv+5dr8GQPJkrGJy+BwFyYEfSlw/RrC7A/G8SPsGSPJzzI8adfcdztmyAx+kU0tSZLmwK62rD3kx5WgEpPGTpI5a9ooqiGEbnKYQ1ac+EB1Deko0OxnOR6paqBgyxOUpFWDRw6REdymkWQWlHCxyrFzYo5i5pPzlAVQxG/Xmh1Oij/dYD3ui+opqTY5ZGdUCYNwtPpmtZzYhhQCy6YqQYpeENidEGE2CTvLyPuYZhipp77Q5DDHnTpuzW11YMO1qeu+fZhZfJyMfzTxI3at9RPRj1Xzunju4MQOOoJVWSuRThF8m6LSsajJoGuvsC2BYKAJEC4fpWijIe5Fph6xQg1HHCrrg0SGtzHfOLdsxotiK98kY9C1/Nna4DKcMJb7QZHXNMxPDjIRD0i43hpyVzTYuD94zBtLxeT0mVKgf7UqyKlsG915bcejTI9CCHCzsPV3kHU4a4xEQzmK0oKC+RyR1Rxws4qb1d41f9bqmneGm12ou3dDa8H0a1S2MIOanL2QfHqNMQilX72bzrw2L/JPO2yFRCXZc1eQGnCCe+WzL7tpWFDZgjLRgkshmT9cye7Qpbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(41320700013)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qd8bXobI/IoogIAPUTHNca2y1n9Mv/aYLFj+RUhY3arz6a1boNBoJUvEUZrw?=
 =?us-ascii?Q?cP3/iSBPpYb3dLp24i9H22JdmkxxiQPQ/cloRf0rVqoNuG+Yu8l3/BQguyM+?=
 =?us-ascii?Q?la1ZUQ5aPv6eKlLvenuIhZiZieAcQKu2gFmZlFSeHxjW49sPZJCcU8xYPV4T?=
 =?us-ascii?Q?hP81XUu9KCCqU0b2vxJajmWGP4bxUcd3dcJC/T6bGoyi68AejBy1Lix8bB6r?=
 =?us-ascii?Q?Usa2CTaNxpjgqubaTJtXqUPHUaIHdJ0LrB3YteQn5w+f7VMC8M8OlWjkz6qB?=
 =?us-ascii?Q?WJRl3y6+Cf0b40PA/3YQ/6NgQrnl8aKwJUNLdi+lwdXCVqApse5W9R6XVb9R?=
 =?us-ascii?Q?YuO+bmChx/I2QasoTIPHQJDqLSFTDx0bwRlzrKTHxBEyerAByZpmhRhxXiHx?=
 =?us-ascii?Q?EciqPqyDFyQx4P8kCwkspoNsSlU0Lvt/mtL8xI0hLiBQGlO33EnyHdejr8jp?=
 =?us-ascii?Q?yNY2gKJUzrTeIil8j4YJUibLO64DHZpeFCARB0G2r5JCrj7vFoE5CTZjOp7S?=
 =?us-ascii?Q?Oklzz0H78xy9IV96gfSYApxrdoBENvMJfxkUH8qcgc/6ehPtBIg0dTnE+7KQ?=
 =?us-ascii?Q?DLUv79h4nmK3TgdaYhV9ck3TB28DGxXEZhXFMmtAUrZBl6f3JFNt0+vikf/2?=
 =?us-ascii?Q?DUNb4qlN7pvRJ5lnzzrsSv6793+9eHot/gFLBfMUr+qRR3rM+5hkNgRIDypq?=
 =?us-ascii?Q?BtMIxGdWaPQ33jWbqpH10Ve5K5jBlNSfedQWEgSnJjgT04xLacT1qCDb7sb4?=
 =?us-ascii?Q?VOiOWyQF7iLrXuqYo+21cfMeHQJPotn2gvMn2LDX54I6eGYTiLRqOB3K5Kda?=
 =?us-ascii?Q?n1TxxVyULQLz367Z/sotrO5ndrJPfSx9pWsdlCunLVBX1fETTW2dubrHj8Jn?=
 =?us-ascii?Q?s9yOpd30lVkVVTeux2Z2R+YlGVbb82bvbWxVgPg2IksxVbf3ZvQm/RNE50D8?=
 =?us-ascii?Q?LGVaoUDMRVgItbDB2OTGQffwWsCaf4wmov0qUk7O0Dd4+SoBf8GIsR23xwIq?=
 =?us-ascii?Q?MGP3M/ooCPDidfMnLAm+YfO3OwWJpaMY8/Dkvo9gBKzGefv16dy6KXrXL72/?=
 =?us-ascii?Q?5oMIQDCGiJFXM8wu3WzwRxjxPvr6Vo7E507ssdKR+9n4JjXz/8jChf26rKjK?=
 =?us-ascii?Q?bvp7obMqpJTxwCHTRSsmI20ZN8nN382ItUeZ6ow4mfXmSEv1QI/uR5lc4ude?=
 =?us-ascii?Q?8WXai/XIxwt0E/NUfwXcD16pEIgpn4uAgxGVzFAt3Iiywf+RISC8/fhGBOCF?=
 =?us-ascii?Q?4EqkRA5ZYFcdgpGEWZfddIXwZOfM9ctU2gw1nU18u+5slnq2NHMrG0iwOX4X?=
 =?us-ascii?Q?UpsaDg4hmn63kEVQmg3+772A0yvCbAUInnN+y9ZrH5pBVINSd018mS4XcN1q?=
 =?us-ascii?Q?HU30/OW1lQbrT2d+YISF4FPPIHVB2jHpdlK8Lg+cTLfCi6ivWYCPq3r8vDcT?=
 =?us-ascii?Q?5bVnQtOkBWOeaeePEEVCrsJ+GWmjs9FDW5SY/KPxJmR1AOAcS6HPctJqS6Zt?=
 =?us-ascii?Q?HxSlTtiTs0xCClQy4z7BCav7cCkUpoLDXGCA3Be+crQzJovpJiPMX0NLeiye?=
 =?us-ascii?Q?MyBM7/gwEYFIcOQ2xkUn6BP6U10kKWEPYKNp4hovzK1OKHS1l5NCPMoJgb0U?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c919e7f-b620-4f11-c25d-08de0c8a2ad8
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:01:09.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivatABNa7RPtj5cldYzK9h1ofxZwzHrKBdmEJ00pj9VksFgnlFpAVsWnBMGE3HegrzGyOLMpHO1eaN2M0FhLLfn++AbWjpjLUojO0jwnoQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1308

VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.

Board features:
- JH7110S SoC
- 4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 1x USB 3.0 host port
- 3x USB 2.0 host port
- 1x M.2 M-Key (size: 2242)
- 1x MicroSD slot (optional non-removable 64GiB eMMC)
- 1x QSPI Flash
- 1x I2C EEPROM
- 1x 1Gbps Ethernet port
- SDIO-based Wi-Fi & UART-based Bluetooth
- 1x HDMI port
- 1x 2-lane DSI
- 1x 2-lane CSI

VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/Makefile         |  2 ++
 .../jh7110s-starfive-visionfive-2-lite.dts    | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 62b659f89ba7..f53109253d41 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -15,3 +15,5 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-lite.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
+
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110s-starfive-visionfive-2-lite.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
new file mode 100644
index 000000000000..ac5e66027bad
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 StarFive Technology Co., Ltd.
+ * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
+ */
+
+/dts-v1/;
+#include "jh7110s-starfive-visionfive-2-lite.dtsi"
+
+/ {
+	model = "StarFive VisionFive 2 Lite";
+	compatible = "starfive,visionfive-2-lite", "starfive,jh7110s";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
+	disable-wp;
+	cap-sd-highspeed;
+};
-- 
2.43.2


