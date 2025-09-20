Return-Path: <linux-kernel+bounces-825592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A063B8C497
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F080E3BB6F7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BD229BDBF;
	Sat, 20 Sep 2025 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mujm31kw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ff4bMo/q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996A244671
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360594; cv=none; b=e6105rauRkzDhkuC5I4QZl6gVgJ945KQLF83KmRhvb0+ySppeqC1UjUAQfBC91NY362AyLwXmn6DHs7Iql+0WYt7cjFJ03esyLpsfrcPqdgE7opwNnWTczPhk775YRG6K71SZWpbGtJtqlkE8haV+frO1TXV0SRr3BUR4k5jFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360594; c=relaxed/simple;
	bh=APGCwi/fO/ArCCNwyud1qTuYzoi5rLqhblhnoOoFYb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iCkabzXDuHeBgMOBPLMuiA/5V/7h6gE9mMaX7v98iH1kqwNv+6XhBMuRTV4P5GG8Cj14d1nTfVUsH49Fe0729Jcq1WXosW9sHLaj0Z3s4Fjq9ucvJT9t/KLTYrdiew7GMSAEnxojUY1ZR8SuvBGPulWyqK6PoR0BHCqTwILkw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mujm31kw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ff4bMo/q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758360585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+iszOu57bJi1eGrUOfZoiWvjbmFORBs+9R/VPl571KM=;
	b=Mujm31kw0QIOIkCwHM0614/8VPgxE7zAjE7TImRG5AJTtjGsPq4bAoh+RIseXh1IJfijTL
	pTueHCUNtjG915ONc4ksplmyf4mmcASha6ccovaEO/KidP7Cz4X+drMlHygA3UGBIk5DTH
	3z9SVJHO1m6ZXFYpDp50ntVwVcz92Gt3RRKBWfNKpATad9e83qAYBMcflZiHz7wAtUhOu2
	UtAmUjsYzC35vSWmEWPztNou9JOTOvWVmVjhDfiqWwEJKEF2V8cRlTV0G1NyrT85xVavBx
	XE4e6QJFomyfzH2CmQppcB7ldLNR40i0hx6+xCQgXRJGO8N6WLSvYA7QB0+P/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758360585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+iszOu57bJi1eGrUOfZoiWvjbmFORBs+9R/VPl571KM=;
	b=ff4bMo/q5xfr+cflhOQ5T3QfqLWtSM49tmuIOG/2H+RW37txPZGB2LMUIR1M3YmvU2hWfg
	mbpmHJx6Xz4LOTBA==
To: Peter Zijlstra <peterz@infradead.org>
Cc: arnd@arndb.de, anna-maria@linutronix.de, frederic@kernel.org,
 peterz@infradead.org, luto@kernel.org, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: Re: [RFC][PATCH 7/8] entry,hrtimer: Push reprogramming timers into
 the interrupt return path
In-Reply-To: <20250918080206.180399724@infradead.org>
References: <20250918075219.091828500@infradead.org>
 <20250918080206.180399724@infradead.org>
Date: Sat, 20 Sep 2025 11:29:43 +0200
Message-ID: <875xdd8oag.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 18 2025 at 09:52, Peter Zijlstra wrote:
> Currently hrtimer_interrupt() runs expired timers, which can re-arm
> themselves, after which it computes the next expiration time and
> re-programs the hardware.
>
> However, things like HRTICK, a highres timer driving preemption,
> cannot re-arm itself at the point of running, since the next task has
> not been determined yet. The schedule() in the interrupt return path
> will switch to the next task, which then causes a new hrtimer to be
> programmed.
>
> This then results in reprogramming the hardware at least twice, once
> after running the timers, and once upon selecting the new task.
>
> Notably, *both* events happen in the interrupt.
>
> By pushing the hrtimer reprogram all the way into the interrupt return
> path, it runs after schedule() and this double reprogram can be
> avoided.
>
> XXX: 0-day is unhappy with this patch -- it is reporting lockups that
> very much look like a timer goes missing. Am unable to reproduce.
> Notable: the lockup goes away when the workloads are ran without perf
> monitors.

After staring at it for a while, I have two observations.

1) In the 0-day report the lockup detector triggers on a spinlock
   contention in futex_wait_setup()

   I'm not really seeing how that's related to a missing timer.

   Without knowing what the other CPUs are doing and what holds the
   lock, it's pretty much impossible to tell what the hell is going on.

   So that might need a back trace triggered on all CPUs and perhaps
   some debug output in the backtrace about the hrtimer state.

   On the CPU where the lockup is detected, the timer is working.


2) I came up with the following scenario, which is broken with this
   delayed rearm.

   Assume this happens on the timekeeping CPU.

      hrtimer_interrupt()
        expire_timers();
        set(TIF_REARM);

      exit_to_user_mode_prepare()
        handle_tif_muck()
          ...
          to = jiffies + 2;
          while (!cond() && time_before(jiffies, to))
          	relax();

     If cond() does not become true for whatever reason, then this won't
     make progress ever because the tick hrtimer which increments
     jiffies is not happening.

     It can also be a wait on a remote CPU preventing progress
     indirectly or a subtle dependency on a timer (timer list or
     hrtimer) to expire.

  I have no idea whether that's related to the reported 0-day fallout,
  but it definitely is a real problem lurking in the dark.

Thanks,

        tglx

