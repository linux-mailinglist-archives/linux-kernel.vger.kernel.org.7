Return-Path: <linux-kernel+bounces-793203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBAAB3D04D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 02:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E38204C8D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29561FFE;
	Sun, 31 Aug 2025 00:33:38 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BB27462
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 00:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756600418; cv=none; b=H4RJxuvA0EH40xbvkbM9uAHTao6UqE3zNk4efQqkmmdG9j0eSOs24rnweRQPN+TUolQlv7RxtEpwOZ+mXn64TPyMz+bEA2Dvt/SwODIvIx9nX7dV3C5ZRrDUvs04SPcoO0Y0lgGeHaT2Ozapj0DrBSm4PqtnlDSB4Bv0laSHP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756600418; c=relaxed/simple;
	bh=If9vYXWVJnfDbMNsqCPNSs/nWLPsDS5Ze2gFBFZE+IM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bkZYIQtu6NyuHEl6xrqnUoHyqUFhoNs3yfUtE9niMSdIYI1ET2K4i3CSN3+AaLAI4aUxlaQMDzcH9vqN//bWa6e/Ma6sZQstaJCukkeRVhT5NJtTadDkIk3Df64+XbFStbcwTihvoNVFVjtNTDdz7UdvB9TAp1Oy2MSsEeZtEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8870e77d31bso530674739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756600415; x=1757205215;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZlNCTVPA3wH63QUCpOdU4WCC8LYdn1Urdu9GA2jomI=;
        b=EewxfyUuKRFmBvFIZ/NFBn5f8etLyo+ocUer+OfIQVQ73vAZK0wydzbrqVtmSYwWr7
         rv/D5LyDBHWCeB/qbrzgHyM9U85YnjakBOcKrZS7fmRgwlczhRJ8Ct4FKtZqcstCE/6+
         YRf9SV8C7ZcacV9FTSbnMb+CB6pChkLXeLSjpftQ2rhMWXesfIsCb+7WnyuZ3iaQycN6
         xdtUZISEWFbdlP+WdFvNyMHMIKcxb3lpeWopPVloibAU/ofw7y7gcz5gLJ1eqwppRUh8
         tn52CsFR/ex5ZpOtAre8qQ6HW17Cn6laPtn8K54RJQRrzZXD97bkiRYXf2JfMS0tHafA
         eJGg==
X-Gm-Message-State: AOJu0Yx7I+JeOHvxWv7HYST6mr2QiNnCLZzoa+qalSgKWW6C1flzt339
	n+ydkYXSBhQjukYbwXREPNj/yAF99zXGintYq3louCeg3TYWYguGAtNS7I3wzi7QT9ovbO3JOb5
	HFKqvGDkvabXcoyN5XfQ8japwE43f8xRh02bn3846EFipbRmlNIJWF/2KTFSh6A==
X-Google-Smtp-Source: AGHT+IE6277IhBW2NU0i9aQtYPh2C8AL+ed3WLZVCtNtc0HPJfUdGZIPlZjPqCtbOjwK1Vf9rthf3WDh4h24x3erQoj3iUeV86pE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:d30c:0:b0:886:c53c:916c with SMTP id
 ca18e2360f4ac-8871f4d4fa4mr631912239f.17.1756600415351; Sat, 30 Aug 2025
 17:33:35 -0700 (PDT)
Date: Sat, 30 Aug 2025 17:33:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b3985f.a00a0220.1337b0.0028.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: vmalloc-out-of-bounds Read in run_irq_workd
From: syzbot <syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fab1beda7597 Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1690def0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=2617fc732430968b45d2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115f7c62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5da7c25b1d17/disk-fab1beda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1da8f2d76781/vmlinux-fab1beda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/edda5f26e059/bzImage-fab1beda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in irq_work_run_list kernel/irq_work.c:251 [inline]
BUG: KASAN: vmalloc-out-of-bounds in run_irq_workd+0x116/0x190 kernel/irq_work.c:305
Read of size 8 at addr ffffc90005289090 by task irq_work/1/26

CPU: 1 UID: 0 PID: 26 Comm: irq_work/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 irq_work_run_list kernel/irq_work.c:251 [inline]
 run_irq_workd+0x116/0x190 kernel/irq_work.c:305
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc90005288f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90005289000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90005289080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                         ^
 ffffc90005289100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90005289180: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
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

