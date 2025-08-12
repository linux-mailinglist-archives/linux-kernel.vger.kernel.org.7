Return-Path: <linux-kernel+bounces-765620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE6EB23B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B6E1AA8828
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5A2E11C7;
	Tue, 12 Aug 2025 21:56:39 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C22DAFB1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035799; cv=none; b=Y6W2W8MHF+tbUpSYp5SNeH6hAZD7sz+7bee8215S21doY07cPSTl/TURzsiQBZC44EiAPdeLkg1rxg3ZErt4JBSdOxNM1xD5/ES+oF0RwCiiz0w88bg0VFd0by1urg8F+Yx+k0FutZIodoRimGyTqq9go8DZYRyITN7bF/uQUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035799; c=relaxed/simple;
	bh=iGdo24tofmm87aJhWmIYd3Q58B+zHHbKJhoHwBGfSpw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XbH9A/pAKZRHYmyDwq+WpzhggPZdClZv/dfBqsXhYD6/RXQLRAxj2Uo+IENaRJYTLDPDDcUuta1V+tKFhXv5VPtIohOVyZJJ4iuwBDPrhKi9hjmyF/tM/14unuIrJ/BswhptpuaGivXa+0mckskWDu6Ct0G5eZEZzD5m1eXvtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-87c1c2a4f9dso1520295839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035795; x=1755640595;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQmTebluP9FJNCSa1bCTc8yuvAKN2vsJUbc85QAend4=;
        b=pxWf7csbLjECHFTgG/zEjoHPkPe3WqJde+dWKazLDm3YkUneqqnVx6klGrhuP25DVm
         g7DTdCPOwtlWkzWKKrNoseGWvMAhb18r3brqG8W+tVFHQs029R8f86hY6zlXnfB1bsh5
         eHjzwKGWw6v/MHq/GqgKEU/f5eAPGqLHuIPdFSiHqR6YhkOJU3N2JbQW3AVU2Zcs35iG
         FS89DS9K+4o8T9rgiS+kFm8+tw2XKYDXoTtxBvS1eYvUzG7oz+YJpq6WKOlvVrhN0X2y
         YHaf32PvMCUu4mFtP+9mOYicnJm2OAvVSSHu1SqcsEoZsNEvWRgeGffEigY/iA5ESre+
         HD8g==
X-Forwarded-Encrypted: i=1; AJvYcCUgQx0jxtP9YEbDQGR6ZSSI8C05WAze6HPzSukg+4RxxXR7UC3FvP+lRP1fl3JY6sxLqyikQlglYe3ud+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6BKJdRHhQxM6qzIi9nQklPlq0mrt7HhWRcoA8GG/9ZtuUJpG
	pioGZbRPO4jCny+eUnPCCyGYAdubrRbRspeIWMFljtQ2FfnTdDZtOnRDlT7Iu3Gko/qb3U6D26a
	SpUooix4RePPI/p2WDyk/cy6KqyTQdsL/9IDp5fUtfUJACMWuVRr4+LRy/h8=
X-Google-Smtp-Source: AGHT+IFg8CeUDC9PGszt9X5eS6h5GIdvQkUvv8UskUP0E5fnXopNHUdPrXkMJqqRTKDsuI88w1w7/P1d2EEIMjlf+jrNqC2x0ohk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6417:b0:876:7555:9cb4 with SMTP id
 ca18e2360f4ac-8842960ffdemr136283639f.1.1755035795424; Tue, 12 Aug 2025
 14:56:35 -0700 (PDT)
Date: Tue, 12 Aug 2025 14:56:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689bb893.050a0220.7f033.013a.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in move_page_tables
From: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    53e760d89498 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165fe9a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9319a42cfb3bf57
dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14172842580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b04c34580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-53e760d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/584b4139c7e3/vmlinux-53e760d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d2474607300/bzImage-53e760d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com

R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f00d0db5fa0 R14: 00007f00d0db5fa0 R15: 0000000000000005
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_normal_pmd mm/mremap.c:357 [inline]
WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_pgt_entry mm/mremap.c:595 [inline]
WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_page_tables+0x3832/0x44a0 mm/mremap.c:852
Modules linked in:
CPU: 2 UID: 0 PID: 6133 Comm: syz.0.19 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:move_normal_pmd mm/mremap.c:357 [inline]
RIP: 0010:move_pgt_entry mm/mremap.c:595 [inline]
RIP: 0010:move_page_tables+0x3832/0x44a0 mm/mremap.c:852
Code: 02 00 0f 85 b6 03 00 00 48 8b 2b 4c 89 f6 48 89 ef e8 e2 1b af ff 49 39 ee 0f 82 d5 cb ff ff e9 0c cc ff ff e8 1f 21 af ff 90 <0f> 0b 90 48 8b 44 24 40 48 8d 78 40 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc900037a76d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000032930007 RCX: ffffffff820c6645
RDX: ffff88802e56a440 RSI: ffffffff820c7201 RDI: 0000000000000007
RBP: ffff888037728fc0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000032930007 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc900037a79a8 R14: 0000000000000001 R15: dffffc0000000000
FS:  000055556316a500(0000) GS:ffff8880d68bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30863fff CR3: 0000000050171000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 copy_vma_and_data+0x468/0x790 mm/mremap.c:1215
 move_vma+0x548/0x1780 mm/mremap.c:1282
 mremap_to+0x1b7/0x450 mm/mremap.c:1406
 do_mremap+0xfad/0x1f80 mm/mremap.c:1921
 __do_sys_mremap+0x119/0x170 mm/mremap.c:1977
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f00d0b8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe5ea5ee98 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 00007f00d0db5fa0 RCX: 00007f00d0b8ebe9
RDX: 0000000000400000 RSI: 0000000000c00000 RDI: 0000200000000000
RBP: 00007ffe5ea5eef0 R08: 0000200000c00000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f00d0db5fa0 R14: 00007f00d0db5fa0 R15: 0000000000000005
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

