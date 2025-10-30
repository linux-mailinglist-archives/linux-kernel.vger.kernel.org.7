Return-Path: <linux-kernel+bounces-878401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BDBC2081A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26F23B112F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91A223DE8;
	Thu, 30 Oct 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJuUs2ey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B656B81
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833248; cv=none; b=fs9z0qydlXgaPJ5+w60RL+15N6GQVa4l2FQL3cVprATIEMY43VMWwuBlAvimF9S2d5BDcjN8vgPQvESIl0cozDml2IG/reTFcZ6zdnEshlDRuO1NKIN0Iq5I1sQJGjYmLz/GREurXc4Tb+l+I/k1DI2StH2A56kwCayw0WLEni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833248; c=relaxed/simple;
	bh=ElSuKqJi7YmoFgm6sGoqUg8kYUYstSWdd9WHWiRKB4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3InImaGp5XfAnnrxKme2DFJwOmEN9GuxkYnXSiLg2nF3HsC252lpvwEy36lbDf3KtAEwCkpyeoyrRpClcRrdgRlzY/CUVYVoMxkQ+CymNfxXx4WYDyCevojL2sicpvunUjlCgHjQEUXLpBhYRBq+QKF1LFOuehqVlh7oMfrP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJuUs2ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A210C4CEF8;
	Thu, 30 Oct 2025 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761833248;
	bh=ElSuKqJi7YmoFgm6sGoqUg8kYUYstSWdd9WHWiRKB4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJuUs2ey7RaoceKzXP3BAhCLGwW/6cpZG1UH33PXH7C03WML9SmP+tfW9u3ml7q0M
	 KmZ2k4dyfKUSr/aHyiqjRhOHG6GtqLDTm+hUoEMziCBkMu2QJ+P5doSIfpFVl6Pmgh
	 V0HZYrjBvtJcJpz2pHfwZgF+AHNgroOGjnnDRtbjNNqyrPZTl2ZXDcZQnhQBrJOYJq
	 qmKubWhG6J6xDOEDqOtifE3EhuNZsIwdGtabljsxEoQsF3J6sQF1MMhDKL7ffSk5RK
	 vFogArbVaDGwOfSoaYRQykZsKFLsEI8U/b0SUjYsaXDAoku6ZC3mHnwye4dJ3eE0QR
	 2+vZ6Oe/GPQmA==
Date: Thu, 30 Oct 2025 15:07:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RESEND PATCH v13 1/9] timers/migration: Postpone online/offline
 callbacks registration to late initcall
Message-ID: <aQNxHUQK8wrqGvuP@localhost.localdomain>
References: <20251020112802.102451-1-gmonaco@redhat.com>
 <20251020112802.102451-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020112802.102451-2-gmonaco@redhat.com>

Le Mon, Oct 20, 2025 at 01:27:54PM +0200, Gabriele Monaco a écrit :
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> During the early boot process, the default clocksource used for
> timekeeping is the jiffies. Better clocksources can only be selected
> once clocksource_done_booting() is called as an fs initcall.
> 
> NOHZ can only be enabled after that stage, making global timer migration
> irrelevant up to that point.
> 
> The tree remains inactive before NOHZ is enabled anyway. Therefore it
> makes sense to enable each CPUs to the tree only once that is setup.
> 
> Make the CPUs available to the tree on late initcall, after the right
> clocksource had a chance to be selected. This will also simplify the
> handling of domain isolated CPUs on further patches.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  kernel/time/timer_migration.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index c0c54dc5314c..891891794b92 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -1481,6 +1481,16 @@ static int tmigr_cpu_online(unsigned int cpu)
>  	return 0;
>  }
>  
> +/*
> + * NOHZ can only be enabled after clocksource_done_booting(). Don't
> + * bother trashing the cache in the tree before.
> + */
> +static int __init tmigr_late_init(void)
> +{
> +	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
> +				 tmigr_cpu_online, tmigr_cpu_offline);
> +}

I just worked on a fix in the timer migration code and this made me realize
my suggestion was plain wrong.

The CPU doing the prepare work for the target must be online because we must
guarantee that the old top level is active since we unconditionally propagate
its active state to the new top.

And if we do that late call to tmigr_cpu_online (after most CPUs have booted)
then we break that guarantee.

So I fear we can't do that and we must go back to your previous idea which
consisted in sending IPIs to apply isolation on late stage.

Sorry about the late brain :-s

-- 
Frederic Weisbecker
SUSE Labs

