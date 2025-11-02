Return-Path: <linux-kernel+bounces-882008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E11F7C296FE
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 22:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0A3C4E4786
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 21:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9FB2222A9;
	Sun,  2 Nov 2025 21:10:36 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73D1F3B8A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762117835; cv=none; b=NHrimjqgB+wjtlT7ousOY767/Wam80yOXtKVbUp6k9TxJFGvyScmE8AOaQgIQhr6SlHKRFVrRxR56Jqpb2JBFrdfN7cyvt+BkO1HRVyFB2Juc26Mwyv3d5I+pYst6jRSqpG+m2sjsEB7kF2aA+mR4o7Ff5QyUXM6McOvMh0sCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762117835; c=relaxed/simple;
	bh=hHOeeEihzzDfg1Xo6u6zZ2eGJFu1etPWu2Vm+y9Jth4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gMjo9UgjFmpONO+oTHgE3fUdoO5C8qctyADp6AzuBD095eEqFdsLHtb1XA6/78BOvswvZlfruWN55KdO4uYktI+ZoMvgdxZDIh73Vs4F18G8aedVX91R2ghNQGMm+vqQVnv4Rklj8tvlgduX7jjSbK0lZ+AeqnGvaQHMvkI4ZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-4333052501cso2040025ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 13:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762117832; x=1762722632;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3r4tNEJZqNR7jvnaf7lJZd2h8YwAodUy8epKeDGKL8M=;
        b=iWAuRv/NBxbMWatXK4+vc3pzbeHFxiROxxEGA5lRbWCYN/DUkMmg0/RhU+Uo0kTLmY
         kj91LybUK8UQZOAiBVgT3bQEkRbc4oxVjDC26KqCPm0sI+90Xj2BGSOsxY7QTvvlPB1Z
         fLYulEK6rGMZMV45Zv1hwhwPYt9ci7m1kJLrWCMbhzz1ush+17YYYmJ8Fk6SLfe0RAd/
         gNkBboRMXedf1RCnuTHeNDTIyRyrzudFL1i84YgGZw1LtLx4imjOFWxXseeWwD77ZhHE
         pNETN+c8YCLnA/kGlx9DKatUiFrkFAcXZ1nRULJEQjiPsr2FzDSCCLd6aKhgK0BCwdbc
         W9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKp0iOcduULKHCfGy+nkdmg5aa5+ahJjTeeTsYW+my7eIv4n46TWFOghMRYKd8VPSxkcb8/ZOBYoQuDXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZ0oKvHSU45/0zOp5qpVXBtuASQX+KT8e2/6Amhv0wnyz9TvW
	Oox15QrdjrZlXB4Irr9Fcl9vlSxLrpMflC0VMlmp2rXRba5c+mw5Pvha+YdJNA6ZbC5LlAHUs5G
	t9JGx1PzFpd2mhNI1MCVVdPhrDaSiv1P6iiAXLbDNm2ucHRavDhOA+IjLgMs=
X-Google-Smtp-Source: AGHT+IEqch9T1rUJ4zmGL76ryOqcCV26GrGnOehnclE3lWkRPkCkLqATTcyvFnUrKGBOLj8Tji95+WoXRgANuKRr2nfZX0/Qrafy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1849:b0:433:3035:7426 with SMTP id
 e9e14a558f8ab-4333035764fmr19518625ab.16.1762117832219; Sun, 02 Nov 2025
 13:10:32 -0800 (PST)
Date: Sun, 02 Nov 2025 13:10:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6907c8c8.a70a0220.37351b.0012.GAE@google.com>
Subject: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (6)
From: syzbot <syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
	soci@c64.rulez.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    691d401c7e0e Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14607932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=5a40432dfe8f86ee657a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5eaccda03e4f/disk-691d401c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0df5294a69bc/vmlinux-691d401c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f4f242731772/bzImage-691d401c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap_2ppw drivers/video/fbdev/core/fb_imageblit.h:364 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:462 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x1a6f/0x1e60 drivers/video/fbdev/core/sysimgblt.c:24
Write of size 8 at addr ffffc90003e99280 by task kworker/0:2/781

CPU: 0 UID: 0 PID: 781 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events_power_efficient fb_flashcursor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
 fb_bitmap_2ppw drivers/video/fbdev/core/fb_imageblit.h:364 [inline]
 fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:462 [inline]
 fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
 sys_imageblit+0x1a6f/0x1e60 drivers/video/fbdev/core/sysimgblt.c:24
 drm_fbdev_shmem_defio_imageblit+0x20/0x130 drivers/gpu/drm/drm_fbdev_shmem.c:38
 soft_cursor+0x524/0xa10 drivers/video/fbdev/core/softcursor.c:74
 bit_cursor+0xe8c/0x17e0 drivers/video/fbdev/core/bitblit.c:395
 fb_flashcursor drivers/video/fbdev/core/fbcon.c:401 [inline]
 fb_flashcursor+0x310/0x400 drivers/video/fbdev/core/fbcon.c:370
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc90003e99180: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003e99200: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90003e99280: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90003e99300: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003e99380: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
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

