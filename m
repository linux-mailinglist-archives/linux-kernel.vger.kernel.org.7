Return-Path: <linux-kernel+bounces-835571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31104BA77B3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 22:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB953B9C1A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151A279DC3;
	Sun, 28 Sep 2025 20:43:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752F1DB125
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759092185; cv=none; b=khoariKvu0g33HfzEqtTPeJGuCePM7r5Id7F8MS9Uc6oVXGOBVmz3dkuUI6zetmjvmRiD4BluTKtpTevVpTahZTtGrhHF6RFTkkjdKSqBoLpiJ0JtQr8fOsoCIrv+GDi3ffL0rZTo9dO2y05ZamzHluptdkQi1H8+6yf9kOEShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759092185; c=relaxed/simple;
	bh=m9qplz64UZgfS9AXwtmyrqI2YazY8gJZ4JvF7wP2Tec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qBdUZff3Er2KtRfaSM+x48KEOys7IAnRBzKY0EytURdhfUtQCozjR8QBJ78NrQB9nP/KZUubaGrweAgGyrJuXmLaPjrAgeQhMDDgNNTdsXPIKrGFdRYrBdY3ot+gkAM1dQThCFdOruN6G8OClOl44JF4h9ruU+yxY5YGc2y6Brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42955823202so12596285ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759092182; x=1759696982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gae0C0ktqKnfxkP8sTTUEYK7MZodBFuW3jnjywbn7No=;
        b=kk45mU4ZmbA0hhYHextrdZQAPd71ao7HsabakrjgBxq0FmIJkQ1OnP9+VfdJxVxdJc
         2EVI/w7+TjjsjV23NoSiO/DVsbcCxS25h3uzhM/mxPwsxPCotWPr64B0UZV98eKUxt7/
         SvXlboTnkcU014Po/hNRTXE7syme6KLtJnqbH5ZclxxCmbtsnID7uKvCWi6V7nGy/jCy
         ir+cdhq42avzcF4SQUtO4YV9DQZ+st11pPOqROCn0r79N1Gf9h3Myv+W38imGlpav25X
         omBTu9eq4kRz8/zAeZg3HilMpYR2veFfiYWJgyJpzQrcbtV60lA+By8t26dhqENS0Ww3
         nDZQ==
X-Gm-Message-State: AOJu0YxE5P+HD4CRUSTELFDOE+DEy7BW3CsHA6zWaei0lnIQNiEIrJ10
	XVQ4A3LvqKft7V6stO4fbZDnR8ukKG2BH7J6wR1ZdCdT7ymPp0HDaQEIUayIyYvqLrWdoIMUcxd
	hCGY1tBAtbFpCosY2ZLMUxdZDmu57cogdMFhmxOMvCFjRaRabVR+YbQ6ReaA=
X-Google-Smtp-Source: AGHT+IHACiX3HKd/0G1CczFLlxkHj0UXkcd6gel0dc+HHx1xStqARpz4FUE8t6IZui9bO1kOe1a9Xn6AAqdOxIMottazxcCHwk9S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:423:2666:4687 with SMTP id
 e9e14a558f8ab-425c36bb2cdmr193762145ab.15.1759092182629; Sun, 28 Sep 2025
 13:43:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 13:43:02 -0700
In-Reply-To: <87a52e2uxz.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d99dd6.050a0220.1696c6.000a.GAE@google.com>
Subject: Re: [syzbot] [fs?] UBSAN: shift-out-of-bounds in befs_check_sb
From: syzbot <syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in befs_check_sb

loop0: detected capacity change from 0 to 128
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/befs/super.c:96:9
shift exponent 2066842816 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 6637 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 befs_check_sb+0x421/0x4c0 fs/befs/super.c:96
 befs_fill_super+0x49b/0xa70 fs/befs/linuxvfs.c:841
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc8d5fb066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc8d5615e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc8d5615ef0 RCX: 00007fc8d5fb066a
RDX: 0000200000000040 RSI: 0000200000000000 RDI: 00007fc8d5615eb0
RBP: 0000200000000040 R08: 00007fc8d5615ef0 R09: 0000000000800001
R10: 0000000000800001 R11: 0000000000000246 R12: 0000200000000000
R13: 00007fc8d5615eb0 R14: 0000000000009e17 R15: 0000200000000080
 </TASK>
---[ end trace ]---


Tested on:

commit:         8f973663 Merge tag 'trace-v6.17-rc7' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f7f142580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=fc26c366038b54261e53
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

