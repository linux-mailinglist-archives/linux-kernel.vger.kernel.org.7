Return-Path: <linux-kernel+bounces-674029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDD5ACE8F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 06:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A11895544
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 04:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683E5145B3E;
	Thu,  5 Jun 2025 04:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sCFXstNa"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477C63B19A;
	Thu,  5 Jun 2025 04:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749096995; cv=fail; b=ulbQAofI1AYozx0s63hXZOD5K5EPp6cj9MIZlcwpQ7A6DK63TAsKmU1Lrtqdm6+n9pFpAG4LDzTWRpfnCq+v1auGKkZ4nFAwi4KAlKyDrLcWNKj9Bl0XTwnKXxeM1CC18g9m8OUNqXw+9q7iYyZ7NMuk4mm2K9v50g0ImQGzWdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749096995; c=relaxed/simple;
	bh=VGz3xv8wrmkr/UJ0S/4C3Ccd8g8J0Nl9XK40DhbUjB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mv3c53ZXA5WwyOdoCOMIT63ZdKVoJ+2pBW0L215uyJ2NxPPw6eGx2VxKeEg5cbkoEXJcvzZyYI0j402VccQnSIS7mD5OmBWo+AZmVrMi0T97nfw7cg12hULKOOv3+bjPU3hJy68FOK2YefoVE3Vri1LJcfwEOACzjiix5ibKPx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sCFXstNa; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaTg/NNcujXCw9tlpaEfCKkFbyoNHOOfkLedSoYttGRghtFDqU1vZfahTR3OYDmmzJB3IosOcv29B7MRWXg15NyxVzXxoIsoubgkmFPIGhaqeT+fBZerJrj1f/3z1IBL7NalQK260hkDrvdLl4RXaV/cxjtWMW1U2JxXlVU5TjSp4tLF+BidlGKb+cFXCcuHXRese2VIDsiGrHL0fPn+YnPmUCTbzZCBUm/+Bd7+/u1VGY8xVqWnvLYIwwlF+e8zkBevSomSwTa8VUSuagADlA7pFm0ZJmfA91k0kLXk5PmwFc408vw7lrMTifJ7uGeMjEw0rPgXSVS5OZtSpzCU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P62/RFK2zzrBmag+jdudsF0tBvkRDgoEgmlCEPfEbis=;
 b=ODLCXfXcSZqtMFcQVco+fq63buNXsWNR1Gpv2aJv6dRv+Dkhn1n6i6SR1mJHUf45uqo/yq4/sZhoFy1zXRGjRM/JtBrO91rxjApXGSmeBOdf1UInIKUExH66ysrnx922P9mzU6FFTNc175kXuyVuy/0V8F+yBQJz9RT354d8t9d7vu2qX+YihB0GrGgnR4rUwG9ouWarPdH99whounsF1q2sO+OmBRjBqJF3TtE+lzHhV/ZWp/19+HJKTzE/Yyf3USW7/mfGPum5HqQt3yDwV1FKNAh5ekjQoDVDa5p6LbtUg3YAy79MbQZYiy35kJydOdKvN8Y5ocq9JeTnB4tHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P62/RFK2zzrBmag+jdudsF0tBvkRDgoEgmlCEPfEbis=;
 b=sCFXstNa55GqvGhYijhBofMHcqgdp4ALMwebOkZ/jwoLpT+VXoTiqWT4A1zN4pJwFa1i4ebL84B5QE9Ly1chJFru6UhnanXT+scZitaWtNAdBAXOOkeCyaKWBePMcWBNxiDgY8Ze61Hrxj41NFTjth9enIU1lbDQOV1yiSzGuoU3VTIpu33OZmLzfeUlbMQpCdGltoCDrOZm0w0FL2q0PpAqlaxdczPek+LO/fUz8v4NzIm4KzuGd4HXZPHAH+rn6+zrDrK8Jd00KiWJCSPXA4+K4H4cqpGn/3LUuBDdojYKevtu5yaS5TT75/6eyZVz5szpMk2fpRXQ1LKTPiYTZw==
Received: from MN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:52f::6)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 04:16:18 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::6e) by MN0PR03CA0007.outlook.office365.com
 (2603:10b6:208:52f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 5 Jun 2025 04:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 04:16:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 21:16:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 4 Jun 2025 21:16:04 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 4 Jun 2025 21:16:04 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Donald
 Shannon" <donalds@nvidia.com>
Subject: [PATCH v3 1/1] ARM: dts: aspeed: Add device tree for Nvidia's GB200 UT3.0b platform BMC
Date: Wed, 4 Jun 2025 21:15:51 -0700
Message-ID: <20250605041550.1940089-3-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605041550.1940089-2-donalds@nvidia.com>
References: <20250605041550.1940089-2-donalds@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d4065b-f0e2-4da3-efd9-08dda3e7b811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oHVn5VupDqm77zcBjsKssxGDID79UgIHLPlq3ZXFf15fPkYJ0hCiy+T07Dsq?=
 =?us-ascii?Q?GcwJBwT5cQaet/cjIDYH7+Nav4phLgBu/VSrOZqfjVO37Xf9Gsw8Cmd4J6zX?=
 =?us-ascii?Q?fP2jN0GUAcWDTcRHf0cy9HFjnfYeN/ecpKc+6lM6jQGJJk1tp/5xfChU3aMQ?=
 =?us-ascii?Q?3/x0YJJlEDRYO+5AjoVo2109Mm1OExs1NLcOXC140yBxI6lwOJ4aahJo7vYK?=
 =?us-ascii?Q?I+XttZc6YgcaJ9j5BIHC8owMswHzbkBukmM1HERMXTmOCnHqI/L0orfjesQ9?=
 =?us-ascii?Q?yIM61K4xFhdT21XWeA6KtvxPI+tT89lNKrEfkMCaquFkwiiBILx88+d9y/+H?=
 =?us-ascii?Q?vEINnliGx1DtmRlrRTicTvXhLS6gJ8o9wRRax/SjFJ+DmVrg2r6Iuw0LhqfR?=
 =?us-ascii?Q?8CkFxV/9UeVeghGfqI4W3RBgb24TKI7Os0kOSZtaB0qbGJqwMeX9TwqLJN5o?=
 =?us-ascii?Q?33QfDVwtIEjRPjzBwp3L5WBrcBLJ4BoSiHZLXDpMV6eDNU3tqb1s/bwxv9ex?=
 =?us-ascii?Q?3R+t40KQGjs4fgMJWUet9sunoOKFxVRu3YIcFMoIURl3JPCjhtuDNvxdALi3?=
 =?us-ascii?Q?20bgL2DNmPeSbRKpmZh4iYvEUldzUaeXng7jrilJf8ol686A5LMjfn1AI8IC?=
 =?us-ascii?Q?3q0NEz936DihzR7spmoNe000Jx+PD/juOXQH5hOjqBA1eTqevPV3hhRLAro1?=
 =?us-ascii?Q?6Rk3RHeQhwzycJk8uWgzhvTYel7jTqIMEi6LhO0hxusKdfDJHUfwnv+tL/63?=
 =?us-ascii?Q?XzdbjqAsmSG5r+0+FRERAgJjved2d0+ns0nY/Xs+rjGCi0sFEGwBSpzkvPrp?=
 =?us-ascii?Q?YSwJmK+gy/Hw3qyXqQcSOIwVH25b5EKft+YZCWHyq66GeAUCjB/v4HFH9ggL?=
 =?us-ascii?Q?UXQUqwsvLbF6tPVDTfMsKx1QrqOpkx52G7kybE3Iei0yu3rAMEOSF7+b0soH?=
 =?us-ascii?Q?WRGzNSAR4eB3xNdUp2293Zs3bqASW+zttZVmMStwFr4Q8h45kZ8PeoLYhvvE?=
 =?us-ascii?Q?s18wMYq3XtY7sbV6hfTOdJce+kzfnD738n0dYOFzxHJqqRZnDjXyuEF1PDzb?=
 =?us-ascii?Q?kicAfoJfsCvSRHsPDHSwvYYiHa6z+1UahZHsPpFqoNbLvBfLafxp2tYo7YoX?=
 =?us-ascii?Q?wVzg8kaA7D1QR2oISrq5sUuSF1iAJKSgslb3o8k6KlNCreeeICqDMHjGT9ld?=
 =?us-ascii?Q?nisn5O7TmVS24pKVejiT8z+YjmZ3JSseh6uRpeWa+2HyN4aG9k65yOLyLioF?=
 =?us-ascii?Q?AckayxWsb3oHoUjr/Tf+JmMOHILHmElszu4Z61CI82GZyAvlufIIBaJ6ouzu?=
 =?us-ascii?Q?XyYBLSJqFVg/4AYrFU2z1ZfgFCwVvZxtzph0PuG/FSDRRbLEIt8NXMgOoLet?=
 =?us-ascii?Q?xJkwkzbz8FCVBl+xgJgKffDNF1nwrF+ECuP3Iz3v/to/YcF75Pze9af+tYIe?=
 =?us-ascii?Q?QAqw4GOYU49TNqUrUrqzOqFspc98eOHJxkqyW84V3dl5y4bmVpZl9WmtLlBc?=
 =?us-ascii?Q?3BLsBdHYw6cSZKkZQ6Q8PStAbEiWvagclPA2szqVGWtqu1k5M+NPiaUxRQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 04:16:17.5486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d4065b-f0e2-4da3-efd9-08dda3e7b811
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200

The GB200NVL UT3.0b BMC is an Aspeed Ast2600 based BMC
for Nvidia Blackwell GB200NVL platform.
Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]

Signed-off-by: Donald Shannon <donalds@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1125 +++++++++++++++++
 2 files changed, 1126 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index b3170fdd3096..1101bc74e8c8 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
+	aspeed-bmc-nvidia-gb200-ut30b.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts
new file mode 100644
index 000000000000..81c44a1e4f5d
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts
@@ -0,0 +1,1125 @@
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
+	chosen {
+		stdout-path = &uart5;
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
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reg_3v3_stby: regulator-3v3-standby {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3-standby";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
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
+};
+
+// Enable Primary flash on FMC for bring up activity
+&fmc {
+	flash@0 {
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	// Data SPI is 64MB in size
+	flash@0 {
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
+&mdio0 {
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	pinctrl-names = "default";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
+// USB 2.0 to HMC, on USB Port B
+&ehci1 { };
+
+// USB 1.0
+&uhci { };
+
+/*
+ * Enable USB port A as device (via the virtual hub) to host
+ */
+&vhub { };
+
+&rng { };
+
+&video {
+	memory-region = <&video_engine_memory>;
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
+
+&sgpiom0 {
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
+&uart1 { };
+
+// Enabling SOL
+&uart3 { };
+
+// BMC Debug Console
+&uart5 { };
+
+&uart_routing { };
+
+// I2C1, SSIF IPMI interface
+&i2c0 {
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
+	clock-frequency = <400000>;
+	multi-master;
+};
+
+// I2C3
+// BMC_I2C0_FPGA - Primary FPGA
+// HMC FRU EEPROM
+&i2c2 {
+	clock-frequency = <400000>;
+	multi-master;
+};
+
+// I2C4
+&i2c3 {
+	clock-frequency = <400000>;
+	multi-master;
+};
+
+// I2C5
+// RTC Driver
+// IO Expander
+&i2c4 {
+	clock-frequency = <400000>;
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
+		vcc-supply = <&reg_3v3_stby>;
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
+	clock-frequency = <400000>;
+	multi-master;
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+		vdd-supply = <&reg_3v3_stby>;
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
+				reg = <0x74>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+				vdd-supply = <&reg_3v3_stby>;
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
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+		vdd-supply = <&reg_3v3_stby>;
+
+		imux20: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux21: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@20 {
+				compatible = "nxp,pca9555";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				vcc-supply = <&reg_3v3_stby>;
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
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux23: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@73 {
+		compatible = "nxp,pca9546";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+		vdd-supply = <&reg_3v3_stby>;
+
+		imux24: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux25: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			i2c-mux@70 {
+				compatible = "nxp,pca9546";
+				reg = <0x70>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+				vdd-supply = <&reg_3v3_stby>;
+
+				i2c25mux0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c25mux1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c25mux2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c25mux3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+
+		imux26: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux27: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9546";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+		vdd-supply = <&reg_3v3_stby>;
+
+		imux28: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux29: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			i2c-mux@74 {
+				compatible = "nxp,pca9546";
+				reg = <0x74>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+				vdd-supply = <&reg_3v3_stby>;
+
+				i2c29mux0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c29mux1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c29mux2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c29mux3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+
+		imux30: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux31: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@76 {
+		compatible = "nxp,pca9546";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+		vdd-supply = <&reg_3v3_stby>;
+
+		imux32: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux33: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				vcc-supply = <&reg_3v3_stby>;
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
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux35: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9546";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+		vdd-supply = <&reg_3v3_stby>;
+
+		imux36: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux37: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux38: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		imux39: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// I2C7
+// Module 0/1 Leak Sensors
+// Module 0/1 Fan Controllers
+&i2c6 {
+	clock-frequency = <400000>;
+
+	pmic@12 {
+		compatible = "ti,lm5066i";
+		reg = <0x12>;
+		shunt-resistor-micro-ohms = <190>;
+	};
+
+	pmic@14 {
+		compatible = "ti,lm5066i";
+		reg = <0x14>;
+		shunt-resistor-micro-ohms = <190>;
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
+	clock-frequency = <400000>;
+	multi-master;
+};
+
+// I2C10
+// Module 0/1 IO Expanders
+&i2c9 {
+	clock-frequency = <400000>;
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
+		vcc-supply = <&reg_3v3_stby>;
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
+		vcc-supply = <&reg_3v3_stby>;
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
+	// UT3.0b Expander @0x22
+	exp2: gpio@22 {
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
+	// UT3.0b Expander @0x23
+	exp3: gpio@23 {
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
+	clock-frequency = <400000>;
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
+	clock-frequency = <100000>;
+	multi-master;
+
+	//E1.S drive slot 0-3
+	i2c-mux@77 {
+		compatible = "nxp,pca9546";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+		vdd-supply = <&reg_3v3_stby>;
+
+		e1si2c0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		e1si2c1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		e1si2c2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		e1si2c3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+// I2C16
+&i2c15 {
+	clock-frequency = <100000>;
+	multi-master;
+
+	//E1.S drive slot 4-7
+	i2c-mux@77 {
+		compatible = "nxp,pca9546";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+		vdd-supply = <&reg_3v3_stby>;
+
+		e1si2c4: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		e1si2c5: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		e1si2c6: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		e1si2c7: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
-- 
2.43.0


