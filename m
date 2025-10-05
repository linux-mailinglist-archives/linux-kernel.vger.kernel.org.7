Return-Path: <linux-kernel+bounces-842216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E78BB9406
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 06:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BA418998D3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 04:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CC919D8A7;
	Sun,  5 Oct 2025 04:48:37 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA255DF49
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759639717; cv=none; b=gpwx2oQ+1FOpMv2rZ5TzXLkHevHCuZQidSgltmb0EQijRhyfJIEMMjLWm8g5GIomeR1WzGYyQPjzwp/vSHM10AyS0b+4EUqp+ofVAuVd+5GOo/ykNgPZtRP5zAYdWc5CLaIL63Qw1xS50GoZc90mUaRmoXy9vFUPmgsQh6TiK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759639717; c=relaxed/simple;
	bh=zob1Z+bggh2wgwtwyrO8vEZO7GC5E/2Ir1fGJPfxAhI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G4ZkyKW26raE9oxLq28crRHipsRn1qf1PCgJkP87xBdkN4I53eN5CL7xgl95zlRvt6oNVFm8VVfa4XVIm9/fkd2PLtisWcSAcbTI8Wu141RNGBkY7MTCesCugv3K+PgOwK+WlzAoxDPcxmQhjZfBd6Jq8Ke0nnQS3i4y+rLhw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9286199b46fso385230839f.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 21:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759639715; x=1760244515;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRw6kQ7NQTHzEKLukPtcZ5PmWxL56zkThQhorWgQoDA=;
        b=tMpkIuHefCNMYmaAYkat7SCQRp/k1A0WOa3wAh5lOOZTRzyCoq93kPOD7Cy0kFaU2t
         O2Nqb9aE/zg3enXshktHWMCjWzGkrMrJEu6OSwr46e+FDN1kiMLxHVWXc2fUvotvcsWj
         cyVMOJ2JQ4U71xi+T/81w9BLMucBDeC4oouLPCS1zaRmNWeZ+FKBXf8i7PI2mDUfWQ0Z
         98iQJyW3s7al8YhRu0cMtFyKVnS4shv8vahJDqbeTDlSSo5fudFA/P8lanasp8S1ozgf
         xZQTl/SZGva8Q6DEE+yukOfB8loiNQgDTmMC1m7OXNCaBKEGopfDJv+rXdpq8ImaCju2
         qblw==
X-Gm-Message-State: AOJu0YzrIjin9VU4nDVqwmdp/C+/HZEl8jurhMUOjaCZdXvNUqHxgfj2
	XYNEPyvvdpLZQjIXz2K2FvwSxNGcZL1Aqe0+zSK18p5GPmWUH0B6lOTc+Ymm+W+SnAqzHVf6I3k
	nJzOBP+aKFPrfDPLVEXEaaZVkbYqbkQF4WQTFQGyzURLU7EXU1mrgZ3BRlLDxFg==
X-Google-Smtp-Source: AGHT+IFvNczzEzaaf08eM9b/Hy9aU9vUeeXh+CfbpIaSQvlVasGfo6UYE0XCG7c7kCHVKIUNrSQMYhbDeck+sILgBepaJ9pQmV3m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7407:b0:91c:fcd:88e6 with SMTP id
 ca18e2360f4ac-93b96937759mr1085218239f.1.1759639714831; Sat, 04 Oct 2025
 21:48:34 -0700 (PDT)
Date: Sat, 04 Oct 2025 21:48:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e1f8a2.a00a0220.102ee.0126.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in kcov_task_exit
From: syzbot <syzbot+47cf95ca1f9dcca872c8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cbf33b8e0b36 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10440ee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4754d79c625c476
dashboard link: https://syzkaller.appspot.com/bug?extid=47cf95ca1f9dcca872c8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8dd21bcf666/disk-cbf33b8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/190c622f8270/vmlinux-cbf33b8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/95c5beb798e9/bzImage-cbf33b8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47cf95ca1f9dcca872c8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 11596 at kernel/kcov.c:477 kcov_task_exit+0x13c/0x150 kernel/kcov.c:477
Modules linked in:
CPU: 1 UID: 0 PID: 11596 Comm: syz.4.1726 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:kcov_task_exit+0x13c/0x150 kernel/kcov.c:477
Code: c7 c7 40 98 a4 8e 48 c7 c6 3c c6 ba 8c 48 c7 c2 fa 9c b9 8c 4c 89 f9 e8 32 46 f0 02 4c 39 bb 98 00 00 00 0f 84 ff fe ff ff 90 <0f> 0b 90 4c 89 f7 5b 41 5e 41 5f e9 f4 9f f7 08 0f 1f 40 00 90 90
RSP: 0018:ffffc900055ffd00 EFLAGS: 00010287
RAX: f6d69a1b07268900 RBX: ffff88814131d800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b1dc0c0 RDI: 00000000ffffffff
RBP: ffffc900055ffe78 R08: 0000000000000000 R09: ffffffff8ab4d7a1
R10: dffffc0000000000 R11: fffffbfff1d6b527 R12: 1ffff11004c9279d
R13: 0000000000000000 R14: ffff88814131d808 R15: ffff888036835a00
FS:  000055557c98c500(0000) GS:ffff88812712f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005562f7e5e000 CR3: 00000000685d0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_exit+0x105/0x2300 kernel/exit.c:905
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 __do_sys_exit_group kernel/exit.c:1118 [inline]
 __se_sys_exit_group kernel/exit.c:1116 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1116
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f57eb2feec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee660d918 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57eb2feec9
RDX: 00007f57ea569000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffee660d97c R08: 00000000000123ac R09: 00000000000927c0
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000012a
R13: 00000000000927c0 R14: 000000000009ff7c R15: 00007ffee660d9d0
 </TASK>


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

