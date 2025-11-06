Return-Path: <linux-kernel+bounces-887592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65934C38A99
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 603464E6D84
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3BC1E5205;
	Thu,  6 Nov 2025 01:11:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1735464F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391467; cv=none; b=ezNSqfu9RcxDa11G6wkn0y+Qx6CqoZteuS+DvkHqpb3FEfJrF+xl0IcfN1Ue/I9Cs1c7Z54oAoLgepmmz+P+ygFoiPtteCkIuQ1FaZWB7pVBtTq4ay4gtx4qDbZYvcr0/8DxHb9vegsIklRKE8eTFynEkiHDNJWWY7+N8HLUzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391467; c=relaxed/simple;
	bh=7aQN0/U9nFKbV/b4ByOypyzgC/mbguJffjRz48r8vW4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UC8DinF/HMtOnFM2+Sim4haPnB2GAa/xuF0OdC7ulKaxbfrI6ZlZMS6+Hlvl3t2PBFjqjTKnzan/GQRuvsj0Gr/7PpIopoe4XfUgrZ0rq1zJr+LHylkNUOZzSVbuiL07cF+3j5gO2tcMC3G5ETScX37AuMm27jvxWhH+p3UT+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43324a2096fso4090055ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391463; x=1762996263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDn2njhc8Fa2vARae9rMVbiTXEUqf8IX6ws7Pwl3xWA=;
        b=cpXyuT+qS0rr5INSbmCUuR5VSOCjb3ZY5fkznIVI2kwIgCw9Hgb/kCZDLzXacsXqv1
         g5mXMnptiqyMgInez5S11p4zFaJGO3YbxMzBawOc8Zng5a8s1iFLqxJ+fb5I5KggBrCJ
         yyg1QQpp73A0lTWjDcT2He6aKbM3DFU5+vfNCWZ/QKN+0s/pDQ/jpP9UDDHUY0sYwE2g
         FYrGTJE84tw13peNYBy1cWOhIzRBg/GVnpKByxC4NPAYCfSOs7Ml+Q0He1NT06TNrHmJ
         4JIiELXI/cjjZL3IsfbIptAjIYUJSp2S6qXQ3Op7J+CnaZvDouEyWpYYdYa4FYhbgajx
         HmKA==
X-Forwarded-Encrypted: i=1; AJvYcCWhtQTE/JddfEn77O4jPLYRe52O6k5UMSPjZJM/lMT5drE1UUGtViFf7xNAibMfvcLKWnkYR7ADf51TzSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMV5LonF/nLX9RDuMzI5e5Fp7fYnbuBZJuc92AxRJAcgpp5VoX
	WCfIcEIN1n8TIC3w8SeFvxvgl42pbvBwn/E835Q/Y0t5PLxG+MVBIDWNJGTjVnNlVNUeEcJg2Jv
	ygGSCMv9OWfVhqPxNqqgrY8+DFYpn6kC9i7I5tZoLRahEpFuRzV26JZNLX8Q=
X-Google-Smtp-Source: AGHT+IGinytdy/zQc3YkwzAhNO1mU4Ygb13N1VR0q+2gHDrcZ0Vj1kb1xeGqWK24RUswJHiTVFwFZHLUYhQsC8yIWY6gbGk7Ncrm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3812:b0:433:1cd2:2fe2 with SMTP id
 e9e14a558f8ab-433407696f5mr64352355ab.7.1762391463259; Wed, 05 Nov 2025
 17:11:03 -0800 (PST)
Date: Wed, 05 Nov 2025 17:11:03 -0800
In-Reply-To: <38f2a630-7edc-4e9b-b5aa-3e983d67d024@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690bf5a7.050a0220.2e3c35.0010.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=381, state: 3
WARNING: CPU: 0 PID: 3018 at drivers/infiniband/core/cache.c:829 release_gid_table drivers/infiniband/core/cache.c:826 [inline]
WARNING: CPU: 0 PID: 3018 at drivers/infiniband/core/cache.c:829 gid_table_release_one+0x64c/0x780 drivers/infiniband/core/cache.c:908
Modules linked in:
CPU: 0 UID: 0 PID: 3018 Comm: kworker/u8:9 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:826 [inline]
RIP: 0010:gid_table_release_one+0x64c/0x780 drivers/infiniband/core/cache.c:908
Code: e8 03 0f b6 04 28 84 c0 0f 85 f1 00 00 00 44 8b 03 48 c7 c7 00 7d 2b 8c 48 8b 74 24 28 44 89 fa 8b 4c 24 50 e8 05 e5 35 f9 90 <0f> 0b 90 90 44 8b 74 24 0c 4c 8b 64 24 48 48 8b 1c 24 e9 1a fe ff
RSP: 0018:ffffc9000bf478f0 EFLAGS: 00010246
RAX: eb4f68ae1be28b00 RBX: ffff888028b86a90 RCX: ffff88802e945ac0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1b7a680 R12: ffff8880746374d8
R13: 00000000000001a8 R14: ffff888054220010 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff88812636a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1cff997f98 CR3: 000000007478c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
 device_release+0x9c/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         af436594 RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=15f6ca58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

