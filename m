Return-Path: <linux-kernel+bounces-670175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4ECACAA19
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 09:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A247A7715
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B781ADC7B;
	Mon,  2 Jun 2025 07:51:31 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48DB5BAF0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748850691; cv=none; b=QeuZ3lIgGtiOAm3BeEkkhILp0HYC0gcxf6Le2xmCfxeJjEl7Xs2ZeXElCzuAfqlpS3SeHQ/iijCf4XLttCKYPu3a3YY3z8jH1/QSDrD8zqmMWhwBRxcgTYhaoyFAIy4swZ/2LJFwiLVFGkaZm5qJwJtaMsAwHoDR5aX8AhNVlIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748850691; c=relaxed/simple;
	bh=UMDcY/x4ajMZTj8Zj5dlLrfxjw6rIfqkylsXXmgVS4Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KUfEDAQrlM8obfwkPQ8BzcqVSPr96bSyxtxd6BVwBDkwS8/m0qpkIBbx9/0+Z8KSdseUwYJS8CVlmDw3JuMRoJC42vmEhBSoHSA0in0bCljijUjLx6vIWu//Aa0A1t4IKxi5eaAmCRbwjPHLptSCy0sfROj/CE9hyeu9RG1/P10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3dd75379fa0so88020855ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 00:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748850689; x=1749455489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVum76WYJkhxbVFuUvobx6OTlGIJVf1bF6Wj6/N6lf0=;
        b=UdllbpHZTVgLtUaBaoYLmjfBJKfYrHNMGaa5v+BTfOrMgrbVyykLm4rV2FLX5i5Cfg
         bGwftToACNY9+n2RmEPBjDpygPwPAW8z0J+tYoq9gvHC3Fh6L3JKdBSAHvV9zPDKEAcy
         bGHWQmv2EdJRoaUnx+9uEQ+hkaUeO5p6diRSA6phJiA5dwuM/1KE8lK/Cwgmzcprc4hm
         E8SV6v5DiFoUhY97mJA+K4qmIUfNFWa0lh8gsvOFxnsiepPl2dWKBLb3dfyheKe3C11g
         0q9Ox48iwXFEQFAZXg92iV8c0iJ+1o4RUZO9owiiNU0+RqYxfaE3I9hZiRapH8Ewlb0n
         XPZg==
X-Forwarded-Encrypted: i=1; AJvYcCVlEn9ajB78yzSuRFJwEWCWl8R87nfh6G2I/0LkPzgHHPMg4VDrOSdidqpnQgDiE+a4G6nrfm6/4Pb3orM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlMQV1vcTGpXmx++oOYSPyz8QyGGPBnRbQTk/hURX8pZbWLRRU
	6hGX5MWVvyhcodwuO7k5AuZU5uIEQZcQFmBd1zoC+v5Hyj8rbc7bQlPe/dHUnNKNvlC4kaKHoKN
	s2FsKQiBvkYqJMg9uNtC405/ga/O0MGkgvban6ehNVkwGRA9i9y+OKd13Ohc=
X-Google-Smtp-Source: AGHT+IE2p59FpzEqb3SSgA25S8jo+QkgwR4WUQRGWvPhq7+XLJvwPqNSCBMA/qASAiTtWRzRPK1uYLYshWuWyol+cTziyXFLnMOj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:3dd:89d0:3d82 with SMTP id
 e9e14a558f8ab-3dd99c2875bmr130513095ab.16.1748850688863; Mon, 02 Jun 2025
 00:51:28 -0700 (PDT)
Date: Mon, 02 Jun 2025 00:51:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683d5800.a00a0220.d8eae.0047.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_bkey_cmp_packed (2)
From: syzbot <syzbot+00644eb66b865d7db7f0@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90b83efa6701 Merge tag 'bpf-next-6.16' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122807f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=262b2977ef00756b
dashboard link: https://syzkaller.appspot.com/bug?extid=00644eb66b865d7db7f0
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162807f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bedbf4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-90b83efa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09e54f3c33aa/vmlinux-90b83efa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6417d9c45508/bzImage-90b83efa.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/424513942ae2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00644eb66b865d7db7f0@syzkaller.appspotmail.com

    bi_nocow=0
    bi_depth=0
    bi_inodes_32bit=0
    bi_casefold=0
  nonzero k.p.inode, deleting
------------[ cut here ]------------
kernel BUG at fs/bcachefs/bkey_cmp.h:104!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5322 Comm: read_btree_node Not tainted 6.15.0-syzkaller-07774-g90b83efa6701 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__bch2_bkey_cmp_packed_format_checked_inlined fs/bcachefs/bkey_cmp.h:103 [inline]
RIP: 0010:bch2_bkey_cmp_packed_inlined fs/bcachefs/bkey_cmp.h:116 [inline]
RIP: 0010:bch2_bkey_cmp_packed+0x941/0x950 fs/bcachefs/bkey.c:1031
Code: fd 90 0f 0b e8 f0 67 a5 fd 90 0f 0b e8 e8 67 a5 fd 90 0f 0b e8 e0 67 a5 fd 90 0f 0b e8 d8 67 a5 fd 90 0f 0b e8 d0 67 a5 fd 90 <0f> 0b e8 c8 67 a5 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d46ebe0 EFLAGS: 00010293
RAX: ffffffff841a9320 RBX: dffffc0000000000 RCX: ffff88801c99c880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000ffffffff
RBP: ffffc9000d46ed30 R08: ffffc9000d46ec3b R09: 0000000000000000
R10: ffffc9000d46ec30 R11: fffff52001a8dd88 R12: 00000000ffffffff
R13: 1ffff92001a8dd8c R14: 00000000ffffffff R15: 0000000800001000
FS:  0000000000000000(0000) GS:ffff88808d266000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe172b0da8 CR3: 0000000039110000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btree_node_read_bkey_cmp fs/bcachefs/btree_io.c:935 [inline]
 validate_bset_keys+0xb9c/0x1390 fs/bcachefs/btree_io.c:1000
 bch2_btree_node_read_done+0x18c8/0x4f60 fs/bcachefs/btree_io.c:1211
 btree_node_read_work+0x426/0xe30 fs/bcachefs/btree_io.c:1400
 bch2_btree_node_read+0x887/0x29f0 fs/bcachefs/btree_io.c:-1
 bch2_btree_node_fill+0xd12/0x14f0 fs/bcachefs/btree_cache.c:994
 bch2_btree_node_get_noiter+0xa2c/0x1000 fs/bcachefs/btree_cache.c:1261
 found_btree_node_is_readable fs/bcachefs/btree_node_scan.c:85 [inline]
 try_read_btree_node fs/bcachefs/btree_node_scan.c:220 [inline]
 read_btree_nodes_worker+0x1319/0x1e20 fs/bcachefs/btree_node_scan.c:269
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bch2_bkey_cmp_packed_format_checked_inlined fs/bcachefs/bkey_cmp.h:103 [inline]
RIP: 0010:bch2_bkey_cmp_packed_inlined fs/bcachefs/bkey_cmp.h:116 [inline]
RIP: 0010:bch2_bkey_cmp_packed+0x941/0x950 fs/bcachefs/bkey.c:1031
Code: fd 90 0f 0b e8 f0 67 a5 fd 90 0f 0b e8 e8 67 a5 fd 90 0f 0b e8 e0 67 a5 fd 90 0f 0b e8 d8 67 a5 fd 90 0f 0b e8 d0 67 a5 fd 90 <0f> 0b e8 c8 67 a5 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000d46ebe0 EFLAGS: 00010293
RAX: ffffffff841a9320 RBX: dffffc0000000000 RCX: ffff88801c99c880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000ffffffff
RBP: ffffc9000d46ed30 R08: ffffc9000d46ec3b R09: 0000000000000000
R10: ffffc9000d46ec30 R11: fffff52001a8dd88 R12: 00000000ffffffff
R13: 1ffff92001a8dd8c R14: 00000000ffffffff R15: 0000000800001000
FS:  0000000000000000(0000) GS:ffff88808d266000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe172b0da8 CR3: 0000000039110000 CR4: 0000000000352ef0
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

