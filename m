Return-Path: <linux-kernel+bounces-777453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9A5B2D981
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACC55C48E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6662DECCD;
	Wed, 20 Aug 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NF0Yn1NM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CD2DEA6B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684120; cv=none; b=jTmaDDLIvzWG1vnBfjrdm0DBnDRf2YgT0S8ltWDJtNyruK/XkVDWHKOX3P/OSGKeCTsdhT3sxdpfBiVEWVQgVlisuQ2BZ0a0ha/56u8+pJvTtGPYgrDSBGBn7hy3RO5WjgTrrSUcoDilxwc32Lfnd4Y8vwh3ETcQlZJjHKO/rmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684120; c=relaxed/simple;
	bh=KrUeuF/TJEre1Nbnn2vH7Do4FwHcUriDT7roWFQIX2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGOAYTsm/teeQRw7pSFRTBWWtYrvC+xrOXuVWIHYlPA/b34IAd7vNIch+6r/n7HKIm75UDPf+CLYReZ8xkS2m/UJISezdqMgRk9xx6oH+fPDCF/Sa1CPiEPhanmq01gSOJw8nJbFd2zIxejrFWKM2VFvCo/b/1BTIiXdeUG0qbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NF0Yn1NM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755684118; x=1787220118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KrUeuF/TJEre1Nbnn2vH7Do4FwHcUriDT7roWFQIX2E=;
  b=NF0Yn1NMBqkh/fPMqRhcm5NXP1xwKPqL7gVIv7WZMHrC+P4dpEu7EQis
   KbA32PDYW0x5/uk46ImXcaQwCVFYDbHLZzE9P3FWQ5dZlOej+D3WiIzX9
   +nGyAIHP/52ZAiEtvcXQal6yg1T3ZhRcBoOzGNARQjIw8iDcHTDUHlAA9
   RacOdqCGRwlM9+lPg2BpLfYvu8EL0OK/0Ep3v5FZYVQbCDC4yK1bjXd+l
   W4ddNIvnwgV9jN1oitQdB5Er7e0/8zxmQmBqur8zL1BslUxRgGgYqXle+
   BSdx+xcSUGSnDg+2KOsNifA0CbSmqlFyOCJzV1BgWf29Jnv7mAxZ7RxBN
   Q==;
X-CSE-ConnectionGUID: v97onVdNS4mtSid20rF1hg==
X-CSE-MsgGUID: yMSVThPHS7Wf5LTAf7ZbWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61583799"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61583799"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 03:01:56 -0700
X-CSE-ConnectionGUID: rp+raw9WTEmMUYCaABoi8A==
X-CSE-MsgGUID: H6HuFHKwRCuVqAbMpa8RDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167308404"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.36]) ([10.124.240.36])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 03:01:50 -0700
Message-ID: <0858437c-e088-4e08-86fa-7ef08fd314a6@linux.intel.com>
Date: Wed, 20 Aug 2025 18:01:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/17] perf/x86: Add eGPRs into sample_regs
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 dave.hansen@linux.intel.com, irogers@google.com, adrian.hunter@intel.com,
 jolsa@kernel.org, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com, zide.chen@intel.com, mark.rutland@arm.com,
 broonie@kernel.org, ravi.bangoria@amd.com, eranian@google.com
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
 <20250815213435.1702022-12-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250815213435.1702022-12-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/16/2025 5:34 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The eGPRs is only supported when the new SIMD registers configuration
> method is used, which moves the XMM to sample_simd_vec_regs. So the
> space can be reclaimed for the eGPRs.
>
> The eGPRs is retrieved by XSAVE. Only support the eGPRs for X86_64.
>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/core.c                | 39 +++++++++++++++++++++------
>  arch/x86/include/asm/perf_event.h     |  4 +++
>  arch/x86/include/uapi/asm/perf_regs.h | 26 ++++++++++++++++--
>  arch/x86/kernel/perf_regs.c           | 31 ++++++++++-----------
>  4 files changed, 75 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 1fa550efcdfa..f816290defc1 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -432,6 +432,8 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
>  		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
>  	if (valid_mask & XFEATURE_MASK_OPMASK)
>  		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
> +	if (valid_mask & XFEATURE_MASK_APX)
> +		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
>  }
>  
>  static void release_ext_regs_buffers(void)
> @@ -709,17 +711,33 @@ int x86_pmu_hw_config(struct perf_event *event)
>  	}
>  
>  	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
> -		/*
> -		 * Besides the general purpose registers, XMM registers may
> -		 * be collected as well.
> -		 */
> -		if (event_has_extended_regs(event)) {
> -			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
> +		if (event->attr.sample_simd_regs_enabled) {
> +			u64 reserved = ~GENMASK_ULL(PERF_REG_X86_64_MAX - 1, 0);
> +
> +			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
>  				return -EINVAL;
> -			if (!(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
> +			/*
> +			 * The XMM space in the perf_event_x86_regs is reclaimed
> +			 * for eGPRs and other general registers.
> +			 */
> +			if (event->attr.sample_regs_user & reserved ||
> +			    event->attr.sample_regs_intr & reserved)
>  				return -EINVAL;
> -			if (event->attr.sample_simd_regs_enabled)
> +			if ((event->attr.sample_regs_user & PERF_X86_EGPRS_MASK ||
> +			     event->attr.sample_regs_intr & PERF_X86_EGPRS_MASK) &&
> +			     !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
>  				return -EINVAL;
> +		} else {
> +			/*
> +			 * Besides the general purpose registers, XMM registers may
> +			 * be collected as well.
> +			 */
> +			if (event_has_extended_regs(event)) {
> +				if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
> +					return -EINVAL;
> +				if (!(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
> +					return -EINVAL;
> +			}
>  		}
>  
>  		if (event_has_simd_regs(event)) {
> @@ -1881,6 +1899,11 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
>  			perf_regs->opmask_regs = NULL;
>  			mask |= XFEATURE_MASK_OPMASK;
>  		}
> +		if (attr->sample_regs_user & PERF_X86_EGPRS_MASK ||
> +		    attr->sample_regs_intr & PERF_X86_EGPRS_MASK) {
> +			perf_regs->egpr_regs = NULL;
> +			mask |= XFEATURE_MASK_APX;
> +		}
>  	}
>  
>  	mask &= ~ignore_mask;
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index dda677022882..4400cb66bc8e 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -613,6 +613,10 @@ struct x86_perf_regs {
>  		u64	*opmask_regs;
>  		struct avx_512_opmask_state *opmask;
>  	};
> +	union {
> +		u64	*egpr_regs;
> +		struct apx_state *egpr;
> +	};
>  };
>  
>  extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index dd7bd1dd8d39..cd0f6804debf 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -27,11 +27,31 @@ enum perf_event_x86_regs {
>  	PERF_REG_X86_R13,
>  	PERF_REG_X86_R14,
>  	PERF_REG_X86_R15,
> +	/* Extended GPRs (EGPRs) */
> +	PERF_REG_X86_R16,
> +	PERF_REG_X86_R17,
> +	PERF_REG_X86_R18,
> +	PERF_REG_X86_R19,
> +	PERF_REG_X86_R20,
> +	PERF_REG_X86_R21,
> +	PERF_REG_X86_R22,
> +	PERF_REG_X86_R23,
> +	PERF_REG_X86_R24,
> +	PERF_REG_X86_R25,
> +	PERF_REG_X86_R26,
> +	PERF_REG_X86_R27,
> +	PERF_REG_X86_R28,
> +	PERF_REG_X86_R29,
> +	PERF_REG_X86_R30,
> +	PERF_REG_X86_R31,
>  	/* These are the limits for the GPRs. */
>  	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
> -	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
> +	PERF_REG_X86_64_MAX = PERF_REG_X86_R31 + 1,
>  
> -	/* These all need two bits set because they are 128bit */
> +	/*
> +	 * These all need two bits set because they are 128bit.
> +	 * These are only available when !PERF_SAMPLE_REGS_ABI_SIMD
> +	 */

The eGPR indexes are overlapped with XMM indexes. User may get confused
about this, we'd better add comments to explain it.


>  	PERF_REG_X86_XMM0  = 32,
>  	PERF_REG_X86_XMM1  = 34,
>  	PERF_REG_X86_XMM2  = 36,
> @@ -55,6 +75,8 @@ enum perf_event_x86_regs {
>  
>  #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
>  
> +#define PERF_X86_EGPRS_MASK		GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
> +
>  #define PERF_X86_SIMD_PRED_REGS_MAX	8
>  #define PERF_X86_SIMD_PRED_MASK		GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
>  #define PERF_X86_SIMD_VEC_REGS_MAX	32
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 5e815f806605..b6e50194ff3e 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -83,14 +83,22 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  {
>  	struct x86_perf_regs *perf_regs;
>  
> -	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
> +	if (idx > PERF_REG_X86_R15) {
>  		perf_regs = container_of(regs, struct x86_perf_regs, regs);
> -		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
> -		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
> -			return 0;
> -		if (!perf_regs->xmm_regs)
> -			return 0;
> -		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
> +
> +		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
> +			if (idx <= PERF_REG_X86_R31) {
> +				if (!perf_regs->egpr_regs)
> +					return 0;
> +				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
> +			}
> +		} else {
> +			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
> +				if (!perf_regs->xmm_regs)
> +					return 0;
> +				return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
> +			}
> +		}
>  	}
>  
>  	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
> @@ -171,14 +179,7 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
>  				 ~((1ULL << PERF_REG_X86_MAX) - 1))
>  
>  #ifdef CONFIG_X86_32
> -#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
> -		       (1ULL << PERF_REG_X86_R9) | \
> -		       (1ULL << PERF_REG_X86_R10) | \
> -		       (1ULL << PERF_REG_X86_R11) | \
> -		       (1ULL << PERF_REG_X86_R12) | \
> -		       (1ULL << PERF_REG_X86_R13) | \
> -		       (1ULL << PERF_REG_X86_R14) | \
> -		       (1ULL << PERF_REG_X86_R15))
> +#define REG_NOSUPPORT GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R8)
>  
>  int perf_reg_validate(u64 mask)
>  {

