Return-Path: <linux-kernel+bounces-842214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 059F7BB93FF
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 06:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F4914E1A02
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 04:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022F21A08AF;
	Sun,  5 Oct 2025 04:26:31 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258A7FBA2
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759638390; cv=none; b=mrZWAH4IQKylP6gk4wG1qFmXB0h0uAdc+ayBZAMgvQlBqsmOLOKWS1Lqqi8q0QapTL6qQf8C+6sxGqQEeGXzY52CRb5TqRhkTknewteYZGij3hF8BRYgg2OhjlznnHDwUHvkOCdvX1bPsB2ViNxzGekneHgYgptnD3aFCkD1f20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759638390; c=relaxed/simple;
	bh=bEVwJUPinqPdCfKqSomN9iBpPONckYSTSRa9V7qwvnI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JcbYRvgBUTjW3IQZ4bPEFTRhkvRPL956xpKVpz83ciRl3vgKE/xVHxnAPExk74qCng2zaPHl+gar06b2csEymMLTdXbBl2aqHovYFxtbkmUAPbtd00s6Y5VcH1kXkIXWjYBfB5p++LXqDU59Iqqq1z5NX1Vaxzfixg2SxUocHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42f6c3feed8so3404025ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 21:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759638388; x=1760243188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uL0vNEmJw+4LB7Q3FpsP4QzGIadNWrpy9p1/JLh4FK8=;
        b=nmiEAMBcCKNMvmAHpcxGgNQ374OGljw0oD1yP6EAFIh5CjQgyQWLYgOMneeXpd6o3o
         dHxju91my7BYakHs5dg9vXStW4Q/e8EyT9ljvITBvHiALifkty2FM/tj3yl6YJXa6ycS
         vjSJlgnFoZz8qbZw21WEMLVSUb3UucXlbcG5qO6pd/USOKoxb92paXbdqyPuPkaMkW+j
         fhP4O3x6GCXc99tF5nzvE0QOyaar+p4zfSAvqLCKkDMcwtzO/Vh9p0NvvwfGnGuQ/O1y
         GdZfrzvnHIjX7ECHpSsDEcMtpLHX+ILBvLnoXQxa7umnLo7e/MBw0sWLn/gkC9/yXD4R
         H3vg==
X-Forwarded-Encrypted: i=1; AJvYcCWg07k4Kz50pyoGduNtJlFtUeiPoz+600RCA3tTrLJbcXRrRceP3O7m7dtXxaXVF03HjOh7RFdwliqn7gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmvwSFcItok6/CPXAdvEr5J+5gy/hNPb6Dp+M/htNW/GtfIrp
	ojIbU143F3Oecdi9ypBBDFQoXCSiRt5PvnYIyqnwoQwd0YMJykp14hU6e2IeIsi7yHCqK7u062w
	1Awi+KwA9HDSPQceJdrlVKoO7LPrAcsW+elw+9GLEsH4dtof50EC2UkB6zUY=
X-Google-Smtp-Source: AGHT+IGPvbeckVVCtyYzmDwA7gwjCKzyLe+4IWGjam7H5qCdm/6AruTf74YkqoNNjRF2LgmF6yRHb2ozuiT4SPh8ionCqNqLFlMa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2293:b0:426:9b42:24c6 with SMTP id
 e9e14a558f8ab-42e7ad18eeemr113924715ab.10.1759638388051; Sat, 04 Oct 2025
 21:26:28 -0700 (PDT)
Date: Sat, 04 Oct 2025 21:26:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e1f374.050a0220.2c17c1.0034.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: vmalloc-out-of-bounds Read in kcov_remote_start
From: syzbot <syzbot+8a173e13208949931dc7@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d104e3d17f7b Merge tag 'cxl-for-6.18' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1146b942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccc18dddafa95b97
dashboard link: https://syzkaller.appspot.com/bug?extid=8a173e13208949931dc7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/335d7c35cbbe/disk-d104e3d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72dbd901415b/vmlinux-d104e3d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ff1353d0870/bzImage-d104e3d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a173e13208949931dc7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __list_del_entry_valid_or_report+0xb5/0x190 lib/list_debug.c:65
Read of size 8 at addr ffffc9000d912008 by task kworker/1:5/5918

CPU: 1 UID: 0 PID: 5918 Comm: kworker/1:5 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __list_del_entry_valid_or_report+0xb5/0x190 lib/list_debug.c:65
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:223 [inline]
 list_del include/linux/list.h:237 [inline]
 kcov_remote_area_get kernel/kcov.c:143 [inline]
 kcov_remote_start+0x2b0/0x6f0 kernel/kcov.c:906
 kcov_remote_start_usb include/linux/kcov.h:55 [inline]
 hub_event+0x158/0x4a20 drivers/usb/core/hub.c:5888
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc9000d911f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000d911f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc9000d912000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                      ^
 ffffc9000d912080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000d912100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


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

