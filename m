Return-Path: <linux-kernel+bounces-789471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6EB39600
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DD93BBB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E682D7D59;
	Thu, 28 Aug 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qj+usrFO"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012048.outbound.protection.outlook.com [52.101.126.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9472D73A7;
	Thu, 28 Aug 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367675; cv=fail; b=CKxAYsAj2a8noIeTGu6wxuCJHecmqZKtW2HdmRPP6PBuT0LU1VBl23xlf/mxWhKcAO7RMm8kCQ+faggynQirQ8z6voMVgifjfT9k0UQrO5UF2tmM19CNMQJ+nmkVq8IlHegxyrO2Ty5CZYtf5jr94YtdWSWouO0hSVZqGOXGxaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367675; c=relaxed/simple;
	bh=ewC5Es/7muztZJ7dtHgugSUzuPkJkir92wv48mvyn54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OewNIENg6VOV2gH18f243kCEABz+A9Fvw7ZVmVeZaWlpCM0IN9zJBNhDYEVvVztyMkRQJOV3fXDNOpyj9xue+1KxX1IZ+yLqgnsbovzoCWTAREY8Zmi5KZ1uvGJrqiXyWukpqbHaJlo0KlK/e6UIheoMdBPfpq9OzYyjq7dZ0FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qj+usrFO; arc=fail smtp.client-ip=52.101.126.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh28s7cWHjuBZUyva/fZCEHRDpqOJO0atpgZkJzboZr7R9jaBQKE+Ry5JQPjFmYXlD53H74FIYQJhUBgX9Mzsl7M4EMJveHTlrqWywXRESYkw3gjiGm7fGOZ26OU1eOtivrxH0Fshj4TkVhStjOUHNSaABuvdzK/ITToEQTGzHuMpTIgUzHBhCggm622PxyH2xwxLhG20nmZRyZ3TVZlBoH8bsrY2hkqMAg6ynw2aQOYVSiUuPh1LGVlR3lNBaQFVaUhSMpI6iJeyIntfHEf1rCyslevkU7JFIvvXgUvLN3I61BznwGgek0wG6nXa59jjcwJLPOIVg6QrQ8yiJXxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBjY9hzMQs0asCXjfKcALrhLv/t/UyJLsTBDWAFjUS0=;
 b=ADTdJy+xSJXy2ph3DhNVhFyx61EnYGE6y/NYFdtvZx9I3jelo2Cjme4CL2l6uskAl89FESBc9evFAHPtojh6d/NrWCyPNrq8VvNOrFCn/lntSjW38PWoq8ZGRCqcIAzL/y9wm35cb2nazspZqZo5ufphL+RSReM1eb+ijkf5TxAo+0NrhMomNV4K1a0AX6QtMhjBOWbOr8xSsGjdN6PLKyt6b/X+faIOYAv2nwhtw3LqToeKMypUy1i42Vd846362R3n+mSdNNgZ9NNe6OOGdMZZiZwueLyn0GQiHRIW21yCRHXvLDqt3Zeyh/Frv9rbDG5QUviOm5/IPkbx/cPHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBjY9hzMQs0asCXjfKcALrhLv/t/UyJLsTBDWAFjUS0=;
 b=qj+usrFOs7fM7Hx/QKA2W9vbmQ+CKB+FTDJ22UENVL5lqJMaxEuB3GBXXdROwI62lvRagCgYbeFJovks7jrop4JaV5z1d1HOz5kD49CXNmGOoqxGavcR105XAWwSnUluJrQ9XIcceGl9YSQ+BAW94bDW3sXJYifHxbhdPyPy0CuPsgcD6ibXK2xcfF+sAKt+43aENgeZY8k92PGHu2bofNwX2w6MT38qDVbIOP8SuNEoYczLZuIEetMPt2eVjKzXOyd2hXAKItUrfZCBfkpNDwwS9Po7UScusa069Lx05WUF0mQKZI6bhRbA6NjpN9i0f5bkghxUz2VKdDNnRAFtZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB7035.apcprd06.prod.outlook.com (2603:1096:820:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 07:54:31 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 07:54:31 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org (open list:ANALOG DEVICES INC ASOC CODEC DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 2/3] ASoC: adau1977: use int type to store negative error codes
Date: Thu, 28 Aug 2025 15:53:58 +0800
Message-Id: <20250828075406.386208-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828075406.386208-1-rongqianfeng@vivo.com>
References: <20250828075406.386208-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::13) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 5252cbca-c0cf-4e49-8dd4-08dde6081ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+YRFWJJZyO/2Q4Iw+QzfzSlbHMA4m2rvXb7eIkUr9whRwW4GYfe8FhdpOXR3?=
 =?us-ascii?Q?2x06+huTKlCdGRSfkj0BVUSptrcmV32+o/w8nEIPMRHQdI2gpWApSdERzlRE?=
 =?us-ascii?Q?9wwzAHsGNqFQUfGtszlR9Ib231aIlGI+S0+je1nQjdeSIva1hJ2PUrLR3AjO?=
 =?us-ascii?Q?CNg8jDcjsNGnDT+WitM3k0FEu6kXUbWgzVDmvIbstRZxkS1zQHwgyzW+RCgR?=
 =?us-ascii?Q?a7lbCkhBfBDNN0m3srXz60Un+K+oZnXd8z/r0UmuHkxhn2O0Wto3UFy4Jo1X?=
 =?us-ascii?Q?GVqPnXIGXcb7tKXfM+PbsrXTSLDAZ6B20lrpT0tL2sxo7aOCmCNjQ/s/AaYC?=
 =?us-ascii?Q?2bVuFUlTa4ZgV4X3tPRsbTUtvl8q3Dhm+a/os6auwLDfIVO7T3KV8+wAISca?=
 =?us-ascii?Q?7rFqSy8kGsCc62JA+YvmKwcGGawKE9iaTeociCcYjU4vKL2C0w+V/0eLOT/S?=
 =?us-ascii?Q?UIblTkysna314Yo1pjoMNQbgx0m5bR8fOVaOU2/yMLYwA1xQ5OXxho6jrxQu?=
 =?us-ascii?Q?nZnlgt1SS1Sfcvgs48EC2Q7HMCU2P66/LZ1JFeodjHlh1a45MYvTKkbIG69t?=
 =?us-ascii?Q?o2F9sRlNhWKX7yek7krlnLDlDbr2aThNgO5EZ7PnW3iI+QjlN0DNPUw+mC/e?=
 =?us-ascii?Q?weUMEYvS5UoCe3QpCyuOBxZ+6m2byk/XEKniKZ1/hwmx7IQwMtFPp/wlBfDd?=
 =?us-ascii?Q?jvuAZmgtsyQo5lc18Kf3cYDsCB16m1hIcxehfVaDlI/EDEtcuAE8JFbUG1v3?=
 =?us-ascii?Q?P9piT7jzEozR2Yp0z25VYI9WZJDjpjE3YE5SMeh9djDRALB6ysJYZvvmMZ1f?=
 =?us-ascii?Q?1ECWo9NyvEJCUnl9fcO9UZACxha4mIdZRXcPY+rFtPRu0izH3gUrtY4eIkOC?=
 =?us-ascii?Q?Tf4bXGv8t1qIczb72aSaSiYgA3sS2gdDiUysK8lgHtM0Uk9RGOx3fRQ9xNIx?=
 =?us-ascii?Q?VnSAYM+LAbF/4yiMqFizIr1MkqgIYTVrX21Nmuv1D05QQaKb2z5fzNHdyflg?=
 =?us-ascii?Q?McUA75KZVV4Mccl/rUJWQJ7lIgaPTjvK5UlJ/NAeK3a1COGvedDTfkiG6p+2?=
 =?us-ascii?Q?qP8jAEAiroFrNkTHHJtKs46bufmXOBx3RJTMXacb8ErzUUeMNgv38vPBLo3d?=
 =?us-ascii?Q?DA1ST3HY+oy/v7KT2OsVSJIHZWppVvzwyhHdZeb/yR7idPyMdOLYCCEJ0MZh?=
 =?us-ascii?Q?8VWIVPubZeIIfnvYP8QjVp2ACvB9ULwJ/ts5Vk7D6qMqg5RHIUIzs1msCjjG?=
 =?us-ascii?Q?So2vM8E3tCmg6OAb19+Qn1euAsuHQxfKM8Es9t4lwofNNq3nscnC6f5EzCDa?=
 =?us-ascii?Q?moTv+H6JA5YrLRUqdn/Gd0CXPX7uBluMo3z916HF6PMxGoaOeY9mu97xPihe?=
 =?us-ascii?Q?8VbdOqpuuT46HtbAC87QZwQrwaPdJdO6yyge6KBJvSdcyPdJ0w05car4A2Z8?=
 =?us-ascii?Q?WwbNaHIg2QhdCeKqyLX11mD7ggnBdYoUnbF/4qHj0F7bxcrWXI1ukw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZpLiuW00f0kNm7wF3j80B/QUdWZ9PGqyQBaWR8K9t5oluIuJvVf/bIGg0EXJ?=
 =?us-ascii?Q?iPrhb77u0RcjFuY6ya3qnYuaf43g3dtuhEtrDDcw9+2qq9KQt/YNJK21+Xkl?=
 =?us-ascii?Q?Ag42qni/7oqZ2paE+hT/dMQqqlg+3lfb9nmODfMucjhk/8qD3WJmcGe+8Zo8?=
 =?us-ascii?Q?WExlt4hfWKevbWVwzD1FeX3ATvDzHK3lYYiuyCCVn1aL1nDuO8XNVjLXm26e?=
 =?us-ascii?Q?F7pjwwTHi0s9a0GtJeFz2rdDru9NrdbhzCy+3hvbULmWckSBpOLNulleYgWA?=
 =?us-ascii?Q?UaWctG9p/thjZyXd42AI6qDom2EiIqg68WKywKV+05BvGRfaiSVRJXJmb32d?=
 =?us-ascii?Q?wb9mttfhDzLYL45KLnLbMLwf8N0UiHtBnmeDPZckfSHwB1biIMnnBZRHnys4?=
 =?us-ascii?Q?8UF0a/Yx5Y3o93/UEqeyB3qcDpHEn4cu7zozm6x2aErf0jE9p5kDgZuMneoB?=
 =?us-ascii?Q?rsothz5L6vfF6ADbYwmPVd1ZqYr4odQqv0KE6bFTbhPgzP6+I112y46p0AB3?=
 =?us-ascii?Q?LFJUV0sPpsm4p2Eh4QczZLE2RDdBT6nP5ugc/KUpNB8VYIRf7xB9WtBqPP8T?=
 =?us-ascii?Q?l2YEm2TjqBg6EF4PSBPCtTX1UwEKOZnJt3Dt02wdHj0qe+xTz9bJhbaZgfJY?=
 =?us-ascii?Q?BBh4JsoXrdcLzQ24Ia8aCHi85++l4j9Rz47kAknteijfKswkhcdK7PqsExsB?=
 =?us-ascii?Q?kZRWh4jOZjoirwRyqx4ToxnwEmO9olZIuRLZ0mXpIABW88qPQnQruImyYvOn?=
 =?us-ascii?Q?AtZWqf/EW0kokQLsoOLaUFgO3gUoxcHaiABcBeb4AnI0fbJbLbbvwZXYdv3D?=
 =?us-ascii?Q?hLA3xsY79+r26TBNViPi/+zsgyQnjD+E9hM+iEGMjZPRjSw+xC+fk40aUUzB?=
 =?us-ascii?Q?3aKU8SLVzmqzcHybSdhM2+ozASvZqawyC/C/c8oRjMfc1dVYBTCoXkFdxFpQ?=
 =?us-ascii?Q?7orBy/o6hf7riH7mr2FNmDk/JhZRWPrg6qXI9YFRfYQChUiLQgk5I37+1JhL?=
 =?us-ascii?Q?7yuKPp3ARRd3zxbiBMEGFQPJom09CoOqkAWsMhjM2BsJrDPH7uHHSUcHMS69?=
 =?us-ascii?Q?ZsXKF8T3OSimeHmoD1EBJWGjIe2+NerhdqyTQYVRzdJyYmAtz6Quz2rc2A+K?=
 =?us-ascii?Q?GUqGroBdI6s2M2ZKF9VpKqr2jDtVJulkp5/2O4XawBimh2HWib5ZA99IN8SZ?=
 =?us-ascii?Q?2jWFRPdEYkHsve2pe074sTQV5nhE0OITX1pb2+DnndSAioR79/BopScylq6K?=
 =?us-ascii?Q?zsapkUvEuOrFHKlbZxIyzhkKc1dKPWkVbX1RM3AGlfmaKtd+kD7j1tluvEdO?=
 =?us-ascii?Q?W720PtM3zLM+XQrBBytOzG8LweoruMNRpXMz58ee+zhe7SRZuVqcmdgRErM+?=
 =?us-ascii?Q?Ao98DgqX8Dx2xQK8KAYnsz8emu1o32d4B5e7j1xc/ntzC7+oCGjelKabdVAP?=
 =?us-ascii?Q?568y/rdpxqq7x/7JY/ijFmwxRirN9+K3PW/sv9n+G1Wn9lOh6WwyqRcBJ8gR?=
 =?us-ascii?Q?X/kBiSibjrLeiRa1fndxrrSXbgnYlgouA0ckp0JOxZUsfTNUJ8QbbonG+UQi?=
 =?us-ascii?Q?Rfoy3kpDINlYUBYDG1JJzMgmlreTEEHBmwX+TtXJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5252cbca-c0cf-4e49-8dd4-08dde6081ee1
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 07:54:31.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCxVyoRk2pRX+bJaPod0Dm1ThNGbVnVUkQXFjAt8y6mMoE8WxLJqbavzvc/RhRM+ofe3bL26trl34iKuHcjIyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7035

Change the 'ret' variable from unsigned int to int to store negative error
codes or zero returned by regmap_update_bits().

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly as pants. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 sound/soc/codecs/adau1977.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index ae59efb38f26..c193a9f22f59 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -795,7 +795,7 @@ static int adau1977_set_sysclk(struct snd_soc_component *component,
 	struct adau1977 *adau1977 = snd_soc_component_get_drvdata(component);
 	unsigned int mask = 0;
 	unsigned int clk_src;
-	unsigned int ret;
+	int ret;
 
 	if (dir != SND_SOC_CLOCK_IN)
 		return -EINVAL;
-- 
2.34.1


