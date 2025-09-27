Return-Path: <linux-kernel+bounces-834841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F47BA59FD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818171BC4782
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469DF27990D;
	Sat, 27 Sep 2025 06:54:00 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697411FF1C4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758956039; cv=none; b=IC3l4n2SZDb1czYp1urIRQYBh2Pz/yuDF8fEx3U6YIVD1NMmdoVXvVXV7FIezIGGdA8S9LCthQeU9lE6PulswCecQWsbQItejPEG1ubWp6Fm/6n+ncidS1cS4R6zb3KV7EkaZ3ly8wQ78i7BS5ywbYXfjFDYJK1O3ymmKdk+u9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758956039; c=relaxed/simple;
	bh=ews0uAJF2afggW2uR8BzxRbCOlYY1Dqq2Yas/R7b+yo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FbzC9UlEfYfSslfK9HProwcCxfkbpPBVrF6QcsJNuUt6jMSTm+3vjGAfFpKYrixkYWHM96sEW+kj4UmcniGVVEb0MdFdf98vpFmNzwjQhj+CT8ccfSYfMY/IVq9BwEOnUZ99ySqG8AyIUvMRTYNTE2wpP+fFVSOVrmbOtke39YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8a1e8c45f59so328156739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758956037; x=1759560837;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYMFv8mT20Sxv6aWto+iww88GaWMZtF+DLGFAgx4DoE=;
        b=KTYFMbjAUggTE0dnlznGNE4ZkckFqhF/E1A4+hLMy6XBKz2s4kYUh0wEbnw7otj6jc
         RY3/AlDGSLEx8xGw4G3285nAyTgseRj+J8ERHNk1acDGV/5TQUJwpi+Gw8TaMw0ALfR1
         SXC2llkPeKVnDsE+A3YZPi7t/qRH2zgFYcfwJYaTFY0c2Wh0QCYw26XiaQrmi/56vzKA
         EiAk+AsyE4+xLA/0JS3jou0wufrn6IPY4KXLKeXdwJ0DhhLXR4cI3PlGg8o7Kkv/C+GS
         +cb2odQ8IgmUNNU4lieP3R+GUbE/2SvAbzp2V3O+AmubxOLSFV+zqFX2F1eHKwKpq8OJ
         vNKg==
X-Gm-Message-State: AOJu0YxAPuBu0KJm9jkxTpYoOHf+2EKPS1ES6QWI1LW7VQbD4Vmx0az0
	3oSUDfBtFFr7xZ3vQ0eIjlsE0+jLURnuTv02l4WlIvoKhE+NiMPqBFEFRwEXkICx/PpiJBxGF1H
	GfGqq3c8CXTqkSKd5N4zEG11Bj2WO4/9H+yThsY7D+keLPdCqFdKfk3vg/5M=
X-Google-Smtp-Source: AGHT+IF3tz84L7pPezDSPY45lYJ6NPcIai4xvUtFgwbCEEtmUO76mj5DFNHsBYSuqO7r2dXiWVBUeqUl+Pzpf9vSL2KehYv4lxRk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a04:b0:426:3ab1:74bd with SMTP id
 e9e14a558f8ab-4263ab17a1fmr120261515ab.18.1758956037672; Fri, 26 Sep 2025
 23:53:57 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:53:57 -0700
In-Reply-To: <68cb3c24.050a0220.50883.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d78a05.a70a0220.10c4b.000c.GAE@google.com>
Subject: Forwarded: [PATCH] bcachefs: Fix deadlock between fallocate and readahead
From: syzbot <syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] bcachefs: Fix deadlock between fallocate and readahead
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

There is an ABBA deadlock between fallocate and readahead operations:

Thread 1 (fallocate):
  bch2_fallocate_dispatch
    inode_lock(&inode->v)
    bch2_pagecache_block_get(inode)  // Acquires two_state_lock
      __bchfs_fallocate
        bch2_clamp_data_hole
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
around the blocking bch2_clamp_data_hole() call, following the same
pattern used in bch2_page_fault(). Force a transaction restart after
lock release to ensure consistency.

Reported-by: syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=cb91f22d8a581fc19edf
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/bcachefs/fs-io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index a233f45875e9..04f76d141b17 100644
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
 
-- 
2.43.0


