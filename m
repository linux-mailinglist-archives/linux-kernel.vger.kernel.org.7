Return-Path: <linux-kernel+bounces-892010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A24ABC44143
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 16:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 600B44E5E52
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 15:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2AE2FB978;
	Sun,  9 Nov 2025 15:05:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F02D6400
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762700705; cv=none; b=F/Dy9YlHJ6D0fdER1gTuPOSbED46t3e6RHmL+rtIzLQpgYZDteaNjXjRA3h/KHv2s75JNdwUEiJ5OREJopkwUYWZImk6InhQrur11rI1xwTxwvxobUH81lm5yJ1dOfa4RrcUsbgZBJA+6o6JCVuKtRgzeLC94vPD6iLHEEPfNPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762700705; c=relaxed/simple;
	bh=PJrWlU+YFN8HqBushORRLTdVD4GvJkIPpDf5YLplygA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eKZmKDNAdqHX1iVJ4nJW57N0ZiMQXmOzu4YpKeEjo1fimE5Hp/z4SYSQmIe/K59RffJ3D1vXaNLsacpZKnbXVaMoFtB4rJYIsZAhEU+5EfP62pNlXYcYQHmo3k2LcaBmIO/Unh2dbABV/K3xmfA7o04dUj8zh6MP+CK0Ziip9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433795a26c5so5785165ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 07:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762700702; x=1763305502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2OdtiXIbuQZatpYdTc3cFXUEUcJdYB6m4MQNfuwiBc=;
        b=fx2n4YCbNjA//lYmLdspSQyO44LB62Lo1K3B7RV+sbjQC6y35EbzDVdT/jHTtV8/D4
         BpWPN+hj/UtOzytDHvPpVzPH6j/4uuhH4Enwjk7EjDlcipzLGsM10181YNC6WD3vCKzA
         iDv/Ze0NWQHXw8eBHi4wfG/2Rm4C9pdaf1M10E+PgP8d5AMNUZJL4hkrtqFwHkK1zJan
         4inv+Xazj+d7syXSOTq/7EIuy0hgoYrwd0dw2uOCYMRrzbsUkHt0e4bd4FMHS2khELrn
         MSxVJZYvbhsLa9lpw2cPsLNnihZwPpQgHWlhE63pCtdyGSaTjE8zQDz2Zn1rBiO0HEeJ
         MoSA==
X-Forwarded-Encrypted: i=1; AJvYcCWjVvLKUZwtWkjHbvk0swT/QtBRGZTxK/BGsrpIKzIDEmNUP5BHj4MKg2Y8fyH8gMyRIdobSYEUEeQUE1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJr8yk7tjbIPu8kPmneBgOJCihZLkHw6qAnDT9gmlIecowTK3
	EHHROeDDzLZhasQiF227vc0KgHRhVUvPPz2OmpNYZrsKIa3Owhccdnf/qFL7Qi89sxq5uryD0RU
	IrTSuRmdWjQegGP34619yxiuCpKf1wE0yzjffZ0+Kmk0CZoad2MzMVmW3KFY=
X-Google-Smtp-Source: AGHT+IE3moNTm5Se2mbNKMdizBnj0/kdaDRUi0vpoi2pPG0QEsLWuB/j2RCGFklRnFkkVc2y05ybruUha7b1w8CSFL8Bg1qqoABh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2307:b0:433:5a5c:5d75 with SMTP id
 e9e14a558f8ab-43367e31d36mr77006795ab.18.1762700702321; Sun, 09 Nov 2025
 07:05:02 -0800 (PST)
Date: Sun, 09 Nov 2025 07:05:02 -0800
In-Reply-To: <20251109142934.1142273-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910ad9e.a70a0220.22f260.00ba.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: About to unlock rwsem we don't own!

After notify_change: owner=0, error=0
BUG: About to unlock rwsem we don't own!
  inode=ffff888043102e60
  i_rwsem.owner=0
  current=ffff88801fbd8000
  delegated_inode=0000000000000000
CPU: 0 UID: 0 PID: 5829 Comm: syz.0.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 chown_common+0x555/0x6f0 fs/open.c:803
 do_fchownat+0x161/0x270 fs/open.c:834
 __do_sys_fchownat fs/open.c:849 [inline]
 __se_sys_fchownat fs/open.c:846 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:846
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f3658efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f373a1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007f7f367e6090 RCX: 00007f7f3658efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f7f36611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7f367e6128 R14: 00007f7f367e6090 R15: 00007fff1e869178
 </TASK>
inode_unlock: inode=ffff888043102e60, owner=0, current=ffff88801fbd8000 (syz.0.21:5829)
CPU: 0 UID: 0 PID: 5829 Comm: syz.0.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 inode_unlock+0x92/0xd0 include/linux/fs.h:994
 chown_common+0x55f/0x6f0 fs/open.c:805
 do_fchownat+0x161/0x270 fs/open.c:834
 __do_sys_fchownat fs/open.c:849 [inline]
 __se_sys_fchownat fs/open.c:846 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:846
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f3658efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f373a1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007f7f367e6090 RCX: 00007f7f3658efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f7f36611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7f367e6128 R14: 00007f7f367e6090 R15: 00007fff1e869178
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888043102f38, owner = 0x0, curr 0xffff88801fbd8000, list empty
WARNING: CPU: 0 PID: 5829 at kernel/locking/rwsem.c:1381 __up_write kernel/locking/rwsem.c:1380 [inline]
WARNING: CPU: 0 PID: 5829 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Modules linked in:
CPU: 0 UID: 0 PID: 5829 Comm: syz.0.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 80 ff 6a 8b 48 c7 c6 a0 01 6b 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 b3 35 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 94 55 7d 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc90002e77bf0 EFLAGS: 00010296
RAX: 59e03a60efe32100 RBX: ffff888043102f38 RCX: ffff88801fbd8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: dffffc0000000000 R08: ffffffff8f7d2577 R09: 1ffffffff1efa4ae
R10: dffffc0000000000 R11: fffffbfff1efa4af R12: 0000000000000000
R13: ffff888043102f90 R14: ffff888043102f38 R15: 1ffff110086205e8
FS:  00007f7f373a16c0(0000) GS:ffff88808d729000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000043752000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 chown_common+0x55f/0x6f0 fs/open.c:805
 do_fchownat+0x161/0x270 fs/open.c:834
 __do_sys_fchownat fs/open.c:849 [inline]
 __se_sys_fchownat fs/open.c:846 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:846
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f3658efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f373a1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007f7f367e6090 RCX: 00007f7f3658efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f7f36611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7f367e6128 R14: 00007f7f367e6090 R15: 00007fff1e869178
 </TASK>


Tested on:

commit:         439fc29d Merge tag 'drm-fixes-2025-11-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f21a58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1624d0b4580000


