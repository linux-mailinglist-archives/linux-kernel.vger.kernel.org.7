Return-Path: <linux-kernel+bounces-891924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 375FFC43D34
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFEEE4E20BC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B552E88B0;
	Sun,  9 Nov 2025 12:14:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BB2E7F25
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690445; cv=none; b=mv6o69+kFgaWMocSHcFATtZlHJQa9fMSXQv2Ruf2oxR9HEMWR4mx7EIc9girQEYSvLJQ+FdiVE1btdm/iPfnhe9aYBsLz3Sob8g1t2NC9Qj2TWF9KwfiipjeIa9AW15ayDnrTe32TngRjHkMiaIUt7+13p9ciDRSm5HbVhIUOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690445; c=relaxed/simple;
	bh=hfWdAV8neB9830u6JDV8MCRDEekOBmyvspguPXZkN5U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XJz0LWs0QmjL5qcUxrbXiaFggbqp56f/3Goo1SoIdUkqp2r8JSbvMjHX4H4LoDVSDFGpiPDE3/nA2ish7cOkWuBtF4HWmkY/AXakVT/f0p+GsqtCL8ADX210jLRDUsap3aab91B9tcCuDz3UeKxunukQqFU+/3FE6uHCD1cnHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43321627eabso75273155ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762690442; x=1763295242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xY4QkuJExLq8D74iUXRjPvE7n50LIYMzd8jnNA9ew2g=;
        b=FiD0hxkTh0AlB4sezLgfADUjpHGxLIjgWsXP3oNow7ltH+nSpJv7GQeL+keUY2qoU5
         MXL7R+OD0wSeq6dJ5/7ScFJc4udcU5D6Rxl1QdYAEmrLhW+AOw83VOjWHOXTE05VtI8R
         PZKkB6Cnd/4dhdXnKMyJbv19eaF1FcKmMDe9vyZ2Xjl8gaZovtexMAEtWMU9RABgFdMX
         JFOEjpqm0T5YqkIKnOZMWZxp3jIVc7IXon4ZetZ+XEexM2oN1aZH9u6vjFFTuR+pgSqj
         nzxQlz7BArQ6TAy3dIcTYXNeDFvKX5swuDc/QC55lPKgrZCtiVUl00vCTUn5rcEh1wPW
         cM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVA/dnSCE8mbUvBCb0+sYK44PqwX4VHOfkS9CcE+aOcEEKMqW1PDeDqLdaOCnOyGXu8peu6iNkLYVnwG8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUra9/LIdrmtzCLLkyNxOFS3OGwUYtJwUvxZtq92vcCXPSY5LL
	z2k+pn9Ik8uNXecOC7oJ0lyho0pSwhuRiVfgCGPB7k7hBZG7DltD199PJNyZzx/tWtZc7kiTTrG
	Gip+DhubwULtTPRrUO3ovR7fyL0SfobqlceuI4X94R7FdjrH6SCOH8UM3IuM=
X-Google-Smtp-Source: AGHT+IH4hBZkVRmMvUkksC3TxkX3UGpKG85g+nu1eZnbeKdpuTuwTlqTEoXY4tVrMLVMVtgqextZx/cPxtl1I4RTrKyjweUfCeDK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:433:79a7:8158 with SMTP id
 e9e14a558f8ab-43379a7844bmr26704025ab.27.1762690442750; Sun, 09 Nov 2025
 04:14:02 -0800 (PST)
Date: Sun, 09 Nov 2025 04:14:02 -0800
In-Reply-To: <20251109115742.1138274-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910858a.a70a0220.22f260.00b0.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: About to unlock rwsem we don't own!

BUG: About to unlock rwsem we don't own!
  inode=ffff888042108000
  i_rwsem.owner=0
  current=ffff888000424900
  delegated_inode=0000000000000000
CPU: 0 UID: 0 PID: 5833 Comm: syz.0.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 chown_common+0x66f/0x720 fs/open.c:799
 do_fchownat+0x161/0x270 fs/open.c:830
 __do_sys_fchownat fs/open.c:845 [inline]
 __se_sys_fchownat fs/open.c:842 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:842
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa47538efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa476279038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007fa4755e6090 RCX: 00007fa47538efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007fa475411f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa4755e6128 R14: 00007fa4755e6090 R15: 00007ffc415c5d88
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff8880421080d8, owner = 0x0, curr 0xffff888000424900, list empty
WARNING: CPU: 0 PID: 5833 at kernel/locking/rwsem.c:1381 __up_write kernel/locking/rwsem.c:1380 [inline]
WARNING: CPU: 0 PID: 5833 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Modules linked in:
CPU: 0 UID: 0 PID: 5833 Comm: syz.0.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 20 ff 6a 8b 48 c7 c6 40 01 6b 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 c3 35 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 94 34 7d 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc9000cdcfbf0 EFLAGS: 00010296
RAX: 5957612cb528b400 RBX: ffff8880421080d8 RCX: ffff888000424900
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bba684 R12: 0000000000000000
R13: ffff888042108130 R14: ffff8880421080d8 R15: 1ffff1100842101c
FS:  00007fa4762796c0(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004a36b000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:990 [inline]
 chown_common+0x4db/0x720 fs/open.c:801
 do_fchownat+0x161/0x270 fs/open.c:830
 __do_sys_fchownat fs/open.c:845 [inline]
 __se_sys_fchownat fs/open.c:842 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:842
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa47538efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa476279038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007fa4755e6090 RCX: 00007fa47538efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007fa475411f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa4755e6128 R14: 00007fa4755e6090 R15: 00007ffc415c5d88
 </TASK>


Tested on:

commit:         439fc29d Merge tag 'drm-fixes-2025-11-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ff50b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bc4b42580000


