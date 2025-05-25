Return-Path: <linux-kernel+bounces-661998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342CAC33FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 12:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD9D7AC4DD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 May 2025 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C401E5B62;
	Sun, 25 May 2025 10:51:34 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B91EEE6
	for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748170294; cv=none; b=V3/RxbqHlzHNCkRAAmAyjsw9P5EQw4USSslHzgEtY2toaBpQqRnhVBPDele0krjRfk3W8AVkO5HReCEluwb5IciLuSWlhMi7UUu+E6yH8ZUJ2Ib4ATsp8shlcWP96THS4RgqO/uIuuCMKwS04E29LYwx7uutAq33yZWhKmQlqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748170294; c=relaxed/simple;
	bh=Oa34/m9hCBxB+jJeUi3f27Wm/DyeXjvNCF008TtGAQQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UcQJPTa3WXEYWrIYPAjIuz2W+JhEj5nj7r4QqABOvMqxj8I7InvYphiPU6vDsk/URGkraEGyQq1eT663YMwvo3aZCEf2Doblxmg1u4crH0brVwJZUMFqI+fP0X7qlbTBIgsSD8HLlS9XWcqIEBRipPR0bf1UIyfpbtLONCC94YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b3888569bso111317539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 May 2025 03:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748170292; x=1748775092;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtRZa0aVmC1OpZ7OQyz5QGz3z13z+YI/OAolGa309pI=;
        b=n/O4wagBUxkXNQ3Dv/ZcB2NpRTCyX/C93kQV/Loq13jUoBQLMXI6E/q6AyVf/yVa/H
         UxrWZSuscVGXE4ETix3GVzGwZPuZF+sc9iT27Bya/DpaGaQBrwPIDOXAmhva5/RBpi1E
         zUZZ5RcfnY9m7SUkmzjVoA5R43Dwd1B/PA53o9m24T3WxEerFeFbLV21o4DT5phDVMUA
         JnjqliNoOeyfPX+CrNfKQVvTeTbDDXFSgLTVqApS6AQtTxsYd1y0FwRHmxLI4XzH9+/V
         lNr7uuCEKzv8AlAFHK+PuzIgXPJxKSIXkloEYAtC9KsL3tA1XdL2+KqPS/qq3NEbAahS
         UAzw==
X-Forwarded-Encrypted: i=1; AJvYcCXA729NwGf3TwY7Wpm5N/ulMm7zJMVMJiRYPcMVtpDrJF7uoB8h9kK1zoxpSGh3p/T21Kk8GOveQjXghKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65jTfFm7NgIL/WY0nsEj+X9MPHTJAeZPIAQsEPx228tGGSqrj
	Hj+FMNaZZgwgKHv2TBb/5ZyKnJDGPB0aRoExhoet0tr+lKBcZTDmQ3ZV8eVj53r+qg+8RMsRF0Z
	puJY7mcmFaIYCzdYJX2j+JGDqd/J6iGX7l75mAICI6+3zNygFXd688nVJMgY=
X-Google-Smtp-Source: AGHT+IFlld98JAlDwwVSrgQIBcz+fyTpGDHPtAwKORBWq9vFvptyfXeFQkTa1r8prfYf6v4+YiyxhlSPv5x/c9mOWMAzySwJIv7W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:360b:b0:85b:4310:a91c with SMTP id
 ca18e2360f4ac-86cbb5eedc9mr565893239f.1.1748170291751; Sun, 25 May 2025
 03:51:31 -0700 (PDT)
Date: Sun, 25 May 2025 03:51:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6832f633.a70a0220.253bc2.0087.GAE@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in __ocfs2_decrease_refcount
From: syzbot <syzbot+7774dd506af3f6fb5df5@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b36ddb9210e6 Merge tag 'for-linus-6.15-ofs2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fb69f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9fd1c9848687d742
dashboard link: https://syzkaller.appspot.com/bug?extid=7774dd506af3f6fb5df5
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b36ddb92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e5bf04315bb/vmlinux-b36ddb92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14f603b88226/bzImage-b36ddb92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7774dd506af3f6fb5df5@syzkaller.appspotmail.com

(syz.0.0,5319,0):ocfs2_dio_end_io:2398 ERROR: Direct IO failed, bytes = -28
------------[ cut here ]------------
kernel BUG at fs/ocfs2/refcounttree.c:2242!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5319 Comm: syz.0.0 Not tainted 6.15.0-rc7-syzkaller-00002-gb36ddb9210e6 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__ocfs2_decrease_refcount+0x1603/0x1780 fs/ocfs2/refcounttree.c:2242
Code: fe c6 05 07 19 cb 0b 01 90 48 c7 c7 40 5b aa 8b e8 52 34 e6 fd 90 0f 0b 90 90 e9 a7 eb ff ff e8 43 6c b8 07 e8 ae d7 21 fe 90 <0f> 0b e8 a6 d7 21 fe 90 0f 0b e8 9e d7 21 fe 90 0f 0b e8 96 d7 21
RSP: 0018:ffffc9000d3b6880 EFLAGS: 00010287
RAX: ffffffff839e1a22 RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000e613000 RSI: 0000000000004b6e RDI: 0000000000004b6f
RBP: ffffc9000d3b6b40 R08: ffff88801f6da440 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000002 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffc9000d3b6930 R15: 0000000000000001
FS:  00007f9d9ebc46c0(0000) GS:ffff88808d6c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555b9e1cb168 CR3: 00000000353f0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_decrease_refcount+0x573/0x730 fs/ocfs2/refcounttree.c:2312
 ocfs2_remove_btree_range+0x11c0/0x1540 fs/ocfs2/alloc.c:5791
 ocfs2_commit_truncate+0xb64/0x21d0 fs/ocfs2/alloc.c:7373
 ocfs2_truncate_file+0xca2/0x1420 fs/ocfs2/file.c:509
 ocfs2_setattr+0x1520/0x1b40 fs/ocfs2/file.c:1212
 notify_change+0xb36/0xe40 fs/attr.c:552
 do_truncate+0x19a/0x220 fs/open.c:65
 handle_truncate fs/namei.c:3501 [inline]
 do_open fs/namei.c:3884 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4039
 do_filp_open+0x1fa/0x410 fs/namei.c:4066
 do_sys_openat2+0x121/0x1c0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_creat fs/open.c:1522 [inline]
 __se_sys_creat fs/open.c:1516 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1516
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9d9dd8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9d9ebc4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f9d9dfb6080 RCX: 00007f9d9dd8e969
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 00002000000002c0
RBP: 00007f9d9de10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9d9dfb6080 R15: 00007ffeb64bb688
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__ocfs2_decrease_refcount+0x1603/0x1780 fs/ocfs2/refcounttree.c:2242
Code: fe c6 05 07 19 cb 0b 01 90 48 c7 c7 40 5b aa 8b e8 52 34 e6 fd 90 0f 0b 90 90 e9 a7 eb ff ff e8 43 6c b8 07 e8 ae d7 21 fe 90 <0f> 0b e8 a6 d7 21 fe 90 0f 0b e8 9e d7 21 fe 90 0f 0b e8 96 d7 21
RSP: 0018:ffffc9000d3b6880 EFLAGS: 00010287
RAX: ffffffff839e1a22 RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000e613000 RSI: 0000000000004b6e RDI: 0000000000004b6f
RBP: ffffc9000d3b6b40 R08: ffff88801f6da440 R09: 0000000000000006
R10: 00000000fffffffc R11: 0000000000000002 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffc9000d3b6930 R15: 0000000000000001
FS:  00007f9d9ebc46c0(0000) GS:ffff88808d6c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555b9e1cb168 CR3: 00000000353f0000 CR4: 0000000000352ef0
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

