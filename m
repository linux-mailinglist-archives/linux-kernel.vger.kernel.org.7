Return-Path: <linux-kernel+bounces-771721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF594B28AB2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9F7B84CF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D61E260A;
	Sat, 16 Aug 2025 05:34:39 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245F78F24
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755322478; cv=none; b=EPJSdv4eUr7WVHK66IHcub0LrMKMZjiPLg0bn8Y78gJrO6naJRd6lyuqmIgQ5PPored6LdwOudHt17SL5vkI4/OnF5AlpHSAqmfIz/5N2Q3TStvPs2GGtrle0sUTcTdUyEUVOoT0G1uVOBuTXeXW5ubDzuHnocaTrsUx3Pvf084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755322478; c=relaxed/simple;
	bh=pTKB3kaxBhKOB3BFo8XY4/gDpnQ7iR1gZaGfdwoiZV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nOhajAgIQ8fpDrpTweUCZ6RxTk+2JYvWlQk6OJ26jPCKiD4lr5gqfUE8PRiJW6WqXAwzypBAeLe4WRu5uCs/Sgqk2ChEdlkCP6kgLChawhhnlL6pP+oOqjqimdYOv0dZIaVYJ3OxHeHwgfn0SgiQ020gBbXJLEqFDRPllC9t7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88432e3c4ffso268459339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755322476; x=1755927276;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzQoCb1WLtrRu6y8GFrbrr6yZw0bmvbIslI+EnlYyds=;
        b=gYO5LI36e+TZ6N2PyxOpz3fC6cg3Qjw10EcjC/5CaUwZwusclkcvwkLmfzk4Q7w9Jj
         Ah1O7O3aU6VuAdy/+Iv6Q+cvfRDMOeYcrXZy7mTuQPyeF9tMYbRRnwOL93NPwpm3tgTq
         0RhCTOTDm4MEYUMuJY4Ad8TGtvUkLnizenpfqjDAdiDvG3ZRss6wBuMrVR47YOPow6Dq
         GKg5o6htJvKXAxKZKJMAdgVj6Chmitrws6s76vE9svrVhpC2NPcFN598kPV/VFqZDon6
         MGkN149YWhJPsjhj+0c/UFb4T2JID45vBmy4UmmIV3SW7KIBbeouUICYovRkUWPv05hj
         g2hA==
X-Forwarded-Encrypted: i=1; AJvYcCUE1Fxx5aXAFcX8NKFnZ2rlfQCLURZOWjKY1CrpcyVEYFSUFCo9xLgxXUZgHSumo1Zc1WRfruiMPiQ6qSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJB3C/UKKOBiaK8fCWafEYl8esOnC/09EbxcvzY+HKWvIa57Y7
	+tl+aoKPQhmlrjDoCHyHZFJjfIgZgq12m0jFvCts8QBF7CMcz7kXtMZ+/fq/71rJoKXWXfyzEeb
	/qrqUvIdCepRiuNcXq8rwwMiYXsmdk+cfo7cl/J78zkOrAb5nH7F+32USioA=
X-Google-Smtp-Source: AGHT+IE4/jQcP/MBfxadW3739rxlWF7NdyD873hqGh8u3kdo6fDkvt8mq+iES5NJ0Q6b2M5BTSnhJXVbcVSrXqTWowwKsSLXcf/N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a85:b0:3e5:7437:696f with SMTP id
 e9e14a558f8ab-3e57e9c8b6bmr87726945ab.24.1755322475923; Fri, 15 Aug 2025
 22:34:35 -0700 (PDT)
Date: Fri, 15 Aug 2025 22:34:35 -0700
In-Reply-To: <689ff631.050a0220.e29e5.0034.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a0186b.050a0220.e29e5.003b.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] INFO: task hung in __gfs2_log_reserve
From: syzbot <syzbot+e1c0c6cfbf89afd6043b@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    931e46dcbc7e Add linux-next specific files for 20250814
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1574f3a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a286bd75352e92fa
dashboard link: https://syzkaller.appspot.com/bug?extid=e1c0c6cfbf89afd6043b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133b53a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1681a3a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fb896162d550/disk-931e46dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45f6f857b82c/vmlinux-931e46dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f16e70143e1/bzImage-931e46dc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/50c19e68b482/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1281a3a2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1c0c6cfbf89afd6043b@syzkaller.appspotmail.com

INFO: task syz.2.249:7180 blocked for more than 143 seconds.
      Not tainted 6.17.0-rc1-next-20250814-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.249       state:D stack:25224 pid:7180  tgid:7177  ppid:5999   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x80/0xd0 kernel/sched/core.c:7903
 __gfs2_log_reserve+0x208/0x400 fs/gfs2/log.c:535
 __gfs2_trans_begin+0x549/0x890 fs/gfs2/trans.c:91
 gfs2_trans_begin+0x6f/0xe0 fs/gfs2/trans.c:118
 sweep_bh_for_rgrps fs/gfs2/bmap.c:1533 [inline]
 punch_hole+0x1e92/0x2ca0 fs/gfs2/bmap.c:1860
 gfs2_iomap_end+0x4f8/0x6c0 fs/gfs2/bmap.c:1178
 iomap_iter+0x313/0xde0 fs/iomap/iter.c:79
 iomap_file_buffered_write+0x7fa/0x9b0 fs/iomap/buffered-io.c:1065
 gfs2_file_buffered_write+0x4ed/0x880 fs/gfs2/file.c:1061
 gfs2_file_write_iter+0x94e/0x1100 fs/gfs2/file.c:1166
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f461038ebe9
RSP: 002b:00007f46111a0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f46105b5fa0 RCX: 00007f461038ebe9
RDX: 000000000208e24b RSI: 0000200000000040 RDI: 0000000000000005
RBP: 00007f4610411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f46105b6038 R14: 00007f46105b5fa0 R15: 00007ffc7df3cf48
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.17.0-rc1-next-20250814-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 8415 Comm: syz.0.549 Not tainted 6.17.0-rc1-next-20250814-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:trace_lock_acquire include/trace/events/lock.h:24 [inline]
RIP: 0010:lock_acquire+0x58/0x360 kernel/locking/lockdep.c:5831
Code: 8b 05 cc b4 03 11 48 89 44 24 58 0f 1f 44 00 00 65 8b 05 cf b4 03 11 83 f8 08 0f 83 b8 01 00 00 89 c0 48 0f a3 05 b8 55 06 0e <73> 16 e8 61 02 09 00 84 c0 75 0d f6 05 0c 3a f0 0d 01 0f 84 d7 01
RSP: 0018:ffffc90000a08638 EFLAGS: 00000297
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8e139ee0
RBP: ffffffff8172c195 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90000a087f8 R11: ffffffff81ac38c0 R12: 0000000000000002
R13: ffffffff8e139ee0 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f552f8486c0(0000) GS:ffff888125d0f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f173cb69000 CR3: 000000007f9f2000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0xc2/0x2390 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x18e/0x440 mm/slub.c:4879
 slab_free_after_rcu_debug+0x60/0x2a0 mm/slub.c:4717
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2061 [inline]
RIP: 0010:vprintk_emit+0x58f/0x7a0 kernel/printk/printk.c:2449
Code: 85 32 01 00 00 e8 e1 80 1f 00 41 89 df 4d 85 f6 48 8b 1c 24 75 07 e8 d0 80 1f 00 eb 06 e8 c9 80 1f 00 fb 48 c7 c7 80 e1 12 8e <31> f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00 45 31 c9 53 e8 b9 35
RSP: 0018:ffffc9000d8c76c0 EFLAGS: 00000293
RAX: ffffffff81a02547 RBX: ffffffff81a02404 RCX: ffff88801cb13c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8e12e180
RBP: ffffc9000d8c77d0 R08: ffffffff8fa3b137 R09: 1ffffffff1f47626
R10: dffffc0000000000 R11: fffffbfff1f47627 R12: dffffc0000000000
R13: 1ffff92001b18edc R14: 0000000000000200 R15: 0000000000000030
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 gfs2_sys_fs_add+0x39c/0x450 fs/gfs2/sys.c:764
 gfs2_fill_super+0x13c0/0x20d0 fs/gfs2/ops_fstype.c:1206
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1692
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
 do_new_mount+0x2a2/0xa30 fs/namespace.c:3807
 do_mount fs/namespace.c:4135 [inline]
 __do_sys_mount fs/namespace.c:4346 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4323
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f552e99038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f552f847e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f552f847ef0 RCX: 00007f552e99038a
RDX: 000020000001f680 RSI: 0000200000000040 RDI: 00007f552f847eb0
RBP: 000020000001f680 R08: 00007f552f847ef0 R09: 0000000000000084
R10: 0000000000000084 R11: 0000000000000246 R12: 0000200000000040
R13: 00007f552f847eb0 R14: 000000000001f790 R15: 00002000000001c0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

