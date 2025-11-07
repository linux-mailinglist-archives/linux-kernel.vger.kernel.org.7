Return-Path: <linux-kernel+bounces-889876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E4C3EBF9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CD43AAC73
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A2B3090CD;
	Fri,  7 Nov 2025 07:29:27 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7B2FB602
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500566; cv=none; b=ctTQu2V8hi6h/a4GOCXA2A8rCTKxiXwZ2v4/7BbDIPqkVeeIu/YOnoI6cIQ+StbS40V1/5kd6yNb6pJt2i9gm53zFCL//Cqyj82dW7mYyZMQrQpmyss/R9tmyOpTV219qjD0SHYjqFPneDOKPfeszYftldLOa5fPyxw+Ko5DJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500566; c=relaxed/simple;
	bh=3925RX+Ai+tuIaIP2P1jYM5ykyLQre7AGfFASsCc8Wg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B2rwVCZP9MJoGZJqErxhEpVFNJ4/As7UwPX5ncQjx7vj93bSn04nOOHMBl+Nq82TZf/0XEUftYlPZHaCDFe4E3FvMBYbNl7BqcXvUw7jtLyzBCkCu3FvdZt3OhKzYMRyD/fn1ffCMOJw9mqNDwnYoSdZ31M/oeSTfiHir8t0frA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-93e8839f138so39830539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500564; x=1763105364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elLBvF3NR3U9sPOSG0QINyPMQhDneG0NFmxvnTGIyos=;
        b=k4/ZEcs3vzDkLHCqUDObvCooTW5nMqbocFggd2ofh+9Dl6eVCpFYB4FNNSNHSJXH3H
         kW7ycaKPPRSpI9628k+DnPS9iuqV/Cl5tp2OuQDWg1U4ep1hve6Mr1m2cxrSXPlzLJ4f
         OD6XNLRP42cycYwodmKVgpbnoVA2gZEiQmEdr2r2XXCct3QrzLcPviLd8YFFQz6Nvt30
         Yty79NetJ66TJ8LPospYHzObpUCFsXrjLhqRKHOSGzLtZxLdENW+hgd1jLwa9tWDLVbw
         9el51JXR+GMW1sYOU9gJAIbWkR8UpUPcnNDA7TLwDv8rUeIeUr6pxloC9wqOASUoTZUJ
         x1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVUlxoikbN9XYRyjEiG7sjGj/2x/D9oamWSLq9Bgl6T77xO7gYmldnKCFCKv4SRQ87McDtyKvMzNHUBkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLpCa0+h5b1JqZVOeZXFpGR+7S2Czu0MlhQ77X7AIHagYk7dO
	o6S/CQiV1xUFHDKNKQDzm1fIslx2Yzx3oZwKFXq6zomaq7OQQxfmeLfFZbNTU7ISHTj069Xpwbx
	WpgzT7OxhS2VuhopMaiZUEVVdAnyuhHh9LNWE01ynOw024ZtQNmD18RFtoSI=
X-Google-Smtp-Source: AGHT+IG3lFor0ae7PvaoBhmAsLl69TPWuf62yHSW1JRCxxSsLzReWFsrW+xzJfUk76XMRaO8ppPdJoqUuZao0nT6Q+pjMAw7ZZFz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3485:b0:433:2943:3a78 with SMTP id
 e9e14a558f8ab-4335f478e35mr32160345ab.31.1762500563895; Thu, 06 Nov 2025
 23:29:23 -0800 (PST)
Date: Thu, 06 Nov 2025 23:29:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d9fd3.a70a0220.22f260.0021.GAE@google.com>
Subject: [syzbot] [jfs?] general protection fault in txCommit (2)
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bb886cb8f3a Merge tag 'edac_urgent_for_v6.18_rc5' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1207c114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=9489c9f9f3d437221ea2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1033d012580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea1bcd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/393661e2054b/disk-8bb886cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba628b757c6a/vmlinux-8bb886cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15255c2cc8ad/bzImage-8bb886cb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5ffcac92a4cf/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=125bf932580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
UFO tlock:0xffffc900034fa[  113.512606][ T5985] UFO tlock:0xffffc900034fa1b0
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 5985 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:txLog fs/jfs/jfs_txnmgr.c:1390 [inline]
RIP: 0010:txCommit+0xafb/0x5430 fs/jfs/jfs_txnmgr.c:1265
Code: 3c 10 00 74 12 4c 89 f7 e8 f2 cb e2 fe 48 ba 00 00 00 00 00 fc ff df 4c 89 74 24 68 4d 8b 36 4d 8d 7e 28 4c 89 f8 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 ff e8 c7 cb e2 fe 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003fc74e0 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000948 RCX: 1ffff9200069fd48
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003fc76b0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac5ef R12: 0000000000000002
R13: ffffc900034fa000 R14: 0000000000000000 R15: 0000000000000028
FS:  0000555570e52500(0000) GS:ffff888126df9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000038f28000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 jfs_create+0x865/0xa80 fs/jfs/namei.c:156
 lookup_open fs/namei.c:3796 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x1500/0x3840 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_creat fs/open.c:1530 [inline]
 __se_sys_creat fs/open.c:1524 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1524
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f575dbcf6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff260cfb28 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f575de25fa0 RCX: 00007f575dbcf6c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000580
RBP: 00007f575dc51f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f575de25fa0 R14: 00007f575de25fa0 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txLog fs/jfs/jfs_txnmgr.c:1390 [inline]
RIP: 0010:txCommit+0xafb/0x5430 fs/jfs/jfs_txnmgr.c:1265
Code: 3c 10 00 74 12 4c 89 f7 e8 f2 cb e2 fe 48 ba 00 00 00 00 00 fc ff df 4c 89 74 24 68 4d 8b 36 4d 8d 7e 28 4c 89 f8 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 ff e8 c7 cb e2 fe 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003fc74e0 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000948 RCX: 1ffff9200069fd48
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003fc76b0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac5ef R12: 0000000000000002
R13: ffffc900034fa000 R14: 0000000000000000 R15: 0000000000000028
FS:  0000555570e52500(0000) GS:ffff888126df9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000038f28000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	3c 10                	cmp    $0x10,%al
   2:	00 74 12 4c          	add    %dh,0x4c(%rdx,%rdx,1)
   6:	89 f7                	mov    %esi,%edi
   8:	e8 f2 cb e2 fe       	call   0xfee2cbff
   d:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  14:	fc ff df
  17:	4c 89 74 24 68       	mov    %r14,0x68(%rsp)
  1c:	4d 8b 36             	mov    (%r14),%r14
  1f:	4d 8d 7e 28          	lea    0x28(%r14),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 c7 cb e2 fe       	call   0xfee2cbff
  38:	48                   	rex.W
  39:	ba 00 00 00 00       	mov    $0x0,%edx
  3e:	00 fc                	add    %bh,%ah


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

