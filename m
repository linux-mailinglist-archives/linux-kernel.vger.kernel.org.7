Return-Path: <linux-kernel+bounces-828658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977CCB951C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF897B21EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937F31E892;
	Tue, 23 Sep 2025 09:03:32 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383822097
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618211; cv=none; b=Mpu25CUDWPyp0gJ+UToYW2i3z/sRLMck9hSVbnuoO57pcgPXg6EgvG4yP8L8hqYkzJc1j2AFm8yc9j3+aPRF29D3F3YQI3WPRe2lqBeJhY0YIhkj9fQ4SU257ylj8nOlG34lROXBo61j3vjviIKwSRNUcmopBgww2HkdNuSQ0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618211; c=relaxed/simple;
	bh=x9PFS7wCOEeobor166cLYDcLun8YYYLLo5sibGz1s7U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gIA85Y/8lCs72dEf4D2Ncp0mmx2nFYTmQ5Cp/a6W/8if61+45ILw5T8Oyt78r0uGeQu5siObjRbdobnG6k2LKhIzW5EstTfd1HMmLV/3erVdj3kry+zN9jN+M9eOWciNHCgajbSaJ6de1Vbhqs0JE3Mixx5oXp/x/bGecrVnp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8870219dce3so543651939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618209; x=1759223009;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DBJDn6xDaiOhYMo2RaF4q11GLTSm+nfoJ4hteBQ+HQ=;
        b=aFDIi8QibziruMiKaMKVFcZmdMzw52oYRhE571l9NweetckFAlukVsKcV/u5Ns6gD9
         J/O1rxMRY6eYfO7JYM7B+B7IqiaIIUqBqfs+AkSXWdKbmq7QAi4V4jU7ieyR0Ryu5AsA
         10Ovz9RHguMsiHPEdz6RaLF5zjNratMl2jV/dKfczCbQtjoDkULYtH1ZwPUOBfOc0cI2
         IuWcSfz3IaFX0c1yGDq+hffFHZLkWb7J/35XDqLtbdxhltomrgYMZq5uBjqGfmyeq5LA
         dj291GxuyVGRPhMHKwesAh2y6UGQblrqrpfEF5t37qK4vpmDXZjKlHPtTPsfRHGS7Tzz
         ju1g==
X-Forwarded-Encrypted: i=1; AJvYcCWQciryBAEvihrP/854MC6ajfmnb+gwpTWIvcbv6WjuO/SgkEa2Iodz48jyTC5Xa3LBBrfNBeuVXnsiJjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyE2x7NYWCsZv20DtRCDzcMOiHgnq/OXlmBE/4gn69tfkXT63H
	g4/vkGLp+s+Fdjo2rKZd0nAGyWQ60zeSrY/hrc2Ui+MdGwg77F1V86O0uo7D/E5sPeFIYu6LMLp
	TJlHrf64MEdX3QmkGom+rfP2RZqX2i5Ktpyd9p+d0u0C+ViShzS9HnVhbRg0=
X-Google-Smtp-Source: AGHT+IE/1nhaPRURoqVDgGdxyupjZFT/6ioLFhQOG75Ih/hNH2NvNvEsaKQZwfJVfUbEhIe0M8hJycznVzxXLNPubyRxPiFEKLtK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c86:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-42581ebcee2mr27557375ab.27.1758618209337; Tue, 23 Sep 2025
 02:03:29 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:03:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d26261.a70a0220.4f78.0003.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, osalvador@suse.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    846bd2225ec3 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=162ab8e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173b4142580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f504e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c53d48022f8a/disk-846bd222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483534e784c8/vmlinux-846bd222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/721b36eec9b3/bzImage-846bd222.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/hugetlb.c:368 at hugetlb_vma_assert_locked+0x1dd/0x250 mm/hugetlb.c:368, CPU#0: syz.0.366/7101
Modules linked in:
CPU: 0 UID: 0 PID: 7101 Comm: syz.0.366 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:hugetlb_vma_assert_locked+0x1dd/0x250 mm/hugetlb.c:368
Code: 2e e8 17 e8 a1 ff eb 0c e8 10 e8 a1 ff eb 05 e8 09 e8 a1 ff 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 f4 e7 a1 ff 90 <0f> 0b 90 eb e5 e8 e9 e7 a1 ff 90 0f 0b 90 eb da 48 c7 c1 70 0b e5
RSP: 0018:ffffc900036b7388 EFLAGS: 00010293
RAX: ffffffff821e312c RBX: 0000000000000000 RCX: ffff88807bc95ac0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006d6e74 R12: ffff888033642a00
R13: 1ffff1100f12319c R14: dffffc0000000000 R15: 0000000000000080
FS:  00007fa9ba21d6c0(0000) GS:ffff8881257a2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa9ba21cf98 CR3: 0000000078830000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 huge_pmd_unshare+0x2c8/0x540 mm/hugetlb.c:7622
 __unmap_hugepage_range+0x6e3/0x1aa0 mm/hugetlb.c:5901
 unmap_hugepage_range+0x32e/0x410 mm/hugetlb.c:6089
 hugetlb_vmdelete_list+0x171/0x1c0 fs/hugetlbfs/inode.c:494
 hugetlb_vmtruncate fs/hugetlbfs/inode.c:641 [inline]
 hugetlbfs_setattr+0x4d1/0x6d0 fs/hugetlbfs/inode.c:879
 notify_change+0xc1a/0xf40 fs/attr.c:546
 do_truncate+0x1a4/0x220 fs/open.c:68
 handle_truncate fs/namei.c:3516 [inline]
 do_open fs/namei.c:3899 [inline]
 path_openat+0x306c/0x3830 fs/namei.c:4054
 do_filp_open+0x1fa/0x410 fs/namei.c:4081
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_open fs/open.c:1458 [inline]
 __se_sys_open fs/open.c:1454 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa9b938eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa9ba21d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fa9b95e5fa0 RCX: 00007fa9b938eec9
RDX: 0000000000000100 RSI: 000000000014927e RDI: 0000200000000340
RBP: 00007fa9b9411f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa9b95e6038 R14: 00007fa9b95e5fa0 R15: 00007ffdd776dfc8
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

