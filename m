Return-Path: <linux-kernel+bounces-662511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F37AC3BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C626316B90F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1421DED4C;
	Mon, 26 May 2025 08:29:37 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C641C64
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248176; cv=none; b=o7Ja+sqyLojPqwYSZFkSxgBKgYKQyc9E42u+B7apRTfxIk3IBaUD9nci82SGZGQX1d6Gc0cBcunQrh/mx2j3VvfZi39DRSdx6txsk4PMWQD73gMZ4JAS2Cs7nuXKGwmDwYstIXStPn7pVzHENdsXx6pPL/fzp+7Um8+NF23+mkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248176; c=relaxed/simple;
	bh=eBrF7mg+xgyb29STZvRbbiMsmQxnxBwJ/j6BxbhBVaQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nX5nnhyItpup0bDpuMI/GazOe6Fn/NFDZRAq2pybRd+q55DibuzAatH86jPUolCIlwUQQVv70nuVEtjwhhNMoYzNhc1Hkf4732AdhUE00mK52wEMh109HGeAztS8GchNvl1BN7Rd/gW+JQ8essehpsFHhKCImIJRPHHeFGsgr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86463467dddso182610239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 01:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248174; x=1748852974;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiQRlfDNtqOi24rme/9r0diFS+WzZzezNtRBnIppWFI=;
        b=igSQEZJQyEkp47ddAAo6MJ1nIEvHMLLmro0DEe1zVmdVoaZeU3bpvnqgv2oUxCOtzt
         f2iu3aYKfj45qp/cMbKdnU/2DZbTmtA12PkyCamNzmZMjEF/0fMpupBrhIr584Ku3pG0
         ck9vMz8q/wlpLoLHZ7XSDObUOPp2TNa0VnIXG0sGbCQNSyld2/F4pgia/747avcrEWtg
         ZwTkBj6qxNUnoS7DzepKuz6bDTaPd7fRVrZz3c7ZsPlJFKQAS/MhWJ9v+VUV1WR5yZRu
         HJal5/BcHqrWtFeN5crczKvSssqaIZk1kY6wbq/Fz1Kwlo9+HZfMkofqQMnkNPAjJJE+
         rmUw==
X-Forwarded-Encrypted: i=1; AJvYcCXSyIdLz/doRVEXw5Q+XOShSRAuGZ2d3lDfRSD95weA0vOlK+yasg56h+IGjcaRk/hPO/fHnJoR54hDE/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbrhJvP8+JD/1FrQgtkmRFLDcKZpvUGXav2oj5gAkeqZz+1SGZ
	5fZsnCJM8gArIwYTLfWj/yx7MkxaNHTMmWAq+6pyoHZIMw+7kJ3BzRNs1t+EBmO/RdX8dJ9LiG5
	ACY62XivA+UkKg+z8VICjJh8klWTh2G5tSkAk/YNTvOuxL2poAUg9W0QI1xk=
X-Google-Smtp-Source: AGHT+IFpKdYWxZJdtg4Aw7uHYN3AyKfkhOo6oOeNCczYE8xOadwo7fAIisGx+r16uXef5MudZK4reH7t/W0KHdg8fQKIdGsBdBnI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a08:b0:3dc:7f3b:acb1 with SMTP id
 e9e14a558f8ab-3dc9b698537mr47334285ab.13.1748248174200; Mon, 26 May 2025
 01:29:34 -0700 (PDT)
Date: Mon, 26 May 2025 01:29:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6834266e.a70a0220.1765ec.0164.GAE@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_invalidate_blocks (2)
From: syzbot <syzbot+240643026e8cd9ddfaf2@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d608703fcdd9 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d18170580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1de0d8596cea805
dashboard link: https://syzkaller.appspot.com/bug?extid=240643026e8cd9ddfaf2
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103d19f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111550e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/62f880b05e70/disk-d608703f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48229a0ebcc2/vmlinux-d608703f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/376656c50345/bzImage-d608703f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f95e4c8e6c27/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=134279f4580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+240643026e8cd9ddfaf2@syzkaller.appspotmail.com

syz-executor274: attempt to access beyond end of device
loop0: rw=2049, sector=45096, nr_sectors = 64 limit=40427
F2FS-fs (loop0): inject inconsistent footer in sanity_check_node_footer of f2fs_get_inode_folio fs/f2fs/node.c:1547 [inline]
F2FS-fs (loop0): inject inconsistent footer in sanity_check_node_footer of f2fs_get_inode_page fs/f2fs/node.c:1552 [inline]
F2FS-fs (loop0): inject inconsistent footer in sanity_check_node_footer of f2fs_get_dnode_of_data+0x251/0x1c30 fs/f2fs/node.c:781
F2FS-fs (loop0): inconsistent node block, node_type:1, nid:10, node_footer[nid:10,ino:10,ofs:0,cpver:10241045589465957861,blkaddr:4615]
------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2586!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5825 Comm: syz-executor274 Not tainted 6.15.0-rc7-syzkaller-00014-gd608703fcdd9 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:f2fs_invalidate_blocks+0xa02/0xa10 fs/f2fs/segment.c:2586
Code: 89 d1 80 e1 07 80 c1 03 38 c1 0f 8c eb fa ff ff 48 8b 7c 24 08 e8 be c9 1a fe 48 8b 54 24 08 e9 d7 fa ff ff e8 5f f4 ba fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000419f5d8 EFLAGS: 00010293
RAX: ffffffff8404fc81 RBX: ffff8880340fcc00 RCX: ffff8880332a8000
RDX: 0000000000000000 RSI: ffffffff8e53f220 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffff8880332a8000 R09: 0000000000000003
R10: 00000000ffffffff R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88806e92c000 R14: 00000000ffffffff R15: 0000000000000000
FS:  00005555846a3380(0000) GS:ffff8881261f6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000006000 CR3: 000000006ed52000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __replace_atomic_write_block+0x498/0x1240 fs/f2fs/segment.c:254
 __complete_revoke_list fs/f2fs/segment.c:293 [inline]
 __f2fs_commit_atomic_write fs/f2fs/segment.c:385 [inline]
 f2fs_commit_atomic_write+0xefc/0x11b0 fs/f2fs/segment.c:403
 f2fs_ioc_commit_atomic_write fs/f2fs/file.c:2318 [inline]
 __f2fs_ioctl+0x3f11/0xae80 fs/f2fs/file.c:4551
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7566ed5b59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef05ec848 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7566ed5b59
RDX: 0000000000000000 RSI: 000000000000f502 RDI: 0000000000000004
RBP: 00007f7566f4e5f0 R08: 00005555846a44c0 R09: 00005555846a44c0
R10: 00005555846a44c0 R11: 0000000000000246 R12: 00007ffef05ec870
R13: 00007ffef05eca98 R14: 431bde82d7b634db R15: 00007f7566f1e03b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_invalidate_blocks+0xa02/0xa10 fs/f2fs/segment.c:2586
Code: 89 d1 80 e1 07 80 c1 03 38 c1 0f 8c eb fa ff ff 48 8b 7c 24 08 e8 be c9 1a fe 48 8b 54 24 08 e9 d7 fa ff ff e8 5f f4 ba fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000419f5d8 EFLAGS: 00010293
RAX: ffffffff8404fc81 RBX: ffff8880340fcc00 RCX: ffff8880332a8000
RDX: 0000000000000000 RSI: ffffffff8e53f220 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffff8880332a8000 R09: 0000000000000003
R10: 00000000ffffffff R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88806e92c000 R14: 00000000ffffffff R15: 0000000000000000
FS:  00005555846a3380(0000) GS:ffff8881260f6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f684d7f8000 CR3: 000000006ed52000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

