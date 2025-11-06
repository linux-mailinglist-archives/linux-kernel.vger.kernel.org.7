Return-Path: <linux-kernel+bounces-887772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD98C390AE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 05:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB7434E4CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C214BF92;
	Thu,  6 Nov 2025 04:02:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C451FC8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762401725; cv=none; b=I6MsSU6Wx0oVw1xZ/iUczLB1MfdyACAO/ldWsONvW7ZQaIYGjRSg/MOinfFswl6N44Sb+PQraEFjOtUlwsoLw6ZlYezhxSGlbpFqBeKQtdc+mjRqpgm1xxSc8OcAeb9U+WfQkhPqOlgEG7LrCAbgdYKn5IV+XR4WpPFyOHnfaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762401725; c=relaxed/simple;
	bh=Y/XAT6WqkqFQPq89qfT4KjJwpqC9np3CzcNWZgn1QvQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=puoWjIdH7EwtpfnVMhW29B/rgmsnQsO2hUralBQNZH1+nO06EaHt3NteJ7fkF4q8B+6Bh0YwpVNzxL90ewUG2je/GnEiorUrBNwRScUjNz/Ze53GxoDoLMONVhjAIRNP4/7QFaR8u7y6W78gDAnflzeonE3wNM+G/Xdd4pQZVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43322fcfae7so5373685ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 20:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762401723; x=1763006523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1OHdfpvqmdDQtLTRE00Aed+Fe+id3JHtyNrfcHKNOU=;
        b=X0EZpuR0tS6N4jPHUtttKFPmaEab3kXZgIJ8z97XEIKjO3rB0kJzuBf3jduLgkdeoa
         NdJKO72kgj/fK5Yyq1v932oeqc/235pOO5gjz4FY8g5NAFG9SePNhOxh/hgh6anPTaKs
         k2T3JcvEzeTEG/z6QWgFVTD2q0ggSn+daZTcU6ravIOXCnuPbNqd7jh5OB4lYd2+40Pi
         J0/ySy19PJ/ImLyT+crY8swkG5bfQSrGH3TIVI6blf57ShOy/drC8b7QI8yJS+MmtjGm
         Xk/7ZOliSa17l/CLMN17Q1f7PCifsDk64Au48rD6PR8OPjcJvhiPQCzp7W85hq7fPNBz
         oYng==
X-Forwarded-Encrypted: i=1; AJvYcCUBUMSbrwOMzAm+KrKpv6xqN7XTFMZxLfX7KVMO/GTVw7Q922uBj2nYcdflthfDFx1FOvY///iOEFlerr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5DjLVs3oYfrUzCuNttTi0lD5yklhPwphpo5OnAww6Q35K+SN
	gZRtz3o4ZFOuskO9G4ux7iT130Nts3I5zQN+zELpuKOOpixo8l66CmAxzjacIQW+hB9LM+lqcic
	pyuNRkVqN0HJCsEQ5PBIjNZW2SJ0BxfJ3Snr5i4wOD21Jvy7MLJRGBpj/tqc=
X-Google-Smtp-Source: AGHT+IG0NS58Lw0EGEXUvDhgGjkU+XmnNvclC0o4Ft0EHzSJnSTd0IE4JzjDVgwoy6dXsIDBhUX96F4GTHr6sh8Emdmxl+VgK69i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:431:d726:9efd with SMTP id
 e9e14a558f8ab-4334078ee3fmr79728435ab.12.1762401723339; Wed, 05 Nov 2025
 20:02:03 -0800 (PST)
Date: Wed, 05 Nov 2025 20:02:03 -0800
In-Reply-To: <81fedfc2-8e6e-44f3-94d4-2c694c759ded@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c1dbb.050a0220.3d0d33.00df.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=353, state: 3
WARNING: CPU: 1 PID: 36 at drivers/infiniband/core/cache.c:817 release_gid_table drivers/infiniband/core/cache.c:814 [inline]
WARNING: CPU: 1 PID: 36 at drivers/infiniband/core/cache.c:817 gid_table_release_one+0x39e/0x570 drivers/infiniband/core/cache.c:894
Modules linked in:
CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:814 [inline]
RIP: 0010:gid_table_release_one+0x39e/0x570 drivers/infiniband/core/cache.c:894
Code: 04 28 84 c0 0f 85 9d 00 00 00 45 8b 06 48 c7 c7 60 7c 2b 8c 48 8b 74 24 28 4c 8b 74 24 08 44 89 f2 44 89 e1 e8 83 e9 35 f9 90 <0f> 0b 90 90 e9 c5 fe ff ff e8 64 7e 72 f9 4c 8b 64 24 40 4c 89 e0
RSP: 0018:ffffc90000ac7900 EFLAGS: 00010246
RAX: d89947cea50d0900 RBX: ffff888076c960d8 RCX: ffff8881436c9e40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff888076c96000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1b7a678 R12: 0000000000000161
R13: dffffc0000000000 R14: 0000000000000002 R15: 1ffff1100ed92c1b
FS:  0000000000000000(0000) GS:ffff88812646a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b2bf056c0 CR3: 000000000db38000 CR4: 00000000003526f0
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

commit:         e365ec00 RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=17a24a92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

