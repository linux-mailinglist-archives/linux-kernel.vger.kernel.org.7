Return-Path: <linux-kernel+bounces-761295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F0B1F7F8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 03:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFA904E0EE6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 01:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D93717333F;
	Sun, 10 Aug 2025 01:55:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335887E0E8
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754790905; cv=none; b=q3EAaH9zjnzVj4HLuoQKdobvgRRobPfnNMh/VP4qSeIt5Wcwc4s3q38JHSldoEvkK8M2Ijo3v6DPVvOp924QSQqdZAWO7PU7Uhc8xv8xYCOZBZUq8+4RGwUWnbQAMbbwODj5GUK+JTGV47lV1vxg2yWYppKkpVY6tZsXQW+dY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754790905; c=relaxed/simple;
	bh=4g+DYYNv3dClYctwdX9K1etApbzEsHXlDB1CnOrMfK0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NKEH9KqQ9vL3m/I2mzMvEsA8Ou9Gjht1UuqDMiNyQYqiyubdrYaqHMwF94NQWEXxzAMBUK5WTFhHs1s9h2NZbPtTc4xgApJuhAuHt0UVnKkR4Uoh6tg/2XMHXQJxAW8LIBexMzuGegYcYCdS86Nl6iBdOTfYs3IExz24Muabnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88177c70d63so354625739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 18:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754790902; x=1755395702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbxBDLARe4VkO906rDCMfTV0uNgBLuvLj77IDTd8/ho=;
        b=un7nNWuKogI0dbHk/UdhW1Ysh7HLKb00jbruvFBGz6hEMBrkEjdS5KdMOR6/aunTd/
         kOfk3Qqz764hFAAWGd1ss+f0VrSPS7OfI2kZpyCsqvQJovmSYvM5fDXnFHQbQsQWokSi
         DOe0nxTPmgW+5bFi81tus2yKosRCq0Zqtezj4m/2y0veG1sqGwuE0KF51+TEV1ROm5V3
         a/J9T88b1SQm+rDe1Zg+MDVYI5EmIzy/9b2o4zfjrv8pbe2RjjbxCf5ssPupwY22WxMX
         ISOSbHs56WyGPtwUwSKS1j+SUFOkBzSc7GIgogHxGkMMiACDqxKLoICAXWvUDePHzt+9
         6GRg==
X-Forwarded-Encrypted: i=1; AJvYcCXz6dE0PzOO4iwh63RW8hwxacIdQkLjB+6NUnEHfsYvx0bUZ24BC9j/6B91kEF/MsL+UarlMI5coAIJmoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWX/1mVskARRP0h2+dm7w97vHv/SnDAYTA69N2ApshLCLAjz1b
	vZ5+tSR7An6EsSL/Z6b0WNWrqitm3LdsOmX6oTjADBlSQ7UvH0GqtCSjP1rqbzi9Ar/mKiR3tif
	voqdKDFu3oCQYRXQt1ubHMcQD1Hr94xoOm4BoQNwCotEsiNCR9v3R0YhnB8Y=
X-Google-Smtp-Source: AGHT+IHIuN7qUsMP86x2VKZjULaBh7wkoirrYbgBxwnMyVJUmf7oqT6f2jRoeMA4TQm/H0ujwyHO6bWCqAYBForF7STF3/GdKcBG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d83:b0:881:72ca:57f with SMTP id
 ca18e2360f4ac-883f1251bebmr1295983639f.10.1754790902318; Sat, 09 Aug 2025
 18:55:02 -0700 (PDT)
Date: Sat, 09 Aug 2025 18:55:02 -0700
In-Reply-To: <20250810013557.4116-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6897fbf6.050a0220.51d73.0084.GAE@google.com>
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
WARNING: CPU: 0 PID: 6686 at mm/rmap.c:2453 try_to_migrate_one+0xf99/0x3540 mm/rmap.c:2452
Modules linked in:
CPU: 0 UID: 0 PID: 6686 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-12256-g561c80369df0-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:try_to_migrate_one+0xf99/0x3540 mm/rmap.c:2452
Code: 00 e8 cb 3f ae ff 49 be 00 00 00 00 00 fc ff df e9 f2 f7 ff ff e8 b7 3f ae ff 4c 89 ff 48 c7 c6 00 79 96 8b e8 08 90 16 ff 90 <0f> 0b 90 e9 52 ff ff ff e8 9a 3f ae ff 49 ff cf e9 bb f8 ff ff e8
RSP: 0018:ffffc90003ddf120 EFLAGS: 00010246
RAX: 9446046ff81e8900 RBX: 0400000000000000 RCX: 9446046ff81e8900
RDX: 0000000000000003 RSI: ffffffff8dba5fb3 RDI: ffff88805cd51e00
RBP: ffffc90003ddf370 R08: ffffc90003ddeae7 R09: 1ffff920007bbd5c
R10: dffffc0000000000 R11: fffff520007bbd5d R12: ffffea0001988018
R13: 0000000066203867 R14: dffffc0000000000 R15: ffffea0001988000
FS:  00007fe5b6a1b6c0(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000012c0 CR3: 000000005c8a8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rmap_walk_anon+0x550/0x730 mm/rmap.c:2843
 rmap_walk_locked mm/rmap.c:2959 [inline]
 try_to_migrate+0x3f5/0x670 mm/rmap.c:2620
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
RIP: 0033:0x7fe5b5b8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe5b6a1b038 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007fe5b5db5fa0 RCX: 00007fe5b5b8ebe9
RDX: 0000000000000001 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007fe5b5c11e19 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe5b5db6038 R14: 00007fe5b5db5fa0 R15: 00007ffc7a58f7a8
 </TASK>


Tested on:

commit:         561c8036 Merge tag 'tty-6.16-rc1-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167fd434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cefea2580000


