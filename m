Return-Path: <linux-kernel+bounces-819651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A05AB5A416
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B587B1760
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC4A28CF5E;
	Tue, 16 Sep 2025 21:39:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17531BCAE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058748; cv=none; b=VKN7dCsbkYTfYFA+XoeRurUjF11DjIv/b1x938KL4WVgO6ykh45udRd3h5Qo2H3EkWabbvpaXIOJQNyEFqTvnj5cjI7MhS20WX26/A8WmQljUf1I2JWKS1SbpFBiHaHtgmiWbU2wK0R+LDmSj8ej66bFKl9PmzHlS7n/+xiBwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058748; c=relaxed/simple;
	bh=2U/ZXYmbAHBOaDifQt6wxnhhTJZJYPsBfCo6Ds0NawQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XOF0yYjE3qY+hcuKuo5UOn2dkwT8DZST6OJNSzn2ZSkc6Pwve8Lab9FgugP2w41WJin67zqHlFefVLNJR3L7YHmgliynGx5asbxgoFuHqspslWB533BEhpcQfOFy1W4dmEcT/ug/BD6B13M8MLDX60ca1ZNhqfmnbBWx9OBjajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4240c613549so44218705ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758058746; x=1758663546;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vl7t+PBfQ8bdvK8QTObBC7BDDedNyuuoaO+ZlW7A6p0=;
        b=VwI4ENDK0YxQBFGQp4EaAI9gVyMNjMeV5yhjaIsWe5Rzx3a3ScbI1dz/2WNC23Tp6N
         ORkTKV26ikGcQU+UKhKPCJAJjDCX1E1fk6LMna5Xvdp5RXSXINOhaU2R0UILb+cphTh2
         p72ETY5AHB4nSXL2B0i6Lu1afkjQgWTsbZnv/cILzEotusk50PPQKzKlOoyrhNbgVDnh
         b8h/kG3G+AAS39lwhkBSrZf9U2vEEDG9bm7apanbX3BVtXo46Ql0XZi/QwIrNrbQR1cv
         6nWjp/d2kEDyOA6UzEbqKHmR7SOfavwCatgI5pbblkYgjXSgcQ11Ihb782bLhjAJy/Yk
         euZg==
X-Forwarded-Encrypted: i=1; AJvYcCXozLZetRxXhY2AZSemSNsAwRGbCuyUb0dcr0EAPkkZUiEU2nrzaBrYBYWuYhB+QJvalQBh+CDDSZE6ADQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qGL2LyHXmg4GGTJcjx84Sqjbrdw0QM9rQSismuXnOJIWylzl
	cwzIaU3OLQci/S97Q0WLx8+R57PR0RbT2xhcIPS20ilUDhTwNCqEs0wCQ6bQZFY/JQOFL+ici/f
	lntRWA1yujTGf5+fTbXU4HW+kcoSkCS3HGIUctuEU5kH3aCliJ5fQkl0jeo8=
X-Google-Smtp-Source: AGHT+IHqhBkqFGSWmccIkGL+Lakomv6MCzcEbuBafeGDOb3f8HYP1KO6Pv/gY7t2TkOhaddzeIpDzZ198+G0xBEZ4ZaOjEypAPee
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a62:b0:424:19c4:3000 with SMTP id
 e9e14a558f8ab-42419c43026mr2785425ab.14.1758058746498; Tue, 16 Sep 2025
 14:39:06 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:39:06 -0700
In-Reply-To: <295acd4d-1f40-455a-9d2f-27393cd047bd@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9d8fa.050a0220.50883.0020.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=426, state: 3
WARNING: CPU: 1 PID: 36 at drivers/infiniband/core/cache.c:815 release_gid_table drivers/infiniband/core/cache.c:812 [inline]
WARNING: CPU: 1 PID: 36 at drivers/infiniband/core/cache.c:815 gid_table_release_one+0x606/0x7c0 drivers/infiniband/core/cache.c:898
Modules linked in:
CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:812 [inline]
RIP: 0010:gid_table_release_one+0x606/0x7c0 drivers/infiniband/core/cache.c:898
Code: 0f b6 04 28 84 c0 0f 85 80 00 00 00 44 8b 45 00 48 c7 c7 60 4b 71 8c 48 8b 74 24 38 48 8b 54 24 18 44 89 e1 e8 5b 7e fa f8 90 <0f> 0b 90 90 e9 f0 fb ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 8f
RSP: 0018:ffffc90000ac78f8 EFLAGS: 00010246
RAX: fc4e2f5b20774800 RBX: ffff8880786046d8 RCX: ffff8881442b1e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff888024e8ee90 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa24c R12: 00000000000001aa
R13: dffffc0000000000 R14: ffff8880227ec778 R15: 0000000000000010
FS:  0000000000000000(0000) GS:ffff888125d16000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b331808 CR3: 0000000026c94000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
 device_release+0x9c/0x1c0 drivers/base/core.c:-1
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

commit:         59f2dceb RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=133dfb12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

