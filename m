Return-Path: <linux-kernel+bounces-858747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6632BEBB4B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B30F6E8655
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0E1264A76;
	Fri, 17 Oct 2025 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ET1HGGW/"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04491354AC2;
	Fri, 17 Oct 2025 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733609; cv=fail; b=JCUopk9Ffpt59tUN9C4USW7ldpE+fqtym27Qf2nFfg/SuDIns+a6fxTPm4RsqaG8zRTyAa6fGPp2wN+8wGzoI/FubNen+1kVHxvbEGain7EEY3YMKDiVg/ay/WtFc0+eqKZkGayn7dz0r2U+kFULRuaQGk8N6GXNniwXREoPF6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733609; c=relaxed/simple;
	bh=sE7+L+Z+UDvfkG7y4L9AGFixi3+u1XQe90001PqNSkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PccpvDbM9HcybP/vWHQCmiWZMHSgFQB0MdTf2f/xwSBtjsuqkFVlsoWNZRnFol8RMgfOv99vSSsE6ewxM0LrR/p1n+yNO//hnS6OhNZ7T8gWPnQqhrinKgxX8DeNfHV62/CWKSCo5jXpLiU4AhMbNEp3voxHVnh7c7dgK07PkHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ET1HGGW/; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBToL85iCEXezFkWDibcQ/XnMQLi/26skBUcH9lLpAUJ3IB03DB2W3IxsdAd43W0PKbdWWlNZseYfw2rvutTLZJu4rFaLZy1DHdlqQnuzByxRxr2BNUTjbIJ58wNsFe03r0PK3SYQO78Pe1ADiZ8wkRNV9J524Aykzzf4fH3qWdVB6FdykDW5xVWoC00+5xBVKhgbgCc0jMPZr5iYkNqmhHlmoCfIWaiqz9IKn79pM3ZKLlA2R9/ke/AejwFGnhzPFcC2uqSy0QniXq/wj89/CZXl3RsCkoSwciZF5hgTImyMwPoYjWgq/rKYaCP/wsAvEOvbtiJP2qz8YEpt/TBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNVi+7JnYeTvUqXNQtC+zGGRUUG6WPNQgt5xNrJDyYA=;
 b=R/IPua6yrGTylOEHLg/yD2KX8VdiM+CiEs3CAh7pu8TbTzNumMVTpjJPzw2hr+jGaU26WuN6EV4lezZduxdovMsNjaPIY8yNneWIwoB//d5SRHi69FJNK1pP3ha/q3Fubg2SwN1Uf8NDkw9wBKO30cnk6+3mMrcT/D/ekF2OkK1UbBpNOsj0UGSxDYn2RCxyOfUjmWtDLosS78Xc7XpBah9goVVjQZlC00Z++2Q3aLra4j4eXiNScV8ETCd1kLY+8pHLtV1/NwSgt1jvm7lQouDL2UzEOUhIHHf5Go8cT2iW8DPvwEmha2fRtK5SE2reZyK+NHvjf9qR3imflfVrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNVi+7JnYeTvUqXNQtC+zGGRUUG6WPNQgt5xNrJDyYA=;
 b=ET1HGGW/rhOQTHz7HzS2QMRNRuAk7ejqpzGKGApAPZS24gYq985Pse58oAvyoMhVGXwdJeEThmAO7597V/x8JxH4aHbtw9L1585XgVn1dKkowTMj1s2ftEVkkoWFMz+OZV3J8Pm0sL8RrR+aAHwn5xoG8UOgOPUNmaulBiRjyfE+qnuMR8UXrTMZi2ZOY/3hOH0oq48UxHPsM8sxZ/oo0Oll+zGlKdiesRzVogMvcLntU8/1H43m+cLRxv7I5THIDS1B+LTfcVhF7hunVtXZ2HgUTrXjJS9utEFNtbOOS5JCfcePAql6He6UfgR7bt069Qk/l6SODEC+YMOLv5wbqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAWPR04MB11612.eurprd04.prod.outlook.com (2603:10a6:102:512::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 20:40:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 20:40:02 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] arm64: dts: imx95: Fix MSI mapping for PCIe endpoint nodes
Date: Fri, 17 Oct 2025 16:39:46 -0400
Message-Id: <20251017203947.2749779-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF00013309.namprd07.prod.outlook.com
 (2603:10b6:518:1::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAWPR04MB11612:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f48868d-cee4-49b3-adec-08de0dbd58d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DaLRjgvDLweQxU68/kGqE8qKueZAoSqHjCt+jXkGgduoe7j5ezlMiEQbqnpU?=
 =?us-ascii?Q?SU8BAUgaSiz0JwyqBKyE5iBfTJrSaTS1WjPTeRmdbjerA+s0JzSFUO4il1JL?=
 =?us-ascii?Q?T43Tqagmy3zYqMAueL0avJLHEhGwgvexHG565/Xpa8ej5ssDTPCjutqwvyj/?=
 =?us-ascii?Q?pMLPfDOphTJFvTtVEtNyBWc1pjEqF2DmW8H7g2cvr8VQVG7EYSZ08M/nryEN?=
 =?us-ascii?Q?xn3ya0ohftmLqyZHeV5s+JlIWkdGNz1mS6MQb753WAyYwjqIGALDOtY22bWC?=
 =?us-ascii?Q?h+pa7AKVJU0GYq8bxEBdEPmUQru4nxZlCXGcYPB59ZKdXT3CMicregPUW0kE?=
 =?us-ascii?Q?TMbughlgDF5sxU477+HnC5p3NkcWKjeE8s6Fi9PDJ3nTwn05sawZ61T/3Pvb?=
 =?us-ascii?Q?2XQDa0zraC1M79AEk0SyOIR2w0/QQsQPMzdT52TzCoKnVnGL/LntVzx0KDVk?=
 =?us-ascii?Q?M9Qkq9Hc1SJ4wuZGlA5Q4yUUsWpZByZLSCBMizazNtU55FnfHqTApLllZr1V?=
 =?us-ascii?Q?+ucRTRrcrW0ZsO3NkNjmzXbF7OQPNy6U10c3qN7TkeRWgV8x8SKow2lJKlGh?=
 =?us-ascii?Q?QyUjsTS+Kc/1Y34c42wO7MrMzEg7N2167VLegfEnIQsnu9xlO2qZcpwyJgjr?=
 =?us-ascii?Q?BO9eeN5knxAi3tb05cbOv1WB46Ugy1zRIAY/ZqX0z9u9GXxRCLoB9tPBea6R?=
 =?us-ascii?Q?Nhs7WxLyeGz8Zt4lKOxTbRRnAAhkX5PcIm1HpYDpZx3LRnYTRP6ZXhZP0xyb?=
 =?us-ascii?Q?wRmnDpVXSel3mzUBw1jCg9cbAJU9upqqyfmk+M3mlqrEh4M+DZPPdbKXRXoc?=
 =?us-ascii?Q?NGvW1Bz1Wl+lGa7AMHMF0bq9uFb01a3Gt/92gddnZsgZTqsUjO+7sVEhdz63?=
 =?us-ascii?Q?djOYxDa+OFPFJdMUyzXfulxroNfk3Iav3E8EPvu+iFLZgXse5KvJrNglqEEF?=
 =?us-ascii?Q?GRJf7CPlIJqcIkgMuq8TtpqwlzcK2v0gWSsVq+FFCYR3N71KJrJOMUhrVyYR?=
 =?us-ascii?Q?V43B3aVLwBtHh5N/Z5Ft4n75SK+O/s/eQIum45t0gIcHzNb76UnDkgll+u6W?=
 =?us-ascii?Q?2QBcwpHyc9HgAB5TLbTLMDWpsDTe+74R0+fRvRJJXMYiiCtK4JNzYDKKhhs4?=
 =?us-ascii?Q?EnScWyRaE2n641+35sC4WXXFm1IUs5JnQmC3qmf7i5e7FVjSytYOfszCfoXb?=
 =?us-ascii?Q?/Ivd6wJ3yN1Nz9G7jeLIhw/Bedp4Jg3Yxj3WgpQ+DgcDFJGTNpnlh53r3HY5?=
 =?us-ascii?Q?GU4DMj8wYCPBeBhJDfqqtAoa4AAqCmDtLhC4k1fjS8sLHZryKnvp/1htiXdu?=
 =?us-ascii?Q?G+SW/MmCYlQyYWDW2HMA/BfGInd5FRwnhnaAlu4XzyMpEfbmWCeUO5YPOd7e?=
 =?us-ascii?Q?YdtYNSbvjEMyBnSqoGHnHInd/u4qVef7y28XN3EzbiJsjysySB2FOq/Ls40k?=
 =?us-ascii?Q?p8WSwEXt0exI8XJGYe6xaz/jcLPHZrbj4F6OjlXR1eahrkHPNrgFDdChl3Sz?=
 =?us-ascii?Q?z/sy9dQgdFTYSE87d6yBv9WRAxA3klBk3X3A8mN+Z/vV5HJCxGrr+GAYoQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jmzsq2iC+jbcCtZF67q0+t4ubDuKjs51rZa7Dq2YuIwVwlYj0EcB1Mc3k9Sx?=
 =?us-ascii?Q?GGTJAtkpTLHdSx/uKiSXE96v+pp4eZUYS0f5EwPuJ04oU3ZTs4sJuvfu+GiL?=
 =?us-ascii?Q?mumhxcBRlS2dkSbu8d62K80p4zVqhfw2hSpuz6BNwkhfBM7y1Hirn0bajxoy?=
 =?us-ascii?Q?n+t9uOdx6xyxAY2J0cxY4P/77Gs3wFo8zAtH7o4QdfYHMzAFVVUDlLH+W5rs?=
 =?us-ascii?Q?G0L1XGoM+l+Gzsxvv6qvhyb7BEmzz8QNwMuGnEf6qLFjC45RVKl4gK4fDEA3?=
 =?us-ascii?Q?FF6JzoD3/37ctd6ol+3Uk7oQbhGNHXPZS0eP/e/m7PsjJyUkoM8/pahAp21f?=
 =?us-ascii?Q?TqguT5g71trQPclI/gUqVblzIZWeddqv4BPDVfTi0w/9w7ObQLgVdr3HLv6V?=
 =?us-ascii?Q?AJPwfi+IzTGW53S/1TSmzPXDQQGFEql75rg0+SlIO3BaRd3GC4zR9dUcDIWQ?=
 =?us-ascii?Q?ytOr+Pw0O2aJbz1wVImMuoCs0JA94fQaOEvGPigc5IonVYUnrxweg9J4OxWI?=
 =?us-ascii?Q?VU4fKgCUPKEQqMbnaMg7buPdd9tATgD0VtRKocooHdSB2PHGvXFjpwlrYz7W?=
 =?us-ascii?Q?kJ1mAtjNbJzrCYKMFRR7R9wFZxt+CSFnr7oHIyDluLS1M/bgec2qh2cwn+YZ?=
 =?us-ascii?Q?r/JT+dBcjSEyBmaezmmPN8G4rZ/R1al7dY2GYSwFKg5k70/Ry0ny29sD2Ama?=
 =?us-ascii?Q?JMk9urC4ym23tYs95EoVrvotrT7NXBoitBGHyrXP2layZCICTI8DrmI2uLdD?=
 =?us-ascii?Q?bUkRnEvpbdkHhVleYHPG+xFodANhpNEjwR1F4uCmaFE1EipWZ/9i/vymikO/?=
 =?us-ascii?Q?HFD+4yXlr0279J/Vo5yYVfZhUArwAyjU1KlSMeY/8dyL+I8gDIeyPiR4Y7lU?=
 =?us-ascii?Q?w4wU1unsKeWVmfxHuVgtgFGYp23dmjk9ywApeu/Blnw6yznfF8GtgVFve5TY?=
 =?us-ascii?Q?v1vSEVMBBA1KY6VZ71yY646rpO0sOOXQXWGStZxrgrvs66CEcgvJtunGUm7O?=
 =?us-ascii?Q?AuPcOA99JiSvfqgTV+Ls7GGCenv7hc8D3NdR1ShTfjGV5IrleaKY1yabwap9?=
 =?us-ascii?Q?roOVcY3QzrV43Z2bbsCGr5yMFlosW/QZYVjbQZO0r0LsIllQInB0LE0bfrGG?=
 =?us-ascii?Q?7UANdAXxsO+itkDmkojb7GTMTzCZ3W5DayJyOBqWVh+JSyebLZefU397TA3r?=
 =?us-ascii?Q?IuRNy/9PIfM86tkbRjrolZ6PEyPizJ4YnwgEoU46iVR7CaXSMgS61ApX7sfD?=
 =?us-ascii?Q?aIs9qpBGOmiluDHCz3D4EIW9q5OyNDDQjKZXOIK4j6V2BVjYCAUd//D1jlD1?=
 =?us-ascii?Q?xrD40xkJcbHyvYwrXISbtAb96pV4Z6mL/oSsrs37qLLSL+rW2pCs0Bz7fanF?=
 =?us-ascii?Q?xb5Ki5kg9MduNfQQDuL8vWqzIoK+LAxpSe3s2LPsKrtPvIFlZvU6IO+z22nE?=
 =?us-ascii?Q?N4wTa5rB8arHiIidVzM6w77qHExTAuhbVNxgsyWkM7QZKSOpELOyXjkP1n7m?=
 =?us-ascii?Q?vfJelPr8qa2Yv86mLopcA+Gn9nf/BK2cDfTby7BresbIO0IPPPH9HVgoCadq?=
 =?us-ascii?Q?EduQLC4xUtXEWcmzl4A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f48868d-cee4-49b3-adec-08de0dbd58d4
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:40:02.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5Se4U0Ctkniae3Lgu4Qcr34Co6Kh4Bi8U00CBNnNkEc2NSm9ArCncR8YKV/UhOS5Crp62K9UXryTr1PwQXc2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11612

The msi-map property was incorrectly applied to pcie0-ep instead of
pcie1-ep. Correct the msi-map for both pcie0-ep and pcie1-ep nodes.

Fixes: bbe4b2f7d6533 ("arm64: dts: imx95: Add msi-map for pci-ep device")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 6c10f3a4b63f5..d2228927bde8a 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1886,7 +1886,7 @@ pcie0_ep: pcie-ep@4c300000 {
 			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
 			assigned-clock-parents = <0>, <0>,
 						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
-			msi-map = <0x0 &its 0x98 0x1>;
+			msi-map = <0x0 &its 0x10 0x1>;
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};
@@ -1964,6 +1964,7 @@ pcie1_ep: pcie-ep@4c380000 {
 			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
 			assigned-clock-parents = <0>, <0>,
 						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x98 0x1>;
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};
-- 
2.34.1


