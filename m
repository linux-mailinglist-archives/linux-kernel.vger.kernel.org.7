Return-Path: <linux-kernel+bounces-814791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C1B558CE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AD9AC338A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F1274B44;
	Fri, 12 Sep 2025 22:04:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802F4C81
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757714647; cv=none; b=Ixvh7tsqTMlj0TYAo9ZiLDCpYnTn16zCbxe6rxFtRThHPJM7vJP8aYkbSeppo5+QSGnw03DdlCjTvUL00drGyw5X+eGbGmFRAq8GxgczeaKnCVyY+IH2PJ8yV/tG76Gbe6ol6JGpiZHWduI1p61DpZfY49FHjGZSnYqW30d7fAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757714647; c=relaxed/simple;
	bh=RXCSG6VGhVwf1PmKCPtbVLuKwWZ51J6eHkFRrkrwTmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rg9HjnZEWNqlbB0aL3BgVMcEVmefdXOFC10L/FbkO964NDauilwFv3AomqJjG/lkOe2fXFAfLCV3LPbp1R77aErA49L4UOAvLyZnBNAaFtH5rmLvrOFKaRo34s5LEKt1cvZGwM37ADtAwFOOzEsSMCFjm5/2h221t5ehemqti9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f65be4978cso25658085ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757714645; x=1758319445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vbjPs234+RRXiTS2mFwaU6pNKzx07cUp302jMzoQ54=;
        b=tmmlXIRhKE731Nnuw73Eh3t0lCYtqGkxPsm4QDwK3KKjQwNvxzk1tvhnh+TTQMsFtk
         faSb3K48XYszE3ge/3k0n22xXYkhgRI5Wy0gX2V4IUepuE+gPo/S3o/+wBUQKG1V0A/r
         dAM2s4JST4U1uJfBP6YDuqY/Y8KecPgIOkstm4YLV+TuwnZlURUD56qsyBj+OXX1Z7KV
         a73FLzD8FqlRkgQzy9fCQnhCApZacX0QLlDNQHB/vfYEvZZaKXyw7eNZ5ABiVeT/IQBk
         UUIakY343q4B5sytRAxttyttNTEA+zHUIhhJ/0zcsXE00CRPTfNC5DMTsfwMbs8q8M9B
         aqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPGUe04qgxm69iPTYL0YnF/KAPUefhy6kJYtKROiDX41KWYa3S4HqMUAcM9PkiCF0l04TnK8ZeO30hMio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTXLYtCQimavRLkc1g2zS69wdLr1aacj+Pl2GfLklzpCj1Ele
	fMGxT0WlLmU1xplEGIoKJvckhzELstvWVoZ39qrXzw+B7MMHhUbiDXBL/ITSM1QJXU7A+LbBvKX
	QRCqL7yw0nwx+zB/vIH+/AYNb8FFXmV/l4QDRgWbN0GG382eBJjF5q3ZCOyA=
X-Google-Smtp-Source: AGHT+IF08CNESlMQflsi+ep4Smz4rdZbLuAHcxank6pr23q6o/nae8QXTI9BVocogO7DmHyH1rHsfAuRwmgeyjVGfn+DtlU/dXIa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:412:c994:db15 with SMTP id
 e9e14a558f8ab-4209eee6a7fmr82817795ab.14.1757714645262; Fri, 12 Sep 2025
 15:04:05 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:04:05 -0700
In-Reply-To: <b678b916-ad9f-4845-91b5-2e5d1f79fe24@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c498d5.050a0220.2ff435.0367.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=445
WARNING: CPU: 1 PID: 1088 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
WARNING: CPU: 1 PID: 1088 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
Modules linked in:
CPU: 1 UID: 0 PID: 1088 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 00 46 71 8c 4c 89 e6 44 89 fa e8 3b a5 fa f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc90003d0f908 EFLAGS: 00010246
RAX: 11007f8b953ea200 RBX: ffff88802d562cd8 RCX: ffff888026adda00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff11005aac59b R08: ffff8880b8724253 R09: 1ffff110170e484a
R10: dffffc0000000000 R11: ffffed10170e484b R12: ffff888028265480
R13: ffff88802d562c00 R14: ffff8880779b1800 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff888125d16000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000240 CR3: 000000007612e000 CR4: 00000000003526f0
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

commit:         dd87fd3f RDMA/rxe: Add logs to find out the root cause
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=144a9934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

