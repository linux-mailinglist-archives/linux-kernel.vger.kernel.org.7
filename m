Return-Path: <linux-kernel+bounces-830251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C7B9933E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429D84C520A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31442D9EC2;
	Wed, 24 Sep 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="uGyTnHik"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020110.outbound.protection.outlook.com [52.101.69.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B942D97A8;
	Wed, 24 Sep 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706907; cv=fail; b=QYHMecS2ux6jns5/tym0BuECQhm4jCDF+h8L7QSdczW+Ff/KkPjcmpLA7GVOQB06/yda5yDWXRi5T3vFiyTIce/7rj5xV4llaLAAuIl2kXxjwBpVah7IO/0qEiK2LS0dP1Baqqe8TbBbDLlvfNWeCnSuJyCCHfHKzYJO0ipHe+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706907; c=relaxed/simple;
	bh=8ACmMiCVANJYH1yxqYOQBBcnNZAZyobHws3h+TqSvEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8ElWAKcAjVLY/C0XoWPbQlq+xUK5oI2l8YanQzNWTuEhUoqZTbTnRxq5y6x3iupzTcdsC2CiDba9WvF5OiH63m1zeysV+4zk/uBeYEAf5Pb47+yDgVPS+zGkYt8IsZGfEi5FGYgphCGuWnJljmPIRJSzTbotaXJNoN5+XeampA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=uGyTnHik; arc=fail smtp.client-ip=52.101.69.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzG0pRrGeL9F92tSJzCx1Eyv9Z/2pDdSgCnwqhpOW2+hnJF0F1+koh5HcAtYEGPnO0ufen89uJKBCG9I7LnZOEhA31h4v26OwwajP4BpcEOpxa3XY776NfBTaheLZvnntcnA/40Y3+WUDDhDlQh84RLJIbwPie2iIxWi9xmCuF+98mKZm6iNGw/w58/VhLCTaJbjVmKcfKvGT0iHGM/+3LgqisX+iBaB/OTyR7JLKcanxUgctqbz+GAwpNJxram/RKuMcondNXsB1GDthRFiySrN0Tp5ec1VWnqqiVogEpA1UPkvjCOUmXa17riEWDRp/UhYdQ5d12rbl80ToyS6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9Gch6omiWO3A08BFZ6zYYOikqsDOljdI8CDFQzYHoU=;
 b=MzqS6gQugiKF6Ut6EVCXqVgLnmV2EwBHbHPYLIXkTrpkUTeEpSub5TesXvLKifHNEvVWP561rZqblTi5PRwPYY0PHgAyQVk/QGXprsDrZ0JvKvOJCYBKJRZbLLWMfj0m35jheQk6d1YM0dfo5MS3iEMf/4meWovSzHKEbRrsR5MKzB0d9Pon7lt79ALboqK0NJ2a9/qkXbtJj7Dq/HzRPbBhtuwEaWgsjfhXsUlWW+6UDk66x71vCTy0wCnMdA0w2YUeXwj8m9Zi1Bk3vBkQCTyge8xC0gtHvRt41IflX7/Epjrowdl1UgoAOFuE2hOO1OYJ9oZ/pK6zU3uhtsJPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9Gch6omiWO3A08BFZ6zYYOikqsDOljdI8CDFQzYHoU=;
 b=uGyTnHikdYub4FIqdXqpxOUd9zqG0kcmeJKdk/fT0cKWWEWb/VeVApLKrY8+BD5aSdKCn7i8JAMFo7YHu1vPOPEdUJhpwYQrbpq1daDnT3eaP+b5H/4ZmKeF+0uLdQxO8hTPbGlT5hsAEXQIrGQuchrA1rq7Px6TwW+/g8gZ5nqzsrjBYYZiHSaQbsQ0YALyScF9L1CsYGaajV7WXsWDKA3xouumpx38npY/EsPqHp+EvrNKwODPwK76MwnAvlj16OTir3Llb3JY5cvrfxIKVA38+MfsIYNg8ZeuytMDDxZUTsMUbvY09Ou3UKwInsGl1Ar6nS7UbQEJxBPnU/wt8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6098.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 09:41:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 09:41:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v2 3/3] ARM: dts: airoha: update EN7523 dtsi to support resets
Date: Wed, 24 Sep 2025 12:41:12 +0300
Message-ID: <20250924094112.1918444-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::25) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2edffe-753f-4ebd-19a6-08ddfb4e86ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xUY26l2mDt97rLLVdcu+mjej+SlrPaITJe07JLPGnzFPXajhBgJDjvxk64Ai?=
 =?us-ascii?Q?34ti8HO6CP4ISMU5Wyy6XxfHlkADUIbPuOh1rsINMw1uZVuW7/aa5cHDu01b?=
 =?us-ascii?Q?xglXCISj/xLD2BTmfR1O1G1mpFhaZDmGqiKgwuavAEViCT7WQV0kFXxygJ/3?=
 =?us-ascii?Q?n0vIIt0adiZMG2OV9tuESpNNXyFUkcbUBD/v5K0EjlGz4tCKZfi2mPExzVQ5?=
 =?us-ascii?Q?hsGAG/HWYTBf+Ty5ujZtOFMabEZCtpH4UQcPGxm3cTPGObubXKj5lbm8Gt3o?=
 =?us-ascii?Q?sMYLgVeWyKR2CRUOFmK07pvWHOZb+msag+juqne49cuGQ7ewIpBaCtrWXAjP?=
 =?us-ascii?Q?hV1+LEvV0ZjoEKo/tdCeKhcah6sFyWRZPWNzrvEPT2Yc9adW8PndIvnYFQrZ?=
 =?us-ascii?Q?kkXbp0uhsuS+3eazo+0gwacYxOPQECuHC9R0jLKS43tdp9KG+XafkArawsft?=
 =?us-ascii?Q?ggDAiMHM36PGXyf2aIG2zBFMgDvWixySMsbg4u1KV4jJ2OYj029Q9IfUx+tz?=
 =?us-ascii?Q?28W9oXV6r7OF9IIec91nnEX2yaJXCZnPRANKjpTet95C428GqypX7Qu2EdBr?=
 =?us-ascii?Q?tU+U2sRpKLDCT+3sQYb5XiX3XVsviJQ9KXjbKvvxJohuxPRlFneGl+AB0HRE?=
 =?us-ascii?Q?UwZxKUNZlasbC3DRnnddek2BO36n5B7bPUM27Xa5oj+R9d44WGDG283yhWxo?=
 =?us-ascii?Q?xA+2FpjhIidqynqd4bp0IF91HSMabWKAf+NMQsyo0NwofuSS+fBLDqDxUD0F?=
 =?us-ascii?Q?eRDTRKjgeDNpP8TjgTDAjP5eYiaXn//KVcgUpHcvFrg8QOeB4o0o7xRa2cQ7?=
 =?us-ascii?Q?pvkShS4xVfW7FEGWQ0SgFIZttAUjAjFE/Jef8L0fJNtBYorLhZlwlk8mnWuj?=
 =?us-ascii?Q?KZy8QQ+OMTBEPugiN1iLaUIze1cMc3u/VoHpRMBnL2tmgv/XunD3tlkzMp+7?=
 =?us-ascii?Q?EpcM4B3Cf54w8JFoeoE4pI+/yalB1Jyamg1feebqIUw4HMxj4OIH2YjKWNZ1?=
 =?us-ascii?Q?f2lGhjLWUcmnlWN2cBWWPzhaY5XkXCbHgSwmQbHMREXJBfyhx5gQKirWdt9y?=
 =?us-ascii?Q?myXjCk5kxtPRXiasEsG352X+tIbb33wfi7FOG8lUFY0zyYV5ufK4xk8ADRSh?=
 =?us-ascii?Q?hVlkHbL3wVHRqjiT0MMQ80tNW1NGIJyVkQIceaHW91CHAhNq9sBpvl5TgMbI?=
 =?us-ascii?Q?QKdBx/D6oR8sz/5UyX6b0I0ZSEj+m9tkL9HCEdQUHFQf+tHUzku01pfYaB5X?=
 =?us-ascii?Q?R06g4bH4G45y6/rveVZVN0wwcj1gvyOuvBfrwTheG+eWEZPgIRWMQiqFsYsH?=
 =?us-ascii?Q?cczfa3LbGN0kHGHLwnDq4V85FOV0zL1tgPr82sf/Gv8sqaSTVH0LmUMH4gZO?=
 =?us-ascii?Q?2GTRB59mb4upgDwJGCPW25IfTOUJ4entuExXcHcAVU97zuKvsLnuVAS1utPs?=
 =?us-ascii?Q?WzGF9s4CiI9+1r5kufrf7VH2z/ddR4GSnYE6MtdVJro8+j6MptaGUdUpPcxH?=
 =?us-ascii?Q?cFfLdQOOfYGX9gY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jQa+yP1okomFuc9EspbkjnY/RcpFs/kAreheFHFuPherzezaP3b5oznjLaxD?=
 =?us-ascii?Q?dDt2mZt1vhZED54BLnXuWZHhubP0ecfg7G07cejMEI0XKCs8UpV+S1/d1QjT?=
 =?us-ascii?Q?D1DCPKl19Ia7+Y/NplrAtL0WCyYJ5Z3F+erZNM79zAnY943PaavhdCcA2XMf?=
 =?us-ascii?Q?SIRti2y9XdkfySbX73UZoPps5Sqr3g6LeE2ttY1pq8gH9ID7Fo/2+drwVaDu?=
 =?us-ascii?Q?RiRRMnQ9qBPa/7+hnGVbtlBtGisri/H5sAsg3B3ixE1p1GxFTh83V9t6hZU7?=
 =?us-ascii?Q?WmCjL4HWadnjJ3QmjFN9M6O4J4Bc4KWVy1JI220oPoz0SE0rvd5o3vOQjd70?=
 =?us-ascii?Q?Rr+EbPeN6klokZOFvSnVsqgfqZU+RdyDLtqHI+Oa6x/JxADGmqgIT6m87ULZ?=
 =?us-ascii?Q?TtTIGBbAlf7LDGKFcsGhMOCC2OK1AfX14gj6NRBG7KBde5yvOsfaMAblwnIw?=
 =?us-ascii?Q?BawMZCGFWDTAbvMtX9xaAboWXO3Bwi6U0VdbtPeVlytFouk70XpzmUU/5OTT?=
 =?us-ascii?Q?0mXC4Jxj1mr3DX4QBc4LQGdWwES74KfzPD9i+gvfLYGqr3VCggqhwFRRuWtO?=
 =?us-ascii?Q?FUnxLY+4v+7ZYTefyEKqd1sXnSmfA2Lu0ABKfGsSZnUV7qD2/BZGcGdfTq0I?=
 =?us-ascii?Q?989h6ZjvX6mYbDR/ZGDzYKn2k2s9m/y7vNixJSr2WC0LzZ4hD0zKefNVAErR?=
 =?us-ascii?Q?rHDfND+LF1RyVKdf+OYYUxtKSBgrb54yNVnPEEh7WcgVZOVt1ilNRK0VtoSE?=
 =?us-ascii?Q?PE3t8kP5gjlUI0iDXN71NMFalUViIXXsNlxUn8GNX8KeMa1UGZq8SN+mF6gj?=
 =?us-ascii?Q?44SxpcLCDYFSIryiFOvATcWAVcIZuhaTegV0u5oz9VxRJBFl2cXh+P4L97CN?=
 =?us-ascii?Q?66O6j07RElbI66EXkBlxCKYd5msogLnnFfajzbKwK8xSZVGmhmbRtjGYn2n3?=
 =?us-ascii?Q?gXq3hnSFd8tb5Ukl0g44U1inItLeBGX8LIyY8bPZPVxLWLQ60Xj4UoQSFM0J?=
 =?us-ascii?Q?tb8TFD1Cpx3dcZYTni8fMBolSX1XtZrHjfcj/Dcpngsh0ZUT9xdRpoBuYtva?=
 =?us-ascii?Q?ahkW7k5zQ6hM9Gjk0Pw8TvYC/DPhaZA9wsp7coINRSsFx8Beh2K2UCg3+O/B?=
 =?us-ascii?Q?JncaV3JDV585AtoLpdRaoJehhyftmcxu6MGdA9T+tMRUNqh32n8xsJ9PD5pO?=
 =?us-ascii?Q?S4qJSzL744STauL/B5rSHMIHJprkWKimAF3S4fCvpiAdNXqXh9DzHF0n5LcZ?=
 =?us-ascii?Q?5kzduNd5PvWgrtvROq4loQPQuIzCA3MKKB6tjr23EbD4a6nBZqAwL1wTu9bG?=
 =?us-ascii?Q?jtdg14G7tyyWAq3Afe8PBfsHLkb68q59HAiDvvto3oJCr0vnfChcsD72xN7Y?=
 =?us-ascii?Q?MJAojQy7WeCTvYCP3/afOmVcCTEqnTSD8rEyRh9X2t1Tn+pzK9bgI07+8isv?=
 =?us-ascii?Q?OTa6v03D7LpLIHBhuzXxNfpcppem/MkjrzWTLbFs8rsxkdWcL6SwZFdwPYl4?=
 =?us-ascii?Q?024xOv7gnBHqHNsmhYCg4HnbVCbdKuJ5BiBYqm0FnIpTuhUBtuvZF7PR3gwL?=
 =?us-ascii?Q?ftLzUrawkDcad+vjlaJKKGga57gIkHAiw03tBdDDVj98gtCZgivkPq6ALkOs?=
 =?us-ascii?Q?x4YXDCcECNtDq5IG1DUdphE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2edffe-753f-4ebd-19a6-08ddfb4e86ef
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:41:24.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTy0hrpgV+u04T1FwGUBuJtoDQN1vx2cIU09PAjRvNfRJLHckwi/ij7BErhTi8TZXCiCfWzCO9219ht20IeM+m0yu1lcewQvLh1MsNVYbUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6098

This patch updates EN7523 dtsi to reflect the reset-controller
support for EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/boot/dts/airoha/en7523.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
index b523a868c4ad..231638b25c5b 100644
--- a/arch/arm/boot/dts/airoha/en7523.dtsi
+++ b/arch/arm/boot/dts/airoha/en7523.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/reset/airoha,en7523-reset.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -91,6 +92,7 @@ scu: system-controller@1fa20000 {
 		reg = <0x1fa20000 0x400>,
 		      <0x1fb00000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	gic: interrupt-controller@9000000 {
-- 
2.51.0


