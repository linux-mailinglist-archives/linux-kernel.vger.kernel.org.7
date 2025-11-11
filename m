Return-Path: <linux-kernel+bounces-894532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FF1C4B3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58783A7C97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D232D0EE;
	Tue, 11 Nov 2025 02:52:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C6230264
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829525; cv=none; b=OsnfEQYMLc2NixibYhSHzdoXXLkxdY51LYasOYfM83o/4vO5TKZVgzxicJjbAyaxnFe/RzZN7pqP4DoyRBuMY7WiF+ujtTxFPLtX4Jfs60S8VO36kZGVzcx9Tg+paXFEaMW/XVB8eAuyA6KXpD3A8unuqoJ/6QR6p/+mzjH6jEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829525; c=relaxed/simple;
	bh=JsmFPx5bRGTzZ+R3klWmLgI/Jmndjq2glcwL1bwuPUk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EpI4LxdbOGN9EqKDlSH7e5UxAaCtKM00+aTLRyRwpkfgO7XeX6ek+FHEif3FZ8yFjgp9GbarOIa4Lpxe3LbwRGwQsKnvZfC/sNpvponcXmj4Yt6yqzNtHabglz06GvZmK8+cexyZbBo+QR6gP7GGpj1+QyALWW/OlIxvcxKQVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433692f7479so54096145ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762829522; x=1763434322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0v1oofwrV7UCbXxxcW8jKkzRKMftBkr3pzwpkvblzao=;
        b=wsK1kpoGrtcL60ap0JDk6DzE0lZ4xZpwuuKJfMWtQURhjOmKCCZSpUxW/krD/82jPe
         fGgjIzkrWCQ5mLppFCvP5WAMZ7/hP3RUVqPrm1Ef6qcK5QZ/XuScFO+bgNiBoNV/xDzD
         wJ97soG4o4eFbQI0Hjngh0LPKp85rSgYjPH0ybRnM0Gif21+PgZkWGywYxQ8P1W9jO/K
         kHhjF6AxWOG6Zk7Pml5Tv5rLZvXN+V4prTMTqfe4aGbRkCRDsHSY0ilRsO2WJgM5Zb5B
         nywmNnNf3VniwCGp4uYhT7D8LU6Kx7migCjBK9YJTJsvvHXYHXhDbDTa91PD7pWjqJau
         iixA==
X-Forwarded-Encrypted: i=1; AJvYcCXneT02VFRSLgnthybApD3nfQsrVzUH4gsqN21SNYpxiQHT0iACT+Z526vsg7+pZraTvjS1EnTMbOT7XSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrFdkJ/LDH4UHOXPKe/EW03xWAO+7YhnBzBxP8ZeEKPc0t7TR
	WdrrR0+SW4tcLqZ3+ZncK8YxVGTfSAkIVAsiWsv3GhytAzhxWY0MQ/i5mpEEUGPCKVjxFnp6kb+
	bC+Wric7Zgt7i+dZBnLWqLjM1U4goKSZ4GYHExw5a4VLp1blkvUJr6UZ+PWA=
X-Google-Smtp-Source: AGHT+IG1HT4Nwt9uPiJNpa/WX5MC1LeCNH+o5OL7RG89afFffK3qVI84iRKMpZT1ohZU6FR3UiB1CTUJJQ2RMQw1VraRZJNmiaDf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c9:b0:433:74ec:e77b with SMTP id
 e9e14a558f8ab-43374ecea17mr134445345ab.4.1762829522616; Mon, 10 Nov 2025
 18:52:02 -0800 (PST)
Date: Mon, 10 Nov 2025 18:52:02 -0800
In-Reply-To: <CADfthj3aOC17CsRgB13PKvD6s4VFKNC1yUMVfkmdj2AZE+rTDw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912a4d2.a70a0220.22f260.011f.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ext4_dirty_folio

------------[ cut here ]------------
WARNING: CPU: 1 PID: 16600 at fs/ext4/inode.c:3964 ext4_dirty_folio+0x172/0x1b0 fs/ext4/inode.c:3964
Modules linked in:
CPU: 1 UID: 0 PID: 16600 Comm: syz-executor314 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ext4_dirty_folio+0x172/0x1b0 fs/ext4/inode.c:3964
Code: 74 7f 47 ff 4c 89 e7 48 89 de 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3f 2b d0 ff e8 5a 7f 47 ff 90 0f 0b 90 eb e0 e8 4f 7f 47 ff 90 <0f> 0b 90 eb a7 e8 44 7f 47 ff 48 89 df 48 c7 c6 60 a3 5e 8b e8 a5
RSP: 0018:ffffc9000489f368 EFLAGS: 00010293
RAX: ffffffff82782371 RBX: ffffea0001b6ce40 RCX: ffff888029725ac0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffffd400036d9c8 R08: ffffea0001b6ce47 R09: 1ffffd400036d9c8
R10: dffffc0000000000 R11: fffff9400036d9c9 R12: ffff888052670e48
R13: 1ffffd400036d9c9 R14: 0000000000000000 R15: ffffea0001b6ce48
FS:  0000000000000000(0000) GS:ffff88812646a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd1dfa7000 CR3: 0000000030d2d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 zap_present_folio_ptes mm/memory.c:1629 [inline]
 zap_present_ptes mm/memory.c:1709 [inline]
 do_zap_pte_range mm/memory.c:1810 [inline]
 zap_pte_range mm/memory.c:1854 [inline]
 zap_pmd_range mm/memory.c:1946 [inline]
 zap_pud_range mm/memory.c:1975 [inline]
 zap_p4d_range mm/memory.c:1996 [inline]
 unmap_page_range+0x17c9/0x4370 mm/memory.c:2017
 unmap_single_vma mm/memory.c:2060 [inline]
 unmap_vmas+0x399/0x580 mm/memory.c:2104
 exit_mmap+0x240/0xb40 mm/mmap.c:1280
 __mmput+0x118/0x430 kernel/fork.c:1133
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:954
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc152b11b89
Code: Unable to access opcode bytes at 0x7fc152b11b5f.
RSP: 002b:00007fc152aa4178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fc152b9a718 RCX: 00007fc152b11b89
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fc152b9a718
RBP: 00007fc152b9a710 R08: 00007fc152aa46c0 R09: 00007fc152aa46c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc152b9a71c
R13: 000000000000006e R14: 00007ffeb6196c60 R15: 00007ffeb6196d48
 </TASK>


Tested on:

commit:         4427259c Merge tag 'riscv-for-linus-6.18-rc6' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1506a7cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107cf17c580000


