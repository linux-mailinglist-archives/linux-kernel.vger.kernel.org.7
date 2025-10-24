Return-Path: <linux-kernel+bounces-869598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5615C08471
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC24ED7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B104D30DD2F;
	Fri, 24 Oct 2025 23:11:31 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A12BE03E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347491; cv=none; b=olZ0OpNlom4nIig1LqWd1C8nz9WlwFs+/dYKEMdP3jysmS66pBNMbELvYaiWS5b2bXraScNQN5qcygFFWCSjTof8SEuTZWXez5NzYapnElrufqjX5eOQaK4VFTOY1jKmzXDb/kNHIwcijYapPqzV0kW0xfaoavwbZInJtCIzeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347491; c=relaxed/simple;
	bh=D0HhoPZUUI003Dr0/Z82VmkSMWyCgcVcSc/NG0S2ZRo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CIWECmqkjnZu4c3fb1qAZprcn9oOotzYkMDJZr3G28yek3CNk20XoAEwxaV8bEKu278ffi4PLkMNljAth3bjhlWAgcnGPtiGWMdE+VV01pjJuVh4N12D8cOAlFgY0LUJdTdNNdsH3ZW7bWV04sblVl1nc9x6fwiqp09/8oF6DMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-430da49fcbbso34924755ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761347489; x=1761952289;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLmm+C3ZCh8Qp07LUG92nktccaTXL6AyWpT7k1Nn7as=;
        b=TEK89HIHRuYncimk0drf8+FbKRKolGQbMq9CXFGJ54awcEXeURzNJKBRJmIfTx4dEc
         736zadeiYdolMV2kYYIaGkxy+wnyLxC/a8GEqHx2D9mooBmonPebIcAo0IJMBm7Du+uO
         ERw8pB24kwyAWm9tI50nc3OcuVo39Q4mu/L4iKwCDkPHh/QwFcOPPI+gJIqtGErbf8/H
         EUxk1yJ3c3/N0Rq0vU74v1PB72lNV/VCDShjKUfwXFv0sGXraKgj3k3h3SLxykYvmEmV
         xJDVRUt+z4/TuFkJZgtmR0bZpWOvDDzeWal98sEGp66cSpTudsyc/kO1rBFYv9jEMP5d
         McIA==
X-Forwarded-Encrypted: i=1; AJvYcCUaLXQXYMlbDLrhUCOJJVQjLOZhIJbyBiQ+WesDNdRLjQqNRiI+HB3Sa1qarX54yH8NWSL8+IdRUZ5H4YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQ9ekxFjNlrW3s02o4wid2S7uUqKJmQIYIw9WUFmommPdePKf
	/+4/uGV8Mq/1ddXa0IFmta1kyYDZcZ2oCvZVOZ1dFSzCkuoyZGs2IzkAmmqBD8I5ZIAgqUqwUsw
	iN86dNjjt8vPf5KBlWtod9X66IY+txp2DyHfCfoUTYt8TlQ7LQDYtkFFd7tc=
X-Google-Smtp-Source: AGHT+IGBSt7L9vcY/WLMU3vVT94oq8gMy2FOzTxRk6D8OcXsdeJI+zG817jRuUkMRphkH0xsDYJq2/MlLo8Wb4O54yFIpGU1eoZJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:42f:6790:476c with SMTP id
 e9e14a558f8ab-430c52d5323mr419014795ab.23.1761347488684; Fri, 24 Oct 2025
 16:11:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:11:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in raw_ioctl
From: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    72fb0170ef1f Add linux-next specific files for 20251024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10fd0be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e812d103f45aa955
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fd35fa6177afa8c92b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119eae7c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140693e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be1fa3d1f761/disk-72fb0170.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57302bf7af40/vmlinux-72fb0170.xz
kernel image: https://storage.googleapis.com/syzbot-assets/91c806bb2a2b/bzImage-72fb0170.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/page_alloc.c:5190 at __alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5190, CPU#1: syz.0.17/6001
Modules linked in:
CPU: 1 UID: 0 PID: 6001 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5190
Code: 74 10 4c 89 e7 89 54 24 0c e8 64 b9 0d 00 8b 54 24 0c 49 83 3c 24 00 0f 85 a5 fe ff ff e9 a6 fe ff ff c6 05 b1 7d 70 0d 01 90 <0f> 0b 90 e9 18 ff ff ff a9 00 00 08 00 48 8b 4c 24 10 4c 8d 44 24
RSP: 0018:ffffc90003017920 EFLAGS: 00010246
RAX: ffffc90003017900 RBX: 0000000000000013 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003017988
RBP: ffffc90003017a18 R08: ffffc90003017987 R09: 0000000000000000
R10: ffffc90003017960 R11: fffff52000602f31 R12: 0000000000000000
R13: 1ffff92000602f28 R14: 0000000000040cc0 R15: dffffc0000000000
FS:  000055558dedb500(0000) GS:ffff888125ddc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef4504a80 CR3: 0000000072ffa000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2418
 ___kmalloc_large_node+0x5f/0x1b0 mm/slub.c:5583
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:5614
 __do_kmalloc_node mm/slub.c:5630 [inline]
 __kmalloc_noprof+0x4c9/0x800 mm/slub.c:5654
 kmalloc_noprof include/linux/slab.h:961 [inline]
 raw_alloc_io_data drivers/usb/gadget/legacy/raw_gadget.c:673 [inline]
 raw_ioctl_ep_read drivers/usb/gadget/legacy/raw_gadget.c:1162 [inline]
 raw_ioctl+0x18fb/0x3be0 drivers/usb/gadget/legacy/raw_gadget.c:1325
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fccefd8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef4505ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcceffe5fa0 RCX: 00007fccefd8efc9
RDX: 00002000000000c0 RSI: 00000000c0085508 RDI: 0000000000000004
RBP: 00007fccefe11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcceffe5fa0 R14: 00007fcceffe5fa0 R15: 0000000000000003
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

