Return-Path: <linux-kernel+bounces-855741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF28BE229E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 766124EC4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338CB2FF14D;
	Thu, 16 Oct 2025 08:34:23 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2133.outbound.protection.partner.outlook.cn [139.219.146.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61A145348;
	Thu, 16 Oct 2025 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603662; cv=fail; b=ZcVivxR3PheW7tUOdv4hns8nFS29QWCX9Jbwmu3aMtkhiROF4VEL2ucqCaDN5Ge8bVwMcUBfu6r4qbaErAVsBmzDui3pebs3PP9uPgJE9O1y+Mm+xMew1y6b41kkyRwnW37+aV8BtFrp19BphJUK45mzJDyDIqOoUXD7rAiYUqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603662; c=relaxed/simple;
	bh=LffuFy0o+ak0sYVtamZtfM1tkLci4+dbgr5HAogXeVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bguFnvakxEdvBeBr+pY5AD/sW4ngR7gM3izZqxLV/Ia1Vii3lJv6BjqWx897y1rIRu5OTkdZsKxpH3/o5YqE710X5mpMAfdNfoueiSEu0Qnv6WGa4VDea6WJ6OaCuPZ47xZpi2VRFu8YDawftDgB3Wr+aDxgYCSMZkX8z6nOns8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdYN8qwIlfNCdamwENSIJFhUKqEFu+YSkV3P/eQcN+OpKmkmKGflsbwUQr+v1dOgooWFGve+tmDBbyWSLMIQh0cyYEJrf6aDwPg0arW6/6c4Ah7sEgQcu+52h2voDBlVPxwSIPjMnOvD3kbwLeZc/eUTupWvjBR9yH60lvpynYut6+TlgzcSZz8Jxv1cHmHHoj+gT8v/8DMf1L4+K4zBK1KoiR30seEtZshfsXq8gGPLbodX6hStWUle82dlTnUEiyBIHwbXgCZSOvgThX63vt5EsR0pN1pcqwvjizEpxgM3Tr1v8vGXgOc/aIhdfIULan0kbTwBDBfp55KYOD9obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kXPRul5UgqNQ91FZuNxL8MCd5ZCkwkQkOLYKss6ByM=;
 b=XZ/D/Fb4hkXxpT7pTS2KRp1bK5AXWP1tgkGPlkCFslY+ScykeXXIFrKhY3oC1uZr9TmWcd5/rB2PQZlb77BIEsGFklMgPP8kP1RIoFygYFCW7IOzSMnKpjZLO+kqQucd4J4NF99ZEovLSvU/hMlCo9Via/PPAKeqCqNu5D0+EtumYzD7dFmkQI9rKPliI6E0qvqj6QNC5qn463khYdRJvM+E7LKDKKNXejtGTJ0yGPB6xDzn7WISLvZyEr44x5Yo+v0YVLuklh2+y/tiVN5LjIfHM+ayQ+aASSpscIM/nqwBI8vbX71ChcLhYAXw0+qx6LOzv+9DgyEbgpgOlx17LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Thu, 16 Oct
 2025 08:01:11 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9182.020; Thu, 16 Oct 2025
 08:01:11 +0000
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
Subject: [PATCH v1 7/7] riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree
Date: Thu, 16 Oct 2025 16:00:54 +0800
Message-ID: <20251016080054.12484-8-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: d04bd4d9-28b6-4cc9-a876-08de0c8a2b8c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|41320700013|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	elSKiNQNqM1l8u5YaBkvYvQ7xDDEB8Fx11WO5kuUHSsK1mDKiNxGa/Pr/QccK4T0DBBHTyqFgp+8xvMlsduMSf+7QGTSmSiDwP6qrXgUuoVEb9abrX/Q8UfbaTvLy4umL/Iuzye1R7k7MHpbIhfWxNHmtGRqVuBgDQVFD/fEZeOJ6DhywRZt27x4BMjn3BaJa1oSSxh99Q+WCqssempjlLDpxf4XN473EF4MFe6pB7cZhIE0HjMrREF0phmmYM3J6HeFKjiQQ1LwSERQ7/dNBUQd0OuINp557rqxEG04lrB8Kibk700h42LOKAFgCu3HXbM7qYLPZq8SYajEa/Kne5KgOl50cLt855ygPU+2oKbtwNAeZO9coNXSuyWWNPhC/8mctGdtxajc31k87AZXlpPHm5ddGwCNnWdK4PE5MvROSGRUOAnf8FIUi1A0dV25334OkSXr5HneKZ6yD4rowm1MewZTQyKdwHzkZHTGrw5n323Am03jMEMQGHYMXn++kI+XCCfptndTZBbQSGLv9j2XZIsSAHKTXVbvXr6WQAG/lBoraNac29rC/VqSGHte/rZvjDjHT9yRvhOCVDN6mgvo6aAwJQR4BJz5wh3WhV0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(41320700013)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lxzPeheErrwsgk6CgCOIejkb/o1+7rCXJLF0lMbQ7Ros7W0gnAVDrqfXwoxd?=
 =?us-ascii?Q?tYfxLSSRkRnQ0TdJISeFNIaZyyIbu1XBSyAQzjXcCuoNNKrsz3Sar+4wTEHG?=
 =?us-ascii?Q?l/IinGoqHbgsmE283wj9kSXe3QGYxZldpyvjw37NVYbu4gMkKgGNDdzbwrhU?=
 =?us-ascii?Q?eOBxAtg5Hw/w5LwsCMEunqH0NqYdVP7L4w/8BxMdsbfzCWq0gSiEbg03zvbZ?=
 =?us-ascii?Q?3yC14gHLxanuQyd5UqKNSj/AVlN66XiyiRwqoRdoogt075PoBMo3AghUhzB9?=
 =?us-ascii?Q?LpF+rKrdmZ++PdPW+nN/g1PX9SvWsKS1CE5nmrYf5syUAxQfZE8Yv1CrmV7X?=
 =?us-ascii?Q?8wi42emjhX3afcBapnvCiRqGlSZ6zzHwjqWsndsP/kxVJjfYJ6y3t6rN19gZ?=
 =?us-ascii?Q?sazEom9cLKJ51o03VUhAKtrV2fB8DAqpL0vF6j1ul0IbXnPd5A+KriQJf+YL?=
 =?us-ascii?Q?n7a4Hyy9HptgT5e2XLvW7RoOW5aepIt78193YREZi5EST6Mt+3z6HG3hIluS?=
 =?us-ascii?Q?z0FHq/sKZLtvq+PYCc3a1A64MXq/ji2RTCy0IZSl7Ng5qki5wo8D28kDPSnQ?=
 =?us-ascii?Q?J9+tQo8QeIVEg1pxksy+WTKDF45E6TS8CCwI1IZH1+vmjGvo8TjsFxTVM41O?=
 =?us-ascii?Q?MjTwgdHJrkUbr2ANbcwuJuRydXtIcIDcsLpB+8WGbImNZKx6k4YvGGCFHWh9?=
 =?us-ascii?Q?nQyif3XkvSO8kH5Tyq6+rYHcsP6BO9egQ2C9s1XLelFkYGaExxQlX7xDZaco?=
 =?us-ascii?Q?U8sk1xOCTmp+iwTIqEZ4CZjTuYOiUSqhT44AKBecDpjIZKiA5Zlt6RiLMRT1?=
 =?us-ascii?Q?ijFAV3v81ABziu5omLoLwQkbRr/z5pzyYRBuccS0bWBB9SLR50UOvvV1pkiP?=
 =?us-ascii?Q?Zc7V6u5lxa8JLtBq5FyoJmpz2oCZnlE0EJ+ACJCArAmU/HkwYNR+Z4Zm7ZoK?=
 =?us-ascii?Q?yw1c7W4EZHO0XWlo1CN9r0FlIsDkp2HT9y76UBHoZDzCyMPfrW8TsuEGiUm9?=
 =?us-ascii?Q?r0xHV6ADU54RxA1P2RDjkomUKh+yYhvVIbD31qovVZa3WDRqFOCuFufqBVAN?=
 =?us-ascii?Q?jKTVkq2Omd6+HY336rdZFMESn2BOMq8+PhE/7sdaCjfOQ8aDtpGYARIrfuq6?=
 =?us-ascii?Q?zJHydmDAMpPppvCX79opRHp1Wwj5E85YJ7ulxbkoecl6Tnl941pKu/ELDPX5?=
 =?us-ascii?Q?pvT2239LCIo7qrJoF5rf7YlkEbN11LUcteEcQ263+C2/43/DXLMU0MIlKzkM?=
 =?us-ascii?Q?U4+R7nbjokDD/2TR+9ALR3RFpq93LNmz8BubM4R5Rkbkv7inn3ii+KpKGJee?=
 =?us-ascii?Q?J4s/MsJWUClW14UBrIEkuX3na7sGHdDukdQzJMH6/Me6IhJggrSVvZAiSx2v?=
 =?us-ascii?Q?gIIdVLntxSKeNWM9SNYN5LejLzMW8QNtGLYnW6zEF8Y9WWdphh2XK9g/mDgW?=
 =?us-ascii?Q?eoC+WLHS0ouw5KbEb9h2i0a4l0JtlnAsWuwAQI1mLCSCQg9NQ0f4Mi0H+ax+?=
 =?us-ascii?Q?LyH/2jZq4Wo44+iCzXK25V0sXKLm+ZZ2pCUUYK/bhyFK7t87JBESyE9lJPOj?=
 =?us-ascii?Q?/mg8tUeLQqcdIP4XTFybDAqtCZDwSOkiXox1i9Du8stu6BlGDUFi4C8PIICn?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04bd4d9-28b6-4cc9-a876-08de0c8a2b8c
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:01:10.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RoUo+bEcDBuNrs1WNfu16HoaSD2dq3uRlf3n60SiLjGvD9nG4LZCrEliwKLJHEv4FUs8YjRdsC9+14zlrziSxDuV7wQzV/DC+RGhp4hfLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1308

VisionFive 2 Lite eMMC board uses a non-removable onboard 64GiB eMMC
instead of the MicroSD slot.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 ...h7110s-starfive-visionfive-2-lite-emmc.dts | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite-emmc.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index f53109253d41..a60244803829 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -17,3 +17,4 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
 
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110s-starfive-visionfive-2-lite.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110s-starfive-visionfive-2-lite-emmc.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite-emmc.dts b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite-emmc.dts
new file mode 100644
index 000000000000..60ce2753f2d1
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite-emmc.dts
@@ -0,0 +1,22 @@
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
+	model = "StarFive VisionFive 2 Lite eMMC";
+	compatible = "starfive,visionfive-2-lite-emmc", "starfive,jh7110s";
+};
+
+&mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+};
-- 
2.43.2


