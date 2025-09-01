Return-Path: <linux-kernel+bounces-794908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BD3B3E9FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9C814E2E7F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94F324B0E;
	Mon,  1 Sep 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TnDX4Zij"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59921320A3B;
	Mon,  1 Sep 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739600; cv=fail; b=hR1P2FilJEmqV74HyGLdsJxIzLMb3stFTvF0zqiXMy/uwNVO+wH6uGqlwJKMsgX0ghc1vb2zrUTj0b3jyp5Q8/GQM3mKg6dBXxomgeuGweo2B7Xl3lBbhph6mpeDQXdq/QefqvBtv1he1d4bGytR1Czmcp9npWpCz+Zlt/bD2Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739600; c=relaxed/simple;
	bh=0TsBRrltV7b6vwxeL0RM9hDbjYhxmlo9B6q0xvErc0o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f+heOQLj1R93JRJo/7VXZw3KOILEBKnvH5IFgraX7e+ktWIeekPTKtPkok2X9Ng9VnH1HiqQMo21tvhcE06m+iqQ9KomQo6R9hE3m0+8F18feoqmi41CD3SvTdz4tNxrj//4WZ0znNEd1/javtdBaDQO/aDJXvA1vSfKH++3Mz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TnDX4Zij; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1862nn5wQ2gQ1FYZ4emjiYuS4ESM8Q6WREdZXDIFxsliH/MWFQMVdJ5ZRg4gYtX8/bT85MTVf0DCACFyFfcclJ+6vckWIT6+f4Z+Gv9yIxwMkvSOuXCGb3I3DdK8rFIgehviGZA65ljJi1Y7e9+PbM5mve0jOM0+txSRlXuSXEWqGNhEnEiwBJwzm2+6gyJXRn4eE8giOrNWzv4Q5qxGtLTuJ3R7A6VKZYIPcSQnCtVUvqS1FBzUHSFjiBeIMJRyG/WtwLryWJnWCI5SrJVAb3oULJ899jLKPXZKAM0Pv7k7uzlgRGDXqdI1L8OQDDn0/Bvh43nPmoQGdufYMdSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y5oddWOttJMkAom7Eo6XffqQf3UAKQvmoiCvU/4q6A=;
 b=fs3eH7NLEJTI/oMwYYW8RSn18ASu/a6RwPlnRaQhooe3xOEmZ6G6bwAJfkPeMK4IX7P+mRugOx+qzHfNyT1Ntls62M4rXbmmNe8rdCQxiSrUQtP3oM6Qa6iAVsnRAkDnWQ4ldn8eFAjsUfauPn6wd21voAcDjuWu3ULVlcREFXXLrvoqCVWN2n9bMXR+J4FHNWH4D0Mgk7rUjavhuT39Dh8bGFAQKV82UfsIzlPXVuN0AFYgAsZZPV3gzmiVgQKxswXeMEQGha+x0M5tVTJ7l+bC/j7/JB0qk/tboaNQNGWoOxdu1Kb3Y+Xh5eYvqKxuAjcbNVI7645MNKObErjxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y5oddWOttJMkAom7Eo6XffqQf3UAKQvmoiCvU/4q6A=;
 b=TnDX4ZijacsmrxtEW4E0GS+CDw/A48bQFDstpmKg1fUo68/zvfniBuwzUFPBxgsMZcJw/TUZB4btu80aRXPURTwavW51IjX2Gln1zs4hWhe/W2Cogqg6+PBD9zaQqM17rwAie6ciaUrIXAV9ZmMgxiJAgYa5zq6rJ6Z7/bOE00gQ/svJIp720cDIFZw1F3FJX4ifZbIeQwHOE7dRUtnYv5+2GaHhn1EFXFEvtXLLlGWEAy5kKK5vNnVhjokoqc27BNVHyhvJ8YizNrVmXSUc8sly7bFUnBNTgxQ7uKEtEeoToOl2G59t8/IBDA/ktPLqtsFvjYisiu8+LyOVC35XDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AS8PR04MB7527.eurprd04.prod.outlook.com (2603:10a6:20b:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.15; Mon, 1 Sep
 2025 15:13:13 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%6]) with mapi id 15.20.9052.014; Mon, 1 Sep 2025
 15:13:13 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com,
	robh@kernel.org,
	laurentiu.mihalcea@nxp.com,
	dan.carpenter@linaro.org,
	waqar.hameed@axis.com,
	festevam@gmail.com,
	kernel@pengutronix.de,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: SOF: imx: Fix devm_ioremap_resource check
Date: Mon,  1 Sep 2025 18:15:13 +0300
Message-ID: <20250901151513.286454-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::17) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AS8PR04MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f49cab-6f23-434a-8079-08dde96a11d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hwrVG1I/rwqAsqUEGHZyK2Luoms6I7ODIxsOSIliTLu08q2T5PFwIB7p5S5x?=
 =?us-ascii?Q?gvCPyab0rBVv5No6Tfbo2mSaqpmljk1+uEihsIxtyvbTGHffuq4VJ9JEFkjJ?=
 =?us-ascii?Q?6HGT0QtIB5/U748M2yWXwrgsnCA2jnPxP+8FReao2d7MztJ1qGIJMjcGErZ2?=
 =?us-ascii?Q?wx01LLVcUdDyYcSr61Tn0u2VNeilwVqZA1x4Z60oiiYj9eAJn/H+aUD5IBRL?=
 =?us-ascii?Q?HT5hAmnfJXCZ603zk9G1z1o+iNySQG3+WzV/PExg+Dy9QP9nlAO4PYHKkZ0j?=
 =?us-ascii?Q?y4mvWqmK77iHrkYmFlFZpzR1kz1a40J44WFWp0XGGWz4h0lnkWFMkFMDZ6V8?=
 =?us-ascii?Q?pK9nYRj74Hzfa49wSJOSQPpwvVegqEGvL8jUv+PWs38jDrXGtbxdy7cJQIZp?=
 =?us-ascii?Q?eCjUYpON03p5vTauy1vCi8r/r5tCUcc5026JBeGbz9v0y1GHo9Q2fdd8HhE9?=
 =?us-ascii?Q?hNf21bWt1PI51Uu80r+GmuKKeORbfXl6epii4uR/O7zuN9FMwn9VwiGwoPKq?=
 =?us-ascii?Q?YjXgwDID2emRtpKo/vayAG7TH/42FXU53PBL7BgSCq5ICUW6KWNB2WWbGUcq?=
 =?us-ascii?Q?OFP/FbVxGsqv6YgQTeP85hm7qAbLoarHXrdb6+TiKtAKk/vqS0NFze7tb9r/?=
 =?us-ascii?Q?QG3KC4TIa+rT/TwJnKF5u78nw65oDj31lSXbUV7u/IxJZonY75m0LGYa7GMX?=
 =?us-ascii?Q?ljYeK3EWGyzpUjYEDAZIMyWkQBhxgC68el7GSdHLHQQgQQj0JHdMKxgpJvk8?=
 =?us-ascii?Q?vDX3xAGGV3qil2u4hzF2nm014BgPhFVJJmKOCktX/Fqgp/tGWrZEuDNG3TQc?=
 =?us-ascii?Q?pG8O0pP3R8TWFesH/wETCi28RPPk+6XcWelIR5DWkcAvojMgL6YulXkxHfP8?=
 =?us-ascii?Q?Ud9nnrXwNHag3h1oihkydnUH6hyfuo5ir1p8uPnrpF/RUcDmViN58wg77L9o?=
 =?us-ascii?Q?K27hr/2eIlRdxhp6+nyi/mov/5IUW2d87/dhguGjTR2Zs2Gf59opm7QAYZSR?=
 =?us-ascii?Q?VbinthHkVanf1nYhTWUgK966Gw/+BkuX9yNXBOR0kjR4ZLnB0q8LBwPNvWB4?=
 =?us-ascii?Q?vRs3i3KpdbuQ++OPy2oJmTE+1PLUS2BrX0+R6WGBRUIY0brHMwLy5k+F0c8D?=
 =?us-ascii?Q?oUDqvt7wBmaSTckskfd4BLHsmlBMNaJ+fmm+QqsYdUu2UOZU+h9NHBZ34a3y?=
 =?us-ascii?Q?Bzzuejg+NdYUY4pc6t0EYzKI09tubT5Wyb0rC7EtQ6d7Z5yNFgcHQSQVrSMu?=
 =?us-ascii?Q?jBDpwh1ZJZhfGfHagijixILk4fy3FQHC1Jqp2lQSJ8Oosb8ji/aVUE4GNiNB?=
 =?us-ascii?Q?QRnu7Wi8uIj4uYriF40iwyCJ+FcprtbEG0PwF1ZVa/BXbxhFRjhqo9R5YSyo?=
 =?us-ascii?Q?ISaPZLR8cgRTuigW6JR3OcKW3Y02J9TJ9dTzpAMiZaokE94EdPoDnluRfTIM?=
 =?us-ascii?Q?HbDxujvTjtu1s32YcG+5cVdrg824JdBaDYaTAeHRsDnPzFbGoNi30w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1E4+RRiivQM38kV1AYVWvIn9II/YtVV3KGUUP6ikaJMzrgqC1/Pvo/gQo4qV?=
 =?us-ascii?Q?YkMUFPKqxjb5Whxwg2lc7OozF9MyCDfKZkX0v2ZzZibvsubPuiEWIMhtghO1?=
 =?us-ascii?Q?hI7EFLYH65zHRFxKE6mLo9rYYsk5Zt8wfUYOspIqf8Hl+FRE7J57F3+VUCu9?=
 =?us-ascii?Q?+vga2GGg3MwDZ8sjtZC+pNu4sjDtyJsLCQwg599x3gNANdT73I0vQFU/YNdx?=
 =?us-ascii?Q?sPBU35pR3TxZCcNRyYmtyXG+YkpUOlFL50+73a2ojhJh0LKstJqGgQJsuEvK?=
 =?us-ascii?Q?018Oi/jvYR48n6H2dE7tr9UHry80BvSQve7c2vDWdpEYteJYQx7n0kFxB6k6?=
 =?us-ascii?Q?d1av7nmi0ineRizm0l6BuBX9qUxgfvjkhPQmOvmSOzWl3nuceTURyQxS1AF/?=
 =?us-ascii?Q?ZhoiuRQnbkuIig71dXtFmAxnEEp7CkLekRpvquLCPx3vypUH4bS0xYMWi+4k?=
 =?us-ascii?Q?SGh3qnj3FVZTnvi/leUR+kihYlVe4p0sN2wY5dlGCkYj+i4o6XsTyL1e3YqQ?=
 =?us-ascii?Q?cM4TXn/J3VQDnS4Sh7fcMBk1mdzHW2yaYuNWMK41VWoFHaHglP8SMYBrCcJF?=
 =?us-ascii?Q?o7VHsDqnxg31xORZw9736DU2Oq9Fkv5CZflGc1V1k2UN8DZGrvTMATiyksqo?=
 =?us-ascii?Q?OAl1lIeQ/rLCNyQy6lJAmCQJ2d+R4ssYWWgb2DrDArKOqwdvbSiHfGGuM4pn?=
 =?us-ascii?Q?6GLOe+1lvYd3b540IWcsmdPwc/GMGl3MCvBugknsNo1R0eZ0ARLXaRDIiYad?=
 =?us-ascii?Q?xPmHs0+LzSQJmZK30NgSnPmmlSN7YoQbC0/HbsnqlpHp6l6Nkq1Z8HKIqEVG?=
 =?us-ascii?Q?o6FwFpX1miIc7qc1mGfse6zbO/zucMTgcSv4UegZR1AeoxZz+wlVp9j5UOni?=
 =?us-ascii?Q?6WRCYRrHaApM2YiW37CpIn8iipyQWA93yQ3biUPUYFvVCs56MEi3s1lerJ5/?=
 =?us-ascii?Q?OijfzLS/3pYdu90sVDPsusZqlsrxPukTelBNT6abGrXzB2sptL1pnySDf5Ih?=
 =?us-ascii?Q?WBYjqbDoeNNy0R8GWDNYNms2BAlo7Dgxl2he3c58deftvskH8N/HF2JIeD5E?=
 =?us-ascii?Q?YkhWmTs4+4eXobZYR5YdgKNDJanTQEpop903/CYWYNMpNnkXpx33MtMisumN?=
 =?us-ascii?Q?mKYcZ3DvgH915Obp057glYpok7nq2pOR4AdQZqBuHLjI0/gaLfPuzzoLpIB9?=
 =?us-ascii?Q?YVpWDJlhP/qUHqKuUpX6SleCvXZ9Wbvv949HWUXV6tCgHlHDvZ4UubIKkMa1?=
 =?us-ascii?Q?E+LGGV1GbS2YCkkVC6094PdX/6zb/gVR1aMAZTU6PIu3dEr+P1q9TPbA309/?=
 =?us-ascii?Q?VVcOTSOHW7Qu/NaJXLnHsT1AGX9/taDjkV9s2XePHCwfu1Hfz0kSCYBK10Mx?=
 =?us-ascii?Q?unEwf8lacAS5Z6MCSz4/LLW2/a5MTmhSh4L/XOuI1HyCwIeufjwFzNVqzbxD?=
 =?us-ascii?Q?iF5XN1rkBb3NVkAPeSw2aYUGJ8YblsHPZxYC5iqY9sqJVAzb7Wo3x3bWZ7da?=
 =?us-ascii?Q?12G9uHVi45fW0OZdX3GFI/DUfwfWJc/rsdD7e/0ojltzTMOgtPp1mche73QC?=
 =?us-ascii?Q?kGMgxvrv7C5yuYvG7t8Vm9z1XSfpl4wKLw9K0tf9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f49cab-6f23-434a-8079-08dde96a11d4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 15:13:13.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fkv7iF3puWHRoO11bbHNm78RmgnxP6aTcv6dE3I/I5MBNobYQSP8P7dBj7bHQOoaH32mrSYaMcfUbM+xU4UkeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7527

devm_ioremap_resource does not return NULL on error
but an error pointer so we need to use IS_ERR to check
the return code.

Fixes: bc163baef570 ("ASoC: Use of_reserved_mem_region_to_resource() for "memory-region"")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/imx-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 40debc541bf9..b3248c65215d 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -316,7 +316,7 @@ static int imx_parse_ioremap_memory(struct snd_sof_dev *sdev)
 		}
 
 		sdev->bar[blk_type] = devm_ioremap_resource(sdev->dev, res);
-		if (!sdev->bar[blk_type])
+		if (IS_ERR(sdev->bar[blk_type]))
 			return dev_err_probe(sdev->dev,
 					     -ENOMEM,
 					     "failed to ioremap %s region\n",
-- 
2.45.2


