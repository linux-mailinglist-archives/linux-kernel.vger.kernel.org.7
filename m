Return-Path: <linux-kernel+bounces-812755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B06B53C42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0957AFFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB98325C822;
	Thu, 11 Sep 2025 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mejLG50R"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5AD19CC37
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618850; cv=none; b=Oi5vUXn7SYTQNLX8NTX3zvCVae6xN/9Cp7Ptm9wukSgZ+4twtCWOVCleZqGIZ0SRVTmddzhyf9jEdKZo0ord+/p2e4AjPPMPgy198lm+1sFfxXxBp2CBxg2YId56mqbv1w8OuTa2UCJoG+69UgXAXp+a8x7l+4qAfGMyCXwVe84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618850; c=relaxed/simple;
	bh=wwS53c1sfVZXwNTJ5JFgqlegCQJ96CQmrfZtGQEsS3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Usg4Yja7oTU1tJFndQ2egIPMoPlDDb5GG9Imp1dRr2br1voKReHEQBAX+kZ5odZXELVInJQaNxdorkq0t/bzr90jIfFbsq9M3QJ9YVPNh/LK/7e8fS/1cZGwqyOyksjDKRfKFUvvQjNzSduS42xA99HMi03tfT0I4jQauuW54Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mejLG50R; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757618838; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TgS+L0bL55mIYD7rURt5we3dz3uCQIidBU8PE3G6xGQ=;
	b=mejLG50RGAT/akD3G79peaYRvYLGJgnd3d3iQdfTxW4ElAZOIsVRtOpr+ibhXI/kQgOTTDVGe0gcTgD5PLzid1cQ5coNmCFgJnmUJUu53sdBSLzggfsJAtpGeuInV2eTELfeqegPlKThFsXi25mASZznfOr5Sk4j0FSJtoulaLY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnnaSWZ_1757618832 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 03:27:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix long xattr name prefix placement
Date: Fri, 12 Sep 2025 03:27:11 +0800
Message-ID: <20250911192711.1771664-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, xattr name prefixes are forcibly placed into the packed
inode if the fragments feature is enabled, and users have no option
to put them in plain form directly on disk.

This is inflexible. First, as mentioned above, users should be able
to store unwrapped long xattr name prefixes unconditionally
(COMPAT_PLAIN_XATTR_PFX). Second, since we now have the new metabox
inode to store metadata, it should be used when available instead
of the packed inode.

Fixes: 414091322c63 ("erofs: implement metadata compression")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  8 +++++---
 fs/erofs/internal.h |  1 +
 fs/erofs/xattr.c    | 13 ++++++++++---
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 377ee12b8b96..3d5738f80072 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -12,10 +12,12 @@
 /* to allow for x86 boot sectors and other oddities. */
 #define EROFS_SUPER_OFFSET      1024
 
-#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
-#define EROFS_FEATURE_COMPAT_MTIME              0x00000002
-#define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM			0x00000001
+#define EROFS_FEATURE_COMPAT_MTIME			0x00000002
+#define EROFS_FEATURE_COMPAT_XATTR_FILTER		0x00000004
 #define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX	0x00000008
+#define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX		0x00000010
+
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ccc5f0ee8df..9319c66e86c3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -234,6 +234,7 @@ EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
+EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
 
 static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
 {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index eaa9efd766ee..396536d9a862 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -482,6 +482,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	erofs_off_t pos = (erofs_off_t)sbi->xattr_prefix_start << 2;
 	struct erofs_xattr_prefix_item *pfs;
 	int ret = 0, i, len;
+	bool plain = erofs_sb_has_plain_xattr_pfx(sbi);
 
 	if (!sbi->xattr_prefix_count)
 		return 0;
@@ -490,9 +491,15 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
 	if (!pfs)
 		return -ENOMEM;
 
-	if (sbi->packed_inode)
-		buf.mapping = sbi->packed_inode->i_mapping;
-	else
+	if (!plain) {
+		if (erofs_sb_has_metabox(sbi))
+			(void)erofs_init_metabuf(&buf, sb, true);
+		else if (sbi->packed_inode)
+			buf.mapping = sbi->packed_inode->i_mapping;
+		else
+			plain = true;
+	}
+	if (plain)
 		(void)erofs_init_metabuf(&buf, sb, false);
 
 	for (i = 0; i < sbi->xattr_prefix_count; i++) {
-- 
2.43.5


