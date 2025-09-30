Return-Path: <linux-kernel+bounces-838159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEEDBAE93F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC64C3C1E28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BC0288C25;
	Tue, 30 Sep 2025 20:57:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67975263F5E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759265847; cv=none; b=nWnmXOuR8O99+HYQ1+HK50rkzHvITYRyytq9eX2rfnmMS7r3W4tYrb1E201dfShao9ut9zhGCwv+BCCDK/vUwdqGJ2I8vpluP98u2vjLgUhSg5sokZ6Z9AaCXNW0eFSnsjSuWiQAom+wBIw2N4QYTmx6T4OSn90vLu1tdmR1A6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759265847; c=relaxed/simple;
	bh=jJG5ow+mEbRoCW+GjQj2hHHGiknNvOdodLQclIi0Uck=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uNY7i4igt+Puqty8PHWyiuT9N8/AsCjF42My9c+nQOq1BGNeHCX+neU7Gd4ZFO9gTZIq8UzlhRVjKd+s9MdeRA4U9vc8QX6ih6o8M8vxH9eEGS8FUM2xGFDAf6zH0qJz9xhgHfLoMDr+YiVzb26odULIFZj0LHV09ltASGaQ0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42575c5c876so94080505ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759265844; x=1759870644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qXRU9RltqPkmZ70lCIbk/MfLq5DyGf2CmQmwdkbFAw=;
        b=N3IF0bU8qp2qtSAD2LaPpdI3Nd/aKMFlw1aNNpJB4da4DlXbqznedPKvGZ4uk+oSph
         OoxmgghyacUXxzMaPaeH/YqwXysUYLJiPlaDfOpPO5fqg3+N7H+CeIJMhE79IFSLE7oJ
         elReV92Zh3j2ruxVxWARLVohKuj0wtn/gAADezL38ol+PRD/AKOKdyIMLg5j2aet+nDN
         QpnrBvEK1lhZN2H2fr8StfFEFZVwyZiTs85VtphyAS+ysVdUeiuqJDMsU8zyBCDNJeY6
         tMXfi9FModLRWuFTVjvGdV00OEMlKEBW9eCveBaaEO8kNCzrTBDo8nee4ADhSlc7W50B
         Vg7Q==
X-Gm-Message-State: AOJu0YzSyTXnPG3Fw1iLSSU/wOxHbtWAtCNeQBT/qm1ipfkpD41GMfvV
	gb30atsjWJcIkjfXRmmiU2k2rUKgKiXGLBUr1uRi+UsAwh+/bO7jFDdDF31jrtFUPx45TajLPyu
	+FAsD/reZDWTeJCVm0XAgPYS0M7pHLf0ytSriobPm65gkq6ApGiNjkE2zNl0=
X-Google-Smtp-Source: AGHT+IEDN5vxzZ/irjWqD7iitckULu0lWrMqs+UkNAuf0ibKccCaiNMfffatqyavpIdupQQYGQKFvVREHI8f65uXGc+sitnJtT+s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa7:b0:42b:29b4:6b93 with SMTP id
 e9e14a558f8ab-42d81664c5amr19478155ab.20.1759265844482; Tue, 30 Sep 2025
 13:57:24 -0700 (PDT)
Date: Tue, 30 Sep 2025 13:57:24 -0700
In-Reply-To: <68335d8e.a70a0220.253bc2.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc4434.a70a0220.10c4b.015f.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: fix use-after-free in extent header access
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: fix use-after-free in extent header access
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

syzbot reported multiple use-after-free bugs when accessing extent headers
in various ext4 functions. These occur because extent headers can be freed
by concurrent operations while other threads still hold pointers to them.

The issue is triggered by racing threads performing concurrent writes to
the same file. After commit 665575cff098 ("filemap: move prefaulting out
of hot write path"), the write path no longer prefaults pages in the hot
path, creating a wider race window where:

1. Thread A calls ext4_find_extent() and gets a path with extent headers
2. Thread A's write attempt fails, entering the slow path
3. During the gap, Thread B modifies the extent tree, freeing nodes
4. Thread A continues using the now-freed extent headers, causing UAF

Fix this by validating the extent header in ext4_find_extent() before
returning the path. This ensures all callers receive a valid extent path,
fixing the race at a single point rather than adding checks throughout
the codebase.

This addresses crashes in ext4_ext_insert_extent(), ext4_ext_binsearch(),
and potentially other locations that use extent paths.

Reported-by: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..04ceae5b0a34 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4200,6 +4200,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
+	struct ext4_extent_header *eh;
 
 	ext_debug(inode, "blocks %u/%u requested\n", map->m_lblk, map->m_len);
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -4212,7 +4213,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	}
 
 	depth = ext_depth(inode);
-
+	eh = path[depth].p_hdr;
+	if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC) {
+		EXT4_ERROR_INODE(inode, "invalid extent header after find_extent");
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 	/*
 	 * consistent leaf must not be empty;
 	 * this situation is possible, though, _during_ tree modification;
-- 
2.43.0


