Return-Path: <linux-kernel+bounces-778374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A5BB2E4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F12116C881
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6C274671;
	Wed, 20 Aug 2025 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cl3KhZMx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495136CE0C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713454; cv=none; b=s2ypscXTYNCNT132MJM/6O4HtLj6vCueLsE33pfcZ+Ze5Z+hgUbs1E7b+DDwJHNEAQH1gFYNKd/XXXbW9kY7xV7ybsn/MfTpsGNiJkc4FafgP87BRKr3hhg3BquvL6akSjaQsaiKOxjcqPrdxzfobrK07bq2JkgQpwXBESYN5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713454; c=relaxed/simple;
	bh=5eVMt1E7aOgEoKMEGUnGSjdULZ7yY1wBdeFwYq+jrMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0S+kbsVjJyk4VHVDpBamow0kOabmRif8FPD399QJEnrpbDd3ehfbCWkTthUL/RTyZU8f2Fb0O7VMPfVaIvauJPHV90tb75mePyD7mRtwWLT2E7NEvs63nkvVkGUhjGEl0XMDhKgAB2gKVTsx0l2RVQPTU66Y5O5RARdxcFMkZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cl3KhZMx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755713453; x=1787249453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5eVMt1E7aOgEoKMEGUnGSjdULZ7yY1wBdeFwYq+jrMI=;
  b=cl3KhZMxo+TrKKg/UqQSo8O8x94zIRV9qWN3HzBC+fq/CySTJm9c1mAS
   TCW1TAU/1qNeMbcemcf2pisXZmJtGW3yvGSCRe4737e+XsHxDTQuTlGTC
   +Xic5vqlNzXC2Qc8VsMPCIaJlUI9TTz6S0F3lEzpQCbTUCY4yZHAem1cP
   DpHpoqIJg6+oqCQDyMGpnUn6p/XWJUSSfzqy4TKekSnwBUYCTtJg8cHM3
   7pdjdk8CmRwY8DyOFLECVc2uak380+P5yzOUsLfot3Fz/xLHJ6W9i1WhE
   QsPHsjlLjJNEucgZ4XBN2GmE9rH7nPvDGsabj6dNeT4IEg6OM1y+S0M35
   w==;
X-CSE-ConnectionGUID: vMlNKHF7SyOG8dP30S8Jfg==
X-CSE-MsgGUID: LVmqqqjGSImdM4ah+vOx/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="45565847"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="45565847"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:10:52 -0700
X-CSE-ConnectionGUID: dPIzg+/fTW+0jVoOlqYi/g==
X-CSE-MsgGUID: Zb1qPuQvSzK3FYxPxaSDjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167402836"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:10:51 -0700
Received: from [10.246.144.138] (kliang2-mobl1.ccr.corp.intel.com [10.246.144.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8B29E20B571C;
	Wed, 20 Aug 2025 11:10:49 -0700 (PDT)
Message-ID: <655dd7ef-85ba-4868-a945-c9aa9d70d480@linux.intel.com>
Date: Wed, 20 Aug 2025 11:10:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/17] perf/x86: Add YMM into sample_simd_vec_regs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 dave.hansen@linux.intel.com, irogers@google.com, adrian.hunter@intel.com,
 jolsa@kernel.org, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com, zide.chen@intel.com, mark.rutland@arm.com,
 broonie@kernel.org, ravi.bangoria@amd.com, eranian@google.com
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
 <20250815213435.1702022-9-kan.liang@linux.intel.com>
 <8f535bbc-bb24-4baf-b9c6-ac0c8fb4c730@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <8f535bbc-bb24-4baf-b9c6-ac0c8fb4c730@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-20 2:59 a.m., Mi, Dapeng wrote:
> 
> On 8/16/2025 5:34 AM, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The YMM0-15 is composed of XMM and YMMH. It requires 2 XSAVE commands to
>> get the complete value. Internally, the XMM and YMMH are stored in
>> different structures, which follow the XSAVE format. But the output
>> dumps the YMM as a whole.
>>
>> The qwords 4 imply YMM.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  arch/x86/events/core.c                | 13 +++++++++++++
>>  arch/x86/include/asm/perf_event.h     |  4 ++++
>>  arch/x86/include/uapi/asm/perf_regs.h |  4 +++-
>>  arch/x86/kernel/perf_regs.c           | 10 +++++++++-
>>  4 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 1789b91c95c6..aebd4e56dff1 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -423,6 +423,9 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
>>  
>>  	if (valid_mask & XFEATURE_MASK_SSE)
>>  		perf_regs->xmm_space = xsave->i387.xmm_space;
>> +
>> +	if (valid_mask & XFEATURE_MASK_YMM)
>> +		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
>>  }
>>  
>>  static void release_ext_regs_buffers(void)
>> @@ -725,6 +728,9 @@ int x86_pmu_hw_config(struct perf_event *event)
>>  			if (event->attr.sample_simd_vec_reg_qwords >= PERF_X86_XMM_QWORDS &&
>>  			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
>>  				return -EINVAL;
>> +			if (event->attr.sample_simd_vec_reg_qwords >= PERF_X86_YMM_QWORDS &&
>> +			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
>> +				return -EINVAL;
>>  		}
>>  	}
>>  	return x86_setup_perfctr(event);
>> @@ -1837,6 +1843,13 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
>>  		mask |= XFEATURE_MASK_SSE;
>>  	}
>>  
>> +	if (attr->sample_simd_regs_enabled) {
>> +		if (attr->sample_simd_vec_reg_qwords >= PERF_X86_YMM_QWORDS) {
>> +			perf_regs->ymmh_regs = NULL;
>> +			mask |= XFEATURE_MASK_YMM;
>> +		}
>> +	}
>> +
>>  	mask &= ~ignore_mask;
>>  	if (mask)
>>  		x86_pmu_get_ext_regs(perf_regs, mask);
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 538219c59979..81e3143fd91a 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -597,6 +597,10 @@ struct x86_perf_regs {
>>  		u64	*xmm_regs;
>>  		u32	*xmm_space;	/* for xsaves */
>>  	};
>> +	union {
>> +		u64	*ymmh_regs;
>> +		struct ymmh_struct *ymmh;
>> +	};
>>  };
>>  
>>  extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
>> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
>> index bd8af802f757..feb3e8f80761 100644
>> --- a/arch/x86/include/uapi/asm/perf_regs.h
>> +++ b/arch/x86/include/uapi/asm/perf_regs.h
>> @@ -59,6 +59,8 @@ enum perf_event_x86_regs {
>>  #define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
>>  
>>  #define PERF_X86_XMM_QWORDS		2
>> -#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_XMM_QWORDS
>> +#define PERF_X86_YMM_QWORDS		4
>> +#define PERF_X86_YMMH_QWORDS		(PERF_X86_YMM_QWORDS / 2)
>> +#define PERF_X86_SIMD_QWORDS_MAX	PERF_X86_YMM_QWORDS
>>  
>>  #endif /* _ASM_X86_PERF_REGS_H */
>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>> index 397357c5896b..d94bc687e4bf 100644
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
>> @@ -66,6 +66,9 @@ void perf_simd_reg_check(struct pt_regs *regs,
>>  	if (*vec_qwords >= PERF_X86_XMM_QWORDS && !perf_regs->xmm_regs)
>>  		*nr_vectors = 0;
>>  
>> +	if (*vec_qwords >= PERF_X86_YMM_QWORDS && !perf_regs->xmm_regs)
> 
> should be "!perf_regs->ymmh_regs"?

Oops, good catch.

Thansk,
Kan

> 
> 
>> +		*vec_qwords = PERF_X86_XMM_QWORDS;
>> +
>>  	*nr_pred = 0;
>>  }
>>  
>> @@ -105,6 +108,10 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
>>  		if (!perf_regs->xmm_regs)
>>  			return 0;
>>  		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS + qwords_idx];
>> +	} else if (qwords_idx < PERF_X86_YMM_QWORDS) {
>> +		if (!perf_regs->ymmh_regs)
>> +			return 0;
>> +		return perf_regs->ymmh_regs[idx * PERF_X86_YMMH_QWORDS + qwords_idx - PERF_X86_XMM_QWORDS];
>>  	}
>>  
>>  	return 0;
>> @@ -121,7 +128,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
>>  		if (vec_mask)
>>  			return -EINVAL;
>>  	} else {
>> -		if (vec_qwords != PERF_X86_XMM_QWORDS)
>> +		if (vec_qwords != PERF_X86_XMM_QWORDS &&
>> +		    vec_qwords != PERF_X86_YMM_QWORDS)
>>  			return -EINVAL;
>>  		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
>>  			return -EINVAL;


