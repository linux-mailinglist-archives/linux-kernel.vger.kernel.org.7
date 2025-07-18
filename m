Return-Path: <linux-kernel+bounces-737348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB5DB0AB35
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7534E1C4340F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F6321C9E5;
	Fri, 18 Jul 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3AHbLCHa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lagEFNVx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B351CA84;
	Fri, 18 Jul 2025 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752872008; cv=none; b=HL3Ui/C12+tn615OLFrYpUO24Dz2kON6u1zPO3cXVeDnhlDotdIPs3hejZpp2cctm/aTd0gK+LBiKyokGXRLx5+QXlf8twQrtlBsg+CCEdZbG2RU7wutydseAm1p7BST9v4ib+Rrse5lxCd26IL/+kedEDM8FbY/QT1b2d1M5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752872008; c=relaxed/simple;
	bh=xLNKt/lWj0ahP/K+1RUOTT9zzV2/lT3d5fXlStGDV/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ooSSujdsPcu1o6JjrjqdEPS+S/mKZlTYS757+CtH5E/57f4B7GXE3ljxb8Bq/IUkHnLTieYEgyBD3dY6mMhmAuZRJKBG7tVZpMuKqyiDsijDD7LSAjE7mvvOCWBxXwygIYXBSjr7VfshDBSlxPN+3PRJl3KxcJt2Uz97LMMUB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3AHbLCHa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lagEFNVx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752872004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iK1R06UG5GJ6VRHa5zdFleL46v8S6s7PAcqB3w2iutI=;
	b=3AHbLCHa7+jKYUHB0ivi7XaWOkknPY6VTBPI2djDbc/25K9eyUT/eyxD7LOHAo5LdNhldQ
	WcwrIOS49+xfijFwJNi8wxvKJLfLOPT2e+0/A9vC6aK9EaUszaUZs50q9FRQARGpXaIGRR
	WPsLTyq/I/eFUWLbgTpJCGKQuj3j96v0VxHgggaGQeWpBmxgtQFV8tq5zqCIb+BmlsvhIZ
	A8eML6ks3VGRS+S9swz6yuNrZx1KQsvh2bbLDSbhn6rVHZxh+RHGnfb4K494Yz75wUhLj3
	bLw6W4qf2cbO68n6frXcvYum36Bqe4QLjgq7x6OdAdnuN/KoL2XgVZc67+gfhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752872004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iK1R06UG5GJ6VRHa5zdFleL46v8S6s7PAcqB3w2iutI=;
	b=lagEFNVxsKJhSl4DAbk7Y2h30PFz1bCuPZJmyNXJ+8kQrNpxpImmAnE8qYxLnUnAARLxJQ
	IQzgWVLwQVQAtOBg==
To: Wladislav Wiebe <wladislav.wiebe@nokia.com>, corbet@lwn.net
Cc: akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, bp@alien8.de, arnd@arndb.de,
 fvdl@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 wladislav.wiebe@nokia.com, peterz@infradead.org
Subject: Re: [PATCH v2] genirq: add support for warning on long-running IRQ
 handlers
In-Reply-To: <20250714084209.918-1-wladislav.wiebe@nokia.com>
References: <20250714084209.918-1-wladislav.wiebe@nokia.com>
Date: Fri, 18 Jul 2025 22:53:23 +0200
Message-ID: <877c05w798.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 14 2025 at 10:41, Wladislav Wiebe wrote:
> This patch adds a mechanism to detect and warn about long-running IRQ

# git grep 'This patch' Documentation/process/

Also please read:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> +static int __init irqhandler_duration_check_setup(char *arg)
> +{
> +	unsigned long val;
> +	int ret;
> +
> +	if (!arg)
> +		return 0;
> +
> +	ret = kstrtoul(arg, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > 0) {
> +		irqhandler_duration_threshold_us = val;
> +		static_branch_enable(&irqhandler_duration_check_enabled);
> +	} else {
> +		pr_err("Invalid irqhandler.duration_warn_us setting (%lu)\n", val);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +early_param("irqhandler.duration_warn_us", irqhandler_duration_check_setup);

Why early_param? Nothing cares about this during early boot.

> +static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
> +					      struct irqaction *action)
> +{
> +	u64 delta_us = (local_clock() - ts_start) >> 10;

Lacks a comment that this is an intentional approximation.

> +	if (unlikely(delta_us > irqhandler_duration_threshold_us)) {
> +		pr_warn_ratelimited("[CPU%d] long duration on IRQ[%u:%ps], took: %llu us\n",
> +			smp_processor_id(), irq, action->handler, delta_us);

Please align the arguments in the second line properly.

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#line-breaks

> +	}
> +}
> +
>  irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
>  {
>  	irqreturn_t retval = IRQ_NONE;
> @@ -146,6 +184,7 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
>  
>  	for_each_action_of_desc(desc, action) {
>  		irqreturn_t res;
> +		u64 ts_start;

This wants to be in the if() branch where it is actually used.

>  		/*
>  		 * If this IRQ would be threaded under force_irqthreads, mark it so.
> @@ -155,7 +194,14 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
>  			lockdep_hardirq_threaded();
>  
>  		trace_irq_handler_entry(irq, action);
> -		res = action->handler(irq, action->dev_id);
> +
> +		if (static_branch_unlikely(&irqhandler_duration_check_enabled)) {
> +			ts_start = local_clock();
> +			res = action->handler(irq, action->dev_id);
> +			irqhandler_duration_check(ts_start, irq, action);
> +		} else
> +			res = action->handler(irq, action->dev_id);
> +

Even if not required by C, the else clause wants brackets too for
symmetry.

        if (foo)
        	bar();
        else
                baz();

parses perfectly fine.

        if (foo) {
                do_stuff();
        	bar();
        } else
                baz();

is asymmetrical and disturbs the reading flow, which is pattern
based. The extra brackets just make it easier to parse:

        if (foo) {
                do_stuff();
        	bar();
        } else {
                baz();
        }

See?

Thanks,

        tglx

