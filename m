Return-Path: <linux-kernel+bounces-763888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7EB21B39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10AD1A22BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A012882C9;
	Tue, 12 Aug 2025 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wej+NuK2"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5AD311C13
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967865; cv=none; b=fGYdvodWwRbYyWHg7fwyzqiBsQnyWT8Rm/WeKc45SMBH8YDeSPCjWjrI0JCznroriI95woI9jgiQm7VbnV8TfO/kms4t5ayXOiHtW87wVtnI6IsDe8zk9XrHUqUYBD96uKBMQDTYNQhV9/c1lRlokzd1nPNaOGFGSWnok2ZmCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967865; c=relaxed/simple;
	bh=S/GGW/X0sbmzQyKSCjDvMQOd57U7wUBEnR97rSsPnLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DV8jcHWb2rzrk5LQY/RMaGntH4pFOfQza0bHdno9NqHeavApv8kLI5eCxRzctd2Co2lkJby8jIwZn1AtkT+20AozvK6ERIZPJj0h/fOi2Zog88UVs3RNzPsIIoL5uOV35hgcig5RmsBQ7v4j68lnZROrPs/lircqcp5BjXJXarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wej+NuK2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EO
	3yrp+GyHoL0Z84VhP5JUnJKqyveCdWDwnuje+Gi3I=; b=Wej+NuK2sfNda9FJLM
	0wv1FOrWWmrhvmVs+MMecv45OWGR8a22kZpql4Y5E5aJN6nLphTiTUisNgedc+T+
	fC00RDY+2BpQwWzvS+32FRY3EGn2lOcxiojFaG3ws3OQZi1o9A+7HmrN2dAMgLSp
	6LT4GsVr40eGE1bpsmDAt1hiQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wB3nrsmr5poKBF9Aw--.8632S2;
	Tue, 12 Aug 2025 11:04:06 +0800 (CST)
From: scott_gzh@163.com
To: phillip@squashfs.org.uk
Cc: linux-kernel@vger.kernel.org,
	Scott GUO <scottzhguo@tencent.com>
Subject: [PATCH v2] squashfs: Avoid mem leak in squashfs_fill_super()
Date: Tue, 12 Aug 2025 11:04:03 +0800
Message-ID: <20250812030403.517269-1-scott_gzh@163.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3nrsmr5poKBF9Aw--.8632S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4DAr4kGryUWrWDCF1kuFg_yoW8Aw4fpF
	1xWr1akr4YvF45Xrn7XFZ5X3WF9w4vkFyUJFW8Z34fZr93t3WxKrWktrWaqryfKrZrArs0
	qFn0qayS9FWUXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jHAp5UUUUU=
X-CM-SenderInfo: hvfr33hbj2xqqrwthudrp/1tbiQwOnnWiaqLf8nAAAs3

From: Scott GUO <scottzhguo@tencent.com>

If sb_min_blocksize() returns 0, -EINVAL was returned without freeing
sb->s_fs_info, causing mem leak.

Fix it by calling and checking result of sb_min_blocksize() before
kzalloc.

Fixes: 734aa85390ea ("Squashfs: check return result of sb_min_blocksize")
Signed-off-by: Scott GUO <scottzhguo@tencent.com>

---

v2:
  Adjust commit message based on Markus' advice, and refine fix
  following Phillip's comment.
---
 fs/squashfs/super.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 992ea0e37257..073462b098c5 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -188,9 +188,16 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	unsigned int fragments;
 	u64 lookup_table_start, xattr_id_table_start, next_table;
 	int err;
+	int devblksize;
 
 	TRACE("Entered squashfs_fill_superblock\n");
 
+	devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
+	if (!devblksize) {
+		errorf(fc, "squashfs: unable to set blocksize\n");
+		return -EINVAL;
+	}
+
 	sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
 	if (sb->s_fs_info == NULL) {
 		ERROR("Failed to allocate squashfs_sb_info\n");
@@ -201,12 +208,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
 
-	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
-	if (!msblk->devblksize) {
-		errorf(fc, "squashfs: unable to set blocksize\n");
-		return -EINVAL;
-	}
-
+	msblk->devblksize = devblksize;
 	msblk->devblksize_log2 = ffz(~msblk->devblksize);
 
 	mutex_init(&msblk->meta_index_mutex);
-- 
2.41.3


