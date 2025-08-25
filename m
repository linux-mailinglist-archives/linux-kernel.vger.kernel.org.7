Return-Path: <linux-kernel+bounces-784172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998CB33791
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2323AFB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9882882DB;
	Mon, 25 Aug 2025 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mrdZzdNl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWVYz0Cn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7392877F5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106104; cv=none; b=rk8T3U/Fv4qGE8tOK//q6hsh6Iqg/xnswb7YLWEPE4wPnCxjtGw+OZwDEh8dtaC7KfSZ6odmIPPqm2fyoJS2ybFWZxdmf5rYrg2jcKeFmynZqvdCyTuuXuRjQvbXftFIPHrU+uSPBXTgWbUrWr7hwClNFp6w4MZ91DdgQjzpJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106104; c=relaxed/simple;
	bh=x+/wG4kd22HNH/xFh6XIJg3dd2eG04/uZnQZBnlZHrw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=JwRFh06fjrI8c8qE15r6BCMaEXk1aggTwhp4eq8xnZW/FTWkAgajXfTogQDr5/HKPF213o9ACaeCdHWGtsN2Gohcb/oDhn0vIC/ZV95UtL/Wm32r9tyVfQ6g9dMyxbO3Dv3SyFTxoF6VWh7hoCdUXD78b8KvZgz4FVmiV6685B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mrdZzdNl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWVYz0Cn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756106100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=HRF7iy6h0BsCSFLXqGnF+qkgmpUo0BUo5JJ7GwCl0bg=;
	b=mrdZzdNlcVzDsDnOHBlUDhrVNgqRak4M+wlEt+0E8wcj0Ewt4d5ut2i76UerlWfMGbDeqX
	erN3R057Ir57ZoYYB6BC5xpiiPpLps+H/XhnCAjeNWOHEgh0ajQ2gqEbWVrm12rZpjw1eU
	VrgAg7xAOHC3+a8vBCq/BqvL91HXW95OqzLjmLf/WuM4VtFexG2U1qskLdctFZ8eIQEXLR
	oAXO72+Go45qZkMIhRhEq+oVhkocPmofvE4Nc9t0WSsAthFvLfex8Ehm0Oh8pVW7W465rT
	ZFUIflB1GbgEUPAWfoVFmTViQiYqVTXxNEoDcZUP2hnhousGOx2s28JB0g8o5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756106100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=HRF7iy6h0BsCSFLXqGnF+qkgmpUo0BUo5JJ7GwCl0bg=;
	b=HWVYz0Cnlj2K/lZUZDgpecC9Eo3d6mvKnAnPMObRpaBitwGdMeEcJM1u70XnzIYDARub2U
	oFh8FBNz8NHzORBA==
To: Jirka Hladky <jhladky@redhat.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, john.stultz@linaro.org,
 anna-maria@linutronix.de
Cc: Philip Auld <pauld@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>, Miroslav Lichvar
 <mlichvar@redhat.com>, Luke Yang <luyang@redhat.com>, Jan Jurca
 <jjurca@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [REGRESSION] 76% performance loss in timer workloads caused by
 513793bc6ab3 "posix-timers: Make signal delivery consistent"
In-Reply-To: <87sehh2gw8.ffs@tglx>
Date: Mon, 25 Aug 2025 09:14:58 +0200
Message-ID: <87cy8j3ma5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 24 2025 at 11:44, Thomas Gleixner wrote:
> On Sat, Aug 16 2025 at 18:38, Jirka Hladky wrote:
> And this has nothing to do with timer migration or whatever, that's just
> a matter of correctness.

Just to come back to timer migration. That's completely irrelevant here
because /proc/sys/kernel/timer_migration only affects the timer wheel
and _not_ hrtimers, which are used here.

And just a few more comments about your findings:

> grep -c hrtimer_start hrtimer*txt
> 6.12: 10898132
> 6.13: 17105314
> 
> grep -c hrtimer_expire_entry hrtimer-6.12.0-33.el10.x86_64.txt
> hrtimer-6.13.0-0.rc2.22.eln144.x86_64.txt
> 6.12: 8358469
> 6.13: 3476757
> 
> The number of timers started increased significantly in 6.13, but most
> timers do not expire. Completion rate went down from 76% to 20%

Did you actually look _which_ timers were started and which ones did
expire and which ones not?

Data for a 2 seconds run (couldn't be bothered to wait 23 seconds)

On 6.10:

All start/expire:

# grep -c 'hrtimer_start' t.txt 
248039
# grep -c 'hrtimer_expire' t.txt 
247530

stress-ng Posix timer related:

# grep -c 'hrtimer_start.*function=posix_timer_fn' t.txt 
246739
# grep -c 'hrtimer_expire.*function=posix_timer_fn' t.txt 
246739

stress-ng nanosleep related:

# grep -c 'hrtimer_start.*function=hrtimer_wakeup' t.txt 
2
# grep -c 'hrtimer_expire.*function=hrtimer_wakeup' t.txt 
2

On 6.17-rc1:

All start/expire:

# grep -c 'hrtimer_start' t.txt 
457456
# grep -c 'hrtimer_expire' t.txt 
304959

stress-ng Posix timer related:

# grep -c 'hrtimer_start.*function=posix_timer_fn' t.txt 
304673
# grep -c 'hrtimer_expire.*function=posix_timer_fn' t.txt 
304674

stress-ng nanosleep related:

# grep -c 'hrtimer_start.*function=hrtimer_wakeup' t.txt 
152241
# grep -c 'hrtimer_expire.*function=hrtimer_wakeup' t.txt 
1

The 150k timers which do not expire are related to the restarted
nanosleep(), because the nanosleep is canceled due to the signal and has
to be re-started.

On 6.10 that does not even reach the nanosleep in the test thread
because the thing is too busy with bogus signal handling.

Trace for 6.10

 stress-ng-timer-2229    [110] .....   187.938505: sys_timer_settime(timer_id: 0, flags: 0, new_setting: 7f7880228ec0, old_setting: 0)
 stress-ng-timer-2229    [110] d..2.   187.938505: hrtimer_start: hrtimer=0000000023e2c3e0 function=posix_timer_fn expires=186716941003 softexpires=186716941003 mode=ABS

Signal handler re-arms the timer

 stress-ng-timer-2229    [110] .....   187.938505: sys_timer_settime -> 0x0
 stress-ng-timer-2229    [110] .....   187.938506: sys_rt_sigreturn()

Returns from signal handler

 stress-ng-timer-2229    [110] d..1.   187.938506: posixtimer_rearm <-dequeue_signal

Dequeues the signal which was related to the arming _before_ the signal
handler re-arms it. So it's incorrectly delivered.

 stress-ng-timer-2229    [110] d.h..   187.938507: hrtimer_expire_entry: hrtimer=0000000023e2c3e0 function=posix_timer_fn now=186716941468

Now the timer which was armed in the signal handler above expires

 stress-ng-timer-2229    [110] .....   187.938507: sys_timer_getoverrun(timer_id: 0)
 stress-ng-timer-2229    [110] .....   187.938507: sys_timer_getoverrun -> 0x0

While the signal handler handles the bogus left over signal

Lather, rinse and repeat.

 stress-ng-timer-2229    [110] .....   187.938508: sys_timer_settime(timer_id: 0, flags: 0, new_setting: 7f7880228ec0, old_setting: 0)
 stress-ng-timer-2229    [110] d..2.   187.938508: hrtimer_start: hrtimer=0000000023e2c3e0 function=posix_timer_fn expires=186716943483 softexpires=186716943483 mode=ABS
 stress-ng-timer-2229    [110] .....   187.938508: sys_timer_settime -> 0x0
 stress-ng-timer-2229    [110] .....   187.938508: sys_rt_sigreturn()
 stress-ng-timer-2229    [110] d..1.   187.938508: posixtimer_rearm <-dequeue_signal
 stress-ng-timer-2229    [110] d.h..   187.938509: hrtimer_expire_entry: hrtimer=0000000023e2c3e0 function=posix_timer_fn now=186716943952

vs. 6.17

 stress-ng-timer-1828    [029] .....    84.089978: sys_rt_sigreturn()
 stress-ng-timer-1828    [029] d..1.    84.089979: posixtimer_deliver_signal <-dequeue_signal

Signal, which was generated by the original armed timer is correctly ignored

 stress-ng-timer-1828    [029] d..1.    84.089979: hrtimer_start: hrtimer=0000000081582a37 function=hrtimer_wakeup expires=83144889279 softexpires=83144839279 mode=REL

Nanosleep is restarted

          <idle>-0       [029] d.h1.    84.089980: hrtimer_expire_entry: hrtimer=000000009e0c5084 function=posix_timer_fn now=83134840265

Timer which was armed in the signal handler expires

 stress-ng-timer-1828    [029] d..1.    84.089981: posixtimer_deliver_signal <-dequeue_signal

Signal is delivered and timer is re-armed:

 stress-ng-timer-1828    [029] d..2.    84.089981: hrtimer_start: hrtimer=000000009e0c5084 function=posix_timer_fn expires=83134842396 softexpires=83134842396 mode=ABS

Signal is handled

 stress-ng-timer-1828    [029] .....    84.089982: sys_timer_getoverrun(timer_id: 0)
 stress-ng-timer-1828    [029] .....    84.089982: sys_timer_getoverrun -> 0x2
 stress-ng-timer-1828    [029] d.h..    84.089983: hrtimer_expire_entry: hrtimer=000000009e0c5084 function=posix_timer_fn now=83134842856

Re-armed timer expires and queues a signal

 stress-ng-timer-1828    [029] .....    84.089983: sys_timer_settime(timer_id: 0, flags: 0, new_setting: 7f7cccf7dec0, old_setting: 0)

Timer is re-armed

 stress-ng-timer-1828    [029] d..2.    84.089983: hrtimer_start: hrtimer=000000009e0c5084 function=posix_timer_fn expires=83134844444 softexpires=83134844444 mode=ABS
 stress-ng-timer-1828    [029] .....    84.089983: sys_timer_settime -> 0x0
 stress-ng-timer-1828    [029] .....    84.089983: sys_rt_sigreturn()

Signal, which was generated by the timer armed on signal dequeue is
correctly ignored

 stress-ng-timer-1828    [029] d..1.    84.089984: posixtimer_deliver_signal <-dequeue_signal


Thanks,

        tglx


