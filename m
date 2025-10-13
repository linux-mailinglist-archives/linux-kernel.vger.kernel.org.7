Return-Path: <linux-kernel+bounces-850205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D8FBD23C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CB654EC3C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05E62FC88C;
	Mon, 13 Oct 2025 09:18:34 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D092EC543
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347114; cv=none; b=oB4tUdYlyEqXrgjUgsi44PzBmT06U4HcvSYiGAabWAExBI/YgkErcGU/dS9Tcgn0WIK9giGQyFBpel+kR56AIOlCkg6DFN0EwyUjrKPqp3ceMkvdq28Q1unepXlInRdlYhpiPTO3sQzhjFEosmrHXOMQYBpQBVW4VPIDJUynnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347114; c=relaxed/simple;
	bh=zQ04kJMvulXBDhJ6WmqFJqA0Vyg/xCqGs/ntwRq3C5s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LpveEqKa2ti7fTiqGAoqdoZgjoWG8NSZbq4MZptvoxsQOod6lXSJWBk87GZOv38LaC9tWAIZsa1XHMrX98ottx0oAfah5b4PuZXMXj8KKYnAUAu59NesJ5XB0cjfppFwhdtyNjqSMULkLHFD+9AZE2W/e5muXzIEZ0hSpOdVAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-93e4a324b9bso31399639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347111; x=1760951911;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0laP8EeKth6R1NgHIrN+JC7w+ZEUl/qF2GCsYmoFEo=;
        b=CcRUAgvCrXgeMg7/dFK4Gh4WmREVWnlffKJjhvTxtakL/sh/hHFgjRfdYw7q8rxClc
         FP27NKQezbvhigHKWbFCNdaDrDsF3II7FOtTd4wBiRrxVaKL05SJIW99slw5n2APH2yZ
         R1wYXwDkmPDM7pfKc7hV5PERj8X0cCxQjrlPdjZwZjWE44n3WKKDhBM8WVnI/ly8QcmR
         PTvdFuDbnbtBYjTg+4oCa4L+qfYXmtyh4aFi8LmTjCgoyxB4F20pzEtKY3xm1IjRgwiu
         bfRaFg8F3/hzClmISfnOQ9vEpXc4yohGbMgv8V/mkqKK1clKUeod3zZj2Btis/sADsPB
         6gJA==
X-Forwarded-Encrypted: i=1; AJvYcCUVfrFbJ91V0hKYTDAO3eE7ishqGn76SXEeIKRp6CG2IElDQxVgXHfJi/eYQc0COG1z6BW5oM27xHeizeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIM7c22/hKDkzMYwNXw9xWAWTd3LlUnU1xDzaYO5M/kpeFVt1
	TNsHqfXM4v4QQIt6fhafF5jDjTWBFc8r4u8MJ8OHCxXFtxT3+427P/uszOMyKXa4U0iMj2E/IIs
	DlRr1fPg8HZq7ZnjyhrFlxrieH9II6mESnuImk0+vRhgJMOrc+tR2RQqQEt4=
X-Google-Smtp-Source: AGHT+IF5V+oWCmqM0HfuIQ88nOy3VMUgRK5cRx725Aul0GoLvxWIBznmInpSPo79qN1Jb2CGYMPHP8qp7k6whgQvmH9F4AJfe84H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318a:b0:42f:8ee7:6494 with SMTP id
 e9e14a558f8ab-42f8ee76610mr186770395ab.9.1760347111433; Mon, 13 Oct 2025
 02:18:31 -0700 (PDT)
Date: Mon, 13 Oct 2025 02:18:31 -0700
In-Reply-To: <68a82586.a00a0220.33401d.0251.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ecc3e7.a70a0220.b3ac9.0018.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_rename (2)
From: syzbot <syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2b763d465239 Add linux-next specific files for 20251010
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15847304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1191867c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13847304580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a00344625c3/disk-2b763d46.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd34c500f8eb/vmlinux-2b763d46.xz
kernel image: https://storage.googleapis.com/syzbot-assets/660905c62cb2/bzImage-2b763d46.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/25cb8f01270c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: fs/inode.c:417 at drop_nlink+0xc5/0x110 fs/inode.c:417, CPU#0: syz.0.217/6748
Modules linked in:
CPU: 0 UID: 0 PID: 6748 Comm: syz.0.217 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
Code: 70 07 00 00 be 08 00 00 00 e8 07 da e7 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc cc e8 dc 26 82 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc9000c52f9d0 EFLAGS: 00010293
RAX: ffffffff823e1d34 RBX: ffff88805699e008 RCX: ffff888027213c80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f9e1877 R09: 1ffffffff1f3c30e
R10: dffffc0000000000 R11: fffffbfff1f3c30f R12: 1ffff1100ad33c0a
R13: ffff88805699d368 R14: ffff88805699e050 R15: dffffc0000000000
FS:  00007f06f15f66c0(0000) GS:ffff888125d0b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa97ff3f000 CR3: 0000000072f60000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nilfs_rename+0x46a/0x820 fs/nilfs2/namei.c:418
 vfs_rename+0xb34/0xe80 fs/namei.c:5216
 do_renameat2+0x6a2/0xa50 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f06f078eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f06f15f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f06f09e5fa0 RCX: 00007f06f078eec9
RDX: 0000000000000000 RSI: 0000200000000180 RDI: 0000200000000040
RBP: 00007f06f0811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f06f09e6038 R14: 00007f06f09e5fa0 R15: 00007fffd3cbc518
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

