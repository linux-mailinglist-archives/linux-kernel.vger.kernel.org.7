Return-Path: <linux-kernel+bounces-729675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7AEB03A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6CB188EF58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE12E3718;
	Mon, 14 Jul 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lh+axwBt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664D23C4E1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483552; cv=none; b=NIVqIdjwhUqATJeVt+D5eil476SPvefkzhL8SCkoXSwqFHHF1nsjDnqrDhTjLAQqxR+QFp0PxrF7i8rEmK/01lsBGb15ld1YyVD9+c8wtqFfN5i6A6QUaKhuqEhNgA0Y6d114BpXhRAsZ0Xxau5K6S0/Y25yfYqD0CHTZKn8alc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483552; c=relaxed/simple;
	bh=OntQVodFCtnQIELDbn5MJv3wY4VaG3/t+UChWeFjE0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyx6obObfCcDFysoGzVEQ3tBOXSX6zGhC4icMrP3+K0fgCevfG4lZmiGpt/3Ual84ZcsUwKAlfooecrA0WlCxR+L0KNKNPpKFwSaOA+H2ao6owqH2B4ybRsjCVmHVzpA2CmJrpGNRgJfaURv2qjPCFllzeAm+EqDyiNpzzItMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lh+axwBt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UtNRJei6Sj++tRR+4/eP9ytxxSQQIaA7UPDLZe1A9MU=; b=Lh+axwBtc6le0ggzqWQC9Ff4dJ
	D7zVESCcMmNHBO4JQO98bo7jzIQTCAoj78YvAYexwCx6QvmMKvmrLPJehZqFhxcjrIWjjypCMqvXB
	SB3rBcLJKwr3McYwnV6rnalrvtFtH+2MA/5loQZuTrU2mVUoAjssCEavMoDXvrFGX/36ble9S2erf
	VyFUY2oFBpblWgbEiL3Iisrs7c4evCrPQ5JaIrLGdOoO961UQlXuTBVua2WMgxpEIWY1jpsUe8Qq1
	EbYVjcDhzrqip8KrONWy61sgmNIkSHrQ88eldkxpoK7IdIFnpH91gG3JhFNfuN+XOg+Lbo58fBVA9
	s49Nlrjg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubF1Z-00000009j77-2gBB;
	Mon, 14 Jul 2025 08:59:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3724D3001AA; Mon, 14 Jul 2025 10:59:01 +0200 (CEST)
Date: Mon, 14 Jul 2025 10:59:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
	Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>,
	Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: [PATCH 3/5] sched/deadline: Fix accounting after global limits
 change
Message-ID: <20250714085901.GN905792@noisy.programming.kicks-ass.net>
References: <20250627115118.438797-1-juri.lelli@redhat.com>
 <20250627115118.438797-4-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627115118.438797-4-juri.lelli@redhat.com>

On Fri, Jun 27, 2025 at 01:51:16PM +0200, Juri Lelli wrote:

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 15d5855c542cb..be6e9bcbe82b6 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2886,6 +2886,12 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
>  	sched_domains_mutex_unlock();
>  	mutex_unlock(&mutex);
>  
> +	/*
> +	 * After changing maximum available bandwidth for DEADLINE, we need to
> +	 * recompute per root domain and per cpus variables accordingly.
> +	 */
> +	rebuild_sched_domains();
> +
>  	return ret;
>  }

So I'll merge these patches since correctness first etc. But the above
is quite terrible. It would be really good not to have to rebuild the
sched domains for every rt change. Surely we can iterate the existing
domains and update stuff?

