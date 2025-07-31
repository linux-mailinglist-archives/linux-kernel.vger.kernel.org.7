Return-Path: <linux-kernel+bounces-752673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7B0B17935
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5EE1C248CC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4902B27F010;
	Thu, 31 Jul 2025 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqu/qKrg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F29427EC73
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002480; cv=none; b=dbUF/Jz2efr1tPA40eM6wOygW6zj9FfsDCIqayEcHzbySU7ulTZXfZvMBja0967XCFymz839AcSXCSCs10x6u+eX0OI4TEYOcWIcKEqNQD9Bgr4unptLLlJLzNXzvdu1ZCaRLmbxmeCLP75E9G288wnL7IIaxGi13u/W+ZTvxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002480; c=relaxed/simple;
	bh=1c18v8PDnN/LBJvUPvFVu6eW13LKMcTFSGS+VNQHBxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttyVeVCvxEqZ0txjrpw36gQVxxQ1NSD8tVoqP7VKx5UDLeNKBqFTDx/K7GRwRg/kYqRW6SxNR/bDJriFGPXPjtb89PC+qs3zQYHekCRiW5Pu8Zd1RQmiB7ItYgX8sKP07FF3mV+1o9Rx0r2Biee5jjlwh8YW+FMFShfpqE1r2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqu/qKrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6C8C4CEEF;
	Thu, 31 Jul 2025 22:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754002480;
	bh=1c18v8PDnN/LBJvUPvFVu6eW13LKMcTFSGS+VNQHBxk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Gqu/qKrgI96cWLCe8CiNebb7hZR0x1V/VjXSJHdx+axQNWHeHlfZYTusS/SzQUqx+
	 krKJIwTrvB29m3OKHGsFLArin6QEXopNQIyHSwPbWOFPf9YYugB+/fPO/7jygUfp3v
	 /CQ00djVjpINCC7iFEwrscOePAhKFp1yISb0LiJkX8l9gWu+h0r2LjPytbXXOtdwtm
	 IPpcDNsMCcjMztzDvmM9RSVqZpOSyWWniXFONgieFQ/4HbGuLsdPcqx2x5N0PROgwX
	 VO9oZw6e7+g2FREDJGKRJmKunzxtc/c988V1XKNIMgwtPGMcCcd/CknYyIH11K4Pcl
	 mQ9eJUzR2sa0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BBA03CE09FA; Thu, 31 Jul 2025 15:54:39 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:54:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] clocksource: Print durations for sync check
 unconditionally
Message-ID: <d8aa492c-a5b3-46d5-986e-6e6aa5260d21@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <aIuXXfdITXdI0lLp@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIuXXfdITXdI0lLp@incl>

On Thu, Jul 31, 2025 at 06:18:37PM +0200, Jiri Wiesner wrote:
> A typical set of messages that gets printed as a result of the clocksource
> watchdog finding the TSC unstable usually does not contain messages
> indicating CPUs being ahead of or behind the CPU from which the check is
> carried out. That fact suggests that the TSC does not experience time skew
> between CPUs (if the clocksource.verify_n_cpus parameter is set to a
> negative value) but quantitative information is missing.
> 
> The cs_nsec_max value printed by the "CPU %d check durations" message
> actually provides a worst case estimate of the time skew. If all CPUs have
> been checked, the cs_nsec_max value multiplied by 2 is the maximum
> possible time skew between the TSCs of any two CPUs on the system. The
> worst case estimate is derived from two boundary cases:
> 
> 1. No time is consumed to execute instructions between csnow_begin and
> csnow_mid while all the cs_nsec_max time is consumed by the code between
> csnow_mid and csnow_end. In this case, the maximum undetectable time skew
> of a CPU being ahead would be cs_nsec_max.
> 
> 2. All the cs_nsec_max time is consumed to execute instructions between
> csnow_begin and csnow_mid while no time is consumed by the code between
> csnow_mid and csnow_end. In this case, the maximum undetectable time skew
> of a CPU being behind would be cs_nsec_max.
> 
> The worst case estimate assumes a system experiencing a corner case
> consisting of the two boundary cases.
> 
> Always print the "CPU %d check durations" message so that the maximum
> possible time skew measured by the TSC sync check can be compared to the
> time skew measured by the clocksource watchdog.
> 
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>

Works at this end:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/time/clocksource.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index e400fe150f9d..3eeb18233a6b 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -410,9 +410,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
>  	if (!cpumask_empty(&cpus_behind))
>  		pr_warn("        CPUs %*pbl behind CPU %d for clocksource %s.\n",
>  			cpumask_pr_args(&cpus_behind), testcpu, cs->name);
> -	if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind))
> -		pr_warn("        CPU %d check durations %lldns - %lldns for clocksource %s.\n",
> -			testcpu, cs_nsec_min, cs_nsec_max, cs->name);
> +	pr_info("        CPU %d check durations %lldns - %lldns for clocksource %s.\n",
> +		testcpu, cs_nsec_min, cs_nsec_max, cs->name);
>  }
>  EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
>  
> -- 
> 2.43.0
> 
> 
> -- 
> Jiri Wiesner
> SUSE Labs

