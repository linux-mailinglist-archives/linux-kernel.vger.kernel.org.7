Return-Path: <linux-kernel+bounces-835357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD1BA6E0B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289931780D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411AE2D9EEF;
	Sun, 28 Sep 2025 09:41:45 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426972D9ED0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052504; cv=none; b=WAIDKtQvd3Af+nJRd9bxsZlB6OLbbqjk6sXaBfYwWWe6rBAhSRpF+JzI2KnfWUPm4673mxMZZKREdHKxqNOssNkuUvGD/ux/vTmWKpqtozDE6Ljrli7SD3QH+qXv87tnOI89oACL9tuLWRez6uBScvgAlbrGPKmtXa+kUp/dOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052504; c=relaxed/simple;
	bh=1tlzJWdN56EDcq5HthC03bg7XMECCgYcQrkhJv9S8ww=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lbatDGEy3nUgdXJfJoIYKMxBIb1rULiRlKo4wszlkiT+SmWQPwllMd+cCVzuLOLlVdlHo4rX3LIsM0Z836HUleSYhzMqDMp3SjjMsnEDFjNbWlr7B5t7y02iHNMDaBAQ2Tgh65WGYZU96Q3e8gROfs0lxd+K2qhX092YYeRLxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8870219dce3so365071639f.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759052502; x=1759657302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ3/mFKpVGZ0sZwc0az8WJEb4oHMyVi5sQTf8ELWSSg=;
        b=wHFtyDScxKuuAdEb+43Ll/3TJFCJe/Dh3p+8+MfZF2tRX8GSxXKNdcuCzP+3MBSme+
         Ha9A5/cwfypS8YJREdRalGMtpzpnVDbrgOv8oOi6PVp+SNt3odUlFnPXcXQJ6fIu4Kzu
         18gOdnxWDW/ImPNCP7fVUZcgpYj1tS/XImdZZIdr1jXO+pf8UWQjTu9jE8vt+a947gTc
         ygGA/tM/yV5CGyi92a2pkDM7Xjo6MldvJVYLFC5O8cDFKLBVgoZXdwXrFLEdvrCeajBH
         I2/BYz+13yEhvud60HuvzQu3e9tqrEpVO0qsV6PCYiR5C5lAQedtEcF07GkkMql9L424
         E+dQ==
X-Gm-Message-State: AOJu0Yy+oF44/2ebTfa94XdGJKE7sKIDs1cFoqjlswpckDCtyKbm1Dwu
	WX51JmqudoODJ+7CctjJSY6o+EYXE1h5/jut6ocPkHRqObRld96Os5+LV/+LVTZrIZsTy4/xjtL
	KUlOsm08/L5DAww32hVfHUX4/5XqyK3u6HcohPO0NVlM4N+sPi7hrJt8tLAk=
X-Google-Smtp-Source: AGHT+IFVseFJzWM3T2nHSADc0aw168ys3L4KJKfOtzYKsCeJIn3+W1FXKRXvAVOB2Ef9pVZAAC8zdbM8Q0EMRcKsKx8GZxXDhZnu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:427:2aee:4935 with SMTP id
 e9e14a558f8ab-4272aee4a76mr136615165ab.12.1759052502423; Sun, 28 Sep 2025
 02:41:42 -0700 (PDT)
Date: Sun, 28 Sep 2025 02:41:42 -0700
In-Reply-To: <68b95f81.a00a0220.eb3d.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d902d6.a00a0220.102ee.0029.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


syzbot reported a BUG_ON in ext4_es_cache_extent() triggered when
opening a verity file on a corrupted ext4 filesystem mounted without
a journal.

The issue occurs when the extent tree contains out-of-order extents,
which can happen in a corrupted filesystem. ext4_find_extent() calls
ext4_cache_extents() without validating the extent entries when the
tree depth is 0 (leaf level). This allows corrupted extent trees with
out-of-order extents to be cached, triggering a BUG_ON in
ext4_es_cache_extent() due to integer underflow when calculating hole
sizes:

  If prev = 4352 and lblk = 1280:
  lblk - prev = 1280 - 4352 = -3072 (as signed)
  = 4294964224 (as unsigned)
  end = lblk + len - 1 = 4352 + 4294964224 - 1 = 1279 (after overflow)
  BUG_ON(end < lblk) triggers because 1279 < 4352

Fix this by adding extent entry validation using the existing
ext4_valid_extent_entries() function before caching. This ensures
corrupted extent trees are detected and handled properly through the
error path, preventing both the BUG_ON and potential use-after-free
issues.

Reported-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Fixes: a86c6181109a ("ext4: cache extent hole in extent status tree for ext4_da_map_blocks()")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..f8e45623f7ea 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -924,8 +924,18 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	path[0].p_bh = NULL;
 
 	i = depth;
-	if (!(flags & EXT4_EX_NOCACHE) && depth == 0)
+	if (!(flags & EXT4_EX_NOCACHE) && depth == 0) {
+		ext4_fsblk_t pblk = 0;
+
+		if (!ext4_valid_extent_entries(inode, eh, 0, &pblk, 0)) {
+			EXT4_ERROR_INODE(inode,
+				"invalid extent entries, pblk %llu",
+				pblk);
+			ret = -EFSCORRUPTED;
+			goto err;
+		}
 		ext4_cache_extents(inode, eh);
+	}
 	/* walk through the tree */
 	while (i) {
 		ext_debug(inode, "depth %d: num %d, max %d\n",
-- 
2.43.0


