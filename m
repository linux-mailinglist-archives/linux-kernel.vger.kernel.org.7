Return-Path: <linux-kernel+bounces-872587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 798ECC1183A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B2D24E67BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B66328619;
	Mon, 27 Oct 2025 21:18:35 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F52DCC1A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599914; cv=none; b=DzhgWAmmhxeYnVnBGTdLDQa4QhZiE3m2eEHCy/hHMPhfuuct7jNotqVs0+HREKqW5firtZ0iwIX/t5DzQJ6o4gmqXG4ZxocicLcY5fdsbF4F44Bla1sRPJbh4KTGjOG1sQpkaYqhoDs/SUAXWSvNwJLuwyfcNbfQan3FHCaHpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599914; c=relaxed/simple;
	bh=X+jtCqU5yQL7NkWd9TYOCUpJTY+5eyxjzjojxoethrM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W2q4uNMHvoemKNbAN0nkbdhiDSiQulSJgtmp3npTL+Wj+VTYFW+cv7CfFhGyz5VFlQJqM1nq0/4+AjO0+a7seHGunTz1CMarqiSuMDgVRFJ7nX8BCQSf6ci6NPdUXVwbpGy6pH/bdnQ7xPmLA4r7tswzl2BJCz5TopQLDSYIR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-430c6b6ce73so155024815ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761599912; x=1762204712;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4EkWfyUu2EKMYSWMO58Kw2PSZVDedjYKfMXcj2zumE=;
        b=OrDX9ro5oqVN6eCkpTyUWSqyq6LwqiVcnd6x0FmGeDKwUP/MNu11BdnAf2ma8d/VWM
         2ihAvJczuFmClx4n0B/IBarbvQRnwNtVu1XRSkcWsk98iq9kYsHodv1pngQq0SHDzVmc
         iJAF3q3+4pUr5qGAfUyO5Q3COln60/JoYyBPZcrxB0x5JJ8owY+m4BrzvWBNWDz6GFrm
         5bkWDTbkkJtPJsAofyuUKvII6U+SDy566NwALnNEOZAow8Md/kw5tjSWe+Ae04O14njV
         80bvit9fkouJ+Usyk51SoqaySsDf+C5NtEmE7kF+b8pK98+yLBaxSGs7I5DYyA+jeMRE
         ADgw==
X-Forwarded-Encrypted: i=1; AJvYcCXuWga/OmcuUaPt8wo9c0sd9b3Wv6LdTg66b40Ok1uf+DMxhhHHvNMP9s49ypgAPD8zdt7REdnAVEeSHf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSx0Yp1Havj5lxmZghi0s+6gZ65kFN9fAkDXgM6SnNqyv/E+q
	pDJzK6qrFEUEttZfQ6GtxlDBL/EcOJQA5ILR37AuKlSoaAEgnAyxlJo3RMJcLui7MWHLUNqmELR
	b8oIMe2P5F5/tB5u2CK0iTafd7KfxPY49HGnxtkHiVVYCMHOnRmS8ehh/cjA=
X-Google-Smtp-Source: AGHT+IGSIx4R/X+4T/h9VAdXT+ZzvTHIkrzU8hH3yNfGn1bm9RGGyFg81lGOQFSxvhErxsCtiLjf5GstT11RlozeYZbsRr+x/HDB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148f:b0:430:c394:15a3 with SMTP id
 e9e14a558f8ab-4320f841926mr20056985ab.22.1761599912043; Mon, 27 Oct 2025
 14:18:32 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:18:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ffe1a8.050a0220.3344a1.03a0.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in raw_alloc_io_data
From: syzbot <syzbot+a894fe5447d0543e89c9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160597e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=609c87dcb0628493
dashboard link: https://syzkaller.appspot.com/bug?extid=a894fe5447d0543e89c9
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11af27e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c2d614580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dcb6fa37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/61176fd888a1/vmlinux-dcb6fa37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84e7e9924c22/bzImage-dcb6fa37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a894fe5447d0543e89c9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 6091 at mm/page_alloc.c:5159 __alloc_frozen_pages_noprof+0x309/0x2470 mm/page_alloc.c:5159
Modules linked in:
CPU: 3 UID: 0 PID: 6091 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_frozen_pages_noprof+0x309/0x2470 mm/page_alloc.c:5159
Code: f0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 83 fe 0a 0f 86 0c fe ff ff 80 3d d4 63 52 0e 00 75 0b c6 05 cb 63 52 0e 01 90 <0f> 0b 90 45 31 f6 eb 81 4d 85 f6 74 22 44 89 fa 89 ee 4c 89 f7 e8
RSP: 0018:ffffc9000371f9f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000014 RDI: 0000000000040cc0
RBP: 0000000000000014 R08: 0000000000000005 R09: 0000000000000009
R10: 0000000000000014 R11: 0000000000000001 R12: 0000000000040cc0
R13: 1ffff920006e3f55 R14: ffffffff9ab2c464 R15: 0000000000000014
FS:  000055557bf92500(0000) GS:ffff8880d6d0a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f84d9710300 CR3: 0000000032452000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 ___kmalloc_large_node+0xed/0x160 mm/slub.c:5583
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:5614
 __do_kmalloc_node mm/slub.c:5630 [inline]
 __kmalloc_noprof.cold+0xc/0x62 mm/slub.c:5654
 kmalloc_noprof include/linux/slab.h:961 [inline]
 raw_alloc_io_data drivers/usb/gadget/legacy/raw_gadget.c:673 [inline]
 raw_alloc_io_data+0x12c/0x1a0 drivers/usb/gadget/legacy/raw_gadget.c:659
 raw_ioctl_ep0_read drivers/usb/gadget/legacy/raw_gadget.c:776 [inline]
 raw_ioctl+0x1397/0x2c30 drivers/usb/gadget/legacy/raw_gadget.c:1313
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f84d938efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe768729f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f84d95e5fa0 RCX: 00007f84d938efc9
RDX: 0000200000000080 RSI: 00000000c0085504 RDI: 0000000000000006
RBP: 00007f84d9411f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f84d95e5fa0 R14: 00007f84d95e5fa0 R15: 0000000000000003
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

