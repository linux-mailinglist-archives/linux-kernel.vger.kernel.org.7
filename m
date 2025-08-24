Return-Path: <linux-kernel+bounces-783652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C398B33041
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12EF1B61EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304B266591;
	Sun, 24 Aug 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="h62pUX0B"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012012.outbound.protection.outlook.com [40.107.75.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B22DE6F5;
	Sun, 24 Aug 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043740; cv=fail; b=jKmrHdCa6EcJlpcZ76zMALQUbnlDFIRy9Xjdb2FaU1Dg2nnlFDRCq4/jeaZoalMQ/rhuTQwTopxJCxTm064ZR8m4Ru6kbYaHXncR90wYj9rgPFNXuJKjdZRmdVPr3wtvKXF711lXWboUqalC//t3bGZ5fvj6M1LuZpJTaFNINoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043740; c=relaxed/simple;
	bh=ApFN8UCCf64agp3Lhkenuz4g60mqlNJVdtf8SnBxsa0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HoSfIaRl/hnlbuxt5SbgLfglCocaJBLgLNojNZvzuTwMPYbUArsCHOhvNs4fHWJd/1D1RpSx8wpikipUnN74UhZKt4r6LhxT4xYDw7OTk14dsu8+EY6rJ9lMgp5AD3OSOJYXASRyw59NMaJlLLdvrQX6J9WQ1agDTYyS6iFN7Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=h62pUX0B; arc=fail smtp.client-ip=40.107.75.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVWj69bZRwtFVUwahiDHrlc/2iK6wBMmUC3wGJpEI8mWsGfUxtfjrOEFSxqxuikexYBQrJv2M6/KZnn6undSoF+UR0kFsG/IjdKDAPfeewKAoYihdFJkNTV5R9C0jJ/EMtvbA5ADZzaH40nWDioLA5CX2D+syptmELp91/XAbkgZ1W8ELHGgiDKBfmyuBH7DkOPkYIwWwp8Mj7yyUPPd8yOoxAxki/uDtZUCBcDTNV2HK+2l67pZqxfDWssLny8wGOA4BFcUZn/tUrtG+OTqIXPBdnG46CE4/3Cvo/DRctSEg2GUczmRJgTU+LazoCecmMoLB9gQtB4uCEWTQ/rpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSxXZUd9M3LpeIiG8YcLqCcgrE/OpLacLSunETs3WQ4=;
 b=L9cdXoXtvNYMPTvI2yW79ikeKlfu7N0B1ssS/SZF8HZoJZYO6Z/a0+sZBowMQETjoS3KE7fHD//j6XocwM7tQF3VKxbYQ1I/O/NbQwOmQh3Dg0PyJ9My/WKt1n0Pe41OA1OdB7nyLI3fiASNcES1k9wXKdPPFhmcpaQJOJqX6aBAjqCvIAeI1pNuIPrVAUhB4stmjofCQY327IiNP24PnTM2193Foin3NZc6e5zuvN0ozaG57w1eFQuyMDSUReEW0BPNtBMVuISa6zbV6vMpfrlAGQNvl/kuXkAojBArZwB0d/a5xuoXU3cA58eDTmITiP/wC+35kS7D2CewV2Xo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSxXZUd9M3LpeIiG8YcLqCcgrE/OpLacLSunETs3WQ4=;
 b=h62pUX0Bu72d/1RppEJeg2uSxy7uVVdGXn+ioO1qJ0njM8anXO5LHYYaZjZrXl1sOGNAzSj4BCrfXapRG3xir9v9w2TSSLoDPr4llGN3Wqr21524DnhtcChs3exkn+VCpa730+SmSMWJXmK0lGSl+VhV4BXkEuiHjdPXVgqCzGKb/CY7EhqKX3vbwmxgOZKJ9lah9I+NJ4UYHcoW1Tam38hD0y8aJrgk8B9IcqZvEd+2cj3kSKC/So+TzJgzfvVdO3oIOuySLXHD8OIU+eiCpLkNi9JXE0eyJTWiBuEBz2qsjSGOV0mpMHtrLeRIOyf72OGyl09JB8J2lWN0HSdL7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5685.apcprd06.prod.outlook.com (2603:1096:400:283::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Sun, 24 Aug 2025 13:55:36 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 13:55:36 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	linux-sound@vger.kernel.org (open list:SOUND),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] ALSA: cs46xx: use vmalloc_array() to simplify code
Date: Sun, 24 Aug 2025 21:55:10 +0800
Message-Id: <20250824135521.590780-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824135521.590780-1-rongqianfeng@vivo.com>
References: <20250824135521.590780-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: c98e9d3f-5fc3-4f7d-f6e8-08dde315e709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IYTWBsf3MAdjaUfDdTQfKwxqtvvKRAtJWg9sogClf+x2Bp02v0tWqvd+Vs7Y?=
 =?us-ascii?Q?Yyo856AJCHPN2cMlb6a8y0NNLUEuLRfGGaL0/Yp5cX/d1JXRoCW2rj/sLvQS?=
 =?us-ascii?Q?IlClRZkxa6BphH0GLsteoarG+ZPPbULEatnD+oyDUClENsKCcrXx4Fz0eLtE?=
 =?us-ascii?Q?tD3GNiUTM3lusO31nbECbBw88eMmTmDRDjzRHLhI1YTh0//o6uiarKmlw7FP?=
 =?us-ascii?Q?cK/uy1jFs/pag440tnSX5nhNJd0uMNLGfuiY6TO9xZRz1v9oaO/2FNL3kcmK?=
 =?us-ascii?Q?h/7WY3Lm7MnbOIV49bL/3YTxyfS2h7g3abHED/PlrGxIqorfaaCiDP44XhCl?=
 =?us-ascii?Q?LlNyA6RH9QO/fbTk95OLdqN/+xM2ruXhsHTcIe+pK56Khz8TqSW00mKZbf2Y?=
 =?us-ascii?Q?BwjyLxXRA+GFIOnkOczaO8B/BceB4zjTUOHy9nZn8NQP/AVOHexC39LYMOq6?=
 =?us-ascii?Q?GraA9GUT3dOMqOODlThgxt4LHmp2Orn+oQGU2GeQHcC1kVjLtXqUFzqzv8cz?=
 =?us-ascii?Q?Aw1aV7NPfv6C1viPAG/0FC2QaQ+YplhzV4wRJuKCdLEF3T/JultII33Tqdse?=
 =?us-ascii?Q?D3x30Ztkz47f7nh5HSFDCRlxl9tdg2faXEsELMs9ODKVekYKhm62mp3BcfZZ?=
 =?us-ascii?Q?pAOFNSmoQHkUAhnFGhBK50Vzl5aDWtqzAbF6nBI2yICGjMq+5k09KmmthvMX?=
 =?us-ascii?Q?6Zkki9JDpdQEIyikzEhaA+gtPRcAANYVj/ry8nj6UcC6IT56pwgwljCx7M3P?=
 =?us-ascii?Q?9a0qZXt8eeVNYQAtqhEJk1bTxhKyyAb3uKrjcEe1bvsgPrt2wKmgn51yBAle?=
 =?us-ascii?Q?W3PJ+vI3aHv0pgDpRZuYCPU2kKHzDzUBkpH2uXezcD84LXQLMRNdsrp7yG+t?=
 =?us-ascii?Q?eRRuA+76GVpYKnc5Hil9sqALZV5AtL1WBdA/PRV0a71Vn71/YRhYJ+NZQBAq?=
 =?us-ascii?Q?IJlNMg1z9RTop7u7PO1h4QIVY1eou8cq76VGoutoJHKqrgmMJHjBu58ByFYz?=
 =?us-ascii?Q?hao2CjYpEWrbEoIeZk1rG/Ev27EL2vofarj8cZIwW3FhAWqkEZxVt3n9OFKG?=
 =?us-ascii?Q?seX2eO+JNCDWng8BQhLv8L9zOoMaYcRXEbObeLDeVr8cn0T8U5yC+vkec1bb?=
 =?us-ascii?Q?fAWG1LYKl2TWAin9E9I+5h9nO5Y4otc8cht3cs6NWHiTTRCp6YpYZYmK9cmr?=
 =?us-ascii?Q?5q7J8aE9S4zBJcORYmR14AkaHCtWU++RB69MGbbVF9RNkbtGeOleQd+Lqf5c?=
 =?us-ascii?Q?Xwmf9Ju9W2u+jxhrvsQ/nRiI02Q37fxMinXGmnrL45GgF4OYHS0IF0lbSPdp?=
 =?us-ascii?Q?nPYOKEORqX+xABXHXGkqBkHxUZ4hoNBkRvkg0xFURMQgW7SASWFeHL5rDrqC?=
 =?us-ascii?Q?eXRnCdfYdp1FcBEVP4+PfNiJ5Ke1tAZghjMToHOGhjmsiLivIXZoaedUMOEz?=
 =?us-ascii?Q?/CVHt+Hr4DNM5czHgNiVbR9c3WHvLNcyL5SYSMKi1ovddxDeIasqkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iml+vw1XSytLDdyROqbU50mgfRUQMKWuNPyB/8qXRPO4E+Cf0WeBQNjUj/VN?=
 =?us-ascii?Q?1CHY6H3TBYcPrIHDc/GCoAvKuWjGAA4vb36082IF5XP+XNEZYqcap5SqFCHl?=
 =?us-ascii?Q?Z96AzruUfhWzEkCuuPMFYQYV968d0CJ59L3m5poe8Ye4VCWcRenr0wX6U7mq?=
 =?us-ascii?Q?92pCEh8WX+U8NGItEIW5YVmuII3LTeV7RsPeMzfkr3Z07QwOmzbZITwtNg10?=
 =?us-ascii?Q?eRRmLbIIjqEAAEVgu0iIGLT17nISZF4wbH72NrrF2BE0og/r1Wtg/MBWTgtP?=
 =?us-ascii?Q?yPvZBIC9Ye3x5Ua66Fnsa+zF58XTNtwFeLAsC1F/Ossnv52ig7TrW6A05OvE?=
 =?us-ascii?Q?OlvKvKN33FBwQZE55/NBf8wZGxFOEvstJWHPZ+9vioGwhgpOpyRWkTT4WiyA?=
 =?us-ascii?Q?qJZslOUhtfN55RnDtP2BJz+c5g5Gc8rGYpzV793WQp0B5ZjV1qhnMQXRV2TB?=
 =?us-ascii?Q?KJ5mjLsgl6EuqoAjqJ2ladsg0rK2mUbSLuwPOwP8ByBJ8uNGWw+3H+v/jxbC?=
 =?us-ascii?Q?4565BJwdknB2zApiMTzVA20oPVjR2GotcjaMI0+7vb6IOZMvYahFIXk9c33q?=
 =?us-ascii?Q?MyZYrsNC+snHrmTAc2nlNE0r164GY/QY2QP1JFDPzCqbv1Uq/Q3GIfTLghu8?=
 =?us-ascii?Q?9OjLHmSfe6nNSQbAPda1+PWFAdOgM0TnNKn5uFpPSk+VG6RrUmEJMwPNXWXX?=
 =?us-ascii?Q?39It794VKapF8zfE08OuokhhL9Jm9rdLFBUk6/AjQh08PgBGhgPl8E+vjc/Q?=
 =?us-ascii?Q?l7uNSrMneU5oEhXBz7w9MWXO5kMAMpB+zDHeu65KQUMODbpUNdyAwU3UODbh?=
 =?us-ascii?Q?Q2LIJagoyGZ1pkxIHWARwNBQpqB6M+8zTywGh9q6A4Y3HnnSBCYdY000oKr5?=
 =?us-ascii?Q?xLbclXIu6jh6wiMPae47krh0d/uZfp2tyB0s1y9QQCHPmdSPK0THfvaacn6l?=
 =?us-ascii?Q?V601QiraDTGt8jE4pZDHDgehXfC7rXiAsjLG2LNt2qN422+kJySUVM03sirh?=
 =?us-ascii?Q?YahMVhLco52CphJV9TK7CKkpS4+0tlLTQCDGBNj6doU8ntaJiMTNv6KuwwD7?=
 =?us-ascii?Q?IFY1xR0qIuPZkaE6+KuifFCgMS/zGLIq64HBTGUz6K+ISUhKOXap5T0Js1/7?=
 =?us-ascii?Q?8dDwCJ28s86kgrXwKtaUZbIaGZOCtAlFZ0IfNF4QtsTsCOcri0pQ8/fFJDCg?=
 =?us-ascii?Q?qJeVWeVsFPWJN6yxAAgGQtnH5c/d+5vkSCFLcr4X5bRq/LITsWY6mjoQX0uc?=
 =?us-ascii?Q?Eg69b8u1/FancF5NuS4tO5ITHv4ZN+OTGH++ERLYFaaeSRlyy4LaOC2Ndno8?=
 =?us-ascii?Q?6ZqpNSid7DNm1oEJqI1iztL3qOx6ILCi7Gl3MO6cEzFD6hQKMpjExBXUcrRe?=
 =?us-ascii?Q?hGjXDKW4re1Qbh/t3Q6SmqIjrbEbUyBJsI1neD1aLNA2CKDo93CH0IHCz7aK?=
 =?us-ascii?Q?SBmEo3bvK0uYFTeRZIjr0wRqLCpEGi7fXs9rgcYAKAtsJ5ZTXvTLQnqR+LTx?=
 =?us-ascii?Q?QtQ1uecV8IJ0PnNz2yCRR9OWydvsjZhoDgFtRky9UFNO5ErQnpb2Hz7JxFDU?=
 =?us-ascii?Q?nPQCTem+nsWY8ARN8G+xkhnIH9TzvIPkfGUPK7Xp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98e9d3f-5fc3-4f7d-f6e8-08dde315e709
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 13:55:36.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHAvYzCnTuhV9P1eikrNC9KBct5As7NmNDZh4i4aYjc7SJbXH3slpRRYwOejdphDS04DC7kcm4bfnEHcUkD4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5685

Remove array_size() calls and replace vmalloc() with vmalloc_array() in
cs46xx_dsp_spos_create() to simplify the code and maintain consistency
with existing kmalloc_array() usage.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 sound/pci/cs46xx/dsp_spos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index e07f85322f1c..0aa68f9dd2aa 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -228,8 +228,8 @@ struct dsp_spos_instance *cs46xx_dsp_spos_create (struct snd_cs46xx * chip)
 
 	/* better to use vmalloc for this big table */
 	ins->symbol_table.symbols =
-		vmalloc(array_size(DSP_MAX_SYMBOLS,
-				   sizeof(struct dsp_symbol_entry)));
+		vmalloc_array(DSP_MAX_SYMBOLS,
+			      sizeof(struct dsp_symbol_entry));
 	ins->code.data = kmalloc(DSP_CODE_BYTE_SIZE, GFP_KERNEL);
 	ins->modules = kmalloc_array(DSP_MAX_MODULES,
 				     sizeof(struct dsp_module_desc),
-- 
2.34.1


