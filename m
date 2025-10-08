Return-Path: <linux-kernel+bounces-844979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5BEBC3303
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 221FB4E7333
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614DE29BDA3;
	Wed,  8 Oct 2025 03:12:27 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378122877C2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893146; cv=none; b=lhOjJ9les84lsYA1mH+B6DVTUwk9M0uGdLq3O7NNREjlxMdIy1/T9mRoKDPw4II1m321op/57vSxCuEExCdbdvzxgNH/TjRfHpvI+PX+kqvyIbQNieLicZIwDa4CzH3auo1he7KZaFnH1j2Jgl05mEf0bwl78u+SKAd3qtuV42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893146; c=relaxed/simple;
	bh=6vLD9JDTClmSPNmyzOCx0WSv9MCpjdLlKHnC8gRouTA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dy+R6XcaUo8v3Ej+uhDxTMqxVDBGM7hYwTT0Y3Mn+BXh1PjkHpus85F/zIUcvL2C4u7Vn6tzO3VXHQRMcljLmaL51oKZql7vMXU5AeJuWPwe0Kfkx3ui4zF4xlM+NDwagHf1nXLL0ng2rkcYQ+TI9u6evbPVKKkK6OZdiz+eGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-9201572ebfbso1835792739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759893144; x=1760497944;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwTLc9AEDgMWzLb+oR9MzDN6KMGy+Scrkcp5Out2arU=;
        b=s5EjvunOL9qL5tUaRyCzS2B1rUrxJj/zjQeAVn+K792niZBX9B7zaAekDF3CsgFuh0
         xOPItq0QP8HnvGO5kxeGqzOh+kVY446mSgK5gambesOWzPtfmenEA6nZiBg/Ah41sVg1
         TlHd7VHYtx6zXC3MYcCoLKOa4keBiObz+zIJ0qmPSL08tZKYpFoHOUV/C5DLCsp+lSO0
         oURGGL3iwAgMMdbnqIscghquxYmsiBT3SvzJjYypFWUvBgm9bSF9wDrTyoko0KYZV2Bg
         qwaJiiSNJP3wQ0SFzMjgHU1AVGjajk1lIbyE7nWUuP0PgNcyXw9+vXtS0CHIPXdpCX2e
         sTgA==
X-Forwarded-Encrypted: i=1; AJvYcCXO8YF/XnWEAhoY9Df8CJ+FMHR+T3IcuO/IifSIqb9OrKcLjUcjsPWR5ZP7wMnWYc5ZbMExPH+PU4SZzNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziD0pXeRLXppoAPqk7As6eoHxN65CdScr0cR3StHTeycC/CPey
	vBvoZtR8W3JgRBNMQppt/o4mpyJAAxlALVBE10030ji5b4nNJvyymYqC9gK8t9fa/qN+aQf+Jpb
	x8r+KKlNSVias4iJsMxuBn010vkZLcNPQWfMUZq6vvkTuQ2O9m7FXEsUgLMw=
X-Google-Smtp-Source: AGHT+IHmcsQj2dWrBzBGYQBWtULG+EjlZGzb57hXahEETnTDtOXPKLZMimsmY+Rf1v9++8MfERfpMU6ba2KtDSvQstedRcq0i/6Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60cc:b0:93b:b7e9:95c2 with SMTP id
 ca18e2360f4ac-93bd182ef7bmr178972639f.2.1759893144252; Tue, 07 Oct 2025
 20:12:24 -0700 (PDT)
Date: Tue, 07 Oct 2025 20:12:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5d698.050a0220.256323.0032.GAE@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in __update_extent_tree_range
From: syzbot <syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccb4d203fe4 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130b4458580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0e74def2d38a839
dashboard link: https://syzkaller.appspot.com/bug?extid=24124df3170c3638b35f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2ccb4d20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/749f87aeac3d/vmlinux-2ccb4d20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c8888fbaabd/bzImage-2ccb4d20.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 131072
F2FS-fs (loop0): f2fs_recover_fsync_data: recovery fsync data, check_only: 0
F2FS-fs (loop0): Mounted with checkpoint version = 1b41e955
F2FS-fs (loop0): access invalid blkaddr:16711680
CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __f2fs_is_valid_blkaddr+0xe52/0x14f0 fs/f2fs/checkpoint.c:213
 f2fs_do_zero_range fs/f2fs/file.c:1647 [inline]
 f2fs_zero_range+0xef0/0x1580 fs/f2fs/file.c:1737
 f2fs_fallocate+0x583/0x990 fs/f2fs/file.c:2030
 vfs_fallocate+0x669/0x7e0 fs/open.c:342
 ioctl_preallocate fs/ioctl.c:289 [inline]
 file_ioctl+0x611/0x780 fs/ioctl.c:-1
 do_vfs_ioctl+0xb33/0x1430 fs/ioctl.c:576
 __do_sys_ioctl fs/ioctl.c:595 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f07bc58eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f07bd4f2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f07bc7e5fa0 RCX: 00007f07bc58eec9
RDX: 0000200000000040 RSI: 0000000040305839 RDI: 0000000000000004
RBP: 00007f07bc611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f07bc7e6038 R14: 00007f07bc7e5fa0 R15: 00007ffdf7c46b18
 </TASK>
F2FS-fs (loop0): __update_extent_tree_range: extent len is zero, type: 0, extent [0, 0, 0], age [0, 0]
------------[ cut here ]------------
kernel BUG at fs/f2fs/extent_cache.c:678!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__update_extent_tree_range+0x13bc/0x1500 fs/f2fs/extent_cache.c:678
Code: 48 c7 c2 60 62 93 8b 48 c7 c1 a4 09 6c 8d 44 8b 44 24 0c 4c 8b 4c 24 30 41 ff 37 41 56 6a 00 53 e8 89 09 ef ff 48 83 c4 20 90 <0f> 0b f3 0f 1e fa 65 44 8b 3d 5a 3e 2e 0e bf 07 00 00 00 44 89 fe
RSP: 0018:ffffc9000d47f4e0 EFLAGS: 00010282
RAX: 2b7eb175dbc53d00 RBX: 0000000000000000 RCX: 2b7eb175dbc53d00
RDX: ffffc9000e052000 RSI: 00000000000125e2 RDI: 00000000000125e3
RBP: ffffc9000d47f6b0 R08: ffffc9000d47f0a7 R09: 1ffff92001a8fe14
R10: dffffc0000000000 R11: fffff52001a8fe15 R12: 1ffff92001a8fec0
R13: ffff8880123b9ae8 R14: 0000000000000000 R15: ffffc9000d47f6d8
FS:  00007f07bd4f26c0(0000) GS:ffff88808d97f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f54bb84ad50 CR3: 00000000420fe000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 f2fs_update_read_extent_cache_range+0x192/0x3e0 fs/f2fs/extent_cache.c:1085
 f2fs_do_zero_range fs/f2fs/file.c:1657 [inline]
 f2fs_zero_range+0x10c1/0x1580 fs/f2fs/file.c:1737
 f2fs_fallocate+0x583/0x990 fs/f2fs/file.c:2030
 vfs_fallocate+0x669/0x7e0 fs/open.c:342
 ioctl_preallocate fs/ioctl.c:289 [inline]
 file_ioctl+0x611/0x780 fs/ioctl.c:-1
 do_vfs_ioctl+0xb33/0x1430 fs/ioctl.c:576
 __do_sys_ioctl fs/ioctl.c:595 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f07bc58eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f07bd4f2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f07bc7e5fa0 RCX: 00007f07bc58eec9
RDX: 0000200000000040 RSI: 0000000040305839 RDI: 0000000000000004
RBP: 00007f07bc611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f07bc7e6038 R14: 00007f07bc7e5fa0 R15: 00007ffdf7c46b18
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__update_extent_tree_range+0x13bc/0x1500 fs/f2fs/extent_cache.c:678
Code: 48 c7 c2 60 62 93 8b 48 c7 c1 a4 09 6c 8d 44 8b 44 24 0c 4c 8b 4c 24 30 41 ff 37 41 56 6a 00 53 e8 89 09 ef ff 48 83 c4 20 90 <0f> 0b f3 0f 1e fa 65 44 8b 3d 5a 3e 2e 0e bf 07 00 00 00 44 89 fe
RSP: 0018:ffffc9000d47f4e0 EFLAGS: 00010282
RAX: 2b7eb175dbc53d00 RBX: 0000000000000000 RCX: 2b7eb175dbc53d00
RDX: ffffc9000e052000 RSI: 00000000000125e2 RDI: 00000000000125e3
RBP: ffffc9000d47f6b0 R08: ffffc9000d47f0a7 R09: 1ffff92001a8fe14
R10: dffffc0000000000 R11: fffff52001a8fe15 R12: 1ffff92001a8fec0
R13: ffff8880123b9ae8 R14: 0000000000000000 R15: ffffc9000d47f6d8
FS:  00007f07bd4f26c0(0000) GS:ffff88808d97f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f07bd4d19a0 CR3: 00000000420fe000 CR4: 0000000000352ef0


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

