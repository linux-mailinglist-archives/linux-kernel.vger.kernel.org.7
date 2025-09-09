Return-Path: <linux-kernel+bounces-809041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DECB507CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D4D4E7252
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38D12571A5;
	Tue,  9 Sep 2025 21:11:33 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDED2517AF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452293; cv=none; b=kcRvy8phRl7dQjeygWNNJCc6eeP585GKLz+nZ6U7wcBDG13480+RIwBSX3Dt7u1it/bo68p6Te4Kg+/Evm7EVoGbHhX3xs8fDLr7dBazVkoVqUy4udO7FCc8VXfs7ZSBoswNY46HGSBEDplLcF+L9oGDOWhcVvxps1TceOLi/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452293; c=relaxed/simple;
	bh=HjCNmC5FZxM2rUG0wIm+8swxW+Tho9ot4RDURpIWr5c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OJ2YwzT8aeik10XL05wm+boLM6n/fVHj/tDRRQTQI7EEkmndZa2UzPGxaxR/I7qsgHMH7FNnXqmWIKBrgAwHlr3sI5m1q4gaAc+LsBLljPwlLC5twK3u1WaB78v+wjl1V8SmpSTI3gp6zrjFF/29Ux6biLyQthWUmuGQa4hxFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3f65e91bfa9so27987625ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452290; x=1758057090;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2E6uKZowa7YhpoptIPi7df6cgW2oGwc5hKKJm/fXpc=;
        b=b96EWfpDquJvm2T2tdJmR/uHwQoR0L3/zzraLfA2zNr2bY/GBQMlA2Ryoiaf/K4ZUd
         7cZXRNA9tjSoTShcsGCPm8qUnsPm2xjqimX6wywOg3kWg9FYk/iAc+4AOLEb4/hdkohy
         T3bCaJNjHmi4kTi4TGNIznXYkLj1KLGHn+TLnQefsPV8CKYrBcDpXa3ZiMkFCzksIrbF
         0DMWG39dcUzbUb+8wnI+HDYLR/qA76ygbvMiDkdDE2NYk+zvuLq+I8PKCZqFimekhm44
         e7+uyaKPVoGP7yvNnaHECFF3FHiQsA1QqO7TKwZ4v7EbOxZMPRPpk1Idl5pIqf20ojH/
         eO8g==
X-Forwarded-Encrypted: i=1; AJvYcCWyMpBIfokWXUlbLkYWaeubVstO1L1zcnaVAL8aoiNw/gB54ZjVdqP+pKPiwUw6PVil52bx5ByEWqhJSVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLc0tAWp+YS1zitT+etAgfZfQJcHiwXKtQGAllDMlBP47LdFnd
	+1DhPo63mD7qjny0xJuJ/uWSWoR+627tJTRHzQKBosNH5PCNW9dCVedHfvaLQIdYq9QixFs0jnG
	SpC/xmNeXMaEn8lXXLlVVUPiqxAeTSQbzPXXxSPosyN9KUYGRSEfSiU44ULs=
X-Google-Smtp-Source: AGHT+IECe7+4JWTlUX5ahDOrF1l3veoWFm8tTRWDKu9dpqZiG+GZMcxtpuWC48N84X3BE7spBCw4vOPaGU2Eh6EcxLXqznbD0Owv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:3f6:56a4:1e13 with SMTP id
 e9e14a558f8ab-3fd806a3222mr186122465ab.1.1757452290676; Tue, 09 Sep 2025
 14:11:30 -0700 (PDT)
Date: Tue, 09 Sep 2025 14:11:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c09802.050a0220.3c6139.000e.GAE@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in clear_inode (4)
From: syzbot <syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f777d1112ee5 Merge tag 'vfs-6.17-rc6.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124dad62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
dashboard link: https://syzkaller.appspot.com/bug?extid=90266696fe5daacebd35
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a43562580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164dad62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/860ff2f591a4/disk-f777d111.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31f4ca3a76d4/vmlinux-f777d111.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c534fac91a74/bzImage-f777d111.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6c7a25c90276/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11a43562580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 40427
F2FS-fs (loop0): Wrong SSA boundary, start(3584) end(4096) blocks(3072)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): f2fs_convert_inline_folio: corrupted inline inode ino=3, i_addr[0]:0x1601, run fsck to fix.
------------[ cut here ]------------
kernel BUG at fs/inode.c:753!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6097 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:clear_inode+0x169/0x190 fs/inode.c:753
Code: 4c 89 f7 e8 59 7a ec ff e9 60 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 7c c0 4c 89 f7 e8 2f 7b ec ff eb b6 e8 28 40 8d ff 90 <0f> 0b e8 20 40 8d ff 90 0f 0b e8 18 40 8d ff 90 0f 0b e8 10 40 8d
RSP: 0018:ffffc9000408f890 EFLAGS: 00010293
RAX: ffffffff82311f78 RBX: ffff888022059300 RCX: ffff888024ced940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000408fa00 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1e3ab47 R12: dffffc0000000000
R13: ffff888022059300 R14: ffff888022059558 R15: 0000000000000001
FS:  000055557dd70500(0000) GS:ffff8881268bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055738e9e8660 CR3: 0000000029a1c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 evict+0x504/0x9c0 fs/inode.c:810
 f2fs_fill_super+0x5612/0x6fa0 fs/f2fs/super.c:5047
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f865d77038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc62ec72e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc62ec7370 RCX: 00007f865d77038a
RDX: 0000200000000140 RSI: 00002000000000c0 RDI: 00007ffc62ec7330
RBP: 0000200000000140 R08: 00007ffc62ec7370 R09: 0000000000000008
R10: 0000000000000008 R11: 0000000000000246 R12: 00002000000000c0
R13: 00007ffc62ec7330 R14: 0000000000005531 R15: 00002000000056c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:clear_inode+0x169/0x190 fs/inode.c:753
Code: 4c 89 f7 e8 59 7a ec ff e9 60 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 7c c0 4c 89 f7 e8 2f 7b ec ff eb b6 e8 28 40 8d ff 90 <0f> 0b e8 20 40 8d ff 90 0f 0b e8 18 40 8d ff 90 0f 0b e8 10 40 8d
RSP: 0018:ffffc9000408f890 EFLAGS: 00010293
RAX: ffffffff82311f78 RBX: ffff888022059300 RCX: ffff888024ced940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000408fa00 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1e3ab47 R12: dffffc0000000000
R13: ffff888022059300 R14: ffff888022059558 R15: 0000000000000001
FS:  000055557dd70500(0000) GS:ffff8881268bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055738e9e8660 CR3: 0000000029a1c000 CR4: 00000000003526f0


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

