Return-Path: <linux-kernel+bounces-834842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FF9BA5A00
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5821BC49A3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D858284681;
	Sat, 27 Sep 2025 06:54:01 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13D1F4C90
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758956041; cv=none; b=A+mWQJG2lCwmWXfjPcTP5hnWbCR0ThbbC66YnLWTbCc9olMROfmqzW2+b10Oojes+iySYoOntIiov2yj/2Eb8anTbE5twek044o8PwkNbPagkhdWQJPabTpoaZV2ndEgxg3RsmaUGOSFeTirLwgKIOlU3cAWwUo34fQD90n77g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758956041; c=relaxed/simple;
	bh=ews0uAJF2afggW2uR8BzxRbCOlYY1Dqq2Yas/R7b+yo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sXGYQeOmvPpMU+d96arxF/OnjftxRXX6s3BvBD+vhLJg1ugNK7FmDn+/4+MczdqwQpOcReHZ4S42XhzjKID0mSsODKlhfwXp/z+owga1iV7f2DgwS1yHGBaqn4HnRAeSvYFK8aA/eP01D/Oiw0AW/hKLy0Zds0HHQGP/yahS2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-886e347d2afso315433339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758956037; x=1759560837;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYMFv8mT20Sxv6aWto+iww88GaWMZtF+DLGFAgx4DoE=;
        b=qDhmmMIXyysMCVzrVNvxCmnnqypOepmSDO+86+6Y4idVyWpTJdrewFEPTSYCWMWRb2
         f07Iry3rNYU4yEfZYyJn/mEKI5CB88LULcXyK1hDOlGnq+pPS/KNQJX6M//I54zEKRgh
         jaDaMKpcweUq6pI6cTl22Yk8h4iX2z2P1miyzNbqy7S2qFWkm6nLS00KY9w4wYlsGFBg
         DlIJnSFMrue/qCwEFzzgYOHLxytW1g/q6xKpoN7oVdbj5kEcj7HqgFl8wGuEk2vxwQUR
         4bqj0hJduX+zeMvNOycW5GYASPWJZgGdBcgL6CDf3NFyPKKth25XpLO191D+/La0JrJN
         f1Fg==
X-Gm-Message-State: AOJu0YwMZPWrzBzWlwaM9aK9p37S2vOFs8gAuN18T4RX8lETmRzL/DjD
	/twzl1BUH8iLYm11PjXjzxDvMd5YOkxtb3vq2zAUPDKwsxo3gQtDimv9jAiwqLiMKtApJMeJrMV
	IMpKJCMMwva0EmIyGdsqjXYnHyE7dIYoW7b40DVQrJ3H3lSq9EJuRD5+2hxI=
X-Google-Smtp-Source: AGHT+IF3Bdn2G7v4qYrTL1q0h5ilPbphsa3JYMoyO3r2EFr2V7vAYhslAHLvMqfEFvrUK3ZXAut61EyvevYFrNNGr1OWFAAduEyE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2199:b0:427:db3e:bc10 with SMTP id
 e9e14a558f8ab-427db3ebe4emr47842395ab.0.1758956037532; Fri, 26 Sep 2025
 23:53:57 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:53:57 -0700
In-Reply-To: <68cb3c24.050a0220.50883.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d78a05.050a0220.25d7ab.0286.GAE@google.com>
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


