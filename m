Return-Path: <linux-kernel+bounces-814756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC3B55849
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8261B1C855E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC83D2367A0;
	Fri, 12 Sep 2025 21:20:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E11DFD8F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712005; cv=none; b=HpF9lN4PFqqOtwsTzdXASLkP6QzmJowmRarCXB4/yTJ7vbWnqfnSr9JTPbi3hD4OCJupWxKtpy+PVtoI4PCmEk1JAlP0vDnaZTwnG+3knB+3CFR9NJP9aNXHsFcFOuf5fYxI68q1bLLRX3DNwo75Qc01BoWgXj/58lkxRbS1tUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712005; c=relaxed/simple;
	bh=s0dLJD1pylmUB6Rp/Wf1ixub+Qwmi7U3q2Fjg7wivlY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qx/BSpoekcpFn2qh7vyraWx8lO+d3ikGw8o+vRhaIG01liM0th98nyM0W7ZRMdQt/012v9NFPnkrF5YpDC2udZcXJKzvZUC/rqhw0pgGeiwHfv/geOERmEQmXaQ4FUVxklojAMuoSsUr9MBGqkIcjfWtUmQ5V06klzXt0Q8uIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-40194dd544eso32810795ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712003; x=1758316803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJFKxvHGvZZBn62ZAITAiCMsMZxoix2SCcjWo8rn3Ak=;
        b=jwalxargAI0uObUlCWK3p08s+YpIbJyJ65UzlRWZMVBIP2+Poh+0LdgKNQ7srzc0rO
         6LXAUwJqh5MmEP1l9cE8rJjYe0d2YWkeXfrmW6rWaw6s34cPZoDt4ZScWRhU1WHZNmfD
         VKoWbtzKjdovHcCxIjdcQhVs9WlgmJBkvMNFhl0eSHkGOMtFTTT2fmQaUqVOZDo50bwV
         LXpjUmn0PzHo5w/OsIFJJ1CnZUvL7kmeKE2TDuswTNVyxePCnlkwl6Lxv9mjh8KV4mQk
         V0Y5s8sFd5YvlPzhnBns7OahYqPZGwY1T878yXYy4afOsIiBrOc0qwq02bkOaRwK0bMK
         sdYg==
X-Gm-Message-State: AOJu0YwKwAz7VFV5bimaFykT8TKYqwZ5+rE/yFnBK7zrcC3BWiejmFYL
	aNP59ScD3UScjAIp/SMWmKdRzEW1t+ekfSRGMnkTUOxJLpuMXtxy4HoQ6/jsW9mkRuZ5xafJPxU
	c8WC762a72/wwtNvXoi/U50RGsAYzLzaCWUFDyW2gCW3TbykdXqh8qeNyWBU=
X-Google-Smtp-Source: AGHT+IFvi5GGcWD96sBzCcOS850cF6TH6IvLDMwPvAEctZ3qXB8KaIZqf63/Sle0vsav2XyFmD52RFxe2W9lYOCKxiRMnDw7K+ox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:40d:e7d8:63fa with SMTP id
 e9e14a558f8ab-420a4268b84mr62586055ab.26.1757712003181; Fri, 12 Sep 2025
 14:20:03 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:20:03 -0700
In-Reply-To: <c9778714-2966-4b61-b371-9d831bd2492e@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c48e83.050a0220.2ff435.0363.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

WARNING: CPU: 1 PID: 1342 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
WARNING: CPU: 1 PID: 1342 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
Modules linked in:
CPU: 1 UID: 0 PID: 1342 Comm: kworker/u8:7 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 00 46 71 8c 4c 89 e6 44 89 fa e8 3b a5 fa f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc90004bff908 EFLAGS: 00010246
RAX: 6115427e6ab01100 RBX: ffff88807855c2d8 RCX: ffff888027abbc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff1100f0ab85b R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa24c R12: ffff8880206a4b40
R13: ffff88807855c200 R14: ffff88801ffd5a00 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff888125d16000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000240 CR3: 000000005e54a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
 device_release+0x99/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         e5320428 RDMA/rxe: Add logs to find out the root cause
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=12829934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

