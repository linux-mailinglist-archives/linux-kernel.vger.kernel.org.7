Return-Path: <linux-kernel+bounces-881911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323EEC2932F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50313A3F44
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274E92DA75C;
	Sun,  2 Nov 2025 17:07:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE02DA77E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762103225; cv=none; b=f/ayLsrBzrG3wZKZ6X+oK4dELiwhlSvTy0QPUa5qSAeatAyNmzHuzllrjQavCUU+IaSKFarL98oEbqUIE22irjj4VV6CQkfrqB8RzMz2d7w5elVp7TGtvVaUmc0aqRB+9ZU9WZTYWwL+cd4oFnVBZzicLHxMiO0q7G4N81iejPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762103225; c=relaxed/simple;
	bh=Io+cZPFa/mMeMwrJU5c2n/BmZ8EFzbF419m+anlpewM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jtkG6qORZbtnlpMEyXGnYLiCc87vbpwribhouSL+XeZNWxzZeTmT0vz9fI9C8MzQRcBkNp/7Nl8aY2sVGQ5SE1/cZaA/fXBiJU2bjdXKKjQz18fFSD0eXAeKTQqrXHrZ7+0vMAyMUvKqDzz80lf+JUOWFuS90ddODrib1GryTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4332b83308fso3273655ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 09:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762103223; x=1762708023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9ryJ/Rb/1rutOXnSeaOrhEWyGdymn7htqzIzA/p/zk=;
        b=E70w+vAWFn25XFVz/CawPjfxH3gKZ5lxo2iymOjREVjpPIyJ9bzLF/eW6hG7DMVWmw
         wzHbqnFFQVoj9bjquqYKqBkDcvl2vdOrPvaNrCU3c0/xlbt9VjpBHKRa671JPE4uRAef
         paNhGHvUXUURwjyO/rwdgYItOfitNKZN3yS3DE9/xaUByCxcrSnHAqkP9IV268det/MB
         cHfBdV0LGJXQTGCuwX5xgrE7MnOBdMBeDggafdo21P9KP9QBw1lltDB/DWNyn4oa3sbw
         YABRNKmTZExp1Bi/AgQCsLVirhh8/ATxB7PKA3syYoAVXubyMDOf3mEXf7CMP8T0tH29
         +1CA==
X-Forwarded-Encrypted: i=1; AJvYcCXYbB20XDN++4w4xF5NJUqDTzGpKw5ekIzkpqMi8xqSrA2e5GrkrEZEUGJN0qlXkeXDAFARfBhxep2nyx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhvfUwVWLI0RXhnz9H2+tGfid0HDGAAE4DktzF2OAGglFHWdT
	fW4yfD9jtBnFUi37AUK5buUvYjPOs54oJt/4UC4aXRB90VagQm3Kv6ls7V+gMCA22WJGAREb+//
	a9Wp9SqpIr/iWSv9ZG+SGWQaAm5CJBJLHheyIakHrmvNGbh01DxQ+zkTx/dw=
X-Google-Smtp-Source: AGHT+IEWCmWx/44tyojxrspz6oAhdPG3S+rv4rbGYq6wE6I8GKCDskA5ZxrBduIfIRaosqhSpYI7VqyCXGVrXAMejr9FRl4ogqsu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4506:20b0:433:2072:9d2c with SMTP id
 e9e14a558f8ab-43320729fb2mr65371945ab.10.1762103222978; Sun, 02 Nov 2025
 09:07:02 -0800 (PST)
Date: Sun, 02 Nov 2025 09:07:02 -0800
In-Reply-To: <589113983.3481676.1762101635409@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69078fb6.050a0220.29fc44.0029.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ntfs_fill_super (2)
From: syzbot <syzbot+2e6c1eda2eff0745b028@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in get_data

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (4096) and media sector size (512).
------------[ cut here ]------------
WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278, CPU#1: syz.0.359/7136
Modules linked in:
CPU: 1 UID: 0 PID: 7136 Comm: syz.0.359 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 b7 d6 1e 00 90 <0f> 0b 90 eb 05 e8 ac d6 1e 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
RSP: 0018:ffffc9000bc46e00 EFLAGS: 00010293
RAX: ffffffff81a1af09 RBX: 00003fffffffffff RCX: ffff88801d389e40
RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
RBP: 0000000000000012 R08: 0000000000000f1e R09: 00000029b9da0681
R10: 00000029b9da0681 R11: 00001be062000029 R12: 0000000000000012
R13: 0000000000000000 R14: ffffc9000bc46f48 R15: 1ffffffff1bcab06
FS:  00007f01589546c0(0000) GS:ffff888125fe2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b9ec23000 CR3: 000000003328e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 copy_data kernel/printk/printk_ringbuffer.c:1857 [inline]
 prb_read kernel/printk/printk_ringbuffer.c:1966 [inline]
 _prb_read_valid+0x672/0xa90 kernel/printk/printk_ringbuffer.c:2143
 prb_read_valid+0x3c/0x60 kernel/printk/printk_ringbuffer.c:2215
 printk_get_next_message+0x15c/0x7b0 kernel/printk/printk.c:2978
 console_emit_next_record kernel/printk/printk.c:3062 [inline]
 console_flush_one_record kernel/printk/printk.c:3194 [inline]
 console_flush_all+0x4cc/0xb10 kernel/printk/printk.c:3268
 __console_flush_and_unlock kernel/printk/printk.c:3298 [inline]
 console_unlock+0xbb/0x190 kernel/printk/printk.c:3338
 vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 ntfs_printk+0x3b3/0x440 fs/ntfs3/super.c:100
 ntfs_security_init+0x644/0xc40 fs/ntfs3/fsntfs.c:1910
 ntfs_fill_super+0x3f35/0x43d0 fs/ntfs3/super.c:1586
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x92/0x2b0 fs/super.c:1752
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3641 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3717
 do_mount fs/namespace.c:4040 [inline]
 __do_sys_mount fs/namespace.c:4228 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4205
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0157b9076a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0158953e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0158953ef0 RCX: 00007f0157b9076a
RDX: 0000200000000100 RSI: 0000200000000140 RDI: 00007f0158953eb0
RBP: 0000200000000100 R08: 00007f0158953ef0 R09: 0000000002200010
R10: 0000000002200010 R11: 0000000000000246 R12: 0000200000000140
R13: 00007f0158953eb0 R14: 000000000001f2b6 R15: 0000200000000780
 </TASK>


Tested on:

commit:         98bd8b16 Add linux-next specific files for 20251031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1653a342580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63d09725c93bcc1c
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6c1eda2eff0745b028
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1226a012580000


