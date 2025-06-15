Return-Path: <linux-kernel+bounces-687319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77178ADA2C1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6E93B12A5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7127A12F;
	Sun, 15 Jun 2025 17:07:28 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE01A840A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750007248; cv=none; b=rVEhWxNLLt5U/0MEE4roGeLHaY7h7BjcSQTaZB3CV/DRF+h3KhwPhsXIfC/8bynhWdo1nuzmiE9YD2vvoF303jAVq4rcdTMy1EAEev7YoIgS7aREgHkXgK2XEccreMfPPOxTnc7BsfBxHFlOFJWNVaeqqCpF+783TSsLXnJBBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750007248; c=relaxed/simple;
	bh=Vw1a8uDnCR8nuRBjztWUG2BFmges2wmcLR+AMEKqAoU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=skfCM1MIw4LhX1xu1PBX4zwXrzrKKnc846G860qIbOFNMMCimsutYWXc8Wl9cswopaYaSEbhgpdNdtYEfxpeEv6lKh2m+SbqJtm/09Rf2WBZ+vIz3MULAffCeypSbQrhfyqXo/eepf16sTF1zB7pE3y8TylrTT63kvBeXHdv8A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddc5137992so42648675ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 10:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750007246; x=1750612046;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuWcFcctyDFv1ZXS1aYW5Py6XC2zw0uCFEY1yzDOT+o=;
        b=AHxbYmBdjd92cho16/Z8Q59o9UwD2lDjwcX7bNICQGnSKsxSdutwA7sDCAXEDrqdJ2
         9KfcX/AKBThA1lbd/oKIZAGEqKyXrUlOMjoJJ4RskNvxq4NnthcVD/z0JjwPDFdCHGmO
         K2W0vYCqqhyR+8f7DrAvl5jS9aWTV5FMethgLNSuft70YUjRZTuVZIb6jVKgxpPQUTqJ
         O2kv4IfWSaFj9vGHVPoyel1pdgv/D61AaasNDDPwpfzoY9HNamfDVX12oO5EDb0dffwG
         tfltSclHXYsCAkpmsOCsXMK2PigqyNisB19XkQMhWW/8Db/Dw9JyjXkjj8PFNV6gAx/M
         fXCA==
X-Forwarded-Encrypted: i=1; AJvYcCVBHhPbozSDREPEaxJGDF2N6nEPyasdLIuyrUUgydNJyJG82AWj6zslfgSR7Xx53055zMlCJhS9o0dKAew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYgZxM2vV2+Tzj6+OIcTxPOG/VpCyc+FYtowRdOKBF+4+43SD
	STExxGMPQ/mgA/2hBprgvr7dqTq7NOruTbOjGC9zDzIHOy4xptSiAkuEK3skrywKoDyttuqdHiq
	ph8nqeS0yKxEXEzss8DNYNNtXsq4bEJQ26Suh3Y9mJHn+03+ahSL37y/+mt4=
X-Google-Smtp-Source: AGHT+IHQZ3Te4HdIp2GJFXXT4zhKwLGAn2/HMxHDi/lS/mqUh8uKvql3w9Z44LXZO+0V67jwsnnNPLx3E4gXLMoVme3IDpSgERk1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2308:b0:3dd:f4d5:1c1a with SMTP id
 e9e14a558f8ab-3de07cd1771mr66086365ab.17.1750007245854; Sun, 15 Jun 2025
 10:07:25 -0700 (PDT)
Date: Sun, 15 Jun 2025 10:07:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684efdcd.050a0220.be214.02c1.GAE@google.com>
Subject: [syzbot] [ocfs2?] BUG: unable to handle kernel paging request in ocfs2_unlock_and_free_folios
From: syzbot <syzbot+c2ea94ae47cd7e3881ec@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c4a1f3fe03e Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1422ee0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c07f08ee4bcfb276
dashboard link: https://syzkaller.appspot.com/bug?extid=c2ea94ae47cd7e3881ec
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ede60c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15aab682580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2c4a1f3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe90e2ba373e/vmlinux-2c4a1f3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fdd4ddecb119/bzImage-2c4a1f3f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/77e1eb294850/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1727a10c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2ea94ae47cd7e3881ec@syzkaller.appspotmail.com

R10: 0000000000000001 R11: 0000000000000246 R12: 0000200000000180
R13: 00007ffd0a9a15d0 R14: 431bde82d7b634db R15: 00007f06760c301d
 </TASK>
(syz-executor335,5312,0):ocfs2_grab_folios_for_write:1073 ERROR: status = -12
(syz-executor335,5312,0):ocfs2_write_begin_nolock:1791 ERROR: status = -12
BUG: unable to handle page fault for address: fffffffffffffffc
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD df3d067 P4D df3d067 PUD df3f067 PMD 0 
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5312 Comm: syz-executor335 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:const_folio_flags include/linux/page-flags.h:347 [inline]
RIP: 0010:folio_test_locked include/linux/page-flags.h:547 [inline]
RIP: 0010:folio_unlock+0x3a/0x160 mm/filemap.c:1498
Code: fb 49 bf 00 00 00 00 00 fc ff df e8 20 df c8 ff 4c 8d 73 08 4d 89 f4 49 c1 ec 03 43 80 3c 3c 00 74 08 4c 89 f7 e8 76 56 2c 00 <4d> 8b 2e 4c 89 ee 48 83 e6 01 31 ff e8 d5 e3 c8 ff 49 83 e5 01 0f
RSP: 0018:ffffc9000d517128 EFLAGS: 00010246
RAX: ffffffff81f77fd0 RBX: fffffffffffffff4 RCX: ffff8880007fc880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: fffffffffffffff4
RBP: 0000000000000001 R08: ffff88803fedc07f R09: 1ffff11007fdb80f
R10: dffffc0000000000 R11: ffffed1007fdb810 R12: 1fffffffffffffff
R13: 0000000000000000 R14: fffffffffffffffc R15: dffffc0000000000
FS:  000055557d696380(0000) GS:ffff88808d252000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffffc CR3: 0000000042b50000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_unlock_and_free_folios+0x71/0x1a0 fs/ocfs2/aops.c:765
 ocfs2_free_write_ctxt fs/ocfs2/aops.c:813 [inline]
 ocfs2_write_begin_nolock+0x3078/0x4340 fs/ocfs2/aops.c:1830
 ocfs2_write_begin+0x1bb/0x310 fs/ocfs2/aops.c:1882
 generic_perform_write+0x2c4/0x910 mm/filemap.c:4112
 ocfs2_file_write_iter+0x157a/0x1d10 fs/ocfs2/file.c:2469
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0676081af9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd0a9a1498 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffd0a9a14c0 RCX: 00007f0676081af9
RDX: 00000000fffffec6 RSI: 0000200000000180 RDI: 0000000000000005
RBP: 0000000000000001 R08: 00007ffd0a9a1237 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000200000000180
R13: 00007ffd0a9a15d0 R14: 431bde82d7b634db R15: 00007f06760c301d
 </TASK>
Modules linked in:
CR2: fffffffffffffffc
---[ end trace 0000000000000000 ]---
RIP: 0010:const_folio_flags include/linux/page-flags.h:347 [inline]
RIP: 0010:folio_test_locked include/linux/page-flags.h:547 [inline]
RIP: 0010:folio_unlock+0x3a/0x160 mm/filemap.c:1498
Code: fb 49 bf 00 00 00 00 00 fc ff df e8 20 df c8 ff 4c 8d 73 08 4d 89 f4 49 c1 ec 03 43 80 3c 3c 00 74 08 4c 89 f7 e8 76 56 2c 00 <4d> 8b 2e 4c 89 ee 48 83 e6 01 31 ff e8 d5 e3 c8 ff 49 83 e5 01 0f
RSP: 0018:ffffc9000d517128 EFLAGS: 00010246
RAX: ffffffff81f77fd0 RBX: fffffffffffffff4 RCX: ffff8880007fc880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: fffffffffffffff4
RBP: 0000000000000001 R08: ffff88803fedc07f R09: 1ffff11007fdb80f
R10: dffffc0000000000 R11: ffffed1007fdb810 R12: 1fffffffffffffff
R13: 0000000000000000 R14: fffffffffffffffc R15: dffffc0000000000
FS:  000055557d696380(0000) GS:ffff88808d252000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffffc CR3: 0000000042b50000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fb                   	sti
   1:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
   8:	fc ff df
   b:	e8 20 df c8 ff       	call   0xffc8df30
  10:	4c 8d 73 08          	lea    0x8(%rbx),%r14
  14:	4d 89 f4             	mov    %r14,%r12
  17:	49 c1 ec 03          	shr    $0x3,%r12
  1b:	43 80 3c 3c 00       	cmpb   $0x0,(%r12,%r15,1)
  20:	74 08                	je     0x2a
  22:	4c 89 f7             	mov    %r14,%rdi
  25:	e8 76 56 2c 00       	call   0x2c56a0
* 2a:	4d 8b 2e             	mov    (%r14),%r13 <-- trapping instruction
  2d:	4c 89 ee             	mov    %r13,%rsi
  30:	48 83 e6 01          	and    $0x1,%rsi
  34:	31 ff                	xor    %edi,%edi
  36:	e8 d5 e3 c8 ff       	call   0xffc8e410
  3b:	49 83 e5 01          	and    $0x1,%r13
  3f:	0f                   	.byte 0xf


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

