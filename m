Return-Path: <linux-kernel+bounces-798519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF17B41F20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D852D565465
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C7301001;
	Wed,  3 Sep 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XOWmVRYd"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624E3009D2;
	Wed,  3 Sep 2025 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902864; cv=fail; b=crET/2uztLMRuN/mHqrE9SyOitEFMKphSnBlb1859jQbSg1Y8xNl4t/lWSDpMUQPD7+8QFR18Q9OFiGjYJnJI526vFFGuREw5P8X7TKGHH0RzdOe0P/M9SBempToKKdGPcqLa/Bgh/ToRi7lLRYe0rCPE2PR6I74QeDyr9UcA+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902864; c=relaxed/simple;
	bh=pi81G8PylagKh1H/FHExwvFZJ1CqxDA7nY2YWzrECj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kur3LCTLoQsz2Gl6nnhZG4COZ/cRPCrCxhSc54dEQ4MQYzUbMcVFXw82VgPppGkahh6uHHY1A7mwZva1RWJMYPZ6PkNgNp436zAoxSM5DMayzFAyuvP6yp1miYKQB3nSBU+t16hgJPKXSynTaJV95/iZOiDFsnFHk0jgOV3Mmeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XOWmVRYd; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK75Eoz0wE5312UDZ/dAk1Wt+jwzQ+RC0cO7wDSw1EPXBwut2I+cz1+agCmdy9WWwArfw24GDZSXTyMhPcYNo1TiL7AdNjbnt9rF+zsFuM/1gbUK84jbte6OfCmjMAwFU+MJwFu5dnqY7GpC6yEzdnlWex7Q37Ir4nTlZScndpMsGEQnegf6YTFRB9YOrjYNVWJb6kXjpX/O5dki7C4Y+OIxJnuGitFB/5h+q0dvtRQqdgRClHIFnV0Llb8Pv/iwthHq7EYOuj7TXeaoM4/8gWFQvQ90ldd2vdzatpdJ5v5Z+iIWFoq8V/xZZMmqkwTRwWX23blL7/b+4qQd1pqAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pKz+WlvrYJ+fPEt2bgu3jtniyOiD0UOJU/vbSrbWmw=;
 b=TfonscUcNPdVxn9ysSQ7apSap4fDHz5SVNZNwGEbPXCTXbOh8a4K7xwV6p9LPEL2MltDD10pbHqJo9oEe+kOYs89sQFMikH+f6heSw6Xx7cRUy+zT7oBN6aMiDaeVWPiVnCV3/15X7H09tkLeUQYbq4/iiwdoga8JgCjkTNmNo2ZdFuU4ZEOmik8CAegnvjwPwG8HY45U8B+UE9m5Px87x/xRlETvnZoY0FG6w/JP1IOWy5JZHZyNlB9fhf3zvFMygb7TXXRQHUoUqIpSkldtjzj8OFMcYXrlptFZ7kzk/va7qf8P94KMAIaMpstlXQYGHSfS+fcYCtitYdI9yDjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pKz+WlvrYJ+fPEt2bgu3jtniyOiD0UOJU/vbSrbWmw=;
 b=XOWmVRYdBE918FGSrP0Uv5ROrkdfyWh7sXgF3OoSD2lXPtrUxBb2n3ak+gGNXkD/WPLW5jw7B+/p89tSG+C6hRNSrUY3PHtvCh7tDLaT0aEXmVxVH7nRx3XbmmHTOZACVUZgkJNX36Htyq7LrSG1Pmh9ItKi43cSYTc8Vl8gAznbjpUT7vIRvVDw2fmXAM2VglGjPmDWXcgBlM1n6Qlbvb3zM4ye6wS5KcBpTmhjrZUEfCotb12ZG7LIrEjf10saInDG6oIBgoUzK2XEunbKxuPjR98QjCRlx6gIx5EEuBcytJicp9uxkX1YHeXgCSBzU3vPJFRG5esbM3sHgHGvmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:34:19 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 12:34:19 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] arm64: dts: imx943-evk: Add display support using IT6263
Date: Wed,  3 Sep 2025 15:33:26 +0300
Message-Id: <20250903123332.2569241-9-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
References: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: ee64a4e5-4b0f-46d6-d374-08ddeae633bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOBDJDqcLAWgLIWUIJpqZOt/rZPUv8rL4LhH9NVWtH/M7UBh+GrFoblvOeFo?=
 =?us-ascii?Q?0CobmN2sPs+/LHC5sioG9Bvg1zepeAXAnjoL/Xg1+Q9wIuJAXheJa1R+Ehjk?=
 =?us-ascii?Q?+5Jju/PjltI61mF9KCmXthm+wwSgeOLN5y812h6PtpB/FLnQ6JcAauKFWq4F?=
 =?us-ascii?Q?QAwhWCNtLa0kCeb2fu/estIviKfP50z6qcNseSeXSlj/C8mFUmm/LWwQwCXd?=
 =?us-ascii?Q?hrkZnyXP6t4tWhJgJRYHI76St/DfXTQOLkXBtidlJVHWrLpAUNVhLCSHiEDU?=
 =?us-ascii?Q?23vIm1vNYHOgDNFcmYEcu0sT3nDWRB2M8ZUasdVpuYqCtddc8vX9ruohnMJe?=
 =?us-ascii?Q?esGMdWfdrkIAqWhg5eSCJTwnXGH+VsQd/Bc5arEkpaTnt46DPS/dDTzKYb+i?=
 =?us-ascii?Q?7kjSJDOC8u1nUF4C7vr4KtBVeYeb0KMGpyaUyd0YoiMTDk4HThkvW6syj2D/?=
 =?us-ascii?Q?wGGbkrZTOnejHH81kYIpskXbO4xw1REsvK4UfIafVgT/rqv31gIYpkT0GUdj?=
 =?us-ascii?Q?DKhKOJnCH7vp5nwrA9or3vKfVqOvDW0wCxDjxuC4Gfj0v2RWONCdpgNMY5J0?=
 =?us-ascii?Q?M+gD4EcaZD3TLcuHw5/Bp7jO10A0GIHmPaZ813/gNKKBK9f7EWlVR3DGAV0c?=
 =?us-ascii?Q?n7wNxPHgF7MioWbNW8jocWLANJh48eymdR32TbbjEn7iUibYVQxec/PbZ1FT?=
 =?us-ascii?Q?7e8/7Pj7rs/yPX62PQkmoaweonD79r2O/1V3qCxMzRbw8zS8vqwCoO6obzea?=
 =?us-ascii?Q?vao2qlMzY7L42bJyC1r/x1aSLxahyeXgSquu1ucACDATu6TWLJ+XJmXfgcva?=
 =?us-ascii?Q?jZtcRijVSStNHmnGLtlvOxplVpTA8KyGsLR5LovRs/oHAqvA54jd026pO3C6?=
 =?us-ascii?Q?TZ2tAcstcTKwiltz/2Sd3vztuHBqhAupq498at8p/ZekjQusC+oGeM2/p+Tb?=
 =?us-ascii?Q?yrJEreJwUMcrKpCk29d15nU+v1RF5PiKRNSWwGj63+uqJXUZDtVHO4qthcwX?=
 =?us-ascii?Q?VaI/LbXQgxrqMhqcyJBiO7Nl/AsNwp8xPyRWwZFC8CUkybUGIj3Vt1lpVC9v?=
 =?us-ascii?Q?lrpSoT7z3wJf+UndREnL9OjJGlrSrLBAZk0ILAUFZ528Z0Ck8FJRP1O4RyHw?=
 =?us-ascii?Q?Ose2grmJALXPaUmNwXgOJRH7aFm+Xv6P/AEvkOILytRGqhuS059P0BcBfBLw?=
 =?us-ascii?Q?bxpWSQZtOue/XXGUiYztFMKi0IkX1ud86IOc9ioseYR2ao4Q6KMc7pUstDYF?=
 =?us-ascii?Q?ZPxnpdbz+5245ZaRMYlRsGX/gRQco60iB5pzEc38C8yQqN91pVaPNCI+Zwcn?=
 =?us-ascii?Q?l90H5tLnGGQwulHbeU3UXT9O779KWJW15IsQ3yvdPdnGIxyJDzgCnaAFph7G?=
 =?us-ascii?Q?5JnzquaiapqAWLpqThvrW2cMD4PZb15HFX75exUV0TBmNhV1Rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TMk7blbCR2Eyn9woOAGbS0eoMFkCCxNBUt0v8S6nvM9MqcjWLB2Sb1f2gFPc?=
 =?us-ascii?Q?7ByYX+UvkVZXDTAxvPmDDKKQjxkIJBZZdUuyPvL4Po+vbQDR1VW97WL0c5TG?=
 =?us-ascii?Q?E9r2bE7ldxgNL98v0HH1xVnm07HyCMEWGSK/u9MHp5cjngFCc+2y9jBEZru8?=
 =?us-ascii?Q?yi4Bp07FwcOLdMx/XfGkDUbDaP53bFePZq99vp1qiOtCQ9nqQ7dR8y7IdWyL?=
 =?us-ascii?Q?HlvntoqR06zBBi0Vxi40n/7X7OdaIwZb2GAa10JlikZoUlk6MrTr5ae/LnUM?=
 =?us-ascii?Q?u/oEbF5AyGK6NW6g4AWxW/lSIc0sp5yrGE43wjO71sbCC5lrsjrygTtn37Tg?=
 =?us-ascii?Q?bKXbyzmhJ7vY6fA3WuAMfd206BbnDt1QJBW19aaIZ1sduqz6yxnfoTLVrA2H?=
 =?us-ascii?Q?SFzAvr0z20wiGf+Mz9KxMS4oDYyikslpgRe3bYNGV0fLhrnVsSp+O5DWxIFU?=
 =?us-ascii?Q?5OyYtACVDsz0Lu4EebHDRrosrKvZ4JpoZH44dQnqzqRfbQeuZHYUZc+Cso2L?=
 =?us-ascii?Q?CqckP8LSzF0kANS96gOq+WxDsnao+FACKek4fB0hYVF0QD9LcLCTY9sQ/ROw?=
 =?us-ascii?Q?eNJNYYEs6OuoS2PzaPVru3NSbacyoXOaqp2yB9/LBda95a1KzY9pz3mP0Rz3?=
 =?us-ascii?Q?FV2tV4FYzwouWKW4KR3k+BM5qKzvivV71ZB0SIqlWgAS8jD3th+NZjBjyINL?=
 =?us-ascii?Q?fWX5qQ1eEqu5zpWGAiiCnAROI/Tsv1XhfTepbNJ9UyPxAUxeg3eF4m+w6aMd?=
 =?us-ascii?Q?PdsC1eHVs+Xbz2hGp98ampQqPRj7MBOIjdOkP+GzHaMiOR47q4rQeDCZKbEj?=
 =?us-ascii?Q?1UDb2GZTGEyzegb0AhPVvGyRwZyg6ndC+XkuvkrLqZSNJXKLJhmUvMNLGZPw?=
 =?us-ascii?Q?s7p2BB+oscUUUoCcFinMwmvmmY1GH395dAseAe1ZtacVWTOm5fPErilrB9oG?=
 =?us-ascii?Q?RjFePcDFY4AYxO+TyWGckRNpDyXJmhzPo9TWMJZ7aFb0GjGtw93020puXPOs?=
 =?us-ascii?Q?k8flKTP8QLeqjEEkSJCFgfhFOQHZ1jcxn8weQGXZoC0HbJvsde50ztX+FVys?=
 =?us-ascii?Q?KGZUAeaOYQxWEwbW1z5BD8oJOQsw1TpCta1cFfkeYtx3qFwFP9+IlvPl78C9?=
 =?us-ascii?Q?vi1L6mvik/p4L8BqIWmdnIE97gW+BS9SQimstxQqz3bqMNw884bGIOODI7Ls?=
 =?us-ascii?Q?Z7phyf4JaR9VUTZHXqKgnlG4L5Fv/8/Rje8ix85nfc5bMrAuZUGkwG4ni5aj?=
 =?us-ascii?Q?jvDAizvUAnexqJ4pe7Iw+4NO1gcEmDvFv3SeidypnXNDtKfvQNvqyWG9ACsM?=
 =?us-ascii?Q?xyKM73tUT6a+UV325xYg6osM17b8QlN5x9zHTd2YTHiuveZa1KPgSWTRjSaJ?=
 =?us-ascii?Q?nzjcQRBjPsgfEMrMDTL4UNCWlE0P2kYTfrVlM57pEtkPPSSqdF86BIpl/p+5?=
 =?us-ascii?Q?bWoWBaVa0HlsEojO366Yq+B00lyE63VmainIfE73MPHwS3/dzNlhzdZOaZ7G?=
 =?us-ascii?Q?6XbykwncFxdV3Q/nC0AOS3+Ic1DMuGtcKlhSzLb9Fib+0eYusyz/YB3K3C82?=
 =?us-ascii?Q?s5Q7vRl2F83pqgETJRP2lHtj7t6ZLc/6uTuh2n2GRWQ+72ftHy5Ylg2yO7BR?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee64a4e5-4b0f-46d6-d374-08ddeae633bb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:34:19.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tQZWoVrqwc3KoLc3KXDVdD2QiPseuXYg+frBdcevALPTmuP28DGiEC6GBTLgilTzcrs4ndN5kVDMpNPvXHcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

The ITE IT6263 based NXP LVDS to HDMI converter can be attached to the
i.MX943 EVK board LVDS port using the mini-SAS connector. Since this is
the default configuration for the EVK, add support for it here.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx943-evk.dts | 121 +++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx943-evk.dts b/arch/arm64/boot/dts/freescale/imx943-evk.dts
index c8c3eff9df1a2..5900ff355abc2 100644
--- a/arch/arm64/boot/dts/freescale/imx943-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx943-evk.dts
@@ -34,6 +34,18 @@ dmic: dmic {
 		#sound-dai-cells = <0>;
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&it6263_out>;
+			};
+		};
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		off-on-delay-us = <12000>;
@@ -127,6 +139,115 @@ memory@80000000 {
 	};
 };
 
+&dcif {
+	status = "okay";
+};
+
+&ldb {
+	assigned-clocks = <&scmi_clk IMX94_CLK_LDBPLL_VCO>,
+			  <&scmi_clk IMX94_CLK_LDBPLL>;
+	assigned-clock-rates = <4158000000>, <1039500000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			lvds_out: endpoint {
+				remote-endpoint = <&it6263_in>;
+			};
+		};
+	};
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pca9548_i2c3: i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lvds-to-hdmi-bridge@4c {
+				compatible = "ite,it6263";
+				reg = <0x4c>;
+				data-mapping = "jeida-24";
+				reset-gpios = <&pcal6416_i2c3_u171 8 GPIO_ACTIVE_HIGH>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						it6263_in: endpoint {
+							remote-endpoint = <&lvds_out>;
+						};
+					};
+
+					port@2 {
+						reg = <2>;
+
+						it6263_out: endpoint {
+							remote-endpoint = <&hdmi_connector_in>;
+						};
+					};
+				};
+			};
+		};
+
+		i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
 &lpi2c3 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&pinctrl_lpi2c3>;
-- 
2.49.0


