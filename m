Return-Path: <linux-kernel+bounces-744583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0A9B10ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E97D1D00E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7F2E9722;
	Thu, 24 Jul 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c7HwVXaX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BRw6ZFVp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D4264A74
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371099; cv=none; b=MprKEOZFlAhykHhon3YxoDblkPZvIMz8MzW2I+YGcuJBfd6lIKGSPDp40k7aAHqIfznQ7yzvPCM/aNwsPh+2OLARdNwyOhn6yP3PtBWYIV9pMCMeftwm1Nu06CAZou8ElIe4P9dX+EufilAU6NIq88uOcSKq5/RkYs6wOoZXXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371099; c=relaxed/simple;
	bh=PuCvx93fI5WdSWBXONt7HX4oa3CPR9Z1RgAoUB9SGwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EkEgg0bsPRS8X3DFWG6YAJ+fm1hOTxWcX+9EnGSoHTq1Xi5GS7WkqQjXfWDezj27h030kb3eC83n+awJzjhkp/SU0WAvHutLXqlH4M73+O2Az5oSk+2bXRn3mFLqUMKljKoSGZCcsqEl5e9H+U5n/84UqdQWCnJh5r1gWgm0mPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c7HwVXaX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BRw6ZFVp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753371095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1G3MekQgMVdwkAz8QZdfoDsQVqrzOU3Isg5G6JFJk70=;
	b=c7HwVXaXAoPccKBLP72b+Qcbs/fvfae0+AMWy0d2iie2Tx3/yVShL/bXaFORJwjrrqout4
	/j4Rfk7MZaooCKV5wP/iH6GVo6wr/ce4J+rcoPlOQ6gdb2s5qER6EjprZi1Rh7ZF8J03vN
	4+NQ/Rc8lQfuK0tHZy32INmbzfMW36NQbsHQEUQ7YwNBpdHCcXiodwyEXFwkB624ePxcEY
	wXgmhQ9ZwAwcz2gieJzKU2EaYptJGltQjxfG1/XQ7WPBhuHF250gxayjr4vTSkEEDKgY6J
	fPWpghay1vgx9Xlgxm7mP4WDFxTeK9BedtTEccByfslVmj3xUqH5TaWXtcTIxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753371095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1G3MekQgMVdwkAz8QZdfoDsQVqrzOU3Isg5G6JFJk70=;
	b=BRw6ZFVpFFgUc0u8GEK5C3NVWTJiUHIMwf2BmcAJ3FLGvmjZar/BFJZPWzAhKfNeIGdagD
	VjKc2Vaa05V8a+Bg==
To: syzbot <syzbot+e84a763987edd173d82f@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] [kernel?] KMSAN: uninit-value in hrtimer_wakeup
In-Reply-To: <68820e8e.a00a0220.2f88df.0022.GAE@google.com>
References: <68820e8e.a00a0220.2f88df.0022.GAE@google.com>
Date: Thu, 24 Jul 2025 17:31:35 +0200
Message-ID: <87cy9pr4fc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 03:44, syzbot wrote:
> HEAD commit:    bf61759db409 Merge tag 'sched_ext-for-6.16-rc6-fixes' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1693938c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5227c65742122bdd
> dashboard link: https://syzkaller.appspot.com/bug?extid=e84a763987edd173d82f
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c9e297bb553f/disk-bf61759d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7f2d1bf53414/vmlinux-bf61759d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9a4f67426eab/bzImage-bf61759d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e84a763987edd173d82f@syzkaller.appspotmail.com
>
> =====================================================
> BUG: KMSAN: uninit-value in hrtimer_wakeup+0xcb/0xd0 kernel/time/hrtimer.c:1997
>  hrtimer_wakeup+0xcb/0xd0 kernel/time/hrtimer.c:1997

...

> Local variable t created at:
>  hrtimer_nanosleep+0x48/0x480 kernel/time/hrtimer.c:2142
>  common_nsleep+0x118/0x160 kernel/time/posix-timers.c:1353

This makes absolutely no sense. hrtimer_nanosleep() initializes the
local variable

      struct hrtimer_sleeper t;

in two steps:

      hrtimer_setup_sleeper_on_stack(&t, clockid, mode);
      hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
      
and the complaint in hrtimer_wakeup() is:

 1989 static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 1990 {
 1991         struct hrtimer_sleeper *t =
 1992                 container_of(timer, struct hrtimer_sleeper, timer);
 1993         struct task_struct *task = t->task;
 1994 
 1995         t->task = NULL;
 1996         if (task)
 1997                 wake_up_process(task);    <---- here
 1998 
 1999         return HRTIMER_NORESTART;
 2000 }

t->task was initialized:

 2027 static void __hrtimer_setup_sleeper(struct hrtimer_sleeper *sl,
 2028                                     clockid_t clock_id, enum hrtimer_mode mode)
 2029 {
 ...
 2054         __hrtimer_setup(&sl->timer, hrtimer_wakeup, clock_id, mode);
 2055         sl->task = current;              <---- here
 2056 }

This code hasn't changed in a very long time. Looks like KMSAN is confused...


