Return-Path: <linux-kernel+bounces-761301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 520CBB1F831
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 04:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649F81896941
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 02:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3E7191493;
	Sun, 10 Aug 2025 02:56:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD113790B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754794565; cv=none; b=Z40QIkwgknFI7YPJSWQ1lVM/q3dk+z8DQzj6wBVnsJWdo2RBje3BNs0ErSCSNQ7Vo/PLKo7OIZuAecrpXf/5J0ZVXdmEhp1WaTb+qt1acGJqDZKyr7Sm9rsa7pKG5aXoyS2QacHgymQuUajUv7ZbK7JOR/wM3dQRfFWoWQNwVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754794565; c=relaxed/simple;
	bh=GDK4rR9kipkAUgSxuFb0bTCk0jyjy9Y5iilq9iup3GE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CkV8gJtlLwqrYMGneMIY6SYJiFAlob21KIQ00CDHoQOibltWCNtYgIw6dnU7eBE6LOnkShehH/ayH+Tn/WrJxRioyzN3+gI4rAErhb4nlLHCQPNr7rmZn4IzzLJnPzPdjo+R2jOBwq1qmqb2915+sW2YhnsxM68JHYP4lN5jc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8818b1512c2so313178739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 19:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754794563; x=1755399363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCE12Imvi84JX5F1OBqoUKUrxAuzFmBcO5au4Z5/j6s=;
        b=hRc24itoSZEG8On7o3owQ90RhsXd/KNP3ObGLTH/hwqQ/4pvjbu3M2TUvUnevQMp5Z
         1LhOsLokSHfW9IikyROML+apW1C+q5GnLqrPWfOH5cHQtgQ1nAi1ta5MBYqQbYjRCitd
         +RSRHWvaYxDAx0e++4Gno4Hv9IKipjLn1Md9aaWHJ3rJ01VhXnSpOXzTNq6gXBYPve2w
         DAXdsjiHY+oYDZYKe3Uq/ZyI6nR1yKp+FbJ2qwCdGILCXINgUli+wH1HWYbLNypB6L69
         8RAO0bhWBdsjE5ZOEl6ahnn6tCvMwk7uvBwhi0LVYfNYWgp4yD8NqRlTR3AJoJ7FovDS
         t+dA==
X-Forwarded-Encrypted: i=1; AJvYcCVN4s9V8mwEN8ePP81oNEfCpfjpnPcH1VIYTm1trE6EcsZxzehasWTY419m9M3HrAxgSCpjULqkEwkprHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxahYUfKReQnrelNgslq4AqtLVQCw118GThOpwc7cn7VXudwqkj
	rSsLiUVn8Y/bT/pSNwxSccne/deByWBAZXWpjgFVVCRMCA/s4SjOvrWe5CCNbXQxj5/jzCJB8H8
	pouFCkX3O/nOcrYOvLf19ICprpeEpjowA3WPD6SzPYAqAEHtQieOofhF8lqM=
X-Google-Smtp-Source: AGHT+IEPB0P7VUg+AXZKhTmpLtTLNykT1PDPHzcXJiMvR6c3994UgNE9G0Mr31F3k6fAhC86S/DPT1pZR3Rtq9nKlUduKo5GBPoH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:f:b0:881:87ac:24a with SMTP id
 ca18e2360f4ac-883f12042acmr1068712439f.7.1754794563469; Sat, 09 Aug 2025
 19:56:03 -0700 (PDT)
Date: Sat, 09 Aug 2025 19:56:03 -0700
In-Reply-To: <20250810020217.4151-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68980a43.050a0220.7f033.00b6.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (3)
From: syzbot <syzbot+63859a31071a369082b1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in try_to_migrate_one

 folios_put include/linux/mm.h:1419 [inline]
 folio_batch_move_lru+0x319/0x3a0 mm/swap.c:175
 __folio_batch_add_and_move+0x5ad/0xd20 mm/swap.c:196
 map_anon_folio_pmd+0x1c9/0x5a0 mm/huge_memory.c:1208
 __do_huge_pmd_anonymous_page mm/huge_memory.c:1253 [inline]
 do_huge_pmd_anonymous_page+0x518/0xb60 mm/huge_memory.c:1371
 create_huge_pmd mm/memory.c:5917 [inline]
 __handle_mm_fault+0x1139/0x5440 mm/memory.c:6166
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6632 at mm/rmap.c:2453 try_to_migrate_one+0xf99/0x3540 mm/rmap.c:2452
Modules linked in:
CPU: 0 UID: 0 PID: 6632 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-12256-g561c80369df0-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:try_to_migrate_one+0xf99/0x3540 mm/rmap.c:2452
Code: 00 e8 cb 3f ae ff 49 be 00 00 00 00 00 fc ff df e9 f2 f7 ff ff e8 b7 3f ae ff 4c 89 ff 48 c7 c6 00 79 96 8b e8 08 90 16 ff 90 <0f> 0b 90 e9 52 ff ff ff e8 9a 3f ae ff 49 ff cf e9 bb f8 ff ff e8
RSP: 0018:ffffc900034f7360 EFLAGS: 00010246
RAX: ac960e1a3b7e2b00 RBX: 0400000000000000 RCX: ac960e1a3b7e2b00
RDX: 0000000000000003 RSI: ffffffff8dba5fb3 RDI: ffff888029dd9e00
RBP: ffffc900034f75b0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: ffffea0001c1c198
R13: 0000000070706867 R14: dffffc0000000000 R15: ffffea0001c1c180
FS:  00007fbdca6816c0(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000012c0 CR3: 000000002d9e6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rmap_walk_anon+0x550/0x730 mm/rmap.c:2843
 rmap_walk mm/rmap.c:2948 [inline]
 try_to_migrate+0x3bc/0x670 mm/rmap.c:2622
 migrate_folio_unmap mm/migrate.c:1302 [inline]
 migrate_pages_batch+0x116f/0x3620 mm/migrate.c:1851
 migrate_pages_sync mm/migrate.c:1974 [inline]
 migrate_pages+0x1bcc/0x2930 mm/migrate.c:2083
 do_mbind mm/mempolicy.c:1539 [inline]
 kernel_mbind mm/mempolicy.c:1682 [inline]
 __do_sys_mbind mm/mempolicy.c:1756 [inline]
 __se_sys_mbind+0xa3e/0xc30 mm/mempolicy.c:1752
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdc978ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbdca681038 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007fbdc99b5fa0 RCX: 00007fbdc978ebe9
RDX: 0000000000000001 RSI: 0000000000600000 RDI: 0000200000000000
RBP: 00007fbdc9811e19 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbdc99b6038 R14: 00007fbdc99b5fa0 R15: 00007ffd9d17a4b8
 </TASK>


Tested on:

commit:         561c8036 Merge tag 'tty-6.16-rc1-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1109fea2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15403434580000


