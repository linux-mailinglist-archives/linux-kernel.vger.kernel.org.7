Return-Path: <linux-kernel+bounces-779944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64530B2FB64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0075EAE3D31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487428DF36;
	Thu, 21 Aug 2025 13:48:35 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA42255222
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784114; cv=none; b=fP6e2xG9s659OKpwsrIdaKjxL0ukrx1B2wRpuO03UMJIeBZxDa2XUddPdgZoMzLPslFFOIDmUETYYKtYJSRPJxb7EAWMQqo5mSDl76+xEn48aP3/a78KXmhYdGzq7/vJtI8Xhl5/F63GbhU8jo07kK80DBSGa2lBEqIE8ID/AmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784114; c=relaxed/simple;
	bh=QPzLBIr4gsTUMqIIsAPK4l2yxUehyDvGERyI2n0otHc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZZ3QVdv41glMj+AabLOcqnvIqdgaUFcY5N0Opj45N7AuyMXDeZaqqOnVEcskIz0XI/KLDkWDp+wf8NaC6xVUiOPwxANvATd3FRBem+rPtA0mlEWuU7Vd5iy1eT6Vs2JpMCHXRDG597m8iV3rR9szs6BbXoACGO4t6+Tb9P6Vnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e6649d783bso22761885ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784112; x=1756388912;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dM39bhFfKQvEU5ZVLy2qtymq680cCKn9jGpbpwOpVGw=;
        b=eVAb48ZxxMkPc3o3PLrv5EWZTJBYwjQPK5JiprSeJCYsjbAjEz7UryW6vAyiYz+3yP
         Qs0xkbY7+4D+F3mZEh2af7e+Wn1lva5HHSyFBF6dDTODrgLpz6pwotxTu7Fvp6WYdtr8
         4V6VMHtgyylNqMIEaNspo/5u4RQnWumkdF58fZSBN5Ni3Q0OgJh/B3sjeVdpVlzrfVr2
         kbNQfVfwLe3T93poweKVTLO/a3vFQ+8C/xIB5zPkaHhicwbTNqkdizOU7cGfyxWApuTW
         xB6pYUWZgj7/MNfFNZvziVgSoSVj1vyl8CFV3eGHYjr0tbOFTlY3d1wj7VO2Xu53R+9B
         otMA==
X-Forwarded-Encrypted: i=1; AJvYcCXNdedSQK9iI7tlr8nIBGAtROJPnTBPQMohtzHvK4MFYZNUHoq+HDUWmaQBVLXNQ2Gc1GVlAuBz7Eht1/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe73fHmc9uz4tlfajQRsfI19vm9/9hxTC4DrZhXPaZqkQfrCrt
	Eh6Oq9yK8XMqsv1fy/Tb+Ei2y6+ZCN1TrXGlweQGOYCvJwO0aSQtepRMWSS0PpgCc+oNFJ4f1uB
	WMqS1cjBXlEc94Ecr5+yH7dmHQiwWnw5mf+ZnUUPvIbfXDZK9hPSzd6L4Hr8=
X-Google-Smtp-Source: AGHT+IHjBEDyzI2bgi3qzYUQK4qU2RDA4pJPjPClRn2+OHiizIpWwkD/GAWwaEm85R+bM7hcfKm6bCs4uMSwbqjg4MKjBCcNfbOT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4515:10b0:3e8:cd52:4ccf with SMTP id
 e9e14a558f8ab-3e8cd526232mr6309365ab.18.1755784112235; Thu, 21 Aug 2025
 06:48:32 -0700 (PDT)
Date: Thu, 21 Aug 2025 06:48:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a723b0.050a0220.3d78fd.0029.GAE@google.com>
Subject: [syzbot] [ocfs2?] INFO: task hung in ocfs2_page_mkwrite (2)
From: syzbot <syzbot+541dcc6ee768f77103e7@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    99bade344cfa Merge tag 'rust-fixes-6.17' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14222442580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce98061fb8ee27bc
dashboard link: https://syzkaller.appspot.com/bug?extid=541dcc6ee768f77103e7
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d2faf0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d2faf0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d660b67f436/disk-99bade34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0bfb9fd6d898/vmlinux-99bade34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/387d6017422c/bzImage-99bade34.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d1682febf5d8/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=12d2faf0580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+541dcc6ee768f77103e7@syzkaller.appspotmail.com

INFO: task syz-executor241:5854 blocked for more than 143 seconds.
      Not tainted 6.17.0-rc1-syzkaller-00214-g99bade344cfa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor241 state:D stack:21256 pid:5854  tgid:5854  ppid:5853   task_flags:0x400140 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 rwsem_down_write_slowpath+0x872/0xfe0 kernel/locking/rwsem.c:1185
 __down_write_common kernel/locking/rwsem.c:1317 [inline]
 __down_write kernel/locking/rwsem.c:1326 [inline]
 down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1591
 ocfs2_page_mkwrite+0x2ff/0xc40 fs/ocfs2/mmap.c:142
 do_page_mkwrite+0x14d/0x310 mm/memory.c:3361
 wp_page_shared mm/memory.c:3762 [inline]
 do_wp_page+0x268d/0x5800 mm/memory.c:3981
 handle_pte_fault mm/memory.c:6068 [inline]
 __handle_mm_fault+0x1033/0x5440 mm/memory.c:6195
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
 do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
RIP: 0010:raw_copy_to_user arch/x86/include/asm/uaccess_64.h:147 [inline]
RIP: 0010:_inline_copy_to_user include/linux/uaccess.h:197 [inline]
RIP: 0010:_copy_to_user+0x85/0xb0 lib/usercopy.c:26
Code: e8 00 bc f7 fc 4d 39 fc 72 3d 4d 39 ec 77 38 e8 91 b9 f7 fc 4c 89 f7 89 de e8 47 25 5b fd 0f 01 cb 4c 89 ff 48 89 d9 4c 89 f6 <f3> a4 0f 1f 00 48 89 cb 0f 01 ca 48 89 d8 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000403f950 EFLAGS: 00050256
RAX: ffffffff84c7f101 RBX: 0000000000000038 RCX: 0000000000000038
RDX: 0000000000000000 RSI: ffffc9000403f9e0 RDI: 0000200000000060
RBP: ffffc9000403fa90 R08: ffffc9000403fa17 R09: 1ffff92000807f42
R10: dffffc0000000000 R11: fffff52000807f43 R12: 0000200000000098
R13: 00007ffffffff000 R14: ffffc9000403f9e0 R15: 0000200000000060
 copy_to_user include/linux/uaccess.h:225 [inline]
 fiemap_fill_next_extent+0x1c0/0x390 fs/ioctl.c:145
 ocfs2_fiemap+0x888/0xc90 fs/ocfs2/extent_map.c:806
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1173/0x1430 fs/ioctl.c:532
 __do_sys_ioctl fs/ioctl.c:596 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f13850fd9
RSP: 002b:00007ffe3b3518b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007f5f13850fd9
RDX: 0000200000000040 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 6165627472616568 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe3b3518f0
R13: 00007ffe3b351b18 R14: 431bde82d7b634db R15: 00007f5f1389a03b
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.17.0-rc1-syzkaller-00214-g99bade344cfa #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc1-syzkaller-00214-g99bade344cfa #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 3e dd 96 f5 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 c7 0e 00 f3 0f 1e fa fb f4 <e9> 13 dd 96 f5 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8de07d80 EFLAGS: 000002c2
RAX: 67466ec3a757a800 RBX: ffffffff81968308 RCX: 67466ec3a757a800
RDX: 0000000000000001 RSI: ffffffff8be334e0 RDI: ffffffff81968308
RBP: ffffffff8de07eb8 R08: ffff8880b8632f9b R09: 1ffff110170c65f3
R10: dffffc0000000000 R11: ffffed10170c65f4 R12: ffffffff8fa38130
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffffffff1bd2a20
FS:  0000000000000000(0000) GS:ffff888125c1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005559e8184660 CR3: 000000000df36000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 rest_init+0x2de/0x300 init/main.c:744
 start_kernel+0x3a9/0x410 init/main.c:1097
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
 common_startup_64+0x13e/0x147
 </TASK>


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

