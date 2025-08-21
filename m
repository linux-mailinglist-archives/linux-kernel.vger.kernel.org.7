Return-Path: <linux-kernel+bounces-779483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E90B2F4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DD05E3B76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5326A2DC327;
	Thu, 21 Aug 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lK4+KyC/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tsWgcySR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DE2DA76D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770026; cv=none; b=ez5ZWjwNW7kjGoQSKdim2HGdWsKwdvREgNeBd6DhTdKflT9XufnwJV1v+H7ifUA3QvU8XtgVMvAkPWHyAom1j3c4XAbc/FObxDX8GxfAjL4sKbeKtJpjd9zWH6HxpjH1fGuH/ncTXOE/13ji1wXRoLWShuNzBZhFEaJuwllDKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770026; c=relaxed/simple;
	bh=Kw933jXbLorysRey7gN+vZiHMPJ9xddyIJCcqssbuhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9iJElzIPSa6UtuVE2iVsR29jDEcc9B1KNg8joRDHO9GHinhtqpqa1PPAAB/hivYS9U2R2P2tOJrhCASBbx7kQek3VFRJljkMv4dxrsj4c2NQ/ZyV5pPEUIsI2mE0mlH0UiB4YEbH0zxVzQVAVgLBBS3s/VEnCFJa9jXgOAJC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lK4+KyC/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tsWgcySR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Aug 2025 11:53:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755770023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CihmxdU4Ms1mqx70T+KZ5W8aGesd/p/F8CWha+o07Dk=;
	b=lK4+KyC/zfPncJJYE2xfIzlp3F/F3hoRjd6RflaxcdAsv5k0s3964vcqK+3W/yTxJnhXvd
	ZXoK23MjqI0Ajm4ZVMJY8I770D7rc3mk/k8EUGAVLGKfhsRItSBvoTN/Rp5/16xdVo9XNH
	WNmbaSH3jux1x8lpzwZU8eGxkH6mzdFxnsA0YUaLlYSa8n7Q6VpYX6SqSeMUmPmTa1jgQ3
	TiLCfZBKrV3DZXkfKBsw28RS+otC5dE4VMCPlSstXy/UMbgR/kbgpzR+mga0rSwaopLf1r
	ASGSw2qSpXwsTSxG8X7tYFeWUBG+2XOqaq3STmdzoXcy8LFpDQ4kOaSQaEARXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755770023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CihmxdU4Ms1mqx70T+KZ5W8aGesd/p/F8CWha+o07Dk=;
	b=tsWgcySRHLUte7GIwJFfNuUvyyO0PPRXuYc14uXl20wjecgUr12uGEJgvpOskt4IMxkQWf
	ffC7IqxzyOJkjQBA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/2] x86/cpu/cacheinfo: Simplify llc_id calculation on
 AMD platforms
Message-ID: <aKbspRcrEWBiox8c@lx-t490>
References: <20250821051910.7351-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821051910.7351-1-kprateek.nayak@amd.com>

Hi,

On Thu, 21 Aug 2025, K Prateek Nayak wrote:
>
> Reuse the available cacheinfo helpers instead of open-coding masks and
> shifts in cacheinfo_amd_init_llc_id().
>
> This series has been tested on top of tip:x86/cpu at commit 6a42c31ef324
> ("x86/cpu: Rename and move CPU model entry for Diamond Rapids") with no
> changes being observed in "/sys/kernel/debug/x86/topo/" on a 3rd
> Generation EPYC platform.
>

I had to merge the diff of the two patches to get what was going on.

My only comment would be:

> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> ...
> +/*
> + * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
> + * ECX as cache index. Then right shift apicid by the number's order to get
> + * cache id for this cache node.
> + */
> +static unsigned int get_cache_id(u32 apicid, struct _cpuid4_info *id4)
> +{
> +	unsigned long num_threads_sharing;
> +	int index_msb;
> +
> +	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
> +	index_msb = get_count_order(num_threads_sharing);
> +	return apicid >> index_msb;
> +}
> +
...
> -/*
> - * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
> - * ECX as cache index. Then right shift apicid by the number's order to get
> - * cache id for this cache node.
> - */
> -static void get_cache_id(int cpu, struct _cpuid4_info *id4)
> -{
> -	struct cpuinfo_x86 *c = &cpu_data(cpu);
> -	unsigned long num_threads_sharing;
> -	int index_msb;
> -
> -	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
> -	index_msb = get_count_order(num_threads_sharing);
> -	id4->id = c->topo.apicid >> index_msb;
> -}
> -
...

Since you don't write to 'id4' anymore, please make the pointer constant.
It helps with code comprehension: from a quick glance, one knows that the
function does not write to the passed structure.

Other than that, and possibly merging the two patches (if you want to):

Acked-by: Ahmed S. Darwish <darwi@linutronix.de>

Thanks!

