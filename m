Return-Path: <linux-kernel+bounces-826780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED738B8F53E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE560189F881
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE92F6168;
	Mon, 22 Sep 2025 07:44:34 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17945182B4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527073; cv=none; b=Y1E4ay4M5e1m4rOoS79myVvN/faPUqoBu7V5X1dox0gxPhP4+rH7cJB9bQO4721cKteufYb8mn7t7FRVkMAsx0G8vPyFMEO0aTVylsvx+oa+kIR1QNiZZZVv9ivtPywvPBgrz0jTwnaXaHW1ln72mUZyNKAGu//NvNOV6gMoXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527073; c=relaxed/simple;
	bh=Wa4mZn5OmRreVbC6+RpGQVPGF1DVQlCaADuMoo1wE8k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jwfm9Ulmzj+LZPzNk8iopyFPKnBeiJunOP1ly9AcEGnG+LC2CaJJ9pG2MJkPTiDSsss+H18HH2J59w79ZYNw+123oyVFWmzEQJoSAAhJG+6TyE4Nt93ZwvgPOyB+ZpZFpZWisd0dd8dd7/xSOhZhqWWa8g1VZLinibV06GptmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42577be9d9fso9545135ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758527071; x=1759131871;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3Okt1HSnexvyDI11y8Xvh0ZNvB4kxeuT5RfQh263q4=;
        b=hUsMvgyDqj1kHZRTm1kHQgGfJRNsteXjlA/nD4Oz6JId1ZNMJIbXxC5LvGgJBhaZ+b
         TfA9+qcnrAW19/RA88ZCIKBy+OdcyaVslUJZa7AEh0OJrQovKXgskO84O/dEZ+bYYTEW
         Gm7d29+HNCxfRHG2dpTbjD8qsPZcknzzYDXPhbduFHwBrytd30/0coVXzCANa2mzoWDJ
         vcJINIG2YgFvtV4ujb2wfw9QOHOaRwNyBoh+fGbVwCtwIhom38/p8ofrsWuSk8eSvuC5
         gBP+WkZxoNdT+BEM6KYXVdfuFz4wlWel6rocr0dQH/f4N66ZN9fvjbB4Mxf5AVcPHDrO
         ZP3Q==
X-Gm-Message-State: AOJu0YyCRZGuQtoDiGFuKyLbRuwP+8JiSOE22IrFhsx0NopugMRldH3m
	ZpG1xGzA7fk8cthsvbV02FWG+2oRGT03VEL2L2xHpBASMYXCC8dYne2vHya4kfcYQIK9WWqmIB+
	dJrSrO1peeCHXrDYV1wSui2Q13CVGAEdJMWDKvyTYarwSLrD1MJRm4Zvxbx65DA==
X-Google-Smtp-Source: AGHT+IE1QoRTIJ8DXNR/3bcnKRyiXn1j4DUoVYdNR1FfKO+tcCEzjdJN0n+ajEUoWqPPM6aMAr6lnNfcLDc1O5yXKqcK69bJ7LHW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e4:b0:425:6edd:f004 with SMTP id
 e9e14a558f8ab-4256eddf1f0mr82341885ab.20.1758527071243; Mon, 22 Sep 2025
 00:44:31 -0700 (PDT)
Date: Mon, 22 Sep 2025 00:44:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d0fe5f.a00a0220.37dadf.0046.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in __ns_tree_remove (8)
From: syzbot <syzbot+a709c87b450d0d76fdb1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1065be42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4a7665929dce15c
dashboard link: https://syzkaller.appspot.com/bug?extid=a709c87b450d0d76fdb1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fe4d04580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb9b7388a93f/disk-846bd222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c509e16ebe42/vmlinux-846bd222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1cab2834ac1b/bzImage-846bd222.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a709c87b450d0d76fdb1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: kernel/nstree.c:115 at __ns_tree_remove+0x28d/0x330 kernel/nstree.c:115, CPU#0: syz.2.780/9341
Modules linked in:
CPU: 0 UID: 0 PID: 9341 Comm: syz.2.780 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__ns_tree_remove+0x28d/0x330 kernel/nstree.c:115
Code: 0f 85 a4 00 00 00 48 8b 04 24 ff 00 48 8b 7c 24 18 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9 79 92 f9 09 e8 54 f5 31 00 90 <0f> 0b 90 e9 cc fd ff ff e8 46 f5 31 00 90 0f 0b 90 e9 ee fd ff ff
RSP: 0018:ffffc9000e427708 EFLAGS: 00010293
RAX: ffffffff818de3cc RBX: ffff88805df2c820 RCX: ffff88805bd15ac0
RDX: 0000000000000000 RSI: ffff88805df2c820 RDI: ffff88805df2c820
RBP: dffffc0000000000 R08: ffffffff8e1efb53 R09: 1ffffffff1c3df6a
R10: dffffc0000000000 R11: fffffbfff1c3df6b R12: ffff88805df2c820
R13: 1ffff1100bbe5903 R14: ffff88805df2c800 R15: ffffffff8e1ea3c0
FS:  00007fb7a87da6c0(0000) GS:ffff8881259e7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffaa6095e8 CR3: 0000000031e7e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mnt_ns_tree_remove fs/namespace.c:165 [inline]
 free_mnt_ns+0xd1/0x110 fs/namespace.c:4066
 namespace_unlock+0x529/0x760 fs/namespace.c:1710
 class_namespace_excl_destructor fs/namespace.c:96 [inline]
 copy_mnt_ns+0x6e0/0x870 fs/namespace.c:4172
 create_new_namespaces+0xd1/0x720 kernel/nsproxy.c:78
 copy_namespaces+0x438/0x4b0 kernel/nsproxy.c:175
 copy_process+0x1733/0x3c00 kernel/fork.c:2199
 kernel_clone+0x21e/0x840 kernel/fork.c:2624
 __do_sys_clone kernel/fork.c:2765 [inline]
 __se_sys_clone kernel/fork.c:2749 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2749
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb7a798ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb7a87d9fe8 EFLAGS: 00000206 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fb7a7bd6090 RCX: 00007fb7a798ec29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000a5000
RBP: 00007fb7a7a11e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007fb7a7bd6128 R14: 00007fb7a7bd6090 R15: 00007fff04cb79a8
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

