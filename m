Return-Path: <linux-kernel+bounces-848966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BD4BCEEBA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C71406B9B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F561B0420;
	Sat, 11 Oct 2025 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sspQxzAv"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E21885A5
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760152341; cv=none; b=RCPLCQ5i/8HeXtmJ7GxucVfII5aEYItvmlkMibaoi7rdiQSL8N50Beg/qjX5U+VO4sGRcNaVtxYPKAvTaiCzmpeipA6KwrH2b0+DrQHX/icCjbUiTj/DBB/6WJKhhiPOmRnVVXjKUbArsnvmhfIzFlnNpy97lzam2/CNZ7TvaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760152341; c=relaxed/simple;
	bh=+pfquoeRmGw03nPZA5TmG3AF3zxsHo75WJfQ+88Ukxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpCzHItX6xVMVZngOwUwFAd3y+mr7MCvf7/ymchrgOSGLyyg4bYxtLLWQV85v4cODfNcRIqBg+q/Agrd2TfolhlqpWSKr81WxKHAf7VG5E1CFAbXCa9YRai57cY1juAkKxyJ67tmqplxlni+iFHrhaoG2cbjp2A9yYCB4v2xBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sspQxzAv; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCXU3pofNfJa+f3ez5Q6yMu1TNrp9VvQr9k4KbL94x1dWrtnFGsn3SFml1Rv/u9YhNfbqJ9ywERbEuI6JyQ=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760152336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luu98aminM5AVaUeuQ2zVnLv5uEAc7jLUrqA8djWYIc=;
	b=sspQxzAvbUZVh2y1xfw1Mvb8GnS9xGdDEG6h3tjvXtvBGOTpIvclGXFvQP2SqOLyCqgqlD
	Lz2bYQQF/LIJKy3OR1s1iw3Ae50e2iMxmCloXhp2lxqX3h8w8ou+ZOdKZ7GWqN2PzbogTZ
	pNNc3a5NijFFFLF5/bnoBdRZjMeeTM8=
X-Gm-Message-State: AOJu0Yw1DFtPYX2g/8Q72qWy2hFElnA8eSWFH3718XoSrP+i3XF1l9OC
	hPqHr+vs8NlzkqGYnjE7Qs+pwx9J3EOc9luj4aGFsxtSQzzz/8dKqAuS6tPmFA6dAigqXXU0VB1
	HEBD0gFIgZOHlUJ889GxD02Q7xzUAggM=
X-Google-Smtp-Source: AGHT+IF8qCViy/e3uSoedOoUJrkcGkDYMISHGKLHQTp5VF67lBfjNba8yQRCYajXdpeDQdk81u/Y+lI/XYON3LgxqfQ=
X-Received: by 2002:a05:6214:1cc5:b0:77c:9e3d:672 with SMTP id
 6a1803df08f44-87b2103c549mr197373726d6.5.1760152324538; Fri, 10 Oct 2025
 20:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68e9715a.050a0220.1186a4.000d.GAE@google.com>
In-Reply-To: <68e9715a.050a0220.1186a4.000d.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Sat, 11 Oct 2025 11:11:27 +0800
X-Gmail-Original-Message-ID: <CABzRoyYLxqdQpLf5JBO2qjpw0G=b8diuHs6WA3Bn24_0Ynu9oA@mail.gmail.com>
X-Gm-Features: AS18NWC2mXrVE-1qVFD2VI_0cIzg0JgnOLSbGp-QL9DFB3pqfvwUCHee6g3s8wg
Message-ID: <CABzRoyYLxqdQpLf5JBO2qjpw0G=b8diuHs6WA3Bn24_0Ynu9oA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in __rmap_walk_file
To: syzbot <syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	harry.yoo@oracle.com, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, riel@surriel.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 11, 2025 at 4:49=E2=80=AFAM syzbot
<syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5472d60c129f Merge tag 'trace-v6.18-2' of git://git.kerne=
l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16d6930458000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5b213914b883d=
014
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2d9c96466c97834=
6b55f
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D133e89e2580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17f3ba7c58000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-5472d60c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/af61e8db8b22/vmlinu=
x-5472d60c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a2c11e401d8a/b=
zImage-5472d60c.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com
>
> INFO: task syz.5.48:5749 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.5.48        state:D stack:27656 pid:5749  tgid:5747  ppid:5477  =
 task_flags:0x400040 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5325 [inline]
>  __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
>  __schedule_loop kernel/sched/core.c:7011 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:7026
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
>  rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1086

It would be great if CONFIG_DETECT_HUNG_TASK_BLOCKER was set, as it could
point directly to the blocker. However, the lockdep output at the end of
the report already gives us the crucial clue :)

```
1 lock held by syz.5.48/5749:
 #0: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at:
i_mmap_lock_read include/linux/fs.h:568 [inline]
 #0: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at:
__rmap_walk_file+0x227/0x620 mm/rmap.c:2905

3 locks held by syz.5.48/5754:
...
 #2: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at:
i_mmap_lock_write include/linux/fs.h:548 [inline]
 #2: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at:
hugetlbfs_punch_hole fs/hugetlbfs/inode.c:691 [inline]
 #2: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at:
hugetlbfs_fallocate+0x4b5/0x1100
```

1) One task (5754) holds the i_mmap_rwsem write lock for hugetlbfs_fallocat=
e.
2) While holding that lock, it blocks waiting for a folio_lock (according
   to its call trace).
3) This starves the other task (5749), which is waiting for the i_mmap_rwse=
m
   read lock to perform migrate_pages.

From the report, I cannot tell who originally held the folio_lock that
blocked task 5754. I hope this analysis is useful ...

Thanks,
Lance

>  __down_read_common kernel/locking/rwsem.c:1261 [inline]
>  __down_read kernel/locking/rwsem.c:1274 [inline]
>  down_read+0x98/0x2e0 kernel/locking/rwsem.c:1539
>  i_mmap_lock_read include/linux/fs.h:568 [inline]
>  __rmap_walk_file+0x227/0x620 mm/rmap.c:2905
>  remove_migration_ptes mm/migrate.c:471 [inline]
>  unmap_and_move_huge_page mm/migrate.c:1520 [inline]
>  migrate_hugetlbs mm/migrate.c:1641 [inline]
>  migrate_pages+0xc98/0x2930 mm/migrate.c:2080
>  do_mbind mm/mempolicy.c:1539 [inline]
>  kernel_mbind mm/mempolicy.c:1682 [inline]
>  __do_sys_mbind mm/mempolicy.c:1756 [inline]
>  __se_sys_mbind+0xa47/0xc40 mm/mempolicy.c:1752
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd36cd8eec9
> RSP: 002b:00007fd36dccd038 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 00007fd36cfe5fa0 RCX: 00007fd36cd8eec9
> RDX: 0000000000000000 RSI: 0000000000800000 RDI: 0000200000001000
> RBP: 00007fd36ce11f91 R08: 0000000000000040 R09: 0000000000000002
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fd36cfe6038 R14: 00007fd36cfe5fa0 R15: 00007ffec3386808
>  </TASK>
> INFO: task syz.5.48:5754 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.5.48        state:D stack:26920 pid:5754  tgid:5747  ppid:5477  =
 task_flags:0x400040 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5325 [inline]
>  __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
>  __schedule_loop kernel/sched/core.c:7011 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:7026
>  io_schedule+0x80/0xd0 kernel/sched/core.c:7871
>  folio_wait_bit_common+0x6b0/0xb80 mm/filemap.c:1330
>  __folio_lock mm/filemap.c:1706 [inline]
>  folio_lock include/linux/pagemap.h:1141 [inline]
>  __filemap_get_folio+0x139/0xaf0 mm/filemap.c:1960
>  filemap_lock_folio include/linux/pagemap.h:820 [inline]
>  filemap_lock_hugetlb_folio include/linux/hugetlb.h:814 [inline]
>  hugetlbfs_zero_partial_page+0xae/0x610 fs/hugetlbfs/inode.c:654
>  hugetlbfs_punch_hole fs/hugetlbfs/inode.c:708 [inline]
>  hugetlbfs_fallocate+0xb91/0x1100 fs/hugetlbfs/inode.c:741
>  vfs_fallocate+0x666/0x7e0 fs/open.c:342
>  madvise_remove mm/madvise.c:1049 [inline]
>  madvise_vma_behavior+0x31b3/0x3a10 mm/madvise.c:1346
>  madvise_walk_vmas+0x51c/0xa30 mm/madvise.c:1669
>  madvise_do_behavior+0x38e/0x550 mm/madvise.c:1885
>  do_madvise+0x1bc/0x270 mm/madvise.c:1978
>  __do_sys_madvise mm/madvise.c:1987 [inline]
>  __se_sys_madvise mm/madvise.c:1985 [inline]
>  __x64_sys_madvise+0xa7/0xc0 mm/madvise.c:1985
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd36cd8eec9
> RSP: 002b:00007fd36dcac038 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007fd36cfe6090 RCX: 00007fd36cd8eec9
> RDX: 0000000000000009 RSI: 0000000000600002 RDI: 0000200000000000
> RBP: 00007fd36ce11f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fd36cfe6128 R14: 00007fd36cfe6090 R15: 00007ffec3386808
>  </TASK>
>
> Showing all locks held in the system:
> 3 locks held by kworker/u4:0/12:
>  #0: ffff88801a479948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_one_work kernel/workqueue.c:3238 [inline]
>  #0: ffff88801a479948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: =
process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
>  #1: ffffc900001e7ba0 ((linkwatch_work).work){+.+.}-{0:0}, at: process_on=
e_work kernel/workqueue.c:3239 [inline]
>  #1: ffffc900001e7ba0 ((linkwatch_work).work){+.+.}-{0:0}, at: process_sc=
heduled_works+0x9ef/0x17b0 kernel/workqueue.c:3346
>  #2: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0=
x60 net/core/link_watch.c:303
> 1 lock held by khungtaskd/26:
>  #0: ffffffff8e13d320 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8e13d320 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:867 [inline]
>  #0: ffffffff8e13d320 (rcu_read_lock){....}-{1:3}, at: debug_show_all_loc=
ks+0x2e/0x180 kernel/locking/lockdep.c:6775
> 5 locks held by kworker/u4:6/1041:
>  #0: ffff88801b6f8948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3238 [inline]
>  #0: ffff88801b6f8948 ((wq_completion)netns){+.+.}-{0:0}, at: process_sch=
eduled_works+0x9b4/0x17b0 kernel/workqueue.c:3346
>  #1: ffffc900025b7ba0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_wor=
k kernel/workqueue.c:3239 [inline]
>  #1: ffffc900025b7ba0 (net_cleanup_work){+.+.}-{0:0}, at: process_schedul=
ed_works+0x9ef/0x17b0 kernel/workqueue.c:3346
>  #2: ffffffff8f4d4c50 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf=
7/0x820 net/core/net_namespace.c:669
>  #3: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_b=
atch+0xdc/0x890 net/core/dev.c:12807
>  #4: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_l=
ock kernel/rcu/tree_exp.h:311 [inline]
>  #4: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_=
rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:957
> 1 lock held by dhcpcd/5017:
>  #0: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include=
/linux/rtnetlink.h:130 [inline]
>  #0: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x323/0=
x1b50 net/ipv4/devinet.c:1120
> 2 locks held by getty/5110:
>  #0: ffff88803597c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wa=
it+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc9000018e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_r=
ead+0x43e/0x1400 drivers/tty/n_tty.c:2222
> 1 lock held by syz.5.48/5749:
>  #0: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: i_mm=
ap_lock_read include/linux/fs.h:568 [inline]
>  #0: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: __rm=
ap_walk_file+0x227/0x620 mm/rmap.c:2905
> 3 locks held by syz.5.48/5754:
>  #0: ffff88801ebe2420 (sb_writers#12){.+.+}-{0:0}, at: file_start_write i=
nclude/linux/fs.h:3111 [inline]
>  #0: ffff88801ebe2420 (sb_writers#12){.+.+}-{0:0}, at: vfs_fallocate+0x5f=
0/0x7e0 fs/open.c:341
>  #1: ffff888011d3f348 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: inod=
e_lock include/linux/fs.h:980 [inline]
>  #1: ffff888011d3f348 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: huge=
tlbfs_punch_hole fs/hugetlbfs/inode.c:683 [inline]
>  #1: ffff888011d3f348 (&sb->s_type->i_mutex_key#20){+.+.}-{4:4}, at: huge=
tlbfs_fallocate+0x3cc/0x1100 fs/hugetlbfs/inode.c:741
>  #2: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: i_mm=
ap_lock_write include/linux/fs.h:548 [inline]
>  #2: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: huge=
tlbfs_punch_hole fs/hugetlbfs/inode.c:691 [inline]
>  #2: ffff888011d3f618 (&hugetlbfs_i_mmap_rwsem_key){++++}-{4:4}, at: huge=
tlbfs_fallocate+0x4b5/0x1100 fs/hugetlbfs/inode.c:741
> 2 locks held by syz-executor/20402:
>  #0: ffffffff8ec74400 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire in=
clude/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8ec74400 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock inclu=
de/linux/rcupdate.h:867 [inline]
>  #0: ffffffff8ec74400 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0=
x23/0x250 net/core/rtnetlink.c:570
>  #1: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rt=
netlink.c:80 [inline]
>  #1: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/co=
re/rtnetlink.c:341 [inline]
>  #1: ffffffff8f4e1ac8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8e9/0x=
1c80 net/core/rtnetlink.c:4064
> 1 lock held by syz.4.7446/21125:
>  #0: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_l=
ock kernel/rcu/tree_exp.h:343 [inline]
>  #0: ffffffff8e142db8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_=
rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:957
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
>  watchdog+0xf60/0xfa0 kernel/hung_task.c:495
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

