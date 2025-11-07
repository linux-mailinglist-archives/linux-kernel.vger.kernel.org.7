Return-Path: <linux-kernel+bounces-890204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF272C3F812
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35BD134DC4D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6831D751;
	Fri,  7 Nov 2025 10:30:26 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0F31A542;
	Fri,  7 Nov 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511422; cv=fail; b=ZOXqqhem1RhGIjcV2SJSSVPHN8q3wbDlknmyGah6dahgR1UUTtccy0sTSZC/FNeD/W4fhaH//ifoL28r4LjN1Pc6Fub1Tv3fJNakOXl7t0jc4iPVE2MpAkM4u+3StHF31XhRTxEGNegAhx46JH8msa9VSOszzknF4HEQs865Z2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511422; c=relaxed/simple;
	bh=LffuFy0o+ak0sYVtamZtfM1tkLci4+dbgr5HAogXeVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaphqUZmszk/+FmvDqPFp9RNKdOkiaiaoOB34xzhTkkNUswm+yjUJ8BMegATecIb/0HDQUX2Ygani9hrLkAU54I9hfob8HkoMOkQtHkHy0qaA1X+Ayj2mgj+WDP1/ehpC18aVM28fK85m4PC2rFANUd63aePmGNmZgNZBXoLak4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWvBSdDXXbOomf87+spAhKSGTyJIVdrYdAIzj6tI72ZrR7BSl/2NG9/X5ZApcazLsavUMBEF5WB6rF6h0GdM/mZFJI6HkvmJyIlFVib/jhdFvoD+g9EchCkSQCZkPejmaiI8r1vzkiX3IVUk928irlcmdVx9d8mohvPJTLJ/9GCf3v0OxtxyG/jeer0RT6GzeNVML6IsF5BAHIHVeFCKEnnI24U7oDvdbfj/0Ax9+PaKxfrGqLWFT2XgjPp2ElCYDsLcEiUDkZ/H3XjqUqj8OKglcwpEb/TJ99sq/IlFfkuAsM7rgG2GPVIda8wlkXqj+pFZRsizIAAIVzlY8a0vbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kXPRul5UgqNQ91FZuNxL8MCd5ZCkwkQkOLYKss6ByM=;
 b=Z7RCPJC0/AkiNlBVO0Ga2Wg/mz3x+mpHUata2lkeRPhhUis0i43OZDxAEqxQiaRxmapOHJFKFztF7bWjxvtbRxYuMJLsLRtsRt0fprj9vAvFTBvUcxH5xV9b6C+h9gJ/1NTFYvjdfmwPW/lvzxhCGs8JQhBLZ6Y1VoVvFSPmpJ+acyWQLN5V/f5OlHUdH8UT8UV3ftjPyzwHXFRKsKgOefJehuCEw21kgxEIRY1ZhoMDDRJOfl7eo3it8bwCZOx2YRMrez1/Mg80E/oClpwcy8W0baA8JWieW5g+ll5Pk8inbUl6BklTLyuVsh6+m9bQVBKpZEE7lwjQgDkc05PGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:55:47 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:55:47 +0000
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
Subject: [PATCH v2 8/8] riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree
Date: Fri,  7 Nov 2025 17:55:30 +0800
Message-ID: <20251107095530.114775-9-hal.feng@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb8fe6f-6a7d-4adc-f1ae-08de1de3d36b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|41320700013|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	90hR7ZVPH81Lj3uQtD/YY7U6ZuBGfP4LVEMuIwGoi/OOpY0At2W9kDP3uJ9+OzdgxST3/f3DlGrpd0f6a9ni4rnh+T6UtwwizOxMNvMXmlJXQd8t3wzctbk4TM8fsRp/M4/wclsn0KkZCeDb40zpFPS55ejMPXICw1MkqMYpocg65WeAA0ailapdisav6zAGp1gnKaq9xQfd+Wo4lGfilJWWbD/2wVUMqBgb88Xqa2nFm9Bc+jkuvAhKVFs0jE9S4mnygDi+u2bVTPiNZ/T01y89n/WKx/uKxuLQqd+Exf37+LFTr44LAGRX83fC2yQPmiM/0AF0UFU5iBfXjJ4JjUA3McnevOCbrADJ6SP9Wo/nzTq7TYlHEx3VUOwGQt7jfznEo9N+zXCcKrCXK/PHhnV6DqG4Y5FXWLomcYFHRd1ImR90eluSCFeiFLF7FuVM0ZT10xcqBuWVHzPhg856SyTGks8xd4B9vM4Jl3Nqt3xY5myaL+8WH0XsX6TsZvX0w6fxgVMIS5KS8AzbsV+fficC/cfZxrdcsT1w4SDLVqgov8pbMl6ThtgFPIGuIWKkLc01bE6xbrivp9GMvsqByTRHrjXfK3kdnu/JyOznM1A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(41320700013)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O9F6TYOtHI1AKsfliBsMnIxAM8fbE321VcZxH8e9dfbn5vaBwwhPaB6lBnsH?=
 =?us-ascii?Q?OCQR2nxXTitrGwT41PUQQ78kZlSmHnk+txhs5kkkKCt53v5APDTI6C5G1T0M?=
 =?us-ascii?Q?A89wNnjYrnmlBLYthAk6jLW0WWEw63UqNhi0nP9rAvTQhw6l/L7GQIPO4aJ2?=
 =?us-ascii?Q?unDj8y0KGc1HBQ/PccMCajaCdKh+63JVV5xn34qaqzaJoBVRtcPIPxxmzvmn?=
 =?us-ascii?Q?rJxSZFGKZtxnZsrtfVb9BM55o4sbXNiY9ptlefschP49BcI0yaq3DBLniRcK?=
 =?us-ascii?Q?kaO0KKQ7JtD73ca8ODtkXtQmRAVsLsZjZTUBDD2FV9rwJTpTLoblEHcTAqMd?=
 =?us-ascii?Q?WyETUfva/JhgXVO5lukO1JuTUobS8Yv5xhISuN/FDmVGc7py1XJzZ2KILdt5?=
 =?us-ascii?Q?DUDgGN2Pb/aXEWhKvl22E2evgGb168VPHLwDKhD80HiwRTTBxQjJMgf4cpMO?=
 =?us-ascii?Q?iGahHefAedQBmr4YMXh1F6GgBLmeK+CfdJuyg5eFKozZmcBuoHjOFaYoi7OO?=
 =?us-ascii?Q?/q59ugLGPQCm3qKSDRO2CiMaPfhUI1RboerMzl2xCco2gB9b10LucxYlZTMv?=
 =?us-ascii?Q?Til8uETHB6QHtTcO6D0ssijWTyg/H1G1MfQwIhd0Qr17ydtvP5NYHtC5W8Yo?=
 =?us-ascii?Q?RTlDXiABW7fnWCPAkpVGUoSNC6Rs8PYHGk3Xqc7r9mwvaicDNiLM561wN7UP?=
 =?us-ascii?Q?zsU6pm6h4qxVlUgnunUB6Z02i5Ql17uAsKP5clfTzDmC3oTqqo9Wa8606YMR?=
 =?us-ascii?Q?u+xK3H2pauCPmEY6UVzopyv++mZn38P6gj8A1EI8vuK2RaQVbab8aagRU8Kk?=
 =?us-ascii?Q?zBW0/1YiGjlby+0Dcsn9RnAJZi6dOiMl4BLw451PIYwnOUO5EXSB2orBgQ4b?=
 =?us-ascii?Q?lB9aA7EgsP+8sB5wH03adHKAI9VaER6r7Fm32c0UxibYT37HaKv3oGwALLDa?=
 =?us-ascii?Q?RRMRhj30ckcZSN5bfl5dVQCByVFqY+F5J4lQOBhJ2KgG2cb3rkZcSVyXOKN3?=
 =?us-ascii?Q?5Pf9EGZDSlxnWU9SKk0qTNxTaTvjukPMCXU0zZEU+mQr8WkCqwj4cmZkMo57?=
 =?us-ascii?Q?KIFM6OlfvPgqMd4QGQYhxEGjWt9iMAZBvUCCW8MdmjzGRWilD9S+saJjNwA8?=
 =?us-ascii?Q?dxeY3EjI7gESmBGAnIz6tJxT4f0lwXmMgUYIrs7WJq9pxA5z7vrB+AoLur5P?=
 =?us-ascii?Q?63/FrN9QRXx0nrE4AJqibeUIO+k8Bg57wW3xKHHoYxMHBKFrl9NMzv6ORAkF?=
 =?us-ascii?Q?X1rTpOcw5jL+kFIzJ6o2ii+8SdqX14Iqt1mDt1FAiCbBH8VKOOxDD/zBvGSn?=
 =?us-ascii?Q?Hu1d/lOkftZ1/2s1Mzn84ANXxjjktbpdmugFub89i6eFfGHT5nhuvpfHsFj1?=
 =?us-ascii?Q?hoBWK0Kj7lRaE4uLiLRFOvYW/rtqJD3IfdX1X1XbqcN71GWthx3wCUBCP48U?=
 =?us-ascii?Q?d96AaSuZS3GY1Hwzf4wgBAyzB5gsqIDusRyLYYIGDZPHCi0mZWaIZA9Pctuu?=
 =?us-ascii?Q?JG6vN41Dh8RUSINHDVqQo7+oQHJBC6ygdM6QwoGHKjBM5j/P3MHwLQQdiriZ?=
 =?us-ascii?Q?bQtSR5iYWRmLn+MNZiFvIcL+H8R1L+LwQWWTdCBK1TFqrbHchKQXF4Z84sa4?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb8fe6f-6a7d-4adc-f1ae-08de1de3d36b
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:55:47.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFiuM9zGQIRd0iYaTnlg+iFBscbwKtuXFM9YzvhV/cbTPjnIIbu2JQ0mharYVuRkNf3dQvZA6PKszYTP3Bw4gSfUTWwHIGR9NDMluj5zX4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1305

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


