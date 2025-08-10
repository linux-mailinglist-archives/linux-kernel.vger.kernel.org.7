Return-Path: <linux-kernel+bounces-761358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA99DB1F8BF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759443BAD95
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91021FC109;
	Sun, 10 Aug 2025 07:16:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0699AD23
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754810164; cv=none; b=vAEtKIHoLBmw12pkX/I80iHzXqzla5mtd58pdW1R5wjy9vBvIUK7Z1Smbq8h9wCMwqNbDBMZ8OiAgr7euHS4O1PzAeR6UYtO5kv10pUR+j+/C/rnB/3FIvVWZ7k//zH1v1M0AE1eiAAj27NR+5MCXF+tIkzcsrDkafpilpkdHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754810164; c=relaxed/simple;
	bh=u3ezGgj1S9hWOOy6AzblKsCuQQhvF3Of4eQnALgHavk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mrI6GV/RSGz7i5aTDi9OU64CebaL+Xc8M/W6ZbPWdUA3vRxZSLu8oB9piJGbPTjQWtStrmoUyEngix/4zbSpGMGMJSW5zXr8ZWC/ddDF43Dh6J8h5AOIoEj0eGsHX48LtMJF0uzufoK2no03nnwoTMYDcaRhm+RjG3UfdNzhVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8819fa2d87fso303057139f.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 00:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754810162; x=1755414962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOZGUUb4diDfQKBp9zimvXaBsc6nfbLDdqTbocJxV6s=;
        b=A95Lq5yVOiHDtu83vQZI+XFk03IT2pinNFocsM65P4ceJQSPjVHqqgtrHHDNc+RGlv
         XKgJZiCpii9p699TfSv/JaoBeiICItVWMqe0gmwrwVUyACZNPY6+R9WD5Gj/947SlrLx
         IImofPWLHIGnd5kCYsKwbF4TpIlB44VLNUE9f69XugdHTbd7g9mRfwec+pv5E2M5Uia8
         mIELbL0J8cVR6f/orLdo2cuy0YMzBBMs4jLn44YHte5mvAgR6YTwUiOmbff5pXtRCJAY
         fqu29afv1NSk9mcG1Y2EVVjT6dQS8IL9TuAJzmPHYkNZdOj4BtHfgUonkM/JzsJunJnJ
         fEpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSr90QYoA3frBq3NktiLSm6Nqk7HCe90/DaE0ycClt3GAqFSTTc8xddlNWRrFk4qUspk0VLGKntTlkTrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4gRZfUzBAOoXtUYO8sIoOJY01vTSVor0n5QCrrGqibcvnlMr
	UhLfn5BxQ+cu0/9mSMmU7rzVvPkXoBaWZyTT+uspU20ZkvM7L3y8/d+TiHFnqfX5i08TALMER38
	gHhQ+e/DjkUVhGkBocf8FP/ikZliAJWNHVlqpwyWEnDQBqNy6ySHLL129AdU=
X-Google-Smtp-Source: AGHT+IGtUiglwa2oa8BLudGO5CF6weAt17G6rbka7bUTiD4KnlSemPF0cWOOpAi1Xk09XqD0WB+KrY3L0W0Y6FEylLShuYybpy8c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1481:b0:864:4b3a:9e3a with SMTP id
 ca18e2360f4ac-883f127b622mr1550051939f.13.1754810162066; Sun, 10 Aug 2025
 00:16:02 -0700 (PDT)
Date: Sun, 10 Aug 2025 00:16:02 -0700
In-Reply-To: <20250810060545.4177-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68984732.050a0220.7f033.00bd.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (3)
From: syzbot <syzbot+63859a31071a369082b1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in try_to_migrate_one

 vms_complete_munmap_vmas+0x206/0x8a0 mm/vma.c:1277
 do_vmi_align_munmap+0x358/0x420 mm/vma.c:1536
 do_vmi_munmap+0x253/0x2e0 mm/vma.c:1584
 __vm_munmap+0x23b/0x3d0 mm/vma.c:3155
 __do_sys_munmap mm/mmap.c:1080 [inline]
 __se_sys_munmap mm/mmap.c:1077 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1077
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6665 at mm/rmap.c:2460 try_to_migrate_one+0x20a9/0x3cb0 mm/rmap.c:2459
Modules linked in:
CPU: 1 UID: 0 PID: 6665 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-12288-g2b38afce25c4-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:try_to_migrate_one+0x20a9/0x3cb0 mm/rmap.c:2459
Code: c7 c7 a0 79 96 8b e8 36 cd 71 ff 90 0f 0b 90 90 e9 a8 f8 ff ff e8 a7 2e ae ff 4c 89 ff 48 c7 c6 c0 78 96 8b e8 f8 7e 16 ff 90 <0f> 0b 90 e9 22 ef ff ff e8 8a 2e ae ff 49 ff cf e9 e5 ef ff ff e8
RSP: 0018:ffffc90002f87120 EFLAGS: 00010246
RAX: 1f9183d47663e300 RBX: 0000000000000001 RCX: 1f9183d47663e300
RDX: 0000000000000003 RSI: ffffffff8dba5fbd RDI: ffff88802540da00
RBP: ffffc90002f87370 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: ffffea0001ad8018
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001ad8000
FS:  00007f6cc346c6c0(0000) GS:ffff888125d1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056399b4b5008 CR3: 0000000074e12000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rmap_walk_anon+0x553/0x730 mm/rmap.c:2851
 rmap_walk_locked mm/rmap.c:2967 [inline]
 try_to_migrate+0x3f5/0x670 mm/rmap.c:2628
 unmap_folio+0x191/0x1f0 mm/huge_memory.c:3137
 __folio_split+0x90d/0x1c60 mm/huge_memory.c:3711
 try_split_folio+0x13f/0x310 mm/migrate.c:1550
 migrate_pages_batch+0x653/0x3620 mm/migrate.c:1819
 migrate_pages_sync mm/migrate.c:1974 [inline]
 migrate_pages+0x1bcc/0x2930 mm/migrate.c:2083
 do_mbind mm/mempolicy.c:1539 [inline]
 kernel_mbind mm/mempolicy.c:1682 [inline]
 __do_sys_mbind mm/mempolicy.c:1756 [inline]
 __se_sys_mbind+0xa3e/0xc30 mm/mempolicy.c:1752
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cc258ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6cc346c038 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f6cc27b5fa0 RCX: 00007f6cc258ebe9
RDX: 0000000000000001 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007f6cc2611e19 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6cc27b6038 R14: 00007f6cc27b5fa0 R15: 00007ffd706df1a8
 </TASK>


Tested on:

commit:         2b38afce Merge tag 'turbostat-2025.09.09' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b8f2f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f3fea2580000


