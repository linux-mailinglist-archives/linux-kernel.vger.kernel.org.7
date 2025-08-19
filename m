Return-Path: <linux-kernel+bounces-774788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0FDB2B782
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC35D560C15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED132D3EEE;
	Tue, 19 Aug 2025 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lxN37YBZ"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012015.outbound.protection.outlook.com [52.101.126.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781F4A35
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574114; cv=fail; b=e0sVTqfWbNclEiZFJ3pGqph/zKCjzsBzuy02NGQRdMa3xSxOGKHtlO3IQh59Yl0ewk9gK5mb4xRK0/86Wv+0ucqqBg3YtCdvTdS8LAPHfXASIOT9RGitWP/UHuMAfJIUP+sAiLRN/sGwGJ7Utj/qc1J6pZQUm4BN1R9oe57caOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574114; c=relaxed/simple;
	bh=ClARPPuEy4wnHkK1hAJwb9fPuEPNffrRXZSCLsrLJDE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nTrixEgQmkKbuacbvu/9MpY3FSUcqfJe06LQCIi96b+K+18oYdjgZDptD/Dz8nBQ/XNszzie8qjIjplkvZQEaykS+Snx9lhPBq+59Or5zOzWezwBNxMOD7eltgaMZIQoLZDXwS7kLZunmA4n48ulhMpmGHn6C2Li4XQtZeUSRFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lxN37YBZ; arc=fail smtp.client-ip=52.101.126.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzxk2CHmWfV5HBL/ANnlWYdKYcJMAmpS/zwLhZ+eCZsceR4DsY1Zn18qbYrXmXikX/wg3bsE9PcNruWPuPLeqUX9OFltpt2LNzFkMxlWqf0qHl8I6tAo9R70pfuLT/WlgjNSE8p7s95h/gLef3S2osTc1wFFeU3OGQNSZHoJdMneFS0pLA/tMH7g13FzPA592oBDUE9ZOhI3r93ef6DpXwZaHa5xx34OYPx+CvzbSmRPUgOZCAInkZV4NgtUR1GYCfPPvecX+/6K4PqBuTfcTXsF3WABY2x2sL8e+qNLgc7jTT47qWv3lCP2xVgF7t0x4v2jBK3eNRZX8udJfTTvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7y+u/bPpQ5847fFbiHla7bdIQVhGRO5v8LAvIQ49g4=;
 b=psom7VPnNT4mNp5JjbWvyy9c6Kmmf7LWU9HUsoVs7bxisNwfpP34yMPy90KtjQxwVHxOeRfptOp+wsbw79puBOupc0bM1ZdtBKq5j09R+Nr5rbraznJglwGNTwRfA1cAqzFjO7ULH2jAhQ3qbSrXHeLCYiFta+d9tGEteWPa2R04yxDeqsb2vdEPVoorzpaAwnGVq2mAjKhAthPKlFBFhxxO7fzyZ5gIjW2iWiIRXMtVhTtPM/rD0F6ApsWgZNS0f78Mf3ruJ9U4lSCorhz8bsEubmwRKd2nYLuIp34G+GRsbsQg6CFGCa3NYp1wmlXdJ+E+ZBoZUx11Nwsmet7Rig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7y+u/bPpQ5847fFbiHla7bdIQVhGRO5v8LAvIQ49g4=;
 b=lxN37YBZ5hXSGMgsq8gW+rT2KwfwdXBbcgK4abkWAL/zoS8a3nCsP8IP2rPkwKT0DG5hlN/DBBLrQBhDKxjAe8qo8hrVqRDOO4Uny60SAn28l/ydhHOzLvNsXi6pCksol58GVTOZ81KJgQfI9Yc2YvEM8HHBRgMZCJhy4iLxDzfzbPeD9ncXxgCrEa/AaS7SbkMPBsScwlUViGtiVWueEmwApa5BQ3Bxq9mqVHHbX0DB9gw5Jh7zzYWBjbDAFLpr5S44mOZY0rJKQC9bjHbmSB2o42W++AwQN/wCyR7RDyEgtd8D75ibQG/OAIsTaxJkLLVbXVOCVgYoIYyfJJAndw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by JH0PR06MB6809.apcprd06.prod.outlook.com (2603:1096:990:4c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 03:28:29 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 03:28:29 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net (open list:JFS FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] JFS: Remove redundant 0 value initialization
Date: Tue, 19 Aug 2025 11:28:14 +0800
Message-Id: <20250819032816.426276-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|JH0PR06MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f14743b-eadd-4d89-c8bc-08ddded0771d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3URXxz2OLqPa1JdtwSCG+9UJSMHDKZtujAkl3hJ1PAjuQAq/HEDNAOO3a+B7?=
 =?us-ascii?Q?zgfb2fnn7SKPHt35uhBfeGYR4FbKmHegMmzW/tQU5pfg8/7no2i7/JzKjoo4?=
 =?us-ascii?Q?rA58iY0swrEqqYcO5qVbEIK7sOD0CTRcqcE7epJ+D94WzVe+1EKWVfc9IVl9?=
 =?us-ascii?Q?OFfGMnbsYm5h1g2uUN6LvTacgFk0NBlcXAqew4F4q2vTBpRAUq9y9wSdv/rP?=
 =?us-ascii?Q?2c9HMvweiAz40a1YoAoYB4auulGjD0THtixmqmW+7EqCAEj1DTeGdFbUcQLW?=
 =?us-ascii?Q?z0yNmgTZLGwXLQdU+Hbq8GvnXVXCN528rViV4CBkYbpaYu+7wU4tg0nJfnRA?=
 =?us-ascii?Q?KhfZuWLatGjY/zdtFjlrZdWewTfCzwDFCaxozo2WoyFSdGPEbz860vjcB/yM?=
 =?us-ascii?Q?IqRVL2hS4BZYEjZWKRn0nhwbcEYQxZWgDyAiABBuZTvsk8RJBbrWusvZd1De?=
 =?us-ascii?Q?3ID+1mslvOayI4OMrJo8vapXW8yjbRZk2btDqjwsfiYJlJSc4SEIVTkb8Byi?=
 =?us-ascii?Q?oyTLojXuE4d99bMTLXqIyYDs20QpFzMLiT9nfOwIfUTzrOrtwPErvvREASGX?=
 =?us-ascii?Q?GSu6M/ZWEo++OZPOxphnmVmxjkDgHQP/0MWVD/pO4yXGwbexwUwlmHx7Z5FC?=
 =?us-ascii?Q?kbcooUtYFdRfGaq+1nu9XBwN0sPKvtuxoept5oezI6+5wn+AEBPHwqhagidA?=
 =?us-ascii?Q?lZ1wByuEZoY2Bo7jkdZYStpTtLe0U5YWG6+MY8pmK5uVtEHQSvlnADJUmS15?=
 =?us-ascii?Q?2K+RyqJK6E8mP4SVSfZGAEmIxO3UC1Z7d5Y0x/Hyg6UGbMWlF+Nrjf0OQsE1?=
 =?us-ascii?Q?1hH0Z1URV7WSwvf7M8Hijc0v3SuUwmI4RnmRrN8I/j4GLUflDY7DfsUKpKfW?=
 =?us-ascii?Q?gtmQeLrdxZoFTzKCM8ubGzcZZRs903qZX8mJXhDOosjEGcaG+bek1AMwcLup?=
 =?us-ascii?Q?fainUBcIfOAe1qsxrpfbuI3bexopitxjLwDlvWQMHdvt7Ek6sGbSAfJJ7Yo9?=
 =?us-ascii?Q?mW0luiFIyRpYKiUSkgRU601FbWe9abOA3n6YrOSudE8UzKd3dVpj3XdfP7H1?=
 =?us-ascii?Q?7IU3VbMBCQkSoGFJzAupkNgc5drFeE7bENiHxMMeBHwXkGp0XlZd0VbH6v14?=
 =?us-ascii?Q?E/MNaU10sHojX2BvxKvugbGxbYAo6MkIOrnDAGLj/tYiEGXr4MgYsDbIfEjm?=
 =?us-ascii?Q?6CqU9/B6JUfk03IF8Sl9bL0V7ImpdMXIO2y+D4/iviKdwCGv6sDGaYDMOyps?=
 =?us-ascii?Q?XgI5WHUKbitwKKe8q9UKqOrvoSn3eClJ3i0WW8bAf4y4UL8D/2BB0O2dez+G?=
 =?us-ascii?Q?S2jZscZrdrFnXloTLn5VK3m9OGgiT/1E+zvhFlmFm76APXmguTS0ijLJTq/U?=
 =?us-ascii?Q?RwTfhgsgXhnsIxreowkKmMWEFVCnF9mwbdNu1P8XvuvQrjuCbR9JX6+NQYLu?=
 =?us-ascii?Q?Nl/jOCkXRVfKdckAzLlACIHKIosdGAcK/3A5FkkHfdXxB3u+h2BNbutC++iA?=
 =?us-ascii?Q?sAPK6cpBhRNrk0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9zkVZWtHhK7uAMB6eWpV2nhCsqJBNz+kfM0qoWFqwSu1iRf4dUM/2cGdHbHw?=
 =?us-ascii?Q?giWVKjVR7JVvxvbQpeMLK+UDsxkcGhvt6UURiYKzUTrSPByQLkWr92kCiLUL?=
 =?us-ascii?Q?N5gbdtFSp4p0fD7P7HOqpG6es3ZcuMkgnZz3SG/TY5IP1nl3yUN4kEG3po6M?=
 =?us-ascii?Q?dlTbJNYHnSxQYaebnpp9gyl8BekzvC4b+wBndGkJmW+08l/AoQ4StzIz6BJB?=
 =?us-ascii?Q?E6tztwXDm7+f6DPPgUUcUyUbMSsmNaM/mOgMjpx5Rapw+AXmY6nAJdclxrk2?=
 =?us-ascii?Q?I0Qu8wXiMDmj3nQ5IlZ/Ri0m+m6/w6faV7UvOsqnhlKtieBbcMLQ7hid9uj5?=
 =?us-ascii?Q?XnctnBaa4s/NjraY7KF9D2fFWHdx529vPLyFNa/zprFHlHlv4oM36Hd4TUYF?=
 =?us-ascii?Q?ds/3J19vvFKpyb7wjrVN5e4TCIBdFqJtdPOJDAfgOCNR//TCJgu8QGK1Wa9W?=
 =?us-ascii?Q?VD0Pz8AjT5w1IKERAL+pDvzBdIdfPeu3HIpulK2keDwichbyhooHN8nD+Fcf?=
 =?us-ascii?Q?Wg3pWoTC3u+LRH5EhIHBQ0cVmxowuo2wpwZRfSNJuwqxB5lVqo1SKPwnkMvm?=
 =?us-ascii?Q?kwMm1tubM4+Xv5AIDUChhoOmCeo+/nVjO0RU9RAmpA6PkZCT3Ekq3jvZmcE1?=
 =?us-ascii?Q?luePESk5dm2IRkk1p2bJx5zgI288UR4UFpdDxc0bHUTvi7nbEuAu4LFaKD7F?=
 =?us-ascii?Q?ofpWL9qP625rvFdyu+ru0rHpuw7s2LzKjH97q0Gtp5U5qxm637x9DuVl3Kt/?=
 =?us-ascii?Q?G22jHkH+Ya7pkRZCv8Q27zz/Xaz/cKT0OCT1R90g1tOMe/esTwjrO7ViK1P1?=
 =?us-ascii?Q?WOyxvScE53YvW3f2+lKSRvGtThqnuHnCrjGGwSrX8eHw+ieGPcxJGbq7AgMD?=
 =?us-ascii?Q?CXjwARH40vRBohn3wXRMnXHMvZIS9TRVdPvBMKgQOqJ+XuTxX0qt4+MhSsX2?=
 =?us-ascii?Q?y/fyawUDdrOp2UkAFJJwrgIx/jT1tMY2ftGrnLy9C8h0Z6gzy0nYMcTwj0YY?=
 =?us-ascii?Q?NanPr81sKPnRD4qBqGLnyC9B99RIkPW46Dc6F6VNrVTVIk3HjZjbSGlm9dOh?=
 =?us-ascii?Q?6EG4/u/1wghLfPNibvdJioWnVLe/4klCTk2kZVTmNz1Gk7pzFl7Djdxvtv2C?=
 =?us-ascii?Q?bP6dUD7KbJIlAGhsh/DqL8buMF8x3SSgYm46pgiiHEzXB91GIUgkUEFG+CZC?=
 =?us-ascii?Q?HqbtESIkHzSbH2KFNuVKzsy4U7ababGtaUJNZlR9ZH5SYFTTApt/D/3/8hAg?=
 =?us-ascii?Q?CCHcxyzO1iZb1DSHYOdSYba/bARsfmGAHFQOmRhRLKZdLmgDmaZDmz3wjITM?=
 =?us-ascii?Q?7y5GHmU6OfLrcXKbR5S6TA8fWWpmjlNkTjcR1VbLKjf9NGWq/VDVPPC4VCVd?=
 =?us-ascii?Q?WcfZsCgTAbHx0IQN4hZakJlr8kQO3a5dqRd3sK/w1jhVAxWvqeuqtmGTpB5b?=
 =?us-ascii?Q?kWBE0KuNK2k5r+skJF1dVe0A5Gixn5Lt8V4QsgEzWlk/vJlIFdnguRUptRYq?=
 =?us-ascii?Q?eLcsjOVMrKfj4JkF04GvtABEHTzUlvquPQGQAy2Q9v8fOAQOHF24I7uEiU+n?=
 =?us-ascii?Q?f7OC0lFlZDB1AXf22PCO47E7P25LAEinBHbnftvA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f14743b-eadd-4d89-c8bc-08ddded0771d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 03:28:29.1635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZDHMaYPVIMtM9Sz2kbHCHDzVgtL02iZ7XNnGRT3y4ovM9ZSUNsPycTflsEv1h5/rF0uil9svKwJ86VuRyf4nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6809

The jfs_log struct is already zeroed by kzalloc(). It's redundant to
initialize dummy_log->base to 0.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 fs/jfs/jfs_logmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 270808b6219b..b343c5ea1159 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1199,7 +1199,6 @@ static int open_dummy_log(struct super_block *sb)
 		init_waitqueue_head(&dummy_log->syncwait);
 		dummy_log->no_integrity = 1;
 		/* Make up some stuff */
-		dummy_log->base = 0;
 		dummy_log->size = 1024;
 		rc = lmLogInit(dummy_log);
 		if (rc) {
-- 
2.34.1


