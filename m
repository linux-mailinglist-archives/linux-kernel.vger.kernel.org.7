Return-Path: <linux-kernel+bounces-824039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD3B87F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59ADE1BC12AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F22874FF;
	Fri, 19 Sep 2025 06:16:32 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D22459CF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758262592; cv=none; b=K6xsO2uV09WTo2ivf7nBgvjx16KhcVuKyk8dT1umUsHXlVsVC0Otz3lkuCDvhB2AOpEfoYJB7jJeSA8Ib+2XrgEkrt/ucXNGzQCgJR8LarUCXRgl1qD/VjlrJVJA+ZyO5n0FF50/rXoBgRjCNkJfZd/H5NCl28YAFXN+rykCqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758262592; c=relaxed/simple;
	bh=FVSCoZmBsMbTwjJG1txlyxueyo90afB4FZJ0n0sL0vw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cS0HdJ/6uHLpyRN4dVi1A/FmdrsLlJvXZ/JJJ8aJNt13wdUE2qqcJf0BKhOHBix5KQeLQ+VahNk9pbuocI7isjd7L/v8uz2Wh+UG9xES+9rpdti410BcJ1JQbT4i11BOYcLxgvw/Mno4srxfpYl5NvaAWz8uwwqehbJV98dxndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8a1e8c45f59so176030139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758262590; x=1758867390;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWOv3ZaoyR+MrksVj85SUrQm9uQJho1Y7V9AqIxigjU=;
        b=oH1z/TxRrGQy9uLY6J6kj0w0Fdd2n4G8xfZUsWHIBQMqsjRl03OntQ9fm+Skzd7Vok
         AwORFdDU0AhFoZ7MiBwooU6V1UPOZlv66Vjp3jYkMfFGJ36qwpRaFp+6VYhWKGysWaeZ
         kbBwWip6aHRABJbyn0AKX5ZnS/W3HrQ/2LwRi21tm70vnoMrW/mdE8IBq5ZHGcB6MZT5
         EJ2uciL2z3NsdT7l/LO5r/3B4PXu7TEnF5U+0DQOMa42ctuWP/QYNk0QYW/K3aOb+1JJ
         vNH9RVzN3qtVe4hLhPZJefrmYLPDcylivZ/kVYhOEtAMmZggkKxvGsKzzjLQ/aLIFNp3
         9+fw==
X-Forwarded-Encrypted: i=1; AJvYcCVPbsK9v+9Td8UunFuevUJkYmvaxELl/ccTjhBmPMyxf2HK8WLQZT8vErrzPKKVKA6rvhP5HsIDLq7o4Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlsGyH6dVCnzeYbK/7K2xhSQU6C6iS7+Qb0Y10ck362aZ9io8e
	vhDuuOWi5ZEF+yFwkGxQVj1LXVnhPiQ6oHD32IoBIrFHlUoespsZMds6T1EQxYE7ta8lowhYKiL
	M8PS5Nv3Zu3RTiUUYu/z/sjZ7PVfg0fbglch5ztFeQ2HHQNNykIYBnx76w3E=
X-Google-Smtp-Source: AGHT+IEbLRBwDjqr8maWLy/P8pnHjKrbCftlZm3+aY5S+40V5r7oQ2I55wJ3Oi88zne90LJ+2Ljb0mnYm5IqhVvgXcVkwLnW59Ts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378f:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-4248197e1c2mr41069915ab.27.1758262589880; Thu, 18 Sep 2025
 23:16:29 -0700 (PDT)
Date: Thu, 18 Sep 2025 23:16:29 -0700
In-Reply-To: <68bd8fc2.050a0220.192772.01da.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccf53d.050a0220.28a605.001a.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __bch2_trans_get
From: syzbot <syzbot+3a42e4989f9047772c6d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c9d61056440c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14aa6534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b6789b42526d72
dashboard link: https://syzkaller.appspot.com/bug?extid=3a42e4989f9047772c6d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f3e858580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b6c712580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4f571468ab6f/disk-c9d61056.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3871c29d58eb/vmlinux-c9d61056.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbc62ff54c5b/Image-c9d61056.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/257c55ab376d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a42e4989f9047772c6d@syzkaller.appspotmail.com

bcachefs (loop0): /file3 offset 0: data_read_io_err
  u64s 7 type extent 1073741828:24:U32_MAX len 24 ver 0: durability: 1 crc: c_size 24 size 24 offset 0 nonce 0 csum crc32c 0:0  compress none ptr: 0:34:8 gen 0
bcachefs (loop0): /file3 offset 0: data read error: data_read_io_err
bcachefs (loop0): /file3 offset 0: data read error, data_read_io_err
  u64s 7 type extent 1073741828:24:U32_MAX len 24 ver 0: durability: 1 crc: c_size 24 size 24 offset 0 nonce 0 csum crc32c 0:0  compress none ptr: 0:34:8 gen 0
  loop0 io error
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_iter.c:3462!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 14 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Workqueue: events_unbound bch2_rbio_retry
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __bch2_trans_get+0x9ac/0x9d4 fs/bcachefs/btree_iter.c:3460
lr : __bch2_trans_get+0x9ac/0x9d4 fs/bcachefs/btree_iter.c:3460
sp : ffff800097c674a0
x29: ffff800097c674a0 x28: 1fffe0001d620840 x27: ffff0000c1a01e80
x26: dfff800000000000 x25: 0000000000000006 x24: ffff0000db4541d8
x23: 000000000000000e x22: ffff0000eb104200 x21: 0000000000000025
x20: ffff0000eb100000 x19: ffff0000d2510000 x18: 00000000ffffffff
x17: ffff800093529000 x16: ffff80008b01d6e0 x15: 0000000000000001
x14: 1ffff00012f8ce34 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700012f8ce35 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c1a01e80 x7 : ffff8000828bb454 x6 : 0000000000000000
x5 : ffff8000936f2db0 x4 : 0000000000000008 x3 : ffff800080522fb4
x2 : 0000000000000001 x1 : 0000000000000004 x0 : 0000000000000000
Call trace:
 __bch2_trans_get+0x9ac/0x9d4 fs/bcachefs/btree_iter.c:3460 (P)
 bch2_rbio_retry+0x17c/0xd44 fs/bcachefs/io_read.c:594
 bch2_rbio_punt fs/bcachefs/io_read.c:411 [inline]
 bch2_rbio_error+0x24c/0x354 fs/bcachefs/io_read.c:686
 bch2_read_endio+0x510/0x908 fs/bcachefs/io_read.c:-1
 bio_endio+0x858/0x894 block/bio.c:1651
 bch2_rbio_done fs/bcachefs/io_read.c:464 [inline]
 bch2_rbio_retry+0x86c/0xd44 fs/bcachefs/io_read.c:667
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
Code: 17ffff25 9779d56a 17fffe9f 9779d568 (d4210000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

