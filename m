Return-Path: <linux-kernel+bounces-834848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF487BA5A31
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E191631E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA27F2BEC30;
	Sat, 27 Sep 2025 07:25:49 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20BA1DC985
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758957949; cv=none; b=dnM3Mui8n/4vzY+jfHp7NabB/mXREIPPEQ7NZ5JPn1SqK8TxU8V9yUn/HRwl+6Eoa8AkMkBnBS7vjRKr3GH0fHs16R5KQTuk0DyJdyeC8EDCwBOnV2ATWS7KWNaZ1BzSQodyTYPABDLc2Xncu59qYlgEzw/KgNrzeudFP6mdkGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758957949; c=relaxed/simple;
	bh=br1AXxuf0ukMM0/gUVqgxoAWvp5U6HATMgfURsfCQPo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W9PH03TFBRv0uz3tT0KS5VkNjJLhHtYpH1MudThfn8jXrgrCYricW8H087So98Tb0A0lhWl9hwTbOV3yjf3W7FVuHdqT/gipFpM1Hmg0hQ4Nexz3eGCdcjfmvlU+c2Ior91yn7vJOVViHhBMjX0jODF9LYHbB48OXg15gGgCpTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42955823202so111815ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758957947; x=1759562747;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzNUm0jNRb41uy9spNZn9WJOUu/At/q9X3J8y6QUK48=;
        b=gV4YbVtjrFir5+ohFtfI33eH8T9JJ+Aih4v4iBAeJ5ocmIdn5FGy+8XmfaDI9gDyIQ
         3828D86t+RUs/sH25rfl5fCW0B52xPPeFC7irVmX4Hg9g2BlGTPDtjZ1BbnHtRXLHULN
         MYd2maxDV3LVGLRnTlwlnL8sZArQ4/YHyOYefVht0HQAKDLPNY/vSOAz6ilK/GOHP+1Y
         PYXllkdWrPIQn8UFsqIpzMQaSWKcHBufBB74pSbfN37a9JAQCsgaZ8LOivKvdPzIhhZy
         W1kjmGu20zSSXULbUM5iIxjEJO0VseA505nSzjX5sVWG3jP/t+LeX42tprl40j0Amhyh
         j6eQ==
X-Gm-Message-State: AOJu0Yw21ZOiXgFUnnsqC8DwSOnjMD0nPp5cpt/ePFRTwyHEhhfEvbzB
	qQEcS4Kv0GLjQOuFSC4GL4bW2t5apzcznL5fC0Pp/gMKEw9OCYlGn3v2teU4o4mfOgIZ9wM/rB6
	PPnaflveqtZTuK6ot+dZfklh8NOELXRrvyLO6oWaQ1yKystDzRTE+U6JYUGs=
X-Google-Smtp-Source: AGHT+IHH+9aBLsSd1lgHHCMKjQJc2+0yoHGe3B0MhNHhtiATfyfin1K3hRdMBdpIVDyO4vKJ7XEvHyX9Olne+Yknc6viuJ7FsNPf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd89:0:b0:423:f113:749d with SMTP id
 e9e14a558f8ab-425c18ba836mr115138405ab.4.1758957946969; Sat, 27 Sep 2025
 00:25:46 -0700 (PDT)
Date: Sat, 27 Sep 2025 00:25:46 -0700
In-Reply-To: <68cb3c24.050a0220.50883.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d7917a.a00a0220.102ee.0010.GAE@google.com>
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


