Return-Path: <linux-kernel+bounces-834849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B9BBA5A34
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F2D7B061B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73AC2BEFF1;
	Sat, 27 Sep 2025 07:25:49 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EEB1E00B4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758957949; cv=none; b=QFFP4ujUODFWYkTdlWhkC1xJYogntPB9lC9LvBRAaFqzaC48FldnXPChAfSHOWLNqB1VkesrIh2ky2f7OOLjNMNXKuQUCRE927CRdqBcTiEnzqP+AENTJWksOsB8+1vRYyGwB/Wb6qUGLQL2/Ruy6ky9h+TPW0cspKVwlSbILP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758957949; c=relaxed/simple;
	bh=br1AXxuf0ukMM0/gUVqgxoAWvp5U6HATMgfURsfCQPo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uEqUAKhk8aEznE9OzecbRMWInLk1wk5idNFJtZQwK4oqLOVd6qVfuo7Lwu/0URrqxG+T/R7qWac9oRCHOTAfV7mFB7yO+dMPUW2IaSar0B1M1I1bM4j0fkSYYoTPpEQYoH+pGO7WitLTf6uByzVnJ/ZsTAJPRJFrXNM8WunmOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4284df6ceaaso21640755ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758957947; x=1759562747;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzNUm0jNRb41uy9spNZn9WJOUu/At/q9X3J8y6QUK48=;
        b=Thf3KC8udYST2esLJEzt6wTCOtnLgCHU8hn0YpVXWVRKNJ5Wdfun97Yok/KhNdM+Qg
         pZz5MFozy/XafyTuGdif/u2hHbHrTi8FXJlx1rEtUqapuY5XvpefXtwXHNGC8t3b4eQG
         DG0E8pTLyk4N40QdaUhISkhvL4WxlYIfJiwBRtaGmUgiYVo1ak1JNzcBicf3W29bTFW5
         9ZS0q8YrBNJ+2tVpInvbjs761xsNvSsoRJ2mDWYb9J2pWvSa+1kHKuXcnqzfzXC+PH87
         O8wmPdgPiyh0JSbD4RaFd0qjZupUPECZ/Ch2tKhIqmt0FUjb9oDolYKVAyYDI6Pd+ZJb
         3v/w==
X-Gm-Message-State: AOJu0YwAuiEKwQCSMkkPgjBR3gI2FYwv2jJKS0ZCSt68er4mvogQEfxE
	gdnzNIfYNMYnXE3DnNveP/yx2U16um85nd4CSBbzDgy92W1/nVxw6IXzq7cp8j1zfOjmsjEVnKM
	SQhVzZKpbLx03xa8vNjytdezaIfbBeYa/4cRtGzYOwbeb9Z7937wRPtOBNb4=
X-Google-Smtp-Source: AGHT+IERo0f88sGK7j2tGZCpE1gXSEtP6l1W7UVDiUHPH+15GRkZNVj0iZvQ2MfyUg/nboAJ0YPsTInXudHQYqzw9EhSvBoaGBzx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:278a:b0:427:a3ef:5701 with SMTP id
 e9e14a558f8ab-427a3ef581emr66529715ab.14.1758957947154; Sat, 27 Sep 2025
 00:25:47 -0700 (PDT)
Date: Sat, 27 Sep 2025 00:25:47 -0700
In-Reply-To: <68cb3c24.050a0220.50883.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d7917b.a00a0220.102ee.0011.GAE@google.com>
Subject: Forwarded: [PATCH] bcachefs: Fix deadlocks between fallocate and readahead
From: syzbot <syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] bcachefs: Fix deadlocks between fallocate and readahead
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


There are ABBA deadlocks between fallocate and readahead operations
at two locations in __bchfs_fallocate():

Thread 1 (fallocate):
  bch2_fallocate_dispatch
    inode_lock(&inode->v)
    bch2_pagecache_block_get(inode)  // Acquires two_state_lock
      __bchfs_fallocate
        bch2_clamp_data_hole (or bch2_mark_pagecache_reserved)
          bch2_seek_pagecache_hole
            __filemap_get_folio
              folio_lock()  // BLOCKS - Thread 2 holds it

Thread 2 (readahead via copy_file_range):
  bch2_readahead
    folio_lock()  // Holds page lock
    __bch2_two_state_lock(&pagecache_lock)  // BLOCKS - Thread 1 holds it

The issue is that drop_locks_do() only releases btree transaction locks,
but Thread 2 is blocked waiting for the two_state_lock (pagecache_block)
held by bch2_pagecache_block_get().

Fix by explicitly releasing and re-acquiring the pagecache_block lock
around both blocking operations (bch2_clamp_data_hole and
bch2_mark_pagecache_reserved), following the same pattern used in
bch2_page_fault(). Force a transaction restart after lock release to
ensure consistency.

Reported-by: syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=cb91f22d8a581fc19edf
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/bcachefs/fs-io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index a233f45875e9..66a60e5f03fc 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -694,13 +694,19 @@ static noinline int __bchfs_fallocate(struct bch_inode_info *inode, int mode,
 						 &hole_start,
 						 &hole_end,
 						 opts.data_replicas, true)) {
+				/* Release pagecache_block to prevent deadlock with readahead */
+				bch2_pagecache_block_put(inode);
 				ret = drop_locks_do(trans,
 					(bch2_clamp_data_hole(&inode->v,
 							      &hole_start,
 							      &hole_end,
 							      opts.data_replicas, false), 0));
+				bch2_pagecache_block_get(inode);
 				if (ret)
 					goto bkey_err;
+				/* Force transaction restart to revalidate state */
+				ret = -BCH_ERR_transaction_restart;
+				goto bkey_err;
 			}
 			bch2_btree_iter_set_pos(trans, &iter, POS(iter.pos.inode, hole_start));
 
@@ -730,11 +736,17 @@ static noinline int __bchfs_fallocate(struct bch_inode_info *inode, int mode,
 
 		if (bch2_mark_pagecache_reserved(inode, &hole_start,
 						 iter.pos.offset, true)) {
+			/* Release pagecache_block to prevent deadlock */
+			bch2_pagecache_block_put(inode);
+
 			ret = drop_locks_do(trans,
 				bch2_mark_pagecache_reserved(inode, &hole_start,
 							     iter.pos.offset, false));
+			bch2_pagecache_block_get(inode);
 			if (ret)
 				goto bkey_err;
+			ret = -BCH_ERR_transaction_restart;
+			goto bkey_err;
 		}
 bkey_err:
 		bch2_quota_reservation_put(c, inode, &quota_res);
-- 
2.43.0


