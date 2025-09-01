Return-Path: <linux-kernel+bounces-794332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B4B3E01A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE417EDFF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FE30E0F1;
	Mon,  1 Sep 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PKSR8Pbq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DE2EE260
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722407; cv=none; b=WRv2YCPPQRCFuAJ9eFD9l+xp1IY9mlj80Z9OdCukPEkbjEXymZFfoeo976CmFifHUNliRUg5nR/u3kseHruTdTGU0y7nRdUAXXw8ZQyv2pPo9f8pISq1IQz20tqFOw9P8Sv7AHvg3Gpp/Bm2UtuVWBmTfmoU4H+vlS79ldhoyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722407; c=relaxed/simple;
	bh=qRbOhP2Hk3coT26m0WVj9EMJQnMmn/YhzGu5B64C9qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVjaahFx0QE/ogY8zInLAcIaLpcRhQRDr8rC4QKR8bJHvi6RL/Tl6Pu20BVbJ9lchbmgUsDSlgG6XvvDpTgvGw5xbEH/JY+6tkkTBl59KchHonRfXxzcB84/fF4By0ytXsJZPETfQ0Myzz3BLYfcbQzmYTULtQ6DrI3mL88XAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PKSR8Pbq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j1kKbV5d4unXat77+A/yhxjotz/ONZ6osi4fbj/byZk=; b=PKSR8Pbqps1Kv1zUiviWXXiah8
	Avqfp8WKEK+RHcpQcu42jPkII2XkWQlIxj3vwx7xJ9ykXQedn/VzrcN3oz2WmsnbdBFhKQble2pA5
	qgzQvFyymyg8bCgPPAudk3SYvrsrtsK8tjEnv2U5DWdnTdi0+eR2RuRPzlKRUK0xksXhrkjUdy/3D
	XfO49hWYDv5FcX6sdnvf+i9ZivzY19x6X8+hw5/kYxWCcWOFt7QWtVmUnZIqufQ20ObuMOqnj5nhI
	S5gslic6YL9OXKp2O2EwAkmdLnuhoemlnJUX3704t5ArLLcS9fjOkM7yV/UcVKqv7h94VBbEWWfOu
	6BojnXVQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut1kI-00000006cpp-3k6i;
	Mon, 01 Sep 2025 10:26:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A63AD300342; Mon, 01 Sep 2025 12:26:42 +0200 (CEST)
Date: Mon, 1 Sep 2025 12:26:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 01/33] sched/isolation: Remove housekeeping static key
Message-ID: <20250901102642.GH4067720@noisy.programming.kicks-ass.net>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829154814.47015-2-frederic@kernel.org>

On Fri, Aug 29, 2025 at 05:47:42PM +0200, Frederic Weisbecker wrote:

> +static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> +{
> +	if (housekeeping_flags & BIT(type))
> +		return housekeeping_test_cpu(cpu, type);
> +	else
> +		return true;
> +}

That 'else' is superfluous.

> -static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> -{
> -#ifdef CONFIG_CPU_ISOLATION
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		return housekeeping_test_cpu(cpu, type);
> -#endif
> -	return true;
> -}
>  
>  static inline bool cpu_is_isolated(int cpu)
>  {
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index a4cf17b1fab0..2a6fc6fc46fb 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -16,19 +16,13 @@ enum hk_flags {
>  	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
>  };
>  
> -DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
> -EXPORT_SYMBOL_GPL(housekeeping_overridden);
> -
> -struct housekeeping {
> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
> -	unsigned long flags;
> -};
> -
> -static struct housekeeping housekeeping;
> +static cpumask_var_t housekeeping_cpumasks[HK_TYPE_MAX];
> +unsigned long housekeeping_flags;
> +EXPORT_SYMBOL_GPL(housekeeping_flags);

I don't particularly like exporting variables much. It means modules can
actually change the value and things like that.

And while an exported static_key can be changed by modules, that's
fixable.

