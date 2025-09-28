Return-Path: <linux-kernel+bounces-835358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A3BA6E0E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B83B90F8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04E2D9EFC;
	Sun, 28 Sep 2025 09:41:45 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81A2BF000
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052505; cv=none; b=DgabUMZ46DkkVWRxYWPBlKEmT5jo+hQpPHOeXAHYg41Wy4JKluANYcgX8YzdLgIXQ//j2TSToK9jvNtbXAquXPI8apeyHkSLvbSw2l4qpfjyTO+NWm874VICw9uEXCeaphrchdKggFZS8ddv9jbejVJns+ivyY3p34FPvq/AXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052505; c=relaxed/simple;
	bh=1tlzJWdN56EDcq5HthC03bg7XMECCgYcQrkhJv9S8ww=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p0HXlk3u9GiIYciweg+bqBYhRLfMbjroacTArogjs2eqIMjJzLOOLzPCeR4/MNSc7gSpvjK7iWU8Lere604H5lObJMKMpLH87YWVZVOtr/T4sR9SJnNkimarfAOfa0Q/Q0Oo0n1xw8DA+fQiqH1f24T2Bvl+uy37BbZoy+X+SP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-92789f3367aso6252939f.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759052502; x=1759657302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ3/mFKpVGZ0sZwc0az8WJEb4oHMyVi5sQTf8ELWSSg=;
        b=ryjBpTDgoDi+sB9BAovHbkbFjGkspKu0zuXistup4kBljDaAZbIW4w48NfO8BasJGK
         6Le4lh9xvxlc5CmoIzQAUsvuLq6bCme/lz26G4ZNG3dGFSw8P591EaKwDvweMTxhoo/N
         T+SNFnLlZEw/pb8O/JL8cJAV+aNgBpv0+r5PDL7L5xz4QgJvoHZKRoiLAN7YcXZuqIgR
         UHLrKanxkHVbWKBJnBKXi0bXux4gJtMyWJbYGjWzyq4loA0suK+vXF7XQORir34ajmNg
         4kmTMQ22K14hKtwB3QqBdPuCltHR4F6Ijwx5WxJyC8L0A00f7ejavtqkUJPkOKPvewxE
         JqcA==
X-Gm-Message-State: AOJu0YwsOEEAN3Y5mImTaRGTVJ6yvTBHp6MJ7toUXTrMMT0q3kZhkFt9
	JTg3Hwe92wiyajbvviRgw7zFQCyoHeuznusK6f0hBYnlQTthz2QG4L/x5TsbhacLSIwuqqeXsLj
	OqVcG5Y98SEUn0lRb8L9j/A8H7op2VdeDXZ41JRmWGi5051WASe+eCVSHor8=
X-Google-Smtp-Source: AGHT+IHf0OLP5/P6OikWc2MJlwGfaaGEgqPom3oQYprCsia9O4qgIzHMQYE+AUg86+WiaIRhuZ28Nqoz/tCMZJqoOHq6yxlX+Jbg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c6:b0:424:64c:5b5d with SMTP id
 e9e14a558f8ab-425955d4c9dmr206575075ab.13.1759052502727; Sun, 28 Sep 2025
 02:41:42 -0700 (PDT)
Date: Sun, 28 Sep 2025 02:41:42 -0700
In-Reply-To: <68b95f81.a00a0220.eb3d.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d902d6.050a0220.25d7ab.04ee.GAE@google.com>
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


