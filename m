Return-Path: <linux-kernel+bounces-848789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BEFBCE928
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AD83AE838
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9325A350;
	Fri, 10 Oct 2025 21:00:40 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29DBC2EA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760130040; cv=none; b=lyiKbpkDGZXZ7zEWjAJEgh8Z1DQDrZvoIFZgJkeTtBhL1g6UNR0OJdqLyIL0YYfg751858vz+YPafLxRBN3r7wiTjzx96rD3eDRsVlhd3oDMF5aIVaPl639IyzUOXhpG3eZm0h6RbwxiMI3WHa8jiI1Kx2hQPKcqPPJmn+7FzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760130040; c=relaxed/simple;
	bh=LpUxzYVvhwsUykyCtYa0fzL9/cPgaQThwTleBr327cM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lxq5PyjnkKsMD/0LFHcwn180P3bBYjIXQbcbfqNiK+u5/o1K+CDKOsbBzC4yoq9aQI147lO88WV2YCpb/5jyPjliOl7ImHs8e3VVctT64EOZ8kVxhBJcC+oKJ8Bxi6TPpjxzTTf3aE1qijHo86N+rFxpPCM0O9BKtQZ41Ts62B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-91b3cc5aa6aso1334790639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760130038; x=1760734838;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tb7JA8nQSppmswvWj5Za4jrsCoMl2uCHIZrjUPUW+9Y=;
        b=vgakVMJpzIyVr0hBX55CcnqEVzBL4LfnG+0V8+GxCNfKUHtUd1GBY0Mwjlf/JfmSqA
         k8azkVj94uJ/cChgeadFVMnsjxo/S851xi4eVvNKFXmpuZL8/QxYOB/bTLrJEYDDdFhS
         3WZoSp7XCdcA62wmfri1Abrsdnp6HDQ2zwvXehZbEhWhhSe+WdFfMYpaH5UqH0RhPOwA
         aOQrTroqd8Nf1kKi4adsXZBeZxyz1GaJLFaN2bLjYPPHX9DLhXUAHazF1YLQaXj5CM1X
         X9RQxgVceHgn2BUxCO5n21WCiAH6EkSd9tcsJGnlVUoaMJ7/rhO9DvjoZiFXkGekANI0
         vCfQ==
X-Gm-Message-State: AOJu0YzO8lf1o4WysY52jSMlAOO/7Mogm8nl9Kl2AJRdFrit1pmtv5un
	QVDt2oouqu3yPnxq2X1HTDz7Bixl0XFKTJpztvjz5dEzfizQmvfAokvAXkQdx9d2BY/u1CfNm/N
	z3w2NO1zFPBL+RLGfcQCrGUnUtsoRcoHlQS1NGlNTup0XQoPL6UgCjeUOwvc=
X-Google-Smtp-Source: AGHT+IHEJ/tuUBE/OzYTs/Fcvbt0h2ZHQmXuI2aMLHR2U95LqmebklBZw80TVLMLVw1RShenlNRkcMWbmicUqqaeV75RuqeS2hw5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d81:b0:8e3:2d3d:9a7d with SMTP id
 ca18e2360f4ac-93bd19a9a40mr1759767739f.18.1760130037498; Fri, 10 Oct 2025
 14:00:37 -0700 (PDT)
Date: Fri, 10 Oct 2025 14:00:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e973f5.050a0220.1186a4.0010.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in write_raw_marker_to_buffer
From: syzbot <syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5472d60c129f Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1239b458580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7dba95d4cdd903c
dashboard link: https://syzkaller.appspot.com/bug?extid=9a2ede1643175f350105
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eec52f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e9892580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fbf444614257/disk-5472d60c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f129612e3b8b/vmlinux-5472d60c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8095ae997ffa/bzImage-5472d60c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com

------------[ cut here ]------------
memcpy: detected field-spanning write (size 2655) of single field "&entry->id" at kernel/trace/trace.c:7458 (size 4)
WARNING: CPU: 0 PID: 6004 at kernel/trace/trace.c:7458 write_raw_marker_to_buffer.isra.0+0x2d4/0x330 kernel/trace/trace.c:7458
Modules linked in:
CPU: 0 UID: 0 PID: 6004 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:write_raw_marker_to_buffer.isra.0+0x2d4/0x330 kernel/trace/trace.c:7458
Code: ff e8 30 74 fa ff c6 05 b4 7e aa 0e 01 90 b9 04 00 00 00 48 c7 c2 e0 1e 93 8b 4c 89 e6 48 c7 c7 40 1f 93 8b e8 6d fc b8 ff 90 <0f> 0b 90 90 e9 d7 fe ff ff e8 6e 04 62 00 e9 da fd ff ff e8 64 04
RSP: 0018:ffffc90003837c40 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88813ff34018 RCX: ffffffff817a5e58
RDX: ffff888031d73c80 RSI: ffffffff817a5e65 RDI: 0000000000000001
RBP: ffff88813ff34010 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000a5f
R13: ffff88813ff18c00 R14: 0000000000000000 R15: 0000200000000040
FS:  000055558e5ff500(0000) GS:ffff8881249e6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30263fff CR3: 0000000034638000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tracing_mark_raw_write+0x2da/0x4a0 kernel/trace/trace.c:7500
 vfs_write+0x2a0/0x11d0 fs/read_write.c:684
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f18a0b8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff2b2d2c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f18a0de5fa0 RCX: 00007f18a0b8eec9
RDX: 0000000000000a5f RSI: 0000200000000040 RDI: 0000000000000003
RBP: 00007f18a0c11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f18a0de5fa0 R14: 00007f18a0de5fa0 R15: 0000000000000003
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

