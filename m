Return-Path: <linux-kernel+bounces-809146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBCFB5092F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8253A833B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9BB287262;
	Tue,  9 Sep 2025 23:23:32 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739328643E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460212; cv=none; b=AY4Jox3dLzkwO5L2aF7554U8C9KDGyVLugBCNlxl6HWovOZbdqDlrUuifVzcaGMOq78Wo/1boUuQX7Ys6s+8cDCPgYgZA1mM0L9X2sneBws4NgDHBHt+kZgqcT3a9r7zlt1EB8ckGSsDgKCk8W5K2c/hXNbl/9ggcEPx6JX9r+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460212; c=relaxed/simple;
	bh=M5GUi+UFBwWm+EXf6sxOo83N1GRYMBNV4Yu3+UGUlJU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h7Y/kShY3Jn0XqXpgUo6RfYsIZkUQ3ws1YtAEZSIg+Foog1zaOqKKb+wkC0nU6LT6aubnEj4H/nQxOtZLxWZjb4HOTbhnWP3bnvsyD57Z1Sl6FRY9QoguN3+uIDkX4y6X2PUugYv4CONhTQAqcxFnEcKkJb0fvFzZvxJXrBlUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8875735aecfso2313745639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 16:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460210; x=1758065010;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXRzNXovbvKhfHPl7AbaXleDD01AmnIrCau7uI7AOJI=;
        b=VSPdlpgUragkVQd7r87bKlJrvAbxnhkUf80ZxnA7VaLGrzOj3O9amejuVyVlbPumf0
         pd/vNoxXk9bjvv7GlJsywwDrtsyAXuTtZ4epuEyS/lcQE1D5Rpfg94mK2emofi0E37h6
         34Udm8e67x/Yxep3ZMPjZd+EN80Mrpe0zneEO3Lc0el8/dVUXZnEKBR8rCKMfROovGm2
         3noDWrtqn1JdWMTH9qPd9DS9QEzV5YtHIbBkrUffLREBBH6T0l2jvsnW1+j+bgyOs4Sp
         s3wbuA+oK/kf2795ExzjEa/cPkjUEio9EFKagaASnjbsXTaUPV8wlrhtnZjOYEOMrQZr
         5UVA==
X-Forwarded-Encrypted: i=1; AJvYcCUUcHHPa7lUrZlSy8958POKqvQlHM5cYGrk7h/fdceGZ98pLUODG25CLSzNt/Poo4ueubntnQrJxvUX5dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXB+C39ort/cbWaWKH+R/BU3RKwVeG5qU19cfg/76C5k3zw+P
	zqLmdXA9Fe2GxF0tLIzWK2CH5ZiR7lZKn8Dms6p8zaffMRn/HavAGbhWvp5QhI2yr5dtkgdqGyH
	PWa0CG5sTxITPVMfvx9eO5AZLaNhwyZN6aIy6U4EnAtxHdrMTxxJJVx/SMpo=
X-Google-Smtp-Source: AGHT+IFvCVHOScOi1V4fP34N4FyO6fyiAJKqjUpEEcDIuwwx8hBXeKenax2RAZr0ypfGlZNKySYb4PvwnUH7a4//b70QmsG4/c34
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4417:10b0:402:b8e3:c9f6 with SMTP id
 e9e14a558f8ab-402b8e3cfbcmr156221175ab.25.1757460209872; Tue, 09 Sep 2025
 16:23:29 -0700 (PDT)
Date: Tue, 09 Sep 2025 16:23:29 -0700
In-Reply-To: <684c0d76.050a0220.be214.029f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c0b6f1.050a0220.3c6139.0014.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_jindex_free (2)
From: syzbot <syzbot+150563285f78ac3e9bd4@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9dd1835ecda5 Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1580c934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7f605fd273c8220
dashboard link: https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10472642580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b94b12580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9dd1835e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4657190ff75d/vmlinux-9dd1835e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c21590a37de/bzImage-9dd1835e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4e71338bb0fc/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=138ab562580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+150563285f78ac3e9bd4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/gfs2/super.c:76!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5487 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:gfs2_jindex_free+0x43e/0x440 fs/gfs2/super.c:76
Code: c8 85 80 07 cc 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c ea fd ff ff e8 42 39 26 fe e9 e0 fd ff ff e8 b8 a0 7d 07 e8 53 48 c1 fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
RSP: 0018:ffffc90002a8fa40 EFLAGS: 00010293
RAX: ffffffff83fe763d RBX: dead000000000122 RCX: ffff888034610000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000ffffffff
RBP: ffffc90002a8fb00 R08: ffff888050e74d4f R09: 1ffff1100a1ce9a9
R10: dffffc0000000000 R11: ffffed100a1ce9aa R12: ffff888050e74818
R13: dffffc0000000000 R14: ffff888040184200 R15: ffff888040184278
FS:  0000000000000000(0000) GS:ffff88808d20c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0021090f0 CR3: 0000000043def000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_put_super+0x8af/0x950 fs/gfs2/super.c:636
 generic_shutdown_super+0x135/0x2c0 fs/super.c:643
 kill_block_super+0x44/0x90 fs/super.c:1766
 deactivate_locked_super+0xb9/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1375
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:961
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f235d18eba9
Code: Unable to access opcode bytes at 0x7f235d18eb7f.
RSP: 002b:00007fff8ebd2df8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f235d211c2a RCX: 00007f235d18eba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000005 R08: 00007fff8ebd0b97 R09: 00007fff8ebd4050
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff8ebd4050
R13: 00007f235d211c05 R14: 0000000000018b8b R15: 00007fff8ebd4090
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_jindex_free+0x43e/0x440 fs/gfs2/super.c:76
Code: c8 85 80 07 cc 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c ea fd ff ff e8 42 39 26 fe e9 e0 fd ff ff e8 b8 a0 7d 07 e8 53 48 c1 fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00
RSP: 0018:ffffc90002a8fa40 EFLAGS: 00010293
RAX: ffffffff83fe763d RBX: dead000000000122 RCX: ffff888034610000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000ffffffff
RBP: ffffc90002a8fb00 R08: ffff888050e74d4f R09: 1ffff1100a1ce9a9
R10: dffffc0000000000 R11: ffffed100a1ce9aa R12: ffff888050e74818
R13: dffffc0000000000 R14: ffff888040184200 R15: ffff888040184278
FS:  0000000000000000(0000) GS:ffff88808d20c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0021090f0 CR3: 000000003380a000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

