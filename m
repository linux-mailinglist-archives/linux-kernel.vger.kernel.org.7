Return-Path: <linux-kernel+bounces-887000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC9C3700E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4854A1A24DED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C630FC3A;
	Wed,  5 Nov 2025 17:06:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BFD238D5A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362368; cv=none; b=IkJJ/SH/CY2PAXZfLnpG+NwK1QvsLsLNsUkqetkk9FlGkvBLzvihbKHJcm0PHFcYufUWwcUaOXW0V6Swcb06yQD/rwlyGDxoWnvuIpKLcJoyuHRbeyQg+xIjvcu36Fya1QA9j8P8YGcf9MjuZN8+3JfxNrQpbrZfNGNK9PeqBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362368; c=relaxed/simple;
	bh=2+LJf2A0ntqqgcn8ZlsuC57feFOE8bhK4cbFuCrDpEo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QIQU6cUzEroPb4U+b7lty5r1/mjoLpXYuucL0/i7EBqS4z7FnJqRD/HA7mZxyOmOVR2fuUk23s4wwiGYXWv87CSfv4Rm5iuZyhpDPlwo39psoBcJ6M3RBq+tKQ4lCW5K+/Ph3EwzPutWKJCwie4Xwqnx1qILYl+aQExyPV6L/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-432f8352633so145175ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362364; x=1762967164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9HqiRjnB2ROwj8otRrabc6fL16tIEB0s60h3xBLwWI=;
        b=i8yXnFqPh87kS2Thy7ybm8lGP0Ai+ejPguL7I83iMsjfBYqk5L6ry67P7NUwbzvTlS
         FnHnVc+F5sUet4LYVuJfyWsEVfpNdIvPvHqBogJBjioI1m5oG3mfvx5HO3dseM3qbJlT
         aYDK0gWnGlVzthcNnSVxg02xnDyz/DN1UGjgCfeMGeEdXu+Vso9ycuFznE7pFrG4/dj8
         2YDcI0Z91gm8iXxC1rRayBoHDl9vBJDBUIsHXxkHDNTqkSbcxWgKZFuxk+AxnLELVQVW
         uo4vljWUEhsPf3RV89yVxVfy2dSwhbm54cHjaE6XWVCCz5zV5eFU+DawEpq9mC5sxoz5
         454Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTZmcZqZLu3OmyTwbM/bi+EPAA1UzdTey9FLlvpDRh12qAlrXiTJLKZP9EYu47veYixh5fIJG3xFlKo4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKzHb+kzRf5Gh09hHxWeOW1WFeYQW15PhpNGh359lfFTKAhVg
	r92d0rEzbKC2B+Sdi9eKDTw3KpMpbhasWy3lQdJIrV0ZnICA66lskeTe7sZoq5krIkUODBeZE9t
	3RQsy4k0arp39+5Lg9CaIgy1XnLPSfm/y/d2tS/w15rV+0hw2fKI/3L9B1vg=
X-Google-Smtp-Source: AGHT+IEQSHPLfUDfYSdHMhDNJKFOOSDKVoPGYTo5CvN+h2y1+Xq3B6FS4bc+QWqQF5aCxvBkB7TbKA6srtKGlv71zBtVwVH8VIIS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca08:0:b0:433:3396:5fd1 with SMTP id
 e9e14a558f8ab-433407c3388mr53049675ab.21.1762362364601; Wed, 05 Nov 2025
 09:06:04 -0800 (PST)
Date: Wed, 05 Nov 2025 09:06:04 -0800
In-Reply-To: <185e135e-0e17-4ef8-91a2-15e69897cd01@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b83fc.050a0220.3d0d33.006c.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=363, state: 3
WARNING: CPU: 1 PID: 50 at drivers/infiniband/core/cache.c:827 release_gid_table drivers/infiniband/core/cache.c:824 [inline]
WARNING: CPU: 1 PID: 50 at drivers/infiniband/core/cache.c:827 gid_table_release_one+0x5ae/0x6c0 drivers/infiniband/core/cache.c:904
Modules linked in:
CPU: 1 UID: 0 PID: 50 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:824 [inline]
RIP: 0010:gid_table_release_one+0x5ae/0x6c0 drivers/infiniband/core/cache.c:904
Code: e8 03 0f b6 04 28 84 c0 0f 85 cc 00 00 00 44 8b 03 48 c7 c7 60 7c 2b 8c 48 8b 74 24 28 44 89 fa 8b 4c 24 50 e8 73 e7 35 f9 90 <0f> 0b 90 90 44 8b 74 24 04 4c 8b 7c 24 20 4c 8b 64 24 48 e9 15 fe
RSP: 0018:ffffc90000bb78f8 EFLAGS: 00010246
RAX: 124fa0acf3bf2700 RBX: ffff8880268c1990 RCX: ffff888020289e40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1b7a678 R12: ffff88802ed4e2d8
R13: 00000000000001a8 R14: ffff88806a158010 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff88812646a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555712ce808 CR3: 000000006b6c8000 CR4: 00000000003526f0
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

commit:         ad2cc78b RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=11dfa17c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

