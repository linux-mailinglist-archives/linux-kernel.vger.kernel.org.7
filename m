Return-Path: <linux-kernel+bounces-823674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4EBB8720D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2AE189DE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599B12F619F;
	Thu, 18 Sep 2025 21:27:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284762D23BD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230825; cv=none; b=CyQxTLzSaV8Kllj/9DLOTcCyZY5cD2nrEi5dVrMSf5pwPtnxqb67AAX4ybuzoPv5Dji+kZJNKJyZ8ct8LK/rwFmC0Qd22QO7XneQZAilmbFlm+IeGl4RI1CSdIhb/rbqEVhQJBtIv7GHVlvsxi2G0jyu1SmhVhxk0Ti1hJ3QR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230825; c=relaxed/simple;
	bh=WVYrGUAI30Dhah4LdTtf/BJja1qYhH9Uxbom6p/mXSg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HUH2MVRnOYu1qg+8BkaVqeYqvJKbH4Qxgm0GsuGwWIJvszCtPTr8xFhJtL8L9fi2gqmObb9IMiMpRgqA0gMUMwj9K1WBvGY3dwNJyPe4HR3OdftetszAS13ZQavHZL9eTR9mathl97KLtAtNPbI8sxy22anA9Aj2nq1S4HdRC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4020e59b735so32018405ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758230823; x=1758835623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vO3dnOquriC0id4bsNg8UcBS4t91sizOfvuwuJ4d2hw=;
        b=ExPHjJ5yjvVO9sNzP4W9WgLMSZbaXVI75m5EcO2qSUsbMt8uD33aeFUuLN54tbPXwH
         gnefYsXeCbF4qTk2I7vd5YtvmhMW3yUlUMbEE/C1AqDKabN9ULYERRcvPR6RL/CPawu/
         Ne+/5rvZ3RWrGNewDK8kLteq4EzWRY5OhjRWVK8HgzfPsBINpE+KFx9RzSXxdIDojORG
         oI5/gFHBmIfUsCvg4K0w509eo6iasfn6WpvNrTC4a3RuSA+PP4e8moWwld71y4ffiGwX
         xOl0j/3TWxfVxwM5KmItTgbVu1Bdgh2n0be0+rcxWkg04Spx7arDpsjmSS/z75Sj2Z2i
         fSVw==
X-Forwarded-Encrypted: i=1; AJvYcCWLjfCHFgB1gYkGl71VGgqlgOhq4VyIq3AaDOHs4szNi3jT2DKrkheLEnyBmrQSNVjV6apBRrW/khbzCa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNilnC53oJWYl4TjshQAvW8kOpC+zpWD+WcWTvc2QZ5eh/vm1
	ndQnBFvh/NBQFkte5gahz/Sau2Kj1ilGr4kWXAwK4FxCQATZTjpSbtZmy5QesJUb0aFaOP6igKI
	g1T1ZZMf0KGO5o0HvPZi/ERPpp6Bmw6uww4EzWpMvDJhpaElxqFI80WIW538=
X-Google-Smtp-Source: AGHT+IGNHdEqmXZoE5Vu2n9If7dgxKsrMgYBqwzxl9DHXCARi+FNgAvOT6PJAZEqRqJK2c+LOG78Ac4PIcDjl6TOmCmnGN+AfYyK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:424:8013:c7dd with SMTP id
 e9e14a558f8ab-4248190b458mr19985015ab.1.1758230823325; Thu, 18 Sep 2025
 14:27:03 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:27:03 -0700
In-Reply-To: <20250918210414.15022-1-pedrodemargomes@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc7927.a00a0220.37dadf.000b.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtDelete
From: syzbot <syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	pedrodemargomes@gmail.com, shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in jfs_evict_inode

------------[ cut here ]------------
kernel BUG at fs/jfs/inode.c:169!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5829 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:jfs_evict_inode+0x438/0x440 fs/jfs/inode.c:169
Code: fe e9 e0 fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 23 fe ff ff 4c 89 f7 e8 53 32 e8 fe e9 16 fe ff ff e8 a9 30 83 fe 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000294fae0 EFLAGS: 00010293
RAX: ffffffff833c7ea7 RBX: ffff888040f50430 RCX: ffff888000b00000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888040f50430
RBP: 0000000000000001 R08: ffffffff8fa1dc37 R09: 1ffffffff1f43b86
R10: dffffc0000000000 R11: ffffffff833c5ba0 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888040f500b8 R15: ffffffff833c7a70
FS:  0000555570297500(0000) GS:ffff88808d261000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd8d810d68 CR3: 00000000594b6000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 evict+0x504/0x9c0 fs/inode.c:810
 dispose_list fs/inode.c:852 [inline]
 evict_inodes+0x64c/0x6d0 fs/inode.c:906
 generic_shutdown_super+0x9a/0x2c0 fs/super.c:628
 kill_block_super+0x44/0x90 fs/super.c:1766
 deactivate_locked_super+0xb9/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1375
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd644f8e497
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd8d811518 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fd64500e08c RCX: 00007fd644f8e497
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd8d8115d0
RBP: 00007ffd8d8115d0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd8d812660
R13: 00007fd64500e08c R14: 0000000000023de4 R15: 00007ffd8d8126a0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jfs_evict_inode+0x438/0x440 fs/jfs/inode.c:169
Code: fe e9 e0 fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 23 fe ff ff 4c 89 f7 e8 53 32 e8 fe e9 16 fe ff ff e8 a9 30 83 fe 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000294fae0 EFLAGS: 00010293
RAX: ffffffff833c7ea7 RBX: ffff888040f50430 RCX: ffff888000b00000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888040f50430
RBP: 0000000000000001 R08: ffffffff8fa1dc37 R09: 1ffffffff1f43b86
R10: dffffc0000000000 R11: ffffffff833c5ba0 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888040f500b8 R15: ffffffff833c7a70
FS:  0000555570297500(0000) GS:ffff88808d261000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c009bee020 CR3: 00000000594b6000 CR4: 0000000000352ef0


Tested on:

commit:         cbf658dd Merge tag 'net-6.17-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1261cf62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=839dff357af8f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=4f9c823a6f63d87491ba
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11123f62580000


