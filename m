Return-Path: <linux-kernel+bounces-851457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F9ABD68B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4705A425BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99AF2FB0BD;
	Mon, 13 Oct 2025 21:57:30 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A33081C6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392650; cv=none; b=Ok+ilkK4B4EySKSBW789s36T94fWzRaRhIbQvj/T4PPWGBFmzTF0XptcFL9WKULgjNCrz9gR2mA/CTkDC0pBhlKnfmntwgx4iYdg5vmiL2qnDL1YYynYOvGlV62BQ5965ChWgq7yGaCoWUwEkEH9+kgk5v8JnonlyV7YW/f9fkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392650; c=relaxed/simple;
	bh=3HcdFoqrAi70Bfq224AGCh7faTRzJ2+saXmc+NpG5nI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Akdk4/MDRSz/lAKDpmuqC0MQ73VVzsYYuVAVL4Rx6ZyvDSQivbpSxDE1ykuPFMADKYy2rnzqYv3iZbCsasiGdHvEwrbLNnxzFbwNbumNNVG7pIbEOtW1HN9e4g0kbahXb3DvAFkKM8ffGEEe9KRWmYrZFpHAdE5LD0OqZqjYz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42571c700d2so230435755ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392648; x=1760997448;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvnsOugUEyMO21MP4J4A4tH2lO6OVEGAuTJV0kD2UUA=;
        b=kfgsbwsyCOqWI0MHSoMT2h074CwV/Phh8bC0/gvg6Nj3tYFqa4RRAXC0I/f+KkCBN+
         H14qf4dooC/RYrWzN+5b6Rvktkn4lHzRGquFtT2ea0ne0dFLWaajtJXri8PO84yhtbVh
         0PGlhz7EvaZ8avGAXkvpWZzaPLjVMf+bWRFI1Ma3yOfvyXmYmCo6sjjFoIEcyGIC4YCh
         N2AMFQenkGfPgu4TI0S5y9ImkdLJOqIhnNRfQMqV0qzFKnsQQ8/a0BFEAOI5u0Xuh0p1
         8wH3KydM+8j0Q+aoGprW3jvp8IEpw1+lnphieqwyvC6rsCcBlPROZCv6AxjVfN9TkL/l
         5UBg==
X-Forwarded-Encrypted: i=1; AJvYcCUBpo7bzS12dY9wawgyGk7gfvJVIbbDP22Yk5JaDUrg/hQmTyCnsVXSV6zm0pN7isL2NchkqDjCnysyifs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfudOGNBZBx9WsKZ/Tht1VoTJafPAgtTbVGjCdVVgXi2JjOcZS
	AXswuSeGa5A6Sj4Bg4bu050WESy/AIq+LoI+gcJKSsD94eGkYul4CTru9lLUgWYw2FcwMNkaoMm
	2ngtTArvTw962FiylDlmgWS409P0JUYuNSb8NwTVI9xfpJH3qGq9ij+C1LSk=
X-Google-Smtp-Source: AGHT+IEuMX3/+3I7cj5Jz16VBYPe1Jo5F3O8yXF7rEJT1zspVePsmvU59Hta/WnWq9bCDQZstxtOHJoE/JnTlgUnIo0OXVFzBlsv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:42d:8a3f:ec8f with SMTP id
 e9e14a558f8ab-42f873d1bbemr250930725ab.15.1760392647809; Mon, 13 Oct 2025
 14:57:27 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:57:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed75c7.050a0220.91a22.01ef.GAE@google.com>
Subject: [syzbot] [f2fs?] WARNING in f2fs_rename2 (2)
From: syzbot <syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bf45a62baffc Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=113b0c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd2356106f507975
dashboard link: https://syzkaller.appspot.com/bug?extid=632cf32276a9a564188d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100a3892580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151c5b34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0d4874557e9/disk-bf45a62b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0bf44a13b5b2/vmlinux-bf45a62b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18db8bc9907c/Image-bf45a62b.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/33a03f772bd8/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15cce542580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
F2FS-fs (loop0): Corrupted max_depth of 3: 16842753
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6707 at fs/inode.c:417 drop_nlink+0xe4/0x138 fs/inode.c:417
Modules linked in:
CPU: 0 UID: 0 PID: 6707 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:417
lr : drop_nlink+0xe4/0x138 fs/inode.c:417
sp : ffff80009e187740
x29: ffff80009e187740 x28: 0000000000000000 x27: ffff0000d416503f
x26: ffff0000f68508f8 x25: ffff0000f69f08f8 x24: 0000000000000000
x23: 1fffe0001ed0a247 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000f6851238 x19: ffff0000f68511f0 x18: 00000000ffffffff
x17: ffff800093605000 x16: ffff800080528494 x15: 0000000000000001
x14: 1fffe0001ed0a2d5 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001ed0a2d6 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c7453d00 x7 : ffff80008269f9fc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008052866c
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:417 (P)
 f2fs_i_links_write fs/f2fs/f2fs.h:3233 [inline]
 f2fs_rename fs/f2fs/namei.c:1017 [inline]
 f2fs_rename2+0x1288/0x1fb4 fs/f2fs/namei.c:1290
 vfs_rename+0x934/0xce0 fs/namei.c:5129
 do_renameat2+0x614/0x8c8 fs/namei.c:5278
 __do_sys_renameat2 fs/namei.c:5312 [inline]
 __se_sys_renameat2 fs/namei.c:5309 [inline]
 __arm64_sys_renameat2+0xd8/0xf4 fs/namei.c:5309
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 170020
hardirqs last  enabled at (170019): [<ffff800080630af8>] seqcount_lockdep_reader_access+0x7c/0xf8 include/linux/seqlock.h:74
hardirqs last disabled at (170020): [<ffff80008b05ee64>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (169238): [<ffff800080202608>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (169236): [<ffff8000802025d4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

