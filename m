Return-Path: <linux-kernel+bounces-835003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1EABA6033
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7262323F27
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7E1279351;
	Sat, 27 Sep 2025 14:03:28 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850031DF73C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981808; cv=none; b=GXxAf7mn8izmSO1QiWShxK9Nyq1mzuwdCMS89tTNhCOB0QuWHivQ+PWKT0X8umJrCAl6gy0L+J+TagmqIrwD7vYr5FmgjkKikqVPMuIJUO0GLMXMm36MK6gp0up/CMlxtC23gxd/Ht3bQiklmi6+bbDoYNDDivwa+hmeOkNtPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981808; c=relaxed/simple;
	bh=dgs6cQRWJTD4WcoHP0V6zKMtxjBEMlWQE2mPpSLQhxw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dYmBldvA2+P+thiTVOmNk3fjGfZ9ueYtAWuNOk4gucYZH/jT6817Nb5RgvciN25JDyjoMYIFFVXSErMSZKOt/EvQl1xNcOL7UswFoyYA+MJ5MuLPbGzUjkjQSQWx8fTmxhAoec2TWJmQMKiGyH4Aa9XkazQR1crN/MTdsem2ubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8877131dec5so335095339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758981805; x=1759586605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tb7WUnUnmowsD5Xi9s+qXAGpwDsGmAyfKBwl/tCWYKQ=;
        b=ZWhAlaKYnj1cIzlktq3Vq43Fkt5ut4GDIWmFaPqj1nmJRNLU9y23r5LcCzKSTsqIti
         wJyI0R3qf7e4FjfEAXVbRtgWENcbVlLx5GYBL723q+D6/ZaVExzGOh1aGlcK+xTZGMJ4
         ZbBVygASQ201HYpTC0vGiwVnlaBOo45tjiAp7YvLUZyfxCf6xXxxMRPS4finnCqQMklF
         GUlNrZUgQykSKTsM4yGJ3gb3mYGKG8P7rPamMMzHZM+W78CIJWLQlNItz9ukTfDEPVJl
         M+yhBwJjsSO0UUcH+lWIHYQn7IfHtS7KixMxa5NCy57s52oBDnQpb8HeKv9J1sw/BTXq
         2cnA==
X-Forwarded-Encrypted: i=1; AJvYcCXR9zhjnrNIfxyOi6S4qNH9gjsi8I8ytO6AaxmUiXIOBUhDPLjrFuCEbsQKF5aL5AqlZ2x4MGW1j9+AVUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9GHJVtBAlO1a0WEt4bwSiTLrkSVwj8MUEUbyHCEMnqK8eoLO
	HUJZFTYQjDHBgvCJPVbUyoWKd5uJV2/DkLR8YhtnJ/ilr6x16+XUB4Mf0Bx4vv7VKv2rZDr6cFo
	6XVNFspzqc6SqCJKrku9Bf3zBviAySIvJKtXVENtSc6oZHfiM+sw9HrBPPc8=
X-Google-Smtp-Source: AGHT+IE4Trg4Vjvy/AHY1DV5AiKg45oaL3eCTMCg1kYqhhZK/sZ14O/98ZePqene8Jqej8bzVmAugQ38PJ5m2iEjlGRI87/y2flv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc8:b0:428:76ec:b2ab with SMTP id
 e9e14a558f8ab-42876ecb3d5mr51249645ab.6.1758981805406; Sat, 27 Sep 2025
 07:03:25 -0700 (PDT)
Date: Sat, 27 Sep 2025 07:03:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d7eead.a00a0220.102ee.0015.GAE@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in bch2_mark_pagecache_unallocated
 (3)
From: syzbot <syzbot+94b822fda1fb3f24f1da@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5db4add5e77 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1369627c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2ae34a0711ff2f1
dashboard link: https://syzkaller.appspot.com/bug?extid=94b822fda1fb3f24f1da
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cc0d34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6eee2232d5c1/disk-b5db4add.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8b00f2f1234/vmlinux-b5db4add.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc0d466f156c/Image-b5db4add.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/efd7fb7b4339/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94b822fda1fb3f24f1da@syzkaller.appspotmail.com

INFO: task syz.1.152:8462 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.152       state:D stack:0     pid:8462  tgid:8423  ppid:6684   task_flags:0x400140 flags:0x00000011
Call trace:
 __switch_to+0x418/0x87c arch/arm64/kernel/process.c:741 (T)
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x13b0/0x2864 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:7058
 io_schedule+0x84/0xf0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x56c/0x9e0 mm/filemap.c:1317
 __folio_lock+0x2c/0x3c mm/filemap.c:1675
 folio_lock include/linux/pagemap.h:1133 [inline]
 bch2_mark_pagecache_unallocated+0x310/0x6c8 fs/bcachefs/fs-io-pagecache.c:275
 bch2_remap_file_range+0x598/0xb70 fs/bcachefs/fs-io.c:933
 vfs_clone_file_range+0x62c/0xb68 fs/remap_range.c:403
 ioctl_file_clone fs/ioctl.c:240 [inline]
 ioctl_file_clone_range fs/ioctl.c:258 [inline]
 do_vfs_ioctl+0xb84/0x1834 fs/ioctl.c:545
 __do_sys_ioctl fs/ioctl.c:596 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __arm64_sys_ioctl+0xe4/0x1c4 fs/ioctl.c:584
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
INFO: task syz.1.152:8464 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.152       state:D stack:0     pid:8464  tgid:8423  ppid:6684   task_flags:0x440040 flags:0x00000001
Call trace:
 __switch_to+0x418/0x87c arch/arm64/kernel/process.c:741 (T)
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x13b0/0x2864 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:7058
 __bch2_two_state_lock+0x1b4/0x2f0 fs/bcachefs/two_state_shared_lock.c:7
 bch2_two_state_lock fs/bcachefs/two_state_shared_lock.h:55 [inline]
 bch2_readahead+0xbc8/0xd88 fs/bcachefs/fs-io-buffered.c:296
 read_pages+0x13c/0x4c4 mm/readahead.c:160
 page_cache_ra_order+0x7a0/0xb7c mm/readahead.c:512
 page_cache_sync_ra+0x580/0x73c mm/readahead.c:619
 filemap_get_pages+0x2f4/0x19c8 mm/filemap.c:2603
 filemap_splice_read+0x454/0xad8 mm/filemap.c:2991
 do_splice_read fs/splice.c:982 [inline]
 splice_file_to_pipe+0x374/0x5a8 fs/splice.c:1292
 do_sendfile+0x37c/0x658 fs/read_write.c:1376
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64 fs/read_write.c:1417 [inline]
 __arm64_sys_sendfile64+0x1b4/0x274 fs/read_write.c:1417
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Showing all locks held in the system:
2 locks held by kworker/u8:0/12:
1 lock held by khungtaskd/32:
 #0: ffff80008f9d9620 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:330
1 lock held by klogd/6160:
2 locks held by getty/6313:
 #0: ffff0000d35390a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800099e8e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x34c/0xfa4 drivers/tty/n_tty.c:2222
1 lock held by syz-executor/6571:
 #0: ffff0000c696fc68 (&pipe->mutex){+.+.}-{4:4}, at: pipe_release+0x54/0x2fc fs/pipe.c:727
2 locks held by syz.1.152/8462:
 #0: ffff0000cf3a0428 (sb_writers#11){.+.+}-{0:0}, at: ioctl_file_clone fs/ioctl.c:240 [inline]
 #0: ffff0000cf3a0428 (sb_writers#11){.+.+}-{0:0}, at: ioctl_file_clone_range fs/ioctl.c:258 [inline]
 #0: ffff0000cf3a0428 (sb_writers#11){.+.+}-{0:0}, at: do_vfs_ioctl+0xb84/0x1834 fs/ioctl.c:545
 #1: ffff0000f9f89078 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:870 [inline]
 #1: ffff0000f9f89078 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: lock_two_nondirectories+0xc4/0x150 fs/inode.c:1232
2 locks held by syz.1.152/8464:
 #0: ffff0000c696fc68 (&pipe->mutex){+.+.}-{4:4}, at: pipe_lock+0x68/0x98 fs/pipe.c:91
 #1: ffff0000f9f89218 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:935 [inline]
 #1: ffff0000f9f89218 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_order+0x268/0xb7c mm/readahead.c:488

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

