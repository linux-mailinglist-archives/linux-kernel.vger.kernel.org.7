Return-Path: <linux-kernel+bounces-664101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F1AC51D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 17:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD94188A2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00D27A92B;
	Tue, 27 May 2025 15:15:36 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C094C81
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358936; cv=none; b=BbzyhSHK71gu+UhRdvyTJQqerKNYHoRRzaEM46Aes7nJmJB5SiB3gZUD0h5XNYjSKnEH7pHNOPLSAKBmveej4bxykTs+FXZ8XhSxYT6QhkWfBnXviCmXtWebnVr5TDN6UAlhK9mTK2vdoSQpj6XspGx2kxRnMZD93KYNyp4oQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358936; c=relaxed/simple;
	bh=0klOcVmBdm8coIk8HQ2/LTo+Ds76YjXc1MvEi87Epbs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S6jshZtvV2nk344SXTJm+mNfqY2Hje/cdrK17WZltGnMp3pd13LtlaqvXAv1H1MhNh4qwFs2B/L/SJq6VV06tdxsPxsVveXimUuEVRtVZk36l5Eoxz7f//PWCl/Zbplp2CVrZErc+s3E3/geUprO3AvPmFB38nDdvuVLlIusn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86186c58c41so289717939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 08:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748358934; x=1748963734;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjupqyDk3VveA8Ay8G+TINfkms4q7S2h0ALxAs4KCKc=;
        b=gEM3an3BQpBnMSEMn19wJXEMAqBkx5WHsHAkg5RxyD9eldcTGgiePOtyyvn+NRubJO
         KXKeFA7BCyCa1y0FRFFfBXLgt+eYxE5NBK6EscYKbAaxwCR/Q4mvY4CGYMxgD5amvYuU
         myQ8FiHqD3UyJonOi0vWnUZBIb+/43SV5DvsIANNfLMwHqOs9MYGHvvVaJMKgI3wG6W5
         N4QeGxCKGFpv73pITEXRs+wOvUpVAenPjVDKau8b4fFYTXDEfozmGnx+YudAZRKNI/Cy
         TfPDD93zScGtfiZJNUYxxAy5Jn8GIycD99gVanV7vDorv1c/K86o01jJzYxsQruveb7L
         XPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVLaLI81VblqI9UOTCFTCMcVFutr3tjfCTbtI4pRkasoBkEkkiBWAxjnP1Eafmin2EEEzbE8jFpf4S/3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJhuDcLKVoCNsyS5ma3+gZGWZd2FE6Dq0Y86+2nmploOeVutMo
	0SpJUfK9nsa8HOIiiQPUro8lWsw28OkG5EJgx3iXQEZjSWwrUEdnACG5PzInw1WmLgaSVDyghs+
	PEbJ61rq3jgoNgPm6iyIJBOVCCjqxIcvoBhXv72ueTalLLloiZQ0XQbk4LKE=
X-Google-Smtp-Source: AGHT+IGEavW3ATzA8ZPf9gkKivqBFYQbo0RqoJn9dZGyTDDeQZoKMcVvdPFiYqkoWBZb1eAKmtGA/XdpLw21vNCN7dtTEncBqNS+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3e98:b0:86a:235c:15f8 with SMTP id
 ca18e2360f4ac-86cbb6c78d0mr1673871339f.0.1748358933694; Tue, 27 May 2025
 08:15:33 -0700 (PDT)
Date: Tue, 27 May 2025 08:15:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6835d715.a70a0220.253bc2.00ba.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in __bch2_bkey_unpack_key
From: syzbot <syzbot+d78b3c996e2381acd902@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ddddf9d64f73 Merge tag 'perf-core-2025-05-25' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bebdf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd18a1001092f95b
dashboard link: https://syzkaller.appspot.com/bug?extid=d78b3c996e2381acd902
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140426d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16baadf4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ddddf9d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc551d1d4e46/vmlinux-ddddf9d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d26a6de23b0e/bzImage-ddddf9d6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b7eba007e6cf/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d78b3c996e2381acd902@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/bkey.c:272!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5306 Comm: read_btree_node Not tainted 6.15.0-syzkaller-01599-gddddf9d64f73 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__bch2_bkey_unpack_key+0xdeb/0xe10 fs/bcachefs/bkey.c:272
Code: b2 da 00 e9 f3 f9 ff ff e8 a2 10 aa fd 48 c7 c7 a0 7b 55 8e 48 89 ee 4c 89 f2 e8 20 b2 da 00 e9 2e fb ff ff e8 86 10 aa fd 90 <0f> 0b e8 7e 10 aa fd 90 0f 0b e8 76 10 aa fd 90 0f 0b e8 6e 10 aa
RSP: 0018:ffffc9000d3e6ab8 EFLAGS: 00010293
RAX: ffffffff841519da RBX: 0000000000000003 RCX: ffff888000ad8000
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000006
RBP: 0000000000000005 R08: ffffc9000d3e6d4f R09: 0000000000000000
R10: ffffc9000d3e6d30 R11: fffff52001a7cdaa R12: ffffc9000d3e6d30
R13: ffff888046dc1028 R14: ffff88803ee140c1 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808d6b1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ce47cf57d0 CR3: 0000000011f33000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bch2_bkey_compat+0x4db/0xbd0 fs/bcachefs/bkey_methods.c:480
 bch2_bkey_compat fs/bcachefs/bkey_methods.h:134 [inline]
 validate_bset_keys+0x6c1/0x1390 fs/bcachefs/btree_io.c:983
 bch2_btree_node_read_done+0x18c8/0x4f60 fs/bcachefs/btree_io.c:1211
 btree_node_read_work+0x426/0xe30 fs/bcachefs/btree_io.c:1400
 bch2_btree_node_read+0x887/0x29f0 fs/bcachefs/btree_io.c:-1
 bch2_btree_node_fill+0xd12/0x14f0 fs/bcachefs/btree_cache.c:994
 bch2_btree_node_get_noiter+0xa2c/0x1000 fs/bcachefs/btree_cache.c:1261
 found_btree_node_is_readable fs/bcachefs/btree_node_scan.c:85 [inline]
 try_read_btree_node fs/bcachefs/btree_node_scan.c:220 [inline]
 read_btree_nodes_worker+0x1319/0x1e20 fs/bcachefs/btree_node_scan.c:269
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bch2_bkey_unpack_key+0xdeb/0xe10 fs/bcachefs/bkey.c:272
Code: b2 da 00 e9 f3 f9 ff ff e8 a2 10 aa fd 48 c7 c7 a0 7b 55 8e 48 89 ee 4c 89 f2 e8 20 b2 da 00 e9 2e fb ff ff e8 86 10 aa fd 90 <0f> 0b e8 7e 10 aa fd 90 0f 0b e8 76 10 aa fd 90 0f 0b e8 6e 10 aa
RSP: 0018:ffffc9000d3e6ab8 EFLAGS: 00010293
RAX: ffffffff841519da RBX: 0000000000000003 RCX: ffff888000ad8000
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000006
RBP: 0000000000000005 R08: ffffc9000d3e6d4f R09: 0000000000000000
R10: ffffc9000d3e6d30 R11: fffff52001a7cdaa R12: ffffc9000d3e6d30
R13: ffff888046dc1028 R14: ffff88803ee140c1 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808d6b1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ce47cf57d0 CR3: 000000003f92f000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

