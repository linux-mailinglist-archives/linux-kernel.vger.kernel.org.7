Return-Path: <linux-kernel+bounces-839465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA76BB1ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623572A353C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4F2E2DD8;
	Wed,  1 Oct 2025 20:18:37 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0332D0C99
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759349916; cv=none; b=fQAkHWw9Ut7PWw2DBwJAwhJ9xvDMFW46ywDzEOYgkkjNh+Gnmi4C0ah79cVwPusixVb+I2d3r7ZBvb0hUSYS7bxK3M6p9BV3SLIiPfsGKyE5Tmy6vOCP3gsoEOjfVJC1kHS8fME/LEJDhFR30tTEZTI7/OS9EhzProupNoU5yVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759349916; c=relaxed/simple;
	bh=Te/gBjGJTYLmc+piIQn24dZ33glw3MAMAthwy16QuOA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zavlks9PyXxz4pM67OI3rzqdpe3YhYciI9ILYIwq0iUVuaW7T36I8ClJ4d1VDH99ounDozXlbafKmU62wVLIbDvmJhlsrJtNJwIbJq57AwYidTV87p4MAzfWDU4/kM+IQPjhwwI6T8rqtYOw3HkpbkwJWnOs0NHS7pQVI+FfsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42765c940c0so2984075ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 13:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759349914; x=1759954714;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/M/zWJq4xTpiUH/1ni82wk1CLv3H5TpZipkNC6+JSA=;
        b=TgXqC8L4eSPDYCERh05iquAJFdeLH1TXwz/QNbDu9WL+mq2Uz2xiOGV/LVPV5W+Fz+
         Iemm/V+C+++4CZq8EFGoglZMfWWjOTgc8gqP1a2P0JmDdicEhztJn0RVdTEGjUlTBpQt
         2rn7+qcxwvqgtrkgYHuztT8sPMpM02OWE2XjBx8xhfDviRoXLWWPHmgeGYDG1oYERUnW
         EEDhyABbq7VrWTmROKvXgDNHHMEcCnln2IZTvAwas3AKaanj6Eo4W9CAIVfEDgkNbWY4
         Mc9e6nmVdTSsbCcphqpygHnk63REZHRc26HvECC5qX5g8sVitSDY6qW4ckrQ+FZZVacH
         HwHQ==
X-Gm-Message-State: AOJu0YzRE7cvN/6owub3wCOEUPwaULHBmqNKhRG1BOnJDLGqLVruN0AC
	jn6RgaeI2l4gMk+0NGp9FyTrQrjhmR8dVHy6KqcN1hUvdQRY5H/pb03s3RgFKCNf+BQ0epfas93
	MadKwvTaZLy4HYKbNyDVW+4jD5bkd1305NpEgFvxhNEMiqhv7VrlLu+qqKfwrbA==
X-Google-Smtp-Source: AGHT+IFAUSatV4o1ZkBu5epGTfSI11SK0btTU6HGFEA/lrHQrE2nQTkNs5iB9N2putaxIoL9Q89lwvJ6TKg72AgkCaLWREHAdu0+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:42d:8bf0:29f7 with SMTP id
 e9e14a558f8ab-42d8bf02c5fmr4333255ab.9.1759349913915; Wed, 01 Oct 2025
 13:18:33 -0700 (PDT)
Date: Wed, 01 Oct 2025 13:18:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dd8c99.a00a0220.102ee.0062.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in free_uts_ns
From: syzbot <syzbot+c897acc98cdcbd154885@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157b5d04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22ef41a8c536eeb
dashboard link: https://syzkaller.appspot.com/bug?extid=c897acc98cdcbd154885
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/685748d5e5b4/disk-50c19e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d68642bc16e/vmlinux-50c19e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/236e2110bcde/bzImage-50c19e20.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c897acc98cdcbd154885@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=1110 which is not allocated.
WARNING: CPU: 0 PID: 14455 at lib/idr.c:592 ida_free+0x1f9/0x2e0 lib/idr.c:592
Modules linked in:
CPU: 0 UID: 0 PID: 14455 Comm: syz.5.1832 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ida_free+0x1f9/0x2e0 lib/idr.c:592
Code: 75 f6 41 83 fe 3e 76 72 e8 44 5b 75 f6 48 8b 7c 24 28 4c 89 ee e8 47 39 0d 00 90 48 c7 c7 e0 cb cf 8c 89 ee e8 38 e6 33 f6 90 <0f> 0b 90 90 e8 1e 5b 75 f6 48 b8 00 00 00 00 00 fc ff df 48 01 c3
RSP: 0018:ffffc9000497fa78 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 1ffff9200092ff50 RCX: ffffffff8179a5b8
RDX: ffff88806e472480 RSI: ffffffff8179a5c5 RDI: 0000000000000001
RBP: 0000000000000456 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: fffffffffffe1a68 R12: ffff888027a2a000
R13: 0000000000000293 R14: 0000000000000056 R15: ffff888027a2a008
FS:  0000000000000000(0000) GS:ffff888124e71000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f125e818d58 CR3: 0000000027bfa000 CR4: 00000000003526f0
DR0: 0000000000000002 DR1: 000000000000af51 DR2: 0000000000000800
DR3: 000000007fffffff DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 free_uts_ns+0xe7/0x150 kernel/utsname.c:101
 put_uts_ns include/linux/uts_namespace.h:38 [inline]
 free_nsproxy+0x32e/0x400 kernel/nsproxy.c:189
 put_nsproxy include/linux/nsproxy.h:107 [inline]
 switch_task_namespaces+0xeb/0x100 kernel/nsproxy.c:241
 do_exit+0x86a/0x2bf0 kernel/exit.c:960
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 get_signal+0x2671/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7c0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x7a/0x100 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x419/0x4e0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f125d98eec9
Code: Unable to access opcode bytes at 0x7f125d98ee9f.
RSP: 002b:00007f125e839038 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: fffffffffffffe00 RBX: 00007f125dbe5fa0 RCX: 00007f125d98eec9
RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000006
RBP: 00007f125da11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f125dbe6038 R14: 00007f125dbe5fa0 R15: 00007ffd01722128
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

