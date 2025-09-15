Return-Path: <linux-kernel+bounces-817697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F291BB5857D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CC61AA1B63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB528726D;
	Mon, 15 Sep 2025 19:51:02 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607821F4613
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965862; cv=none; b=Jah17JMmG5SjqdQxHA6FQeUvj8o/9PYcSIpIF5jJqROepVgqqB7S1xpfs7yBhhd6aFf8xM9lbwlqyWZE1q4cZk9P4YK9gJpD2Cf/+tPN/X2+QPNKWxErvQsfIim3IV/7DzVxg0ZWLa1K5/BVy94HrD/iWa4+PYGrQNm/R0fCOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965862; c=relaxed/simple;
	bh=NjBWBZVsmsQXEpRKShFK1wXm3i9fNkL1XzvJi5VRBxQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YWTQHL8MQbe8T0/g00ipda1e9WLHFzj0mHocoisg4EV2l7J/0x2M2K2maIYqYiJkAi4IvOVqDrK8eJ51sOI5v/Cmfq8UoroSdEqN16W5TNcz4Z+1sN9RhKatSLMETKxHZiIhzyZ5qeTJLEBa49gb9c0il7Ksyy/8T9Os1RD1e4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4111411b387so42438885ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965859; x=1758570659;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEukhVmFZEX1MlIRnvLM45nVaJ6BfTXf9ETGB8WygQk=;
        b=XD9DCuBLTQZqyssApj1os8K+ZqPRA1fNYddLraFZJkqgeiVkPKwEeyMJwzLSDXBd3b
         plvnFKJ7jAt+HX8CrIux+9Gx1+6dAkpBjFN5GdNJPT25JrWW2ImGoZ/26sggcRQ/ywTc
         DD0lGHjy0OS/Mae0SnxE6OJnrJGrcOwY0lwiKc2L2NYDTJw4D8B4FO/Oi5KgsThc6nFS
         J2Lkg5crRbZ6/6IsU5cCAs13NuHBbonRzmvarCrLbIYajLXzWTy98K0YO1PsOAu1xZUw
         8+x3bhtMva8EZ3sOtyTnYgp3BpWFnMqyca7TBx/W7XIA1qGwRNrazwfOx1/NPdor59uD
         C46Q==
X-Gm-Message-State: AOJu0YwGlon499NUPXZk88jXkBanHBNTd1AAbtDqDH7RQG9uy0breZ/V
	AkXG+oDiL3TdQ0V05cDd5XkeeZ/vr/p1a9soqw+HHKyjWkPPE/8npTgzaZPoXvI7kU5h+QFO1N/
	O85CxXKSQO6ZtQoBuaiXBl7UauAbkLaXd+E2caO40IBwDIo2e5Gp7QHi0qTGR/Q==
X-Google-Smtp-Source: AGHT+IHEsPOhcr00O7P828XiMKxgaWx/QWPi8hoqHSSu8bPD3GVkToT8m1YnvoynjZXFh3y21qo1GsSmnml4Aoz3zKkeW6REb4HQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3783:b0:419:671:25b7 with SMTP id
 e9e14a558f8ab-420a4268b8fmr121462415ab.24.1757965859410; Mon, 15 Sep 2025
 12:50:59 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:50:59 -0700
In-Reply-To: <68c85874.050a0220.50883.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c86e23.050a0220.2ff435.03ab.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [input?] KASAN: stack-out-of-bounds Read in cp2112_xfer
From: syzbot <syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [input?] KASAN: stack-out-of-bounds Read in cp2112_xf=
er
Author: deepak.takumi.120@gmail.com

#syz test


On Mon, Sep 15, 2025 at 11:48=E2=80=AFPM syzbot
<syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5cd64d4f9268 Merge tag 'ceph-for-6.17-rc6' of https://git=
h..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16c0db1258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d8792ecb6308=
d0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7617e19c8a59edf=
bd879
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11240762580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1552db6258000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3840aa3ff580/dis=
k-5cd64d4f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aa965f106402/vmlinu=
x-5cd64d4f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/88839eb3c76c/b=
zImage-5cd64d4f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: stack-out-of-bounds in cp2112_write_req drivers/hid/hid-cp211=
2.c:477 [inline]
> BUG: KASAN: stack-out-of-bounds in cp2112_xfer+0x713/0xf10 drivers/hid/hi=
d-cp2112.c:692
> Read of size 34 at addr ffffc90003c0fd21 by task syz.0.17/6028
>
> CPU: 1 UID: 0 PID: 6028 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/18/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xca/0x240 mm/kasan/report.c:482
>  kasan_report+0x118/0x150 mm/kasan/report.c:595
>  check_region_inline mm/kasan/generic.c:-1 [inline]
>  kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
>  __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
>  cp2112_write_req drivers/hid/hid-cp2112.c:477 [inline]
>  cp2112_xfer+0x713/0xf10 drivers/hid/hid-cp2112.c:692
>  __i2c_smbus_xfer+0x5b6/0x1e50 drivers/i2c/i2c-core-smbus.c:591
>  i2c_smbus_xfer+0x275/0x3c0 drivers/i2c/i2c-core-smbus.c:546
>  i2cdev_ioctl_smbus+0x43d/0x6d0 drivers/i2c/i2c-dev.c:389
>  i2cdev_ioctl+0x5d3/0x7f0 drivers/i2c/i2c-dev.c:478
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f44e378eba9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcb2858658 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f44e39d5fa0 RCX: 00007f44e378eba9
> RDX: 0000200000000040 RSI: 0000000000000720 RDI: 0000000000000004
> RBP: 00007f44e3811e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f44e39d5fa0 R14: 00007f44e39d5fa0 R15: 0000000000000003
>  </TASK>
>
> The buggy address belongs to stack of task syz.0.17/6028
>  and is located at offset 33 in frame:
>  i2cdev_ioctl_smbus+0x0/0x6d0 drivers/i2c/i2c-dev.c:317
>
> This frame has 1 object:
>  [32, 66) 'temp'
>
> The buggy address belongs to a vmalloc virtual mapping
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5724=
d
> memcg:ffff888026b61482
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff ffff888026b61482
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(G=
FP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO|__GFP_NOWARN), pid 5953, tgid 5953 (syz.=
0.10), ts 82929749894, free_ts 82841187973
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
>  prep_new_page mm/page_alloc.c:1859 [inline]
>  get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
>  __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
>  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
>  alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
>  alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2507
>  vm_area_alloc_pages mm/vmalloc.c:3642 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3720 [inline]
>  __vmalloc_node_range_noprof+0x97d/0x12f0 mm/vmalloc.c:3893
>  __vmalloc_node_noprof+0xc2/0x110 mm/vmalloc.c:3956
>  alloc_thread_stack_node kernel/fork.c:311 [inline]
>  dup_task_struct+0x3e7/0x860 kernel/fork.c:881
>  copy_process+0x54b/0x3c00 kernel/fork.c:2004
>  kernel_clone+0x21e/0x840 kernel/fork.c:2605
>  __do_sys_clone3 kernel/fork.c:2909 [inline]
>  __se_sys_clone3+0x256/0x2d0 kernel/fork.c:2888
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5941 tgid 5941 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1395 [inline]
>  __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
>  vfree+0x25a/0x400 mm/vmalloc.c:3434
>  kcov_put kernel/kcov.c:439 [inline]
>  kcov_close+0x28/0x50 kernel/kcov.c:535
>  __fput+0x449/0xa70 fs/file_table.c:468
>  task_work_run+0x1d1/0x260 kernel/task_work.c:227
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0x6b5/0x2300 kernel/exit.c:961
>  do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
>  get_signal+0x1286/0x1340 kernel/signal.c:3034
>  arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>  do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffffc90003c0fc00: 00 00 00 00 f1 f1 f1 f1 00 f3 f3 f3 00 00 00 00
>  ffffc90003c0fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffc90003c0fd00: f1 f1 f1 f1 00 00 00 00 02 f3 f3 f3 f3 f3 f3 f3
>                                            ^
>  ffffc90003c0fd80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
>  ffffc90003c0fe00: 04 f2 00 00 f2 f2 00 00 f3 f3 f3 f3 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/68c85874.050a0220.50883.0016.GAE%40google.com.

