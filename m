Return-Path: <linux-kernel+bounces-777449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF2B2D991
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61E21894CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E22DCF79;
	Wed, 20 Aug 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/Le0mB+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242B227563
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683981; cv=none; b=ba0GUPi4i8wQf7jEgzhHJO0eQx2fE1Fo8KP8jmxVzkIeSV3k15nHTWGVsQs1qXsw61n+WcO4/cbpuOaXY/fZqk8gA4DRpzObxJuNcizuE7ffUdy5gLvoLOJOHdSXogajk/RYqlb6cRfh06vjzNTvC3Ijgl6+QKTYmTxNenZq9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683981; c=relaxed/simple;
	bh=kf8ZOAZzu5DNf1xefAAp9+GONvpaFNba+GUV/PT8Ka8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jm6lB7lZ+E0VQNk2WtPBCtfG6rk/SQcsizfwQxE9uGz0TDHjuRxLaPSJierJyAZtVEqWSuXguXf3pMgYlMxHr+bmByt6lE/D7BtN7LsFDRkDGxAG7Z++zOJ3BHOutnVbncg3ChaZp9oBDjReEw/jizk2+CWTMUvbVuD7n+WnpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/Le0mB+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755683980; x=1787219980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kf8ZOAZzu5DNf1xefAAp9+GONvpaFNba+GUV/PT8Ka8=;
  b=L/Le0mB+m0y0hVqBYkR3FZDYHYfFQrxBDspWWZh+JvY5str8kuN2vzCf
   0PwFkvADNp/9q4tXj8DdtVa/j0yonKRlGiwz4jl9Be+iXIygTS8281rG+
   AbQ5BqeZxsHwIM/dtkIRmdmijDCEZUDWX0BaAHxpCfus3p8MM82PTXVAX
   FvItNiOwe2WZHRy+P34rHtiC5L7LJFchzsEW/fzmj6cfaN0ns4HmekcwQ
   DkSoUuOktZrUoqsad7Poz+22026Sb+qQhW9wUZJ9qesEtClhjKf/S+adO
   v2ZSX8AJQn98W6xHlKdzZuzac+Ua5RfRnhpxsudTlbgLeH7hRkbcsMeyU
   Q==;
X-CSE-ConnectionGUID: WN77LjCqT/eZuCFmeUftxA==
X-CSE-MsgGUID: ul5tnPJVRQmG9dNNxD7hcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61583283"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61583283"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 02:59:38 -0700
X-CSE-ConnectionGUID: 9IMX+Q2pRQmn0+XbktvmBg==
X-CSE-MsgGUID: Gebw+EpQQsOh/Jy7Ez8s4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167307336"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.36]) ([10.124.240.36])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 02:59:33 -0700
Message-ID: <8f535bbc-bb24-4baf-b9c6-ac0c8fb4c730@linux.intel.com>
Date: Wed, 20 Aug 2025 17:59:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/17] perf/x86: Add YMM into sample_simd_vec_regs
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 dave.hansen@linux.intel.com, irogers@google.com, adrian.hunter@intel.com,
 jolsa@kernel.org, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com, zide.chen@intel.com, mark.rutland@arm.com,
 broonie@kernel.org, ravi.bangoria@amd.com, eranian@google.com
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
 <20250815213435.1702022-9-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250815213435.1702022-9-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/16/2025 5:34 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The YMM0-15 is composed of XMM and YMMH. It requires 2 XSAVE commands to
> get the complete value. Internally, the XMM and YMMH are stored in
> different structures, which follow the XSAVE format. But the output
> dumps the YMM as a whole.
>
> The qwords 4 imply YMM.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/core.c                | 13 +++++++++++++
>  arch/x86/include/asm/perf_event.h     |  4 ++++
>  arch/x86/include/uapi/asm/perf_regs.h |  4 +++-
>  arch/x86/kernel/perf_regs.c           | 10 +++++++++-
>  4 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 1789b91c95c6..aebd4e56dff1 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -423,6 +423,9 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
>  
>  	if (valid_mask & XFEATURE_MASK_SSE)
>  		perf_regs->xmm_space = xsave->i387.xmm_space;
> +
> +	if (valid_mask & XFEATURE_MASK_YMM)
> +		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
>  }
>  
>  static void release_ext_regs_buffers(void)
> @@ -725,6 +728,9 @@ int x86_pmu_hw_config(struct perf_event *event)
>  			if (event->attr.sample_simd_vec_reg_qwords >= PERF_X86_XMM_QWORDS &&
>  			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
>  				return -EINVAL;
> +			if (event->attr.sample_simd_vec_reg_qwords >= PERF_X86_YMM_QWORDS &&
> +			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
> +				return -EINVAL;
>  		}
>  	}
>  	return x86_setup_perfctr(event);
> @@ -1837,6 +1843,13 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
>  		mask |= XFEATURE_MASK_SSE;
>  	}
>  
> +	if (attr->sample_simd_regs_enabled) {
> +		if (attr->sample_simd_vec_reg_qwords >= PERF_X86_YMM_QWORDS) {
> +			perf_regs->ymmh_regs = NULL;
> +			mask |= XFEATURE_MASK_YMM;
> +		}
> +	}
> +
>  	mask &= ~ignore_mask;
>  	if (mask)
>  		x86_pmu_get_ext_regs(perf_regs, mask);
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 538219c59979..81e3143fd91a 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -597,6 +597,10 @@ struct x86_perf_regs {
>  		u64	*xmm_regs;
>  		u32	*xmm_space;	/* for xsaves */
>  	};
> +	union {
> +		u64	*ymmh_regs;
> +		struct ymmh_struct *ymmh;
> +	};
>  };
>  
>  extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index bd8af802f757..feb3e8f80761 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -59,6 +59,8 @@ enum perf_event_x86_regs {
>  #define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
>  
>  #define PERF_X86_XMM_QWORDS		2
> -#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_XMM_QWORDS
> +#define PERF_X86_YMM_QWORDS		4
> +#define PERF_X86_YMMH_QWORDS		(PERF_X86_YMM_QWORDS / 2)
> +#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_YMM_QWORDS
>  
>  #endif /* _ASM_X86_PERF_REGS_H */
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 397357c5896b..d94bc687e4bf 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -66,6 +66,9 @@ void perf_simd_reg_check(struct pt_regs *regs,
>  	if (*vec_qwords >= PERF_X86_XMM_QWORDS && !perf_regs->xmm_regs)
>  		*nr_vectors = 0;
>  
> +	if (*vec_qwords >= PERF_X86_YMM_QWORDS && !perf_regs->xmm_regs)

should be "!perf_regs->ymmh_regs"?


> +		*vec_qwords = PERF_X86_XMM_QWORDS;
> +
>  	*nr_pred = 0;
>  }
>  
> @@ -105,6 +108,10 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
>  		if (!perf_regs->xmm_regs)
>  			return 0;
>  		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS + qwords_idx];
> +	} else if (qwords_idx < PERF_X86_YMM_QWORDS) {
> +		if (!perf_regs->ymmh_regs)
> +			return 0;
> +		return perf_regs->ymmh_regs[idx * PERF_X86_YMMH_QWORDS + qwords_idx - PERF_X86_XMM_QWORDS];
>  	}
>  
>  	return 0;
> @@ -121,7 +128,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
>  		if (vec_mask)
>  			return -EINVAL;
>  	} else {
> -		if (vec_qwords != PERF_X86_XMM_QWORDS)
> +		if (vec_qwords != PERF_X86_XMM_QWORDS &&
> +		    vec_qwords != PERF_X86_YMM_QWORDS)
>  			return -EINVAL;
>  		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
>  			return -EINVAL;

