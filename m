Return-Path: <linux-kernel+bounces-823867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE6FB879C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072FF7B92BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09A215789;
	Fri, 19 Sep 2025 01:31:27 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022090.outbound.protection.outlook.com [52.101.126.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BF185B67;
	Fri, 19 Sep 2025 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245487; cv=fail; b=UWNDv6J/AUBg9vw98dDt0+nvRvkRXcv7XmmL2QM1F2Gm+6gm5pSSJlbCPlgAzeS/2r2356LfmLNbE9TEk2fO3sgJroxL18zBOakGu2EtewizeKOpckd0tt5767Hc4k2Fuh9viFs6ZqeYM8lUZ4UAuOKgmrcu24DXlsXxIdPX23k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245487; c=relaxed/simple;
	bh=DlmC6qQkAxAOINIkdpdPwDQEqjiz2xZ5zgnNTPWycjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UdMiRjds4sxLtXu6CU5gZKrvaD12e4mWB0+dScqpqVZ6P69vs/Ns1eCqB9u8Ml4KlLwnt1+sdBuMAiqiNIrZziwUDcCTdctVHfX6MnkbI8OmDxacWvLEQmY074J/avQIcRUcT5IH5+CxxPwx2xrdyBS1qACiGRLa+2ULoukFK0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sx6HWX7an7k7VPeejqUKtroxiN9eO0WJcuq12d7cKB/eYUyoJdl/AjZpCy3s4sCVGCeBmSWrplEh9mSwYQ2S5EyK3iz6jJ284+QwHbIpo05zRxHAzkbYHQt1Istv4xbWKmLmN+IPKOOf5Dtwg+hMDjA/Bydg8DfxScGunQk+WvqlZ/n+Oj8CmkZuPbkYYkx3ULhltdiBgzh1ZWNRnmG2fP5XMjjcaaQJEpdEgXtitfC1tfBtfqfyegNik2sNg1Wvf+226XN4nwdKy+Kels0kEbpn00ir5ZB3oe8DF13iC4gimNqUozkmesaue0ScXpZ2M5U8pW85xTGjFv51sI6brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AdoPFSPFlDntGnZbZm0JUl5Db5m0CDZ0mpL7wxMOhI=;
 b=IUnafG5NNI6qGBeAHBLiCAT66An3uTxIFJS7suzkuPYdYJTAhox0lrf6iwN4p6X0IbNGsu58pr2xfE5AYBCYmGRbg0BAas9lePak/rD1swLnxbzPGyiGX1jNf9dBdTjTZfXKOHaNR9SSj8smoT3j4CGTgYnuPKQx/KVq2Lso3q5pUm8rXMPrKuWiHBEi+dGMluGtcgX2IX1B9r4iV3x3DOirmTVEGzZXTL6Wla8IIpMmML+2WVYR/h/6kxWT5YzzD7TU3iwvVhVV7/EADPb49kMJD2HvVc9BB9YlWucZp25PVzPP4+xJJidl1+LQFWtzkfkO2z5IKd8o0U+NGWeawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SEWP216CA0127.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2c0::19)
 by TYZPR06MB6379.apcprd06.prod.outlook.com (2603:1096:400:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 01:31:21 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:101:2c0:cafe::c0) by SEWP216CA0127.outlook.office365.com
 (2603:1096:101:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 01:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 01:31:20 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8651B41C0154;
	Fri, 19 Sep 2025 09:31:18 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH] arm64: dts: cix: add DT nodes for SPI
Date: Fri, 19 Sep 2025 09:31:18 +0800
Message-Id: <20250919013118.853078-1-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|TYZPR06MB6379:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 31d4bc3d-0c73-4858-f240-08ddf71c3ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pZcn8MYA9ja2IDTHkSYtyYy552is0ZIKbDPjyr6dMxuRf6nLoEycqfoql9+g?=
 =?us-ascii?Q?us+giCFgqAnAmK2M0M3X2SquUBhZKKHS5uzoGShlqkpIZXZG5BptAHDy+11A?=
 =?us-ascii?Q?0SWwI6sLLIE6iX+FS9BhHd5CpXdjS09f7OrLDI6alXpAVi02hsoXQU6W3kWM?=
 =?us-ascii?Q?JtnxZ4o5nenJpkwJwMJVZrG1pgpYKph8XFk6AInHqGMZ0t7D96E17Ub34l60?=
 =?us-ascii?Q?/UiXHp6hZRWUYIYrB0dLLT+qmJS1rgUjEtca8i9ClJTOMkIGhnojOXulSSPn?=
 =?us-ascii?Q?EXu/W+6qJK3rXSD4Q732MnG00bxrQ4VwRx1AT2vOf0IFjO6mIEP3Zu65UE71?=
 =?us-ascii?Q?7S8kD0n8nMDneyGB4JohDbWkfTK5/z3LfW1QO1vSlVJENl1japXZk/mNihT1?=
 =?us-ascii?Q?h7H+oedMFYFNu42pgeupC8YW1AwiDl/pAKquovY7/QOzt86IyphyGkMoSd2E?=
 =?us-ascii?Q?PsI32EDjSFCfxFOF8MMBIuw3WEvrSrmrYKht7HqmLCzDqIP1xmVpEiCtfJX6?=
 =?us-ascii?Q?DVTgFMRnYxVQricSQg0ikqvaTffyUlS60OMYDbGgyFLrtrS480Tne432beDP?=
 =?us-ascii?Q?7ghxFXQJhwfg9wbxnB5PU/WSIUyfFw8chh0HG5s+X08i1+zYvVDyT7jp3JXY?=
 =?us-ascii?Q?qsw3DmQ+u1H3u9iCqEYKsx3tyKoOZtpj6joKAgAcS4qOo3SVOAkT5D1+vOzI?=
 =?us-ascii?Q?ikFNyQyB7BR/h3SnunsjJbIL54YXbTFSZKdQWQ7NBn6RVfL232Z5Xo8GpDy2?=
 =?us-ascii?Q?H7tFzKeSt3rAMKzDUg8l5hCFqu0v6IobUjAX2VakXlGtiXBjzcShthOqBA5b?=
 =?us-ascii?Q?7WE2Vl8xAetYPymolLfhnjYoErBhjMAMXl79X94wsOBhcWTlzzQP/o2JOwpO?=
 =?us-ascii?Q?gIGEK/2aQO0u4xg9Q6YOv+fHm573NIQrf7kCuBRdbzhKTWBjNzGRunYOUPSD?=
 =?us-ascii?Q?aEgecx8PHFU/CwZwbxm1uF3qxSMpH1kVqyKIc8bWjY/Xgcu3Pnv+LYMIrkRe?=
 =?us-ascii?Q?/cd5R95rZqR2ZI3xgo7njORp5X29mSEZM7VAZqgIaPY49VUGvUnR4uWZ/Fcu?=
 =?us-ascii?Q?Eq1fHYdD0stk+XQdkGuo9SV7tW1Ly9Z22n0PtFOQGg+uLLGBymoDcEFhGJmc?=
 =?us-ascii?Q?yNZ7yVJCbySgcFydtV6x1XRLcTSdh1toT58mb4Byj7yl46fHZZ57HIF+x/86?=
 =?us-ascii?Q?CuZqJQObi2oiT1+jA+U2WgBr2dpPcY78XenGGDKuCfNJ9BwCJ9yz3/wFIL3h?=
 =?us-ascii?Q?Qu+pRpARm+CcuVckxPq7oSEtqmczqwryyQsVgY86o/WE/X3Vk2gCaFVmJCbW?=
 =?us-ascii?Q?CbT/+ZI3moNKmfyAOeSxCq0Rh0XfQtHLsH8NQ5/GQnmBtL6lPUzRlhm++L77?=
 =?us-ascii?Q?aDNhehGoYTloPxlG53C/630ODPnv0ImjlxlgxM31tOe8du6HLv3D5RVmf7W/?=
 =?us-ascii?Q?pWQepQPS8BrbieeI4gV/K9Lr8dwy0bHCposCNQNVFBjA5TJNrbD512oA76zu?=
 =?us-ascii?Q?NUIN3xA1FeV7fY81OUb0k9QAP6N1/0XB8/3L?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 01:31:20.2602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d4bc3d-0c73-4858-f240-08ddf71c3ca3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6379

Add the device tree node for the spi controller of the CIX SKY1 SoC.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 2fb2c99c0796..ea324336bf34 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -264,6 +264,26 @@ i2c7: i2c@4080000 {
 			status = "disabled";
 		};
 
+		spi0: spi@4090000 {
+			compatible = "cdns,spi-r1p6";
+			reg = <0x0 0x04090000 0x0 0x10000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_SPI0_APB>,
+				 <&scmi_clk CLK_TREE_FCH_SPI0_APB>;
+			clock-names = "ref_clk", "pclk";
+			interrupts = <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		spi1: spi@40a0000 {
+			compatible = "cdns,spi-r1p6";
+			reg = <0x0 0x040a0000 0x0 0x10000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_SPI1_APB>,
+				 <&scmi_clk CLK_TREE_FCH_SPI1_APB>;
+			clock-names = "ref_clk", "pclk";
+			interrupts = <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
 		uart0: serial@40b0000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0x040b0000 0x0 0x1000>;
-- 
2.34.1


