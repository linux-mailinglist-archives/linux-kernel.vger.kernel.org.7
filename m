Return-Path: <linux-kernel+bounces-878526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3660C20E35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 599494E2447
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE1363B8D;
	Thu, 30 Oct 2025 15:20:39 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8636336D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837638; cv=none; b=PtUYQkQUH+LmIkjaDmpQsaYjlR7g1YW0ZjmP59CqrzNQF66fzwukOzxcZAEK2zc5ILKGUWyrI9g1JPqxnayUcBJ4m1Od85GMj1NKn4Qp+9msDP7wJ4Dp9FZkOymNE2pPtUOC9xgMK3HH70gOyV9ZLt/0QGnIzjHoN2BNbFUFMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837638; c=relaxed/simple;
	bh=XvVtumf+fqy2FWoM1pl0Qysoj0glLkvB2WXvkSaCcdA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZZyg2+Izpef+5JMgSThas0A/OO8hTrLj5hxzEfgQMtTfhOz6x7fzRawWIZXhjW4iZXEBOAoL1TLHSTfUWp+DpuA+82ftuvNiU5yTtTHMFxJz8CeTR6LQOafsqVAooODLWg3Czu4F8U3il3JL6cJjhBgeJ+Y/GrxfuLxcVfv14Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4330ba63227so1664075ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837636; x=1762442436;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQOoO0KSAHoPO47OmpMMZnYp4L7LjjvgRRFTquouxA8=;
        b=SIfGLMOiQIoGEwSqggWFHz7yYEu6Fr7ONl6zOIEQ2iFUPKNpj0I7/FIdGY3SaX2Otd
         LOvoDwnU1RX8KvWFH/dAH8OypBj2vLFX3UDns+Thdsuiyj50HlkSL+Qq9859sJJ/8f9u
         FImvwhOiIxgufWjIGPYHeo7heqxXI9bB0gF8JpEm59dPegPIzljj+QgcAzzZtry+ozhM
         TWRIgpX2qhWPNiTake6FrM0KVn+MqVGpX4F6X342m/zX0ChvbReeQq2o6k9d04eX6TCY
         w7HjfEocnKdJyes3wt05/nar8LwAoYjd4uVYhfWXdAjKNT3gxcO9Ry3pCQ6kErUrA4NA
         ocjw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2UUPgGvKk206gUn9JNwfTu7Ewhc6o8qMCdaD27v1rLLnYLjNnSjH+IK1BjU1PfTGnZoOIXdbjhzjdus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWw6Aq/cpE+1051UpD1yqdh3R9stFDvwCGtt4olKPtns8cM43x
	ZzShUG1qD+fRe+k9NKF27hFYuYUbT32JxHkzokR5KAyFmXkmBcxshdAtiJ/TfPqKJ6xyBukkfBO
	IJ695nLLIHsKAd11ALXRIrGg3e6NGrAO+tCl0Q7BhUutnBye78eU4yxxJt6o=
X-Google-Smtp-Source: AGHT+IEpCDOtAdHK5L4c0YSB8igRXeKbdV2j1P50w1oqVnCB2UlfHHUwk/fTOjlDx2n5WySYqZi6iIWMs/Qt8lOW184TA7flERTr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c262:0:b0:430:afae:fe24 with SMTP id
 e9e14a558f8ab-4330bdaa062mr3299235ab.8.1761837635814; Thu, 30 Oct 2025
 08:20:35 -0700 (PDT)
Date: Thu, 30 Oct 2025 08:20:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69038243.a70a0220.5b2ed.0048.GAE@google.com>
Subject: [syzbot] [usb?] BUG: corrupted list in usb_hcd_link_urb_to_ep (5)
From: syzbot <syzbot+e69c25cf38a53d0cf64c@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6fab32bb6508 MAINTAINERS: add Mark Brown as a linux-next m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d0ed42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1ce99afe6f71855
dashboard link: https://syzkaller.appspot.com/bug?extid=e69c25cf38a53d0cf64c
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6fab32bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/38b1c3a2c170/vmlinux-6fab32bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a6377b85494/bzImage-6fab32bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e69c25cf38a53d0cf64c@syzkaller.appspotmail.com

input: CM109 USB driver as /devices/platform/dummy_hcd.6/usb11/11-1/11-1:0.8/input/input39
list_add double add: new=ffff888047968c18, prev=ffff888047968c18, next=ffff88803609c078.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:35!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 34 Comm: kworker/3:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:__list_add_valid_or_report+0x143/0x190 lib/list_debug.c:35
Code: 89 f1 48 c7 c7 c0 6e f0 8b 48 89 ee e8 a6 0d ef fc 90 0f 0b 48 89 f2 48 89 e9 4c 89 e6 48 c7 c7 40 6f f0 8b e8 8e 0d ef fc 90 <0f> 0b 48 89 f7 48 89 34 24 e8 1f 46 79 fd 48 8b 34 24 e9 07 ff ff
RSP: 0018:ffffc900006ded50 EFLAGS: 00010086
RAX: 0000000000000058 RBX: ffff888047968c00 RCX: ffffffff819b7079
RDX: 0000000000000000 RSI: ffffffff819beba6 RDI: 0000000000000005
RBP: ffff88803609c078 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000002 R11: 0000000000002b91 R12: ffff888047968c18
R13: ffff88803609c080 R14: 0000000000000000 R15: ffff888047968c18
FS:  0000000000000000(0000) GS:ffff8880d6d0a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3c92d9 CR3: 00000000320a4000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add_tail include/linux/list.h:191 [inline]
 usb_hcd_link_urb_to_ep+0x220/0x3a0 drivers/usb/core/hcd.c:1158
 dummy_urb_enqueue+0x2a7/0x920 drivers/usb/gadget/udc/dummy_hcd.c:1288
 usb_hcd_submit_urb+0x25b/0x1c60 drivers/usb/core/hcd.c:1546
 usb_submit_urb+0x89f/0x1990 drivers/usb/core/urb.c:587
 cm109_input_open+0x27a/0x490 drivers/input/misc/cm109.c:566
 input_open_device+0x24c/0x3d0 drivers/input/input.c:601
 kbd_connect+0x103/0x160 drivers/tty/vt/keyboard.c:1584
 input_attach_handler.isra.0+0x176/0x250 drivers/input/input.c:994
 input_register_device+0xab9/0x1180 drivers/input/input.c:2378
 cm109_usb_probe+0x122f/0x17c0 drivers/input/misc/cm109.c:797
 usb_probe_interface+0x303/0xa40 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:581 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:659
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:801
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:831
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:959
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:462
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1031
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
 device_add+0x1148/0x1aa0 drivers/base/core.c:3689
 usb_new_device+0xd07/0x1a60 drivers/usb/core/hub.c:2694
 hub_port_connect drivers/usb/core/hub.c:5566 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2f34/0x4fe0 drivers/usb/core/hub.c:5952
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0x143/0x190 lib/list_debug.c:35
Code: 89 f1 48 c7 c7 c0 6e f0 8b 48 89 ee e8 a6 0d ef fc 90 0f 0b 48 89 f2 48 89 e9 4c 89 e6 48 c7 c7 40 6f f0 8b e8 8e 0d ef fc 90 <0f> 0b 48 89 f7 48 89 34 24 e8 1f 46 79 fd 48 8b 34 24 e9 07 ff ff
RSP: 0018:ffffc900006ded50 EFLAGS: 00010086
RAX: 0000000000000058 RBX: ffff888047968c00 RCX: ffffffff819b7079
RDX: 0000000000000000 RSI: ffffffff819beba6 RDI: 0000000000000005
RBP: ffff88803609c078 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000002 R11: 0000000000002b91 R12: ffff888047968c18
R13: ffff88803609c080 R14: 0000000000000000 R15: ffff888047968c18
FS:  0000000000000000(0000) GS:ffff8880d6d0a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3c92d9 CR3: 00000000320a4000 CR4: 0000000000352ef0


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

