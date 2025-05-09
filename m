Return-Path: <linux-kernel+bounces-641422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1CAB1178
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 13:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BC93BDC2C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE328F528;
	Fri,  9 May 2025 11:05:28 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96728ECE9
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788727; cv=none; b=SJm3mnx3l9mDu3tsHfTWfKXAn7CgmDrFRylzrXeXooyyqiQnEUyJg0idf57qPNfQiAuCb9nfiututApB02hcKDdywR8ND3p+sVwnHThmYuaOMA3Wmy8LcXpQxplMGVHNh5UyZMWV9zMNL4EnPO/EA7W/I9gnpEztPPA7l9i16M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788727; c=relaxed/simple;
	bh=DHKZMjlwf/gT1smmGENNEyBQrJav66oZw/gezV56R20=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SBuBlcGoPGfeBxwgA5W0FeCbbJT45reUM6CwhycPiJhSqBTkevmvD3Cq5ce8NrSXAOohP5Ur0QJ2UMcW5CmBl4m38tHQYmJjW3kQlAxXNQWgxVaXBaA5YHikmIu7xAdXmo1pgeVn3o2jUQ/Y0zHzQL5szQ9VPCEWNqxVLgwSiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3da731b7df8so20493115ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 04:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788725; x=1747393525;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tc0ZuoFkPnk1RmxLqMAo492S/8BWHFi5cOSxHMIQTns=;
        b=UkRQD5xM2MNCbjhLXTi6KR8pEurTGjGpOEHDufKpJJ4lGm97Y32SloQMFl5IuFms1T
         2p1nSt39Gh0knGeySNWTcBbJL08wj3cs4sdLkWXAA4aowqCtv68wRHKCebH2iP+UL6ku
         xbm6wBqklAIMP6bd1Cb0F5z16Yu/+AaGr8JuXD86Ul3Nrj5EkJ7et61nzncul1I5BLr3
         +qdsFMZ4ctPs7LRMI5M+CBcjslhnQv2n49Th0b+yvn+zP0skLO+7skL9OJwxFczUjDsW
         Jo0P7AyTdY+cmPf7tyGC2YakVKssfPKzvy8Cqu8gfsgRjPcAn5Hou0YkkJPHx6M15VEB
         Smlw==
X-Forwarded-Encrypted: i=1; AJvYcCViSI1n/Kv3D0f+Q9wbEGnd/UuQ29mBFiX6A7E3zIj5tSZryF9QvGKjy/HRNy6kjQbL5KjpnO7cR/q/K7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YykrtNvrhmwPjBwg6xd0KAbY83QQOsN35ntn0uc0rXDUS6Szv0F
	K/YvYz8T3pxQp8feYpcICgkwEG6Oz9lbWiUMQZylHRQfCPnzcBVInXAbJIiX9dhaMMFRNqctDuJ
	27DWdlYiW7td51B2Q+MZ4NzsWda3XgMx6+JHC5/bLyxK6uxMIKSdH6J0=
X-Google-Smtp-Source: AGHT+IFkA0+oY8gN9QvJ8CXxLexUp/bhUxTD/dw7gf7YR8vhLWHtP3KuOGzjcZNqhWNSTfNIkZCXiaa65Najn/xcgYeQQkNBeKLk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e85:b0:3da:71ec:985 with SMTP id
 e9e14a558f8ab-3da78531c85mr85194745ab.2.1746788724767; Fri, 09 May 2025
 04:05:24 -0700 (PDT)
Date: Fri, 09 May 2025 04:05:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681de174.050a0220.a19a9.012d.GAE@google.com>
Subject: [syzbot] [kernel?] linux-next test error: kernel BUG in init_IRQ
From: syzbot <syzbot+f23da7c24d8bef5c18ac@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, mingo@redhat.com, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    ed61cb3d78d5 Add linux-next specific files for 20250509
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D167624d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D34d9647dd1e787d=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3Df23da7c24d8bef5c1=
8ac
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-=
1~exp1~20250402004600.97), Debian LLD 20.1.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a58ec818f89c/disk-=
ed61cb3d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47a111a53991/vmlinux-=
ed61cb3d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/904b8ca84d78/bzI=
mage-ed61cb3d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+f23da7c24d8bef5c18ac@syzkaller.appspotmail.com

CPU topo: Num. cores per package:     1
CPU topo: Num. threads per package:   2
CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xbfffd000-0xffffffff]
[mem 0xc0000000-0xfffbbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_=
idle_ns: 19112604462750000 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:2
percpu: Embedded 70 pages/cpu s246024 r8192 d32504 u1048576
kvm-guest: PV spinlocks enabled
PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Kernel command line: earlyprintk=3Dserial net.ifnames=3D0 sysctl.kernel.hun=
g_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb nf-conntrack-ftp.ports=3D2000=
0 nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.ports=3D20000 nf-conntra=
ck-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000 binder.debug_mask=3D0 =
rcupdate.rcu_expedited=3D1 rcupdate.rcu_cpu_stall_cputime=3D1 no_hash_point=
ers page_owner=3Don sysctl.vm.nr_hugepages=3D4 sysctl.vm.nr_overcommit_huge=
pages=3D4 secretmem.enable=3D1 sysctl.max_rcu_stall_to_panic=3D1 msr.allow_=
writes=3Doff coredump_filter=3D0xffff root=3D/dev/sda console=3DttyS0 vsysc=
all=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 spec_store_bypass_disable=
=3Dprctl nopcid vivid.n_devs=3D64 vivid.multiplanar=3D1,2,1,2,1,2,1,2,1,2,1=
,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,=
1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=3D32 rose.rose_ndevs=3D32 s=
mp.csd_lock_timeout=3D100000 watchdog_thresh=3D55 workqueue.watchdog_thresh=
=3D140 sysctl.net.core.netdev_unregister_timeout_secs=3D140 dummy_hcd.num=
=3D32 max_loop=3D32 nbds_max=3D32 panic_on_warn
Unknown kernel command line parameters "spec_store_bypass_disable=3Dprctl n=
bds_max=3D32 BOOT_IMAGE=3D/boot/bzImage", will be passed to user space.
random: crng init done
printk: log buffer data + meta data: 262144 + 917504 =3D 1179648 bytes
software IO TLB: area num 2.
Fallback order for Node 0: 0 1=20
Fallback order for Node 1: 1 0=20
Built 2 zonelists, mobility grouping on.  Total pages: 2097051
Policy zone: Normal
mem auto-init: stack:all(zero), heap alloc:on, heap free:off
stackdepot: allocating hash table via alloc_large_system_hash
stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=3D2
allocated 167772160 bytes of page_ext
Node 0, zone      DMA: page owner found early allocated 0 pages
Node 0, zone    DMA32: page owner found early allocated 21222 pages
Node 0, zone   Normal: page owner found early allocated 0 pages
Node 1, zone   Normal: page owner found early allocated 19843 pages
Kernel/User page tables isolation: enabled
Dynamic Preempt: full
Running RCU self tests
Running RCU synchronous self tests
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=3D2.
rcu: 	RCU callback double-/use-after-free debug is enabled.
rcu: 	RCU debug extended QS entry/exit.
	All grace periods are expedited (rcu_expedited).
	Trampoline variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D2
Running RCU synchronous self tests
RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=3D1 rcu_task_=
cpu_ids=3D2.
RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=3D1 rcu=
_task_cpu_ids=3D2.
NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
------------[ cut here ]------------
kernel BUG at arch/x86/kernel/irqinit.c:90!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0-rc5-next-20250509-s=
yzkaller #0 PREEMPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 04/29/2025
RIP: 0010:init_IRQ+0x1b7/0x1c0 arch/x86/kernel/irqinit.c:90
Code: 5d 41 5e 41 5f 5d 2e e9 27 13 9c fa 89 d9 80 e1 07 80 c1 03 38 c1 0f =
8c a8 fe ff ff 48 89 df e8 2f c7 64 f2 e9 9b fe ff ff 90 <0f> 0b 0f 1f 80 0=
0 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0000:ffffffff8ca07ee0 EFLAGS: 00010082
RAX: 00000000fffffff4 RBX: 0000000000000010 RCX: 0000000000000000
RDX: ffff888140403280 RSI: ffffffff8aa261c0 RDI: ffffffff8aa26180
RBP: 1ffffffff196c30c R08: ffffffff8d459fd3 R09: 1ffffffff1a8b3fa
R10: dffffc0000000000 R11: fffffbfff1a8b3fb R12: dffffc0000000000
R13: 0000004000000000 R14: ffffffff8cb61900 R15: ffff8880b8a22908
FS:  0000000000000000(0000) GS:ffff8881281a6000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000cb2e000 CR4: 00000000000000b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 start_kernel+0x1cb/0x400 init/main.c:1003
 x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:308
 x86_64_start_kernel+0x66/0x70 arch/x86/kernel/head64.c:289
 common_startup_64+0x13e/0x147
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:init_IRQ+0x1b7/0x1c0 arch/x86/kernel/irqinit.c:90
Code: 5d 41 5e 41 5f 5d 2e e9 27 13 9c fa 89 d9 80 e1 07 80 c1 03 38 c1 0f =
8c a8 fe ff ff 48 89 df e8 2f c7 64 f2 e9 9b fe ff ff 90 <0f> 0b 0f 1f 80 0=
0 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0000:ffffffff8ca07ee0 EFLAGS: 00010082
RAX: 00000000fffffff4 RBX: 0000000000000010 RCX: 0000000000000000
RDX: ffff888140403280 RSI: ffffffff8aa261c0 RDI: ffffffff8aa26180
RBP: 1ffffffff196c30c R08: ffffffff8d459fd3 R09: 1ffffffff1a8b3fa
R10: dffffc0000000000 R11: fffffbfff1a8b3fb R12: dffffc0000000000
R13: 0000004000000000 R14: ffffffff8cb61900 R15: ffff8880b8a22908
FS:  0000000000000000(0000) GS:ffff8881281a6000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000cb2e000 CR4: 00000000000000b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

