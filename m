Return-Path: <linux-kernel+bounces-735481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37615B08FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EA63A1948
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941C62F85F3;
	Thu, 17 Jul 2025 14:50:31 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F982F85DB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763831; cv=none; b=qSaORTpz1/3u2triMc2q7YMAJgbEGzrvqSrUjWOr76bY9vSQd6Y1Qdgoz7553TR5Ei/DUPwM4LGx358+L/rrUh/PiTarkvT4WzB46U3s0YDP1AZCdNGrRqDQFxUKrRqxyCmtC9Qktn4yrKqURpR8WgaIqWHmvom4YC4GIL64cjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763831; c=relaxed/simple;
	bh=3flcAl5vcqHjK+MsRhhRLKsSrkBHE5ceT7y/idztzZg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sZSxn2eRVtxkmQNHPIrC33Wdv4Je0y/cNvvijOhbRFFZQNQxUb96MuVHunmnigkOBk/eNa4A+tncKY775eKUY/GlS7/7vQU4IEKnnIzZxd6ibFoKUiInMTRf8GxhyQaThVQ0SI90ObizXiGvo9o+IiWDp/OiYZrRGybkqgHFG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86cf306fc68so118764339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752763828; x=1753368628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRndXCOI3Si7nmp+PzTf6Z0E/uyFmDgc6oNuuuAMa18=;
        b=woIUMuB6N/rvlaynceEUQ/rXFf3IbvWifurrxgIrviUCawFSN6stXR9zZ0wjeutBSe
         c7vMK5L6OCoGm0aOmT6DS+ZbvzOG5/lZMqjCcWESY+SAVaMQCduLyuBiak/VSevzpB3A
         inISDTQcQtUNTi25gtrUe0pgiK1L4xfql6+CubU1Ui/YLDkrXwaA01X1ExbXXCGPgso6
         ZO/2RmSyYXUD+ifCDd2U6HfuLwpltP1bt55iK3CM4yObririSgzTv97HIPSyteNM1Nad
         k8J6igPMKbKgIlkcXZSaNmfVXsXvfr0GQlaE5jYEsbzowrU5VSb2nSw8fL9x1fTy+h0h
         h+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI7Q0k63aJbxbGlM5bobk3DhKK4rZAXCYwdl7EbrqslrkfnC4JeMO6Mm6FVsUJG02xg/ZIJ2m7BJ0ocWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZiZOi3SAtF5RSidwU7U14f4P+9x49oeY9UsiPSeMZhbWpqu62
	69HjeeENFbhXh9X91Vqq9DZVGYUdS9GGZ4R6aBykCLGIY7/uIDTnORXJokAKeKBQWT4iE6bcMAr
	Vi+s4/yRV0mTF7UaC5RHCW3Z26MvUvQ/xWe/ylvyKB/EJZ33bsScPQDGTH7Y=
X-Google-Smtp-Source: AGHT+IEVoH8V6uCXILXo+ruM6FzUCMkB1RRt556CaYqRSj78ntjeI5iuhmtIOpDK7CE/J9Uc0HlGlu80a2SUjXlX+AOHzfM0L4PK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:474a:b0:876:5527:fe2a with SMTP id
 ca18e2360f4ac-879c0927812mr1036964639f.11.1752763828576; Thu, 17 Jul 2025
 07:50:28 -0700 (PDT)
Date: Thu, 17 Jul 2025 07:50:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68790db4.a00a0220.3af5df.0020.GAE@google.com>
Subject: [syzbot] [kvm-x86?] WARNING in kvm_arch_vcpu_ioctl_run (6)
From: syzbot <syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    155a3c003e55 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1413e58c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5ef2da1e1c848
dashboard link: https://syzkaller.appspot.com/bug?extid=cc2032ba16cc2018ca25
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1213e58c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a567d4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-155a3c00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/725a320dfe66/vmlinux-155a3c00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f06899bb6f3/bzImage-155a3c00.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 6108 at arch/x86/kvm/x86.c:11645 kvm_arch_vcpu_ioctl_run+0x13bc/0x18c0 arch/x86/kvm/x86.c:11645
Modules linked in:
CPU: 1 UID: 0 PID: 6108 Comm: syz.0.16 Not tainted 6.16.0-rc6-syzkaller-00002-g155a3c003e55 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:kvm_arch_vcpu_ioctl_run+0x13bc/0x18c0 arch/x86/kvm/x86.c:11645
Code: 0a 00 00 00 00 00 00 e8 25 88 be 1e 31 ff 89 c5 89 c6 e8 e7 68 7a 00 85 ed 0f 8f f4 f0 ff ff e9 f5 f1 ff ff e8 95 6d 7a 00 90 <0f> 0b 90 e9 9c f0 ff ff e8 87 6d 7a 00 90 0f 0b 90 e9 d3 f0 ff ff
RSP: 0018:ffffc9000379fc38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888044358000 RCX: ffffffff81417587
RDX: ffff88802327a440 RSI: ffffffff814184eb RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88804ff02000
R13: ffff8880443580d8 R14: 0000000000000000 R15: ffff88804ff02120
FS:  000055555f07c500(0000) GS:ffff8880d6813000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000005200000c CR3: 0000000033cb3000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 kvm_vcpu_ioctl+0x5eb/0x1690 virt/kvm/kvm_main.c:4464
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4f8b18e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc1bf8098 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4f8b3b5fa0 RCX: 00007f4f8b18e929
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00007f4f8b210ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4f8b3b5fa0 R14: 00007f4f8b3b5fa0 R15: 0000000000000003
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

