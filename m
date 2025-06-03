Return-Path: <linux-kernel+bounces-672352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8635CACCE3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 22:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306AB3A47AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862781F1534;
	Tue,  3 Jun 2025 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eydueFCl"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C4AD23;
	Tue,  3 Jun 2025 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982790; cv=fail; b=P1nAxlsqRJZ93SR/yAQjQUNxiGA35JjCAHtSirNtXOBhf7jfwUq2NIMYOEC8PKKDnjXI6/J6MdkRC3WBExgHB6WVhlA0BkrCbWyfwmt4Vk5FFXMBmgAYp1bSLFmZAmrgi7ei83noTRT8EOS7K0axRmg4XhberMJb2/3sKz0CtNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982790; c=relaxed/simple;
	bh=yMRuVlXMCnYh/y/655WeS/cRuuvUAshjXSZquxlTLaA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=txDtzBKbn3P+D+GmJoOJsh3t0FlTovk4LZJLlPclXv+RJHofIwAO8TFImUPdvJyIFO3GadNQHBH+35btmhu/jwR4NBK3eo5eGYxkx4kRBbz/rTlFuoxkH1kvMyg8sJg0NVVh9FuhYiM11fnredSVqTpkX15EKKkOhIGrN9XTIyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eydueFCl; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/hA6jV7L+Rs0z+3rSL0b/rBDM2YTnuMgvFy4oT2/jMop4+uBsgnT8r5JwvfxtR64H9Hc4FiP3objMEo0E5sCAnzN6HQm7h+QE1hWvLgPl4CPrvEm54F67uXKhY0ceUeOkuElxmlWbuj3eHFcdBSNUDLnImsSpHaAyfvm3Djk0KSitJFFeNe/DA3rWR/kZsp2QrJOZ+vGQ3W8Qm1ol0G9e3Pz2FIb1+WBfDMGHSGGUb5wFl+k1trcOfCVjuVPwciIAPnIN5/SmhLeIN6InAJ6etpmJCNetDZjHYWGOl9mF/F20TpBE6Arg88/CH5jiL2K62Q2zPS6bAgzt/BBantzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e2UdywYZiikOPBuMGxepMoUgnf5a51omZS2ejnoOGI=;
 b=HyjsAsoHHD0WNuXFAIua3tFo8Y3NJxGv60kA1TO4eHVGZ7zOJ4PaMQu/XjgfZM0GwuyZ5FmsvKiK3fKaE4r3UVHZAZZD/S9m5QOQsRiyWo8R+zCyHeMpT1Xsu8fIMcKYkUdDwmxnfa9UOTjBArR+2MlMnJCUhWxtK2YD+6aWmJK4W/JJiSuFw74R1yqyDFwlGOvwz2MavQaPZRvDd20Sfc/PPuNFGlzztq9rD6j+LpF9zY+Uw/6rrUqdLXbkHLnqwbyFVF4SEEybIVjAfyGGSco9kUw0O6XTbLJnY/frQwcpWGSTrexzjU8uOIcs0G6VYdWDd8MStvR2uSHFqGtI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e2UdywYZiikOPBuMGxepMoUgnf5a51omZS2ejnoOGI=;
 b=eydueFClsuRh+kYBxtgW5a2Il93j0mV9VC9UbhW4ISYYd4rnW2Z1Su3pIS6PPRTcS1TVi4ZkFUdiL+vz0zCkb0/oz8UaV4S5asFdp0K2hmwxX2ZxlhousRkiLJ+2LAJMKzFWA9jfM9sVFI74gF5INHda6gbgmQ3dFsEzbeepO4rHvNjpLmknlR6Fg4AYCx6FtfCSP8dXRwxQC1miis0Iy7ZsnqcHR6fxCyzc+lisWThHSLYJXC+Aw1LJXuSlmKa5J6c2GuuGieu6oJYsbE1vS/ctI3RO332ilVNStKtP+KmvJMIi6ApADklQnaiUisbT0/486Wbwn3DiaFOZghyukg==
Received: from BL6PEPF0001640D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:14) by DM4PR12MB7717.namprd12.prod.outlook.com
 (2603:10b6:8:103::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Tue, 3 Jun
 2025 20:33:00 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2a01:111:f403:f901::8) by BL6PEPF0001640D.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Tue,
 3 Jun 2025 20:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 20:32:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 13:32:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 13:32:44 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 3 Jun 2025 13:32:43 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Donald
 Shannon" <donalds@nvidia.com>
Subject: [PATCH] ARM: dts: aspeed: Add device tree for Nvidia's GB200 UT3.0b platform BMC
Date: Tue, 3 Jun 2025 13:32:41 -0700
Message-ID: <20250603203241.727401-1-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 83383086-e8f7-4210-0110-08dda2ddd4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9vF3RseYrRk67302GPb5P8pFGxHsIvzbpy3ARM0b6aLiPwVi/pTwN2oZxSPV?=
 =?us-ascii?Q?NkYVoJTvFblyr5gUk9nPwAWTID4s3zbQvM31Hb4C7iGHqV46gTkxuUiOBPtw?=
 =?us-ascii?Q?JzMIw0Kjz15A/j2YWN05N9A9gw6kAUtCswL5wOKFmRNDa+siuJmfcdjA4rRl?=
 =?us-ascii?Q?wnaDSrj54vUh2zHxf5uAy0dOL5EBGtloJV2iNgHfV9eQKWzYkB7qPW1KMSy4?=
 =?us-ascii?Q?wP6Vt71UGOwZY4l+hya3SWC4+FvPr9rkjvW2UU+5/megEmkPu6DivH84VxUV?=
 =?us-ascii?Q?BVa8paaw0BRZFC2lGp5mi4n/ZwoW6R5Hu17pfqFjbdzjUUckabnFKUby7Y9o?=
 =?us-ascii?Q?hKGkYgyNxWCqErYJxbgRRaE4P1u6SDzwNHqWwJIHqEArt3QlHxBlFhEwzSMo?=
 =?us-ascii?Q?4E25DDmwZRnuSyIpTNJd0rB0K4jXmYKmWZR500c2Sd9rePKfjaduGIBFmlBn?=
 =?us-ascii?Q?NOh4637mlsiWnVhbnqddRpgaq9NwR3ZnDGciYAuToq0/fXrtYhiBf7cYqMDX?=
 =?us-ascii?Q?AuWqSXB10yjVxUjAQ+CGRvcp6YXFEmm9Uocw1D6A+Xr09tOsS1WfQJP9Ie42?=
 =?us-ascii?Q?wgNvrtR+FcIHJcdHkZM/bVq57qtg/HTx5fjUMe0ONMGxjOTN1RiSvad9dPCd?=
 =?us-ascii?Q?TI+HLEPDAoGn4rN74qqPG/BfntwsoFf4u8VAFIf+/krsJKlzL2kulm6ampYz?=
 =?us-ascii?Q?it9DPw3CJLybyG7KbiSNmHnTn17e+xnGJO6Q3OUMHEMpOF+26z02LXDz5y5j?=
 =?us-ascii?Q?KXEJF2bLOaKG1y6gC1LVE3boYGmcmp6nAZZTY0S2CTxJ7fIRmlPegTIs42UT?=
 =?us-ascii?Q?KmM/+kW2fv+MgqXllqVipW8jYd80um15vjI7zSR2urxTff2Kn7d4qLZvKLwC?=
 =?us-ascii?Q?dGmwPm50psN2DnhBVBbJ+UHWez6NUEhOtTSRzPwUmN67MvBYC0jShrk/2ZX/?=
 =?us-ascii?Q?ECLs6vNJgVBzfiGgci9J3LB9sB0iM4/90JPDfVi7l7nvhGWRtEgL7VwISnvV?=
 =?us-ascii?Q?pw3/y9UO6EXp3J/WhNsLIYNWxXUKEWV5nClhXAV7zqC3/mfjzdQMsRGdpTm7?=
 =?us-ascii?Q?k/0lKixAzWy6n8V8MoXufD68zeG4S0LNHPwRIRwRrcHyyghcyufLUyaoZZ5U?=
 =?us-ascii?Q?fizVABTt0ST6UPU+g15Ym7aVi0VpmWwPLRSnK2OcG6xrG2XbyWZCHTbfpTve?=
 =?us-ascii?Q?YPjzpiPRAWJPCbOL5vWUK8SBIKqd+riQWImsAdLoRwRXZnUC9psCFiGb2ua3?=
 =?us-ascii?Q?XzETM8dESoPzZrSNz2LYbhoxIHJ5iHqJcoVLQfDeeLQcgaVtSCQISPUeBRcg?=
 =?us-ascii?Q?OGhCp5vw33cA32ksKN2NZFR2l+uoujA8IINUYSBtyHr7rPvaOhYlHo/hDjVt?=
 =?us-ascii?Q?gmdVLHsyLHDQWnl16e/ZxLo0N/+42/Lb9JXNbhevkcKLymzJpBEg9HrwlIHX?=
 =?us-ascii?Q?2NpZ7cZ91xnCCzxLPdd3bVS3j7Jez9PS74nlcImyjJmhmJ7X4k3fsF8TZtY5?=
 =?us-ascii?Q?DmHQQ8odQO4Hfr0p/DiB2iLyN0obsHUt+MRT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 20:32:59.6768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83383086-e8f7-4210-0110-08dda2ddd4d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717

The GB200NVL UT3.0b BMC is an Aspeed Ast2600 based BMC
for Nvidia Blackwell GB200NVL platform.
Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]

Signed-off-by: Donald Shannon <donalds@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1173 +++++++++++++++++
 2 files changed, 1174 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index b3170fdd3096..fa09d0b61ec2 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
+	aspeed-bmc-nvidia-gb200nvl-ut30b.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts
new file mode 100644
index 000000000000..e2aa33c36e71
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts
@@ -0,0 +1,1173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "AST2600 GB200 UT3.0b BMC";
+	compatible = "nvidia,gb200nvl-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial2 = &uart3;
+		serial4 = &uart5;
+		i2c16   = &imux16;
+		i2c17   = &imux17;
+		i2c18   = &imux18;
+		i2c19   = &imux19;
+		i2c20   = &imux20;
+		i2c21   = &imux21;
+		i2c22   = &imux22;
+		i2c23   = &imux23;
+		i2c24   = &imux24;
+		i2c25   = &imux25;
+		i2c26   = &imux26;
+		i2c27   = &imux27;
+		i2c28   = &imux28;
+		i2c29   = &imux29;
+		i2c30   = &imux30;
+		i2c31   = &imux31;
+		i2c32   = &imux32;
+		i2c33   = &imux33;
+		i2c34   = &imux34;
+		i2c35   = &imux35;
+		i2c36   = &imux36;
+		i2c37   = &imux37;
+		i2c38   = &imux38;
+		i2c39   = &imux39;
+		i2c40	= &e1si2c0;
+		i2c41	= &e1si2c1;
+		i2c42	= &e1si2c2;
+		i2c43	= &e1si2c3;
+		i2c44	= &e1si2c4;
+		i2c45	= &e1si2c5;
+		i2c46	= &e1si2c6;
+		i2c47	= &e1si2c7;
+		i2c48	= &i2c17mux0;
+		i2c49	= &i2c17mux1;
+		i2c50	= &i2c17mux2;
+		i2c51	= &i2c17mux3;
+		i2c52	= &i2c25mux0;
+		i2c53	= &i2c25mux1;
+		i2c54	= &i2c25mux2;
+		i2c55	= &i2c25mux3;
+		i2c56	= &i2c29mux0;
+		i2c57	= &i2c29mux1;
+		i2c58	= &i2c29mux2;
+		i2c59	= &i2c29mux3;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vga_memory: framebuffer@9f000000 {
+			no-map;
+			reg = <0x9f000000 0x01000000>; /* 16M */
+		};
+
+		ramoops@a0000000 {
+			compatible = "ramoops";
+			reg = <0xa0000000 0x100000>; /* 1MB */
+			record-size = <0x10000>; /* 64KB */
+			max-reason = <2>; /* KMSG_DUMP_OOPS */
+		};
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "uid_led";
+			gpios = <&sgpiom0 27 GPIO_ACTIVE_LOW>;
+		};
+		led-1 {
+			label = "fault_led";
+			gpios = <&sgpiom0 29 GPIO_ACTIVE_LOW>;
+		};
+		led-2 {
+			label = "power_led";
+			gpios = <&sgpiom0 31 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	buttons {
+		button-power {
+			label = "power-btn";
+			gpio = <&sgpiom0 156 GPIO_ACTIVE_LOW>;
+		};
+		button-uid {
+			label = "uid-btn";
+			gpio = <&sgpiom0 154 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+    fixedregulator_standby_power: fixedregulator_standby_power {
+		status = "okay";
+		compatible = "regulator-fixed";
+		regulator-name = "standby_power";
+		gpio = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		//startup-delay-us = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+	};
+};
+
+// Enable Primary flash on FMC for bring up activity
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		compatible = "jedec,spi-nor";
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			u-boot@0 {
+				// 896KB
+				reg = <0x0 0xe0000>;
+				label = "u-boot";
+			};
+
+			kernel@100000 {
+				// 9MB
+				reg = <0x100000 0x900000>;
+				label = "kernel";
+			};
+
+			rofs@a00000 {
+				// 55292KB (extends to end of 64MB SPI - 4KB)
+				reg = <0xa00000 0x35FF000>;
+				label = "rofs";
+			};
+		};
+	};
+};
+
+&spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	// Data SPI is 64MB in size
+	flash@0 {
+		status = "okay";
+		label = "config";
+		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			u-boot-env@0 {
+				// 256KB
+				reg = <0x0 0x40000>;
+				label = "u-boot-env";
+			};
+
+			rwfs@40000 {
+				// 16MB
+				reg = <0x40000 0x1000000>;
+				label = "rwfs";
+			};
+
+			log@1040000 {
+				// 40MB
+				reg = <0x1040000 0x2800000>;
+				label = "log";
+			};
+		};
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	// Enabling SOL
+	status = "okay";
+};
+
+&uart5 {
+	// BMC Debug Console
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&mdio0 {
+	status = "okay";
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	phy-mode = "rgmii-rxid";
+	max-speed = <1000>;
+	phy-handle = <&ethphy0>;
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
+/*
+ * Enable USB port A as device (via the virtual hub) to host
+ */
+&vhub {
+	status = "okay";
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+// USB 2.0 to HMC, on USB Port B
+&ehci1 {
+	status = "okay";
+};
+
+// USB 1.0
+&uhci {
+	status = "okay";
+};
+
+&sgpiom0 {
+	status="okay";
+	ngpios = <128>;
+	gpio-line-names =
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"RUN_POWER_FAULT_L-I","SYS_RST_IN_L-O",
+		"RUN_POWER_PG-I","PWR_BRAKE_L-O",
+		"SYS_RST_OUT_L-I","RUN_POWER_EN-O",
+		"L0L1_RST_REQ_OUT_L-I","SHDN_FORCE_L-O",
+		"L2_RST_REQ_OUT_L-I","SHDN_REQ_L-O",
+		"SHDN_OK_L-I","UID_LED_N-O",
+		"BMC_I2C1_FPGA_ALERT_L-I","SYS_FAULT_LED_N-O",
+		"BMC_I2C0_FPGA_ALERT_L-I","PWR_LED_N-O",
+		"FPGA_RSVD_FFU3-I","",
+		"FPGA_RSVD_FFU2-I","",
+		"FPGA_RSVD_FFU1-I","",
+		"FPGA_RSVD_FFU0-I","BMC_I2C_SSIF_ALERT_L-O",
+		"CPU_BOOT_DONE-I","JTAG_MUX_SELECT-O",
+		"SPI_BMC_FPGA_INT_L-I","RTC_CLR_L-O",
+		"THERM_BB_WARN_L-I","UART_MUX_SEL-O",
+		"THERM_BB_OVERT_L-I","",
+		"CPU0_UPHY3_PRSNT1_L-I","IOBRD0_RUN_POWER_EN-O",
+		"CPU0_UPHY3_PRSNT0_L-I","IOBRD1_RUN_POWER_EN-O",
+		"CPU0_UPHY2_PRSNT1_L-I","FPGA_RSVD_FFU4-O",
+		"CPU0_UPHY2_PRSNT0_L-I","FPGA_RSVD_FFU5-O",
+		"CPU0_UPHY1_PRSNT1_L-I","FPGA_RSVD_FFU6-O",
+		"CPU0_UPHY1_PRSNT0_L-I","FPGA_RSVD_FFU7-O",
+		"CPU0_UPHY0_PRSNT1_L-I","RSVD_NV_PLT_DETECT-O",
+		"CPU0_UPHY0_PRSNT0_L-I","SPI1_INT_L-O",
+		"CPU1_UPHY3_PRSNT1_L-I","",
+		"CPU1_UPHY3_PRSNT0_L-I","HMC_EROT_MUX_STATUS",
+		"CPU1_UPHY2_PRSNT1_L-I","",
+		"CPU1_UPHY2_PRSNT0_L-I","",
+		"CPU1_UPHY1_PRSNT1_L-I","",
+		"CPU1_UPHY1_PRSNT0_L-I","",
+		"CPU1_UPHY0_PRSNT1_L-I","",
+		"CPU1_UPHY0_PRSNT0_L-I","",
+		"FAN1_PRESENT_L-I","",
+		"FAN0_PRESENT_L-I","",
+		"","",
+		"IPEX_CABLE_PRSNT_L-I","",
+		"M2_1_PRSNT_L-I","",
+		"M2_0_PRSNT_L-I","",
+		"CPU1_UPHY4_PRSNT1_L-I","",
+		"CPU0_UPHY4_PRSNT0_L-I","",
+		"","",
+		"I2C_RTC_ALERT_L-I","",
+		"FAN7_PRESENT_L-I","",
+		"FAN6_PRESENT_L-I","",
+		"FAN5_PRESENT_L-I","",
+		"FAN4_PRESENT_L-I","",
+		"FAN3_PRESENT_L-I","",
+		"FAN2_PRESENT_L-I","",
+		"IOBRD0_IOX_INT_L-I","",
+		"IOBRD1_PRSNT_L-I","",
+		"IOBRD0_PRSNT_L-I","",
+		"IOBRD1_PWR_GOOD-I","",
+		"IOBRD0_PWR_GOOD-I","",
+		"","",
+		"","",
+		"FAN_FAIL_IN_L-I","",
+		"","",
+		"","",
+		"","",
+		"PDB_CABLE_PRESENT_L-I","",
+		"","",
+		"CHASSIS_PWR_BRK_L-I","",
+		"","",
+		"IOBRD1_IOX_INT_L-I","",
+		"10GBE_SMBALRT_L-I","",
+		"PCIE_WAKE_L-I","",
+		"I2C_M21_ALERT_L-I","",
+		"I2C_M20_ALERT_L-I","",
+		"TRAY_FAST_SHDN_L-I","",
+		"UID_BTN_N-I","",
+		"PWR_BTN_L-I","",
+		"PSU_SMB_ALERT_L-I","",
+		"","",
+		"","",
+		"NODE_LOC_ID[0]-I","",
+		"NODE_LOC_ID[1]-I","",
+		"NODE_LOC_ID[2]-I","",
+		"NODE_LOC_ID[3]-I","",
+		"NODE_LOC_ID[4]-I","",
+		"NODE_LOC_ID[5]-I","",
+		"FAN10_PRESENT_L-I","",
+		"FAN9_PRESENT_L-I","",
+		"FAN8_PRESENT_L-I","",
+		"FPGA1_READY_HMC-I","",
+		"DP_HPD-I","",
+		"HMC_I2C3_FPGA_ALERT_L-I","",
+		"HMC_I2C2_FPGA_ALERT_L-I","",
+		"FPGA0_READY_HMC-I","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"LEAK_DETECT_ALERT_L-I","",
+		"MOD1_B2B_CABLE_PRESENT_L-I","",
+		"MOD1_CLINK_CABLE_PRESENT_L-I","",
+		"FAN11_PRESENT_L-I","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"RSVD_SGPIO_IN_CRC[0]","RSVD_SGPIO_O_CRC[7]",
+		"RSVD_SGPIO_IN_CRC[1]","RSVD_SGPIO_O_CRC[6]",
+		"RSVD_SGPIO_IN_CRC[2]","RSVD_SGPIO_O_CRC[5]",
+		"RSVD_SGPIO_IN_CRC[3]","RSVD_SGPIO_O_CRC[4]",
+		"RSVD_SGPIO_IN_CRC[4]","RSVD_SGPIO_O_CRC[3]",
+		"RSVD_SGPIO_IN_CRC[5]","RSVD_SGPIO_O_CRC[2]",
+		"RSVD_SGPIO_IN_CRC[6]","RSVD_SGPIO_O_CRC[1]",
+		"RSVD_SGPIO_IN_CRC[7]","RSVD_SGPIO_O_CRC[0]";
+};
+
+// I2C1, SSIF IPMI interface
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ssif-bmc@10 {
+		compatible = "ssif-bmc";
+		reg = <0x10>;
+	};
+};
+
+// I2C2
+// BMC_I2C1_FPGA - Secondary FPGA
+// HMC EROT
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+	multi-master;
+};
+
+// I2C3
+// BMC_I2C0_FPGA - Primary FPGA
+// HMC FRU EEPROM
+&i2c2 {
+	status = "okay";
+	clock-frequency = <400000>;
+	multi-master;
+};
+
+// I2C4
+&i2c3 {
+	status = "okay";
+    vcc-supply = <&fixedregulator_standby_power>;
+};
+
+// I2C5
+// RTC Driver
+// IO Expander
+&i2c4 {
+	status = "okay";
+	clock-frequency = <400000>;
+    vcc-supply = <&fixedregulator_standby_power>;
+
+	// Module 0, Expander @0x21
+	exp4: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+        vcc-supply = <&fixedregulator_standby_power>;
+		gpio-line-names =
+			"RTC_MUX_SEL-O",
+			"PCI_MUX_SEL-O",
+			"TPM_MUX_SEL-O",
+			"FAN_MUX-SEL-O",
+			"SGMII_MUX_SEL-O",
+			"DP_MUX_SEL-O",
+			"UPHY3_USB_SEL-O",
+			"NCSI_MUX_SEL-O",
+			"BMC_PHY_RST-O",
+			"RTC_CLR_L-O",
+			"BMC_12V_CTRL-O",
+			"PS_RUN_IO0_PG-I",
+			"",
+			"",
+			"",
+			"";
+	};
+};
+
+// I2C6
+// Module 0/1 I2C MUX x3
+&i2c5 {
+	status = "okay";
+	clock-frequency = <400000>;
+	multi-master;
+    vcc-supply = <&fixedregulator_standby_power>;
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+		i2c-mux-idle-disconnect;
+        vcc-supply = <&fixedregulator_standby_power>;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			i2c-mux@74 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x74>;
+				i2c-mux-idle-disconnect;
+                vcc-supply = <&fixedregulator_standby_power>;
+
+				i2c17mux0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c17mux1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c17mux2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c17mux3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x72>;
+		i2c-mux-idle-disconnect;
+        vcc-supply = <&fixedregulator_standby_power>;
+
+		imux20: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux21: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			gpio@20 {
+				compatible = "nxp,pca9555";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+                vcc-supply = <&fixedregulator_standby_power>;
+				gpio-line-names =
+					"RST_CX_0_L-O",
+					"RST_CX_1_L-O",
+					"CX0_SSD0_PRSNT_L-I",
+					"CX1_SSD1_PRSNT_L-I",
+					"CX_BOOT_CMPLT_CX0-I",
+					"CX_BOOT_CMPLT_CX1-I",
+					"CX_TWARN_CX0_L-I",
+					"CX_TWARN_CX1_L-I",
+					"CX_OVT_SHDN_CX0-I",
+					"CX_OVT_SHDN_CX1-I",
+					"FNP_L_CX0-O",
+					"FNP_L_CX1-O",
+					"",
+					"MCU_GPIO-I",
+					"MCU_RST_N-O",
+					"MCU_RECOVERY_N-O";
+			};
+		};
+
+		imux22: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux23: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@73 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x73>;
+		i2c-mux-idle-disconnect;
+        vcc-supply = <&fixedregulator_standby_power>;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			i2c-mux@70 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x70>;
+				i2c-mux-idle-disconnect;
+                vcc-supply = <&fixedregulator_standby_power>;
+
+				i2c25mux0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c25mux1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c25mux2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c25mux3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		i2c-mux-idle-disconnect;
+        vcc-supply = <&fixedregulator_standby_power>;
+
+		imux28: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux29: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			i2c-mux@74 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x74>;
+				i2c-mux-idle-disconnect;
+                vcc-supply = <&fixedregulator_standby_power>;
+
+				i2c29mux0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c29mux1: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c29mux2: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c29mux3: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+			};
+		};
+
+		imux30: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux31: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@76 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x76>;
+		i2c-mux-idle-disconnect;
+        vcc-supply = <&fixedregulator_standby_power>;
+
+		imux32: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux33: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+                vcc-supply = <&fixedregulator_standby_power>;
+				gpio-line-names =
+					"SEC_RST_CX_0_L-O",
+					"SEC_RST_CX_1_L-O",
+					"SEC_CX0_SSD0_PRSNT_L-I",
+					"SEC_CX1_SSD1_PRSNT_L-I",
+					"SEC_CX_BOOT_CMPLT_CX0-I",
+					"SEC_CX_BOOT_CMPLT_CX1-I",
+					"SEC_CX_TWARN_CX0_L-I",
+					"SEC_CX_TWARN_CX1_L-I",
+					"SEC_CX_OVT_SHDN_CX0-I",
+					"SEC_CX_OVT_SHDN_CX1-I",
+					"SEC_FNP_L_CX0-O",
+					"SEC_FNP_L_CX1-O",
+					"",
+					"SEC_MCU_GPIO-I",
+					"SEC_MCU_RST_N-O",
+					"SEC_MCU_RECOVERY_N-O";
+				};
+		};
+
+		imux34: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux35: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+		i2c-mux-idle-disconnect;
+        vcc-supply = <&fixedregulator_standby_power>;
+
+		imux36: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux37: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux38: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux39: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+// I2C7
+// Module 0/1 Leak Sensors
+// Module 0/1 Fan Controllers
+&i2c6 {
+	status = "okay";
+	clock-frequency = <400000>;
+    vcc-supply = <&fixedregulator_standby_power>;
+
+	pmic@12 {
+		compatible = "ti,lm5066i";
+		reg = <0x12>;
+		shunt-resistor-micro-ohms = <190>;
+		status = "okay";
+	};
+
+	pmic@14 {
+		compatible = "ti,lm5066i";
+		reg = <0x14>;
+		shunt-resistor-micro-ohms = <190>;
+		status = "okay";
+	};
+
+	pwm@20 {
+		compatible = "maxim,max31790";
+		reg = <0x20>;
+	};
+
+	pwm@23 {
+		compatible = "maxim,max31790";
+		reg = <0x23>;
+	};
+
+	pwm@2c {
+		compatible = "maxim,max31790";
+		reg = <0x2c>;
+	};
+
+	pwm@2f {
+		compatible = "maxim,max31790";
+		reg = <0x2f>;
+	};
+};
+
+// I2C9
+// M.2
+&i2c8 {
+	status = "okay";
+	clock-frequency = <400000>;
+	multi-master;
+    vcc-supply = <&fixedregulator_standby_power>;
+};
+
+// I2C10
+// HMC IO Expander
+// Module 0/1 IO Expanders
+&i2c9 {
+	status = "okay";
+	clock-frequency = <400000>;
+    vcc-supply = <&fixedregulator_standby_power>;
+
+	// Module 0, Expander @0x20
+	exp0: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+        vcc-supply = <&fixedregulator_standby_power>;
+		gpio-line-names =
+			"FPGA_THERM_OVERT_L-I",
+			"FPGA_READY_BMC-I",
+			"HMC_BMC_DETECT-O",
+			"HMC_PGOOD-O",
+			"",
+			"BMC_STBY_CYCLE-O",
+			"FPGA_EROT_FATAL_ERROR_L-I",
+			"WP_HW_EXT_CTRL_L-O",
+			"EROT_FPGA_RST_L-O",
+			"FPGA_EROT_RECOVERY_L-O",
+			"BMC_EROT_FPGA_SPI_MUX_SEL-O",
+			"USB_HUB_RESET_L-O",
+			"NCSI_CS1_SEL-O",
+			"SGPIO_EN_L-O",
+			"B2B_IOEXP_INT_L-I",
+			"I2C_BUS_MUX_RESET_L-O";
+	};
+
+	// Module 1, Expander @0x21
+	exp1: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+        vcc-supply = <&fixedregulator_standby_power>;
+		gpio-line-names =
+			"SEC_FPGA_THERM_OVERT_L-I",
+			"SEC_FPGA_READY_BMC-I",
+			"",
+			"",
+			"",
+			"",
+			"SEC_FPGA_EROT_FATAL_ERROR_L-I",
+			"SEC_WP_HW_EXT_CTRL_L-O",
+			"SEC_EROT_FPGA_RST_L-O",
+			"SEC_FPGA_EROT_RECOVERY_L-O",
+			"SEC_BMC_EROT_FPGA_SPI_MUX_SEL-O",
+			"SEC_USB2_HUB_RST_L-O",
+			"",
+			"",
+			"",
+			"SEC_I2C_BUS_MUX_RESET_L-O";
+	};
+
+    // UT3.0b Expander @0x22
+    exp2: gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"BMC1_FANCTRL_FAIL_L-I",
+			"IOEXP_BMC_RST_12V-O",
+			"NODE_RST_STBY_H-O",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"";
+	};
+
+    // UT3.0b Expander @0x23
+    exp3: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"PEXSW_FL_SPI_MUX_SEL-O",
+			"PEX_SW_FATAL_ERROR_3V3_L-I",
+			"IOEXP_PDB_NODE_EN_L-O",
+			"NODE_PWOK_ISO-I",
+			"BMC_FAN_PWR_EN-O",
+			"BMC_ETHERNET_INT-I",
+			"BMC_ENET_RST-O",
+			"IOEXP_BMC_RST_SENSE-O",
+			"BMC_ID-I",
+			"TPM_MUX_3V3_SEL_N-O",
+			"IOEXP_TPM_RST_N-O",
+			"TPM_DOWN_SPI_INT_L-I",
+			"PS_BRD_PGOOD-I",
+			"FP_BUTTON_POWER_N-I",
+			"FP_BUTTON_RESET_N-I",
+			"FP_LED_POWER_GPIOEXP_N-O";
+	};
+};
+
+// I2C11
+// BMC FRU EEPROM
+// BMC Temp Sensor
+&i2c10 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	// BMC FRU EEPROM - 256 bytes
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+// I2C12
+&i2c11 {
+	status = "disabled";
+};
+
+// I2C13
+&i2c12 {
+	status = "disabled";
+};
+
+// I2C14
+// Module 0 UPHY3 SMBus
+&i2c13 {
+	status = "disabled";
+};
+
+// I2C15
+// Module 1 UPHY3 SMBus
+&i2c14 {
+	status = "okay";
+	clock-frequency = <100000>;
+	multi-master;
+    vcc-supply = <&fixedregulator_standby_power>;
+
+	//E1.S drive slot 0-3
+	i2c-mux@77 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+		i2c-mux-idle-disconnect;
+        vcc-supply = <&fixedregulator_standby_power>;
+
+		e1si2c0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		e1si2c1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		e1si2c2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		e1si2c3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+// I2C16
+&i2c15 {
+	status = "okay";
+	clock-frequency = <100000>;
+	multi-master;
+    vcc-supply = <&fixedregulator_standby_power>;
+
+	//E1.S drive slot 4-7
+	i2c-mux@77 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+		i2c-mux-idle-disconnect;
+        vcc-supply = <&fixedregulator_standby_power>;
+
+		e1si2c4: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		e1si2c5: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		e1si2c6: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		e1si2c7: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&rng {
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+		/*A0-A7*/ "", "", "", "", "", "", "", "",
+		/*B0-B7*/ "", "", "", "", "", "", "", "",
+		/*C0-C7*/ "SGPIO_I2C_MUX_SEL-O", "", "", "", "", "", "", "",
+		/*D0-D7*/ "", "", "", "UART1_MUX_SEL-O", "", "FPGA_PEX_RST_L-O", "", "",
+		/*E0-E7*/ "RTL8221_PHY_RST_L-O", "RTL8211_PHY_INT_L-I",	"", "UART3_MUX_SEL-O",
+					"", "", "", "SGPIO_BMC_EN-O",
+		/*F0-F7*/ "", "", "", "", "", "", "", "",
+		/*G0-G7*/ "", "", "", "", "", "", "", "",
+		/*H0-H7*/ "", "", "", "", "", "", "", "",
+		/*I0-I7*/ "", "", "", "", "", "QSPI2_RST_L-O", "GLOBAL_WP_BMC-O", "BMC_DDR4_TEN-O",
+		/*J0-J7*/ "", "", "", "", "", "", "", "",
+		/*K0-K7*/ "", "", "", "", "", "", "", "",
+		/*L0-L7*/ "", "", "", "", "", "", "", "",
+		/*M0-M7*/ "PCIE_EP_RST_EN-O", "BMC_FRU_WP-O", "FPGA_RST_L-O", "STBY_POWER_EN-O",
+					"STBY_POWER_PG-I", "PCIE_EP_RST_L-O", "", "",
+		/*N0-N7*/ "", "", "", "", "", "", "", "",
+		/*O0-O7*/ "", "", "", "", "", "", "", "",
+		/*P0-P7*/ "", "", "", "", "", "", "", "",
+		/*Q0-Q7*/ "", "", "", "", "", "", "", "",
+		/*R0-R7*/ "", "", "", "", "", "", "", "",
+		/*S0-S7*/ "", "", "", "", "", "", "", "",
+		/*T0-T7*/ "", "", "", "", "", "", "", "",
+		/*U0-U7*/ "", "", "", "", "", "", "", "",
+		/*V0-V7*/ "AP_EROT_REQ-O", "EROT_AP_GNT-I", "", "","PCB_TEMP_ALERT-I", "","", "",
+		/*W0-W7*/ "", "", "", "", "", "", "", "",
+		/*X0-X7*/ "", "", "TPM_MUX_SEL-O", "", "", "", "", "",
+		/*Y0-Y7*/ "", "", "", "EMMC_RST-O", "","", "", "",
+		/*Z0-Z7*/ "BMC_READY-O","", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	/* 36 1.8V GPIOs */
+	gpio-line-names =
+		/*A0-A7*/ "", "", "", "", "", "", "", "",
+		/*B0-B7*/ "", "", "", "", "", "", "IO_EXPANDER_INT_L-I","",
+		/*C0-C7*/ "", "", "", "", "", "", "", "",
+		/*D0-D7*/ "", "", "", "", "", "", "SPI_HOST_TPM_RST_L-O", "SPI_BMC_FPGA_INT_L-I",
+		/*E0-E7*/ "", "", "", "", "", "", "", "";
+};
-- 
2.43.0


