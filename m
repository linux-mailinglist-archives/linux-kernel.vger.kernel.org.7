Return-Path: <linux-kernel+bounces-752472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9AB175FA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB949A8134D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4728DEE4;
	Thu, 31 Jul 2025 18:10:37 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE123E325
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985437; cv=none; b=oZOY3ZP/+jDMbWCVhRf7CE0HmN3dApmg0ewkxBA0luY+If+DXYb9kBvNjl21IRN8JlL+Xo7oqEJccAQkGB6bJBl5jfyM3ZQllnjBsRHzzuGjLY2t8h06QizDW5ziyZ+OJUzbaTVi8N248oyscu5wm2MCop27T9YXZ9lFcpWarB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985437; c=relaxed/simple;
	bh=dVkBO3Blw1M7u/7Gq83ObY/d8JaJg/9LtVb3rBuN+lQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ccKm6gvJkbQskVtL4FXS+z3TsDsqmIZYXNrKrKwe52GQUaUvwQz5EbkB60/6JDD6Ob7MTaZ5yuP7QLQ362wAS65BfRVKgdk6neAWphODi2ehsjaOc9w7CM9BsxwIrodeEasR/HptErCgThk9MZCqGDIiJCH7pRtvRaQxJcWr0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-87b89891d5dso200640039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753985435; x=1754590235;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmaWcuuZImYl0mDQkAhmt3J0oJceGWUZsbJrDUdOmRI=;
        b=oXY2gyiw8Qd5WYbGypjuhJltuwuo66rtsfCFdHxqNvSU31PueBL5OetTtq2pe1BpOB
         u+0Z7Y8FimJvqQd2yfXxR+ni8H/nR0JM+Ck1Zp8g8ng0I+KCgcj3tuNqVQSJXFTUCQ3+
         RBmGRgEbSLDfWXa4FDzyBqLzQVCkCgx8rsanNJxkRygrSaC46fF5iOQXpV7DrGREzkmN
         Wp3yc/Zd2Kh1sHvcYaCzHf6eMXhcYIDEOKFCJcW6g7m9YsrJPcQmuUvFCczDV1XkzZCO
         tr2sbrpODV24vyxzIVW/9qxYBm7NAyCn9XYSPXqprXx+SYxDYXBycMVfVDTYui+oBVDu
         Dcfw==
X-Forwarded-Encrypted: i=1; AJvYcCVmRS97cPGujTN+Mnr38EvNIaUxfe6+TJVP7CbIT6ajDDzbj24i9hehH3QymavJ1WTJyCN2WOUaTq9QzTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGXbBwVikpG7z+vbQMkdJJtD038ORzKjrubIl53xQa62e5qoRz
	uLlQxCQdfT+J+0/4hk5Y2hFeluLB3kSVvpHwxJBwgYN1Z3ls7XJGkrl5Z0jtb5BVTGvEbPNr3sY
	4FQpcYZsAF09PIQinZYxOgPQhaYIZ6yqBZ9x4re9jUrt6uq9ccE1eGqauEws=
X-Google-Smtp-Source: AGHT+IEXmvUatQyVhy/YGEy7yRAt/lp31If6wd15LX6kOtPlI3I6kPoVqwc/kgGrCMKOzIQ1dJPqHkusCeulkRT2NwX4/w5aKf9u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:8318:b0:87c:31ad:abe2 with SMTP id
 ca18e2360f4ac-881375dac67mr918287139f.5.1753985434824; Thu, 31 Jul 2025
 11:10:34 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:10:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688bb19a.a00a0220.26d0e1.004d.GAE@google.com>
Subject: [syzbot] [gfs2?] KASAN: null-ptr-deref Write in gfs2_trans_add_revoke
From: syzbot <syzbot+f2b9fe431c853e793948@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    260f6f4fda93 Merge tag 'drm-next-2025-07-30' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1436e9bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6923811cbcd88f
dashboard link: https://syzkaller.appspot.com/bug?extid=f2b9fe431c853e793948
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a93ca2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12089ca2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-260f6f4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28b1dc006a89/vmlinux-260f6f4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dcbc50612705/bzImage-260f6f4f.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/f2243f65af89/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=10089ca2580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/c6557c77eded/mount_8.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=169dc834580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2b9fe431c853e793948@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
BUG: KASAN: null-ptr-deref in gfs2_trans_add_revoke+0x8c/0xe0 fs/gfs2/trans.c:321
Write of size 8 at addr 0000000000000018 by task syz.0.17/5566

CPU: 0 UID: 0 PID: 5566 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-08685-g260f6f4fda93 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
 gfs2_trans_add_revoke+0x8c/0xe0 fs/gfs2/trans.c:321
 gfs2_remove_from_journal+0x43e/0x6d0 fs/gfs2/meta_io.c:366
 gfs2_discard fs/gfs2/aops.c:597 [inline]
 gfs2_invalidate_folio+0x579/0x750 fs/gfs2/aops.c:631
 folio_invalidate mm/truncate.c:140 [inline]
 truncate_cleanup_folio+0x2d5/0x430 mm/truncate.c:160
 truncate_inode_pages_range+0x233/0xda0 mm/truncate.c:379
 do_gfs2_set_flags fs/gfs2/file.c:254 [inline]
 gfs2_fileattr_set+0x80a/0x9b0 fs/gfs2/file.c:311
 vfs_fileattr_set+0x92f/0xb90 fs/file_attr.c:298
 ioctl_setflags+0x17b/0x200 fs/file_attr.c:336
 do_vfs_ioctl+0x8ed/0x1430 fs/ioctl.c:561
 __do_sys_ioctl fs/ioctl.c:596 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f55c3b8eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea6c68328 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f55c3db5fa0 RCX: 00007f55c3b8eb69
RDX: 0000200000000000 RSI: 0000000040086602 RDI: 0000000000000005
RBP: 00007f55c3c11df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f55c3db5fa0 R14: 00007f55c3db5fa0 R15: 0000000000000003
 </TASK>
==================================================================


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

