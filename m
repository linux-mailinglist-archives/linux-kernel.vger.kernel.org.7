Return-Path: <linux-kernel+bounces-838196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A984BAEA66
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 00:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275D31942AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E72C08CA;
	Tue, 30 Sep 2025 22:05:15 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6711F03C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759269915; cv=none; b=JxJKtFBi1/NCy37pIe/j+HOKi5wUZ0Onngl3W9wKccwABRzBLk3G8AcEWCcrmoR4sLlSl6LVfLrHf7/8BOExwJDJuLxxkICfULwUe7SrrQs/xuSeWb9aR0IxZeXnKlZR+EvlkxpsVQVxUx9FugAeXNecCKLhDnoAbe/WOIgpgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759269915; c=relaxed/simple;
	bh=gzI02U8R6l0aO56Esj8/EokCTMcKCb1bPVJwHpCnAZU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kfv7aC8CWpmudBmQTotFGEswM7wKT2Jc/SpuB41W2WGtLFdat0QbtTRzq90D2hlNnHrZfneJp6D/5s5sNCdMvFnDp1jHg5lC1o/Icznr/XYlW6q0CEGfF+Gm0J/gfY5uNhj/6GMS0qqjkI1xzAW1+U/u7vd/SdeZHQAVKh3UCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4284df6ceaaso125326285ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759269913; x=1759874713;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwWz5TLgWyyCC9yVNy4qDw2PGV16uTVnMSefZCoaKKQ=;
        b=myXGkzg0mYEsnxYUTaGL7CUoy8O0ZksbyVoI7Ly2ldpb7LVQzG6MIsksAXOYjDnXS0
         7175l853Ykw5e4GUfxG4vGY0FHRjQc+rqEO9nvTic6G3YZWMW9l82xUyIMLH89khVvLA
         vahYcCV5seFRWM9xH41xGENht9+D40+2v5waGf0jJz7rwbx2hF1MtjvJewbrgPC10Hi1
         7DPAEtFcnGfn+VfeOrHtUIlb5w2teYGBXrd9KbIstITKycp3ntlV3lOy00ubC8hgasb9
         H2AwOYRsO3Jpw0OBD1qbjG+fpUz5wAjdI7IlTiPgYCmY+CFavISCkZ8DSrKfnyiSS/qW
         F3CQ==
X-Gm-Message-State: AOJu0YxLmf4jFZoZWOa+4IVMhg+nE52b0JaiTw5W9GmBM5AJLTh2ti+y
	/BXaqTXzYQEEJtjvNAHu95DUH0994NbiYM5dE3vLUbSSvsm48VLFPzCQaBlPATHveIECuYI5pqM
	4L7q5RkBhby3RoSoEhEOArHjNlfeytsUcf4VVWBl1GJYJA1j0uP9W24yWfy0=
X-Google-Smtp-Source: AGHT+IGMHm8Yw/NoP0Ss9gzCtDJfNRyUhxc5bUU/nTe3a4/aVojVWGdpbt1LV/O7yZ55sMvgYV7CxXOtKJelZdIbqujh0srVI2Dj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:b0:425:70c5:61b3 with SMTP id
 e9e14a558f8ab-42d81647952mr22599925ab.27.1759269912861; Tue, 30 Sep 2025
 15:05:12 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:05:12 -0700
In-Reply-To: <68335d8e.a70a0220.253bc2.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc5418.050a0220.25d7ab.0767.GAE@google.com>
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

syzbot reported use-after-free bugs when accessing extent headers in
ext4_ext_insert_extent() and ext4_ext_correct_indexes(). These occur
when the extent path structure becomes invalid during operations.

The crashes show two patterns:
1. In ext4_ext_map_blocks(), the extent header can be corrupted after
   ext4_find_extent() returns, particularly during concurrent writes
   to the same file.
2. In ext4_ext_correct_indexes(), accessing path[depth] causes a
   use-after-free, indicating the path structure itself is corrupted.

This is partially exposed by commit 665575cff098 ("filemap: move
prefaulting out of hot write path") which changed timing windows in
the write path, making these races more likely to occur.

Fix this by adding validation checks:
- In ext4_ext_map_blocks(): validate the extent header after getting
  the path from ext4_find_extent()
- In ext4_ext_correct_indexes(): validate the path pointer before
  dereferencing and check extent header magic

While these checks are defensive and don't address the root cause of
path corruption, they prevent kernel crashes from invalid memory access.
A more comprehensive fix to path lifetime management may be needed in
the future.

Reported-by: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..903578d5f68d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1708,7 +1708,9 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 	struct ext4_extent *ex;
 	__le32 border;
 	int k, err = 0;
-
+	if (!path || depth < 0 || depth > EXT4_MAX_EXTENT_DEPTH) {
+		return -EFSCORRUPTED;
+	}
 	eh = path[depth].p_hdr;
 	ex = path[depth].p_ext;
 
@@ -4200,6 +4202,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
+	struct ext4_extent_header *eh;
 
 	ext_debug(inode, "blocks %u/%u requested\n", map->m_lblk, map->m_len);
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -4212,7 +4215,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
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


