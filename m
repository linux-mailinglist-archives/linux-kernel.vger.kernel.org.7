Return-Path: <linux-kernel+bounces-727985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F3B0221B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57925189E1B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2AC2EE271;
	Fri, 11 Jul 2025 16:44:27 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C188F17A2EB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252267; cv=none; b=eS8KgdgoU/e2aRS5FQBNZ+vpPP+VKfeF6n2v7awGNWyN27FT5NVqS+nwYjEqHk1v+sCn2hi5jsyq4GfgNF7kMHmVqDwXP8BD1kmayG33+UaQeAoRRnhB53ToZIShgpDTXBipZV6m9R6/TfBxF3BRsIuEVT3rKy2FyuBxm6BNigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252267; c=relaxed/simple;
	bh=ylIpMoQL0XDvbunjsqnjrjcY1gTenYT0w9eJXtYIlCs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q3GsdnCuIl8mHSUmpot6rr7CXSggVMzGHoVtXOxTooqSdACWeQKksyFPZ+W1s7smEOzF5lfNnItvOq8OA+OcdQDc267NUGlui7ThYHohCVBzRFUnSNJkLVuSTlxap1XX3oNDwexYsqUFfPWh0fBwnJf8zFYg7SXcmJeP+EI/qOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86f4f032308so405574139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752252265; x=1752857065;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ga+y/KPA/JaFnBOfCyUSAge1gOX87PpAmzHhX1vwmVA=;
        b=uumzrx+Qn8fvXW2xc4W8rWlanMhd8+S4E6zDU/vCsYD3Zo6gHOSfh8nFo5YCS2YhNi
         HM61fLMrpaCrfW4sBO9Og8AIyDFyodKpOF3VcdcPwY4+tGWSDAz6b2ObR9l4UcC2fRaA
         /ZLYbLWZI6Ub1gCvUkSJROO/pEfptrhXtkpBf4ynqsORor09TV+PsHPvcEwO9EVcUIiJ
         mYhcmX8gatAPMZOabvoafDG6CveGs7pFoPQk6nrqJZ+hEQfvuDGL4UQavEU7RuMYRfV6
         cuMh5U9Owqf7jZjVde6jVqAfVgO1z61Gp/mFUy3zXJjEL4ANXL7H0M5ifOaLjxS8muP/
         HnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUknILUJIO2SFboFmcR/pfpWnGAAI3ZeTbeCQsKY2nFL3mZRhIBjV+yHripffbGRjagOmt9FHHOkuxJcw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpiuMjF02T32HYKg8tYzcUCz1LXn9+MbJIBUINDAByIAdYU0+n
	5VEHIK9oluM+TjANMvGRbg7e+kbgkuJUK2YFwwLeEKTOZInh0DiOIwG2dZ+vPuhoeJ++Qif2Jc9
	OutkNC7Dj+kSgp5LRPD7Fhj1aIdaSgpDxwPM9qODYBBLnRQynxH8LOEykyG4=
X-Google-Smtp-Source: AGHT+IEhe7MIMvRiGFhEOeSNHk3ygWQ/LO0p1qk0BIzsOsoSEaRhYVc6ez9Wv66KwneugsuLPI8UnHA4BS0jcr5BkPQLEvSnQqrW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1594:b0:86d:f35:a100 with SMTP id
 ca18e2360f4ac-87977f7627emr565277339f.5.1752252264829; Fri, 11 Jul 2025
 09:44:24 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:44:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68713f68.a00a0220.26a83e.0055.GAE@google.com>
Subject: [syzbot] [udf?] WARNING in udf_process_sequence
From: syzbot <syzbot+478f2c1a6f0f447a46bb@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bc9ff192a6c9 Merge tag 'net-6.16-rc6' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=163020f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd2783a0a99d4ed0
dashboard link: https://syzkaller.appspot.com/bug?extid=478f2c1a6f0f447a46bb
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1406868c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14160d82580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1e9eedcd43a/disk-bc9ff192.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/422cc2173887/vmlinux-bc9ff192.xz
kernel image: https://storage.googleapis.com/syzbot-assets/baea2fd007dc/bzImage-bc9ff192.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c5472edae325/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+478f2c1a6f0f447a46bb@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5837 at mm/page_alloc.c:4935 __alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:4935
Modules linked in:
CPU: 1 UID: 0 PID: 5837 Comm: syz-executor235 Not tainted 6.16.0-rc5-syzkaller-00121-gbc9ff192a6c9 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:4935
Code: 74 10 4c 89 e7 89 54 24 0c e8 04 14 0d 00 8b 54 24 0c 49 83 3c 24 00 0f 85 a5 fe ff ff e9 a6 fe ff ff c6 05 ae 3c 76 0d 01 90 <0f> 0b 90 e9 18 ff ff ff a9 00 00 08 00 48 8b 4c 24 10 4c 8d 44 24
RSP: 0018:ffffc9000419f460 EFLAGS: 00010246
RAX: ffffc9000419f400 RBX: 000000000000001b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000419f4c8
RBP: ffffc9000419f550 R08: ffffc9000419f4c7 R09: 0000000000000000
R10: ffffc9000419f4a0 R11: fffff52000833e99 R12: 0000000000000000
R13: 1ffff92000833e90 R14: 0000000000040dc0 R15: dffffc0000000000
FS:  0000555585efa380(0000) GS:ffff888125d4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd725aa000 CR3: 0000000072cd0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __alloc_pages_noprof+0xa/0x30 mm/page_alloc.c:4993
 __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
 ___kmalloc_large_node+0x85/0x210 mm/slub.c:4272
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:4300
 __do_kmalloc_node mm/slub.c:4316 [inline]
 __kmalloc_noprof+0x36f/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 udf_sb_alloc_partition_maps fs/udf/super.c:323 [inline]
 udf_load_logicalvol fs/udf/super.c:1464 [inline]
 udf_process_sequence+0x1d46/0x4840 fs/udf/super.c:1828
 udf_load_sequence fs/udf/super.c:1875 [inline]
 udf_check_anchor_block+0x28e/0x550 fs/udf/super.c:1910
 udf_scan_anchors fs/udf/super.c:1943 [inline]
 udf_load_vrs+0x6e3/0xf20 fs/udf/super.c:2024
 udf_fill_super+0x5ad/0x17a0 fs/udf/super.c:2192
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1681
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6162f1f8fa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd725a9028 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd725a9040 RCX: 00007f6162f1f8fa
RDX: 0000200000000c40 RSI: 0000200000000040 RDI: 00007ffd725a9040
RBP: 0000200000000040 R08: 00007ffd725a9080 R09: 0000000000000c7b
R10: 0000000000010480 R11: 0000000000000282 R12: 0000200000000c40
R13: 00007ffd725a9080 R14: 0000000000000003 R15: 0000000000010480
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

