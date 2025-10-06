Return-Path: <linux-kernel+bounces-843043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB60BBBE495
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F99C3B99F9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9FC2D480F;
	Mon,  6 Oct 2025 14:10:34 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D21B5EC8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759833; cv=none; b=jmuxVIyQ+PcYzTRVWaOFG7D2FJKvxdjnHsIjQJvzSvUsyFmgYw1oJLDXNjWFPfqqGaBEeiuPCqYmOTpeJd9K/2MW2vbil0J88UgqTO9gwSp3ORAKk12nGvm8sMdmvL9TB1S06hVYGS7VoTHSvJ+JCaGbdGBBSEVptwu16V093Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759833; c=relaxed/simple;
	bh=rHh8rFyaVv9BgcPlqmMwESfOSSluDMke8GaIK2QXtgI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FQDlCJ8J2FJ7ukfvKAPBWm0T/u1vbcolOR29Y0GbxthZpaVevAPArdlNMnxD+M+II7EzMhnE6KcnTtn12dWqK301TUojFdV/+Wd2kAjSacM7/xicYt87N8Csh9YySurFFFeGB3bDBM93DEzD1+X2OX1JzdXiG7dsGBqIkgyuU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42f63bf6387so67795445ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759831; x=1760364631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwjzkJ160sD+DlJCkji9uVcuXgvmehtyE1uZWuxgyZ4=;
        b=o4OzbIP2vv7ObjDnX8IcooVbZqtX722UeMOLZuDMjBvITfLWcxvbY4bgZewo8V5A6y
         RgOOhBAYAcBiUNmQrFMaTuFd+SilZ1NkrPAJXxWjVIRnB3I2sM0JZS0IocS1SjXBPueS
         uQ6x2Hvf27xJEvh0PWY7l64rkqclI93KpIu2FYdxOpHvw13N/DmbyMoeefbPuXxO6K7+
         iVBPjPtJrljEDC0dwugipjZe0+w5D0XwgGStZ/zXrvKn+QfO+DqFL9k6PBdxDlnsMpeT
         8wFvB2fCRMxHiN3W7JJyHeFxigR4hB9VcikKVsnV9bNst9F+smOORP4kgPRy62vUOT1u
         V+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9bzyjfOurTyuy8AT2aWv1hQED0P5RVOTS4fsA7eySYQ1i9Ipxv3A9ivK9c1XC4Wi4irkqu5/kSV2ejw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12o9v54oCyOpE8rCI25wGZnCjuqUcIYqN/zDIwte1rBbbFpGR
	tb+uQI9UmvPjAPRuL4df6bvHYtrQp0QhAqenZas0XDH3AHb60pMmJf8ktkNiVdcvhJTxmArEW3c
	wF6tW/UxTEP1084Wrq5Kc9CZ3z5KEOR0FjP/eNn4mS1u4tNsozlM2Vd3xBmQ=
X-Google-Smtp-Source: AGHT+IGm0eIv24hz/zlDzqj0kJrSq5C4onbZ3P4ubt50mfZ5GJhsVyj9yZqVYGVHYSE96lIC8rty0OglBkK+KVnQw33/w+ceYrK3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a29:b0:427:8024:750e with SMTP id
 e9e14a558f8ab-42e7ad8401emr173160865ab.20.1759759831140; Mon, 06 Oct 2025
 07:10:31 -0700 (PDT)
Date: Mon, 06 Oct 2025 07:10:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3cdd7.a00a0220.2a5ca.000b.GAE@google.com>
Subject: [syzbot] [afs?] WARNING in delete_node (4)
From: syzbot <syzbot+34813cbce633c9091556@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7f7072574127 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c55942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8582d1234819ed79
dashboard link: https://syzkaller.appspot.com/bug?extid=34813cbce633c9091556
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-7f707257.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e0a26398b43/vmlinux-7f707257.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44d1286a1f5d/bzImage-7f707257.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34813cbce633c9091556@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 33 at lib/radix-tree.c:572 delete_node+0x223/0x8d0 lib/radix-tree.c:572
Modules linked in:
CPU: 3 UID: 0 PID: 33 Comm: ksoftirqd/3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:delete_node+0x223/0x8d0 lib/radix-tree.c:572
Code: 66 58 f6 41 bc 01 00 00 00 e8 49 ea 71 f6 44 89 e0 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 2e ea 71 f6 90 <0f> 0b 90 e8 25 ea 71 f6 48 c7 c6 90 88 48 8b 4c 89 e7 e8 a6 66 58
RSP: 0018:ffffc900005bfac0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88802aec6160 RCX: ffffffff8b489df3
RDX: ffff88801bbea480 RSI: ffffffff8b489e82 RDI: ffff88802aec61a8
RBP: ffff888025afc000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000002b71 R12: ffff888025afc018
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000004000004
FS:  0000000000000000(0000) GS:ffff888097f66000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000008001b000 CR3: 000000005e8cd000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __radix_tree_delete+0x193/0x3d0 lib/radix-tree.c:1379
 radix_tree_delete_item+0xea/0x230 lib/radix-tree.c:1430
 afs_cell_destroy+0x1db/0x310 fs/afs/cell.c:523
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x799/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1063 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:1055
 smpboot_thread_fn+0x3f4/0xae0 kernel/smpboot.c:160
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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

