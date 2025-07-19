Return-Path: <linux-kernel+bounces-737894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD6B0B1A0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AB0AA46F1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A5921D3E6;
	Sat, 19 Jul 2025 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjzirI7c"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569617FD
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752952406; cv=none; b=Qg+xs9wAr6a31mvL73kQfm/gUsgMy3Zrzk23+z2aGIZ6RVpn12M2cFf4U0omt2WQRhYfeUfejjCIddJF2/AOyvDvLo7zCEl25+comwohO57CwTD3b4y1i3ur45qixbzxr7ZpzGHcKVDrYj2Fwy16v0SLiGniqkpR0pd7tTc8Eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752952406; c=relaxed/simple;
	bh=5A9ZHxJb6vRf48GEeZrcaWeOQ/hZr9VCBfL+c/z7iyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HerqA647CLETUzVb+C02shsGZxKcMiFGgSVtBe9uP552k4us6qWAE9k5J92QkNpvICywETtYf9JJyyBCoRwITjPnl8AAi9S1aPqUhuE6ZbywPLzM8HKHhEV8QYfaD4ahj/FpnQjcBTgCJ/paOUtgNcyFgF60JOyv51LfvOGWZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mjzirI7c; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 15:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752952402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/5uhjMWmZzhDFFpO9zehHCjQEkeaf6Or5I7Aez7LJk=;
	b=mjzirI7cJp4jkK6+vNLcHHtpYqT7lsmeuOj3LsJmtI5MlasfzvfqXAV+XALu3h0Oar+zMt
	B5TPsknLPMy+F1NbSSdyeCIF3a+t2A4PwbU2e3MyqcT6n/6qSpCnP0onKz0+ZxAIvnKWJe
	3Sb/i0975sZ2BFTLWG3ZYKlJoAdqp4I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+2b98caf09c41174a9697@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Write in
 bch2_get_next_dev
Message-ID: <gtbxhrjzbwuevau27w2zi645uu2y4xuhzutebojmh535blvah7@bc4344cq25cs>
References: <n2gwogdq44vxgvjdefktzbhfny2ezktepblcsj2q3z7t4dgbtv@6uafqubd7qr2>
 <687be826.a70a0220.693ce.0093.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687be826.a70a0220.693ce.0093.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Jul 19, 2025 at 11:47:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> kernel panic: btree_update_nodes_written leaked btree_trans
> 
> Kernel panic - not syncing: btree_update_nodes_written leaked btree_trans
> CPU: 0 UID: 0 PID: 7134 Comm: syz.4.31 Not tainted 6.16.0-rc6-syzkaller-gcbdeb0ffd5bf #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x99/0x250 lib/dump_stack.c:120
>  panic+0x2db/0x790 kernel/panic.c:382
>  bch2_fs_btree_iter_exit+0x475/0x490 fs/bcachefs/btree_iter.c:3732
>  __bch2_fs_free fs/bcachefs/super.c:640 [inline]
>  bch2_fs_release+0x2ab/0x830 fs/bcachefs/super.c:690
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x22b/0x480 lib/kobject.c:737
>  bch2_fs_get_tree+0xb76/0x1540 fs/bcachefs/fs.c:2578
>  vfs_get_tree+0x92/0x2b0 fs/super.c:1804
>  do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>  do_mount fs/namespace.c:4239 [inline]
>  __do_sys_mount fs/namespace.c:4450 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f59aa99014a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f59ab804e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f59ab804ef0 RCX: 00007f59aa99014a
> RDX: 00002000000000c0 RSI: 0000200000000080 RDI: 00007f59ab804eb0
> RBP: 00002000000000c0 R08: 00007f59ab804ef0 R09: 0000000000818001
> R10: 0000000000818001 R11: 0000000000000246 R12: 0000200000000080
> R13: 00007f59ab804eb0 R14: 000000000000596b R15: 0000200000000000
>  </TASK>
> Kernel Offset: disabled
> 
> 
> Tested on:
> 
> commit:         cbdeb0ff bcachefs: Fix UAF by journal write path
> git tree:       git://evilpiepirate.org/bcachefs.git for-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1627f8f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37de60b3108b6d8f
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b98caf09c41174a9697
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Note: no patches were applied.

appears we were missing a flush_work() in the shutdown path

#syz test: git://evilpiepirate.org/bcachefs.git bcachefs-testing

