Return-Path: <linux-kernel+bounces-874552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1451C168EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0910402D98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F6B34E769;
	Tue, 28 Oct 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUJ+29KD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7234DB51
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678181; cv=none; b=MCQAyBCEKTunAwHm53CN8zPK8NY5Y70G6ga3JH4hCaWdALIt5yUPAnCPwjewoQDKzoD4sUhQCZg3H2Uf9f1IQQOqfdw0N0shejDQMKwBPeoE9VEppbvFoFKvD9oLJ9CqIicMZyII+GrNc4AkxgcJyi/+EIyqBgGSEni4aVDsHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678181; c=relaxed/simple;
	bh=rkQq1RNk1aVsahWPRSNiD4RXJGQtROzmUlElWkqAf1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd/PHJZS3Qqul8g2MXhDV/bDQnkgN3gE1o8Y7QqahWIX9DQSx+c96tXoi51FAhkOoG5NnJSs/Fa9meK2yLwBzA9KzK315u8Bs+ehIp8yN5OCyyN1hSSyMhHLiZbZ6jpz1EI+vre5J0JZwYqIMFcLQl1Wq4Whb6LHUg0KA3sUPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUJ+29KD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCE2C4CEE7;
	Tue, 28 Oct 2025 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761678180;
	bh=rkQq1RNk1aVsahWPRSNiD4RXJGQtROzmUlElWkqAf1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QUJ+29KD4//9YcRJKYpZaIWxVFumooAqTwwnMmNc1EYD0DjAPMhoVpWAnnyoqyYAg
	 ekKkflffc7z7nBasxlHpAxgRxaATTWt7ovz96vaSpY/nWu7tSXjQEx9D5mvpFVMWEz
	 0shiKNyeClf/7X3czfRhlY9jqK9cFSLqI+aDCUQmSUl6eVV2OObaFcfM/aZwTqh/WV
	 H3+W34ZBZWebfaAalaupMKcI5bawl4kvjMnf6MXU8qY9mu2lwF71zDoraIuExMx0SH
	 evr2CeNKe7SickRj5lm52632O0i5tfTGKpAPzPZAQiECUJtf7PWu3kwHJ2N+lvlO2X
	 OGJYopU8AH1GQ==
Date: Tue, 28 Oct 2025 12:02:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] perf/x86: Add cond_resched() when allocate/release DS
 buffers
Message-ID: <aQETYiqpEo5IcTXN@google.com>
References: <20251027212724.1759322-1-namhyung@kernel.org>
 <20251028141518.GA4067720@noisy.programming.kicks-ass.net>
 <20251028152747.GR4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028152747.GR4068168@noisy.programming.kicks-ass.net>

Hi Peter,

On Tue, Oct 28, 2025 at 04:27:47PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 28, 2025 at 03:15:18PM +0100, Peter Zijlstra wrote:
> > On Mon, Oct 27, 2025 at 02:27:24PM -0700, Namhyung Kim wrote:
> > > On large systems, it's possible to trigger sched latency warning during
> > > the DS buffer allocation or release.  Add cond_resched() to avoid it.
> > 
> > We're >.< close to deleting cond_resched(), it makes absolutely no sense
> > adding more.
> 
> Specifically, IIRC the plan was to do something like the below after the
> next LTS release, and then continue to remove VOLUNTARY in subsequent
> releases, leaving NONE the only option for the legacy architectures that
> do not support preemption.

Thanks for your review!

I haven't followed the work in this area so was not aware of the
PREEMPT_LAZY.  Looks great!  I hope it'll work well on server platforms
with many batch jobs and interactive tasks.

I will drop my patch then.

Thanks,
Namhyung

> 
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index da326800c1c9..db4ae53c1d49 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -16,11 +16,12 @@ config ARCH_HAS_PREEMPT_LAZY
>  
>  choice
>  	prompt "Preemption Model"
> -	default PREEMPT_NONE
> +	default PREEMPT_LAZY
>  
>  config PREEMPT_NONE
>  	bool "No Forced Preemption (Server)"
>  	depends on !PREEMPT_RT
> +	depends on ARCH_NO_PREEMPT
>  	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
>  	help
>  	  This is the traditional Linux preemption model, geared towards
> @@ -35,8 +36,8 @@ config PREEMPT_NONE
>  
>  config PREEMPT_VOLUNTARY
>  	bool "Voluntary Kernel Preemption (Desktop)"
> -	depends on !ARCH_NO_PREEMPT
>  	depends on !PREEMPT_RT
> +	depends on ARCH_NO_PREEMPT
>  	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
>  	help
>  	  This option reduces the latency of the kernel by adding more

