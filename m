Return-Path: <linux-kernel+bounces-871491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FBC0D6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2863F4EAE6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6213002BD;
	Mon, 27 Oct 2025 12:13:37 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCC2E5412
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567217; cv=none; b=bbyV81tsbwWh7bmpWEkQUWB3OWl2Iib0wQ+A0I621h9njigeEVa2rTyDe1MvSir9fKhTNuNxpjo/OQ/+CGwkkxyRJqIg3/oZnWEW1Me9ujnKJp4JKrtWd0W7ywB4jq6OBRPkGox6jZ0VN6GJrSbrEoMiEfCyVy4whVNBAuUYkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567217; c=relaxed/simple;
	bh=L0+0JAAo2osHAZw5j1mf394gD80poYYTvd3RIyhk7Nw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SIxceKjIibW8Zj6aob6s/LzPw09SEmPkpcFef8t//1H5bsPmJ7MPfHxeu5D+dIG+SaLmz/QqRyc/49oOUhB5XgLpFz3I7J6lV4uAKJkvR9d2/EDdymFCa/EJEgusE/T2y/jLFhpDOTf35CUtLnTW9yhpQYP5Q+TRUe6EaJILbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so176203865ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567214; x=1762172014;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOpw1oIGSA54cfCdEjOoY0t6/NnZkLADdkVfFEUQgPs=;
        b=U10w0rfsyhcoVyqTdLQcqaXcVJYTc7HsAcE7wT/KJP6MIsiG6Gj5Vc6ZlcTsiZG+Kj
         5Gv2y7Ao8nvF+ALEoH3WARCmKfqtO9DBaUjHIS9fK+xBXdOY68Xvk+X+QNeDRaxpXxTf
         h3E6Z0Ie0dHs4xyA3o9Jt+4dO/tPyUdjXcBJR34EtezTo0vHPUiO4KCMBy6UWUeOr1ev
         M/80+kP4QmtP8azFWjBtMPQeigVGmzcLHdHPDDqJGJe46/k1mZ1IhbUgUw1YcAdwNnOV
         HR+WnjlibRRg2RRc//00leB0Oi8uuIEE/YkhtFZzET/C8o6PsN5ku/wIWIo/Ijf5ZD99
         hOEg==
X-Gm-Message-State: AOJu0YzTgP80TgUnuJoGo03ZBffrRn6Ic5HNiLRbIwwNbEcFYwqJ0BA7
	yNoyk0Xm293c8HRiAIfL7hUM1L+IqCQip27ZNBb1/v588rpYenzNu5aW8e6i9jT3B8iSzGQJjHz
	ZUkqRTj8P/18jbJ5zbCH0iK8qydRrDUDUMyTLxkAZY1ESosIxsrxbWrSENwE=
X-Google-Smtp-Source: AGHT+IHudxGFlEks5njQmDPCei8o0hpwo/JQBNp5Dhx7BqtDzBt3N5t7GqoFvLNAELA4KXQYYy9LyPj3VnSjiKlQa1Kjskf7PlwI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:430:c477:fce2 with SMTP id
 e9e14a558f8ab-431dc13b541mr173428825ab.1.1761567214607; Mon, 27 Oct 2025
 05:13:34 -0700 (PDT)
Date: Mon, 27 Oct 2025 05:13:34 -0700
In-Reply-To: <68f4abbe.050a0220.1186a4.052a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff61ee.050a0220.3344a1.038e.GAE@google.com>
Subject: Forwarded: [PATCH v2] ocfs2: validate cl_bpc in allocator inodes to
 prevent divide-by-zero
From: syzbot <syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v2] ocfs2: validate cl_bpc in allocator inodes to prevent divide-by-zero
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

This patch adds validation in ocfs2_validate_inode_block() to ensure cl_bpc
matches the expected value calculated from the superblock's cluster size
and block size for chain allocator inodes (identified by OCFS2_CHAIN_FL).

Moving the validation to inode validation time (rather than allocation time)
has several benefits:
- Validates once when the inode is read, rather than on every allocation
- Protects all code paths that use cl_bpc (allocation, resize, etc.)
- Follows the existing pattern of inode validation in OCFS2
- Centralizes validation logic

The validation catches both:
- Zero values that cause divide-by-zero crashes
- Non-zero but incorrect values indicating filesystem corruption or
  mismatched filesystem geometry

With this fix, mounting a corrupted filesystem produces:
  OCFS2: ERROR (device loop0): ocfs2_validate_inode_block: Inode 74
         has corrupted cl_bpc: ondisk=0 expected=16

Instead of a kernel crash.

Link: https://lore.kernel.org/ocfs2-devel/20251026132625.12348-1-kartikey406@gmail.com/T/#u [v1]
Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Moved validation from ocfs2_block_group_alloc() to ocfs2_validate_inode_block()
  as suggested by Joseph Qi to benefit all code paths
- Added OCFS2_CHAIN_FL check to only validate chain allocator inodes
- Updated commit message to reflect the new location
---
 fs/ocfs2/inode.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..1b30bf336961 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1502,7 +1502,22 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 				 le16_to_cpu(di->i_suballoc_slot));
 		goto bail;
 	}
-
+	/* Validate cl_bpc for chain allocator inodes */
+	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
+		struct ocfs2_super *osb = OCFS2_SB(sb);
+		struct ocfs2_chain_list *cl = &di->id2.i_chain;
+		u16 cl_bpc = le16_to_cpu(cl->cl_bpc);
+		u16 expected_bpc = 1 << (osb->s_clustersize_bits -
+					 sb->s_blocksize_bits);
+
+		if (cl_bpc != expected_bpc) {
+			rc = ocfs2_error(sb,
+				"Inode %llu has corrupted cl_bpc: ondisk=%u expected=%u\n",
+				(unsigned long long)bh->b_blocknr,
+				cl_bpc, expected_bpc);
+			goto bail;
+		}
+	}
 	rc = 0;
 
 bail:
-- 
2.43.0


