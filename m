Return-Path: <linux-kernel+bounces-814108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36616B54F55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB411799B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C73304BB3;
	Fri, 12 Sep 2025 13:23:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683E21CC47
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683387; cv=none; b=kMDqkP7SX3TykDkT/M7nKut01c5kj4FKwf8uQN7vUbdsGyT/8d1aljw1atWdXKaV4qeN4ukep8kBshb9B1+ZZoJbJdOU9GkKZoaw04byMO4ztgDZkxq4CCSLpNNubdxIU46w/RGoPcAn/9+Fr/HD7S4MCJtxTrShP9CSrOrVqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683387; c=relaxed/simple;
	bh=j9V3bSewSyjfbK3ObB0qunx85mwdfa6gBk3FqDcqVpI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NcLJ4r/vgkFouN/c/EzHloxPYejMCzW2y7RZRY7F8E18Kxe4olVreMuezyU8Na1996rjDYHO+MavzrwIQn5ptuoTGhgQSO4UjvP2zxIh/MDRTcbZB/BeyUTm9yKkiDOk13cUESqXz828aTpO20Vo4zJ93Z8MH85/2wa3GYXVr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-40babea9468so24905215ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757683385; x=1758288185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVJGLqjmB/0QqtSLsSJpzit3a4E35P17aPPWI1PTnRw=;
        b=fnmDjEet1rOzSQCekNSQdQdlZuflHPPDcx0NOBtHP495rjUpYhjZZF6lwX7PKlWCbu
         1227HMOj9E6yN1nsqC3duO4PP/VaVqBf5LUvaHy7Nlx/Qgzx86fnEraLMV3ZmZOceYfe
         pJwuthGp0z2Szt25Z3Di15IwZLusPNJ8dBM4K7MxrzLnOlvOFqMmHJivdtm9JEsGJlMl
         0lwjmG5L0cpCqpHnWMCi7MCFqtHxAzpEqYU7ZP6cJiqXStiNx2OKRlwCkNnJKAz07nin
         Ar6ZymDZnU0RWKUiEMYgBMlshRraEnh7L5gQSkov6mMs6QhwDu+mXhjkSsWezBGj7lYF
         4hOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV42bqx6iCECjlqjDFgUXKVubWFjYyQEV6WXOUQA/Re/g7ENMI5sI1WIqxY83Ih84RVAgHiuxaShc0qQRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrArzzFDysvxNuGjbMqluObqCqnLPymJ6ANXOkVC638cvIn/P
	58Ijjj4Jj+GJriiZI+IceBBPbBz2oySfPgh+5MLSc5+BfEPXdifdjKFm6Mh+26BWeht7Ir5ljrD
	BW7x9BVHsAxgDDqQrvkuanFZS1i04j/imLm72KgmYi5rchfaSTe6EqK6jrns=
X-Google-Smtp-Source: AGHT+IGRh5fsQmUZXffpGaB2cOVDoM5wJCXl8FJo1WEozsmEHlnsHoNWHfTqmzVKdv/YdfNVbULqrbnwrl4sr38g1414IPG/mqRf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4a:b0:3f2:3083:8ab2 with SMTP id
 e9e14a558f8ab-420a39c1aeamr51276415ab.18.1757683385016; Fri, 12 Sep 2025
 06:23:05 -0700 (PDT)
Date: Fri, 12 Sep 2025 06:23:05 -0700
In-Reply-To: <20250912094226.6866-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c41eb9.050a0220.3c6139.04ac.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=580
WARNING: drivers/infiniband/core/cache.c:809 at release_gid_table drivers/infiniband/core/cache.c:806 [inline], CPU#0: kworker/u8:1/13
WARNING: drivers/infiniband/core/cache.c:809 at gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886, CPU#0: kworker/u8:1/13
Modules linked in:
CPU: 0 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 a0 56 91 8c 4c 89 e6 44 89 fa e8 1b a8 f4 f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc90000127908 EFLAGS: 00010246
RAX: a8b5d3ea91c5d400 RBX: ffff888026a6b6d8 RCX: ffff88801d298000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff11004d4d6db R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c3a6c8 R12: ffff88802f551b00
R13: ffff888026a6b600 R14: ffff88802899a700 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8881259e8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555f9ed808 CR3: 0000000033a60000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xda/0x1d0 drivers/infiniband/core/device.c:510
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

commit:         590b221e Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=151eeb12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12a1d1f3a8199632
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15381934580000


