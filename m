Return-Path: <linux-kernel+bounces-757341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D2B1C103
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE153BF636
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A45A2185AA;
	Wed,  6 Aug 2025 07:10:33 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD51217704
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464232; cv=none; b=gfV7yVFe8Be4fcttAaNetoTWVCAmbu2f92yn0nXZtLIDDz0VAP58OMGLmRzCSV7vYy87K53qamuPkSeJsZsnznsB/kidZeqmSHtYipCq3egY6bIltlRM3VpnYcwNn0MoM9Awz0GoPSVN8gEXCdu0mY4lKrR9RezahRabwU84Cj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464232; c=relaxed/simple;
	bh=yUXp9RbYYMvAi4aYBqaN/Y2uH8tUrWetLfNJUkte98I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q4lsBEbzvqkGBgQedpgDjdLZx8P/o518VDwAaQ/+6ahrE2uj9N5Cxmnj+8dPITNWvSRYGL1VDEqpchRvI34EiimkII3USelqutrhHVesBeR4L4ROzOwLXYecAB4kNTtP2P/HijXRPvWVqikP7FrFbMcOvF+uPTiVT6CQgfCR0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88193cfd368so306328039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754464230; x=1755069030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kin3gMriSKVRww+UkHVI/MEOxcjSahtIRjKoHJ1LHvk=;
        b=Zf6N4uF53KHO5tTzxVC7suYudPGjMTl2BO9tCoxP311NVye+4K/wbvFFyh16CPb4sq
         Aas//+BPIbqGyEZFhrQVrgcwgILahhCj3ARMfIqJIcXdu6+TCjTx33GQTYI1omMaispo
         KB/qr+lKy6Kp1xl+LYE096yu1m0c28veCayO+6lefjo4gIFqUVSOnuZOw0FdbmHVg3Sx
         QCCYFiYAUmSth2wbLWVSlYo8R4TLerjl1hr5ApkU6V5KBmYnmE+lzevgDN1P9EvxeW/l
         yWX+2HcCe+nzNVvlmFcdxx1oGV5A2khFpyijlET9l+rqbzemvi1OAQpXtXi2wWo6ac8H
         99PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+rWcjDgsO9bXaSKU6PK0FXRY9CursQw+JF2YOPtQajpv+2eaHVgKX/2JOE2J0h4LJWt0cA6L0iJ1k3yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEhxbEkB8/B6jipDmjZv3y7DtJF6gXQ0FGxA5kqUWeUfe7SzkH
	b8MI4jqjq0C/4Qw6BWt+yZuf01h5UBjzMIRTpHHJmWmmn4OeGThkGEqXiNZPPq2tkq4ZKLwvyKx
	Ny8lGFDynIdIKtFA8w6LWDySdsWwVwV1V9tcIZxvnRyC7SJJmEHrnXDHzqQk=
X-Google-Smtp-Source: AGHT+IGiY0SG7lUZ/g8z97ZDwF7VuX62DwfUi8lBBh+9ImWnlvov1U8Yb42fl7nP9zVvVvJmAesNffh8P85xucWrQAaZnPQitBSD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fd3:b0:881:9412:c917 with SMTP id
 ca18e2360f4ac-8819eda4411mr386020939f.0.1754464230257; Wed, 06 Aug 2025
 00:10:30 -0700 (PDT)
Date: Wed, 06 Aug 2025 00:10:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6892ffe6.050a0220.7f033.0039.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_journal_pin_set (2)
From: syzbot <syzbot+240906f6485cdb6035a7@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a6923c06a3b2 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128df2a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbdefbf39cb79f7e
dashboard link: https://syzkaller.appspot.com/bug?extid=240906f6485cdb6035a7
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a6923c06.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c2b6f269429/vmlinux-a6923c06.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32390e35232b/bzImage-a6923c06.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+240906f6485cdb6035a7@syzkaller.appspotmail.com

bcachefs (loop0): backpointer doesn't match extent it points to:
  u64s 9 type backpointer 0:8921088:0 len 0 ver 0: bucket=0:34:8 btree=extents level=0 data_type=user suboffset=0 len=8 gen=0 pos=536870913:24:U32_MAX
  u64s 7 type extent 536870913:24:U32_MAX len 24 ver 0: durability: 1 crc: c_size 8 size 24 offset 0 nonce 0 csum none 0:0  compress lz4 ptr: 0:34:8 gen 0
  u64s 9 type backpointer 0:8921088:0 len 0 ver 0: bucket=0:34:8 btree=extents level=0 data_type=user suboffset=0 len=8 gen=0 pos=536870913:24:U32_MAX, fixing
------------[ cut here ]------------
kernel BUG at fs/bcachefs/journal_reclaim.c:483!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5362 Comm: bch-copygc/loop Not tainted 6.16.0-syzkaller-11105-ga6923c06a3b2 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_journal_pin_set+0x5c1/0x5e0 fs/bcachefs/journal_reclaim.c:483
Code: 25 3d d8 fd e9 0c ff ff ff 44 89 e9 80 e1 07 38 c1 0f 8c 88 fb ff ff 4c 89 ef e8 fa 3d d8 fd e9 7b fb ff ff e8 e0 6b 73 fd 90 <0f> 0b e8 d8 6b 73 fd 90 0f 0b e8 d0 6b 73 fd 90 0f 0b 66 66 66 66
RSP: 0018:ffffc9000d4ae728 EFLAGS: 00010293
RAX: ffffffff844c42c0 RBX: 000000000000000c RCX: ffff88801fb60000
RDX: 0000000000000000 RSI: 000000000000000c RDI: 000000000000000b
RBP: ffff888052e846b8 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52001a95cd4 R12: ffff888052ecaa38
R13: ffff888052eca898 R14: ffff888052ec9800 R15: 000000000000000b
FS:  0000000000000000(0000) GS:ffff88808d21f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff022fdc9c CR3: 0000000011ba9000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 bch2_journal_pin_add fs/bcachefs/journal_reclaim.h:48 [inline]
 bch2_journal_keys_to_write_buffer_start+0x3bb/0x3c0 fs/bcachefs/btree_write_buffer.c:793
 bch2_journal_keys_to_write_buffer fs/bcachefs/btree_write_buffer.c:510 [inline]
 fetch_wb_keys_from_journal fs/bcachefs/btree_write_buffer.c:534 [inline]
 btree_write_buffer_flush_seq+0x222/0x1a40 fs/bcachefs/btree_write_buffer.c:563
 bch2_btree_write_buffer_flush_sync+0x143/0x2c0 fs/bcachefs/btree_write_buffer.c:598
 bch2_btree_write_buffer_maybe_flush+0x7e0/0x1400 fs/bcachefs/btree_write_buffer.c:673
 bch2_backpointers_maybe_flush fs/bcachefs/backpointers.c:200 [inline]
 backpointer_target_not_found+0x110/0xc10 fs/bcachefs/backpointers.c:220
 __bch2_backpointer_get_key+0x33a/0x490 fs/bcachefs/backpointers.c:352
 bch2_backpointer_get_key+0x3e/0x60 fs/bcachefs/backpointers.c:379
 __bch2_move_data_phys+0xf82/0x1c50 fs/bcachefs/move.c:942
 bch2_evacuate_bucket+0x228/0x3a0 fs/bcachefs/move.c:1082
 bch2_copygc+0x3be3/0x4510 fs/bcachefs/movinggc.c:234
 bch2_copygc_thread+0x97a/0xe00 fs/bcachefs/movinggc.c:409
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_journal_pin_set+0x5c1/0x5e0 fs/bcachefs/journal_reclaim.c:483
Code: 25 3d d8 fd e9 0c ff ff ff 44 89 e9 80 e1 07 38 c1 0f 8c 88 fb ff ff 4c 89 ef e8 fa 3d d8 fd e9 7b fb ff ff e8 e0 6b 73 fd 90 <0f> 0b e8 d8 6b 73 fd 90 0f 0b e8 d0 6b 73 fd 90 0f 0b 66 66 66 66
RSP: 0018:ffffc9000d4ae728 EFLAGS: 00010293
RAX: ffffffff844c42c0 RBX: 000000000000000c RCX: ffff88801fb60000
RDX: 0000000000000000 RSI: 000000000000000c RDI: 000000000000000b
RBP: ffff888052e846b8 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52001a95cd4 R12: ffff888052ecaa38
R13: ffff888052eca898 R14: ffff888052ec9800 R15: 000000000000000b
FS:  0000000000000000(0000) GS:ffff88808d21f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff022fdc9c CR3: 0000000011ba9000 CR4: 0000000000352ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

