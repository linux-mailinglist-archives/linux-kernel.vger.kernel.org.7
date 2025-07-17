Return-Path: <linux-kernel+bounces-734898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838AB087DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A75B4A5085
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030E27A931;
	Thu, 17 Jul 2025 08:25:35 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F653BE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740734; cv=none; b=iQnoGNPXaBcxLsB42ZB6kbvN6FMfapg1VEfD1komXQtezJFtxLMLUOvh997I5cJ2ULKKAmoIWCO7WyPhOmkPiX/QcJ8cYSMqpvW99QUo4bDlIWKLhpXqX8fOit267/Ak05xfsY9bZOFRJUXgdSXr3nRlGTmBF9ZmzyLS/3agNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740734; c=relaxed/simple;
	bh=JPiIC1w/3TYwWMgDsnjNbolZsuxA6bNDhu+gaYfutxg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R+1wQCGxunAJk6+zV1PCxeb0JeszydiAL0MeAI6/ZvlA3abzInXpvygO20cXwoYBulg2PfCcVQC7hgtEuHbd2pS7CaR+uuuhYsmAzjvgTG/LdJSI1nSKOXnKDyxgqTIow0QnLqPJKj6lkutNmqByVC2YbuZtOY/c3bqLj3/H3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87632a0275dso65271739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752740732; x=1753345532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eY9aqbGhGyvqVjLTPhhxqcyiCeBk55+9dzBpRxUERic=;
        b=a18F1ZjXK6sriLheobuu6SmGg2yoW1WLPllEL/sqxGEbufaH3VmExjap7JMBaXsrOy
         ADv5PKSr34FOBBmb1lu/qhFhl8hScYVeSwqtF1ss4wL+LmueB61YpyArfFwrnqbRQapa
         ZEFLb0PEdQa9TINDM5Fjh7GMH6MQ7CC9tjT/RnfiIZjGg4vVwPXwNLB2ubEPN4Vqly2n
         OvS1PHWlhsuydNT7Va8TIHBko+2gP8HDvTlG6uSDE4rwTO1JLesvSpOsYCsElpuTkICY
         JeqFYBleDnPa+bg70rK4J4PNSaO7ICYXdwv49f3BrOkdzBag3S/z9W0zeEXEau+VHilK
         CX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2iWDCI0god/VXXTP9kUjqkvgay8FqYn1JifDjCdiVOekuYgY/23t+ZH6xoGAhgEqlNZDEXidgGZOo+fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9Y5cGYE8vaEu4BPrghBGij0/yLfmLWTKhqxYLj+5ctgHxiR0
	FSwecODW45rKCIAl98stgbmZJkG7b5kxLL8aSqzf6SS83qsVuvwLur6dumWYh3uKJz34DlTH0vD
	6iIX3ubUc2wg5rVMu+c6hrshcjWsv85vq87M32zbyJjibXLMBOzHW4W1iUaI=
X-Google-Smtp-Source: AGHT+IGkBGjgaWMB2XCjyZvBAlVgB2UHG9tSnQejzjNoM6BQvTg1Ju0bY5ox40yz1J2NNECiFGslmKFQMd0+HCuRSHFGFjPB39//
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1348:b0:879:66fe:8d1e with SMTP id
 ca18e2360f4ac-87c0138865bmr212973739f.8.1752740732360; Thu, 17 Jul 2025
 01:25:32 -0700 (PDT)
Date: Thu, 17 Jul 2025 01:25:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6878b37c.a70a0220.693ce.0041.GAE@google.com>
Subject: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in comedi_device_attach
From: syzbot <syzbot+c7e121cdcbe0b0bce98e@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    155a3c003e55 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11196382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=693e2f5eea496864
dashboard link: https://syzkaller.appspot.com/bug?extid=c7e121cdcbe0b0bce98e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-155a3c00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8464683662c/vmlinux-155a3c00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e74dc5d462a7/bzImage-155a3c00.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c7e121cdcbe0b0bce98e@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/comedi/drivers/pcl812.c:1152:10
shift exponent 1029 is too large for 32-bit type 'int'
CPU: 3 UID: 0 PID: 6168 Comm: syz.0.33 Not tainted 6.16.0-rc6-syzkaller-00002-g155a3c003e55 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:233 [inline]
 __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
 comedi_device_attach+0x3b3/0x900 drivers/comedi/drivers.c:996
 do_devconfig_ioctl+0x1a7/0x580 drivers/comedi/comedi_fops.c:855
 comedi_unlocked_ioctl+0x15bb/0x2e90 drivers/comedi/comedi_fops.c:2136
 comedi_compat_ioctl+0x1d0/0x910 drivers/comedi/comedi_fops.c:3201
 __do_compat_sys_ioctl fs/ioctl.c:1005 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:948 [inline]
 __ia32_compat_sys_ioctl+0x23f/0x370 fs/ioctl.c:948
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f15579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f503655c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000040946400
RDX: 00000000800000c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
---[ end trace ]---
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

