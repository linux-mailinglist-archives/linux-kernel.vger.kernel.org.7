Return-Path: <linux-kernel+bounces-809036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED0EB507C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47892189CC37
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD82566D3;
	Tue,  9 Sep 2025 21:10:33 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75618859B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452232; cv=none; b=aZcvJ7+s163TAnOcQVtDmKY+MM0fe7u8lUwDaaFtGF8S2nYHDiGl2Nln30PkPI6qYC2iJrHlDTbYvbV9zHZU6C+vEdg8C5wS2SIApwCnCEkkfJrcg0GWKzYQuwChCqrqVt2RVfuTBGKy09t9SijhrQmnDCQhZy31v3gprpKEO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452232; c=relaxed/simple;
	bh=X9/dYQAkoulzTFjCDF2JWRG1z2iDw/sdelzr0cx3HHw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MHeyVEuOrjGY9SMfatGBe3LMTBbfR6len8qg4k2EcKUAP+H+pAn+0UjHYmIDPxwV2g+/40/YsXP3e6XhGzbP6GseThA9nB/XmNKy9ymEIDmH0a/CfP82Fsf0Y8sZm+hR6TGpgoqrrsw4hDGObQ/Yr46Kjz5hYbcPNw52c+s8hjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-886e347d2afso563447539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452230; x=1758057030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aROe+ahObfDL2t8NU8/dNghrt9SU6qR1dySg0DXLFPU=;
        b=wnfozB6Kv83L1iHi9otRbYPo0FE7DzoSr7TIXT3DcL9S3NrZak8Lae5taBrjwRumGe
         T/E9lTmZt0vbltlAEIZOAJ74A60rj/urkCYkQKFdthIJQiQQ1K75L5gjjWIBRTCNo3Yv
         DUdTFzF6ub6YkwyBNyoM+/NIN8I1KVDK8hDNrW7V4kYE9wY13NuIMQzWl6vEv94v5bHx
         6XCI2QWlOSRPIgKuzN5eGKzpx+CV2TcBrYm3k/o0Rb+K/pfwvRWBaKMB0wTnthIPQS1F
         hrLvDvMu0qV4wfQpExoHhJkNf0/SB6vWgni5j0LuKsZ/b4IjYPLJ7pc3n+CDPbARTXVg
         LqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZghcLF2u/NtyRJJx6P3K43eGZru88FedDSSA4nSfpr+zwcYpo4xV/e6sSfp+iDeqdcg3IiFCesDdoNdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbOxF5dKvqnFmzuBqmPSeFb57rY+nHCjcS2iFC0YZ0oPqU+fLA
	1itGKzsWontmw/BKFSerTce+Nx9WdrPoOKysEEpM3pZ7FPykJpjW4szPpuvFu3czBUWpEoTFVEq
	xYbtGb1vIN2PeUbf4wrcjXlg8WXSXOA8CtIZyXBB0941JJX8pzIuInGDxvqY=
X-Google-Smtp-Source: AGHT+IERcdOZjZ5aryNd9xS8Vt8QDCDJ7HtDdcUuJ8ypEL7PrbrcP/A6ckFdJ55JZYcEOrnw0buYBqeZx6WaWbTCQ8uqBD77Utob
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca48:0:b0:413:3da0:16bb with SMTP id
 e9e14a558f8ab-4133da01c60mr35231445ab.20.1757452230225; Tue, 09 Sep 2025
 14:10:30 -0700 (PDT)
Date: Tue, 09 Sep 2025 14:10:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c097c6.050a0220.3c6139.000b.GAE@google.com>
Subject: [syzbot] [udf?] WARNING in bdev_getblk (2)
From: syzbot <syzbot+7f94fe3ce0f6613e12b8@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c8ed9b5c02a5 Merge tag 'drm-fixes-2025-09-05' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178f3a42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=385d836f07b5a70d
dashboard link: https://syzkaller.appspot.com/bug?extid=7f94fe3ce0f6613e12b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1603f162580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17852962580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c8ed9b5c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a76961649a76/vmlinux-c8ed9b5c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c47f66170b29/bzImage-c8ed9b5c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f94fe3ce0f6613e12b8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5719 at fs/buffer.c:1125 __getblk_slow fs/buffer.c:1125 [inline]
WARNING: CPU: 0 PID: 5719 at fs/buffer.c:1125 bdev_getblk+0x580/0x660 fs/buffer.c:1461
Modules linked in:
CPU: 0 UID: 0 PID: 5719 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__getblk_slow fs/buffer.c:1125 [inline]
RIP: 0010:bdev_getblk+0x580/0x660 fs/buffer.c:1461
Code: 26 fb ff ff e8 61 2d 78 ff 48 c7 c7 60 05 9a 8b 48 c7 c6 55 e0 a0 8d 4c 89 fa 4c 89 e9 e8 58 0f e0 fe eb bd e8 41 2d 78 ff 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 41 80 3c 07 00 74 08 48 89
RSP: 0018:ffffc9000d18f6b0 EFLAGS: 00010293
RAX: ffffffff824790bf RBX: ffff888032185098 RCX: ffff888033aaa440
RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000000
RBP: 0000000000000200 R08: 0000000000000000 R09: ffffffff8217593d
R10: 0000000000000406 R11: 0000000000000000 R12: ffff8880321859f0
R13: ffff888032185080 R14: 0000000000000200 R15: 1ffff11006430a13
FS:  00007f265a53c6c0(0000) GS:ffff88808d20c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559033e08008 CR3: 00000000515c2000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __bread_gfp+0x89/0x3c0 fs/buffer.c:1515
 sb_bread include/linux/buffer_head.h:346 [inline]
 udf_read_tagged+0xad/0xe00 fs/udf/misc.c:199
 udf_check_anchor_block+0x99/0x550 fs/udf/super.c:1912
 udf_scan_anchors fs/udf/super.c:1952 [inline]
 udf_load_vrs+0x6e3/0xf20 fs/udf/super.c:2033
 udf_fill_super+0x5ad/0x17a0 fs/udf/super.c:2201
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f265978ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f265a53c038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f26599c6090 RCX: 00007f265978ebe9
RDX: 0000200000000080 RSI: 0000200000004a00 RDI: 0000200000000000
RBP: 00007f2659811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000002008087 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f26599c6128 R14: 00007f26599c6090 R15: 00007ffe80675be8
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

