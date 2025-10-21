Return-Path: <linux-kernel+bounces-862695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABCBF5EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A67245007B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0512EE263;
	Tue, 21 Oct 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uRfDiAd4"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A644032D426
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044383; cv=none; b=ffafh6CKKQ5IXc6Mbr3g7gHwPs66fQB5izu09yXh+PRSNlMFqtJ5K6DxlksukOX7K9qnSDRMyvBdIIFpPIbQed9gpZAb68MycPdZXb50QO9g8XA5u+KKgoGvZPvqnhYYJe/bjEusHnHYwTzOnSngzAY3Sak9hO8QJJWTxD19prA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044383; c=relaxed/simple;
	bh=QXtAtWPpAQQCg/4es6RksdN5P67u6Ia1as9Sf1erACU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qL2G+bWARu04VmG3OnvEv68EgTy5mbbCzX6OhFCXHrB2sA3BT+R2uBajnkBOXLAabDqfxytVS1KpkP/KESXH9azSTa8X69I889OzwU5HONaVyIxFqGOwuLvV/mPONxkTZBeYpy+X/G8Ct4bbQ3TRLzXP+wfizFJoaPcfKg+ilJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uRfDiAd4; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=krQn0u8nFubnBr1gbykuo1KbTyd2uBSqO/9+KeEmkgM=;
	b=uRfDiAd4kQoGQf21Iyo4WnxrpzV7P9onlEb8FsKEDUZJfzSNb9vCTzMSDLaAf7td3pPENNnzJ
	QKJETRrg//pyl4QIC3Y3I139WiLOkxHNLQ8mfh5pDkOqxlBmTVpRa8NKryQIIaAC024Jx8QlgDg
	J39t3i4wet2ePTBOMBVhTTE=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4crTn81rtgz12LDD;
	Tue, 21 Oct 2025 18:58:52 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id EDD23140156;
	Tue, 21 Oct 2025 18:59:33 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 18:59:33 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<hongzhen@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC v7 3/7] erofs: support domain-specific page cache share
Date: Tue, 21 Oct 2025 10:48:11 +0000
Message-ID: <20251021104815.70662-4-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251021104815.70662-1-lihongbo22@huawei.com>
References: <20251021104815.70662-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Only files in the same domain will share the page cache. Also modify
the sysfs related content in preparation for the upcoming page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
[hongbo: forward port, minor fixes]
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 283449024996..93cc24542405 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -515,6 +515,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
 	case Opt_domain_id:
 		kfree(sbi->domain_id);
 		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
@@ -615,7 +617,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && !sbi->ishare_key)
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
@@ -1032,6 +1034,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (sbi->fsid)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
 #endif
-- 
2.22.0


