Return-Path: <linux-kernel+bounces-735861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5CFB094A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13C1584F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379B2FD584;
	Thu, 17 Jul 2025 19:13:35 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA1219A89
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779615; cv=none; b=CQz5GEHVcJNyQB2kkdP0MRYWRt5EOjnJYp9egR2DHUW2pqVqLDIVviFojYMx6MigHgBjnZd0tHu/fhWBXOKjyvGM/+CWnlU6OEO2rE6VKb8CKfAgJwjER9VaJTA7segJdh3TguaxaUpe3pBv1909N519vWOD1igVjd+41MfRa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779615; c=relaxed/simple;
	bh=MtuOE0bRgiwI+RdjULoC0GTWgCGPkzKaJLP1Djdxp+c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HQHLLiYiPNw6SlzX1XBmXUHNY6ozU1q5VrsW/7cQkEEQdRsU6d2rr8fB/y8eXX2yIKbv3ugDSj3Umhsx9XlOAz0a2O34AbvzZKf5OLGrHf742xy0nmUpId8CF55Qc65osznWeEqtukFtr72P/zaTN1tCfG2AstezfvTDaqJQ3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87beb732acaso204878139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779612; x=1753384412;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOR/nA08lMnv4bs/7X6LwWg/H7cuOkwjTU50nq8CaAg=;
        b=gWEOhATL5f/qDIxSeBmWoOdvgD6uwU3iVWk2FV1yPrmG68FJ1bHRbLcPLaxMS0q7yK
         zF7tcvv/VbyYu4Rck97b1DytHAoD9B24/hA3hhCOZLcPbRTAoXgfrrA2AV1wUtihDtCf
         PTA/F/xw/upQhfzQ7aXfx1p+fd9vMWjmZL7R0uTUsKbbhPDFX4o3eKBf/lkQ0U5r3vTm
         J/1QzI6kklhDV+mZjs3elXQVYdFiMjjhBF43SKK99REOu/9FXchjGtaEeU6vyQAWXDJe
         NTjyl35EqOMqpu6ecIB9GWxJLp02b1haXGdBswFcUD2X5olZJZObALG5sfbiSFIcNxKb
         eELA==
X-Forwarded-Encrypted: i=1; AJvYcCXCeqF0FMlingDZk/sO8qZdSHC6QCo17NRQhitkjmtMfQTQQ9ivEsHRCxyJlPF9QCgON1hHpdEQfzrszKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq09bT2YQ0iGjEGsEcxwWol1Ne1UE39n3mftBqODL3D5yfAQjL
	Ugm5cVKU6GNaZT2XGI2iJWcnSuBE9bNdFJKJEgGJjM9NrOHKUrmkMPtxguO4AGFMCmgPUwy4H9+
	AeCbulkuudQ7PpcHmmBi7p6XwrlTpjebgQz9weCXgYfefvqoKb3cSTXz0q90=
X-Google-Smtp-Source: AGHT+IECtijqfJfhEfNqOOIS0Aa28xIe9pZgjoRGbRNw9QKNWXlsHUiALD3BBIkh6i5Cm9CD5kffHw7bKvfwcuVqsZyuLUYq7uFt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24b:0:b0:3df:4234:df71 with SMTP id
 e9e14a558f8ab-3e282e551fcmr87124505ab.10.1752779612675; Thu, 17 Jul 2025
 12:13:32 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:13:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68794b5c.a70a0220.693ce.004f.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_printbuf_exit
From: syzbot <syzbot+1faf405b707c6475482f@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    e8352908bdcd Add linux-next specific files for 20250716
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D100e158c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2594af20939db73=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1faf405b707c64754=
82f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-=
1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17b1e38258000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10e8e7d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c5f2b597f40f/disk-=
e8352908.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d56411fc215/vmlinux-=
e8352908.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7f800652df04/bzI=
mage-e8352908.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/24f97c1c6123=
/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+1faf405b707c6475482f@syzkaller.appspotmail.com

    bi_fields_set=3D0
    bi_dir=3D0
    bi_dir_offset=3D0
    bi_subvol=3D0
    bi_parent_subvol=3D0
    bi_nocow=3D0
    bi_depth=3D0
    bi_inodes_32bit=3D0
    bi_casefold=3D0, fixing
bcachefs (loop0): hash table key at wrong offset: should be at 605384339683=
1044271
  u64s 7 type dirent 4096:4330382808765833931:U32_MAX len 0 ver 0: =EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD1 -> 536870912 type reg, fixing
------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:23!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5848 Comm: syz-executor288 Not tainted 6.16.0-rc6-next-2=
0250716-syzkaller #0 PREEMPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 05/07/2025
RIP: 0010:__phys_addr+0x17b/0x180 arch/x86/mm/physaddr.c:23
Code: 50 fe fa 8d 48 89 de 4c 89 f2 e8 80 15 8b 03 e9 4d ff ff ff e8 e6 32 =
4b 00 90 0f 0b e8 de 32 4b 00 90 0f 0b e8 d6 32 4b 00 90 <0f> 0b 0f 1f 00 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90003e0dfa8 EFLAGS: 00010293
RAX: ffffffff817473fa RBX: 000000007ffffffc RCX: ffff888031bf8000
RDX: 0000000000000000 RSI: 000000007ffffffc RDI: 000000001fffffff
RBP: 0000000000000002 R08: fffffffffffffffc R09: fffffffffffffffc
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90003e0e530
R13: ffffc90003e0ee00 R14: 000000007ffffffc R15: dffffc0000000000
FS:  000055558a225380(0000) GS:ffff888125ce2000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f740dd9b000 CR3: 0000000071cd2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1178 [inline]
 kfree+0x77/0x440 mm/slub.c:4871
 bch2_printbuf_exit+0x6f/0xb0 fs/bcachefs/printbuf.c:219
 class_printbuf_destructor fs/bcachefs/printbuf.h:148 [inline]
 bch2_str_hash_repair_key+0xf2b/0x4030 fs/bcachefs/str_hash.c:336
 __bch2_str_hash_check_key+0xa85/0xd60 fs/bcachefs/str_hash.c:391
 bch2_str_hash_check_key fs/bcachefs/str_hash.h:427 [inline]
 check_dirent fs/bcachefs/fsck.c:2310 [inline]
 bch2_check_dirents+0x21fe/0x3440 fs/bcachefs/fsck.c:2449
 bch2_run_recovery_pass fs/bcachefs/recovery_passes.c:479 [inline]
 __bch2_run_recovery_passes+0x39d/0x1050 fs/bcachefs/recovery_passes.c:535
 bch2_run_recovery_passes+0x184/0x210 fs/bcachefs/recovery_passes.c:606
 bch2_fs_recovery+0x2544/0x3860 fs/bcachefs/recovery.c:995
 bch2_fs_start+0x957/0xbf0 fs/bcachefs/super.c:1216
 bch2_fs_get_tree+0xb39/0x1540 fs/bcachefs/fs.c:2456
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe9b6ab4e2a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc69216268 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc69216280 RCX: 00007fe9b6ab4e2a
RDX: 00002000000000c0 RSI: 0000200000000340 RDI: 00007ffc69216280
RBP: 0000200000000340 R08: 00007ffc692162c0 R09: 000000000000597e
R10: 0000000001014040 R11: 0000000000000282 R12: 00002000000000c0
R13: 00007ffc692162c0 R14: 0000000000000003 R15: 0000000001014040
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x17b/0x180 arch/x86/mm/physaddr.c:23
Code: 50 fe fa 8d 48 89 de 4c 89 f2 e8 80 15 8b 03 e9 4d ff ff ff e8 e6 32 =
4b 00 90 0f 0b e8 de 32 4b 00 90 0f 0b e8 d6 32 4b 00 90 <0f> 0b 0f 1f 00 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90003e0dfa8 EFLAGS: 00010293
RAX: ffffffff817473fa RBX: 000000007ffffffc RCX: ffff888031bf8000
RDX: 0000000000000000 RSI: 000000007ffffffc RDI: 000000001fffffff
RBP: 0000000000000002 R08: fffffffffffffffc R09: fffffffffffffffc
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90003e0e530
R13: ffffc90003e0ee00 R14: 000000007ffffffc R15: dffffc0000000000
FS:  000055558a225380(0000) GS:ffff888125be2000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f740e4bed30 CR3: 0000000071cd2000 CR4: 00000000003526f0


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

