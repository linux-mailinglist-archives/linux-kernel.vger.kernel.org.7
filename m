Return-Path: <linux-kernel+bounces-853610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FBDBDC174
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572ED3A9C88
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6028751D;
	Wed, 15 Oct 2025 02:00:34 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F91D5ACE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493634; cv=none; b=hsLg4XJhQNNwhvmUC397nM96vzOhKAIJsxU/Pd46QXbasuOWXY2qJzBbFQvs/aCs840CTvRHmJr4ZvIF+7hShJwJ+DG7DOiQtHl1qh/0OzQCQypoBE01eet5Vs1xamofsiVp+fxWEA1frSrbIKEnhuYiWA8QFy8PtbPFWhVrYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493634; c=relaxed/simple;
	bh=A66mSnjX6N6NGNIH6jY477HC/LPTbHEtilVXJHjc/Ps=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KLIX1J0oB5WOtmTRKPDFACDvUZUPA23b0H8K4NXosmP2wvTQyQHLort/rv+OEx2nfvCyfzEqvV9eqt+GWME+mA4ie/gtR4sZEQwv8QYfLhvTbhCBVooduGQfXTMO189gcH2ZW8VMuUiUewqHY6BFSn7Dsmlac3fXxiD3QMicsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-93e4da7a183so236296939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493630; x=1761098430;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fFPe7hyn/AwEN5Z4Q8RKAqq7yvPlsJ4hpwsLWIC0Wc=;
        b=gxYiN7ljojuo6MQAHnzo61IxAAyxUeshg6EXzmTnFjX910YzRsK2diJflRWFj3v6gr
         i34VokPBX9HKl44ghODjciQMR/EcltDnBuBD3Zu+Wq8289y3Bj8K8pMwJK+6h9JsAwhQ
         oSNdueB3scWHBR6oIXRYzsFNdeE1qumjZRiKbWfNJsO46LUNGYezQ9czaTEpxuJ7abc2
         XThpzzHCwTlkzc7OfbNlnhA6JAVw6naxwkngGhtDZQfqESQCfS8VSqBQ97heVX+UKzXX
         qTEUatJLTnYl/GCkI0bN7LPSQes3h2IZaPHMYgwavWBgm7FeCmuvwhIQnE3WAIrma1iq
         LRgw==
X-Forwarded-Encrypted: i=1; AJvYcCULaqZssWGB8l8LGehJjPmyN8O2iu6Z6SdSHijewY418l4dgztEI8R4XGkS3EOWdi/Y53FWvWxEGoY9gW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMvZQHYCXhNsl9rXEuKQ03MibFEPlCF/EbgbfD6pmgFfJrkvA
	SSBk/IUmqS15mRdUgIqqJz4RpLD+exCo/T2h/dECwvnoHnVsF8NPWPczxeyJmJ9YnKycf/EIj9N
	eChVTXAEB81j1ZkHT/heJii5f0GtK4UsjlHyfqWCHWR5gUjUMZZbL5Qb798c=
X-Google-Smtp-Source: AGHT+IHghrZiAsK1jI6A++dl3I1som3DuS+rfakA7eQcIlh0JV7bE164v91Z52e3wI/sZwCjdkXLIZXNlT0bZXBf/m2zQG8Y2m/U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:270a:b0:42d:8b1c:5710 with SMTP id
 e9e14a558f8ab-42f872c59cdmr259625475ab.0.1760493630583; Tue, 14 Oct 2025
 19:00:30 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:00:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef003e.050a0220.91a22.0229.GAE@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in do_xmote
From: syzbot <syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    52ba76324a9d Add linux-next specific files for 20251013
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=159e25e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=353de08f32ce69361b89
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1589f304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1492bb34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1729256319ee/disk-52ba7632.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3152cfcba7c/vmlinux-52ba7632.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4065a3b3d959/bzImage-52ba7632.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/85dc141e7c83/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10dc5542580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: G:  s:EX n:3/2090 f:lyfaqo t:EX d:EX/0 a:0 v:0 r:3 m:20 p:0
gfs2: fsid=syz:syz.0:  H: s:EX f:nW e:0 p:6072 [syz.0.21] alloc_dinode+0x16a/0x550 fs/gfs2/inode.c:414
gfs2: fsid=syz:syz.0:  R: n:8336 f:80000000 b:826/826 i:7 q:0 r:0 e:7811
------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:674!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6064 Comm: kworker/0:2H Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: gfs2-glock/syz:syz glock_work_func
RIP: 0010:do_xmote+0x706/0x750 fs/gfs2/glock.c:674
Code: 38 c1 0f 8c a9 fe ff ff 48 89 df e8 64 77 29 fe e9 9c fe ff ff e8 ea cd c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 1b e9 fe ff 90 <0f> 0b e8 d3 cd c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 04 e9 fe ff
RSP: 0018:ffffc90002ff79a0 EFLAGS: 00010246
RAX: 89b42d9b8aee9500 RBX: ffff8880406efb60 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: ffffffff8bb183c0 R08: ffff888075ab0bab R09: 1ffff1100eb56175
R10: dffffc0000000000 R11: ffffed100eb56176 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000015
FS:  0000000000000000(0000) GS:ffff888125d08000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f742dc70f98 CR3: 000000007b84a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 glock_work_func+0x2a8/0x580 fs/gfs2/glock.c:1002
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_xmote+0x706/0x750 fs/gfs2/glock.c:674
Code: 38 c1 0f 8c a9 fe ff ff 48 89 df e8 64 77 29 fe e9 9c fe ff ff e8 ea cd c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 1b e9 fe ff 90 <0f> 0b e8 d3 cd c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 04 e9 fe ff
RSP: 0018:ffffc90002ff79a0 EFLAGS: 00010246
RAX: 89b42d9b8aee9500 RBX: ffff8880406efb60 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: ffffffff8bb183c0 R08: ffff888075ab0bab R09: 1ffff1100eb56175
R10: dffffc0000000000 R11: ffffed100eb56176 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000015
FS:  0000000000000000(0000) GS:ffff888125d08000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f742dc70f98 CR3: 000000007b84a000 CR4: 00000000003526f0


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

