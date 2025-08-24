Return-Path: <linux-kernel+bounces-783433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1760DB32D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBD91B20E56
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 04:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30D1E3DFE;
	Sun, 24 Aug 2025 04:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Pu9xSSYS"
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012054.outbound.protection.outlook.com [52.103.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE7393DD8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 04:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756010592; cv=fail; b=JnugmOsXaxNr1JTjjElwh0AxyjLXqDVRfp/Gsqm9dzu+oHog6Kk5R9TehvVOlI7yyPq+97wIlCZqsfD2uETSVhry9r0r9n8TQ/IeU0AACHoiI5BgDPqUTPgWYwyJOaubqjH3ICjeNS+C/VPNbFhKNCl5PIiKVLjb7Mz0sjIHFuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756010592; c=relaxed/simple;
	bh=BmBt8sx4lezfdqPV1F+HY0G/TbhZhDtKzNqWpovdZyw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qG4SBVi0eDK+mX/xUhf5K0Sk/TaRQnkJP/jXy6VG6/8h7RKRBAkLveYnHEGbbrqny00eza+aaru9q4IwAt069Rj2CfEbijl0zSB775vcZkX8Esma9uhBxCyLmZkLvgJJDy5jHQyObKabKdfqzKbdpRJfR34E4b5vwTqxTLS3UR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Pu9xSSYS; arc=fail smtp.client-ip=52.103.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCNq/di1EkgFmA06cZhumD8MaFXq/L/lZ0P0H+7xbbdO01XktJommpxeBThbHljA4LPd7eOH8LDAXQcoI8dy9hX6PwnL6kKAWtJrkMSaPsPXg1QrRstvKn99ayGQ3G00w2OPoq8R8VSEPrb6G/mzr5PUyWrJX2uNHeIMuIuCzuHBdh3KAMUp0TQZRu4VOfOMM9H524Rbp/li1xbrqW6dgz6Ub13WMhQ24WnwRw+A0X7AsFo/vhaPCwe/LzRdP9JHsENKGNY1pGmIBpTvztT+jtH8Ltv+S3O7ojWDbkRqATUaiZfb4k9LibaVA8t/vupxuRb+XAwrvkfjIZABX7P3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3lx2RzxHeT/mkzVSuYq3NPYqmJFXrGeftI2LrG/ly8=;
 b=A6RivqHigNMLCjFvmLNhESyuMpb9B7QZAfJYiERFEVEfasVjRd2/JaOZNTqN80ENj0WkKPphQOb/cyHWhz8hbU1/bbbOBN3rixGAqNKmqXhyuOi2kDwUJMTKIr8EJZJTaELt2r/QTi1+PcoTNDPi+OIV39r9CBvk22boJEAKYNOkT696w0ZLw4GI4moLz/+e0rAH0Gy9PGTLXR1ArvSolznWH5c3poGfsfAkEtzR+rfxlQa5zOir6EmSFHs/SwFwEfa5afFslvnVBjty2ZzM9eRvEHePRZT25JTuWMy+swrSFnbkfqqdc4FRvc7aTYGGqnaNqxA5XJ+IUem8ELvjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3lx2RzxHeT/mkzVSuYq3NPYqmJFXrGeftI2LrG/ly8=;
 b=Pu9xSSYSAsx1JubfmNMTeOH51z0k41eHxqJzkjdYvzJO/AYIzsgUL3SK/xGPsx4Zz+N9AlQPJsSCXcxA0FugCuQ1UxwGxWTsRNVaeOcBgU/N4bZ5lFy1jEIi6//WZQZ+FUB5/MNgfTSB4FGRxTRDmmD6YCtmOZVj+/5EimqG8bkVrzHAaqEY/d1P7LEQP0PxsLVvoBgeyDudZuUrBUXZAwrTro5n0TFWw+tdfJoXCmPdINk19nGfeQaIQOvcbGTNe+PfsvXdaDsNjC88/SKXa7Adu+LkQVJnVNvr2K3/3UOLNDuM5JE7N1j45fmxKW7r+t+ptDH78cdXo99aA3YSxA==
Received: from ME0P300MB0780.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22f::16)
 by SY8P300MB0502.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sun, 24 Aug
 2025 04:43:06 +0000
Received: from ME0P300MB0780.AUSP300.PROD.OUTLOOK.COM
 ([fe80::4f26:835b:7a21:e12d]) by ME0P300MB0780.AUSP300.PROD.OUTLOOK.COM
 ([fe80::4f26:835b:7a21:e12d%7]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 04:43:06 +0000
From: Yihe Jiang <he29@hotmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>
Cc: Yihe Jiang <he29@hotmail.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: add erase_on_mount mount option
Date: Sun, 24 Aug 2025 12:40:17 +0800
Message-ID:
 <ME0P300MB07806E7C0A351C163E1176B3C93FA@ME0P300MB0780.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To ME0P300MB0780.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22f::16)
X-Microsoft-Original-Message-ID: <20250824044018.2507566-1-he29@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0780:EE_|SY8P300MB0502:EE_
X-MS-Office365-Filtering-Correlation-Id: d6dea18a-e3fb-4d1c-0e2b-08dde2c8b7bf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|5062599005|461199028|5072599009|41001999006|8060799015|19110799012|40105399003|39105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9UsJBINgyWOAV29uoURzPs5E+YH0S8iaCrm14iIsNjF2biSKzslKWij7TubC?=
 =?us-ascii?Q?LwDdCEsfvgAncTnPvrxFz9Mtq4uiYlHsz2K9Oi9kwXZPvKPXVk0yFkZgriqu?=
 =?us-ascii?Q?BcUwdkEL0nzJ46Kt2gOZkR2Vmlmuw8yrSTNJtJoIIYr6gsxvznpOtbaxrTAT?=
 =?us-ascii?Q?B2bX5Qob9NgjZXAMitwH3I8yKJN7gClQMDStTKkqp0dw4/0CPFogekglmcfM?=
 =?us-ascii?Q?R83zGU90AAWVSZ4Fxaj3YZIaZ55SDzZTjLgweFLsdHqqjfAYY/4NDaE0haeH?=
 =?us-ascii?Q?aD7gseJSWyHhQI/5VtSkH+z4fpxN/MKexjbChy+ePlo+odIpgRgQn8ZvuRNb?=
 =?us-ascii?Q?ksVOF8chaj6IYeUDzkkklqhfZK4gDtb7kzfftcxC2/L1ewDedhEY4WKvxvCv?=
 =?us-ascii?Q?+BH3K168gtT6h2D7pFys+Wu6qzGcbb0wswPp7kJN3cEsHF9pDocsZvaeAgs+?=
 =?us-ascii?Q?e06AflD5ln8megMXtIfXoSPZ/GvKv3SAL5JNIprb4D6JFqN/pzPU2U/Tjb1c?=
 =?us-ascii?Q?xbPvJ3rjHLt/e9MmVNlGCkU07A10jfMcK8quY0TERAhVdPodSvdvdgar9lR6?=
 =?us-ascii?Q?20OltIVr2B3N2xqhxoFTgujVLabdnCCOvR4NDOp79s/0PNJLEw4STOhL1fRz?=
 =?us-ascii?Q?aT1pfJrQxcwuhjfJiOlOARLhQWZfVr2jhc3ecjKqFJH6uKpD49Z8lz9mtaQ4?=
 =?us-ascii?Q?J41uiv+Qne5/54phtuszbll5GiOCFR8wziY6WLnZ06EB01w4GJazvcIs7kdG?=
 =?us-ascii?Q?/bjpTFojkXzA0afuHnyMbXnjUtaT15kUVgEkXzkd0vOc0qK41Zzsi45hUuij?=
 =?us-ascii?Q?3QjbEPBjXhGb9LDmZgZWgyntvfG8hhGiJdId/EklaTRbli0Yqc9RFsD9A2bz?=
 =?us-ascii?Q?88JQ4T+4HnZCOalahyQjYWtGsKX2QsyCUWzFBdPXrj0PgdI3L2AOgStaRKIb?=
 =?us-ascii?Q?lx8pnluufiysua8r/0s9goRxs5zryHWgJwvrNyFR9Brx3fLpxtWoNwjEmIwr?=
 =?us-ascii?Q?6it8zRd671sYcjFLcWcAliY7SpVzaXjKdo6kk/SsHE2FBPzhuYuHJkDjeTSm?=
 =?us-ascii?Q?/yZF3OAWEdXASsB3OCzGPOHrLkjtDAbx3ljjOoBWj6QjD/dw8ztN1Ly3+bEw?=
 =?us-ascii?Q?TZAaOgYQg5LheuTSOvjteGDsAz1nXiRMm+ydwM+YzQjcZX0VKHHHzHcFWqjt?=
 =?us-ascii?Q?ptgHmQeMp6xdtRacAR2iSnPSd6DBpNNFyAMnwiNeicFOJJL1pPhcy21stS96?=
 =?us-ascii?Q?/tsu9tTMR3RDVGue8yCP6deX+m9VOKJM61FiVWmUsg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q7U0DJCfohGhCR1hKjGNTyZSnZZqWGM0rfJ4QQuDyWKfrksTDKv3LFzlC7hR?=
 =?us-ascii?Q?n/y/3+CXRw8NvZ31ullUMKR+jvOm5AbELLwiDHlkh2PG+gDBGX+YIILaDIh7?=
 =?us-ascii?Q?uCy0gXA8xTp+HweFC/GU0xL+WrBFrTxDssbPqVz4VVK26OF2OlW5kac6KaoV?=
 =?us-ascii?Q?GHSPnuXLY7TI4aUoZA3uLhmTFoxMOQ5LfZaPTmRnVm0hBDpcL7lyBCjd2czh?=
 =?us-ascii?Q?n70SLltpQGtNSI1I7nc5CpSCez7LPI+Vj5w6N4lJ65NnxzOYCz7XQABgvZHY?=
 =?us-ascii?Q?6rPjdaXnIum1VlvIin2FDlnFH1Ag6vB/9FfX7RM21zLs/oPzgim74O2JAWtR?=
 =?us-ascii?Q?qrL5FnGl4PDz+Ab4zS7VeyRxD0N9HuhIwQFTMDH+8uK9gaKbAArPdePyNMx1?=
 =?us-ascii?Q?X+vS0K6+it2Dk6Apn1GSI5XLNeUE+a/TkHzkb/RKdSo72rbykmKyQ1tOyhsp?=
 =?us-ascii?Q?ZnLy7n/1NUXgxa5SP6f4Hw4XpjVzZU3n4qbjFfpwR8lxqdAXFCUGKDpvLXeO?=
 =?us-ascii?Q?jfi8Elk2KC8HyZTvkvf4y9T+dVE2f0IPdA+7uvypZ7qhnFiLe/+ZfpkAypmd?=
 =?us-ascii?Q?04X5HoSpMx5mZmM4SLzD6hDPX1pRs85AjExSw2Yh0eZF+BOXHgDbf8OUuGsb?=
 =?us-ascii?Q?cvlqNpIe6ySE28Swd0pRV6YYQtbgVDMYG3vLOxvAJyYWWQXKvnYDqqTyWf5o?=
 =?us-ascii?Q?GF8NF10FiXBVl1Y9sKsQkw9H7VdJcrFfJy+86/yYjdaJ11gTKocQSgWcKLQ0?=
 =?us-ascii?Q?fiR/f0oN99KtZYxWNwDYYlmSZ6FDrOvG6N8PuVqkbT2yWWVtA8jfBTWdUfhg?=
 =?us-ascii?Q?79Th0ASED6Be0DfoAih+1MrWaHXcVZhg7gF0PDSvkdsKXgT9De6Js10X0/YI?=
 =?us-ascii?Q?7bvM8bc8/iO7wGt8ayU1bLN2VrVL3zmm5mABoOSebS/bJpMITKvr0Qoq5WIi?=
 =?us-ascii?Q?j+FvhS/cBdatCpC7D2WXMFcEFe35M20eK3q0Mqi80tnKNbo9F/aij8B3vmUg?=
 =?us-ascii?Q?Oj6b4wa21Dfcmi1a7um10ItvP+1bF1SqAZ7fgeXXYmRJCdNb4GaZnMc5cw8u?=
 =?us-ascii?Q?YvC0kSwflar1FuDkzY6FTjhIMXVvaiDAccf3QHrlS2hZ5x5+k6SAldecoG8A?=
 =?us-ascii?Q?idF8NOLdcgFmQFj4bNKbbd26wwymX2yv79RihPlHRvwUIX1HFlkqA9LXYb8y?=
 =?us-ascii?Q?BJDQRrCwpq5a2owboAd8vTbngHLhZznwkaYLSiFPmKyaEEWAaIpQGQdEhLs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-fb8bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dea18a-e3fb-4d1c-0e2b-08dde2c8b7bf
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0780.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 04:43:06.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0502

On some slow MTD devices, mounting a newly-created empty filesystem
can cause the system to become extremely slow, as all empty blocks
are erased in the background after the first mount. This can preempt
userspace operations and affect filesystem performance.

This commit adds an erase_on_mount mount option. When specified with
rw, all pending blocks are erased during the mount process, avoiding
the speed drop after mounting. The option does not take effect when
mounting read-only.

Signed-off-by: Yihe Jiang <he29@hotmail.com>
---
 fs/jffs2/fs.c          | 14 ++++++++++++++
 fs/jffs2/jffs2_fs_sb.h |  1 +
 fs/jffs2/super.c       | 10 ++++++++++
 3 files changed, 25 insertions(+)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index d175cccb7c55..65cbb47d73c4 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -411,6 +411,13 @@ int jffs2_do_remount_fs(struct super_block *sb, struct fs_context *fc)
 		mutex_unlock(&c->alloc_sem);
 	}
 
+	if (!(fc->sb_flags & SB_RDONLY) && c->mount_opts.erase_on_mount) {
+		pr_info("erase_on_mount option set, erasing all pending blocks\n");
+		while (!list_empty(&c->erase_complete_list) ||
+		!list_empty(&c->erase_pending_list))
+			jffs2_erase_pending_blocks(c, 1);
+	}
+
 	if (!(fc->sb_flags & SB_RDONLY))
 		jffs2_start_garbage_collect_thread(c);
 
@@ -595,6 +602,13 @@ int jffs2_do_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_time_min = 0;
 	sb->s_time_max = U32_MAX;
 
+	if (!sb_rdonly(sb) && c->mount_opts.erase_on_mount) {
+		pr_info("erase_on_mount option set, erasing all pending blocks\n");
+		while (!list_empty(&c->erase_complete_list) ||
+		!list_empty(&c->erase_pending_list))
+			jffs2_erase_pending_blocks(c, 1);
+	}
+
 	if (!sb_rdonly(sb))
 		jffs2_start_garbage_collect_thread(c);
 	return 0;
diff --git a/fs/jffs2/jffs2_fs_sb.h b/fs/jffs2/jffs2_fs_sb.h
index 5a7091746f68..eb43416997f0 100644
--- a/fs/jffs2/jffs2_fs_sb.h
+++ b/fs/jffs2/jffs2_fs_sb.h
@@ -40,6 +40,7 @@ struct jffs2_mount_opts {
 	 * available space is less then 'rp_size'. */
 	bool set_rp_size;
 	unsigned int rp_size;
+	bool erase_on_mount;
 };
 
 /* A struct for the overall file system control.  Pointers to
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 4545f885c41e..270d24b336cd 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -91,6 +91,8 @@ static int jffs2_show_options(struct seq_file *s, struct dentry *root)
 		seq_printf(s, ",compr=%s", jffs2_compr_name(opts->compr));
 	if (opts->set_rp_size)
 		seq_printf(s, ",rp_size=%u", opts->rp_size / 1024);
+	if (opts->erase_on_mount)
+		seq_puts(s, ",erase_on_mount");
 
 	return 0;
 }
@@ -167,6 +169,7 @@ static const struct export_operations jffs2_export_ops = {
 enum {
 	Opt_override_compr,
 	Opt_rp_size,
+	Opt_erase_on_mount,
 };
 
 static const struct constant_table jffs2_param_compr[] = {
@@ -183,6 +186,7 @@ static const struct constant_table jffs2_param_compr[] = {
 static const struct fs_parameter_spec jffs2_fs_parameters[] = {
 	fsparam_enum	("compr",	Opt_override_compr, jffs2_param_compr),
 	fsparam_u32	("rp_size",	Opt_rp_size),
+	fsparam_flag	("erase_on_mount",	Opt_erase_on_mount),
 	{}
 };
 
@@ -207,6 +211,9 @@ static int jffs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		c->mount_opts.rp_size = result.uint_32 * 1024;
 		c->mount_opts.set_rp_size = true;
 		break;
+	case Opt_erase_on_mount:
+		c->mount_opts.erase_on_mount = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -228,6 +235,9 @@ static inline void jffs2_update_mount_opts(struct fs_context *fc)
 		c->mount_opts.set_rp_size = new_c->mount_opts.set_rp_size;
 		c->mount_opts.rp_size = new_c->mount_opts.rp_size;
 	}
+
+	c->mount_opts.erase_on_mount = new_c->mount_opts.erase_on_mount;
+
 	mutex_unlock(&c->alloc_sem);
 }
 
-- 
2.50.1


