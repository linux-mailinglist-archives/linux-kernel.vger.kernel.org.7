Return-Path: <linux-kernel+bounces-869839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A31C08D63
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34E01C84577
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9792E2E4241;
	Sat, 25 Oct 2025 07:30:39 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1A1DD525
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761377439; cv=none; b=SxvVL+y+fPuPVQECVQdcUNBs5/6s+nmxMBWkFXgxQsMRJr6hQkmlYCmIYzw/yMtdHhoqioCRq+hDxmeaTYbaxIRW+6SJ9vO2pX6p9zbP8T8sEU4Og59VudPNN7U/6k8Ehtj5iMajLohTG7sM/9qLaIWkJnS9I8df2hp4dn9xPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761377439; c=relaxed/simple;
	bh=V5DbhJ3p5YS8+9eLZS01P5LRa/zmeVk1OVEyxPRZzl4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E5m8mU288h0rsD8/DTIK79UfT63TgeCnq6DiD1KtXPv4SKzrlazUxSNSB1fJyrqrvSnwzdSFmeujc0ELTXiUDZbL/CJhV1jOmIicGYKUFcUtnVBWpuqKfXqrXlQQuklvY+qHnlDYatm0rLsMEIxz4PgJ2osDIA+T26o1BgfNN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-940e4cf730aso805564539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761377436; x=1761982236;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POFvTDzbXwXj/l9eq54nh96eLr+2+uDRoglNtiSjB/E=;
        b=QSISnQ8p7Qryk15V558c/Paztdqk4J3wWB/3lJ1fJ/taQwl/49vcLhXo930M1axEfV
         IBqLFYJ6fhOgQjliI4Py030d5on/1Z89c2sjb3dzVhQW2dSxFpHROACCdWRy78w69e3t
         Kfj9IJVRkvxbdunOxdXzfZUUAXX7z1FcDhO7SIjsU3OBoEQTf8GShcaEYj2nao/GBVma
         A3YKR+5/R8/vuuJ9oSNpfDYb3qS3oYCOsyxvywaZhOpHRdmEG10KZyV6xBoxjT3OS9Bf
         wuq0KQr0Vc6Ajq/1tam7t4ySzrQ49z07NSJUH/9B4+sNCc9aWTk34J/CTF7vm8tWH40G
         bQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVTezNF/PoaCePJ3oLzi5GTaRGDjfGT8tM769uRI2wIZN1Tq+Qi8yyjOt2MvZZ/x4mVeDVrVEDok6Pj00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5UXwaq6A2BMp6ioQuTXWVtS0nZppt/AtUGYZvtgNMHYxUR8n
	sjoMnDgyVTM7I6J0Z3RIMkmEL84UZQPi3C33SFMXlzrkxTGl+K5R5YmfZ+MDsl5p5BYDe7+Q2Dg
	/2CkyEMpZFhlGsMCK+W3/1kT3RsUqhx+e369wkyjAWecK2h4UlE7bVsWKomQ=
X-Google-Smtp-Source: AGHT+IHCqHFoXgOB0tUs0J97Ri8/hsEWPqr36q4oCGb93VuLnd5QtoYo9JEFh4WoS5fiTpXJ4s93WoC5OxmJaEeZd4+Xdz0yGsbA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fca:b0:42f:946f:8eb4 with SMTP id
 e9e14a558f8ab-430c527bca5mr386037055ab.21.1761377436540; Sat, 25 Oct 2025
 00:30:36 -0700 (PDT)
Date: Sat, 25 Oct 2025 00:30:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc7c9c.050a0220.346f24.023c.GAE@google.com>
Subject: [syzbot] [usb?] general protection fault in usb_gadget_udc_reset (4)
From: syzbot <syzbot+19bed92c97bee999e5db@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    566771afc7a8 Merge tag 'v6.18-rc2-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13956e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8345ce4ce316ca28
dashboard link: https://syzkaller.appspot.com/bug?extid=19bed92c97bee999e5db
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52417ef1f782/disk-566771af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/66730a263bf1/vmlinux-566771af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1fe0762efb1f/bzImage-566771af.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+19bed92c97bee999e5db@syzkaller.appspotmail.com

usb 1-1: new full-speed USB device number 6 using dummy_hcd
usb 1-1: unable to read config index 0 descriptor/all
usb 1-1: can't read configurations, error -110
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 1 UID: 0 PID: 5869 Comm: kworker/1:4 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_gadget_udc_reset+0x27/0x60 drivers/usb/gadget/udc/core.c:1195
Code: 90 90 90 f3 0f 1e fa 41 56 53 49 89 f6 48 89 fb e8 3e 6b fb fa 49 83 c6 40 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 bb 22 5d fb 4d 8b 1e 48 89 df 2e 2e
RSP: 0018:ffffc900051b7260 EFLAGS: 00010202
RAX: 0000000000000008 RBX: ffff888143b54c40 RCX: dffffc0000000000
RDX: ffffc9001a01b000 RSI: 0000000000002b35 RDI: 0000000000002b36
RBP: ffff8880305aa66c R08: ffffffff8ed62877 R09: 1ffffffff1dac50e
R10: dffffc0000000000 R11: fffffbfff1dac50f R12: ffff888143b54c40
R13: 1ffff11004eceaa1 R14: 0000000000000040 R15: 1ffff1102876a987
FS:  0000000000000000(0000) GS:ffff888126efc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce4efb4f98 CR3: 000000004a02e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 set_link_state+0x80b/0x1220 drivers/usb/gadget/udc/dummy_hcd.c:469
 dummy_hub_control+0xcc0/0x1760 drivers/usb/gadget/udc/dummy_hcd.c:2327
 rh_call_control drivers/usb/core/hcd.c:656 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:821 [inline]
 usb_hcd_submit_urb+0xde9/0x1a80 drivers/usb/core/hcd.c:1542
 usb_start_wait_urb+0x114/0x4c0 drivers/usb/core/message.c:59
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x232/0x3e0 drivers/usb/core/message.c:154
 set_port_feature drivers/usb/core/hub.c:470 [inline]
 hub_port_reset+0x390/0x1740 drivers/usb/core/hub.c:3082
 hub_port_init+0x2b0/0x2800 drivers/usb/core/hub.c:4938
 hub_port_connect drivers/usb/core/hub.c:5495 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2532/0x4a20 drivers/usb/core/hub.c:5952
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:usb_gadget_udc_reset+0x27/0x60 drivers/usb/gadget/udc/core.c:1195
Code: 90 90 90 f3 0f 1e fa 41 56 53 49 89 f6 48 89 fb e8 3e 6b fb fa 49 83 c6 40 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 bb 22 5d fb 4d 8b 1e 48 89 df 2e 2e
RSP: 0018:ffffc900051b7260 EFLAGS: 00010202
RAX: 0000000000000008 RBX: ffff888143b54c40 RCX: dffffc0000000000
RDX: ffffc9001a01b000 RSI: 0000000000002b35 RDI: 0000000000002b36
RBP: ffff8880305aa66c R08: ffffffff8ed62877 R09: 1ffffffff1dac50e
R10: dffffc0000000000 R11: fffffbfff1dac50f R12: ffff888143b54c40
R13: 1ffff11004eceaa1 R14: 0000000000000040 R15: 1ffff1102876a987
FS:  0000000000000000(0000) GS:ffff888126efc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce4efb4f98 CR3: 000000004a02e000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	f3 0f 1e fa          	endbr64
   7:	41 56                	push   %r14
   9:	53                   	push   %rbx
   a:	49 89 f6             	mov    %rsi,%r14
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	e8 3e 6b fb fa       	call   0xfafb6b53
  15:	49 83 c6 40          	add    $0x40,%r14
  19:	4c 89 f0             	mov    %r14,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 bb 22 5d fb       	call   0xfb5d22f3
  38:	4d 8b 1e             	mov    (%r14),%r11
  3b:	48 89 df             	mov    %rbx,%rdi
  3e:	2e                   	cs
  3f:	2e                   	cs


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

