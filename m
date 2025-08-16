Return-Path: <linux-kernel+bounces-771662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E51CB28A27
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93E67BE039
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF8119F130;
	Sat, 16 Aug 2025 03:08:36 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196619004E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755313715; cv=none; b=uUHm7cwA4lkQaApHTJ2j62a6lIykvNE4hqwuitZD+rATOAzEa/l2Y82JOQJ68iHpuoQK93GXDeXdzfL57rY0yJcYDffrTFoK+Z4qlEVnrSKMK6B7t5/vb/pNGEO1VT2v/WnovbbQTzQMoudDKBkwq3WLMxDEt8Ry6QmKQ05lDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755313715; c=relaxed/simple;
	bh=O47n/p9fEaSXT5GZk8MWqXDWYNUEOxsivcokhH/6Kyg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s2MaR5aiMnHD8qf9UdrAnVA7uC9mVU9IrgPqcq2V3ZHxWiz+9eXIrkQxv1z+zdQzsyrYmDORpruZyQrDv2DvTB9mQnaLfeFuR71DuslzeKn+QYmUKpi0OhYyVxC0G4qf2ogw5H2ntma3WqXTBpacrH90nBMUvn83Uc62vpfDvhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e576fa8fc9so14914825ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 20:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755313713; x=1755918513;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCL2FXRG+4DpeAE+/wOBcxOm5mvMocyxQgnRq8Vn9Nc=;
        b=pzHT6xukxtZOwahQjcVzpJIg84KZ9Gpm9hNSG15EGjqNwZxIH/bnlb4KsAK4pgrF15
         c+3C4SlvPHUNGhTR+liHVk3606mOMBavE1bT+LoSCw5ClingmcTfy3sbibMjqYxDmzBy
         3M7vZMX+/TRuanFM2QaifW4z1JKDnccw71HWc277o5T3DCOgwqbxymdpc5asWB+C+TQM
         zvwXSva4ACeC+xN+C5nkB2waa4ZSrKTmysLVU+txQhBOAAbCp76XI/L+rVQ7NY6Zpgsu
         ZHYfAZK6y0s8aLNL28X9b7puPHnrVI/9IVtWep7QId9s8Bll6ih/AQ/SSX8mRxXn3lbV
         GE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbygOc8wIvy/rVOZCpnN/diBkSA7Cj3zbHpJxI1fnSL4rV5xrLyas5yxc2As0MrJ/8KY6sfKFNa6u8gBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VGEu/SIkBuUYFFiX6pjnATYAl8hF76n3oc6th4q7kcgxTfJq
	4XTIiax1T7xayBD/gYISy9c+HqvGNL6a9wR4m7qZdiFwxhKWXIT5bLPFPP0Ww8FpJvhSuXA8PB+
	tNUH4VXwY8XJTlse2GlkdEUtpoX6voIkuLlzYhFwV2vIPHZ7Got8Oviha47k=
X-Google-Smtp-Source: AGHT+IFhnl6zUNc+nBEDR1GvUuQ7D1ApnAEUQgL+dGi/evYDaPzrn/Zj0k7+Rb7ZT8UONvdGrYqNvHijhAVr779rDdUXyDH6pYHA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c08:b0:3e5:67a6:d418 with SMTP id
 e9e14a558f8ab-3e57e83d558mr94546865ab.3.1755313713507; Fri, 15 Aug 2025
 20:08:33 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:08:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689ff631.050a0220.e29e5.0033.GAE@google.com>
Subject: [syzbot] [overlayfs?] WARNING in shmem_unlink
From: syzbot <syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0cc53520e68b Merge tag 'probes-fixes-v6.17-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a003a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13f39c6a0380a209
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9fab8b7f0386b98a17
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1387bc34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f4865acb167/disk-0cc53520.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14540c5ef981/vmlinux-0cc53520.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35534bfe1c7e/bzImage-0cc53520.xz

Bisection is inconclusive: the first bad commit could be any of:

241062ae5d87 ovl: change ovl_workdir_cleanup() to take dir lock as needed.
a45ee87ded78 ovl: narrow locking in ovl_workdir_cleanup_recurse()
c69566b1d11d ovl: narrow locking on ovl_remove_and_whiteout()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130d1dbc580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 9026 at fs/inode.c:417 drop_nlink+0xc5/0x110 fs/inode.c:417
Modules linked in:
CPU: 1 UID: 0 PID: 9026 Comm: syz.4.1430 Tainted: G        W           6.17.0-rc1-syzkaller-00038-g0cc53520e68b #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
Code: c8 08 00 00 be 08 00 00 00 e8 b7 90 ec ff f0 48 ff 83 c8 08 00 00 5b 41 5c 41 5e 41 5f 5d e9 82 9f c8 08 cc e8 dc 5a 8d ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc9000f5ef600 EFLAGS: 00010293
RAX: ffffffff82310064 RBX: ffff88803352c420 RCX: ffff88802cfcbb80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52001ebdeb5 R12: 1ffff110066a588d
R13: 00000000689e7afa R14: ffff88803352c468 R15: dffffc0000000000
FS:  00007fec6bd366c0(0000) GS:ffff8881269c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555591d73608 CR3: 00000000274f4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 shmem_unlink+0x1f5/0x2d0 mm/shmem.c:4041
 vfs_unlink+0x39a/0x660 fs/namei.c:4586
 ovl_do_unlink fs/overlayfs/overlayfs.h:218 [inline]
 ovl_cleanup_locked fs/overlayfs/dir.c:36 [inline]
 ovl_cleanup+0x151/0x230 fs/overlayfs/dir.c:56
 ovl_check_rename_whiteout fs/overlayfs/super.c:607 [inline]
 ovl_make_workdir fs/overlayfs/super.c:704 [inline]
 ovl_get_workdir+0xabd/0x17c0 fs/overlayfs/super.c:827
 ovl_fill_super+0x1365/0x35b0 fs/overlayfs/super.c:1406
 vfs_get_super fs/super.c:1325 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1344
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec6c6cebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec6bd36038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fec6c8f5fa0 RCX: 00007fec6c6cebe9
RDX: 0000200000000200 RSI: 0000200000000000 RDI: 0000000000000000
RBP: 00007fec6c751e19 R08: 0000200000000140 R09: 0000000000000000
R10: 00000000000000d4 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fec6c8f6038 R14: 00007fec6c8f5fa0 R15: 00007ffc15eea8d8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

