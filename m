Return-Path: <linux-kernel+bounces-734453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EDCB08203
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3883B7A3909
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145D17A306;
	Thu, 17 Jul 2025 01:05:40 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CB13DDAE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714340; cv=none; b=dmueNyQqdS3FUYn0V5PqkceqIzlfgN3Az6c71LP4Sl3vvFjEbhJ4IPiuOJm826mz3MrsHmLSDFypUMPHUCpR/kY7BOvsyGr53O9GePCCDm4TpJYUNwoENqQXtFwBvuYHjPZCqyjbvzLN2d1yiOx9wybOjVDoXyABjU/hi5C3cFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714340; c=relaxed/simple;
	bh=GUVsHEINq1jH1PHNd9+CTjBu+c2RAf3g+6SKsDaZ0Ro=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D/oG2v/rvMt/gZ/YZPoSjyeQVhvK55sDEdO1dIQ2Q0loOorMT5yDjMrt6j1rw8P2sSUgku4pe0zYzSOfabzoV6x0hjFfzXRfrSWq20BvmTmsBtFDWCh2MgCPFHKF+9rxw6JxrDkdqn5YnyhuRme7uiehA84Of+6ngck+5nSPPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8760733a107so48928639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714335; x=1753319135;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SnYkm2bDnhoVfcjQt2X1pUH9pnFC70gj3YVc5j3Kdc4=;
        b=XcFQvWHyLoH7vYB78z6WVI8+YnRxaNN9keTmcgmgO1l+bOKRYT4t9jL+ndwZSQRF+g
         HUUq3XSP11qQXt+mh67UcR9Y+fd7wMZRtzwjNXe0g/VST+PNm34MdUY5iAYfXSttVV7k
         vhsnCufW9aH9a1kOwjCcQte29l5CEAHwHR0UUS+w9rzcsshFwZWodvu5YF3bbjzLAoC1
         VH2ZG7Fkz8VKCWIPCqc9JeeDFDD4yhy48zfJOU6lvUn4zi0N+1JpMH0Zm72aXtNlER+i
         IPTqdzDpXtIVSCcnLLVaOjQ65nElWGBCYC/tXDcUwce9L24KVb0Jokzq/HsM577PoMdo
         R9nA==
X-Forwarded-Encrypted: i=1; AJvYcCWKuOTZGkxwtUbquG42yrntio1XOrG0xNGrOYbnYWP8++Zc3Quo68Cit++3gPd/RYzxDOrCoKpETQCkXjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYixAB+7QGumjxN+aGqykN9AtrgpG08Q7oEiGxRO/jygF/n7cx
	lmucvFytq8Kzkgx3/CzGLnLlr+fjRFiVTX/eRTg9FB5c8H8AgUenL7Fzy7jhZayPWVTOJMQWULE
	SvH1h70PWgVGyoQTo0KOB3Rr3RtGeb/8DKTG9m8dATvEXsy2dxa/e4j1vmRo=
X-Google-Smtp-Source: AGHT+IHPqT27seKaBOMt7gVaM4TeXQDohaiijVxK6TEtckramKs6FHLwQWK+30JD1onjGI+iCweJwBynatV+Dh8/vBqPk8EPaZx2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1547:b0:876:19b9:1aaa with SMTP id
 ca18e2360f4ac-879c0927bd0mr775315639f.9.1752714335510; Wed, 16 Jul 2025
 18:05:35 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:05:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68784c5f.a70a0220.693ce.0036.GAE@google.com>
Subject: [syzbot] [bcachefs?] WARNING in closure_put_after_sub
From: syzbot <syzbot+0ea2c41a649240197795@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116e1d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=0ea2c41a649240197795
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3f31a806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7304d62ced97/vmlinux-3f31a806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4913df6ab730/bzImage-3f31a806.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ea2c41a649240197795@syzkaller.appspotmail.com

------------[ cut here ]------------
closure has guard bits set: a8000000 (25)
WARNING: CPU: 0 PID: 5328 at lib/closure.c:22 closure_put_after_sub_checks lib/closure.c:20 [inline]
WARNING: CPU: 0 PID: 5328 at lib/closure.c:22 closure_put_after_sub+0x173/0x320 lib/closure.c:32
Modules linked in:
CPU: 0 UID: 0 PID: 5328 Comm: kworker/u5:2 Not tainted 6.16.0-rc5-syzkaller-00266-g3f31a806a62e #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: bcachefs_journal journal_write_done
RIP: 0010:closure_put_after_sub_checks lib/closure.c:20 [inline]
RIP: 0010:closure_put_after_sub+0x173/0x320 lib/closure.c:32
Code: c1 6e 50 ff cd 4c 89 f3 e9 c8 fe ff ff e8 85 f7 c9 fc 90 44 89 f0 48 0f bd d0 48 c7 c7 40 f5 e4 8b 44 89 fe e8 3e da 8d fc 90 <0f> 0b 90 90 e9 d0 fe ff ff e8 5f f7 c9 fc 90 89 ee 81 e6 00 00 00
RSP: 0018:ffffc9000d5ef820 EFLAGS: 00010246
RAX: 641034d4b1ecad00 RBX: ffffffff936402f0 RCX: ffff88801c734880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 00000000efffffff R08: ffff88801fc24293 R09: 1ffff11003f84852
R10: dffffc0000000000 R11: ffffed1003f84853 R12: dffffc0000000000
R13: ffff88805324a9f0 R14: 0000000003ffffff R15: 00000000a8000000
FS:  0000000000000000(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563f86c91bc0 CR3: 0000000033352000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 closure_sub lib/closure.c:61 [inline]
 __closure_wake_up+0x81/0xb0 lib/closure.c:91
 closure_wake_up include/linux/closure.h:349 [inline]
 journal_write_done+0x994/0x1270 fs/bcachefs/journal_io.c:1768
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

