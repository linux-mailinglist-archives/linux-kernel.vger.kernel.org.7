Return-Path: <linux-kernel+bounces-881515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17632C285E0
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 20:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5641887CED
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFF822D78A;
	Sat,  1 Nov 2025 19:01:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0F4C79
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762023691; cv=none; b=sK0UrLDYU2qfrF3aD5M4CCsAst2MlKUqBlX/jwWl/UxKhQMotEjjtUC9Eno1l4J7GWKe0MEFZyhWiNB4WBACpEBxCaxhQHXaP7DocqNTtaI8TgJOjn64rf7wxN/Ygrz+HiKF5wcZnHtbvpA8fqV3soclFYbAIVzzDedQXF4sxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762023691; c=relaxed/simple;
	bh=gg6rBEEDEJfVcEAzKQrMX7qByjuAdeyytQJxfT3lrLU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e1y8rjX7bqAeG8an9Um9udOeIGqrlew11xHcS19WsjKyXBZDYbLiOibGoiKoxp62sjXmCf/m8u7TexByYrIruIalGBGaRFAaoExaRFNWgQzYvJUNbu4nkwpXCSTJqBc4l+U0LN8Q+g5QUghNZlyizWSOpwe136oGO9jU3eRKV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4331d49b5b3so34885485ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 12:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762023689; x=1762628489;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAiywPjy7NLH9045EEUj3oLT+kun3yr5PB6bQ5IPlJo=;
        b=PWws8FJUFUX8zZqykAhrGLJTJyjtEVUZHrSAZY34xYin97F8jMuEs9KSr1KkGrBwD+
         lBLlIpIJqr3xAH7hD9GIPXxc+6PjsX1ro31FJDX5fQ7ExI3zhYLhL44wz6sqyUi5kJt4
         S3y6J6Vk4vJAZBCSBlDDL2Sy/dTz59W0CD+klksiHdZJeGXjGTr3uZl/Xv0Wm8Kf/zbE
         pHwYyW8gml2wPxbFu8vgNfnZ0z2HaWPYpz7rIa964rrGlaH5hkF5p76qjnJWw2DAU3i7
         RmMEFURajOROGIr22JlyOruVxMVUys+iml70i/57+Z+u8lEFvPrih82A3MCdiz1Ddn4N
         9Egw==
X-Forwarded-Encrypted: i=1; AJvYcCWVs76ejCqPimGW/Q5NX4qt8pZtfj5gZwgAgBxgzCdjjyps4rw5flvOLOc5DdjdxxMbIOyRH9UylIBNI30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Uw08pkOTa1MUH8ctRHl5PvKDGNcKtbKhIoNXfdRQtWEXMdi/
	jwbLo00xBRhqnTSh0hG6+Ny+ME8FyCpzRFmlr/3qYrW0KHRa58j/YwMBbPIe2ap1wAo6lqmouVF
	nuh41pnvw13dJFZod8eEj1c/LVy8r3vUl307fYSY65LL+LR4C2Jdnl0bPEBQ=
X-Google-Smtp-Source: AGHT+IEEq1rXevZwsSiYkKzWhOWFF9h5mipACKb7FI1QJG/76X5i4aNC6OBjLGE3hSaw60+fxWLDr9R+jTG90daerREWWSzn4lHF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8c:b0:430:b05a:ecb3 with SMTP id
 e9e14a558f8ab-4330d12c9bdmr120428095ab.9.1762023689072; Sat, 01 Nov 2025
 12:01:29 -0700 (PDT)
Date: Sat, 01 Nov 2025 12:01:29 -0700
In-Reply-To: <6906424b.050a0220.29fc44.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69065909.050a0220.29fc44.000a.GAE@google.com>
Subject: Re: [syzbot] [jfs?] stack segment fault in dbUpdatePMap
From: syzbot <syzbot+f5a5b157b7336d1fda1d@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ba36dd5ee6fd Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16032342580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=f5a5b157b7336d1fda1d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1760b932580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ca3258580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b151a6a8b947/disk-ba36dd5e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ddc072fd4513/vmlinux-ba36dd5e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7cdcc5b6e230/bzImage-ba36dd5e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d873406bb3bb/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=113b4292580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5a5b157b7336d1fda1d@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 122 Comm: jfsCommit Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__list_add_valid_or_report+0x3e/0x130 lib/list_debug.c:29
Code: 00 00 00 48 89 d3 48 85 d2 0f 84 93 00 00 00 49 89 f6 49 89 ff 49 bd 00 00 00 00 00 fc ff df 4c 8d 63 08 4c 89 e5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 e7 e8 32 c4 9d fd 4d 39 34 24 75 71
RSP: 0018:ffffc900039e7a20 EFLAGS: 00010a06
RAX: 0000000000000000 RBX: dead000000000100 RCX: ffff88801ff1bc00
RDX: dead000000000100 RSI: ffffc90003229330 RDI: ffff88814729dc40
RBP: 1bd5a00000000021 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac5cf R12: dead000000000108
R13: dffffc0000000000 R14: ffffc90003229330 R15: ffff88814729dc40
FS:  0000000000000000(0000) GS:ffff888126ef9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffcb89299c CR3: 0000000035922000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add include/linux/list.h:177 [inline]
 dbUpdatePMap+0x7e4/0xeb0 fs/jfs/jfs_dmap.c:577
 txAllocPMap+0x57d/0x6b0 fs/jfs/jfs_txnmgr.c:2426
 txUpdateMap+0x2a2/0x9c0 fs/jfs/jfs_txnmgr.c:2309
 txLazyCommit fs/jfs/jfs_txnmgr.c:2665 [inline]
 jfs_lazycommit+0x3f1/0xa10 fs/jfs/jfs_txnmgr.c:2734
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0x3e/0x130 lib/list_debug.c:29
Code: 00 00 00 48 89 d3 48 85 d2 0f 84 93 00 00 00 49 89 f6 49 89 ff 49 bd 00 00 00 00 00 fc ff df 4c 8d 63 08 4c 89 e5 48 c1 ed 03 <42> 80 7c 2d 00 00 74 08 4c 89 e7 e8 32 c4 9d fd 4d 39 34 24 75 71
RSP: 0018:ffffc900039e7a20 EFLAGS: 00010a06
RAX: 0000000000000000 RBX: dead000000000100 RCX: ffff88801ff1bc00
RDX: dead000000000100 RSI: ffffc90003229330 RDI: ffff88814729dc40
RBP: 1bd5a00000000021 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1dac5cf R12: dead000000000108
R13: dffffc0000000000 R14: ffffc90003229330 R15: ffff88814729dc40
FS:  0000000000000000(0000) GS:ffff888126ef9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffcb89299c CR3: 0000000035922000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 48 89             	add    %cl,-0x77(%rax)
   5:	d3 48 85             	rorl   %cl,-0x7b(%rax)
   8:	d2 0f                	rorb   %cl,(%rdi)
   a:	84 93 00 00 00 49    	test   %dl,0x49000000(%rbx)
  10:	89 f6                	mov    %esi,%esi
  12:	49 89 ff             	mov    %rdi,%r15
  15:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  1c:	fc ff df
  1f:	4c 8d 63 08          	lea    0x8(%rbx),%r12
  23:	4c 89 e5             	mov    %r12,%rbp
  26:	48 c1 ed 03          	shr    $0x3,%rbp
* 2a:	42 80 7c 2d 00 00    	cmpb   $0x0,0x0(%rbp,%r13,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	4c 89 e7             	mov    %r12,%rdi
  35:	e8 32 c4 9d fd       	call   0xfd9dc46c
  3a:	4d 39 34 24          	cmp    %r14,(%r12)
  3e:	75 71                	jne    0xb1


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

