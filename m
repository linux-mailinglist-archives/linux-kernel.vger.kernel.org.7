Return-Path: <linux-kernel+bounces-817373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97969B58168
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5043ACA30
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ED3238142;
	Mon, 15 Sep 2025 15:59:33 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE722A1D4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951973; cv=none; b=E7FxPRP0fPFC/aQ0exxi4s01pd5tZ4QSYnT86Xa2Y9qf7pMEhldojdlbS8uHT0SIIr3CXkfek87hAqvImQYObAx7AkzxxBLtNMJ0Xf4oVJeXQqkqyhzH6nDHDm1EbABDi2zK/hv3ca4eQLUOYafHz2i6KXFlHp4+Qc7PXLEItEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951973; c=relaxed/simple;
	bh=kNVFWUkmNC1lBlh4H8LMAsxRtlfWdqS6hF8okKMOvRQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ut6SzqHZbkX5sVIoeFVRPFxncaMZA3+udh7+yYiKPK74CPYv9Vd3Tx22TQY8/1HhdviDsBRz1+qruGjdYscL1xVmLfePxdq8anLxYT/rltcYCBFbWRr6Jpihv8KJa9tTAIgVLUTJ53jVskXJL5cH7W8wgO/Beyk3lGznNgd7pWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-423feb240a7so41745895ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757951971; x=1758556771;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEEppNHulk6/a4mav9kdAfWGQ62YPb0YxchlxpDlJvY=;
        b=dabJXAZCqFE9T3j+Ic/wNhPxU70MzkO3OgpAanCXr2vmuZWoTaZvfJfMAXgTDXP+tw
         SVSwAmKU1dr5jAC91i+Gls556EC1kxiHCX7ZBEbgIqwpyz25Y/hFPudbcqFebhT7TSeo
         tWf+GLpYaDRgwpThoaoNB8eSBA9ZbAW2fLpbk0/YSage99MthxgvUrCdHvXtFeDvMWO3
         n6w3Cy+he8JQTXMFvbeT2uYa5XAaEi1FPQ9f4s5y14G72Fa15hZtRTtNptCEFL8f/72/
         sD8km0koz6SOZXJUqj8fxv52iG3o6CgcdqFVfuFq4Rtgg5qn12wm3hRcq9BQ9JrMtCdJ
         fBuA==
X-Forwarded-Encrypted: i=1; AJvYcCVLMsR/nEh4b6lR1e/vnODQUh6e1+v3IyDyhSHIimfRbXNoeIiA9thRQ7BdRk9lZhpio+hJqjU+BBLG89Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9T/qR8TUbA55sCaJNuehwU3CX8EiYtoXqUzJd3xEPlmMEVzZc
	oUNGgVqXtuAJ7vIkchZbAq4fJXdJAP9svMtt5Jha69BCbKxE60tLcDOsFYC8kjv3watA56q1PVC
	zsCyEKdtrDBs8Bf3wMf4L/HrxHkEXqXXgDdODXlM826hJA4sylOoKxCH2qWU=
X-Google-Smtp-Source: AGHT+IHfCiWzh1x3f5wDLNXu2i83Btmx14JdBi4AdfR7fkuznpeJOZ3EkL8T9mqZwcuFuM/FjqXf4sDMXqPZnsQ3X2HEx3Z+EAqY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:424:866:ec6d with SMTP id
 e9e14a558f8ab-4240866edffmr24886355ab.12.1757951970963; Mon, 15 Sep 2025
 08:59:30 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:59:30 -0700
In-Reply-To: <68bf2c3f.050a0220.192772.0884.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c837e2.050a0220.2ff435.039c.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
	soci@c64.rulez.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e5f934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14097b62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a9bb12580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f83ec76b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdedf70f8797/vmlinux-f83ec76b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bf9318d9242/bzImage-f83ec76b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap_2ppw drivers/video/fbdev/core/fb_imageblit.h:364 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:462 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x1a6f/0x1e60 drivers/video/fbdev/core/sysimgblt.c:24
Write of size 8 at addr ffffc900051b1000 by task syz.0.17/6126

CPU: 2 UID: 0 PID: 6126 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
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
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:138 [inline]
 bit_putcs+0x90f/0xde0 drivers/video/fbdev/core/bitblit.c:187
 fbcon_putcs+0x384/0x4a0 drivers/video/fbdev/core/fbcon.c:1327
 do_update_region+0x2e6/0x3f0 drivers/tty/vt/vt.c:627
 invert_screen+0x1e4/0x590 drivers/tty/vt/vt.c:748
 highlight drivers/tty/vt/selection.c:57 [inline]
 clear_selection drivers/tty/vt/selection.c:87 [inline]
 clear_selection+0x59/0x70 drivers/tty/vt/selection.c:83
 vc_do_resize+0xd9b/0x10e0 drivers/tty/vt/vt.c:1195
 vc_resize include/linux/vt_kern.h:49 [inline]
 fbcon_set_disp+0x7ad/0xe50 drivers/video/fbdev/core/fbcon.c:1430
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:828 [inline]
 set_con2fb_map+0x703/0x1080 drivers/video/fbdev/core/fbcon.c:902
 fbcon_set_con2fb_map_ioctl+0x16c/0x220 drivers/video/fbdev/core/fbcon.c:3132
 do_fb_ioctl+0x328/0x7e0 drivers/video/fbdev/core/fb_chrdev.c:138
 fb_ioctl+0xe5/0x150 drivers/video/fbdev/core/fb_chrdev.c:169
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8e73d8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc51d189d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8e73fd5fa0 RCX: 00007f8e73d8eba9
RDX: 0000200000000180 RSI: 0000000000004610 RDI: 0000000000000004
RBP: 00007f8e73e11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8e73fd5fa0 R14: 00007f8e73fd5fa0 R15: 0000000000000003
 </TASK>

The buggy address belongs to a 0-page vmalloc region starting at 0xffffc90004eb1000 allocated at drm_gem_shmem_vmap_locked+0x561/0x7e0 drivers/gpu/drm/drm_gem_shmem_helper.c:371
Memory state around the buggy address:
 ffffc900051b0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900051b0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900051b1000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc900051b1080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900051b1100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

