Return-Path: <linux-kernel+bounces-887524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81ACC38702
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD851A2305A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ED2CA52;
	Thu,  6 Nov 2025 00:09:28 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705763B9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387767; cv=none; b=CaaHmJD+zGQJbTbYVpyEa28mvOLgqat6xtN4KVdIkZuE6WowaRMR9kV1uL8nJN1YXJtTqJ4j999Er+btEMA9dXvY4irk3TxYy9LIILq3ybsIB7mHl/B+om6PYdNdSKv6dWTIH0nAsIIvQuyLm5CREpK9gV2AeVv3N+SWSjqAquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387767; c=relaxed/simple;
	bh=ZwYyRu4A2gk38eztsZ4rjhFgj217Hph0IvUrGDW9VZw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hEhJqg9htTgiqH5DQER024vWGeDY6t9gqIDoksj/gKJKQ83rIcKuy+ffsxT2I99I0M5GAFCdfSdLhv78h4K0/wRUwSy+TcwskItGPhCeInYcV5gx9+CRms1JVdCN/8QlCzdM8B7mbt7tJOygHL175E8BiMosoYK9iC2ckN0MOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-433199c7fb4so4267585ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762387764; x=1762992564;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTbAQ2M/nCFfHVZ9BV27LDugd86V/+z5TlraEbOVrw0=;
        b=iVs5I/wIjBjnIiStPPCsY2Q8JN6vmP3JDu4dhtzTZbYFYDxK6bPTBrA6pOcSzROTnG
         nBi4WCYlASrDb+lbiN3pWIsxNC314zB10IzwHB+rjMfiJivV6RUw6dEvVPdEZ5+j+Gs4
         xW/qxoBqYtGM6EbotsiEwEtk+CMx8LHa0MnkXPoJ3UbONYd9e+k1OHsCTXI8m2qQj+I9
         sDj8VU+cEi/3Z2XJs38hUn2FD/Ka+sld27SYqI+5UZPbMIYhjDBs6CMW20Fi7njAgEiq
         CvI2NJC5VIv5tBdu1439g3SYSfXYgyIiUxqPXx89g3EUOYCM6ydXMG4CpDIByxgteMVt
         RL0A==
X-Forwarded-Encrypted: i=1; AJvYcCXuGKdfGYHr1bBqyMFiDJg/Am+WkDeOCyU8VQDDTRgq2h1LW9RWbwstP+FpN0srzDXLsoaHrEd9xeSOcuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJ1EkbP66WlRTXPkc2X+n1yjf06PTCS///hcXbwJE8yAqRbG3
	fMlw4tMkFnMMwxHnybAm9B7XMinLXmSVGLW78qHyDEvEAxmo/8bBexdAP18ELyb3N6Ust3ntaAL
	FWbnfBrsHjWHDpDJeBbJr9tpv0yn4wSEQrXSrL0ZICBK82nGpHkXoVAfmGqM=
X-Google-Smtp-Source: AGHT+IFyxfNhzxUVWRmkkPT+ZrPYGb7DmKIXoPjVutiS3OEQ2ZIHRrLEh6mPuUoziz9D8L/I2Yv+kJEyCy7Mpd5rUFd53ZH4mnU3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3182:b0:433:27c1:75c4 with SMTP id
 e9e14a558f8ab-433407dac54mr85725185ab.31.1762387764377; Wed, 05 Nov 2025
 16:09:24 -0800 (PST)
Date: Wed, 05 Nov 2025 16:09:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690be734.050a0220.baf87.007a.GAE@google.com>
Subject: [syzbot] [jfs?] BUG: corrupted list in dbUpdatePMap
From: syzbot <syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    691d401c7e0e Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1698c292580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0a0feb49c5138cac46
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150b5704580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d75fe2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d338706bec79/disk-691d401c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3ac35c22ff8/vmlinux-691d401c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8d6c3e88136/bzImage-691d401c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/47c6a6500cd9/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=166ee32f980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com

list_add corruption. next is NULL.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:28!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 122 Comm: jfsCommit Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__list_add_valid_or_report+0xc3/0x130 lib/list_debug.c:27
Code: 4c 89 f2 48 89 d9 e8 0c 88 a4 fc 90 0f 0b 48 c7 c7 20 de 3d 8b e8 fd 87 a4 fc 90 0f 0b 48 c7 c7 c0 de 3d 8b e8 ee 87 a4 fc 90 <0f> 0b 48 89 df e8 13 c3 7d fd 42 80 7c 2d 00 00 74 08 4c 89 e7 e8
RSP: 0018:ffffc9000395fa20 EFLAGS: 00010246
RAX: 0000000000000022 RBX: 0000000000000000 RCX: 270c5dfadb559700
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000f0000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff5200072bee9 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000004 R15: 1ffff92000632266
FS:  0000000000000000(0000) GS:ffff888126ef9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056341fdb86c0 CR3: 0000000040a18000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add include/linux/list.h:177 [inline]
 dbUpdatePMap+0x7e4/0xeb0 fs/jfs/jfs_dmap.c:577
 txAllocPMap+0x57d/0x6b0 fs/jfs/jfs_txnmgr.c:2426
 txUpdateMap+0x81e/0x9c0 fs/jfs/jfs_txnmgr.c:2364
 txLazyCommit fs/jfs/jfs_txnmgr.c:2665 [inline]
 jfs_lazycommit+0x3f1/0xa10 fs/jfs/jfs_txnmgr.c:2734
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xc3/0x130 lib/list_debug.c:27
Code: 4c 89 f2 48 89 d9 e8 0c 88 a4 fc 90 0f 0b 48 c7 c7 20 de 3d 8b e8 fd 87 a4 fc 90 0f 0b 48 c7 c7 c0 de 3d 8b e8 ee 87 a4 fc 90 <0f> 0b 48 89 df e8 13 c3 7d fd 42 80 7c 2d 00 00 74 08 4c 89 e7 e8
RSP: 0018:ffffc9000395fa20 EFLAGS: 00010246
RAX: 0000000000000022 RBX: 0000000000000000 RCX: 270c5dfadb559700
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000f0000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff5200072bee9 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000004 R15: 1ffff92000632266
FS:  0000000000000000(0000) GS:ffff888126ef9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056341fdb86c0 CR3: 0000000040a18000 CR4: 00000000003526f0


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

