Return-Path: <linux-kernel+bounces-892014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C9C4415C
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4938F3A5279
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BDB1E8342;
	Sun,  9 Nov 2025 15:32:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94CB67A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762702326; cv=none; b=AHxL59H13XSPqaknzAP8Mqb76lR0kLnxCwd+RAlwL5O/SUBeNGTwyEOromtU3FLv9MuwPCw/mEWPhdYTgp0YkILus0rJZ2SmZcDEF9C0VcsYE+xyeqwmYYyK8WVX0oGuwsl9CBVLWdKks6lXlSEBhCXm58WFLpdMjPoEYCeJ62M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762702326; c=relaxed/simple;
	bh=dP2AFQ4sz1rgJfnAIrjjZczpF6EkrM2FbNbMPPjH9eg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KMwZldYjjRSBvdg0Xmd5O/HAxmMBrGkSZEb25p7IzJEZhQf7c0tQKnKQeAbjA3gotODZGaZ4g5RzbOcCLI797HHDFRYmSRtYCv7SklEwsK4O/6k4k6pyQZiiAi0tqGwXvMDvBuHFvOZppCKoVrO6JxX6+cgrVE9kl+P0MlS4A3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4331d49b5b3so81787505ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 07:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762702323; x=1763307123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEWIGYQPBg8lXJg1T5QbHNpA7wP52LZGWdl4gyFGoOs=;
        b=nJn9Fs3ppTPe6TFJNRpTOg2t7gbvRiHrpYk4KgTFxva03Zup4jJHhcuz47IiXd5Zu9
         7PEfclUfqFwcZ3XFA3HB+tivvdplNSh4i46XJ20wM4ro4sbNh0hZi5njL+R6yyiW7nxX
         RLEuO+I0O1U87VQrtUpRN7w4Cf8pctVqnQ13n4TsyufxUlIbdAhVNywfnDxetYTG73er
         22c7fQfjHoGljF7r9AkIVsnajqs5u7oZDA91Q87O3Po6L31ry6Z0cpv0kKpmGkOAJCVn
         +veqyhOkrp8s1mcYfimbCtaFQdyRi7hD8cz78ui5HaF+h3nJ8Bm+Au6dW3xvHvZwLqbA
         CGOA==
X-Forwarded-Encrypted: i=1; AJvYcCVH4Ll3pNFHO97B20LsqkQ49AMN5abLq7+ryVy6yODozLCqhtSLaECQz2Ff5BlgYuIFlQpc7jrdBY7dAkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0/ar+bhJIra2iAVN+S+qNquIXkLGCb1h2yOPiJl9JeESgN+g
	XrskTUOjXzYhU/2REZqSShKdWol/U6xd6ilt3WOxZ/w1pCBrs94kU3gn4oh2TrEWa2r1U0ZriBJ
	muejeg+RDfN8uOSgZulY2mhgZIC2L9MVMxzx8q/2MNzxE6GfQN/az84jssd4=
X-Google-Smtp-Source: AGHT+IEKqZ0dJXc2Rz4B9PbqAQvkNI0C49zoK9LppGFilxBkoc4FFodz4rXaNB2RvNw3Odg1pSAQq10jTuJ07AZiXas2uCtx5ISz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c1:b0:433:5e33:d424 with SMTP id
 e9e14a558f8ab-43367dddbcemr82072715ab.2.1762702323644; Sun, 09 Nov 2025
 07:32:03 -0800 (PST)
Date: Sun, 09 Nov 2025 07:32:03 -0800
In-Reply-To: <20251109151559.1145822-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910b3f3.a70a0220.22f260.00bc.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in notify_change

After security_path_chown: owner=ffff88801c36c900
notify_change START: inode=ffff8880411c5620, owner=ffff88801c36c900
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5846 at fs/attr.c:428 notify_change+0xc5e/0xef0 fs/attr.c:428
Modules linked in:
CPU: 0 UID: 0 PID: 5846 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:notify_change+0xc5e/0xef0 fs/attr.c:428
Code: ff e8 26 41 ff 00 48 8b 93 e0 00 00 00 48 c7 c7 20 ae 79 8b 48 89 de 44 89 f1 e8 3d 5f ff ff e9 e5 fe ff ff e8 93 00 98 00 90 <0f> 0b 90 e9 b0 f4 ff ff 44 89 e9 80 e1 07 fe c1 38 c1 0f 8c 34 f4
RSP: 0018:ffffc9000cfbfba8 EFLAGS: 00010293
RAX: ffffffff812832dd RBX: 0000000000000046 RCX: ffff88801c36c900
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffff8880411c56ff R09: 1ffff11008238adf
R10: dffffc0000000000 R11: ffffed1008238ae0 R12: ffff88800043eeb0
R13: ffff8880411c5620 R14: 0000000000000000 R15: ffff8880411c5700
FS:  00007f1d976436c0(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1d968a6e60 CR3: 000000004de5d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 chown_common+0x44a/0x700 fs/open.c:793
 do_fchownat+0x161/0x270 fs/open.c:834
 __do_sys_fchownat fs/open.c:849 [inline]
 __se_sys_fchownat fs/open.c:846 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:846
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1d9678efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1d97643038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007f1d969e6090 RCX: 00007f1d9678efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f1d96811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1d969e6128 R14: 00007f1d969e6090 R15: 00007ffc482e6f78
 </TASK>


Tested on:

commit:         439fc29d Merge tag 'drm-fixes-2025-11-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1679517c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17309412580000


