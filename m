Return-Path: <linux-kernel+bounces-720334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5853AFBA6B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8142D1AA7CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8852641C3;
	Mon,  7 Jul 2025 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Le0nvKGW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AB262FD5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911934; cv=none; b=sLo9Sy6h+oONsgJzVaQOXOHz3oCvLj7keFRrlUlpHgM+mb0EmpScj4P+jdeQl+zKDKeyyyuJErnlWFY6kZh45fzbhsFcjo+J5AS9wWNsyKy+DsMESuWkk6RroOmDqZu/0fdPF19tlWkfZ7UuoJc90BWDMT1IYVOBv6Zit0QtBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911934; c=relaxed/simple;
	bh=I7Y6hFh8yU+ynO3kvdHHZoMuz3Q4A6Utlw7kLTRia5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPML0XvIBkBmFt0lWpuTqdSm7d/got+jyNGB8M9aqHE4XylgMFijoGvNJox142A0rjdr2eMpxTufxtKYsG/WM7dXjb6DZKG0Ye5PrAdxQhNff3RAEUoI90TN0myqG9sTxP60eK6t/kJwP0Ckj/u9TRojWG/m1SjAACXcsqPZwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Le0nvKGW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751911932; x=1783447932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I7Y6hFh8yU+ynO3kvdHHZoMuz3Q4A6Utlw7kLTRia5s=;
  b=Le0nvKGWCcoypawWGaLVKF2ILWCFIcuuTSAKaQE6QVetQ2Ys7TS2Mvmc
   0y/gBfbqyeaW2qRFALUQ6tv7gDLCo+NVCeoD31AveHA7IFB4BqfMlJFN0
   gjs8AT4NlQAzq6gTG74s9fW7LijupDiQgVqoths/jhullX2QUCdSB0S/l
   xtvaqmXLs3+HZXO+uI4wfgG0rSKD8RO58mjc1S8T9dHCDy1FYTs/svG2d
   mC4uRBzS9sIvzl3/ClotncQEXZ2YipVOdo2cjdjgB/Rgi9axaFJdN43Zs
   B0T1TUsQgjkJ0Of2hU+azmv9cBmO7bUgjknH8zdxptLjxu7DZ4zN4ZDcO
   Q==;
X-CSE-ConnectionGUID: 4nSh39j/Qc+RxehqOVHtpQ==
X-CSE-MsgGUID: YNWLOYz7T7a4znE0JQnang==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="56753202"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="56753202"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 11:12:12 -0700
X-CSE-ConnectionGUID: H5QuH7VmQ+i+tM49oydbAg==
X-CSE-MsgGUID: +8JuV4SJTXKyBA3bozKJAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="192463916"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 11:12:12 -0700
Received: from [10.124.128.64] (kliang2-mobl1.ccr.corp.intel.com [10.124.128.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 04D7F20B571C;
	Mon,  7 Jul 2025 11:12:04 -0700 (PDT)
Message-ID: <1cb07a5b-fc14-481f-b145-56803edeb0d0@linux.intel.com>
Date: Mon, 7 Jul 2025 11:12:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 03/13] x86/fpu/xstate: Add xsaves_nmi
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 jolsa@kernel.org, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org, dapeng1.mi@linux.intel.com,
 ak@linux.intel.com, zide.chen@intel.com, mark.rutland@arm.com,
 broonie@kernel.org, ravi.bangoria@amd.com
References: <20250626195610.405379-1-kan.liang@linux.intel.com>
 <20250626195610.405379-4-kan.liang@linux.intel.com>
 <3e95a8f7-88aa-4732-b38b-ccef74634819@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <3e95a8f7-88aa-4732-b38b-ccef74634819@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-07-01 5:18 p.m., Chang S. Bae wrote:
> On 6/26/2025 12:56 PM, kan.liang@linux.intel.com wrote:
> <snip>> Add an interface to retrieve the actual register contents when
> the NMI
>> hit. The interface is different from the other interfaces of FPU. The
>> other mechanisms that deal with xstate try to get something coherent.
>> But this interface is *in*coherent. There's no telling what was in the
>> registers when a NMI hits. It writes whatever was in the registers when
>> the NMI hit. It's the invoker's responsibility to make sure the contents
>> are properly filtered before exposing them to the end user.
> 
> <snip>
> 
>>   +/**
>> + * xsaves_nmi - Save selected components to a kernel xstate buffer in
>> NMI
>> + * @xstate:    Pointer to the buffer
>> + * @mask:    Feature mask to select the components to save
>> + *
>> + * The @xstate buffer must be 64 byte aligned.
>> + *
>> + * Caution: The interface is different from the other interfaces of FPU.
>> + * The other mechanisms that deal with xstate try to get something
>> coherent.
>> + * But this interface is *in*coherent. There's no telling what was in
>> the
>> + * registers when a NMI hits. It writes whatever was in the registers
>> when
>> + * the NMI hit.
>> + * The only user for the interface is perf_event. There is already a
>> + * hardware feature (See Intel PEBS XMMs group), which can handle XSAVE
>> + * "snapshots" from random code running. This just provides another
>> XSAVE
>> + * data source at a random time.
>> + * This function can only be invoked in an NMI. It returns the *ACTUAL*
>> + * register contents when the NMI hit.
>> + */
>> +void xsaves_nmi(struct xregs_state *xstate, u64 mask)
>> +{
>> +    int err;
>> +
>> +    if (!in_nmi())
>> +        return;
>> +
>> +    XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
>> +    WARN_ON_ONCE(err);
>> +}
>> +
> There are xsaves()/xrstors() functions, already narrowed to the
> "independent" feature set only. So, adding a new xsaves_yyy() variant
> for a different use case -- without renaming the existing helpers to
> something like xsaves_xxx() -- would make the naming scheme appear
> inconsistent at a glance.
> 
> But looking back at history:
> 
> 1. These helpers were established with "independent" in the name (though
>    they were initially described as for “dynamic” features):
>    copy_kernel_to_independent_supervisor()/
>    copy_independent_supervisor_to_kernel()
> 
> 2. Later, Thomas reworked them, renaming and simplifying them to
>    xsaves()/xrstors(), and adding a refactored validator:
>    validate_xsaves_xrstors() [1]. At that point, their usage was
>    *relaxed* and not strictly limited to independent features.
> 
> 3. Subsequently, in preparation for dynamic feature support, the helpers
>    were restricted again to independent features only [2]. This involved
>    renaming and enforcing stricter validation via
>    validate_independent_components().
> 
> Given that, rather than introducing a new wrapper for every additional
> use case, another option could be to retain xsaves() naming but modestly
> expand its scope. That would mean to add another allowance: features in
> tightly constrained contexts (e.g., NMI). Perhaps, this approach can
> keep the API simple while still expanding usage.
>

So we need to add a parameter, e.g., nmi. For the NMI case, the limit to
the independent features should be removed, right?
void xsaves(struct xregs_state *xsave, u64 mask, bool nmi);

The only user for the xsaves is LBR. It should not be a problem to
update the interface.
But perf only needs the xsaves for the SIMD and other registers. So the
parameter will only be added for the xsaves(). The xsaves()/xrstore()
will not be symmetrical anymore. I'm not sure if it's a problem.

Dave? Thomas? Any comments?

Should we extend the existing xsaves() interface or adding a new
xsaves_nmi() interface for the perf usage?

Thanks,
Kan


> [1] a75c52896b6d ("x86/fpu/xstate: Sanitize handling of independent
> features")
> [2] f5daf836f292 ("x86/fpu: Restrict xsaves()/xrstors() to independent
> states")
> 
> 


