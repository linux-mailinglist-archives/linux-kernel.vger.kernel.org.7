Return-Path: <linux-kernel+bounces-801165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB55B440C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A47D177814
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046D3280004;
	Thu,  4 Sep 2025 15:36:36 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A76274B37
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000195; cv=none; b=toqs98Wifnc7aKYAT9dG6CA9BMGQJDSwDFKL1LVuYEmAZapOxdzyRHkZmn16saJiVxE9Mg5ZDeNuwWgc3WgEJcSXRC76bbPFrpm2AuPA/K9xEz88Oqv4mXJlBlbmEfqlnH4ZLjiaBTV/zpZSwdmuQidpkAuxsZPT5S2IM1wIZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000195; c=relaxed/simple;
	bh=z5RXEYi4GcwdMf14gmfA/4ffGyvvk8RZLq1vDgoHy10=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ixcNrHFx3bu2f2rL7tCGy6EwN0NFTFmK2GC3De83ArvZvRamtJzL/4UH9Z9F+3n4nWx0rKMkzo8XarhJmzx0lcbt2EsExjZ8uIuS5tdzf1z7UIWVPW9diTQQ4rpIKZqwSwpOSUPxBgoMZDQz0OjZ2P9G2wf0kA91EOFpCzqRHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3f29a0a7643so11315575ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757000193; x=1757604993;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nb4DJeXwzg6MWXsPg+hnPxO5qsfvhh0fERo8bLAUg/M=;
        b=T0b0FUupYbsXnBXS1bvO9nosLzsBMKeuCH7U/+yDuQsvr303Wi5eZY/o1/uRMx5eJB
         p4VlTmo2rdipgURszh4vvkw1mAW2deqPWYZYC4tV8wyknZKDeSJtYNGSdk29Al85z0Wr
         5MBV08jANeVQBuOMhngtTS4rhTr7iC9taxvuKjnLhNR4IPIkKe9ETjhXl01+zKoc4IcN
         9F40Trxe6fTEVtatIuI71amoBVL4jSlUok14WT08Hz31GyEY7eM/ta3L+ye8gEdNWA0R
         cHW3wY+9uWTUYtHsw9OqWZ2b3hnATnZqzcnLmuTqOGGcSDJHIAW0AtJBH7Vk8zIvfPZh
         W9kg==
X-Forwarded-Encrypted: i=1; AJvYcCWU8inLG9bgFli4CYPxk4Hzq1ry7FkE27riV86cJYPBKVKTl1PCuhj/rZbiXd6eqnvbEWc3ZggIj2rAmQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSvSHdzrB/T9PFTplJ8qTDY0GryKATr26JWgGIDc/Ndr6yAH/
	K9kCnOM1XE6Om99fkyOXS/b97vZlqJ+tAbT1lVkwleeHhbo1wAX3dbP3v0PXuGH4RQUUDY+Ur8c
	mU/8AL8ZGQiO5eKeDaIo7SIaPldMPMQBrcRN6RH6VKDFYpj1h+4+Cv3DedXY=
X-Google-Smtp-Source: AGHT+IGk7o/15yLBzudnYUlEedLceUiYuKPVbD8kexYmFLH5ueZC1B6jKxRtvKncReVQ7LovZQ0tvsSEt0w4L1+eAd1K/207Jnl7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3f2:69a5:7edf with SMTP id
 e9e14a558f8ab-3f3ffda336emr340619495ab.4.1757000192928; Thu, 04 Sep 2025
 08:36:32 -0700 (PDT)
Date: Thu, 04 Sep 2025 08:36:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b9b200.a00a0220.eb3d.0006.GAE@google.com>
Subject: [syzbot] [io-uring?] KASAN: null-ptr-deref Read in io_sqe_buffer_register
From: syzbot <syzbot+1ab243d3eebb2aabf4a4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4ac65880ebca Add linux-next specific files for 20250904
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1785fe62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbc16d9faf3a88a4
dashboard link: https://syzkaller.appspot.com/bug?extid=1ab243d3eebb2aabf4a4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f23e62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cb6312580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/36645a51612c/disk-4ac65880.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bba80d634bef/vmlinux-4ac65880.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e58dd70dfd0f/bzImage-4ac65880.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ab243d3eebb2aabf4a4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in PageCompound include/linux/page-flags.h:331 [inline]
BUG: KASAN: null-ptr-deref in io_buffer_account_pin io_uring/rsrc.c:668 [inline]
BUG: KASAN: null-ptr-deref in io_sqe_buffer_register+0x369/0x20a0 io_uring/rsrc.c:817
Read of size 8 at addr 0000000000000000 by task syz.0.17/6020

CPU: 0 UID: 0 PID: 6020 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 PageCompound include/linux/page-flags.h:331 [inline]
 io_buffer_account_pin io_uring/rsrc.c:668 [inline]
 io_sqe_buffer_register+0x369/0x20a0 io_uring/rsrc.c:817
 __io_sqe_buffers_update io_uring/rsrc.c:322 [inline]
 __io_register_rsrc_update+0x55e/0x11b0 io_uring/rsrc.c:360
 io_register_rsrc_update+0x196/0x1a0 io_uring/rsrc.c:391
 __io_uring_register io_uring/register.c:736 [inline]
 __do_sys_io_uring_register io_uring/register.c:926 [inline]
 __se_sys_io_uring_register+0x795/0x11b0 io_uring/register.c:903
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f99b1f8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f99b2d88038 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 00007f99b21c5fa0 RCX: 00007f99b1f8ebe9
RDX: 00002000000003c0 RSI: 0000000000000010 RDI: 0000000000000003
RBP: 00007f99b2011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000020 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f99b21c6038 R14: 00007f99b21c5fa0 R15: 00007ffeadfa5958
 </TASK>
==================================================================


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

