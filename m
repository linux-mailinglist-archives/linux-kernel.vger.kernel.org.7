Return-Path: <linux-kernel+bounces-772397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B7AB2922B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DFE1B25A11
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E1617BB21;
	Sun, 17 Aug 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QpfOf86/"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012005.outbound.protection.outlook.com [40.107.75.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199F24468B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755418374; cv=fail; b=fNMzCsGpA/qgrTyES/WiCC4qhhltP++l6eQtMG9p4T9D34bESW7Ui/Q4TzHt61RySghfOAWosHZjJgnSG/q30xFu3iu/C5P0NsdcQT2Qk6MlE+eEqc+UGGpZadWXVCmNYrNsMo44Bzg/qRqa4YUhfIbIDj9k2X0uOMpnM/tIGT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755418374; c=relaxed/simple;
	bh=iiF1O9Bqjl1GXn/5Pmz0lU8mzd+m0MbPWaafBgR/tpc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZppuQhQQ2qbP0nAvzr1/ntXoB1tAJU/ReKrol3lHoM75473+xGB9joLJAer0Rqg8xSsrnwGKeleJ7Zn85gukB9wZKVe/dAwYyHEyEdcLMdFsIWaf69H17U41/807BxtSuCs4eTFQKxjkHl7/5QdAqyn0uWbHAyEcnDzxXqpSNME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QpfOf86/; arc=fail smtp.client-ip=40.107.75.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQuCIdR98ZAe5kunmhoAyDBDfd6KtC/dl7iT3Jqh2LlVz/7LRHP9mYf0333IgZd5mHJhks6e+hJ0AoZot1ilIJHLV+7gYnVnTdg7lfTb5s+9hK0GcWtNkUBSlk/hsvbBNJDb5+VYDAz0Y7ZGBJhEiGEJ4UthWNFAhjxwTNl608HlWRv7m1SOI81eYz7nISjO7r2Z//ReGfRIpz+a+nnOsf3FxBV0nYlmAG2jDZ11dInYdIsj2y1M19+uDe2BKfu7+GWsZUMJy84h2zDoRT9aDEowcncX66FTgTlwZKKuzje3bNmZ4yea1EfKS/BQac8b8kM8Jt3s4qLANKxKJSoIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS2TvaxBzuntOREVMp3tCC6M4B2m/ntrTAJqUDmQg/I=;
 b=JQDMl9fwjD/fBLLEKA6ZMpa8GIDgxqFkx9Qv2jRfDby3TPPCyGgGkG3TudlX9A9/VEeHELDXcJ+ACtPOSom5LJKrOVLnc6Gre2/aNYYzjOsZKz20rdO/FNNyvAP/7fEtzPA+0qroTAWvmy1Wr2ho0y/uZWOWNdoJPvigGzHLTWvocitEIoLTg05tiPhuJhv3WlCgLryFB1jR2MEhcvyP1RCPO7F4ilzlu6rBFV5UDbA72gVWrWlSP0TsQqjWTVfCllM9dwIAm+v/yDFPMW0lLmUBxSqWWpLPB8Ip6E3lTm00T4Vvl7ESPQLb/762kfDrPkCNqKcezVW2LDlul9dI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS2TvaxBzuntOREVMp3tCC6M4B2m/ntrTAJqUDmQg/I=;
 b=QpfOf86/P2iao7fWDLBK+M8GqNaPIwyUezm4xTyj20vRFUM0XfsgSkwiAUTwW+7fB4oxAuiFcWGR6S7gGPi5moJeYQOXxhBAfSWY4XV4zpN8DvtBXJKRe5QvrQjSnDpb7jLvSn0Hn4aGHNr9AR+W0WEqVX77jMessRIaI2okm87EezRdDzkvpTuFP6Sxv1keH3mSy4RZc655gRnnJqgU3+C7IVmOS7gETR/6L5ovgJDh7HV32q71FtLKvy4RIzcYqZLembxcE9kvM1D3BsOdZv7E1mL61nvWuhX+jccYs9fSkoHGYvVfqhDEbmOQDpQgRvcm+WVSVIRZ1uE5UUexsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB7261.apcprd06.prod.outlook.com (2603:1096:101:226::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sun, 17 Aug
 2025 08:12:49 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 08:12:49 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] ubifs: vmalloc(array_size()) -> vmalloc_array()
Date: Sun, 17 Aug 2025 16:12:38 +0800
Message-Id: <20250817081238.44785-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0039.apcprd06.prod.outlook.com
 (2603:1096:404:2e::27) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: efb4a573-62a0-4c51-3271-08dddd65daf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YwtYyjd614qHgRfluhMhftprm/qPXAWBr3JPXksAc50v3YH078bOF/R0FL/u?=
 =?us-ascii?Q?kAv/xY6u0k2iahH4I60ifAJw8PywWwIN3Ge2WzHBu4Mf5V5tf2KE175Nzqn8?=
 =?us-ascii?Q?ffgOfO7qQySlBiwanuysO0ArGO6wvX/9d4sAQ8u/HmNnzNUqn3pekJ8MHg3U?=
 =?us-ascii?Q?ir6j0MRCobDPF8IDkTvviZUWMTgJ2hwTvpipV0x1zHdSBEIyXBdOoMgSU+aR?=
 =?us-ascii?Q?yBAIXbWOM0qiStCA/LonO0vOuuiMkqHGQSbNIZg3TDMX8WFHWzgxrTtpJCsa?=
 =?us-ascii?Q?SDZGQmTRXTNYb/s+xY3xRpICtYgb36oN050EwKP1GIzVmnvXw1Gw/iRkbBL4?=
 =?us-ascii?Q?38x5c9Vq7W5pVTYUgRyIgfi9O9KrsivMEPu8bsxoqbtwe9QzAG1crjHsTibf?=
 =?us-ascii?Q?5ajt13WOPnu4pu1db2YZkv0ihZq55KvRXXmH68p6hmjgsue3THivPMjEwLp+?=
 =?us-ascii?Q?KRa6MfXxMn2ISW44AHD9Vj1Mw0trJKwvyVoCVFFNHxHFjk4lfmDvLaEMXnG6?=
 =?us-ascii?Q?WnAxjZ6tFRXmrbuEzx0tC28sybgBf2tlkYTiHVXhv3w2zN3pLJBTsxh+iS/W?=
 =?us-ascii?Q?l6vuJAzFADP0IPe4qeMLMnU9nDrH4YMXZ9rbZRY3UI+5HWesdt9S5sAJvRY1?=
 =?us-ascii?Q?Nn9w4zIfjiI/blEpLF7ITVXE+E2UPiAZKWo2S7G2v8MImnsPUQxWbY0skAGV?=
 =?us-ascii?Q?BAWwutdKbWA7JIeOhIOxbmJS5NQWzU7ZAuK8OY6GRnnwjGBiK01+/MohGSgu?=
 =?us-ascii?Q?RHh7AX5KYrE2iS/TMpZstdXA91b9exrfK7X2i4ZQlQhic58sGjvBW1EM8W2D?=
 =?us-ascii?Q?MT1KSzxrHdu8TBHeyftKm6GsrzxdWEp2vb6wLjjFfMe9KsTjmHplx6UcYxdR?=
 =?us-ascii?Q?OE8K3jRvEEIi4za1VbXK9WSBeTvmFwsdNvYYBld9QKqv7/hpbtieQgQBthRq?=
 =?us-ascii?Q?fa3dMfb9Rj/7GTi5oxp4a9Z3LxknPk+3x76t+A6syzsnQfnTbgidyn6J3/v5?=
 =?us-ascii?Q?ryg7H3Ba2znEcKJ90WxGCkfkzZx6iJvtIp8wkcb0gUZLYGc0hJ4xyVLqMLPe?=
 =?us-ascii?Q?j0ZKVKXKFRVhPiabq8tNg5OlCP/yZeM5f670e5UBVH35wss9KpgHvtHLVyYr?=
 =?us-ascii?Q?2H6/HlU7gYXGJUuXJjcF7rHIBPqXRBNXtg8P216ZKMATrwk91qdD/rXR+0sJ?=
 =?us-ascii?Q?rgeE+DPXZvR8A1nPLr8clCgf1w6LjXNyW0vh6n8v+7cD5YGRqeYm/ATYlXRZ?=
 =?us-ascii?Q?/YeRydbhUJw/tAiu94fAY3VMEj2jdynczrN8OJd0f1VpGPfIN3Hk1MNAAXBS?=
 =?us-ascii?Q?4hZC2JRQm2+TXDO5pb+gcf8yQT4TlgKB3Vx313pUuiW4s0Z35g+xqtBhZwKP?=
 =?us-ascii?Q?pwY+dkWF7XATFJ4YztFyxQL68a7j0/VwhzC6uLkyP4Xo7aAxstx05zW4uKFK?=
 =?us-ascii?Q?a9Mn1eWfPAule7uORmMij6IGMpnvezE6JEgPZlkZ3xxn7x5Pxv7pp8iXliIx?=
 =?us-ascii?Q?WRVc6DGmTC11cco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AlvXaAyKjF8XegU9Z+r/M7ljBjikS3b4quBHVnpCnPA6C14bXfoYWjo0LsJW?=
 =?us-ascii?Q?TwTBNiNcyyv8uMILcgEXQ64aCudXXanpH9VEqhZZaDNsJ3Okl6ypG1js0rqO?=
 =?us-ascii?Q?tOdZUoZPN79VrY24ImL4pEmeo/+XZ9jR05JOmYrfFFsivqoDkv+wOkdi37jy?=
 =?us-ascii?Q?TVjvD+6nfVomvoN9DxYrTnTpPurJpSj/bmJxmRb2t6vWXGgDYf7uVbkUVisI?=
 =?us-ascii?Q?cDHKTiK6WWUiW6zSrcPzNOVxyS7Z2fPkwAnszL/nnxkpZqaU2CiI/i63E4pm?=
 =?us-ascii?Q?B/RKm++/+daLtsl28DDssBS4VDKDuoAd1sC8j66VdsgQwGlUGjPHtI7qZC59?=
 =?us-ascii?Q?2ZRFj0wLd3LZbh/1Tt8NdqBflAKZGY3sxJgRg2QTYbE4+/LhQScaNIdRnCKe?=
 =?us-ascii?Q?Yauo1ojd2DcIOIuZPNWgsjkfmBiKvIlnJ6apRF565Qr5GHV0+eNp4CGOAI3S?=
 =?us-ascii?Q?xkGJGUpuullWjLISCEvOnRgId5WYJfvNgCXvZnzIPT908tMKfdGG8GV+kjko?=
 =?us-ascii?Q?2s2GUbUt/ElVuu2sqveBpOCMXGbMy3yY+PlKzZX5eSSAesgKFYE4NmYrQuFx?=
 =?us-ascii?Q?KEEJNPZtGzjexbL8kwi83nYoiXRyjxBOYUNRNrO6Ph0iH5H0LfebqsjIlL9N?=
 =?us-ascii?Q?VRd278t376VCcHV1aBt8N/GZKCdJA6MrYjj7bDW6rldAlfbW64lLaDVjQWmR?=
 =?us-ascii?Q?luFh1OoUX7tScPEwnaT06q3ZbygAw+YR5ovbzbux0moqmlOmHNH83XGRr3O+?=
 =?us-ascii?Q?tFqsAGmPCPpJEsTvADsg/PrmbNtjixszIh9stLmCcUgTQC8oxNTXhBYslLQm?=
 =?us-ascii?Q?foQDrNqC7BMXmS5rShUVkpjehkZSRq2mQsshft+BMhGn+b2Degq362MABGAG?=
 =?us-ascii?Q?PMaQgAzbORyg5J+AZwpefQU/mmwVu4xOrZEjUu91hsN8NUNiNb4LhE9jSvGH?=
 =?us-ascii?Q?/jFslHYQMlRdV+jCv454XDDJwfQZfB8HahZ7fOyk4wYsQXnXPqtckxjAYw1R?=
 =?us-ascii?Q?W7FH5VK7k0xhjuwF21QhahEXyevFdmWMB4VBlzZ7A7sefs9LCp14sU3FtdvK?=
 =?us-ascii?Q?4SGX8b9lOezLNgOxyiI8bi6K1T5d9Tp44bPqf14o5mfZySvnSPUC/JUuHmX/?=
 =?us-ascii?Q?UU6AiMAQ17RqvtUft5yhAX90wDaA3U/hINj9Mm6i1fGy5ydrsPXCgA1PvSIF?=
 =?us-ascii?Q?MPNbKHagaK/wlC3z83/RRDejekmJQcAqPhzmG290C2dGR6fskTIpyF0KpjuB?=
 =?us-ascii?Q?uvhRC0dkLs6Lp5xvgKuWEmlt2a4jXjQYmH5LfZT8xM5XcvQ3sDwkrVmoVpze?=
 =?us-ascii?Q?AwKJwyciG4vg0Nh4xCXqwBH3Sy8p+m46perqw1UpenlnfUSIsvEhrGQn23UW?=
 =?us-ascii?Q?aCISgSh2XGZvkanp/OMZNkLjSN/0veBO8ZaQhXUGokz/MiNGPTFBGU11bdy3?=
 =?us-ascii?Q?QfhJquMF4lv4feKPAdSsj6S/0fdUNVrfv0Ow2reE+EUUzpJk9+iEDOa1rmTY?=
 =?us-ascii?Q?9chdjtZllld8tlTu5TA3zm6CkiwzCh0ssy8iQ9S5QmiQoqFUDPYiJzg7Yjyi?=
 =?us-ascii?Q?N+v4yh8f3ObXWbVQfKRVOrcUheCo77n1mJIhZQRW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb4a573-62a0-4c51-3271-08dddd65daf5
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 08:12:49.3126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXu1YxS5Qup+DRrekwOr0PAtTP4CaZPD91OQJV7uzjLRFGovEeseVZBp0C25iA0QYkLlNbQDAZyzF7S4cjYqEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7261

Remove array_size() calls and replace vmalloc() with vmalloc_array() in
ubifs_create_dflt_lpt()/lpt_init_rd()/lpt_init_wr(). vmalloc_array() is
optimized better, resulting in less instructions being used [1].

[1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 fs/ubifs/lpt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 441d0beca4cf..dde0aa3287f4 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -628,8 +628,8 @@ int ubifs_create_dflt_lpt(struct ubifs_info *c, int *main_lebs, int lpt_first,
 	pnode = kzalloc(sizeof(struct ubifs_pnode), GFP_KERNEL);
 	nnode = kzalloc(sizeof(struct ubifs_nnode), GFP_KERNEL);
 	buf = vmalloc(c->leb_size);
-	ltab = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
-				  c->lpt_lebs));
+	ltab = vmalloc_array(c->lpt_lebs,
+			     sizeof(struct ubifs_lpt_lprops));
 	if (!pnode || !nnode || !buf || !ltab || !lsave) {
 		err = -ENOMEM;
 		goto out;
@@ -1777,8 +1777,8 @@ static int lpt_init_rd(struct ubifs_info *c)
 {
 	int err, i;
 
-	c->ltab = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
-				     c->lpt_lebs));
+	c->ltab = vmalloc_array(c->lpt_lebs,
+				sizeof(struct ubifs_lpt_lprops));
 	if (!c->ltab)
 		return -ENOMEM;
 
@@ -1846,8 +1846,8 @@ static int lpt_init_wr(struct ubifs_info *c)
 {
 	int err, i;
 
-	c->ltab_cmt = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
-					 c->lpt_lebs));
+	c->ltab_cmt = vmalloc_array(c->lpt_lebs,
+				    sizeof(struct ubifs_lpt_lprops));
 	if (!c->ltab_cmt)
 		return -ENOMEM;
 
-- 
2.34.1


