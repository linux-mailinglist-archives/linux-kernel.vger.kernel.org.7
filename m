Return-Path: <linux-kernel+bounces-761848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3D2B1FF49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73AB3AD819
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BBA2798FA;
	Mon, 11 Aug 2025 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FYY3Crte"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB4156F45
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893181; cv=none; b=TUs08eqBLlgxyIfDvY11wvWEt9LytY6OvHwCWm//4KNrQPzY6Y1QNhcfy87jsQs9HEg/eNC7jFdfWqaZqvKXCuAonrcJ78h3TBuaoYJ9wqimBHXKVPAAytnnZC01nXa9o6+NNdGgKnJW0aKeKZ0Y8DL4fp/7roHWYN5fD3afDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893181; c=relaxed/simple;
	bh=YYunXkR4kbWFgyaux021WmKySHRcvJ8d9fctGkfy1CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDdSO0bb/ZVHI4bJv8wNIyM+5N8qB4KOw7xrWKvBiNf9jKcdy1Jl81k5pgbAiz54GaoVUy8t3wZ+9IZB0XjFsUNDEDqNvbl6jOSokFhaFxBuB1Hnvp0lWtZSdUpKwgTpesEy/2rf6z9OiL4OJRJkx4MCaHUYZb3QkEBuJVJ5jIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FYY3Crte; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rT
	I+0NUI0xuV0QmaFgJCPbns1IV3pQfw3G/NJERIusA=; b=FYY3Crte2KT/Ov+1xQ
	d+jz1qyWqKWYwnAkfnIdy+R4vpK+ZVrGrcbBGaC3+H5idVqWpuay5nU9HXRs/TWx
	+GAiXnJXYfJLjgJe5znrfVH0op5XGaHhXwqVVy+MSpA2pQj8V1W+fQNKn6niau/i
	wpfhoM8Khzc0yZ9Z5vGbBTLsE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCH1Fhri5looJW6BA--.64867S2;
	Mon, 11 Aug 2025 14:19:23 +0800 (CST)
From: scott_gzh@163.com
To: phillip@squashfs.org.uk
Cc: linux-kernel@vger.kernel.org,
	Scott GUO <scottzhguo@tencent.com>
Subject: [PATCH] squashfs: Avoid mem leak in squashfs_fill_super
Date: Mon, 11 Aug 2025 14:19:21 +0800
Message-ID: <20250811061921.3807353-1-scott_gzh@163.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH1Fhri5looJW6BA--.64867S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1xWF43tw4xXry7Xw1kXwb_yoW8JFy7pr
	18ur1IkrWjvF15XFn2vFZ3X3WF9w4v9FWUWFy8Zw1aq39Ivw17ZrWktrn0qaySgrZrJrsa
	qFn8WayFkFy8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jHZXrUUUUU=
X-CM-SenderInfo: hvfr33hbj2xqqrwthudrp/1tbiWximnWiZZ0gC3AADs7

From: Scott GUO <scottzhguo@tencent.com>

If sb_min_blocksize returns 0, -EINVAL was returned without freeing
sb->s_fs_info, causing mem leak.

Fix it by goto failed_mount.

Fixes: 734aa85390ea ("Squashfs: check return result of sb_min_blocksize")
Signed-off-by: Scott GUO <scottzhguo@tencent.com>
---
 fs/squashfs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 992ea0e37257..7d501083b2e3 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -201,10 +201,12 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
 
+	err = -EINVAL;
+
 	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
 	if (!msblk->devblksize) {
 		errorf(fc, "squashfs: unable to set blocksize\n");
-		return -EINVAL;
+		goto failed_mount;
 	}
 
 	msblk->devblksize_log2 = ffz(~msblk->devblksize);
@@ -227,8 +229,6 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto failed_mount;
 	}
 
-	err = -EINVAL;
-
 	/* Check it is a SQUASHFS superblock */
 	sb->s_magic = le32_to_cpu(sblk->s_magic);
 	if (sb->s_magic != SQUASHFS_MAGIC) {
-- 
2.41.3


