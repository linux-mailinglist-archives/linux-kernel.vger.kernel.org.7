Return-Path: <linux-kernel+bounces-804481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA65B477AD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 23:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD07C3BFC2E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F60280CC1;
	Sat,  6 Sep 2025 21:40:42 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0F23185D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757194842; cv=none; b=qeJvNDwjKfBnOue1EdprGBcHDdpsfQxKGeT0xOe4AIUWiv9XXAzoZYNheqicd91oCPro6cEbI3+xCdVaQPEPZNtAX2lGCvItzqdwQp4e9vPbFZWYtFZ+Q0z6NdpyqGYHBYkajgq4QetySt7t3AcOkuVcxPbNyjJGwtx1i4utpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757194842; c=relaxed/simple;
	bh=Aw7k8BG86rW6fdSUkAtUrCZOwwCwzgG6kZtatWt7OW0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PuaoAx1EEugI4vWZNY4GTV3HU2nfNdbKLxwWj61Y1SdvQXBCINmAxVkSoEwGBDB5H9c6yhgwSUOwxPr/eQG5pMYa9a0J/vNvZM54nyWa5Nxn0cPp7DCESm964XfmSF6J3hyYWjDog+t1EKzRzRJvA00o7YT2h5Krarlaer6YgdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3f2b8187ec9so87199295ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 14:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757194837; x=1757799637;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BodvhCaUvkhDmuBVSxsPCGWmO2gi7b8nzRixLIUCYs=;
        b=PeJInkvV4BEyQ8E3FCa+Ph4ASYbQX40JG6g9pC6Rq6g6aUoVYBcfGs+sY3ACJyAX2+
         +RvooiCFhsfl4Q6zE5mAFnFJ4rITUzUASAA3jGQhuyQPWPv9j5gVkhgI1vfgU67ZAsji
         JA7aVgrpr7UzZJsR4BRtand01gHhPbLuIgaklkKSvju4A+Hh8+S6RzfVKN0ff7qo6e0Z
         xybHpktosqvA8Wjk9iAPoYGifOj1O9PTeXmVGaXUZo/cOtJUqTkrRqlOXAD9ggqEB/QO
         lBtv6PJehgj+n0YanY7mTpm0h8Rt0b5R4XT54hr85qzyzDDzC/KfcRzKl+HMIpWXRyeb
         VTEw==
X-Gm-Message-State: AOJu0YyUxxNjeUI31XBTRD6VdPvij1xcLSkhF5I1oVW3zFj6RWl6kH8j
	JCFW4uxNnOwtsXp0wvUyK7+4bDI7dkNndSw/vOVusUtpJJ609yP0PAFpf4dJvDydpYzJmtJLYCl
	g1uQRiI/vXzhvKNyLf3B2cBAlJbP4KowScotoSGaodcEyORdxsVaTEcMXsLRXiA==
X-Google-Smtp-Source: AGHT+IEv8DsFW2Gs9ZdFlJ2YzjHE8JPHFtl33Z3qstpCEj7zFoaObfGC2mOfPO8eMz9MP5f/olS2zhhdaCnzV/C/t4U1sbArgEEj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2e:b0:3f3:b6c4:7cce with SMTP id
 e9e14a558f8ab-3fd89bf009amr53681995ab.27.1757194837370; Sat, 06 Sep 2025
 14:40:37 -0700 (PDT)
Date: Sat, 06 Sep 2025 14:40:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bcaa55.a00a0220.eb3d.0027.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in __run_timer_base
From: syzbot <syzbot+bebd7f7f6db444f08153@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b320789d6883 Linux 6.17-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a84e62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=bebd7f7f6db444f08153
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dc96f2e9db93/disk-b320789d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcbc622fd55c/vmlinux-b320789d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c309f0747b00/bzImage-b320789d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bebd7f7f6db444f08153@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 16 at kernel/time/timer.c:1785 expire_timers kernel/time/timer.c:1785 [inline]
WARNING: CPU: 0 PID: 16 at kernel/time/timer.c:1785 __run_timers kernel/time/timer.c:2372 [inline]
WARNING: CPU: 0 PID: 16 at kernel/time/timer.c:1785 __run_timer_base+0x777/0x970 kernel/time/timer.c:2384
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:expire_timers kernel/time/timer.c:1785 [inline]
RIP: 0010:__run_timers kernel/time/timer.c:2372 [inline]
RIP: 0010:__run_timer_base+0x777/0x970 kernel/time/timer.c:2384
Code: 26 4d 85 e4 74 7d e8 f8 8f 12 00 e9 48 fe ff ff e8 ee 8f 12 00 48 8b 5c 24 28 43 80 7c 3d 00 00 75 d4 eb da e8 da 8f 12 00 90 <0f> 0b 90 48 8b 44 24 40 42 80 3c 38 00 48 8b 5c 24 28 74 a9 48 89
RSP: 0018:ffffc900001579c0 EFLAGS: 00010046
RAX: ffffffff81abcef6 RBX: 0000000000000000 RCX: ffff88801ae85940
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: ffffc90000157b30 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: fffffbfff1e3a947 R12: ffff88805c0068c0
R13: 1ffff9200002af50 R14: ffffc90000157a80 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881268c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000003844e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
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

