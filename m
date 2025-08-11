Return-Path: <linux-kernel+bounces-761910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420ECB1FFDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CC21881CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45529C32F;
	Mon, 11 Aug 2025 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XcqEMlII"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0891DC9A3;
	Mon, 11 Aug 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895872; cv=fail; b=L47bLTyfYIPXqjP7V3KUdPQ7IW4tmdHMM2z+8iUTtG9/u9/PRrCTIaCvTUMEMc0HDSJchVDfh2aosC6knNWfCIRKEF/2B9o+/MKFpwm1tU2B6VowW4Gp3RP6ERoOqw8UF9crs67rLCFwOOSNT588givUVdBCBTi6iNUs/QoGUfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895872; c=relaxed/simple;
	bh=P1j5bakPnaBZXJo9cD6QJCxhrK7IYj8x+Ghl6CcHNpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=plWquTUvw0SfNAXAaKLW7sWFAtlxIZXXDocJavqS4zpbs0xQL9OvFCIVd8sVa3lnJU2R/m15wiL5V/BFzs30A/IRexWXbi9ai+YvzRvJkI1HxHrCjZCuvzW3X+sHj8pKpuxbOFJO9NX+qwu3zXCVSnBMqZxtJPs8//nm0UPRKcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XcqEMlII; arc=fail smtp.client-ip=52.101.126.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNhoudO6N5KqigmAt/eSqAP/OL+gdXPy978i+XH/x+MhOLbwweILEpupyqfMtgKf2etKlWSN9c2WO85Ba/AXYtwgcPkZ765grXohh6kJg+9ZrkO+3/thj8lEW9d5dLO4uLErW2CcjTmgKZPc4u8Ho/Ek5llSO72TOxvVPTQ5Lcm9DW0i6eFSSNd+PSPb9yL2tmaVFc7JlEN1h6ZeeL81Oryu/hOSviW1IG/spkIwjxc77oGmAra9ufb3EyrTuZ0mhZdIfPBVn2HGDnUfdniB/z8z5n+LqOHm31sNGK40NmQ6PCLOFffYOGuMuP0+ER1BWhe7MXi6Hxbqlq+cRp5SnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkRdYX8E7i8jy42C0ohkTU8Qqz0XTv41NQegs8d+iHc=;
 b=BtGSoqllfifdMOlW+zHbO2rvxPjU6rAuor+xkzBRz2Ax1IFqkmJp+BqGqhJiBG1kcR9M0huwXa/VNGx0NkIBMTGa7/xyhdZ75bZWAo6OvS2QRB9FBfMiqhKAX/re14yFHSNED0l8JtgBEIyTFJTDcZFLeU4/L2PbL4ryQkNNa5tgdZeUT4ksS1loUwljveqVMaJpd4jH5BB7C9Ys/Osu0Sj9Z1IHqtQ9tQmmASZT02nK948+4JA9v52OHkbwr8oTOLsSehmUIY7c/+9QQoqEXSC314lek/qaQ6tT6DpiOuwvqL5kEk1TIT4mC+cTk5xLEanYEY9kRBolyYNKO8wT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkRdYX8E7i8jy42C0ohkTU8Qqz0XTv41NQegs8d+iHc=;
 b=XcqEMlIIr34c7EkwT/KBZ6/dC8W90qSZs7xoiIUKdJzeg4DOju0mU649qdPkC8+aoHDvmhQXPWrLaF5La8jElWvoUc9Hx9/wKV3MYt5S3ruYYuH7+Q4Q2Glqk9EVbhrOu2Qe7hyChA+1j4Kv/jrgRil2CWqty/swm23pQte8EEDaPdLGLnAdn2NLEDgXc5+laePYdfHwI1GsFnxmbqfVDTt9DQfuu56UlDwljU1rFiWRz8YTsD7fAHqNeRAu4VTaCwmTE241tSk9JhIgh7U/5+jGGyziUhPnNcugPyaQUfeLT3ydwhyqar3zXlvn47MnpTbDTXsYcIoD9WRs2+bfKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 07:04:27 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 07:04:26 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] ASoC: fix "dependant"->"dependent"
Date: Mon, 11 Aug 2025 15:04:18 +0800
Message-Id: <20250811070418.352104-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYQPR06MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d0d68d-821a-4f93-1812-08ddd8a54f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9kBFFLb82U+1lSdlVjGlDFH0Nm+pNvckQkp1WzXHv5dS2JmsYT6je0lAyZuq?=
 =?us-ascii?Q?rTvg0vP1l3/COC7l8IrsZPwWHW3J8WpIK4yWKm1zLr0yjjZG1wQNRPnf/ypn?=
 =?us-ascii?Q?zdT4nvvAJtXSymexKTF8nE+fcFYJxJFO7AjAlOHfTAYCCfwacqUCUD++X5Kw?=
 =?us-ascii?Q?OViWbe973rJk43UNoFDiUctPJ7ZV3WsYPdJQZ9WduzFp4IlYy99aVAKY9uPt?=
 =?us-ascii?Q?3JFfwoonCXddDSbfDGRGx4/UDZFqz2a3WQ1DdZ2plFf1gMp7L56JoYIZ8Hbc?=
 =?us-ascii?Q?4GaWPn+5JUt5eE+kxVvP7WKaMzE/5jHrL1aWxLJdHs7PZ55LIT5luk4u0uOr?=
 =?us-ascii?Q?42P1fOcRBPYtmASvvB9Hw03JbrsWSgRYQ6xd289snWXou0GAb+fE32YBTr1g?=
 =?us-ascii?Q?KbLZjtNrQwTDmFGTeRFCxrZc07yWXMMsSqRm5kDcvwXivX6cLhF+KLNvcv3F?=
 =?us-ascii?Q?+vu7NhzG35wIKOYvv+leIJ4fAgTlopp/wu7EhjUpvHsPvye8sNsSXvfztXh3?=
 =?us-ascii?Q?5HCUO1WeMybxInbqEimyXgNA0iclo92bHF4Hvz7yod5lOVFhI5sZkendEP6v?=
 =?us-ascii?Q?ti4b6ToPnjUV/VdmqXnQwUblbF3Hdq6eLqyfpHDeD6ZqNEmIoYQYIvb5UJcz?=
 =?us-ascii?Q?VxzIfjz8+4r8p/7dZ95KTk499UEsm1+3ckjpSdwhqqn8+0+m6/CK/KS0/GHZ?=
 =?us-ascii?Q?CLqOmqBS79ZWigX5WHeXMgWq7bTsu3GC9tRKZR6rhld7E0k5nU6al9vUzrvC?=
 =?us-ascii?Q?oo7kavRHCUDMsqw079D0ws4fLN88oWY5YOg5M2G9+NQCAw7YVdLK1gOIhQr8?=
 =?us-ascii?Q?geACRlDsVnklQ/o05cD4exOb4HyW9jJAt41fQnkb8zgH9pQbChlQJeQYGjOM?=
 =?us-ascii?Q?/5SlyzNUlnmVvOY5Eu/QUjD3hBTAC99GwDTtCMb6ZJI3DyQZhJCK3APKPOJT?=
 =?us-ascii?Q?7CGgXN7l+Vlkfn1xbQq3nAoBvzk/PcSW6uiTeMi1WEv4hfxLKc7WDlKLts5v?=
 =?us-ascii?Q?Bo4Zvt+ONS10/0CPPExbJGgG62uNLC5BY/w3USMwwXLuXAj31svS7/PyMK9E?=
 =?us-ascii?Q?8qpL0rXO/jLu8T4klcKgG/klqIr0TDZAo30/xtWf/G2IV1pqi5NbqJWE+Qrt?=
 =?us-ascii?Q?C+CC5WGaJQOKnCzidNtFOG/r/LwjSRfK6xct2Ig72zSsoYNpVj+m6mttkBrN?=
 =?us-ascii?Q?Ok14wxmOpeLpdNqWFxqyQ5iZM3njLLhk8QPiwMGk2TGbFUokg+Rp1ULXFp5p?=
 =?us-ascii?Q?Wk0LbxcyWHUGxtcC7vWWRd2pjBsASruLnDW7JImAyC44Yo4Bk4uad+L7LGkv?=
 =?us-ascii?Q?eMs9WgPwHjtIBRD9S1J/gUpUZOtQ5uC6gc9wmM9kjmWR8CPM4XRVGwmRcKIK?=
 =?us-ascii?Q?p7wqe0OCBrA1pAa8jRtvCLMFx0bKnDUAuGPwG5nQkXZ4z0dXzN2k2MUatByn?=
 =?us-ascii?Q?EQt77FwoaGOXmjpn3bZwNWGi1/nnkW1rUgxBcHoRatWwp9c/LkZA1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HIZ4Y8YyYqNrfqLPjbQl2/T80BUZ+J027VKNDgzNYzcwvcvf5aEcPZYAQdnn?=
 =?us-ascii?Q?SIVopWNQElLhZD6hLskPvdl+2j8E0WreTLaRwpGr71sdMN3qf83SOGzdIAd0?=
 =?us-ascii?Q?Gz24L+OxcdHxpc5s56W30PkADWAC4g6gkTkYWfgqZu1Q+2Lnt4GWlXQKa9mu?=
 =?us-ascii?Q?ZnLdGplqBzdLk6fH3nATEmrhnRRBfP7f+aYcjFRda9iJRrFUSNdRuNlvWdm0?=
 =?us-ascii?Q?YyCJEkAdAocQapXsjMwlFKSfl0gcRq7mkjSrwmgyfvOq67ftd6tBRKtT0P5p?=
 =?us-ascii?Q?ZXeW/1dJ1rqnC0G1EnJemhXZ44erZYg4fU5oNPOpUu0oNqmZSo01DxEvXn+Z?=
 =?us-ascii?Q?xLzX69QUi/ErXRZAE0FiZvitmcyyq0U1IYpLHlcVUpgYCqf3Yu/MYu+EEwHx?=
 =?us-ascii?Q?RMhDZm+3pA/67BW1CNYZ6RsjoTryRZfbi5xd41ApxeooiLQK/xnz35B8fe8J?=
 =?us-ascii?Q?7oZGkFCdqAmBYss3/KZy6rFD2UaGIlITkJhlplidIgc/JGaROKA9T0dxeBQz?=
 =?us-ascii?Q?AxDVJqOFUqocNzde8k34wDQN3S5Sjp/R3mHO8E/QCFVe8RCZxoyEJcHtRuz9?=
 =?us-ascii?Q?HxFlBRIxQlYwFwS2sqx1K+LiWGov2c7AdunpadGzG5K95lvbZWXf8U8aCu4s?=
 =?us-ascii?Q?GYP+x98zGeVFhhDFUsUk4AmVoQAry1yLWNl0KXOFcJXvk+ACy1GpN1iQ7PSK?=
 =?us-ascii?Q?KxIwQb3LLDSfC4gbpr8mqTe5+PQaGKQ6LMdTSbb3b3dpyCbq978Viq2XBkDQ?=
 =?us-ascii?Q?jRHT/NwBmsp9pSdnGXZ3pZRx07d1pdqlsbCcqt9MBlFQueB7KgqWfMlhpmr4?=
 =?us-ascii?Q?pn+FAzlzNYjU+EnKzU7ALyL7WbUZ1EepqNLVLJySYpJrGBq2/3HxT82dzybw?=
 =?us-ascii?Q?PVvA++FvQM/mnt4B1mqzsHXFawjkwh/5hFTnm6Fo/P6bn4Ilhbx5CMZYMq/q?=
 =?us-ascii?Q?Rw28iPjZd7wEjGL6qq5p9ddXSjOJmgOUUNDawBG8wpDBXIAwF/yKq+fsc/il?=
 =?us-ascii?Q?gjt6NgZjlNdQdGMy3zMsDoGLak9nUBLJXtbGW7lV2AjUzpe6I5diD7EmJhHV?=
 =?us-ascii?Q?JlAqPhp1gFqT6DlyX76qWLd0+GaCeQ8TipCbaJ01bTBH4iRnBjPsj2tca9rK?=
 =?us-ascii?Q?DKrb6gQbcXwOAKvcjZ2RPpCl4+ngGrFQfwMt1CxwC2O9uvHcTwE56gSLwZsc?=
 =?us-ascii?Q?7rsye3LttGEHQc9nzSqSZzNEZw3s0wS2bhePa8FMMbtVGz0wuyXjRajTj1tt?=
 =?us-ascii?Q?uBPjnfdKGCzkufrK5r3Nb/9VlqrTlF9VqTDEvNXwS6C5xG8FCJFNQLTDlVn3?=
 =?us-ascii?Q?lG7Ttk+ZttCNMKtSXNzpzwoiwRgkFNqz8QtCB8dCAxv8j/SkZY/zd3zlLbLl?=
 =?us-ascii?Q?4n1ALYtxoALNjDX1yS/PQhOuOUPq1PRqKCF4J0W+thAb3f068AI9bcjIsMJI?=
 =?us-ascii?Q?K1UBxQQPv60YeEjXSuQY/ddoHVTszxMOjwfqohjWxzOmuAEg7XIVTwjzti9p?=
 =?us-ascii?Q?+tN4VA+qyKGADSEo+NwlNBpWywXiT44rDtgtcfFP0+XPBPc4ZhV/bQrYdAi5?=
 =?us-ascii?Q?GCLJVJJnaXBVgKJRsYhLKdK1kNjMfsTJH/rD1EA7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d0d68d-821a-4f93-1812-08ddd8a54f2d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 07:04:26.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IQI7JCs9AWvfzN64WqXLMF2PE34DJ7D2Fb5tBnXILQwiS4Y95bsIeuxDhd/uVtX1P8jgSlhB0a3KcOpSp3loQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 sound/soc/codecs/wm8994.h | 12 ++++++------
 sound/soc/codecs/wm8996.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index bc584b17bf28..b28398aa9e48 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -106,33 +106,33 @@ struct wm8994_priv {
 	int vss_ena[3];
 	int enh_eq_ena[3];
 
-	/* Platform dependant DRC configuration */
+	/* Platform dependent DRC configuration */
 	const char **drc_texts;
 	int drc_cfg[WM8994_NUM_DRC];
 	struct soc_enum drc_enum;
 
-	/* Platform dependant ReTune mobile configuration */
+	/* Platform dependent ReTune mobile configuration */
 	int num_retune_mobile_texts;
 	const char **retune_mobile_texts;
 	int retune_mobile_cfg[WM8994_NUM_EQ];
 	struct soc_enum retune_mobile_enum;
 
-	/* Platform dependant MBC configuration */
+	/* Platform dependent MBC configuration */
 	int mbc_cfg;
 	const char **mbc_texts;
 	struct soc_enum mbc_enum;
 
-	/* Platform dependant VSS configuration */
+	/* Platform dependent VSS configuration */
 	int vss_cfg;
 	const char **vss_texts;
 	struct soc_enum vss_enum;
 
-	/* Platform dependant VSS HPF configuration */
+	/* Platform dependent VSS HPF configuration */
 	int vss_hpf_cfg;
 	const char **vss_hpf_texts;
 	struct soc_enum vss_hpf_enum;
 
-	/* Platform dependant enhanced EQ configuration */
+	/* Platform dependent enhanced EQ configuration */
 	int enh_eq_cfg;
 	const char **enh_eq_texts;
 	struct soc_enum enh_eq_enum;
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index e364d0da9044..437e00846777 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -77,7 +77,7 @@ struct wm8996_priv {
 	int rx_rate[WM8996_AIFS];
 	int bclk_rate[WM8996_AIFS];
 
-	/* Platform dependant ReTune mobile configuration */
+	/* Platform dependent ReTune mobile configuration */
 	int num_retune_mobile_texts;
 	const char **retune_mobile_texts;
 	int retune_mobile_cfg[2];
-- 
2.34.1


