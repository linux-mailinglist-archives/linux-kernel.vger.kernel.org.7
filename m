Return-Path: <linux-kernel+bounces-879219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F370DC22920
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DF33B6465
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BBA33BBB3;
	Thu, 30 Oct 2025 22:34:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B832ABF7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863673; cv=none; b=fdTqpc3tKFxUhN3NxyHfagyis89dy5fPpxl0BffOz6mqn+zlTVsJN4avgU9wX+vHtORXCHIRdZEV/627UKPIwVyAS6bleTPuUUdGOzGn7Wz8LZI410Cc1KoBETBmsvSx4/Q7nEJ7r+MjJ/xpS5ROb6Ra9GnAQiLZMAuFVenben0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863673; c=relaxed/simple;
	bh=+yIrfAcHvZQGSn8LDTP6aWdoergAqd08V3lV3dcK6eI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NPyO2DpBinbXdu1RbnmnMTfDvOVFrvyAu2l8brWvT0mxOyPufs3u9AqiifXKnTyACSWiLaql4kqKdTt5p/idk3ryzcA6+dLhVJeQWKh6rjJm7xLOZIf9J80HPY0QO2Ny81UiKJk+zGOuqnwH2+39OeRjgq5AC/rRLkZycIGtGAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430d83d262fso53925065ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863671; x=1762468471;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khvxWLmDWKcLZe7oJicpi4kJnAITF6zg/vQbhpB8OZE=;
        b=QXVjjzIfFx4VqjVTXwO6bXDt/D0jhyWWyGvFU2my1xZFZ9ZQkAiUFnraMB/T5hzSCi
         nN6Tb+SQQmlHqbNhZfr1kfHpJpeU8MQrBHxnSE0vlOTegeqbjVs9DZjLWuUqRq/mib73
         fTEypbDIHFGBFPiiebyocT/ytSeIL2o63WvQJQ2/pZT8BF3VgJ2hHndu0AwYPB+BTHSL
         jXzWD0uaEjT4TXyqb7OVwCfq8qGI9Bd5ms5Tf5akvg+eMXPyToN9Y5yqWUP8ZIxzd8t8
         tFQBpsttt/oNkTfp49j/igp/GY5+NZD0zUFQXuE2brGJtlOU7bUixXSZS48RlR+ogUf+
         769Q==
X-Forwarded-Encrypted: i=1; AJvYcCVucgVntuEg0LAL5RM8ESBPMuIgOIn4RqFZodl7ml/jrnHdVIM8ywBox9sKfw/2ZgvlgTlIYV4pM/fBMck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBq7i4ElKszmHRs9hRsIxz6deWZYq/UiZ638kOoJqKXCY7Kms
	BWFOyST1YDnHSrnpvVoSToY3EwLe/X2hg9LIRpWOBlvrJICo5lhzrMv+9aXeCgSlVFAFAI/gYiM
	X5Z6GdwFQSephhfN8rJezorwkEwTl7GSYtU9afgJV7MXbqd+2QxlXa786mT8=
X-Google-Smtp-Source: AGHT+IFtmqur8E8iOXH77isYpzZloSaHX6NBgwM4MVMm7lZIvJ3h5hrbet+7k0YLZAbtqH3hVii6quGaqb+MY4T5+tMcqgmPsTpr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:330a:b0:430:aec5:9be4 with SMTP id
 e9e14a558f8ab-4330d1199efmr24254395ab.7.1761863671296; Thu, 30 Oct 2025
 15:34:31 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:34:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6903e7f7.050a0220.3344a1.044d.GAE@google.com>
Subject: [syzbot] [io-uring?] KASAN: global-out-of-bounds Read in io_uring_show_fdinfo
From: syzbot <syzbot+b883b008a0b1067d5833@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, kbusch@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9ba12abc528 Add linux-next specific files for 20251029
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16493fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e95de7031f410d
dashboard link: https://syzkaller.appspot.com/bug?extid=b883b008a0b1067d5833
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15729258580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10988e14580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b5f5194573e/disk-f9ba12ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83dabfc9c13b/vmlinux-f9ba12ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e62a1d361f0/bzImage-f9ba12ab.xz

The issue was bisected to:

commit 101e596e7404d07a85b38358a392009503aad797
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Oct 28 01:09:28 2025 +0000

    io_uring/fdinfo: cap SQ iteration at max SQ entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102f8342580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=122f8342580000
console output: https://syzkaller.appspot.com/x/log.txt?x=142f8342580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b883b008a0b1067d5833@syzkaller.appspotmail.com
Fixes: 101e596e7404 ("io_uring/fdinfo: cap SQ iteration at max SQ entries")

==================================================================
BUG: KASAN: global-out-of-bounds in __io_uring_show_fdinfo io_uring/fdinfo.c:111 [inline]
BUG: KASAN: global-out-of-bounds in io_uring_show_fdinfo+0x86d/0x1830 io_uring/fdinfo.c:257
Read of size 2 at addr ffffffff8bbe27f0 by task syz.0.17/6025

CPU: 0 UID: 0 PID: 6025 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __io_uring_show_fdinfo io_uring/fdinfo.c:111 [inline]
 io_uring_show_fdinfo+0x86d/0x1830 io_uring/fdinfo.c:257
 seq_show+0x5bc/0x730 fs/proc/fd.c:68
 traverse+0x1ee/0x580 fs/seq_file.c:111
 seq_read_iter+0xd08/0xe20 fs/seq_file.c:195
 seq_read+0x369/0x480 fs/seq_file.c:162
 do_loop_readv_writev fs/read_write.c:847 [inline]
 vfs_readv+0x5aa/0x850 fs/read_write.c:1020
 do_preadv fs/read_write.c:1132 [inline]
 __do_sys_preadv fs/read_write.c:1179 [inline]
 __se_sys_preadv fs/read_write.c:1174 [inline]
 __x64_sys_preadv+0x197/0x2a0 fs/read_write.c:1174
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f67fb78efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe53f8b308 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007f67fb9e5fa0 RCX: 00007f67fb78efc9
RDX: 0000000000000001 RSI: 00002000000005c0 RDI: 0000000000000004
RBP: 00007f67fb811f91 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f67fb9e5fa0 R14: 00007f67fb9e5fa0 R15: 0000000000000005
 </TASK>

The buggy address belongs to the variable:
 .str.15+0x10/0x20

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xbbe2
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea00002ef888 ffffea00002ef888 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8bbe2680: 00 03 f9 f9 00 04 f9 f9 00 01 f9 f9 00 04 f9 f9
 ffffffff8bbe2700: 00 00 f9 f9 00 f9 f9 f9 00 f9 f9 f9 00 f9 f9 f9
>ffffffff8bbe2780: 00 07 f9 f9 07 f9 f9 f9 00 05 f9 f9 00 05 f9 f9
                                                             ^
 ffffffff8bbe2800: 00 f9 f9 f9 00 02 f9 f9 07 f9 f9 f9 06 f9 f9 f9
 ffffffff8bbe2880: 00 05 f9 f9 06 f9 f9 f9 05 f9 f9 f9 06 f9 f9 f9
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

