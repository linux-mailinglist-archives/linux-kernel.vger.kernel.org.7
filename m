Return-Path: <linux-kernel+bounces-806638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E37B499BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF1497A45AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FCD248F7F;
	Mon,  8 Sep 2025 19:19:31 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F7247284
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359170; cv=none; b=PAxko/IyMRjYxDHZXI5YE2oXZyLKgV8LEOHK7VC4S5zXTrEbYG4YaZLuWpZOy41acOKnOZbH9SUB2PREDTq7YvNDb2P1+lvbGLrxtGI0FVwiQw/x+hqBbIZq3FyatPd+sW0kL8x8HyPZIs6MiID83n5iccy5XUgNFrE9z9bFuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359170; c=relaxed/simple;
	bh=qAFcrVBOup5OQXNEdOgYwcxxaA5N6iyAxjDJOx0IFRo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JeBwJd4myCLTfYbqAFu+Abrdtp+TIEH/ENchwhuw1JUruJSvHJ5n6DqvhTKmdg+Fx3Nytpgov9IgP6yIOSnYYLqRe82ian7lb1VPzc9d7QYfQvhpMxiVwsZa3/mHtHFy45pjQGA8KshlJZ0iMuG8ocHav8EGGIly0L71yevECuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-40babea9468so14044035ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359168; x=1757963968;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GS51yBm+KZpy05gOITF+TyPHlJCUTXtwtV3UCcoHVHI=;
        b=poXLl4NA2VaUf7z+BArwkxLfnUKlj9Oi3W8MM+FT9vy7FGJ6L/kPDRwH0K9Mh1Y+8E
         ZuWbjSYZv9hBrQ4QDgTdNo/ty71Bcf0EbC2472ml2Wcc4wsc+9XO7z/GqSylvOp78InB
         /MK+SpRedYOlvUbVfalpjBblmSTmpy3LXxD7lkV6ddVJ6ROxHf5WeYYw7+e5Hj0LheZy
         7TFpC6HX06cJ7JWSqxHP5asZcrLtQBtuwaDpi65XL1E9g8YckgpMIOkTr3TDaYK2nuE5
         eDbsAtAnhsQX7NHqoefEbEda1yVS3vG9/JV49MLWl7/9Ih1sS6YKHvAEwFe0rJSGGopO
         GlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqsG/VZPqcojmGBR3WgcobgiTDe0sbWsjqiedc2fwrKdfnCCvRcT+Gh+n78M7gf9glxz1tdkTreZNkb0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiIRvBrfBL1jvVB2VcIB+/rGUBakgiAgcMHVJddMbQ6vdQsJx
	9PBO1mUsldk0hPXDr+F7iS8zCLor6/loK+vJamNZk9BKocyQSn5uL1azts2+FkCh9c1AXJbpADf
	kkmdMRWOIfYlppdN9ZQ6zqbDjsYKB3YKDPDcolnQSiKFNPPDCcvbL9j0ZOhM=
X-Google-Smtp-Source: AGHT+IEES7IE7iRjJaxYjfY8EtJaJrjfyO12oDu3Dxea0hsbmIRzW3W9wfliz6N4OT7EukOeIr7wEqRT3bnbv1mqF8q806YnN/Vc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:40e:fe2a:b321 with SMTP id
 e9e14a558f8ab-40efe2ab529mr12939775ab.15.1757359168014; Mon, 08 Sep 2025
 12:19:28 -0700 (PDT)
Date: Mon, 08 Sep 2025 12:19:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf2c3f.050a0220.192772.0884.GAE@google.com>
Subject: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
	soci@c64.rulez.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    76eeb9b8de98 Linux 6.17-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14379562580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0bea6c0b97a2002
dashboard link: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b2c9b90de8ba/disk-76eeb9b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd1bcf1fd25e/vmlinux-76eeb9b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc7e94f5dffb/bzImage-76eeb9b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap_2ppw drivers/video/fbdev/core/fb_imageblit.h:364 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:462 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x1a6f/0x1e60 drivers/video/fbdev/core/sysimgblt.c:24
Write of size 8 at addr ffffc90003649000 by task syz.1.259/7231

CPU: 0 UID: 0 PID: 7231 Comm: syz.1.259 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
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
 update_region+0xc1/0x160 drivers/tty/vt/vt.c:641
 vcs_write+0x7c7/0xdb0 drivers/tty/vt/vc_screen.c:698
 vfs_write+0x29d/0x11d0 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7effcbf8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007effccda6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007effcc1c6270 RCX: 00007effcbf8ebe9
RDX: 000000000000ffd8 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007effcc011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007effcc1c6308 R14: 00007effcc1c6270 R15: 00007ffd4fcb0c08
 </TASK>

The buggy address belongs to a 0-page vmalloc region starting at 0xffffc90003349000 allocated at drm_gem_shmem_vmap_locked+0x561/0x7e0 drivers/gpu/drm/drm_gem_shmem_helper.c:371
Memory state around the buggy address:
 ffffc90003648f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003648f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90003649000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90003649080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003649100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
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

