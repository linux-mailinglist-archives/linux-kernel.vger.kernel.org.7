Return-Path: <linux-kernel+bounces-795345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C92B3F055
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3629B4E06B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D53262FFF;
	Mon,  1 Sep 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ottzyoSR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0F8136347
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761095; cv=none; b=ZQQyqgTViQHaWz6pAUVqbj4Cu2Jq0Ejz1pNufvlsuQBM0OvR8PlM3HQrg381xV1Dfckv2W5aH9hY3/zHCXpcm7xHsRLbPJoAX8jsq2tlh/7bYzTeXoUdvjrYtpA8x7UnbSU+tPm5wXuIxZEiNFORkJnr4sk8q/Ofvo2wLpVi4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761095; c=relaxed/simple;
	bh=cO3eEDyjLZrEEcqQpTt97cAeIPZUXGBMByKvTkbGv1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZAr5PttVsy8JsZIBBa6gRi/XlgPUfOEETxwDalWl5JZqB1e+0CIS+TC/FHgmSEUbVM4pM8/txhdc+RnPgJRZj14pla3ZQ2u+4Y05FkXgFfJfvE+9yhB6tm9+GV1+O6r5OZHzalZ9PuOCEl9rIAaN4WJB8i9PDM7+OwjPq9+/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ottzyoSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765BFC4CEF0;
	Mon,  1 Sep 2025 21:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761094;
	bh=cO3eEDyjLZrEEcqQpTt97cAeIPZUXGBMByKvTkbGv1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ottzyoSRlp09ZHXupZXhMMq2sBGe1BZ7A0047xWTAVzFJGrMv65+y5E8JJbBfArvO
	 MiLj6wAL3hXqGtI6sEojXBL1IRalSq1LXVj+SbT26+KekjIImsDpFZc2Tsm8teQ4eu
	 D5YzXCS3gajMFZ/qx+D+HzOF1jRZHpCGCm7y/D5YXiN0ZM1Tqv7h9WH7h9DBR4okFc
	 Zar0e4s6jrHcp9QKGD4brdGLSKmnDS674s4b9AqnAtNTkkdYQtGa+4jbxPDudm5ciw
	 EIWmTmf/2U0DImqN47bWnJ74F2iUlMKgVdocZ+RThdzs5K0r7HJYgj2PG8C35K3XVG
	 LJuL6bkqnTsyQ==
Date: Mon, 1 Sep 2025 23:11:31 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v11 8/8] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aLYMA8niL9Uxhu7G@pavilion.home>
References: <20250808160142.103852-1-gmonaco@redhat.com>
 <20250808160142.103852-9-gmonaco@redhat.com>
 <aLWUkpKgFFVr_TEx@localhost.localdomain>
 <d001f1bc9a87e031cf4f8721d6843013c766c28a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d001f1bc9a87e031cf4f8721d6843013c766c28a.camel@redhat.com>

Le Mon, Sep 01, 2025 at 03:48:15PM +0200, Gabriele Monaco a écrit :
> On Mon, 2025-09-01 at 14:41 +0200, Frederic Weisbecker wrote:
> > Le Fri, Aug 08, 2025 at 06:01:42PM +0200, Gabriele Monaco a écrit :
> > >  /*
> > >   * NOHZ can only be enabled after clocksource_done_booting().
> > > Don't
> > >   * bother trashing the cache in the tree before.
> > >   */
> > >  static int __init tmigr_late_init(void)
> > >  {
> > > -	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE,
> > > "tmigr:online",
> > > -				 tmigr_set_cpu_available,
> > > tmigr_clear_cpu_available);
> > > +	int cpu, ret;
> > > +
> > > +	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE,
> > > "tmigr:online",
> > > +				tmigr_set_cpu_available,
> > > tmigr_clear_cpu_available);
> > > +	if (ret)
> > > +		return ret;
> > > +	/*
> > > +	 * The tick CPU may not be marked as available in the
> > > above call, this
> > > +	 * can occur only at boot as hotplug handlers are not
> > > called on the
> > > +	 * tick CPU. Force it enabled here.
> > > +	 */
> > > +	for_each_possible_cpu(cpu) {
> > > +		if (!tick_nohz_cpu_hotpluggable(cpu)) {
> > > +			ret = smp_call_function_single(
> > > +				cpu, tmigr_cpu_unisolate_force,
> > > NULL, 1);
> > > +			break;
> > > +		}
> > > +	}
> > 
> > Why not evaluate tick_nohz_cpu_hotpluggable() from
> > tmigr_clear_cpu_available() instead of this force IPI?
> 
> The idea is that this IPI runs once during late boot only for the tick
> CPU, while the call to tick_nohz_cpu_hotpluggable() would be running at
> every hotplug event if I move it to tmigr_clear_cpu_available.
> In that scenario, it's guaranteed to return true (besides the very
> first call).
> 
> I don't have a strong opinion against running that check every time
> although it's needed only at boot time and remove this IPI, but in my
> understanding that's one of the thing Thomas was finding confusing [1].
> 
> Am I missing anything here?

Right, Thomas didn't like it, but the organization of the code has changed
a bit since then with the late initcall. If the best we can do to workaround
the situation is to make the CPU unavailable regardless and then undo that
right after with an IPI, then it's a good sign that we should just simplify
and eventually check tick_nohz_cpu_hotpluggable() from tmigr_is_isolated().

> > But if I understand correctly, this will be handled by cpuset, right?
> 
> Currently tick_nohz_cpu_hotpluggable() is called by
> tmigr_should_isolate_cpu() and that is called by cpuset code, changing
> cpuset would save that call but won't deal with the tick CPU not
> enabled at boot time, unless I'm misunderstanding what Waiman implied.

Good point!

Thanks.

> 
> Thanks,
> Gabriele
> 
> [1] - https://lore.kernel.org/lkml/875xgqqrel.ffs@tglx
> 

-- 
Frederic Weisbecker
SUSE Labs

