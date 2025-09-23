Return-Path: <linux-kernel+bounces-829591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30ECB97661
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC244251BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF330CB48;
	Tue, 23 Sep 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OG4q60rS"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F730ACF8;
	Tue, 23 Sep 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656733; cv=fail; b=lw2Siaja6iaCAsLlYofJjHJ5AuBObwso5f2e6Z5ap0h4ubKhcVDQnBiFr8dkjCstaiq6pvMDuY7fr+Yv3gijjBUP8Xnv5cP7b5941PbxGQgrKFJqLw5mleIxU6Z7YUsB4/5FDwQHAH/1lAX8vRXCbw+s1dTuwT0N9uDUj8MBBw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656733; c=relaxed/simple;
	bh=XZ1i9UbC+50Ba7Cy44Xl8BX3bXzVGPdpL4qOZPGL1Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2EyJsCqrdI6DUshSR2yocmWMq9bZRkQwnLURaT8Ros3oM1wnVga8OLKy/qk9JKT90gGF6ANJb0MJQt9t5OpAHCX+YlD4jz1p6eFOkWPCQipibUaG901ilB2qnBb8B9BvoCRdLc+BxIW94MORooibehp2GBy0TBDr46awdioTGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OG4q60rS; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGXTw0TDYWOfugi2BmhEeRrhMm0P7Qk6NBxvl5SWnh8MqH1XKyBrtEvGbUP9Dxa1ftWkQ08+nGxSgwwzp9uHR9ruFDfCk74wQ0vqC6Wgw7ss5HLqEklf8pFSa8d+aXdNMaTCDWiccZq5OPJ2wFfE/o6pSUYteMOG7uRWQmguejywh1gD8Y2Jx3FRYv20kmA5gHWqhTtypsevSdwlBsRmjNd+i23X9KPP02ppxeGXLhFm31EmaD6tEIy2nCz5II/84jRWKWwBLSgSCadEZkfueOU1QEH0ixiD4J0H7PJQWbMsT2aGjTH+DES5xmFziqTGhnSHnuUvzml1478jdqdbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0mLYkH51yP/Rb3VEvfvTB/ZUtMjfgsYuDbmtT3vtUo=;
 b=ApK/zY1IWUn3wrooAjkdWr5lwvcWAYxgQp2cuJ/ibwPG75Dx1ERQ4pKcjD4wmOVkx+EL2IdCKYRtV4I6MBYRFygzP/BcsOfPaQ519H2omgI9KfJ9+sOvco23ZtZByuwoQO1ZmeIosA63o3PuAurNIp+MYuMaeXUPB/9LJRzzpNl5an+sJwdUmYGdDSn3DsStROPqUIrl5R244orRaCocMLFFc1AmaHHHqpY1+37X5Bp1DGDW53428dMwvTTuB8Uv+pK8/WR54vR6bwU0AsMvZGrclvjHEOShAEBIQ0xFivHIkwOFzJwPyytqlSrwD2A/tjLW3wedbckEgn9izorKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0mLYkH51yP/Rb3VEvfvTB/ZUtMjfgsYuDbmtT3vtUo=;
 b=OG4q60rSew76I1VDk83fXyNeBsQi0eEhVeDr5/Mu5P/a59mc93Ks5Sn1rLSf82K1l3pKslX8XgGfcfXsNqsPVcLt0afF+12490gmSEsUXXFwkgX4w13yuPALhaBu3vlq7vpkxgJdwg9gawGjbWkgC6++WZshIDMGhiSq+Xmp8ZEHK4R3OoRpS/gjN+Om2fPjTD9UZw2E+sFJHi6WVEAjHtDkz7nLfrk0imrRsno/6PR6FKYh+1IYoazNAs+6dYm2CvXENtLBEAagYbDzAhmDIp9q+GARvC7TyguCRbR+5DVRmnx4l5Pt1TLmDPC2LOX+SVqiWs+kBBr2hwWD7vfDKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:17 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:17 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 phy 13/16] phy: lynx-28g: probe on per-SoC and per-instance compatible strings
Date: Tue, 23 Sep 2025 22:44:42 +0300
Message-Id: <20250923194445.454442-14-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923194445.454442-1-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: f14ba4f1-5ad2-40f2-31f9-08ddfad9b921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Stu/antWQ8UHIIJ8KysFt+/NVUcDFHIWw3vNRwjkDtgJ+lP8dDFwtwDsRKk?=
 =?us-ascii?Q?07Zy3M4n+V07blF6m32QC2PbC9bvnLR4YZFHc2MFJCORzg/hf2P/pnNnGapW?=
 =?us-ascii?Q?yVwy6wVXyNafXOp4trps55y061Tt+wpOvoKiybs1pyTjjcjtK3l4BO8IaAUL?=
 =?us-ascii?Q?LHrDdEO8ivopmF5bCG3xqNFtVnc0injYdQ5+sOUWOdQtzrgyB5IHB6YbSMpF?=
 =?us-ascii?Q?tPl59pqKhrtzuLa5a3K5JpBf5eA3Ce4crZmMFYr5lsBcdiZKW1qkwPC9qdUF?=
 =?us-ascii?Q?t5bp+JOFZ6UpHETbXZZ/73OO/ZvLQl7vzJ32LXN4UOUFzBqGh6tupb97JwTB?=
 =?us-ascii?Q?noVo/vdnavX6zLr7gUSKz1d9ynkKZLU3gt02Rgusxzk5fk1vQyVRGnGnl/1r?=
 =?us-ascii?Q?4fak3z4992E+r+3yTLnbRP8rQ6Qv5nwD4CHg+vTANmBn/Viwq97mjfa/D70F?=
 =?us-ascii?Q?OksebJoDhp1NA5N+lJrqRB9l9vEhSNaNpFhGkVER6ENpE4ZAu3NMoeGSp0dR?=
 =?us-ascii?Q?KcK10pMMpCko0RNH7+5Ev/26EsJuDT6zm928ik0EhyR1wB9KKeGZdAGoOrg4?=
 =?us-ascii?Q?2lKBs0ZKjNoBl7WKYCtM47FSJzQIVPAP3KsEPwBy3Jq+L8EenLBpvue/aQI5?=
 =?us-ascii?Q?7nQPWTdF0xlHH8/oGmUDofH0vIxbK7A97Wlkue9OfSXPSvKQ3t00BurC/z8m?=
 =?us-ascii?Q?HTddSZQEVpsmLoGavZkc0DLwetrCdILCSuZ42MqAMZ+KpOeMe4Ceygc8SQgR?=
 =?us-ascii?Q?uwZQ7QjwwKiUUcM+7f4WccEibiwEWNhsq156tfSr8JJuOdR26nPrOLVjWNJX?=
 =?us-ascii?Q?KWqQnxYZOv04VLGFZYT+nx2JAkCERFPdyBZO0pP05SZMPdijtI4ycDNzAfDo?=
 =?us-ascii?Q?L02BX8ZRoJa6l2aUKLibJ5FEs4cNEu1rKbSg39ZSTeQuwPMBaAx3dUnvNLRe?=
 =?us-ascii?Q?HvQafx1pSunCSMAjElmZNOMUb1jEgR5tNBwwgy/2TSLw2TAScnlTblCrJUB7?=
 =?us-ascii?Q?SPmjISvKISrIj2xseUwSkH7qpHvrIdk3c++tpatUTWHojOLine1JIISropnL?=
 =?us-ascii?Q?kL0t7tEpxr2kdzQF2OZxtekBAuE2xqOjrLyPHMjFMdIR5/FPLcgE/VYXTY9n?=
 =?us-ascii?Q?2lA4XJL4BJ7hTcj5+8lnjvm1/9d3MdHDerMazBsCb94pmsbXqnA5qlDZa2dZ?=
 =?us-ascii?Q?X65raEMpfDExlWBG6kMMtbH0xkDeK11Jq9tKmJW+uEh6fRlakUbbZwNCeauj?=
 =?us-ascii?Q?ZPPFCSkKkdIOjF8OhsvqgPvesVo778CIXvViadaoNFiHXPqsuC0oYmi2dAPk?=
 =?us-ascii?Q?V9ZZfXxE6rUEfRt1wh2SullgIjrFtkydKm2PEj5a2A3YXgBfak889eVVDbXj?=
 =?us-ascii?Q?Nd15QNKgHMxEuS8WL5Ynj3Yp6H88iNiaM6IT4PxKUzi3Sexbjy7/SHTG6SxG?=
 =?us-ascii?Q?3opXRN+moYlzeLRriF2MbalgjMWPOcFPn/YNOMq3CaCG0OOzgTpWTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COLlkDMM9v9hp+vEJ8wbBXFkb3Sib9YCnWQE3/WSHZWuWWmsxb+v0NI7t5b4?=
 =?us-ascii?Q?P7wTvaP2A67pBDfCrwozKVp9YPZ7u27r9Z5C7Q+Hq7Ad+/o8mGNAMVDVbbf0?=
 =?us-ascii?Q?p0mPkaMPTdtQeh+gxTfqOlyK11+cpJARLttW+43uYD7xfpDExKM2oBH37Xf9?=
 =?us-ascii?Q?Rr5xRaA1nsTP5PQImFwV6+ktQ2wDF2de29G9Z0moEcUsOfkN/50vz0g7aJ8i?=
 =?us-ascii?Q?y7W+hNIWiriTGPz2aPw9O3QXwQS7dSqYWaNAcs0vzsYF8XWoCmJSoUQ683pv?=
 =?us-ascii?Q?vqH98KKevsY4Q+zcJwHHK0BQpzVMbA6l6DnI4QhXRHPHMQroCmeWaVII9sn3?=
 =?us-ascii?Q?DkRJ29EMI41LWF+Fdl/rrxQQVqPGRUD05rz2iRviEjXsE4toHYRJLHaoWvPt?=
 =?us-ascii?Q?+lS8CrBeWPbk9a0bgbX0Ts3EfDf6B7C2HjKRiKnvdFeo49E/eZocU+JB1Svm?=
 =?us-ascii?Q?WOFU5088RSLIKxTjbqZGyHAeeyOBRZjH/0tEn2bimBIudYI6HymHxN0y6Ljv?=
 =?us-ascii?Q?I74tF0KX9CH1VQKDPQYItpTnz3osTHkNIy3btTRjXBrnnQkBFc3q2mW7kHPo?=
 =?us-ascii?Q?JVQKNbHkVREzCpYVO2nZu/revibM/ew6gp2wqLusmXOrdebQQn6KNxo3a1oW?=
 =?us-ascii?Q?esQ1X9SpECiLKpru3ZC8T1GBeFe0QQUN1jw1iBt7pZyRGEc41RqOaw387Kzm?=
 =?us-ascii?Q?RZtVtb6BvgXRNplF4TY9s/j7nCRxkZgI+LJ3PMNfq4yBs9R0fkMrL8BQ1NYk?=
 =?us-ascii?Q?kMIkJlkYLm60gEtC5KO06cyOJbfsv3vzjqP1EYWATECx8NrGWMOIL6sJ5hQV?=
 =?us-ascii?Q?1AKVahbc7iX4JNtSlPNX7Fjryb4labwRNfCWDnd+kL2RiNdhfdS4UpQVmLP9?=
 =?us-ascii?Q?ElgK3+XTPuvDFzfgukZU9/w+5KMx+7dZgiZ6fCwhRELaTFB3N9M0y0P6RP7Z?=
 =?us-ascii?Q?l6ntBd5nGIJS+oEucaVa5QQMk9EN4fUvgTTslotxE053JUNmu5V9ijxFAKJx?=
 =?us-ascii?Q?ZR/GfBmdxV13kzfzaAFBh+2/1rE+9KZ54qyxp0+c6cjceRwCfmLfRQAu7TKx?=
 =?us-ascii?Q?wvD2ZHbokeodozR/yb3u9XMjF4D8vloDY1jOPphC4HbjA4u/NMr5y8zrPPeV?=
 =?us-ascii?Q?14Ir9LhcBp/nUrIBaKI6+u2Akeuqinunghqkwia80dCsv7Ppl6GWvQDKwp7t?=
 =?us-ascii?Q?W+6R6EFW6ql5ZL9a7wuOReBTA2xwVY5gGmEw0Dz0qbFvat/rty89tD3tXGt+?=
 =?us-ascii?Q?f2zblRl17uBeHV1kzyc2ojVf17HPQ773OvKPGk5p+5A74cEO7lUZcCbgXh3I?=
 =?us-ascii?Q?IX/c/SrE32wAylC1OeBui70LLnW5CEz4/2dH1/T0lTZwF4aRzBS1jM/FTo6y?=
 =?us-ascii?Q?qxxPkU4maAt/h9WWJLbRFdCmlno8C3KT7zvHMfwnNO25/BIUHEaw6+33Znty?=
 =?us-ascii?Q?1cSe4bzChpSKPa4ELpLKn6O+3Y1VceiUvcDH3bahqRF/LaXOx3Ku+lVr/AaY?=
 =?us-ascii?Q?uAA9dnJl0HghyKE2ZMfOxZIpkBi6eKRkHFi3Lg3Px2gh/nIwXO4UUapPs7fx?=
 =?us-ascii?Q?5sAK5l7pmUNyH5c3rOu7p+8SQRkvi4QQCOuyKYnpRIi6BDR72lXlhtWR80qA?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14ba4f1-5ad2-40f2-31f9-08ddfad9b921
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:17.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fryi4rjcN+9uAdgxEDFDmebg/183nlYLpi1eO+vFiZE+cZme07AJ8RLmxSS3ctggfLCKs2+kt/RCgRii6flyVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

Add driver support for probing on the new, per-instance and per-SoC
bindings, which have #phy-cells = <0>.

Probing on "fsl,lynx-28g" is still supported, but the feature set is
frozen in time to just 1GbE and 10GbE (essentially the feature set as of
this change). However, we encourage the user at probe time to update the
device tree, otherwise we might access lanes which do not exist (0-3 on
LX2162A SerDes 1) and we would fail to reject lane modes which don't
work (10GbE on SerDes 2 lanes 0-5).

Refactor the per-lane logic from lynx_28g_probe() into
lynx_28g_lane_probe(), and call it from two distinct paths depending on
whether the modern or the legacy compatible string is used, with an OF
node for the lane or without.

lynx_28g_supports_lane_mode() was a SerDes-global function and now
becomes per lane, to reflect the specific capabilities each instance may
have.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- remove priv->info->get_pccr() and priv->info->get_pcvt_offset().
  These were always called directly as lynx_28g_get_pccr() and
  lynx_28g_get_pcvt_offset().
- Add forgotten priv->info->lane_supports_mode() test to
  lynx_28g_supports_lane_mode().
- Rename the "fsl,lynx-28g" drvdata as lynx_info_compat rather than
  lynx_info_lx2160a_serdes1, to reflect its treatment as less featured.
- Implement a separate lane probing path for the #phy-cells = <0> case.

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 199 ++++++++++++++++++++---
 1 file changed, 174 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 5b2a5b1e674f..9b8e24828d0f 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -433,9 +433,15 @@ struct lynx_28g_lane {
 	enum lynx_lane_mode mode;
 };
 
+struct lynx_info {
+	bool (*lane_supports_mode)(int lane, enum lynx_lane_mode mode);
+	int first_lane;
+};
+
 struct lynx_28g_priv {
 	void __iomem *base;
 	struct device *dev;
+	const struct lynx_info *info;
 	/* Serialize concurrent access to registers shared between lanes,
 	 * like PCCn
 	 */
@@ -500,11 +506,18 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 	}
 }
 
-static bool lynx_28g_supports_lane_mode(struct lynx_28g_priv *priv,
+/* A lane mode is supported if we have a PLL that can provide its required
+ * clock net, and if there is a protocol converter for that mode on that lane.
+ */
+static bool lynx_28g_supports_lane_mode(struct lynx_28g_lane *lane,
 					enum lynx_lane_mode mode)
 {
+	struct lynx_28g_priv *priv = lane->priv;
 	int i;
 
+	if (!priv->info->lane_supports_mode(lane->id, mode))
+		return false;
+
 	for (i = 0; i < LYNX_28G_NUM_PLL; i++) {
 		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
@@ -687,6 +700,86 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	}
 }
 
+static bool lx2160a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2160a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return true;
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
+		return lane == 6 || lane == 7;
+	default:
+		return false;
+	}
+}
+
+static bool lx2160a_serdes3_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	/*
+	 * Non-networking SerDes, and this driver supports only
+	 * networking protocols
+	 */
+	return false;
+}
+
+static bool lx2162a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2162a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return lx2160a_serdes2_lane_supports_mode(lane, mode);
+}
+
+static bool lynx_28g_compat_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct lynx_info lynx_info_compat = {
+	.lane_supports_mode = lynx_28g_compat_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes1 = {
+	.lane_supports_mode = lx2160a_serdes1_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes2 = {
+	.lane_supports_mode = lx2160a_serdes2_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes3 = {
+	.lane_supports_mode = lx2160a_serdes3_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes1 = {
+	.lane_supports_mode = lx2162a_serdes1_lane_supports_mode,
+	.first_lane = 4,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes2 = {
+	.lane_supports_mode = lx2162a_serdes2_lane_supports_mode,
+};
+
 static int lynx_pccr_read(struct lynx_28g_lane *lane, enum lynx_lane_mode mode,
 			  u32 *val)
 {
@@ -939,7 +1032,6 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	struct lynx_28g_priv *priv = lane->priv;
 	int powered_up = lane->powered_up;
 	enum lynx_lane_mode lane_mode;
 	int err = 0;
@@ -951,8 +1043,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 		return -EOPNOTSUPP;
 
 	lane_mode = phy_interface_to_lane_mode(submode);
-
-	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
+	if (!lynx_28g_supports_lane_mode(lane, lane_mode))
 		return -EOPNOTSUPP;
 
 	if (submode == lane->mode)
@@ -985,13 +1076,13 @@ static int lynx_28g_validate(struct phy *phy, enum phy_mode mode, int submode,
 			     union phy_configure_opts *opts __always_unused)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	struct lynx_28g_priv *priv = lane->priv;
+	enum lynx_lane_mode lane_mode;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
-	if (!lynx_28g_supports_lane_mode(priv,
-					 phy_interface_to_lane_mode(submode)))
+	lane_mode = phy_interface_to_lane_mode(submode);
+	if (!lynx_28g_supports_lane_mode(lane, lane_mode))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -1067,7 +1158,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	u32 rrstctl;
 	int i;
 
-	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
+	for (i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
 
 		mutex_lock(&lane->phy->mutex);
@@ -1120,24 +1211,48 @@ static struct phy *lynx_28g_xlate(struct device *dev,
 	struct lynx_28g_priv *priv = dev_get_drvdata(dev);
 	int idx = args->args[0];
 
-	if (WARN_ON(idx >= LYNX_28G_NUM_LANE))
+	if (WARN_ON(idx >= LYNX_28G_NUM_LANE ||
+		    idx < priv->info->first_lane))
 		return ERR_PTR(-EINVAL);
 
 	return priv->lane[idx].phy;
 }
 
+static int lynx_28g_probe_lane(struct lynx_28g_priv *priv, int id,
+			       struct device_node *dn)
+{
+	struct lynx_28g_lane *lane = &priv->lane[id];
+	struct phy *phy;
+
+	memset(lane, 0, sizeof(*lane));
+
+	phy = devm_phy_create(priv->dev, dn, &lynx_28g_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	lane->priv = priv;
+	lane->phy = phy;
+	lane->id = id;
+	phy_set_drvdata(phy, lane);
+	lynx_28g_lane_read_configuration(lane);
+
+	return 0;
+}
+
 static int lynx_28g_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	bool lane_phy_providers = true;
 	struct phy_provider *provider;
 	struct lynx_28g_priv *priv;
-	int i;
+	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
+	priv->info = of_device_get_match_data(dev);
 	dev_set_drvdata(dev, priv);
 	spin_lock_init(&priv->pcc_lock);
 	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
@@ -1146,26 +1261,55 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	lynx_28g_pll_read_configuration(priv);
+	if (priv->info == &lynx_info_compat) {
+		dev_warn(dev, "Please update device tree to use per-device compatible strings\n");
+		lane_phy_providers = false;
+	}
 
-	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
-		struct lynx_28g_lane *lane = &priv->lane[i];
-		struct phy *phy;
+	lynx_28g_pll_read_configuration(priv);
 
-		memset(lane, 0, sizeof(*lane));
+	if (lane_phy_providers) {
+		struct device_node *dn = dev_of_node(dev), *child;
+
+		for_each_available_child_of_node(dn, child) {
+			u32 reg;
+
+			/* PHY subnode name must be 'phy'. */
+			if (!(of_node_name_eq(child, "phy")))
+				continue;
+
+			if (of_property_read_u32(child, "reg", &reg)) {
+				dev_err(dev, "No \"reg\" property for %pOF\n", child);
+				of_node_put(child);
+				return -EINVAL;
+			}
+
+			if (reg < priv->info->first_lane || reg >= LYNX_28G_NUM_LANE) {
+				dev_err(dev, "\"reg\" property out of range for %pOF\n", child);
+				of_node_put(child);
+				return -EINVAL;
+			}
+
+			err = lynx_28g_probe_lane(priv, reg, child);
+			if (err) {
+				of_node_put(child);
+				return err;
+			}
+		}
 
-		phy = devm_phy_create(dev, NULL, &lynx_28g_ops);
-		if (IS_ERR(phy))
-			return PTR_ERR(phy);
+		provider = devm_of_phy_provider_register(&pdev->dev,
+							 of_phy_simple_xlate);
+	} else {
+		for (int i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
+			err = lynx_28g_probe_lane(priv, i, NULL);
+			if (err)
+				return err;
+		}
 
-		lane->priv = priv;
-		lane->phy = phy;
-		lane->id = i;
-		phy_set_drvdata(phy, lane);
-		lynx_28g_lane_read_configuration(lane);
+		provider = devm_of_phy_provider_register(&pdev->dev,
+							 lynx_28g_xlate);
 	}
 
-	provider = devm_of_phy_provider_register(dev, lynx_28g_xlate);
 	if (IS_ERR(provider))
 		return PTR_ERR(provider);
 
@@ -1184,7 +1328,12 @@ static void lynx_28g_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id lynx_28g_of_match_table[] = {
-	{ .compatible = "fsl,lynx-28g" },
+	{ .compatible = "fsl,lx2160a-serdes1", .data = &lynx_info_lx2160a_serdes1 },
+	{ .compatible = "fsl,lx2160a-serdes2", .data = &lynx_info_lx2160a_serdes2 },
+	{ .compatible = "fsl,lx2160a-serdes3", .data = &lynx_info_lx2160a_serdes3 },
+	{ .compatible = "fsl,lx2162a-serdes1", .data = &lynx_info_lx2162a_serdes1 },
+	{ .compatible = "fsl,lx2162a-serdes2", .data = &lynx_info_lx2162a_serdes2 },
+	{ .compatible = "fsl,lynx-28g", .data = &lynx_info_compat }, /* fallback */
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lynx_28g_of_match_table);
-- 
2.34.1


