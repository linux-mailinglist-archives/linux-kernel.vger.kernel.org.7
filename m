Return-Path: <linux-kernel+bounces-868732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2501C05FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590731A61C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D189E3148C5;
	Fri, 24 Oct 2025 11:07:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB59313525
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304025; cv=none; b=OHMXi8w5CUQGkNh/bAJEcHF1ZG+JZYBujOnw6B9rBrjDqYbspm9Q9CqkLP8Ei43am96lDcGWdaowuT8tVjMpc0vt78Oa+AVKF1gSbtm+2WfrMgfZkV7etQj1UAC8HdMajIi8BXm82lMSJIUY9JSnH+K4Xh04Hi+gbsNmfmuqYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304025; c=relaxed/simple;
	bh=JfoFFSri8czu3A0PYkF5BUpGGKmXgM8QKcIkvGH4xd0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ScS2kBDhhkG5kw91R4CSNOOGHfTjubYOEibz7czn9rCxGwpLjQDswDXFfg2gf4UYAjhzb0frYF6IReYeHmpfYxJsB+IdLZNdOyBnokziX3JH2//3QND0Xdmtc/Go91FM9+tiZdHL+LOaN5SMswk1O3gEXaKEyVWJo1/W9eJ9k3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430afaea1beso25297605ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761304023; x=1761908823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTgJYuPDdwYzm3TM+QxVGjci0UoRoy/dxD5QJLeH+g8=;
        b=A5sz3s9iuZ7oMZWHLcEGKO0byRl9aSJQobwFKrNiAhB+3kjciXDwVDTGUPky2y7P5U
         RfMBMJBQ7UcqyWUihoZFJInhYCFCdtviedbo9OE6izF/XccbyP9n0SkRQETyHhBVVxQT
         jA1HIysqXqseWm02rpBjq8DkQ0twilFLjuX6RqW5SDiBj/2VvuKpwnPK87jpvHRqXffg
         scMJdHAh/hwndlmscUV3ym1Z4qlZdDv84Cb8VAgpfJ+sio+7ItGHJ+FemS0qpCsZb4Z4
         kmewOiKLuXB54qZACe4aS0dk/M/b02eQdmqpDcwCjMJylPDy7XeoUpGgIwzo9VBv6EuO
         pKlw==
X-Forwarded-Encrypted: i=1; AJvYcCWX7m+Zy/eryoV2Gy+mIhyWTG56kgjtBLUDDLxAdcBk+4AKC74zfIq1cTwLdfHzwVMMC/iaGsiF8fOVII0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBGhfRGLON1rDyXU+PyHDMAPmTJ6TRil7y38DzrZqg5fPgBxc
	iUKYeBLXX0fFNB/cW4wqRy/nZST4abU5Ogel8Kc7Pp3Tty2+MU+xypFXvhcBWNm9+EHL+pxKhqy
	or1vLfNP0iQIhWhztgMST+VnpB0kT/5dMW2ob8K3jnKI0ZOZLxG7nQFQaDRY=
X-Google-Smtp-Source: AGHT+IFT1WZQSuuV0sE2ZAXPr99VUHxrd4tXv2lNIUpVEEhagDxQlrO20PfxxcMxXkDa9VkLRQ4RvKm3rpN4wVSGhYS5s9FN32MX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2702:b0:42f:9574:7c1e with SMTP id
 e9e14a558f8ab-430c52a253amr381702385ab.27.1761304023077; Fri, 24 Oct 2025
 04:07:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 04:07:03 -0700
In-Reply-To: <20251024071534.2MOzq%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb5dd7.050a0220.346f24.00c1.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extents_range
From: syzbot <syzbot+f2107d999290b8166267@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __ocfs2_move_extents_range

------------[ cut here ]------------
kernel BUG at fs/ocfs2/suballoc.c:1396!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 7437 Comm: syz.0.17 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ocfs2_block_group_set_bits+0x780/0x8ec fs/ocfs2/suballoc.c:1396
lr : ocfs2_block_group_set_bits+0x780/0x8ec fs/ocfs2/suballoc.c:1396
sp : ffff8000a13571a0
x29: ffff8000a1357260 x28: ffff0000dcf1cfb8 x27: ffff0000ca040000
x26: ffff0000db626630 x25: ffff0000c6fcb000 x24: 1ffff0001426ae40
x23: ffff0000c6fcb00c x22: dfff800000000000 x21: 0000000000000002
x20: 00000000000000ff x19: 0000000000000000 x18: 1fffe00033970070
x17: ffff80008ed4d000 x16: ffff80008a937600 x15: 0000000000000001
x14: 0000000000000000 x13: 00000000fffffffc x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d6fe8000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 00000000000000ff x4 : 0000000000000001 x3 : ffff0000e115c0e8
x2 : ffff0000c6fcb000 x1 : 0000000000000002 x0 : 00000000000000ff
Call trace:
 ocfs2_block_group_set_bits+0x780/0x8ec fs/ocfs2/suballoc.c:1396
 ocfs2_move_extent fs/ocfs2/move_extents.c:693 [inline]
 __ocfs2_move_extents_range+0x20ec/0x2abc fs/ocfs2/move_extents.c:866
 ocfs2_move_extents+0x314/0x7ec fs/ocfs2/move_extents.c:933
 ocfs2_ioctl_move_extents+0x448/0x614 fs/ocfs2/move_extents.c:1065
 ocfs2_ioctl+0x1c4/0x738 fs/ocfs2/ioctl.c:946
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:735
 el0t_64_sync_handler+0x90/0xfc arch/arm64/kernel/entry-common.c:754
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 17ffffa8 979ad94a d4210000 979ad948 (d4210000) 
---[ end trace 0000000000000000 ]---


Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=16e193e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c2423b3cd696bce
dashboard link: https://syzkaller.appspot.com/bug?extid=f2107d999290b8166267
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17582d2f980000


