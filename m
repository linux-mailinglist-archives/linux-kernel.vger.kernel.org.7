Return-Path: <linux-kernel+bounces-677470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC5AD1AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 11:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D78B3ADC59
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAA441C63;
	Mon,  9 Jun 2025 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvwRkiU7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1084202F6D;
	Mon,  9 Jun 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462453; cv=none; b=CzP7VdOoLl/NbnCdoqVhZ+Frp+EMgZOq5jjSmw3pXrdnp+S2yv6Cvn56OlFtJitTm+v18Vkg0oCOlXBvZf2jsxg34XkS+DskTiw388Yvn04hdbrMab3lCVDgxbngSQyJdbJ4Pif2LgTbAbdBhOQ4caLOU0FZLZ3SksNSuzvUqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462453; c=relaxed/simple;
	bh=1S9Nm6f5O7m3vI4hvRuferiAQBF4taD3Nf0gweHpbdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbxlGi65mYRXPfkt50lpqa/rqfkIZBblBjMeNqJ1usE20a5kmTDyoubH9ZxU0a9XFi4C2WrLsAa3PLyC+oTTJwC4YVDtb1MtNCa+7/k0w8zH5GMBaBbGi9JupYz8yVGiXEdyGwC0nFh1o/Vg/NR2RrNVS2KqgPWdBm0G9Nzy6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvwRkiU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A536C4CEEB;
	Mon,  9 Jun 2025 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749462453;
	bh=1S9Nm6f5O7m3vI4hvRuferiAQBF4taD3Nf0gweHpbdU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hvwRkiU7h8ctg2xeY2aHY8qarL7QCRjdKDyKh3YyX0kfU0ngw0WWHBRiVfyxrRrvr
	 r+/JpfqOjCh+h0WRt6zmeR6n9/wnRxoB6NK8yO5ZrGU4MjilF3x6CcXGz/RtHfzhs7
	 9G1L0iWfzNoWQ7XcWWa3iQmrOHJ1Qk8ClE++87ZwtFGLA3JS3ehfjwMont8BQ1CM4a
	 d481YcTWJrtJkiE1A8XB80L/McR+q2JucMSXwecG+OHcTj24X4gF5J6HI1866WSe2k
	 uEaopo6XsNgr2NL3j++7zBNXxfetlIOdK2d4QL48hBd+5dTr0osTsNw9YhRNgdamJo
	 nGbsstIkBZR+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02F00CE0B6C; Mon,  9 Jun 2025 02:47:33 -0700 (PDT)
Date: Mon, 9 Jun 2025 02:47:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	syzbot <syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, josh@joshtriplett.org,
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rcu@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rcu?] [bcachefs?] BUG: unable to handle kernel NULL
 pointer dereference in rcu_core (3)
Message-ID: <e3187e7a-cac2-46c4-9c56-3a649e122353@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <67a2b20a.050a0220.50516.0003.GAE@google.com>
 <9694d40a-072e-47c2-a950-3b258bbe04f5@paulmck-laptop>
 <jzknqese5idob37wxgclq7ptxnsd66qbqkxtjpjormymsrwv2j@xjum5exljlh6>
 <aEXVKNVLI3VQInSc@pc636>
 <602bb1be-f4a4-4194-803f-856e95711870@paulmck-laptop>
 <aEac1veMLffwOdv8@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEac1veMLffwOdv8@pc636>

On Mon, Jun 09, 2025 at 10:35:34AM +0200, Uladzislau Rezki wrote:
> On Sun, Jun 08, 2025 at 05:25:05PM -0700, Paul E. McKenney wrote:
> > On Sun, Jun 08, 2025 at 08:23:36PM +0200, Uladzislau Rezki wrote:
> > > On Sun, Jun 08, 2025 at 11:26:28AM -0400, Kent Overstreet wrote:
> > > > On Wed, Feb 05, 2025 at 06:56:19AM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Feb 04, 2025 at 04:34:18PM -0800, syzbot wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > syzbot found the following issue on:
> > > > > > 
> > > > > > HEAD commit:    0de63bb7d919 Merge tag 'pull-fix' of git://git.kernel.org/..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10faf5f8580000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=80e5d6f453f14a53383a
> > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b69d18580000
> > > > > > 
> > > > > > Downloadable assets:
> > > > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0de63bb7.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/1142009a30a7/vmlinux-0de63bb7.xz
> > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/5d9e46a8998d/bzImage-0de63bb7.xz
> > > > > > mounted in repro: https://storage.googleapis.com/syzbot-assets/526692501242/mount_0.gz
> > > > > > 
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com
> > > > > > 
> > > > > >  slab radix_tree_node start ffff88803bf382c0 pointer offset 24 size 576
> > > > > > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > > > > #PF: supervisor instruction fetch in kernel mode
> > > > > > #PF: error_code(0x0010) - not-present page
> > > > > > PGD 0 P4D 0 
> > > > > > Oops: Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI
> > > > > > CPU: 0 UID: 0 PID: 5705 Comm: syz-executor Not tainted 6.14.0-rc1-syzkaller-00020-g0de63bb7d919 #0
> > > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > > > > RIP: 0010:0x0
> > > > > > Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > > > > > RSP: 0018:ffffc90000007bd8 EFLAGS: 00010246
> > > > > > RAX: dffffc0000000000 RBX: 1ffff110077e705c RCX: 23438dd059a4b100
> > > > > > RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffff88803bf382d8
> > > > > > RBP: ffffc90000007e10 R08: ffffffff819f146c R09: 1ffff11003f8519a
> > > > > > R10: dffffc0000000000 R11: 0000000000000000 R12: ffffffff81a6d507
> > > > > > R13: ffff88803bf382e0 R14: 0000000000000000 R15: ffff88803bf382d8
> > > > > > FS:  0000555567992500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: ffffffffffffffd6 CR3: 000000004da38000 CR4: 0000000000352ef0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > Call Trace:
> > > > > >  <IRQ>
> > > > > >  rcu_do_batch kernel/rcu/tree.c:2546 [inline]
> > > > > 
> > > > > The usual way that this happens is that someone clobbers the rcu_head
> > > > > structure of something that has been passed to call_rcu().  The most
> > > > > popular way of clobbering this structure is to pass the same something to
> > > > > call_rcu() twice in a row, but other creative arrangements are possible.
> > > > > 
> > > > > Building your kernel with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y can usually
> > > > > spot invoking call_rcu() twice in a row.
> > > > 
> > > > I don't think it's that - syzbot's .config already has that enabled.
> > > > KASAN, too.
> > > > 
> > > > And the only place we do call_rcu() is from rcu_pending.c, where we've
> > > > got a rearming rcu callback - but we track whether it's outstanding, and
> > > > we do all relevant operations with a lock held.
> > > > 
> > > > And we only use rcu_pending.c with SRCU, not regular RCU.
> > > > 
> > > > We do use kfree_rcu() in a few places (all boring, I expect), but that
> > > > doesn't (generally?) use the rcu callback list.
> > > >
> > > Right, kvfree_rcu() does not intersect with regular callbacks, it has
> > > its own path. 
> > > 
> > > It looks like the problem is here:
> > > 
> > > <snip>
> > >   f = rhp->func;
> > >   debug_rcu_head_callback(rhp);
> > >   WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> > >   f(rhp);
> > > <snip>
> > > 
> > > we do not check if callback, "f", is a NULL. If it is, the kernel bug
> > > is triggered right away. For example:
> > > 
> > > call_rcu(&rh, NULL);
> > > 
> > > @Paul, do you think it makes sense to narrow callers which apparently
> > > pass NULL as a callback? To me it seems the case of this bug. But we
> > > do not know the source.
> > > 
> > > It would give at least a stack-trace of caller which passes a NULL.
> > 
> > Adding a check for NULL func passed to __call_rcu_common(), you mean?
> > 
> Yes. Currently there is no any check. So passing a NULL just triggers
> kernel panic.
> 
> >
> > That wouldn't hurt, and would either (as you say) catch the culprit
> > or show that the problem is elsewhere.
> > 
> I can add it then and send out the patch if no objections.

No objections from me!

						Thanx, Paul

