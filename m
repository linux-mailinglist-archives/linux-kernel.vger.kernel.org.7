Return-Path: <linux-kernel+bounces-834505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E9FBA4D55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC7B1BC7B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2589D30FC29;
	Fri, 26 Sep 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q1TSydA2"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C830DEDF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909942; cv=fail; b=izxT6LGTlvU8ASiuhQXn3/FblMK+w2ZVwRKcf/Ybx34fIIHctl+fgAVRHTAl6zJaOIFvZybAjK9ABGs12COpo74qBE6YBGrL94rEF+kvsbZ/VkzoNRCBLpBGGZLh037nM/0NxuuLV/vw4JPC9GVUKhYatdr278Wg86+tsZWyAck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909942; c=relaxed/simple;
	bh=1tquG1Zd3vBHVe8gu2yO5YXXCAkq1jNVUM3nJFYH/hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YyADaMkbdtdfCxH6dSNM2trm3zGy/obi2k12ZmfDP6FOOv5X5dg01vREWOQqLqwoqF1v7MmsaBS8y/YA2p9sQZK93s3TJvj+I2AJWXLr7mCa9cfGcR5pXMSvK3pq7x13YncjPFwfkjZidMPG8OjyrONEq0e4hcWvkw85K1oDxWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q1TSydA2; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPIE8SkY6rBLrYdKv7SloFEWADM1UbefAoiYiKA6E0vZCBtxyUEpSA1cv4fPa19hdzM2rsJf53HF0DQqEv9s2D4k/6VnV1ECBqRR6S+/FmUgczus+zScnQlNniFjWqXiLov2/qgN61M0o+QZJ5Ta+WO2KnhNrJGLwvAiQVXWNwDuYsz/3FoYn/PgyDpnjNnFDHI8KSNiJUYbsPQ0DS5TVl1lKk4BR1xUBWQWXQw4be/S3/hMYxB48uOVG89uVHEIjyKmMrXV6jClRuBgGOjC2AIHC+HWagvEA3GS5P0CjVEIXg6rkwxb1GD73zqotEFaBJt9uTSsMMse+YxAhJ3Zuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4a1GLbKzH+QUYTvw3DCzOml6Vo8Ow7A9guPKvn5430=;
 b=LIF0UQ+RMqWQnKuKSkgLUsfMnU6NrDH4wUvTUXOPy5TqYlEe2Rnr4a1xUF4lJVuzlPmOPwdUa+ZqzW89QZLiO7pIbeUT1oKGoRifLUPKytnLG68IuNsKqihrIdVIWdmA0kYjdwi0A6chYrMNPtOd4N/WVEkTQfpxYWyomLk60zXeGVGKb5BNrasg25gtpp2VGyCsVnTssAeYBv7HldNxaGIdSIx0FnLymeb4KZW/3P0MF4X06LqYYFtSBvGK3Os4D/xCJ/+uoxBxoySgZWGtzujwYAnqK6AeMxegdS3L/iZRXYgPgnojqtJpFEoaK1Qmujkxy2fxuH3EXCsal/1MaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4a1GLbKzH+QUYTvw3DCzOml6Vo8Ow7A9guPKvn5430=;
 b=Q1TSydA2UxtqnE2sZjxat5Le9oHA3ugJxDsPzEax11WpU2HOwCEdFfS+7fsp707uPC51KruSLuunWr17XT5QGoZGqnglvHhpnGJsKbhGCldaXp2BNlvxVpk143QcagZoAkGc+ek7BVXEWJYWCZ3iFfCl3DQuKK9oPZgg7OToaauYcqnqETfoFB9xl4ZRc5WiG/NFswZIxpDfztYIuPk6EcpnPQXECQ+7f1gqhjP6h1601xioiZGI5Tiof2ZpPeVEcimEq7Hax+z0xX9+N4VrxuXFkIpBSczCWt2efr6eDr0jhdb7C+O/aRR+vo5qfJLG101QF9xt6XJIXV9f52Ilbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 08/17] phy: lynx-28g: distinguish between 10GBASE-R and USXGMII
Date: Fri, 26 Sep 2025 21:04:56 +0300
Message-Id: <20250926180505.760089-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926180505.760089-1-vladimir.oltean@nxp.com>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 123fd672-41ed-475a-5d9d-08ddfd274637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hMn2Q7kFlFrmpfuc69DP/AyxRvjlWfgbuN5a+ugiGXpbWGHr8w9UbyZVebNK?=
 =?us-ascii?Q?IBSVI/8WTQbj/lBFSXe6CNI+MTDOGg5y6srKRWIoYMx9KgSq4Ga101jm6uTG?=
 =?us-ascii?Q?z5xKhvW2Tjp84h+QwbaCT5oQUsHUy1K34ouoJd8cWBeww+1LRH02rdAPvfOS?=
 =?us-ascii?Q?/RQ9QzQvZF1gLDFIzlkE5bOKsmIgLzLLaTkl86XGHacclhp0lUB7UVGc+Vb8?=
 =?us-ascii?Q?lQnaF8tDGJGubH8vVM/AmZTjjzh5BD+kfP7fgalMxeXFdlIAACDywG3Rxh4/?=
 =?us-ascii?Q?f+YKLlNURGSyXzG2KHRVCf8TOqsN0WThEmbHWKfSzDGnws+cN+wDH3bA+Wus?=
 =?us-ascii?Q?qiMU4Fy26gWToyC06UEuiWKwFNU7xM2yDdbl2PWJmFBeQgLCD9e6BMgitzum?=
 =?us-ascii?Q?ZRwxjhqQK8O/7zmEdh5f5PCqgp+KECYJU8Zugm10vM71HCyY4xatzo1FmoxM?=
 =?us-ascii?Q?ehpPsCxeVrHSBuixq7D4bSlWD8uIDROwFBNIWjbbkdvoOyYgk6P/4MLGs4ib?=
 =?us-ascii?Q?frbZ2zGc0CpANVatQITuuDuatKill7voVE90xEoP6Z96fFM8RurNaxdnIC7o?=
 =?us-ascii?Q?5aUKLjx4b0PWQgc/iwxhTu6nlHxZl0MZvQPqq41X07U7f2iTuDeZCiBI8ULm?=
 =?us-ascii?Q?yCypFOLfco/WdgMfM0DR4ueexvW4sIdyh0Wqulhcz/rzLdwJfNMK+suSHeD1?=
 =?us-ascii?Q?cFs1FQZMVou3EY7ZjWBb0jTO58SQ0H/8QSS83HSaz9lXie8Zdl7U/gVUG01B?=
 =?us-ascii?Q?eWO5Ngxr3zYe1Oj+cE+b1crkNmB3pp1fnUBcgkLqBRYH2PI80qFI+GVO5zB3?=
 =?us-ascii?Q?ijkcK1DOKWqhhOpXoATX5hiWKhERd8rOGI+TMfVrHxl1aQqc9VmLIBMzwT7z?=
 =?us-ascii?Q?bH3t46o7UxdoVbp4JZeZLlYOkqiQBgSm/h4VvmENJnPj8Rx/9lkWJmY4sMLq?=
 =?us-ascii?Q?M3mkgey9j7IXWs/Qzx1bkbFq4zohoNVoNYjryGjvbOoZddbF1oCat0pz0apx?=
 =?us-ascii?Q?vfHMCckOqO4pmBfAREV4AmhWSjxqTCCVKPZYB+2/KMOeKviAljEneYu9ULVy?=
 =?us-ascii?Q?ca9e9MRjIaCH1uypHw+7vrdF8Yjn3nin22UVc+PbmKFB+l/eOBqadc2jUhh2?=
 =?us-ascii?Q?GRAJxC1alr5xsjtF/13AXpseBRwM04kiP8CK9a3oFVo0PBhlGzxapaK0Xi71?=
 =?us-ascii?Q?IPtcLtcP1fkNVdnNf53iDKbXwSnqgnMw9nilgFukRQUbHbVt5285IUOJ/Nq6?=
 =?us-ascii?Q?dc9nbtRwxfPNx0X8GJxahQC5tKBjwCjzY0Ow1K3k3KOpODBsAUdiw2x1AJ6w?=
 =?us-ascii?Q?pwoPWJfVhkB/QD8Vj2CRjmAy3tshFkErOE3vOTcTJDduhCBXd7M/kjy5VcB8?=
 =?us-ascii?Q?AzUP1Js4S6CaF4FjQb6PDfVm5F9QZrRn837UavcUhbXpQ65B0iJLxfVstUES?=
 =?us-ascii?Q?Oukn9Z7nN9CRBWBfSEHylA1rewzm5+qffRZUzata2JffTp4D3UHAafufd+5l?=
 =?us-ascii?Q?eUVguHWU9fjQJNQ5XfI2W6krfA24Xmk2Jwhq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tEEgqyeX0SbA6qXKeregzVc3gneGAFSDHheO98F4jSpimTiFEfXbGILRYltl?=
 =?us-ascii?Q?tyNprf5bptpAJM9a37iBZBTGMu2djglIkpnPMLyoT8TkOsdpuSoWaBiEWMH8?=
 =?us-ascii?Q?sqQAK+J1OfIVMsq3LxC5/yIO8eyOqeL7ECAq4R9tQKBjfvo9BiuG0X0Nrauw?=
 =?us-ascii?Q?EhwdG7gwYKcIorsnJebDRZEPLaidsQT+lEhVR+6KaekQXRm7/HThIleIeeqm?=
 =?us-ascii?Q?oJKUXdNofkwbP1GSbVo4dVh9e+nWEkOezjQS0lnfHcL6FNT52hhyh14ZaGT2?=
 =?us-ascii?Q?jwpKX7VBKYgjq0yfNxgkXUMwVc73P1m08Fdx2spRFDI9wbvhOSV3c8rVeBb2?=
 =?us-ascii?Q?9aWXsVsPoGbv+uRIGe6+Cwdi8SQ/CIqG6xG6vTbd7+EMgIi6Yilp9GRZ49JF?=
 =?us-ascii?Q?t1hCZCGbXqxiR9rPTJ9VOt1MQdQDhKtrZoVWhv53JH6RqYX1v0yTC5L9hVSy?=
 =?us-ascii?Q?Wc/6etuMLCqJLUfDoZkfuYMbwbyuDpadPwYsHHAJOcrp3O8yUCOaWRA/ipHM?=
 =?us-ascii?Q?hSK36cU/1TpKxPOsrC4PLDsSl5kY1EqDMMyOG8ooXhGHR63BLlmLfwWPxC3h?=
 =?us-ascii?Q?hVrQpaXepwI+kOJh+EpiFoIJKtjW3MdKFMu6MoBTssqPwOfe48JyBax9NK3d?=
 =?us-ascii?Q?h7SU97YfsPZLvaHTxaN2aknSBWCJxRFw9YHXHJa7t68dkC9RjciP4sjlIRPk?=
 =?us-ascii?Q?CWYL4dECppk/FTT34cfFW3rAFwCzIhHf/2w1kezKPYwlInIQEdMpCnGDHV7x?=
 =?us-ascii?Q?VBQPNlbGYgAAmzeZUxTSdMicCaPlTO+h9PKmE+iUf6zoHfhWdHlB+dgxYvqE?=
 =?us-ascii?Q?VjaUXIMhuq/5oBqMAewv8TK0ple7wTwrFJ9+zE4fc8/knw06KmmRxyAqJtKf?=
 =?us-ascii?Q?H5yZ0+cUAtD+o1ar3AJKnJWE9Zqzn6/P0rMZuyrNfXnz/4nKucaWKGqgHIbP?=
 =?us-ascii?Q?Ykama90nMbK+LBLXrVSIhlf1x+71pLqRLWVOSggXOBufRD5iGr+2E+4KDSb/?=
 =?us-ascii?Q?wG1qEyCZC/k4knLQSUYXznb6d4kXdkiPVSz2H6qaTgcGkwajMSrN2hea2jCM?=
 =?us-ascii?Q?IoohAMcpYhJcEdZl5TAG13MKjsydZoppm9kSVqSe3Ub+kmra/ErZxoh+Ovta?=
 =?us-ascii?Q?KV4nNSJLR6G2WuEXBBxe2bUbY1PqYxDpnvPi3LEEdrKiwbS0dUdAAviVbyzr?=
 =?us-ascii?Q?G3TbTxalZXsSENIT1suzihIkdySAE5MD8mNCR20UNoplgQJteqQJL8jzaRp/?=
 =?us-ascii?Q?5rVQvR3hoXjkrNXmFHWT3YwkKgo0G3Yuwtm4CiOkqmit3Z8wK+QJF6NPHq1z?=
 =?us-ascii?Q?UhoRrDp0hSX1ypWCGuofCuRDy7bpS6d3AyZ9+LcEXO0ZaLqROimrSZTe/kYw?=
 =?us-ascii?Q?8z37p4kze3U+wTje0RRldfwT/gYlhGtxqXGemqcjF+dX07Gl3QvriBtuFCK8?=
 =?us-ascii?Q?TV4SW7LD+Qalic1aB0kyXO2IZjIb2Z3rCqGZVu+omf1aDQlrK7iBeiyx/eUt?=
 =?us-ascii?Q?90mea92zc2rTGzjBhCkvzKibQwLhLT+3uC+A139bZCvZdAWuDzvVverJRt/N?=
 =?us-ascii?Q?1F+7n/AT+++2AP3TyMR5bHWS4JAfAjWMID3RqagMligT0/JyCM3EzvP0mnZm?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123fd672-41ed-475a-5d9d-08ddfd274637
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:28.2114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDBO/VDLBMkiehxg4zMG7LsoOvONHyyDOa4qxoO+Ww0Egw4i5hGJlZMPG9vd36WbdY6FliSQI2Ay8++EFlV6aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

The driver does not handle well protocol switching to or from USXGMII,
because it conflates it with 10GBase-R.

In the expected USXGMII use case, that isn't a problem, because SerDes
protocol switching performed by the lynx-28g driver is not necessary,
because USXGMII natively supports multiple speeds, as opposed to SFP
modules using 1000Base-X or 10GBase-R which require switching between
the 2.

That being said, let's be explicit, and in case someone requests a
protocol change which involves USXGMII, let's do the right thing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 87 ++++++++++++++++++++----
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 7ef81f26bee8..a8a335680092 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -246,7 +246,8 @@ enum lynx_28g_proto_sel {
 enum lynx_lane_mode {
 	LANE_MODE_UNKNOWN,
 	LANE_MODE_1000BASEX_SGMII,
-	LANE_MODE_10GBASER_USXGMII,
+	LANE_MODE_10GBASER,
+	LANE_MODE_USXGMII,
 	LANE_MODE_MAX,
 };
 
@@ -316,7 +317,35 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.smp_autoz_d1r = 0,
 		.smp_autoz_eg1r = 0,
 	},
-	[LANE_MODE_10GBASER_USXGMII] = {
+	[LANE_MODE_USXGMII] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
+		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
+		.teq_type = EQ_TYPE_2TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 3,
+		.amp_red = 7,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 0,
+	},
+	[LANE_MODE_10GBASER] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
 		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
 		.teq_type = EQ_TYPE_2TAP,
@@ -413,8 +442,10 @@ static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
 	switch (lane_mode) {
 	case LANE_MODE_1000BASEX_SGMII:
 		return "1000Base-X/SGMII";
-	case LANE_MODE_10GBASER_USXGMII:
-		return "10GBase-R/USXGMII";
+	case LANE_MODE_10GBASER:
+		return "10GBase-R";
+	case LANE_MODE_USXGMII:
+		return "USXGMII";
 	default:
 		return "unknown";
 	}
@@ -427,8 +458,9 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 	case PHY_INTERFACE_MODE_1000BASEX:
 		return LANE_MODE_1000BASEX_SGMII;
 	case PHY_INTERFACE_MODE_10GBASER:
+		return LANE_MODE_10GBASER;
 	case PHY_INTERFACE_MODE_USXGMII:
-		return LANE_MODE_10GBASER_USXGMII;
+		return LANE_MODE_USXGMII;
 	default:
 		return LANE_MODE_UNKNOWN;
 	}
@@ -496,7 +528,8 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		break;
 	case PLLnCR1_FRATE_10G_20GVCO:
 		switch (lane_mode) {
-		case LANE_MODE_10GBASER_USXGMII:
+		case LANE_MODE_10GBASER:
+		case LANE_MODE_USXGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
 					  LNaTGCR0_N_RATE);
@@ -594,7 +627,8 @@ static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 		pccr->width = 4;
 		pccr->shift = SGMII_CFG(lane);
 		break;
-	case LANE_MODE_10GBASER_USXGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
 		pccr->offset = PCCC;
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
@@ -611,13 +645,32 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	switch (lane_mode) {
 	case LANE_MODE_1000BASEX_SGMII:
 		return SGMIIaCR0(lane);
-	case LANE_MODE_10GBASER_USXGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
 		return SXGMIIaCR0(lane);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
+static int lynx_pccr_read(struct lynx_28g_lane *lane, enum lynx_lane_mode mode,
+			  u32 *val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_pccr pccr;
+	u32 tmp;
+	int err;
+
+	err = lynx_28g_get_pccr(mode, lane->id, &pccr);
+	if (err)
+		return err;
+
+	tmp = lynx_28g_read(priv, pccr.offset);
+	*val = (tmp >> pccr.shift) & GENMASK(pccr.width - 1, 0);
+
+	return 0;
+}
+
 static int lynx_pccr_write(struct lynx_28g_lane *lane,
 			   enum lynx_lane_mode lane_mode, u32 val)
 {
@@ -829,8 +882,11 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 	case LANE_MODE_1000BASEX_SGMII:
 		val |= PCC8_SGMIIa_CFG;
 		break;
-	case LANE_MODE_10GBASER_USXGMII:
-		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
+	case LANE_MODE_10GBASER:
+		val |= PCCC_SXGMIIn_XFI;
+		fallthrough;
+	case LANE_MODE_USXGMII:
+		val |= PCCC_SXGMIIn_CFG;
 		break;
 	default:
 		break;
@@ -955,7 +1011,8 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 			break;
 		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
-			__set_bit(LANE_MODE_10GBASER_USXGMII, pll->supported);
+			__set_bit(LANE_MODE_10GBASER, pll->supported);
+			__set_bit(LANE_MODE_USXGMII, pll->supported);
 			break;
 		default:
 			/* 6GHz, 12.890625GHz, 8GHz */
@@ -1000,7 +1057,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 
 static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 {
-	u32 pss, protocol;
+	u32 pccr, pss, protocol;
 
 	pss = lynx_28g_lane_read(lane, LNaPSS);
 	protocol = FIELD_GET(LNaPSS_TYPE, pss);
@@ -1009,7 +1066,11 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 		lane->mode = LANE_MODE_1000BASEX_SGMII;
 		break;
 	case LNaPSS_TYPE_XFI:
-		lane->mode = LANE_MODE_10GBASER_USXGMII;
+		lynx_pccr_read(lane, LANE_MODE_10GBASER, &pccr);
+		if (pccr & PCCC_SXGMIIn_XFI)
+			lane->mode = LANE_MODE_10GBASER;
+		else
+			lane->mode = LANE_MODE_USXGMII;
 		break;
 	default:
 		lane->mode = LANE_MODE_UNKNOWN;
-- 
2.34.1


