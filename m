Return-Path: <linux-kernel+bounces-692144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5277ADED70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 15:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F33A3B2A37
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720282E7622;
	Wed, 18 Jun 2025 13:07:23 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3AB2E54D0
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252043; cv=none; b=owoL983QATZn+MbfCbuOjnntKhVmZOps4gHM+Mgj1EcoILWuvGQSXblpcqDCqG0LnQz07eNbJbegRRe6hl+ZCME33199353XLvqRWdMSNahPnAWYzQHLJY/aObnX8c+iN1OSmZGNLOE31LI65MjA51Q6JnqZQr+B0RR/lopNSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252043; c=relaxed/simple;
	bh=YT4slGZLjT3z3if1pDL1XfyU2P/p1nEtvH/FFrcg1vA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZPKPRGDovMrQeW0VtAia3Zpmu2lsvfGPqYLZXQqMiojiA/MCrVdK5+ZyFUedzaV7gS7+m8Wi28C6caGcehVv8QM0QxWYrE4iN7A9BALRZhEexTnYYu+cJ0+CoSGfcDI0QjU24XbwChShE6WnzaOApgmDSj5HEvNXCdcZw+m5cOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddc6d66787so92129035ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 06:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750252040; x=1750856840;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29iIlAM/vPeDIyvRyfchXzOgO7DL5UfI/2dgENdz4q0=;
        b=F2ud21AM+1FrCGqhS+KjJ2ZZZBzHN3LbhxUrUcQahSrdqqrWnmP9L5xsmotblDwGrQ
         vuKSYmdayVYkT99kqQuSlFGwEXJYlGEsZ3+A+EkgCP/Qq/NkiNJBK+rcr5lzo0g6Lo9P
         LEdsVrjU8jIjXwHe/DetB4fuFWekY+lnF2LWCB8C6GOBFxupPpAI4lfrOxREZNbxDnYW
         3Mhu9b7vRCf9Mt3K96g+gkmgfbvSIcWb8yfIYrLLfGmCf9l4F3+AsVWvSMHvCDo+XSQz
         EhhWmWJbuRQpxHpCc8Rd+K0nNmAXlEMZWiliBj+1Jqp5wJF/2JEJECRauZpEtMFUcgH8
         T+pw==
X-Gm-Message-State: AOJu0YwIPFspxFWK+8qolwc7wy/MwK8H37454kBEV3nRgghAkPiGmRPa
	1hhmcXNvNOruJ0NHKVuafnoiLrOF6/vR/rGtqUFA+MCz2+kiyOITRbnQ5ek4VAbumKs2WezK0G7
	1DBR4oPIAeLZ+TML8LmqCVvc2ZP+9Rtesl2AvurreB8RxXLt2uV6oUH1MCGcoOg==
X-Google-Smtp-Source: AGHT+IHsiUSW+UimKk/AACwNTW7uFLE8AyVvAaU7GFns0uX4B+XFPTuTKQ7eXhSqtaLNS2kuy4FNJBMP8ZVgjBPdfwy+pTxt1fpA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:3dd:d746:25eb with SMTP id
 e9e14a558f8ab-3de07cd170amr198045805ab.16.1750252040444; Wed, 18 Jun 2025
 06:07:20 -0700 (PDT)
Date: Wed, 18 Jun 2025 06:07:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6852ba08.050a0220.216029.0011.GAE@google.com>
Subject: [syzbot] [selinux?] WARNING in hashtab_init
From: syzbot <syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    52da431bf03b Merge tag 'libnvdimm-fixes-6.16-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144635d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4130f4d8a06c3e71
dashboard link: https://syzkaller.appspot.com/bug?extid=bc2c99c2929c3d219fb3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a1f50c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1094050c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-52da431b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ebc79a3dea1/vmlinux-52da431b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b1157e117a2/bzImage-52da431b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com

WARNING: CPU: 3 PID: 5931 at mm/page_alloc.c:4935 __alloc_frozen_pages_noprof+0x30b/0x23f0 mm/page_alloc.c:4935
Modules linked in:
CPU: 3 UID: 0 PID: 5931 Comm: syz-executor128 Not tainted 6.16.0-rc2-syzkaller-00047-g52da431bf03b #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_frozen_pages_noprof+0x30b/0x23f0 mm/page_alloc.c:4935
Code: f0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 83 fe 0a 0f 86 0a fe ff ff 80 3d 83 6e 7a 0e 00 75 0b c6 05 7a 6e 7a 0e 01 90 <0f> 0b 90 45 31 f6 eb 81 4d 85 f6 74 22 44 89 fa 89 ee 4c 89 f7 e8
RSP: 0018:ffffc90003d87438 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000015 RDI: 0000000000040dc0
RBP: 0000000200000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000040000000 R11: 0000000000000001 R12: 0000000000000015
R13: 1ffff920007b0e9c R14: 0000000200000000 R15: 0000000000000015
FS:  0000555574b0f380(0000) GS:ffff8880d6a53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 000000002a80f000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_noprof+0xb/0x1b0 mm/page_alloc.c:4993
 __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
 ___kmalloc_large_node+0x84/0x1e0 mm/slub.c:4272
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4300
 __do_kmalloc_node mm/slub.c:4316 [inline]
 __kmalloc_noprof.cold+0xc/0x61 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 hashtab_init+0x1b1/0x290 security/selinux/ss/hashtab.c:43
 common_read+0x1c2/0x3d0 security/selinux/ss/policydb.c:1172
 policydb_read+0x874/0x3220 security/selinux/ss/policydb.c:2578
 security_load_policy+0x15c/0x12c0 security/selinux/ss/services.c:2299
 sel_write_load+0x332/0x1bd0 security/selinux/selinuxfs.c:603
 vfs_write+0x2a0/0x1150 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0fd65a5d79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc49f31638 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000200000000300 RCX: 00007f0fd65a5d79
RDX: 0000000000002000 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 0000200000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000008f R11: 0000000000000246 R12: 00007f0fd65f419c
R13: 00007f0fd65ef082 R14: 0000000000000001 R15: 0000000000000001
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

