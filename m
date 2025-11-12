Return-Path: <linux-kernel+bounces-897678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4F9C53741
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18594A7A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65673446A9;
	Wed, 12 Nov 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI/kqDtv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9E343D79
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963453; cv=none; b=AkT5FHlaOnO7jSXTXMai36KE4yb8QoP0ofcqlA6kdVj60mNxjlKsnW3ItLDX5NVn92sqAuWYo70ouDhsQK8YCCcekWCF86Pk/nBJRPqFrhVklJxMeH/Lt6LzDvIOInoYumXLD9JMx4Cypwm2P86s6viDWTfzH9IAhNIP+XYvY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963453; c=relaxed/simple;
	bh=8B2q/pY4HluVQKjHZ0UEBhmF/zuqAWxUAaw3utN01NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoQ5C5MWK9d5fI0TItSRhxXVIZaZo0/phJs+MrD/8Pax8wZ5BdUGcOAKlMzEl5JItm+3BTarQtQkENJdTQRHqeYVZ6qtteK0ne63iStJIrll1YFGa6pF6kMxM1Fx84RbJ7EcZVgm0KiGHuLdlKqtJjyh/p+mSBMdIji1ZLNyiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI/kqDtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA81AC113D0;
	Wed, 12 Nov 2025 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762963453;
	bh=8B2q/pY4HluVQKjHZ0UEBhmF/zuqAWxUAaw3utN01NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JI/kqDtvo3BIJJZ5l+Facq31lnTff6k20uUGP+Kayv65bFGydw67hgjkGIHo81fIN
	 os5l5HDKJG6bGuz6XfihwRgroKyQ7PPLJ0q8LR1yRkVyy71Muy12jqv9M3xEVZr30j
	 5znntvzmzxrxdvurwflPbKjCsibYxtF3o6R6S6Gs6u8fPQHhncO91LU/l6JBlfrJOJ
	 mmkMJ8WqYgiXtyu6aNYWbRCtRa40nohNXQjwk9+vJcy2MtdNV/UOSKjbdX8PdrxbnF
	 4hN9MZ1bjQHMWXo31ibv6rHHmnROLUxPLTd8am3UZxUqEi4AgvasXK/TISdkqFWXXS
	 Gw+Qx1mj6UbIA==
Date: Wed, 12 Nov 2025 17:04:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <llong@redhat.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	"John B . Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v14 7/7] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aRSv-kcSj5kc6CJ9@localhost.localdomain>
References: <20251104104740.70512-1-gmonaco@redhat.com>
 <20251104104740.70512-8-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104104740.70512-8-gmonaco@redhat.com>

Le Tue, Nov 04, 2025 at 11:47:39AM +0100, Gabriele Monaco a écrit :
> +static int __init tmigr_init_isolation(void)
> +{
> +	struct work_struct __percpu *works __free(free_percpu) =
> +		alloc_percpu(struct work_struct);
> +	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
> +	int cpu;
> +
> +	static_branch_enable(&tmigr_exclude_isolated);
> +	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
> +		return 0;
> +	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> +		return -ENOMEM;
> +	if (!works)
> +		return -ENOMEM;
> +	cpumask_andnot(cpumask, tmigr_available_cpumask,
> +		       housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
> +	/* Never disable the tick CPU, see tmigr_is_isolated for details */
> +	for_each_cpu(cpu, cpumask) {
> +		if (!tick_nohz_cpu_hotpluggable(cpu)) {
> +			cpumask_clear_cpu(cpu, cpumask);
> +			break;
> +		}
> +	}
> +	for_each_cpu(cpu, cpumask) {
> +		struct work_struct *work = per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, tmigr_cpu_isolate);
> +		schedule_work_on(cpu, work);
> +	}
> +	for_each_cpu(cpu, cpumask)
> +		flush_work(per_cpu_ptr(works, cpu));
> +
>  	return 0;

This duplicates a lot tmigr_isolated_exclude_cpumask().
Would this work?

static int __init tmigr_init_isolation(void)
{
	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;

	static_branch_enable(&tmigr_exclude_isolated);

	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
		return 0;
	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
		return -ENOMEM;

	cpumask_andnot(cpumask, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));

	return tmigr_isolated_exclude_cpumask(cpumask);
}

If so please add my Reviewed-by to the next version.

Thanks!

