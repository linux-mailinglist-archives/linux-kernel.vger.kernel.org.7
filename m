Return-Path: <linux-kernel+bounces-701408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB39AE74A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 04:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD661923647
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3E19E967;
	Wed, 25 Jun 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NMDum3z5"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B43074BD;
	Wed, 25 Jun 2025 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817244; cv=fail; b=jQq1soOGVbWZlnoZy0xjsJDGe5taFP2izyfP7d5gWAlIMJI4li0V6Rf+6Iqen3OV3Y4g1K5UER6cbXewb5xSmnyc6sxsDMJN4y4vy8X+rHDJwxseXlp2rYJKQHPDfvR6MakZZnSVEBHPrUzjfvibKRb02sB81XiLoxJJyCf3dmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817244; c=relaxed/simple;
	bh=1pMl135sNHxBgSK53OJSTy1L/8bebVgoRsuH64iuKPI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=J5dP2d4E5qGZmefNkPSE26B+ESGiot0N9FtUnr6eTsgqZkeuVSEp5NEnzXSVTQ808eyJQP7QgXI6zkBCpJYKuAXaXx1WJpOZ+RhB24msgdZCYA0nvuD/K4F2WDPXwRJmssQHzi0/3xkjLBn0lW6sSd7/0F/ho8FiW0Lu/hLwOw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NMDum3z5; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtj1H4eCgzIbv6teRH9WMNJ4ncPCUECuGhs0ek9iqTYKJsgfd/LglAp/GBfvmgxNxBZ7HvrifatBUxAqgd5kJuF3bDr4Rq+bPBOr5yBHS57kxexHWdMUJqEltJLiy4MOwqnP2B75v3RrwHWE5r81F2mmxKbCiA+nNE6sgYdOsVN9hb20ScwWb/x/xuOB7e8fZvnLGGfjQTBxcsrG0HQAykKlNj+m41YOr1OIigsiMGDVhqtbyR0kZdvZuxiGh3qMcXKIh/MgZ2O98SKfCsqcQSzCc5amn9Nf/VybJFoeJq1030hsCgopFK6aHkVYYAluz3YQ1zwHyKadIj/G6UAeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp3sh28CaxeSzlF0eAGsqDF6PEpno+gQxpxNKcMWYWU=;
 b=euLBFZ+Dy0V5OFRJuBqDGFoXK0yDMJ9sKw0CFYlss7N7zxxcvuEeEFz5yNxMdwOE9YFXZYd9B8Ticts51JyEfOocw/+EqlCzuIxYFErRQzJJNXz6IQT/oTFqBBDgRcVYiyTQX0bWAdJCt/VbiGC0dL7TNogu2jJUztHFekBP+V/pkN/wmLVY+LX3H/5rp8cjk+sj02AsoDviRTXQiafIRqlLj6fJQPM4aSKRkqesReBud2s/mLz4iUYJ8xVuHxeBE4VKzIMUO9CPx/2T4etXar+cqcRgME0vzhOm5nHj6DN254X25kswSZyVV2jsNOMIluIrvgmXzZZws17P4F5NLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp3sh28CaxeSzlF0eAGsqDF6PEpno+gQxpxNKcMWYWU=;
 b=NMDum3z5z1q3pJ2uMSql0QJtjbOZp65dpZaAl9u3eaQVVmtwA1Lgy65m5nXUvjZkE8n5+Rs0TYrObZkt4muNO+NJdYIjUh9kJnrbSoPGOn6K19rBTYN2xJvYdWw4Sk5RarMVEiTM5EqFj29x04lboxeGpI8RnCUqaq2H0rnMoORZcrLgKCwohWfCXV4fxtyNG9Ou/2N0dHAewvHZ1vu5iNEkYeLd60VWaVmGINqS+4IL9Gy2fyohqYPZWPZsS33bfFYEJCuTLwxJPkjWwvWUNiP/Or8ob8l7TPduhrWtqStb9JwrXZi/XFVp/lG4LcBO3AUDL31/VTvQeonPXUKtAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DBBPR04MB7850.eurprd04.prod.outlook.com (2603:10a6:10:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 02:07:18 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 02:07:17 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_asrc: use internal measured ratio for non-ideal ratio mode
Date: Wed, 25 Jun 2025 10:05:04 +0800
Message-Id: <20250625020504.2728161-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::14) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DBBPR04MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: f258da91-c798-4a01-083d-08ddb38d0284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6le8EwF6MR7CNiOiCk27vRa+bgjE2RdEr4PSdxu7iXYqqRcP+xevpr7CCPX?=
 =?us-ascii?Q?Z8uQiqsYLBg9Ru7NKiI3t9KHayzzACXTFGYMLOTiKucNOybopKqoz6zApJAI?=
 =?us-ascii?Q?UJ+tESqOBDfzJ976GB9Rw4kcdgmjsZuPMNA4XkNRUjQfxk691v3JJ10sf/b3?=
 =?us-ascii?Q?VbFBsBa83MWcW5Y47hK0Y5u3Uy/Fg5z5SzZBsEOjlM49QVvOBeSLTPhd0kdH?=
 =?us-ascii?Q?DD58UrFZbZSg//WEmB1K9GHsrLxpCy9tMwsxp3gTOT4bTpluUAINU/XuZsR6?=
 =?us-ascii?Q?/lFaDr2pMJdbQHkJPKPYzJkHQWG56tD9BR0/OIHmBIzz4l68niZ6y6uM7sE6?=
 =?us-ascii?Q?86z0w113GdGBuSoX4W+i2/wOmhmS8ZF2RUPSJ/dlf3i61YV14lS0C1CQUDMw?=
 =?us-ascii?Q?I9mxFxTQREtNQNfr5HSxjJ6K3DRnNMbEDXXS24WdHQz9w0QxGAQEZe/91k1a?=
 =?us-ascii?Q?MGI58pV9m5kRiipSPgheq9nlTHWQXIeclAPxQndc+iQcek24Sf1k+IX7L5ez?=
 =?us-ascii?Q?Xu70mCPPngiWMuObSSTn5RqPqmTmYJ3FxCsigx1AqYF25NjB9u0VY+v9aTYF?=
 =?us-ascii?Q?oYgvXB1Gpe754Iz3hjSs9RgrY3NddhNKa0Q2ULqOcfK516OAbzWBeEUNLHDx?=
 =?us-ascii?Q?SvwonHb8huujWZlafm5ePzOmtibCRm59rgGN33A/Xs2JfHV3hUZmrdaFLpLw?=
 =?us-ascii?Q?fcxE8meqrAa4Iza6bZlGkqqulK7q5PlP9UNbJiy6MHZIlk7vhr2bp6ZAdWu5?=
 =?us-ascii?Q?16AkFkyctx2QVwjtk9GuYT/UcaaIvIL+lPY6Ya0j93lqkj4Ell7rcmcgaEIw?=
 =?us-ascii?Q?a5EtvqhVfy93zG3ZNHztwncjwRU4Zc37nTLs68csJrA4njIXg20yjj/TB32s?=
 =?us-ascii?Q?QLeAj2XsaOD0RH9oMgdeXph+6aLC5/pRtVTw18mjgkozLjGMmQ4kThvH6jHl?=
 =?us-ascii?Q?+iWGPxNSH2il/IlctoSEjNdTIK2C0WjhZBrQ3hnNoQGFlWJPkvSskJH4pn8p?=
 =?us-ascii?Q?pCMK7Uo+G7RaW8a5jddGMK1+BqBDNinc4+l8zekt/wN0k/DkW9i+dOHWwjpO?=
 =?us-ascii?Q?CU4cPOv0FiI3kjci81AssMWw1mFBjS+/YYxPb6rQcj0GKCCOxEUlcJgOvwRr?=
 =?us-ascii?Q?IoakOeeJuB/KSoCPmIqBZPKSoKJdQYOrWKWWiGVxLak6/DoLG8gwlmsZguqM?=
 =?us-ascii?Q?wMslOWzFhntngzVV7btNyrRQwQST+1o15L2Q5qeJD36EDFtGhRh1lPGGOlqW?=
 =?us-ascii?Q?/UwAhzfYjjg1PynVmuigQeLcBphd3tAyflVWRA9tPtr2n4gDVGfjNbXTqjPF?=
 =?us-ascii?Q?FVPQ1zlKsfiBqDgKd2Fkuldp8t2+bwIConZC0/frgCcEaDWGN5LetLWgAE6D?=
 =?us-ascii?Q?5jmOaj4XaVel5x4sTFkmqe+9gvrnnygM6HsbQfD7EyWwZK6CNbB4bVw8SCR9?=
 =?us-ascii?Q?RqlARuNQ4b4YtdTdGWd8FQBV4lwmR2o71L/HtuJxlqMpzVWAF9+HgIMvUPpb?=
 =?us-ascii?Q?ohWHCxdOvTsXS+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+xaN6bI1xIQjkgLGHQAKJ51gKaWLP2mZ0f46xvNLFZn73h+WPNoj8k0v+ZK?=
 =?us-ascii?Q?YUvu427rzEISr9ZV7a59cVjVv2fwkwx3wTE1D73s/PrFM+K9XwN39McA2z0Q?=
 =?us-ascii?Q?H5OSNpJstxQKWgKlTH3vVeS8mZ6keWYk1KSZXyAY59SpDFUusCR/PQRyVGwb?=
 =?us-ascii?Q?bVnfYN1n4N4TRr81t5dUU6qrJawDyOcxL+jFzhzg6wKlECt5GUXet4n0s4UU?=
 =?us-ascii?Q?HzykMKxBhhyukeG01uOEoB85k/qlEjA+IccNUtgrs01tzTPdDVLN/s//riFv?=
 =?us-ascii?Q?GxA4HI52LMSBeWgyaDDNP4b/OTQIS8LRe6zf1NaIY4qOHA+BlaWN1GbdbqMk?=
 =?us-ascii?Q?OOYl4Ta/ahCFSrbP18ni1ifJcQtuyrMVwPAyDRNJPZp7v3S5+JIWU8yrKwH9?=
 =?us-ascii?Q?cJDsJB+eHdKda7hEdYMFVp4t7qCyDNL9m5PLVSfm781fxmxPWPGIYzjBgJup?=
 =?us-ascii?Q?lq5/8DtgcZqXxLC4ATnX/Y2CPL2zeR7hFqw3JUSbw+1vUevmyj3xsYf11QuD?=
 =?us-ascii?Q?Z2aJ+L4opKiQsdMPGsXabwuVo9PeAxdreIzWyXqUSQf0L4THd19dOt2i5jWS?=
 =?us-ascii?Q?7sml0cQRQ9i4jncI3FG0QKt/SeDEmKoiEHRtjBWbs+D7VGWhZdDl4dYu1hws?=
 =?us-ascii?Q?pqshjElvuKGrL2ir4F0aBDzm/ALQ7smTBWHa+iL/wteQDFhEmkOKTCocnP19?=
 =?us-ascii?Q?F9ShQBzbKOmbfEKSiR+SfGKQ804Pikdb6pehaB3O9J/+jo2i749SOTHlCQNv?=
 =?us-ascii?Q?DKcKo6SD/w+Bu+7hkvyIAUkFrmFWFbwtv3kxs+gT9A0tbDm3RYBhN2w/NKoy?=
 =?us-ascii?Q?kMPkmeS0gDvvtJR5tbqf1LCGJYQ6cdwg/erswlqVrJeoThFtZAG1+Fl4g2jI?=
 =?us-ascii?Q?RMxrbgNSPW7LFfQv1wNsnFCxDu5IkxOmgu7yx0S3o7zxkSt+dThS75TAwpGh?=
 =?us-ascii?Q?lhbNRBN4wd7QpNPrf+GGFnlo49lQmm3LAejJxw4lsmcqULHui5SQs0GxvC23?=
 =?us-ascii?Q?mr9X1X1FH/Khz5jgW03Gu1JlV5jXkyKD89U5JE95hpCQy0ugKaLY0T6Sm4A3?=
 =?us-ascii?Q?DWoMwFZCBHSYy6p1AO+lCY9kbBWgsK4H3WoR6ygs06dcTkTb+Dj1OOtBwAk1?=
 =?us-ascii?Q?lxiXDIRito0KkRbt0/tLZN5/hq+fAFJaCNpdJ+siloZOuMrkKyqdjrbxdl3m?=
 =?us-ascii?Q?6zb5UUbEpJQSZLA9sqEEPhfOaWxvHyNOigdQI4yfrPSb5Pvgd1h2QqAqXCJE?=
 =?us-ascii?Q?2B6qAl/7WIxwQbDoYhn6xa/gUPxM+3rndm9Y0Q4l5ZfI5U8tbPgriBmJMSVw?=
 =?us-ascii?Q?rzyLl/LOfKNCgaXcr2HLs7DbVrozOowNgiDxcWOkvWvZBoCkfcg0ObDBG2eK?=
 =?us-ascii?Q?nDgyjsHx/RBNtxrMVDxtuVLsEXSlu2XWPK2CCf7EpbvBVVDIWUfx8IzHKOHM?=
 =?us-ascii?Q?Q1BKNUo3lTe2JSRbKYUB+TjjRzrDz1Yl7TCJd2NKLrBfHck3e+VhspgsFiV8?=
 =?us-ascii?Q?jR7MNWyA2LPaL3UCNP6BiEF+oU6s5RKcgVNE/6uwbkbIsXJn5JrfA6lP8+cs?=
 =?us-ascii?Q?FsLUweQi5kMIkNJtdnd5P7WJhwIthnO+Pc2xj1ls?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f258da91-c798-4a01-083d-08ddb38d0284
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 02:07:17.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6emaybj5zut26ex5lNwGFV1Df23x2XogP6y8X1qPUalh5L+AXgMfc+lT/ZadvC3ABBdyBoAAweLxkJo7G+g8lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7850

When USRC=0, there is underrun issue for the non-ideal ratio mode;
according to the reference mannual, the internal measured ratio can be
used with USRC=1 and IDRC=0.

Fixes: d0250cf4f2ab ("ASoC: fsl_asrc: Add an option to select internal ratio mode")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 677529916dc0..745532ccbdba 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -517,7 +517,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
 			   ASRCTR_ATSi_MASK(index), ASRCTR_ATS(index));
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
-			   ASRCTR_USRi_MASK(index), 0);
+			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
+			   ASRCTR_USR(index));
 
 	/* Set the input and output clock sources */
 	regmap_update_bits(asrc->regmap, REG_ASRCSR,
-- 
2.34.1


