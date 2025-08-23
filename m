Return-Path: <linux-kernel+bounces-782963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF12B327B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A01DAE0846
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB523AE66;
	Sat, 23 Aug 2025 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRz+K1sL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA321DB551
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938702; cv=none; b=IltiOcE7r+ekBbTPHD6dA/peIGxIHkxZLWr0M/cMcYvN5y9GlM+lN2PQAuKXX1wv4TFxel42iRMIHLNYXlS0mcCUyEb0zHce5MybLsxL4FZuAIRSIOct0/Ughs6rjJIM9AfEQV++3Uq0cbpqyyawundMU9mHJXICpJAUmV9uFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938702; c=relaxed/simple;
	bh=3ChhdxgBY1t4EUIcbTAY3hW36/kaApvdTgZ+gvLjtnQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZhrDph+vO0H/SYoBdsjGcekpMK3F7uIcuOAS+EeEhdGyPftsEtFCAxOBT0D0uzyHiiKXvb46nsS5ZZEd4A8gkS/lHX00SAZyoCdlCPP16+Sau1UF2qpyaeKDyNsccLE4wfaBNHgdQAnpx86lA6DlptC/vlekP+jkxpS2PigND6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRz+K1sL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A85C4CEE7;
	Sat, 23 Aug 2025 08:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755938701;
	bh=3ChhdxgBY1t4EUIcbTAY3hW36/kaApvdTgZ+gvLjtnQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WRz+K1sLVmqExK0PkZ8WTGd4p9mvmV6oxoosYMRAm8dRw4PT+GdrGLeVo6Qk9W/nj
	 BdMOCEa0l0tnu+x2kYLegVu7IgRUy04sF9uV7SyxPEkUMWzRqZRk+6AtvztCp7GGRZ
	 uyAfCBlIPdw9wGKP+T6nHTdZMrIyuDABlhcM5I0dv2Bx89qIjDuO5J5Cjik/RcruE0
	 TfCsx5lvvxW7hfRlWU84gVv4JGYu+vkHDoI8Sl1EdtAGW11+MS+vAJr0nePavR56Lo
	 UW0qPLPk8dmYwri4I0cnVoxkhLT5HbplSFcZZxCTURtsILC4J8gkgQ9qY1K4RteY67
	 r/Noxp/rSKnEA==
Message-ID: <69bafc73-d147-4e7d-939d-4b99e68e0678@kernel.org>
Date: Sat, 23 Aug 2025 16:44:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org,
 syzbot <syzbot+942fb6ce3ac2843a1420@syzkaller.appspotmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] INFO: task hung in f2fs_llseek
To: Hillf Danton <hdanton@sina.com>
References: <20250822222346.5267-1-hdanton@sina.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250822222346.5267-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/2025 6:23 AM, Hillf Danton wrote:
>> Date: Fri, 22 Aug 2025 11:56:27 -0700
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    3957a5720157 Merge tag 'cgroup-for-6.17-rc2-fixes' of git:..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13e20c42580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
>> dashboard link: https://syzkaller.appspot.com/bug?extid=942fb6ce3ac2843a1420
>> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db07bc580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f62a34580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/c5cbe8650b9a/disk-3957a572.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/51911bea9855/vmlinux-3957a572.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/b07279b5fcc2/bzImage-3957a572.xz
>> mounted in repro: https://storage.googleapis.com/syzbot-assets/f35e0e9a079a/mount_0.gz
>>    fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10a5dfa2580000)
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+942fb6ce3ac2843a1420@syzkaller.appspotmail.com
>>
>> INFO: task syz.1.23:6086 blocked for more than 143 seconds.
>>        Tainted: G        W           syzkaller #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:syz.1.23        state:D stack:29352 pid:6086  tgid:6081  ppid:6062   task_flags:0x400040 flags:0x00004004
>> Call Trace:
>>   <TASK>
>>   context_switch kernel/sched/core.c:5357 [inline]
>>   __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
>>   __schedule_loop kernel/sched/core.c:7043 [inline]
>>   rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
>>   rt_mutex_slowlock_block kernel/locking/rtmutex.c:1647 [inline]
>>   __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
>>   __rt_mutex_slowlock_locked+0x1e04/0x25e0 kernel/locking/rtmutex.c:1760
>>   __rwbase_read_lock+0xbc/0x180 kernel/locking/rwbase_rt.c:114
>>   rwbase_read_lock kernel/locking/rwbase_rt.c:147 [inline]
>>   __down_read kernel/locking/rwsem.c:1466 [inline]
>>   down_read+0x127/0x1f0 kernel/locking/rwsem.c:1539
>>   inode_lock_shared include/linux/fs.h:884 [inline]
>>   f2fs_seek_block fs/f2fs/file.c:458 [inline]
>>   f2fs_llseek+0x1e5/0x1840 fs/f2fs/file.c:545
>>   vfs_llseek fs/read_write.c:389 [inline]
>>   ksys_lseek fs/read_write.c:402 [inline]
>>   __do_sys_lseek fs/read_write.c:412 [inline]
>>   __se_sys_lseek fs/read_write.c:410 [inline]
>>   __x64_sys_lseek+0x155/0x1f0 fs/read_write.c:410
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f7c9077ebe9
>> RSP: 002b:00007f7c8fdcd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
>> RAX: ffffffffffffffda RBX: 00007f7c909a6090 RCX: 00007f7c9077ebe9
>> RDX: 0000000000000004 RSI: 0000000000000008 RDI: 0000000000000004
>> RBP: 00007f7c90801e19 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007f7c909a6128 R14: 00007f7c909a6090 R15: 00007fffeb5fe138
>>   </TASK>
>> INFO: lockdep is turned off.
>> NMI backtrace for cpu 1
>> CPU: 1 UID: 0 PID: 39 Comm: khungtaskd Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)}
>> Tainted: [W]=WARN
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>>   nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
>>   nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
>>   trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>>   check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
>>   watchdog+0xf93/0xfe0 kernel/hung_task.c:491
>>   kthread+0x70e/0x8a0 kernel/kthread.c:463
>>   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>   </TASK>
>> Sending NMI from CPU 1 to CPUs 0:
>> NMI backtrace for cpu 0
>> CPU: 0 UID: 0 PID: 6274 Comm: syz.3.43 Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)}
>> Tainted: [W]=WARN
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
>> RIP: 0010:unwind_next_frame+0x175d/0x2390 arch/x86/kernel/unwind_orc.c:648
>> Code: 28 84 c0 0f 85 19 0b 00 00 48 89 d0 48 c1 e8 03 0f b6 04 28 84 c0 0f 85 2b 0b 00 00 48 0f bf 03 49 01 c4 49 8d 56 40 4c 89 f7 <4c> 89 e6 eb 5d 49 8d 5e 40 48 89 d8 48 c1 e8 03 80 3c 28 00 74 08
>> RSP: 0018:ffffc90003b06438 EFLAGS: 00000283
>> RAX: fffffffffffffff0 RBX: ffffffff8fd32106 RCX: 0000000000000000
>> RDX: ffffc90003b06548 RSI: 0000000000000001 RDI: ffffc90003b06508
>> RBP: dffffc0000000000 R08: ffffc90003b06567 R09: 0000000000000000
>> R10: ffffc90003b06558 R11: fffff52000760cad R12: ffffc90003b069d0
>> R13: ffffc90003b06558 R14: ffffc90003b06508 R15: 1ffffffff1fa6421
>> FS:  00007f0008c3c6c0(0000) GS:ffff8881268c4000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f8cae82bf98 CR3: 000000005b1bc000 CR4: 00000000003526f0
>> Call Trace:
>>   <TASK>
>>   arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
>>   stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
>>   kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
>>   kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
>>   slab_free_hook mm/slub.c:2378 [inline]
>>   slab_free mm/slub.c:4680 [inline]
>>   kmem_cache_free+0x3ef/0x510 mm/slub.c:4782
>>   f2fs_read_end_io+0x398/0x9d0 fs/f2fs/data.c:-1
>>   f2fs_submit_page_read+0x116/0x190 fs/f2fs/data.c:1110
>>   f2fs_get_read_data_folio+0x4a4/0x7d0 fs/f2fs/data.c:1268
>>   gc_data_segment fs/f2fs/gc.c:1641 [inline]
>>   do_garbage_collect+0x3898/0x6410 fs/f2fs/gc.c:1826
>>   f2fs_gc+0xca9/0x2580 fs/f2fs/gc.c:1931
>>   f2fs_balance_fs+0x5fb/0x7f0 fs/f2fs/segment.c:466
>>   f2fs_map_blocks+0x345f/0x4130 fs/f2fs/data.c:1792
>>   f2fs_expand_inode_data+0x5b1/0xa60 fs/f2fs/file.c:1923
>>   f2fs_fallocate+0x4f8/0x990 fs/f2fs/file.c:2026
> 
> This report complains that it took more than 100s for f2fs_fallocate() to
> complete after locking inode [1], right?

I guess so, seems f2fs_gc() was blocked or in a deadloop somehow.

Thanks,

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/f2fs/file.c#n1991
> 
>>   vfs_fallocate+0x672/0x7f0 fs/open.c:342
>>   ioctl_preallocate fs/ioctl.c:290 [inline]
>>   file_ioctl+0x61d/0x780 fs/ioctl.c:-1
>>   do_vfs_ioctl+0xb36/0x1440 fs/ioctl.c:577
>>   __do_sys_ioctl fs/ioctl.c:596 [inline]
>>   __se_sys_ioctl+0x82/0x170 fs/ioctl.c:584
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f


