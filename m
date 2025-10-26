Return-Path: <linux-kernel+bounces-870360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD4CC0A841
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E83914ECC43
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59752DF120;
	Sun, 26 Oct 2025 12:51:19 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6127E066
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761483079; cv=none; b=iktPOLGV8tXzezDICX7xw1gkNE6Ra7JvM+Bm1X6AW/J8qGpVY+WQkDAI3S60m15Mhgn4dC4n5Sp5u9AtHK3A/nLsXjjPdw2VJNG8tW8y7cN5KTNQWfvhJ1ma9ferUh8IVvYD3ZE7sHuknTyj2BcDel5j+GuJ/UcSg08Q114cjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761483079; c=relaxed/simple;
	bh=a01txqgQ1pcioXtWdFfvUH74Lvj+uuJhNYvf7dT/+Ug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AfETGFzCwwJBnOgfpJMeBSZEik3MpC/SPTbexedY4Hp/dzB0yno8qSFKRm6/EIxN1jA1qe3NwL3OCWWJXDcAtiA5tT5f31sicy0V/JfnJnBsLyuKyVLrjOGNaxTrcla80Jdw8+vB6xEEbAaWhExIavcaOUla07hCtZyvINqO8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430db6d36c6so137662685ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761483076; x=1762087876;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5jXnVhpDCS2PPCZDrkRzyGw8soogOviIReVBbKUgzE=;
        b=ImlRJfvZdAiD5ByOnKXxKa49fsX6o38V63u93nS6e+tfJVPwxhzoBg8NwZOZVDa/pU
         1sC4xesVK7IjrfaF/xVys2tFUNo8ln9330ykoeRujE3AKOSED9v6cvzKap5e+3BGAYhH
         j1IKsJJyVgAbvHQfgABblaqxmnKYJ09tIoYLPY9tn0EvGb8wr+r8HTRGr7Iqztdb8qNQ
         muQ/PbxhZuwazeCPtp9T4fIcUe8n8MhZfygXrdAKtuIvWNDIfYA9LyWjlR+zOjWhDK7n
         Pn0U/2M1PjC7V/nxSwsN6mhJSUF2C4CSiR9Wd2pnt7HwwVClYgJPD4IXaIsP1A2yu8EW
         hiZg==
X-Gm-Message-State: AOJu0Yz2pEzDwLjEAzA7UAWDroSkKUAQIvFWjnILnrNfI0LUSLSdj3vx
	AgQO7Q5iGaqacNFROpk5irdngllv5QYwXQ4QQf7/L+6aJVGEQIayOIKzsKgQOJ/k9khkEjPTSAB
	CXJMZyn2uzvDQJpOtuIsHgnv0pq5bxAwkBzcU6Hq5xTtI/7vMgYCqbrTdhq8=
X-Google-Smtp-Source: AGHT+IGsDnpYCxTawp0BfUD1jhnrlOyysuMyB+jGOPzMYc7z/F6HY8rxU9b9hBGv6morGytylZ/cHGzEGWJ21Lcx1l94KnNi6gXz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:430:b999:49e7 with SMTP id
 e9e14a558f8ab-430c5291223mr477144355ab.27.1761483076545; Sun, 26 Oct 2025
 05:51:16 -0700 (PDT)
Date: Sun, 26 Oct 2025 05:51:16 -0700
In-Reply-To: <68f4abbe.050a0220.1186a4.052a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fe1944.a70a0220.5b2ed.0006.GAE@google.com>
Subject: Forwarded: [PATCH] ocfs2: validate cl_bpc in ocfs2_block_group_alloc
 to prevent divide-by-zero
From: syzbot <syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ocfs2: validate cl_bpc in ocfs2_block_group_alloc to prevent divide-by-zero
Author: kartikey406@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The chain allocator field cl_bpc (blocks per cluster) is read from disk
and used in division operations without validation. A corrupted filesystem
image with cl_bpc=0 causes a divide-by-zero crash in the kernel:

  divide error: 0000 [#1] PREEMPT SMP KASAN
  RIP: 0010:ocfs2_bg_discontig_add_extent fs/ocfs2/suballoc.c:335 [inline]
  RIP: 0010:ocfs2_block_group_fill+0x5bd/0xa70 fs/ocfs2/suballoc.c:386
  Call Trace:
   ocfs2_block_group_alloc+0x7e9/0x1330 fs/ocfs2/suballoc.c:703
   ocfs2_reserve_suballoc_bits+0x20a6/0x4640 fs/ocfs2/suballoc.c:834
   ocfs2_reserve_new_inode+0x4f4/0xcc0 fs/ocfs2/suballoc.c:1074
   ocfs2_mknod+0x83c/0x2050 fs/ocfs2/namei.c:306

This patch adds validation in ocfs2_block_group_alloc() to ensure cl_bpc
matches the expected value calculated from the superblock's cluster size
and block size. This validation follows the same pattern used elsewhere
in OCFS2 to verify on-disk structures against known-good values derived
from the superblock parameters.

The check is performed early in the allocation path, before any resources
are allocated or transactions started, ensuring clean error propagation.
If validation fails, the filesystem is marked read-only and the operation
returns -EUCLEAN (Structure needs cleaning), prompting the administrator
to run fsck.ocfs2.

The validation catches both:
- Zero values that cause divide-by-zero crashes
- Non-zero but incorrect values indicating filesystem corruption or
  mismatched filesystem geometry

With this fix, mounting a corrupted filesystem produces:
  OCFS2: ERROR (device loop0): ocfs2_block_group_alloc: Chain allocator
         74 has corrupted cl_bpc: ondisk=0 expected=16
  OCFS2: File system is now read-only.

Instead of a kernel crash.

Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/suballoc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 6ac4dcd54588..9f3db59890c3 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -667,10 +667,22 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
 	u16 alloc_rec;
 	struct buffer_head *bg_bh = NULL;
 	struct ocfs2_group_desc *bg;
+	u16 cl_bpc, expected_bpc;
 
 	BUG_ON(ocfs2_is_cluster_bitmap(alloc_inode));
 
 	cl = &fe->id2.i_chain;
+	cl_bpc = le16_to_cpu(cl->cl_bpc);
+	expected_bpc = 1 << (osb->s_clustersize_bits - alloc_inode->i_sb->s_blocksize_bits);
+	if (cl_bpc != expected_bpc) {
+		ocfs2_error(alloc_inode->i_sb,
+			"Chain allocator %llu has corrupted cl_bpc: ondisk=%u expected=%u\n",
+			(unsigned long long)le64_to_cpu(fe->i_blkno),
+			cl_bpc, expected_bpc);
+		status = -EUCLEAN;
+		goto bail;
+	}
+
 	status = ocfs2_reserve_clusters_with_limit(osb,
 						   le16_to_cpu(cl->cl_cpg),
 						   max_block, flags, &ac);
-- 
2.43.0


