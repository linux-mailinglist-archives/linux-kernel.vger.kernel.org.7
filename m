Return-Path: <linux-kernel+bounces-767330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578F1B252ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8D5A78DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8EB2D6417;
	Wed, 13 Aug 2025 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNRgpOcU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A3289809
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109286; cv=none; b=kuif/kJ7Bc7tNY5pogDen0npSkhJ7VEfnigQ8B7T6t1eM5c/K57PfGudiqMA2vjONCptq5kv/besSBF7MYRbIwbiMe/kJb7PuHZhbHRRShyeUGCgPjhqFsCo98iXXuyUWJs2aQblsAR4P9VzPsRKr4EjA5HPuFs2JO61l9ISrkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109286; c=relaxed/simple;
	bh=zNHAiGH1TkJNy/2ujD5bZ9HS4dQE/IgxEaCGnHlK6+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEOqARjenO5zETXYEh0eCdCB9m+XheynFkdrk8iKCwij3AjS2Fm1VA8xbufa1fVQNInASEyL6teqmdbuGVmNqKvvDxqgSJ7vIbXHvVynmQaBM+6dLEqmW3InEB76DUvIwDE+lSq57cm18OVJl1DMi0Isl939l3clVrzBrPxR9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNRgpOcU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755109285; x=1786645285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zNHAiGH1TkJNy/2ujD5bZ9HS4dQE/IgxEaCGnHlK6+0=;
  b=ZNRgpOcUq8/9LgPbTbFkvLIG3ve8mTkFBjsT6uHDOz4kXr2ppuVD5HL5
   GdJZb7aPMYGTY5xJ6wUwTl40ZASMq0Urc8tu/PTtiEcWjw/6IszDWH2bI
   Z6MKgTdxoevhjWir0KR19fZ0dv/ycqkt4dzAaHm3xVA2cdAJazYQ/kAtL
   Jyt6x6dtBj34R1IFRAFl+G1Fr2Z5ffjebxqlXmY8Ka9KYMU7biDnstsPC
   kYDTt0Hri/4hhLxkpMv71VlclOT5nPoNLl4IFttbTvqcgxmcNap7+JmwH
   HYCr+399FtPXdEOdZDo/6K+g7HPSrJP9kQuiJizjwoog9eK0RU0oe0o9R
   Q==;
X-CSE-ConnectionGUID: i7sVhjQBTLadubKJEwKsZQ==
X-CSE-MsgGUID: h303wFd4SMm/wO9j2tB2JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56629168"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56629168"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:21:24 -0700
X-CSE-ConnectionGUID: uROt8WiQSjq3PjW2F7fqvA==
X-CSE-MsgGUID: ItE4BPRNTCSFweop4yZ8zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="197532499"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.131]) ([10.125.111.131])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:21:24 -0700
Message-ID: <06d43a86-204f-4658-9759-d24b7038b2d3@intel.com>
Date: Wed, 13 Aug 2025 11:21:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] x86/microcode/intel: Establish staging control
 logic
To: "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, colinmitchell@google.com, chao.gao@intel.com,
 abusse@amazon.de, linux-kernel@vger.kernel.org
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250813172649.15474-3-chang.seok.bae@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250813172649.15474-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 10:26, Chang S. Bae wrote:
> When microcode staging is initiated, operations are carried out through
> an MMIO interface. Each package has a unique interface specified by the
> IA32_MCU_STAGING_MBOX_ADDR MSR, which maps to a set of 32-bit registers.
> 
> Prepare staging with the following steps:
> 
>   1.  Ensure the microcode image is 32-bit aligned to match the MMIO
>       register size.
> 
>   2.  Identify each MMIO interface based on its per-package scope.
> 
>   3.  Invoke the staging function for each identified interface, which
>       will be implemented separately.
> 
> Also, define cpu_primary_thread_mask for the CONFIG_SMP=n case, allowing
> consistent use when narrowing down primary threads to locate the
> per-package interface.
...
>  static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
> +#define cpu_primary_thread_mask cpu_none_mask
>  #endif /* !CONFIG_SMP */

Isn't 'cpu_none_mask' a mask containing no CPUs? How can that possible
work here:

	for_each_cpu(cpu, cpu_primary_thread_mask) {

? Wouldn't it just not run through the for loop at all on CONFIG_SMP=n?
Is that what we want for some reason? I would have thought that we'd
still want to find the MMIO address for CPU 0, the one and only CPU.

>  static inline void arch_fix_phys_package_id(int num, u32 slot)
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 371ca6eac00e..468c4d3d5d66 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -299,6 +299,55 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
>  	return size ? NULL : patch;
>  }
>  
> +/*
> + * Handle the staging process using the mailbox MMIO interface.
> + * Return the result state.
> + */
> +static enum ucode_state do_stage(u64 mmio_pa)
> +{
> +	pr_debug_once("Staging implementation is pending.\n");
> +	return UCODE_ERROR;
> +}
> +
> +static void stage_microcode(void)
> +{
> +	unsigned int pkg_id = UINT_MAX;
> +	enum ucode_state ret;
> +	int cpu, err;
> +	u64 mmio_pa;
> +
> +	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32)))
> +		return;
> +
> +	lockdep_assert_cpus_held();
> +
> +	/*
> +	 * The MMIO address is unique per package, and all the SMT
> +	 * primary threads are online here. Find each MMIO space by
> +	 * their package ids to avoid duplicate staging.
> +	 */
> +	for_each_cpu(cpu, cpu_primary_thread_mask) {
> +		if (topology_logical_package_id(cpu) == pkg_id)
> +			continue;
> +		pkg_id = topology_logical_package_id(cpu);
> +
> +		err = rdmsrl_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
> +		if (WARN_ON_ONCE(err))
> +			return;
> +
> +		ret = do_stage(mmio_pa);
> +		if (ret != UCODE_OK) {
> +			pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
> +			       ret == UCODE_TIMEOUT ? "timeout" : "error state",
> +			       cpu, pkg_id);
> +			return;
> +		}
> +	}
> +
> +	pr_info("Staging of patch revision 0x%x succeeded.\n",
> +		((struct microcode_header_intel *)ucode_patch_late)->rev);
> +}
Hmmm. Consider:

	static struct microcode_intel *ucode_patch_late __read_mostly;

and:

	struct microcode_intel {
	        struct microcode_header_intel   hdr;
	        unsigned int                    bits[];
	};

So isn't this whole ugly cast thing equivalent to:

	ucode_patch_late->hdr.rev

?

