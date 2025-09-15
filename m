Return-Path: <linux-kernel+bounces-817604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B3B58463
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F422485961
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF9E2D77E4;
	Mon, 15 Sep 2025 18:17:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0759286898
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960256; cv=none; b=OeI3XjqVIO9L0A3wDD8Z1UYoRhbMH7IRHTq1Z9ucpaa5+qDmERBI0CuPO5Lcmqh0SXMbwm+47TrSpRvkfjtynPzu/HlezqcFYSA8o/no+Rss6WF1qTzSBZykp1AkXJLinL4TPyBPtffGDYUtAeGAVdk5O9YfkUf6gQIifUFzbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960256; c=relaxed/simple;
	bh=cBGw9yr/NxRXJUn3FlewYS5etNcowikQsf2zc2EFCXk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dU8Z6HSpJR4tjJGhfDUTA/WALhT73IZn9fqx0aAGIf3pBpRMUJMyZleLXFX3Lzb2m9zktFhFtHvVrAHotoTDXvZe11C8jfwGzcs1nMsttzd9jk/8bx3/Q3JLu0/GcSa5pWhTXkrGugK/u5o2vocTZ2YpKGHWMs0HWQZQagNMEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88de776aab6so317689039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960253; x=1758565053;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/wxYceRJIHf60Mk3yO/LAc7F7Idh5Ut1RC/vnd2oE8=;
        b=rLmolvgoPWShglRKGhl50fEllB80qq0GKmR7dnbAQaHMbGPZfC3ywONaExKcc7hXUu
         gvFKvvG5QuK86YUCr9//xdrHpbyo38QDAlYWUubV6TIcuhIKMoTb05bayHrCC27gpHJb
         dvaF19yD0yWx+cTeLoQnNB/m0/GhTHtivxgb0QEDj/+7ul5s4D+S8L8jQu8A/czAJh9z
         6Wu4QgfJsNr0iA9QdBQSzSbttQwZ5PnnDHeRndYqJi2PcDv6Qby/g4lI5UxWB590ZnIK
         K0nM70aaCjSimhRVhiguGbvZKYamHcI/+LW8lEA+dGJopHNmVJHvp5UzgRae1O9XyJMr
         KHvA==
X-Forwarded-Encrypted: i=1; AJvYcCXXOTcOovYQs1oG7ecLItQ0NXk04vJ5v7bt8HIW6Gdd2ChYCMssQGZ4fsHkiJRFQ6JMR1Yq0PJU6WvAUJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxYEno4qmV/aOgnttyDR+M3/ulXOjW1K+PeM2DR6uDxl6NQPl
	6OnrEEJpCIZZ1JwtxIr59Dfq4zOO6kGGT/4HYlyFGaUu8Ps2ItMlnPZlLnvk5F6zT1AWODKck92
	WU3T4+sdbpN/tzcbxAdndYas39RQi689gaQVBMQYrZMAO00wgHz6yJkF9UZw=
X-Google-Smtp-Source: AGHT+IH9pf1hn3UreWY9Lb+3nyIMF2EElfmThhGup3oU2FA6VMmRqVIwzjoD6Rnkn6d9UbIOJU2AaTcbIH80X6buD26pG7SEgUJW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:118e:b0:41e:c3da:57c0 with SMTP id
 e9e14a558f8ab-41ec3da5b56mr139750155ab.12.1757960253643; Mon, 15 Sep 2025
 11:17:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:17:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8583d.050a0220.2ff435.03a3.GAE@google.com>
Subject: [syzbot] [erofs?] INFO: task hung in erofs_bread
From: syzbot <syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, jefflexu@linux.alibaba.com, 
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org, zbestahu@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    590b221ed425 Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b4947c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12a1d1f3a8199632
dashboard link: https://syzkaller.appspot.com/bug?extid=1a9af3ef3c84c5e14dcc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17850e42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12baf934580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63a963fc26db/disk-590b221e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c2013d30830/vmlinux-590b221e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ee4d3a8e8f6/bzImage-590b221e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/364a5efd8f50/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14baf934580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com

INFO: task syz.0.17:6071 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D
 stack:28424 pid:6071  tgid:6065  ppid:5989   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5360 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6964
 __schedule_loop kernel/sched/core.c:7046 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7061
 io_schedule+0x80/0xd0 kernel/sched/core.c:7906
 folio_wait_bit_common+0x6b0/0xb90 mm/filemap.c:1330
 folio_put_wait_locked mm/filemap.c:1494 [inline]
 do_read_cache_folio+0x1aa/0x590 mm/filemap.c:3973
 read_mapping_folio include/linux/pagemap.h:999 [inline]
 erofs_bread+0x46f/0x7f0 fs/erofs/data.c:40
 erofs_readdir+0x58a/0x1020 fs/erofs/dir.c:81
 iterate_dir+0x399/0x570 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee78f8eba9
RSP: 002b:00007fee79e56038 EFLAGS: 00000246
 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fee791d6090 RCX: 00007fee78f8eba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fee79011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fee791d6128 R14: 00007fee791d6090 R15: 00007ffcdf8b9388
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/u8:0/12:
1 lock held by khungtaskd/31:
 #0: 
ffffffff8e33c820
 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
3 locks held by kworker/u8:2/35:
 #0: 
ffff88801a889148
 (
(wq_completion)events_unbound
){+.+.}-{0:0}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636
 #1: ffff8880b8624008 (
psi_seq){-.-.}-{0:0}, at: process_one_work kernel/workqueue.c:3239 [inline]
psi_seq){-.-.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
 #2: 
ffff88805488d250 (&devlink->lock_key#6){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xb80 drivers/net/netdevsim/dev.c:853
3 locks held by kswapd0/84:
2 locks held by getty/5630:
 #0: 
ffff88814dbd60a0
 (
&tty->ldisc_sem
){++++}-{0:0}
, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc9000332e2f0
 (
&ldata->atomic_read_lock
){+.+.}-{4:4}
, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by syz.0.17/6067:
2 locks held by syz.0.17/6071:
 #0: ffff888031f5d438 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1232
 #1: ffff88805f1f86d0 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: iterate_dir+0x292/0x570 fs/readdir.c:101
3 locks held by syz.1.18/6121:
2 locks held by syz.1.18/6123:
 #0: ffff888030faeb78 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1232
 #1: ffff8880300b06d0 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: iterate_dir+0x292/0x570 fs/readdir.c:101
9 locks held by syz.2.19/6148:
2 locks held by syz.2.19/6149:
 #0: ffff88803210a9b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1232
 #1: ffff8880300b1150 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: iterate_dir+0x292/0x570 fs/readdir.c:101
8 locks held by syz.3.20/6172:
2 locks held by syz.3.20/6173:
 #0: 
ffff888021fe9b38
 (
&f->f_pos_lock
){+.+.}-{4:4}
, at: fdget_pos+0x247/0x320 fs/file.c:1232
 #1: 
ffff88805f1f9150
 (&type->i_mutex_dir_key#8){.+.+}-{4:4}, at: iterate_dir+0x292/0x570 fs/readdir.c:101
3 locks held by syz.4.21/6210:
2 locks held by syz.4.21/6211:
 #0: 
ffff88802f23e638
 (
&f->f_pos_lock
){+.+.}-{4:4}
, at: fdget_pos+0x247/0x320 fs/file.c:1232
 #1: 
ffff88805f1f9bd0
 (


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

