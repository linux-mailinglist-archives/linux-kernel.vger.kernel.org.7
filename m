Return-Path: <linux-kernel+bounces-784707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A8B34016
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA0FB4E285F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3E21A453;
	Mon, 25 Aug 2025 12:53:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966D217F36
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126385; cv=none; b=ryWUOUxeKmy1FJqhHvZjPvoTa0V3QQD5k60+8pNNkwKJBy6g0HmcIo4DBDurvJ378VCnuXvuw/Nj5A0szrhH+bPwZUKfjplTYwVcQQLH8QjCfXWYiWUGP/PDHaEnyM3BZV4pAXbzyJ5lybxgJy3wQXvGZ2JTcW1gIUZGU8c6iZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126385; c=relaxed/simple;
	bh=81kL3J2V1N6FXIm5WMNhZF8RHen8YLtBNuA8rDrU5ek=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ndhqXoXQEqSm9lhwUndc/5yKGy4+8U70WNcqFwfuoI626GLpOUBnRiekhRs4l75j1hGtPcTR5ca0BNUfJ8/T39MFQX1NewAbNQjfFs+CihXf5qx0B+ceFKxAVUNyZ4XVId0xR5N0IWOL0N6Fn01ZRbGM/+pSmyoUcxBHgYCt8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ea2bd7b667so82966815ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126383; x=1756731183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkTreR6OCx3H+Pw90Y+LT36zIuTvnfylxeDrKRmFiAo=;
        b=ZEZs0eDirWZzWG79a1uA9bqbEfmoV7JWhlOMt0JaEcDO6//lBhfK61+YbUXYtLgL5O
         cXYH6I1P1FdzxApK3wz7TrXo8kvmuWq6spOnQZTY5bts7OeWmIh9HdGG3ikCYcKLHwaA
         j3yid4utlYDn47m19stQeaaEPn4sO9IxFShSY76GH7gIACqw+NVkGhzhS04BQlOq6l7L
         Xw3aLfvbrW2MayjZoWBcNWall11h8+IuAEXWIzcvV1848aaI3R78ofVA25VZKBn5lSCM
         tychqoUbj1MX/i6yuH62acjDBvXFmwvN8BVbtqDRAToSaZjSJvNsFsWw4g+/enPGqFFM
         2sVA==
X-Forwarded-Encrypted: i=1; AJvYcCVU4ZB0GyrHUpGDgVitdnh2RuRgynJQCsKKujQtaM0pH3Zvd7p2mIVC+jZEdB/1uQ1b0fYbpXI1tAqHi2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2i8LPiI538NzzkgSywXtFlC4Y1EF2iD6BgiLC6HbmZ1mfSm4h
	cwJJC3nxLyVn6j4+HRyBcVq68Z2oUl72/F7ZV9DgpHkxcQsNZNQwvnPapWA4omQGlwaoB8dRCkh
	wNJuqm5JldhwcGTXS/xeLzv0yCZS/ErCJFAeYTm8XiQs5EBypxc7fg0ALkD4=
X-Google-Smtp-Source: AGHT+IH9VM7WDMbdKwJ6HfIcd1PSIxf58Q5RRWOrthTN2CgvCb8nE/O/LyiLEn2k6ILdUdQyR/cyOpLhERhEKuuxgq48n00klPqF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258b:b0:3e9:eec4:9b53 with SMTP id
 e9e14a558f8ab-3e9eec49f04mr145733835ab.26.1756126382783; Mon, 25 Aug 2025
 05:53:02 -0700 (PDT)
Date: Mon, 25 Aug 2025 05:53:02 -0700
In-Reply-To: <20250825102648.5395-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac5cae.a70a0220.303e5.0002.GAE@google.com>
Subject: Re: [syzbot] [usb?] BUG: sleeping function called from invalid
 context in dummy_dequeue
From: syzbot <syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in dummy_dequeue

------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 0 PID: 6659 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x2a/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 0 UID: 0 PID: 6659 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:warn_bogus_irq_restore+0x2a/0x40 kernel/locking/irqflag-debug.c:10
Code: f3 0f 1e fa 90 80 3d 83 fb 10 04 00 74 07 90 c3 cc cc cc cc cc c6 05 73 fb 10 04 01 90 48 c7 c7 40 ee 0a 8b e8 d7 dc 8c f6 90 <0f> 0b 90 90 90 e9 cc ad 03 00 cc cc cc cc cc cc cc cc cc cc cc cc
RSP: 0018:ffffc900041378f8 EFLAGS: 00010246
RAX: 7b813d5b6b8f1700 RBX: 0000000000000000 RCX: ffff888036dc9dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900041379d8 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017104863 R12: dffffc0000000000
R13: ffff8880374cde64 R14: 1ffff92000826f28 R15: 0000000000000200
FS:  00007f4ab96ee6c0(0000) GS:ffff8881268c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b34363fff CR3: 000000001da8c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 dummy_dequeue+0x2d7/0x3d0 drivers/usb/gadget/udc/dummy_hcd.c:786
 usb_ep_dequeue+0x66/0x250 drivers/usb/gadget/udc/core.c:330
 raw_process_ep_io+0x5a3/0xaf0 drivers/usb/gadget/legacy/raw_gadget.c:1124
 raw_ioctl_ep_write drivers/usb/gadget/legacy/raw_gadget.c:1152 [inline]
 raw_ioctl+0x22dc/0x3ba0 drivers/usb/gadget/legacy/raw_gadget.c:1324
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4aba07e7eb
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007f4ab96ecf70 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000044 RCX: 00007f4aba07e7eb
RDX: 00007f4ab96ecff0 RSI: 0000000040085507 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007f4aba3d0320 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000200000000080
R13: 000000000000000a R14: 00007f4aba2a5fa0 R15: 00007ffc6e132658
 </TASK>


Tested on:

commit:         1b237f19 Linux 6.17-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144a6862580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=8baacc4139f12fa77909
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174aec42580000


