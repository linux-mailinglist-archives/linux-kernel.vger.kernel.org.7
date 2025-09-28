Return-Path: <linux-kernel+bounces-835124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A953ABA654C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B1D1758F5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AAE1DF75D;
	Sun, 28 Sep 2025 01:16:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9434BA4E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759022165; cv=none; b=SJ0oDaCuwC+NuM5MSodu9GgWrhOdcSGiucnLKgXq43asGrXX7TpF5SDQvlGmhaShDIrfjyfZO3bgNoV9Uk4K5CvDZEO7CtY3F2jydJXdNqXtrxbhmYBiZYl7cjRiUYrFOfR7MRdhHfGUm+bLz7zn7E2onwlN+eIz/a5dlS583OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759022165; c=relaxed/simple;
	bh=gLPKgqG5TfsBcw4FVs6BjoPf8gU4xACVUhr4IZvDOuk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SGdWhNHdBsSldniaQDWfVQXLYFPjFQ1Htcd1bIFaqlsZlhrunfFtLucSjhp8mYyPCuex6uoz/HqQxyCH3Mv5O6OcW56Nog/xFLOE28Uk3APKSHS6GRBe3eUmGg4dZ8MC2nwm1hxrfgrjNgjxQBirknsKJiPI+dcQYPq7g7Xeg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-90e388db4bdso559166939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759022163; x=1759626963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TGUsPuFDup1Na4UW++qtmDK/v7FbymUOMe4mu+N5TA=;
        b=c35Qa0KlrArkU6fnKuMwk9lmKT5FFcyuuxZwZKhoHJvm80lgau4ptpBjId6drUIdP+
         Lz9mk2RcMiS2mi5/3qqZBrm4E1rwadhwuRNyOpPSMrZHp2aaa6+y7XDuRr2wsxWgSDDB
         IDAEger+mje0FfyAwGEiGpmxUqS/pkC+6JpwqzQGc7i5BfMjXcm4eH9KBUjY+/sfZxN/
         N8zJTdclHviSDFY7dS5VRqLG5rKpB0RvG2glqQJi810hC5ICjLoibEqd8HRCtQ0jnrtp
         3o/E2b/iSyszO4t9d0yfeT/lEQsixmT3TJSMu68DP6+Zl2CEqClNeW3M7+3Y09k747Zj
         4yfw==
X-Gm-Message-State: AOJu0YyaY1CmnWsjy5bBQByuPU3r5oYz01st459krkWLiqglGj+9bGVu
	P9CX3IW5+dA3Lswk6tHMbmbtAaOgfXhZXu7BMIY0fnOODp9qjRy87Kdu+lqluSWzrQrb0ca/lZZ
	2SkP8szNUZGucT5G4xdWhF2Z5NGnsgeLdMn5n+vukSSAia9ekA5/EDTljlKA=
X-Google-Smtp-Source: AGHT+IFrTbA9F4P+pIB1RUr2uUqMlbnHkdIuf/QHzo2r6Q0fM/pfka3QvijyIJvUxuFPRj+Q/oM+6npMD7ItjDLphd8H0tiNCgNK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d90f:0:b0:424:80f2:299 with SMTP id
 e9e14a558f8ab-425956699b2mr151908905ab.27.1759022162870; Sat, 27 Sep 2025
 18:16:02 -0700 (PDT)
Date: Sat, 27 Sep 2025 18:16:02 -0700
In-Reply-To: <87ecrr75n6.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d88c52.a00a0220.102ee.0021.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindBits (2)
From: syzbot <syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in dbFindBits

ERROR: (device loop0): dbAllocBits: leaf page corrupt
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:3031:55
shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 UID: 0 PID: 5831 Comm: syz.0.16 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 dbFindBits+0xdf/0x1a0 fs/jfs/jfs_dmap.c:3031
 dbAllocDmapLev+0x16b/0x3c0 fs/jfs/jfs_dmap.c:1985
 dbAllocCtl+0x14a/0x9c0 fs/jfs/jfs_dmap.c:1825
 dbAllocAG+0x1e6/0xff0 fs/jfs/jfs_dmap.c:1353
 dbDiscardAG+0x2df/0x900 fs/jfs/jfs_dmap.c:1608
 jfs_ioc_trim+0x429/0x690 fs/jfs/jfs_discard.c:106
 jfs_ioctl+0x2b5/0x3d0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f894198cda9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f894286c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8941ba5fa0 RCX: 00007f894198cda9
RDX: 00000000200000c0 RSI: 00000000c0185879 RDI: 0000000000000004
RBP: 00007f8941a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8941ba5fa0 R15: 00007ffd6f2d8608
 </TASK>
---[ end trace ]---


Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103472e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=231ef872e038778b
dashboard link: https://syzkaller.appspot.com/bug?extid=9e90a1c5eedb9dc4c6cc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

