Return-Path: <linux-kernel+bounces-772595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B003B294A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670AF2A0D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48B2FE069;
	Sun, 17 Aug 2025 17:58:39 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3018B0F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755453519; cv=none; b=q0x732u1h+0prmTBkniBRw/yqiJqVMYPGGGgjCQYYvqbek8NdpQzKKi3ldfHMRogh/IKG+9FfvQa52KUcWfoyjJ0xyVQVFHcqZRu9pELHdkSeYXR2n58yA7kGmZioS3gCsLRi9wJInj1aVFvu7FeuWCnDqVOUqqrHvMxaHwezWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755453519; c=relaxed/simple;
	bh=cOm+POGp8rtWWZ/1zY0gimydOD8j12HKIaOb1eZmAYA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i1cWirjDgM5oVbQPL3Ga+QtYz+hI/3ItSsYN+5kxhzMQWbr97URYJcgTbk8e2SsSFjqbVfDVbJ0rA0BgcmsVH8Q0MKIrTeFAqf2J6BuxfRohg7I1jUSsTCEI2V4TmTROP9hRv7Q0yCi7jvdyYX9e1XOjcdxMtdHwysNJUGha8U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8845b4f5394so5661439f.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 10:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755453517; x=1756058317;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShM/4HtZujH7pQsnFibFwYjRau9v9FrA30ZExvTQCnE=;
        b=mID4j9i/8tMdnTBMXrBWbR3Yh1HxYLAigDZq0FWEAliBhA6H+XQTN3u34j6Uvikn5Z
         ctwEuiedPAC5cj9dSnr+bAj5dUm5UCrqQO0DwKZF6U9YRfZrbsvBRQvTQv7fpcPpSTh5
         tntB00SNL1VXf9NaPd98IsmYdcVQ6PNOX6GjX8Wd47PJQSJXa33bTOBx4u7WnC+NrKt4
         vFtha4hIgLKKcJrYFHI2kv9Trp2G1twb6sJ2y28yNE7KBvAQd71elniLK7PTR8Tmtmfh
         6ykbUfC4H7YyB71JF5hMlN6GFRZGzOJFxT5oeHUByK+AQxfqIguoDGXmvxcVgA1e1rZD
         8I9A==
X-Forwarded-Encrypted: i=1; AJvYcCUYRmrr3gEn72RTqjoMa6fjcFK4pN1gofQ0HITN+csgZZll679g3KXRQEOEmc18noc10hWsSzkYbgt1ccE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITuZf1oHWZHC/MIL3LLPh4Hh9hD912FpJvflUei8fYHqaAPSD
	FG2vP/RrgnltdtFZRkjXfGNo/CtZSWGatDpVj3P9j1IpkNfJTGBt+G4kZQYr3xf+2P2VNrRHRqa
	u+UOmk79SY/EbEqEzVauV1GnX9j63cOEI1Fnu6wMJWeSvq4j6kdSPppunM8g=
X-Google-Smtp-Source: AGHT+IEB+XlMWvMkE27pvMl9co5iwrldmB8V/RESRo0PNg9g8dPo1JxT3Dw0Od0OSyvYhLtjOpoWc3T+bK1cGHiHm+ui6J/S0Luw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198b:b0:3e2:99c3:47c8 with SMTP id
 e9e14a558f8ab-3e57e9d10a0mr145042245ab.17.1755453516881; Sun, 17 Aug 2025
 10:58:36 -0700 (PDT)
Date: Sun, 17 Aug 2025 10:58:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2184c.050a0220.e29e5.0070.GAE@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in gfs2_withdraw (2)
From: syzbot <syzbot+901524eae72170197041@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8742b2d8935f Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1414cda2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=901524eae72170197041
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8742b2d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b561d09cce5a/vmlinux-8742b2d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0eac1e9113b1/bzImage-8742b2d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+901524eae72170197041@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 5 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
gfs2: fsid=syz:syz.0: fatal: invalid metadata block - bh = 2051 (type: exp=14, found=8), function = gfs2_quota_init, file = fs/gfs2/quota.c, line = 1430
gfs2: fsid=syz:syz.0: about to withdraw this file system
------------[ cut here ]------------
kernel BUG at fs/gfs2/util.c:331!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5364 Comm: syz.0.0 Not tainted 6.17.0-rc1-syzkaller-00016-g8742b2d8935f #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:gfs2_withdraw+0x137b/0x1430 fs/gfs2/util.c:331
Code: ff ff 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c 55 fb ff ff 48 8b 7c 24 18 e8 20 7c 25 fe e9 46 fb ff ff e8 86 90 c0 fd 90 <0f> 0b 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c ab fb ff ff 48
RSP: 0018:ffffc9000d32f680 EFLAGS: 00010293
RAX: ffffffff83ff2ada RBX: ffffc9000d32f740 RCX: ffff888000aa0000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc9000d32f810 R08: ffff88801fc24253 R09: 1ffff11003f8484a
R10: dffffc0000000000 R11: ffffed1003f8484b R12: dffffc0000000000
R13: 1ffff92001a65ee4 R14: 1ffff110087b3815 R15: 0000000000000004
FS:  00007fc82060a6c0(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc3a1909c0 CR3: 0000000042f3e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_metatype_check_ii+0x78/0x90 fs/gfs2/util.c:514
 gfs2_metatype_check_i fs/gfs2/util.h:129 [inline]
 gfs2_quota_init+0xfc8/0x1230 fs/gfs2/quota.c:1430
 gfs2_make_fs_rw+0x181/0x2b0 fs/gfs2/super.c:149
 gfs2_fill_super+0x1a7b/0x20d0 fs/gfs2/ops_fstype.c:1278
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc81f79038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc820609e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc820609ef0 RCX: 00007fc81f79038a
RDX: 0000200000000400 RSI: 0000200000012500 RDI: 00007fc820609eb0
RBP: 0000200000000400 R08: 00007fc820609ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000012500
R13: 00007fc820609eb0 R14: 00000000000125bb R15: 0000200000000900
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_withdraw+0x137b/0x1430 fs/gfs2/util.c:331
Code: ff ff 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c 55 fb ff ff 48 8b 7c 24 18 e8 20 7c 25 fe e9 46 fb ff ff e8 86 90 c0 fd 90 <0f> 0b 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c ab fb ff ff 48
RSP: 0018:ffffc9000d32f680 EFLAGS: 00010293
RAX: ffffffff83ff2ada RBX: ffffc9000d32f740 RCX: ffff888000aa0000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc9000d32f810 R08: ffff88801fc24253 R09: 1ffff11003f8484a
R10: dffffc0000000000 R11: ffffed1003f8484b R12: dffffc0000000000
R13: 1ffff92001a65ee4 R14: 1ffff110087b3815 R15: 0000000000000004
FS:  00007fc82060a6c0(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc3a1909c0 CR3: 0000000042f3e000 CR4: 0000000000352ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

