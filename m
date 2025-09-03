Return-Path: <linux-kernel+bounces-798058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ECEB418FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D0F4800C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3452EB86D;
	Wed,  3 Sep 2025 08:47:25 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023113.outbound.protection.outlook.com [40.107.44.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040C1F948;
	Wed,  3 Sep 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889245; cv=fail; b=UxAtySmirHPAm6t8vccXM/+nE8h5BiK/zsObgBDRuIqV1aiheLyLbvXHjja29/X1D/4c3ksWFqH+M1rGuCx05KGh1cUMGNFmrUBqvl2sB7LzL0TNimzWg2YC4mDhf3QKb7dyC/UtOjTHJmoOEbnPTaw+41Kimmkv9s1t3LJZ+WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889245; c=relaxed/simple;
	bh=01DTPKy25lQRqQR8pDRwoqbZ8IiVp6ZUPbQiBieXpGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JO9OCIVuO93Oo/6KISs5tO07MBvm8fQgavyaDtfpYlp1AY2YPA5RyRvdM5OcUL02Nzusu/a4J9QcZg36UJUd32gsRQRFF50ujrYuK+JGP9noOtfstiJEUMOmi/VVKGfYn1H2WbBJSEnKLhKtYCvcZOtMjajE4d040dh3pWbZyLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNhAtUxDLtX7bOapDD21s/dFcOTQcZQfZZsaOSfTeOg0UEOfpvP0QPQw9dDmjgEClGTwtNCTN3ZuZOrC7bXh2BcD4J9XGMl6fjedOIaEptUfLV0eortS9qbpMKv7+oYl0Z3CgJIWLPS/m+GRdCCpbjCeKIFQ7WFOjdVn6qDcEXHzaq9Sipvd53nlgXjI6z5dKsAvzGxwO0V4XSjzLgawbdMrCYm3sCQ3hlD0lYXvdvwpXm2xJ5i6ztgc4xEnWTHSO4SEePrlG+B/T7Jlv68CdaHv8G9z4Ged7kW1jpa+10r5ZYxlFvsbT5Xgm9a5Tr7mfXtZ3KtY/CR3SwjayUMWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLPZgs/PIZdp2aRcbNkmUfHK3WRjL/MZ1CbHLXsACIY=;
 b=XNmcLZYYKZUb2NWrJ3bptyMCfAO2Jeda+/5FjPTXKruxLc6vyT33DhLWuYpUINi6PoGJVQBOD/Gn3P+wgZEt3XJdIR/PkzGSEfQ4OtWAR6TUXQ+MkXYCC8PGHeZ2pX9zwD5rY9Mo73VT0r7bQ6DIq29IyH089sD3lTZPoiLqetE++R1+bFQ//buM36boWxwmtxIckvmugiq4DKQ2wz7OGOqJKDAUDIR44gCpMwLz3aDL5eo1LxmuRzC+4eKU/zhRXeeCWT1N/1XMlKQ2Z31OgLmRKJNzLsKnipVIy0g83WF6Rbu/dNU+QOpbdTgM+GFzv8WD6ZQwsZMU9I0Fr7AmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) by
 TYZPR06MB6956.apcprd06.prod.outlook.com (2603:1096:405:3a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 3 Sep 2025 08:47:16 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096::cafe:0:0:23) by SG2P153CA0016.outlook.office365.com
 (2603:1096::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.7 via Frontend Transport; Wed, 3
 Sep 2025 08:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:47:14 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id ED41841C0143;
	Wed,  3 Sep 2025 16:47:13 +0800 (CST)
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
	Hongliang Yang <hongliang.yang@cixtech.com>,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH] arm64: dts: cix: add DT nodes for all I2C and I3C ports for sky1
Date: Wed,  3 Sep 2025 16:47:13 +0800
Message-Id: <20250903084713.3221907-1-jun.guo@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|TYZPR06MB6956:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44a3a92b-27ff-4496-2ca8-08ddeac67b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RD8z4qe3r86F+i6GbCNnlkyUVlo504dJ2vR67Ag5VgF9Iyne19MkGs9lmQTG?=
 =?us-ascii?Q?Vsr34ek0rKVA1iWOOViuxrAllODuBTcBTZ0/bJIJMqkXYeDTcv4hYqNk5uFY?=
 =?us-ascii?Q?WWCCu5YhPI8zccG52s066yQAOE4C0Gkuu5S2t2f1LFW4Ycuga2TuhdRmeFpg?=
 =?us-ascii?Q?GAnTfn6CpkJQgIAtWeXcWA11hRsJJNWQtGZPAG/W56xzYeBfKoXA8CkBkRQ+?=
 =?us-ascii?Q?LICqj+9TZlDZEqx+h/duTCeK8uyrV0/dF5kYt/lvlUAAiOWYNjSrg1gkJf6X?=
 =?us-ascii?Q?Ym9b0r5yZieU7CDYDisuqCqIIjBpwm6UvglFqNRCILXMivTfsR62jkVYqtvk?=
 =?us-ascii?Q?W4BmGswKcEFownisGAU+paZny8zJkzdO2hAZutvOtRV2YkbBl5iA8hbJQ83x?=
 =?us-ascii?Q?Jwd8nr0bv8Ran+7Vf3rvdNGH4L9d0PnspF1iNl0Ke+T4jLAUWyuwzpemMi7a?=
 =?us-ascii?Q?PBnRwj0g6iMIRamupC6apJZtYfsNjtYl7/lYxX/RrZkO3R71U16f2gUAd9mJ?=
 =?us-ascii?Q?0LYl8W4FEAiti1LEGrNSlmPOqiumLH7IYANdkDtgogFzqYLSBFI9TRpUZ4Ik?=
 =?us-ascii?Q?oMbhInv89Y55WPELVh7T1U4Xq4Hv64ZPBbkaZAriafrLWQlkir7ZPtv7uZS0?=
 =?us-ascii?Q?0WOZu5GCcnARkRFP6TgqbtKjvaEp682BNkzP7yaAiI7CWp6fg2IXPMEZtOs3?=
 =?us-ascii?Q?dfx0UjfSw8Wl/gtuNzX9IczMc8iTs0seKpoaC4g5aQULZ52GU56j9eB7JanL?=
 =?us-ascii?Q?zE6SZsU3XcvN6rt6Nvsnm4squgXpO2Y87PIqrQpxgsojknVeO7zzPhbihEcs?=
 =?us-ascii?Q?LCWZzkY5uIT69Z4a9xgqIR/hK+g+Ul1Duoh4zsFvcL5ANUOX6BzxK6Xu8qIx?=
 =?us-ascii?Q?OrO0yv1IarRUhwPJyacLjK8YWNpe2ot/AHI0BwQRHTN+Kz9L6qBlXJ4sTYId?=
 =?us-ascii?Q?qKSWSSX/H9Pi77dBViqFPxlWcSd/cuMBi6VSQW/FRrI/brTXfMMoODtp9yrT?=
 =?us-ascii?Q?dTvh3mFN+nwqe/wdoq8yn2so+cxnycDiEbikUveIZM+/v225IMqHI69aRDgl?=
 =?us-ascii?Q?PKusVpuBJY7glhe8oJLRAIxfar+IYsSid9p8Q/v+29zvxrHQs7TTGZlkA2NJ?=
 =?us-ascii?Q?t/rZVE85W30nX5l+gPXTi1uDXGuGPj2y3bT/eKNHHBSxUJV/ZHAx8y5Ef5XO?=
 =?us-ascii?Q?+ZZy86ILJyOnLenIzUNDUoXvK5gyraZPcPCrtQ6ttKAJhRPjyyU0EqvZJoy/?=
 =?us-ascii?Q?fmupMvb70R4U0S6VrqOcVNxPO2OwuoElOVZBtGl6z3hxUNb6JnMBHNlgwnRg?=
 =?us-ascii?Q?9Sv9V8hreNlPfxrufG6hni0Tvks6cSGRfu5MT8+l3qZOlkrJyqWYb2sjd2FR?=
 =?us-ascii?Q?cggwcQ6vuEJXGdOjZdVzoAiORwrVFj4gg3VL82CyAVFEdTbxJgzFVB6YThBH?=
 =?us-ascii?Q?3HEkhaxx95bXYEPdYPI1W91z3aEaiLiaLqwS3PAU84+OFlY61qn+oB46CWun?=
 =?us-ascii?Q?HwFBYi/fT8anaJ/uVA+Fb1rbiTuFrdnwTwTy?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:47:14.9575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a3a92b-27ff-4496-2ca8-08ddeac67b67
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6956

From: Hongliang Yang <hongliang.yang@cixtech.com>

The CIX SKY1 SoC supports the integration of 8 I2C bus controllers and
2 I3C bus controllers.

Signed-off-by: Hongliang Yang <hongliang.yang@cixtech.com>
Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 100 ++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 7dfe7677e649..2fb2c99c0796 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -192,6 +192,78 @@ soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 
+		i2c0: i2c@4010000 {
+			compatible = "cdns,i2c-r1p14";
+			reg = <0x0 0x04010000 0x0 0x10000>;
+			clock-frequency = <400000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I2C0_APB>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@4020000 {
+			compatible = "cdns,i2c-r1p14";
+			reg = <0x0 0x04020000 0x0 0x10000>;
+			clock-frequency = <400000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I2C1_APB>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@4030000 {
+			compatible = "cdns,i2c-r1p14";
+			reg = <0x0 0x04030000 0x0 0x10000>;
+			clock-frequency = <400000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I2C2_APB>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@4040000 {
+			compatible = "cdns,i2c-r1p14";
+			reg = <0x0 0x04040000 0x0 0x10000>;
+			clock-frequency = <400000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I2C3_APB>;
+			interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@4050000 {
+			compatible = "cdns,i2c-r1p14";
+			reg = <0x0 0x04050000 0x0 0x10000>;
+			clock-frequency = <400000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I2C4_APB>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@4060000 {
+			compatible = "cdns,i2c-r1p14";
+			reg = <0x0 0x04060000 0x0 0x10000>;
+			clock-frequency = <400000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I2C5_APB>;
+			interrupts = <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@4070000 {
+			compatible = "cdns,i2c-r1p14";
+			reg = <0x0 0x04070000 0x0 0x10000>;
+			clock-frequency = <400000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I2C6_APB>;
+			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@4080000 {
+			compatible = "cdns,i2c-r1p14";
+			reg = <0x0 0x04080000 0x0 0x10000>;
+			clock-frequency = <400000>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I2C7_APB>;
+			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
 		uart0: serial@40b0000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0x040b0000 0x0 0x1000>;
@@ -228,6 +300,34 @@ uart3: serial@40e0000 {
 			status = "disabled";
 		};
 
+		i3c0: i3c@40f0000 {
+			compatible = "cdns,i3c-master";
+			reg = <0x0 0x040f0000 0x0 0x10000>;
+			#address-cells = <3>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I3C0_APB>,
+				 <&scmi_clk CLK_TREE_FCH_I3C0_FUNC>;
+			clock-names = "pclk", "sysclk";
+			i3c-scl-hz = <400000>;
+			i2c-scl-hz = <100000>;
+			status = "disabled";
+		};
+
+		i3c1: i3c@4100000 {
+			compatible = "cdns,i3c-master";
+			reg = <0x0 0x04100000 0x0 0x10000>;
+			#address-cells = <3>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&scmi_clk CLK_TREE_FCH_I3C1_APB>,
+				 <&scmi_clk CLK_TREE_FCH_I3C1_FUNC>;
+			clock-names = "pclk", "sysclk";
+			i3c-scl-hz = <400000>;
+			i2c-scl-hz = <100000>;
+			status = "disabled";
+		};
+
 		mbox_ap2se: mailbox@5060000 {
 			compatible = "cix,sky1-mbox";
 			reg = <0x0 0x05060000 0x0 0x10000>;
-- 
2.34.1


