Return-Path: <linux-kernel+bounces-817978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B2B58AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22523AFD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C01EB193;
	Tue, 16 Sep 2025 01:12:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A621E00B4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985126; cv=none; b=YZOIeXTOtnSJZKG8Q/T3bcahiNAfXLm4Q+csB3w5VexFi55xP04NdkPKZVd8dRuXGI+7LZ9I6U1pJsu3Mxup69X2MSpxJAk6iD5eaLc4fw6c7d4HQP4hvevh9v3jZjcvo375dj2Co2zJruleLhBkzlMDvD0IcgpIlv/aRtLJ7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985126; c=relaxed/simple;
	bh=LsJaxOLF22t9KbYfOUbdLMGVQGaGuPyEKfeV0SWR4NM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hw29CKPUhLjdb6aYBqWiD9EelqevobWY5xQcJve2a2eqVcdEJaMXkd/1d8FqOA3sZd0bPtz/x80EGbg1vuYOWOH3XQ5UbKSWMO3Vhl6nEBTfTFqZtT4NFekFiUcUBPiBt2Trzcm4YHT1Uq6CNHev+UXI3neUKFqBnCflu7Pwnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-893656f5776so164171339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757985124; x=1758589924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22IUJA0lK++Umtz1C92SGmsjZctSkach0bUg+Apios8=;
        b=aRKwl/LiUalIuFuTp6/r8C14U8cbrZpiOYwDwlKjvVyOhzS12rvOTMfXf5gI7vDilW
         1hmgsNNc26dYGacmbQ2Pd96oodIdCrGOtdp3XGleCFoANgZZpl1ip9IKWNLFPKx3Ph6V
         bo7A1yfiASh9w8SMyedJ3QeApS0+xADwSWkqvqaDcNfnBnIJ8mOwjch7sLzL9pmEUdVQ
         ZVO58rlLJwT8qlMixk6zcbI02tLeWaKHfEm35uUe12d7BBXMpGHoFkipm6fDzi+SX0vW
         rH81rgE2xjJM+kQfF61vooIKUxof1P90P2ulV804zazaFSERH3+k/dLhqFwv6EmMmf78
         pBVg==
X-Forwarded-Encrypted: i=1; AJvYcCWBAClJCFcKIrI2G/ggQi8tl19MSjeugqymnNNNNCl61szUJAS2XqyTUbnCoIdNV6BLKN2tH/ysBBWSboY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgk11zM5xkIDTmSAipqWnTA5p1wgHK3LzK7lvvxhVq1ft206wx
	z9sGhKMBF87QQhfCPs8/hJ+nGMoHx/K7KK+DVkjGqzVaLZzj060/ed92+k5hZn5cTxrLrHwuGdo
	Dk1J42DK6KmlOVulcTkP9QauSQWyKknLJvlBPUqmJeq1w71xZiEYOjXKdpd0=
X-Google-Smtp-Source: AGHT+IE3tAP7JPlhuDpi9ep0KPvJbwx1yHNABsVEpItsqD/phU4h+NC/ylRdsvP40DBMWOXH24v//q6mbKIhOuuRcFt5V0J2v6Ky
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d89:b0:892:5092:93d2 with SMTP id
 ca18e2360f4ac-89250929d78mr842632839f.6.1757985123839; Mon, 15 Sep 2025
 18:12:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:12:03 -0700
In-Reply-To: <d61c07c8-c5c1-4cfe-ad23-d972eaff8b9b@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8b963.050a0220.2ff435.03b8.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=414
WARNING: CPU: 1 PID: 61 at drivers/infiniband/core/cache.c:813 release_gid_table drivers/infiniband/core/cache.c:810 [inline]
WARNING: CPU: 1 PID: 61 at drivers/infiniband/core/cache.c:813 gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:890
Modules linked in:
CPU: 1 UID: 0 PID: 61 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:810 [inline]
RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:890
Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 60 4b 71 8c 4c 89 e6 44 89 fa e8 1b 81 fa f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000212f908 EFLAGS: 00010246
RAX: 083e9d4088da4900 RBX: ffff888077e080d8 RCX: ffff88801cb65a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff1100efc101b R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa24c R12: ffff8880335d2fa0
R13: ffff888077e08000 R14: ffff8880305cae00 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff888125d16000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c003586000 CR3: 0000000031e18000 CR4: 00000000003526f0
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

commit:         77403d3f RDMA/rxe: Add logs to find out the root cause
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=1399547c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

