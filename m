Return-Path: <linux-kernel+bounces-796465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA2B40102
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD49A7B6DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1E2C032C;
	Tue,  2 Sep 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a97TVXO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065221E9B3A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817110; cv=none; b=ntVIGCfB+TKzBthHjVXP7J/gYPliuWi6J+5NXe9g1MhG+tlayG4uaS9a3DX++Fx+dZqoEif7DjSU8fnNpvAbnjXJFh1WlYamc2ReWQgNj4vjEAgoQ9XMzc51N0corWqyv97GefHtmRzY2RdZOozGZHmNUAbkIY361sOYTou1p2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817110; c=relaxed/simple;
	bh=9BmRlT+BJOmmJrsaNhcwbX6i45q2i2uMT/N4Iz1vys4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9GR0Rm876oy46kI+VSzC1zujZ9kIgKs8ZBmLqS08eQrPdcfy/6QlJR64yHhyWmGnkavxuSbC6U/pglmOtpFhnUOpBmvCJqxGpWynnnT/EXQiu/hL93ie5ZhzeSc5sfZWqPCYJkbgCTiKFFTU31Pf7QSd8+q47fdoAFeDza6EYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a97TVXO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBFEC4CEED;
	Tue,  2 Sep 2025 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756817109;
	bh=9BmRlT+BJOmmJrsaNhcwbX6i45q2i2uMT/N4Iz1vys4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a97TVXO+ikAQctsQzsVWkJ2F3joGpfx1Ueo0dMD8sQkg2oi1M+Sigt95+TkwBImOe
	 uk0HOb1dy1pkgZWDgvggJ1iKrDtaZzQQZvNNZNDxxM5WnLuypXbzJD3oEKHBBlf4p+
	 fNxiCtu2KTeYdOJtVbSS2NuJX1JBY1D/Qhe+ZCfU9PB/rmLvjC2SwkjEUIn5c3lFj1
	 JwUePvEu0t7af393BjyJrOj6XIjZl5cJUFNF8MBhkMG3b57ELypbI1eHRn+efeyf3r
	 1mtXl4ir7TlC3qdWdMytsnlrsL8DelHwHBLkwEsi8tZE42tj2nSYWpEaQWQXU3Pqc6
	 pzckRVEI8zHNw==
Date: Tue, 2 Sep 2025 14:45:06 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v11 8/8] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aLbm0srwDJVpt8cM@localhost.localdomain>
References: <20250808160142.103852-1-gmonaco@redhat.com>
 <20250808160142.103852-9-gmonaco@redhat.com>
 <aLWUkpKgFFVr_TEx@localhost.localdomain>
 <d001f1bc9a87e031cf4f8721d6843013c766c28a.camel@redhat.com>
 <aLYMA8niL9Uxhu7G@pavilion.home>
 <ab9348b0e67f36dea92922bf76aadb7fe9d1667a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab9348b0e67f36dea92922bf76aadb7fe9d1667a.camel@redhat.com>

Le Tue, Sep 02, 2025 at 01:08:25PM +0200, Gabriele Monaco a écrit :
> On Mon, 2025-09-01 at 23:11 +0200, Frederic Weisbecker wrote:
> > Le Mon, Sep 01, 2025 at 03:48:15PM +0200, Gabriele Monaco a écrit :
> > > On Mon, 2025-09-01 at 14:41 +0200, Frederic Weisbecker wrote:
> > > > Why not evaluate tick_nohz_cpu_hotpluggable() from
> > > > tmigr_clear_cpu_available() instead of this force IPI?
> > > 
> > > The idea is that this IPI runs once during late boot only for the
> > > tick CPU, while the call to tick_nohz_cpu_hotpluggable() would be
> > > running at every hotplug event if I move it to
> > > tmigr_clear_cpu_available. In that scenario, it's guaranteed to
> > > return true (besides the very first call).
> > > 
> > > I don't have a strong opinion against running that check every time
> > > although it's needed only at boot time and remove this IPI, but in
> > > my understanding that's one of the thing Thomas was finding
> > > confusing [1].
> > > 
> > > Am I missing anything here?
> > 
> > Right, Thomas didn't like it, but the organization of the code has
> > changed a bit since then with the late initcall. If the best we can
> > do to workaround the situation is to make the CPU unavailable
> > regardless and then undo that right after with an IPI, then it's a
> > good sign that we should just simplify and eventually check
> > tick_nohz_cpu_hotpluggable() from tmigr_is_isolated().
> 
> Makes sense.
> I'd be tempted using a static branch but since the call to
> tick_nohz_cpu_hotpluggable() isn't really heavy, we can just be fine
> including it in the tmigr_is_isolated() check.

Right.

> 
> 
> > > > But if I understand correctly, this will be handled by cpuset,
> > > > right?
> > > 
> > > Currently tick_nohz_cpu_hotpluggable() is called by
> > > tmigr_should_isolate_cpu() and that is called by cpuset code,
> > > changing cpuset would save that call but won't deal with the tick
> > > CPU not enabled at boot time, unless I'm misunderstanding what
> > > Waiman implied.
> > 
> > Good point!
> 
> Here I'm a bit unsure how to proceed though. We want to fail any single
> isolated cpuset that includes the tick CPU under nohz_full. I can do it
> directly in isolcpus_nohz_conflict and that looks easy.
> 
> But is that going to be clear for the user?
> Can the user even know what the tick CPU is? Besides /assuming/ 0.

You're right the user can't know in advance which CPU is the tick.
I don't mind if we prevent or not cpuset from allowing to isolate
the timekeeper but either way, a pr_info() could be helpful to tell
that either:

* The isolated timekeeper will have limited isolation
or
* The timekeeper can't be isolated.

Thanks.

> 
> Thanks,
> Gabriele
> 
> > Thanks.
> > 
> > > 
> > > Thanks,
> > > Gabriele
> > > 
> > > [1] - https://lore.kernel.org/lkml/875xgqqrel.ffs@tglx
> > > 
> 

-- 
Frederic Weisbecker
SUSE Labs

