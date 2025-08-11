Return-Path: <linux-kernel+bounces-763921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DC2B21B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2738F1A2742C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED42DD5E0;
	Tue, 12 Aug 2025 03:20:53 +0000 (UTC)
Received: from sxb1plsmtpa01-08.prod.sxb1.secureserver.net (sxb1plsmtpa01-08.prod.sxb1.secureserver.net [92.204.81.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAA240611
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968852; cv=none; b=Xa92rXax7iw1B4lZSCOrw5RtTC76NT4n3SyH9XigjH3CUXcG1os5AN2D21/S0+6LcJfq+Am5OdCA8t+1XPjJs+llz9sR66am2rDt7bjMUS8yUVYqXg0dXtmv0kqj22pGWSIIC8j0LrfJQP20yC2I2XBA6j91xCaB47JjPAvt1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968852; c=relaxed/simple;
	bh=67/hAMFAcvNuc3mwgrcA87EPthHTLdvZR4u7iBMjTkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f7R3+/tD2qwK+gqciGqnh2nO585rB2HqP2YbXXgfs/nN4GUJ+waHpsXDhhFOJuDYg72gsVWKgWa478UmkQWb4erNghX3XnpZfWJeQ/8atsDml4aqijVoi6D5ju7AToCe0jmYYIQfSd4SKjksGOf7lY3JaKUWy3oLiaOHCuVR+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id lb9Gumnrur677lb9VulKQZ; Mon, 11 Aug 2025 15:38:02 -0700
X-CMAE-Analysis: v=2.4 cv=No7Rc9dJ c=1 sm=1 tr=0 ts=689a70cb
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=GvQkQWPkAAAA:8 a=FXvPX3liAAAA:8 a=Xg-VGseiynj4m8WDMasA:9
 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: fb9a3de28582118c1a1768069003e494:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Scott GUO <scottzhguo@tencent.com>
Subject: [PATCH] squashfs: fix memory leak in squashfs_fill_super
Date: Mon, 11 Aug 2025 23:37:40 +0100
Message-Id: <20250811223740.110392-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDZPnqwHEtCi/1hYhIKsiPUxaIqMUSzWj1w+jG+4NbaqmI+qZD9jxxrZJk0DKV9vh81+WbTcPZCb4TPX+r+Pu4R09D2lpAwqlvHZnjuJDL+b99SBuAIC
 YFBo9vN+x4V9L9VnDg1skxY9pWAT/IIQWBQCZ8xRlGdPOOlXJK2qA47G/GIgzu9Hevqrd+UmN5Dfn+XLmT1mYsDc79QLFKycF+PirNiFkcazqjWoYiIKSBWY
 qTre9YV5F4Dab256ZygFFcqqU4IagQho/I4uPaoh6D3OZ9JwhMRcQzh8bq1pyI2Pj5Cn/JEfJPEY2eVJvDtyfw==

If sb_min_blocksize returns 0, squashfs_fill_super exits without freeing
allocated memory (sb->s_fs_info).

Fix this by moving the call to sb_min_blocksize to before memory is
allocated.

Fixes: 734aa85390ea ("Squashfs: check return result of sb_min_blocksize")
Reported-by: Scott GUO <scottzhguo@tencent.com>
Closes: https://lore.kernel.org/all/20250811061921.3807353-1-scott_gzh@163.com
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/super.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 992ea0e37257..4465cf05603a 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -187,10 +187,15 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	unsigned short flags;
 	unsigned int fragments;
 	u64 lookup_table_start, xattr_id_table_start, next_table;
-	int err;
+	int err, devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
 
 	TRACE("Entered squashfs_fill_superblock\n");
 
+	if (!devblksize) {
+		errorf(fc, "squashfs: unable to set blocksize\n");
+		return -EINVAL;
+	}
+
 	sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
 	if (sb->s_fs_info == NULL) {
 		ERROR("Failed to allocate squashfs_sb_info\n");
@@ -201,12 +206,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
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
2.39.2


