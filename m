Return-Path: <linux-kernel+bounces-874914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1EC177E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022713AD03C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71231EF39E;
	Wed, 29 Oct 2025 00:12:36 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85E2836F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696756; cv=none; b=sERbaS86IwSVuVfCHEU23XlwHhMlG92CxjFDG9NMBPvZq77wJ3tTGIYqiy/4gX5E7toUE3u5jz21vwlk1CubaIxncffaxVLxGM9nWrRPU/1fElx2W7Yg5KjhmCqHBCY/ZWvOMbnK20E78KIsSexJl/RolhyK5wMbZ6prqlwMiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696756; c=relaxed/simple;
	bh=BDxRhop8dq6dGIGdUm3EytmC0tXgAmYyYbhI0AnbcGU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PtuuGC4CPqvFnMomuap69dF4K09uDklBoJPu0q/L1h/1/F01PdhQrxUS/xpDI38gi8oHBadL6RhYfvq94n9Iqd2KWT0sqy+8HNSRh/rqm8PLHhUtH6qONr90GtMdzeDYJnjxEYv7+sfdCWMcoXMPk5DvoL+Ho97r/blLI0WClFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430d4a4dea3so6769095ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696754; x=1762301554;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHjlQLKXYAvzQ021Rh2vJ0um9x0m6CCEDRe9/QdSKtA=;
        b=TBGVQL3PJBB6iQO5pmqkNgTn7StNY6Z6XCv6jEMyq5sWHpe8oy8ZhasNty7EPq6sVu
         ipXgn6Lq+oIt018ava7FUnouTx1jr48RTISBpayCYrElFNPk/LEAYZi47GvMi8TxAxtS
         a3YTXUvwyihOb7mB6kZg2twa+UvPEKmk2Kp8mCgcjNCW6YJqOsD1Q84hJenwB9GuGWMd
         9QHG71K5pn777MnmmXZ+9h/g6aBQvkgSMkJp7Ns+GZX7HRbU6jO7ps9oWfpVd5/aJCTZ
         lMWcXDYZRMpJg9fLcimWWROawko8AaKHrIR098K80U/37jVvt11yRSvs7q65ChEUoo54
         BFqA==
X-Forwarded-Encrypted: i=1; AJvYcCWdZ0Hbv3stLmTjlxUthWal1JxcBD63ZsLkpHM9e46eOk7gqFG+/1gu9Ppmj492Z5BoIWkQg/Lbcf6uiow=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxZpAsIh9w1Rn66AwG4XfDNrFU3middDwiXv7n7tjwpIo7xQc
	YI/aHwLhtdFqTEgMfurHdiYRXNIp+GYP+y9OLtCgoUItMno3cD7WxlWWPsphIoT2dsXc5JFZWIj
	t3DL6xNaeCp7vYry/Iabcxzb5w3c0YhpAZgvKLwoN+q2iChUOd6cECaqvMiM=
X-Google-Smtp-Source: AGHT+IHU8MT6Z7C4GsQPasY7ylFYsPjt/O9coMlvrh2+a3htHUCIGs9yf1zB+uShe3N63W7aSKUXso9aYttaRlwYNsG0zO0htwn/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e05:b0:430:c857:734e with SMTP id
 e9e14a558f8ab-432f8e2f263mr22346695ab.10.1761696753737; Tue, 28 Oct 2025
 17:12:33 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:12:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69015bf1.050a0220.3344a1.03f8.GAE@google.com>
Subject: [syzbot] [ntfs3?] WARNING in ntfs_fill_super (2)
From: syzbot <syzbot+2e6c1eda2eff0745b028@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f7d2388eeec2 Add linux-next specific files for 20251028
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15edde7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecdce5bceba74f
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6c1eda2eff0745b028
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116e6704580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11198fe2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8aa0aaa475d1/disk-f7d2388e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc97cba5a8b0/vmlinux-f7d2388e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/30e4617d837c/bzImage-f7d2388e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7f2ed67d49f3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e6c1eda2eff0745b028@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (4096) and media sector size (512).
ntfs3(loop0): $Secure::$SII is corrupted.
ntfs3(loop0): Failed to initialize $Secure (-22).
------------[ cut here ]------------
WARNING: mm/slub.c:6752 at free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6752, CPU#1: syz.0.17/5997
Modules linked in:
CPU: 1 UID: 0 PID: 5997 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:free_large_kmalloc+0x15c/0x1f0 mm/slub.c:6752
Code: 44 89 f6 e8 16 d1 fc ff 65 48 8b 05 1e c3 57 10 48 3b 44 24 08 75 57 48 83 c4 10 5b 41 5c 41 5e 41 5f 5d e9 86 7b 3b 09 cc 90 <0f> 0b 90 65 48 8b 05 f9 c2 57 10 48 3b 44 24 08 75 32 48 89 df 48
RSP: 0018:ffffc90003a3f880 EFLAGS: 00010206
RAX: 00000000ff000000 RBX: ffffea0000389000 RCX: ffffea0000389008
RDX: 0000000000000000 RSI: ffffffff8e240de0 RDI: ffffea0000389000
RBP: ffffc90003a3fbb0 R08: ffffc90003a3f4a7 R09: 1ffff92000747e94
R10: dffffc0000000000 R11: fffff52000747e95 R12: 0000000000000000
R13: 00000000ffffffea R14: dffffc0000000000 R15: ffff88807b48e9b0
FS:  0000555574161500(0000) GS:ffff888125feb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe9d639d000 CR3: 000000007fa22000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ntfs_fill_super+0x656/0x43d0 fs/ntfs3/super.c:1674
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9eef39076a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8b15b1b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd8b15b240 RCX: 00007f9eef39076a
RDX: 0000200000000100 RSI: 0000200000000140 RDI: 00007ffd8b15b200
RBP: 0000200000000100 R08: 00007ffd8b15b240 R09: 0000000002200010
R10: 0000000002200010 R11: 0000000000000246 R12: 0000200000000140
R13: 00007ffd8b15b200 R14: 000000000001f2b6 R15: 0000200000000780
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

