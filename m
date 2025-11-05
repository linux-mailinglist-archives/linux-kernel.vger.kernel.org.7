Return-Path: <linux-kernel+bounces-887192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4581C3781F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01653AEC57
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDE4334C0C;
	Wed,  5 Nov 2025 19:36:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26676263F30
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371365; cv=none; b=uCkpezqfew7IBjYCQYkLhNH9tv8Fdk61jaLccpvrctJZR5s801FC7kh8v9Hs/dR9+dhGGqDTzXRwLAxvLUNRNz83/VyvXB7x/6RH8TxXbiAOKN9H3tOMfinVINRI9k30Ipcd9YIYtZkLyIWVeHOLXK9JuiHcNfMLx0XztyZmtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371365; c=relaxed/simple;
	bh=IekQoZ3M9prWcjxwpstVbwxA+V1ymfoG+44r09VJBIk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sewzu4LSnBxho/eIAW3OZ/x/TbVmFSPpdt+cNK8FvWq5hYsoZyYpaaBpuV5ocOiNKm1TgKBZHgnNp0I9f9MTBNYL4HH/xMaRr/+VKzn7FI74Syvoo51/PIFGdSBM5vHpmv1gzFYe/avJZ3NJasZnJEFKGbfp7gVgug8bvgDamik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43329b607e0so2937605ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371363; x=1762976163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhVjQvz/hyBvBW6cF+3wOMpyfpvYIy+XoHhEKTyln8A=;
        b=WA7gNWq/fJiDlan0BIhqZ8U+2HFGwhLd/5rWe5AMlg4xoc3k+/xPyKzFNQ3iJ+aS8R
         gWwHokw0PZm/hK/qVqfvclMLn6Lzt1+skfWMxmWS5IYDnP4iH71vXfG6zIBKmKV69buw
         b2aIi7BvmTu7fOi6a2tRDPXVplTflHpz/CIMHe9j3JzdWg/y2t3kBQjWmS6L5dUs9wRR
         whV4ZlQoiqpHT/huVIXw2HFVyMuBYDK5n+ow8lcQbvXcZ7oF+UTdydqWoWU7tLsAod3N
         71orIfGfAOkB5MvuEr3FU4Oe4RKF3oW/OGRSCktawoN4n/Kih3cyoOs7plOVBkGOuZxM
         nyug==
X-Forwarded-Encrypted: i=1; AJvYcCXgE3jgjFQxkyyxM2BdDmznnpHGMkWy/JsJ+vHTEwoWqzhl/rmhajspSlFrQwspXlLIceEIu3OxvcUuCLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwr4J30ntXU39BjHNbsQlPo5HFodrWQzAumW70Cjfxu1cZWSB
	AimsSPtjAKi3RKE9AqZ35fNNvCJeubXhKTqKxwHJuBt6SGBkukatmbAxVORfXXt/MDRIxbGejS+
	AT0DyrnIKUYtKokxuXatTv21OawMtmlJAgSjGm8JYJb/bbyGNH5Z5aNQxKBo=
X-Google-Smtp-Source: AGHT+IG4M1YhSNBuUJpqFofsInA4CluIksii2VKhgkhHytN7n7F5LgkwTKSJSsjKusfpu+X+9zbLx4F+QJXsg2oAXHaZECZ8Z1ul
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2706:b0:433:246d:283e with SMTP id
 e9e14a558f8ab-433407ceb56mr59122355ab.28.1762371362965; Wed, 05 Nov 2025
 11:36:02 -0800 (PST)
Date: Wed, 05 Nov 2025 11:36:02 -0800
In-Reply-To: <d8cba3c4-117b-4e7c-a442-d38d5289680f@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ba722.050a0220.baf87.005e.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=328, state: 3
WARNING: CPU: 1 PID: 49 at drivers/infiniband/core/cache.c:829 release_gid_table drivers/infiniband/core/cache.c:826 [inline]
WARNING: CPU: 1 PID: 49 at drivers/infiniband/core/cache.c:829 gid_table_release_one+0x64c/0x780 drivers/infiniband/core/cache.c:908
Modules linked in:
CPU: 1 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:826 [inline]
RIP: 0010:gid_table_release_one+0x64c/0x780 drivers/infiniband/core/cache.c:908
Code: e8 03 0f b6 04 28 84 c0 0f 85 f1 00 00 00 44 8b 03 48 c7 c7 00 7d 2b 8c 48 8b 74 24 28 44 89 fa 8b 4c 24 50 e8 35 e5 35 f9 90 <0f> 0b 90 90 44 8b 74 24 0c 4c 8b 64 24 48 48 8b 1c 24 e9 1a fe ff
RSP: 0018:ffffc90000b978f0 EFLAGS: 00010246
RAX: 79fe70c1b2777a00 RBX: ffff88802780ac90 RCX: ffff888021eb0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1b7a680 R12: ffff888075294cd8
R13: 00000000000001a8 R14: ffff88802e928010 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff88812646a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000240 CR3: 000000007e658000 CR4: 00000000003526f0
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

commit:         25f4e06f RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=109f532f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

