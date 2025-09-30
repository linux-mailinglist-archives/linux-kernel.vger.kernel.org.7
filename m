Return-Path: <linux-kernel+bounces-838219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E308BAEB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 00:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1734A113B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12025334B;
	Tue, 30 Sep 2025 22:49:41 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5644C81
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759272581; cv=none; b=qdiZjVuFaCIrmEwYsp3maj3D0eKelgdFLXG1vL5PdSkEGK9eDsIPl1Y14Em3soqrqzaZ02cfu7eI2jC0xWa7yaMDlawcUwRDGnYVnpjyssI8NNpYecK9XcFX9x9gBS1WMcC22UiQvAdOchWOSDEo/FOEcwKQhDqQPkyiAO1oc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759272581; c=relaxed/simple;
	bh=reqZM0IFyHzIghHkDo0BotZD9QfKTpnARFndmavpLzQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kDbatWM0fTsMlCNmWI70cA+8m5+ecM8QctSqXjz3NSy/72CoYtukt1/ubwlggYXgLZN8rrT0m01iwNAHERe0N2mg0TU709zUUdBs0x9RNXcyFPVwGGbskD6VQe1qwYsJNZBcgVrCY4wjEslAkJ7G9tID+TjW5GiK3FcXac79XO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42d7e4abc61so14673325ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759272579; x=1759877379;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/FjHfy4kEhH7Sa2g71TzyCgR38aDr5JQUNCbn+Lizg=;
        b=rpzuMmXX7ffL83+/FtBAebcic35koHTDVsljopIuNoVWfqCyLZQ6e8lzxo0dtrlsmW
         7cquCiBDsnLHymZCh6MGcseOIeU6wTRGa5D8Mohzi0IJhyXa6fzkYAPpMNVyWrhGpSUK
         TkZ9G9qQpMI1dYVWmFfj9C6C84crOOxNKZ9le736tqcwE6IUBBzKyWS1bq+eTe0oDiM3
         WYLjd1EYT1NHzZCU8VhA/BGX4yNbJ9EU0uJ2375eC8GzwadaozSRZ00xVzW5MQK5S6+T
         5m0c9alrSPWxDsEoDKiJoJY9sKyCz9w3YNOJkzb7oYdeilQ7tOWI1EQqTLz6PdSb7UzY
         N43g==
X-Gm-Message-State: AOJu0YweBfImDwxadVRYyKlkRJzIYfglTXOW6zaI/J+d3iDse9TvPAV7
	4QSmJLJk7TsF+gxpaxbv+97LzKG7FBGRT85HvK1vz0r4jGh9jAnkZ/8JGFynXqtVJIrN8Xpf8kv
	SsINhadYxiy6wdozVvUb2OBD/AWqLit7e2RaWNpja4q7zuWbkFDxtMVwqZHs=
X-Google-Smtp-Source: AGHT+IEIwgj+wBLJ34AfalS41ceMUDQ9ng0RHwSpLFffHE6VDWTHBqMhA+KHUWQWWzRJoY6h5bYV1NlPBvqzam/JlXjl5hKG0JAJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2309:b0:427:1841:666d with SMTP id
 e9e14a558f8ab-42d8168d2b6mr22426765ab.30.1759272578885; Tue, 30 Sep 2025
 15:49:38 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:49:38 -0700
In-Reply-To: <68335d8e.a70a0220.253bc2.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc5e82.050a0220.25d7ab.0768.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: add defensive checks for extent header corruption
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: add defensive checks for extent header corruption
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

syzbot reported use-after-free bugs when accessing extent headers in
multiple locations. Testing revealed crashes in both ext4_ext_map_blocks()
and ext4_ext_correct_indexes() where extent headers or paths contain
invalid data.

The crashes occur when:
1. In ext4_ext_map_blocks(): After ext4_find_extent() returns, the extent
   header at path[depth] can be corrupted
2. In ext4_ext_correct_indexes(): The path structure itself may be invalid
   when accessed at path[depth]

These issues are more easily triggered after commit 665575cff098 ("filemap:
move prefaulting out of hot write path") which changed timing in write
paths, though the underlying vulnerability appears to be pre-existing.

Add defensive validation checks:
- In ext4_ext_map_blocks(): Validate extent header magic after getting path
- In ext4_ext_correct_indexes(): Check path validity before dereferencing

These checks prevent crashes but don't address the root cause of how
these structures become corrupted. Further investigation is needed for
a complete fix.

Reported-by: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..04d2328ee1d4 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1708,7 +1708,8 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 	struct ext4_extent *ex;
 	__le32 border;
 	int k, err = 0;
-
+	if (!path || depth < 0 || depth > EXT4_MAX_EXTENT_DEPTH)
+		return -EFSCORRUPTED;
 	eh = path[depth].p_hdr;
 	ex = path[depth].p_ext;
 
@@ -4200,19 +4201,26 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
+	struct ext4_extent_header *eh;
 
 	ext_debug(inode, "blocks %u/%u requested\n", map->m_lblk, map->m_len);
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
-
+	depth = ext_depth(inode);
+	if (depth == 0)
+		eh = ext_inode_hdr(inode);
+	else
+		eh = path[depth].p_hdr;
+	if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC) {
+		EXT4_ERROR_INODE(inode, "invalid extent header at depth %d", depth);
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 	/* find extent for this block */
 	path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
 	if (IS_ERR(path)) {
 		err = PTR_ERR(path);
 		goto out;
 	}
-
-	depth = ext_depth(inode);
-
 	/*
 	 * consistent leaf must not be empty;
 	 * this situation is possible, though, _during_ tree modification;
-- 
2.43.0


