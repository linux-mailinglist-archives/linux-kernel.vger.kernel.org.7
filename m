Return-Path: <linux-kernel+bounces-777431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E33B2D94F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822F9682DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F192E03E1;
	Wed, 20 Aug 2025 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8JRaTce"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852692253EC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683222; cv=none; b=ktgbCYXq6hhIi9H26aTxWWT/Iwp2TRrtx/kekiOoRWURCcAGg8jexHiWVk260ajbv4DkeuhZS3thBrEaUxEsf5GSyzCftGeTpkgWwHWkKvSZCb8z8Kx7rNDMgb5viLdtnKRTcnAx4Y7jM4LWbwwzfuW5lo+Zo0UZ/O1TSoKVBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683222; c=relaxed/simple;
	bh=FD9cMz3eEMJTKS3oFM4329N+rpS/nhBfEyohFFOXBmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaVMO9qx5jbV4ib/ImK8y0oSH7UVKLUqh1tHnsT7S5rhy4pI93c0xbr2k9yw6NixsCG1cnQPQibUSXkXochLmPaDNIpHcMtrtuN8/QHGIBA7mGDoBSw0bfbJMMc0hHm/VmAm6D2AntfB43Yq3sDnYVQYhxyl0BFh0xikorh54+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8JRaTce; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755683220; x=1787219220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FD9cMz3eEMJTKS3oFM4329N+rpS/nhBfEyohFFOXBmQ=;
  b=b8JRaTcenJuwd5LtM+beqTZPoseiKinKABVVDBAlVcRRaxihln3h0lOo
   xkgIcr9ediLhmWwWesqPTUmtZHBe8tMsYJ1ump1BjwfdJx5d3ckIfiNiG
   PGWbL8d4IZHLnMSVOqNm30YIDTADiR6HCEJL5eFsEDdX718/fnUZsTtRj
   rbc1MrVvbQ2MMHCq32NW+dZRYnW5KNwiuUiMckso87DPsy0xks2xGEQrp
   XZm199RNpuPTiMtybjX9SiqRNwA+ZKSuWbpg+Ed3qaStPo1d2dxd6oof+
   yrttTPc5VghZsY0xyezyZD3GxQdrmzg1W88ORGGtVC6a5UtZxbDeT05+E
   g==;
X-CSE-ConnectionGUID: 0Ut6SmANQZ27yBJgGZPptw==
X-CSE-MsgGUID: YMqqVEXlSJOsVoxuGx0yQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57895495"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57895495"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 02:46:53 -0700
X-CSE-ConnectionGUID: dCzEoT1xTl6k7QfV9xFgmg==
X-CSE-MsgGUID: eHBM51glSi2oRaWASMJ+fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168340639"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.36]) ([10.124.240.36])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 02:46:49 -0700
Message-ID: <47cbf0f3-9480-497a-ad88-5eb0c50dd88a@linux.intel.com>
Date: Wed, 20 Aug 2025 17:46:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/17] perf/x86: Support XMM register for non-PEBS and
 REGS_USER
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, dave.hansen@linux.intel.com, irogers@google.com,
 adrian.hunter@intel.com, jolsa@kernel.org,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, zide.chen@intel.com, mark.rutland@arm.com,
 broonie@kernel.org, ravi.bangoria@amd.com, eranian@google.com
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
 <20250815213435.1702022-6-kan.liang@linux.intel.com>
 <20250819133902.GJ4067720@noisy.programming.kicks-ass.net>
 <7009606d-0c47-4c3f-a7f9-0ae1922c9e5f@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <7009606d-0c47-4c3f-a7f9-0ae1922c9e5f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/19/2025 11:55 PM, Liang, Kan wrote:
>
> On 2025-08-19 6:39 a.m., Peter Zijlstra wrote:
>> On Fri, Aug 15, 2025 at 02:34:23PM -0700, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Collecting the XMM registers in a PEBS record has been supported since
>>> the Icelake. But non-PEBS events don't support the feature. It's
>>> possible to retrieve the XMM registers from the XSAVE for non-PEBS.
>>> Add it to make the feature complete.
>>>
>>> To utilize the XSAVE, a 64-byte aligned buffer is required. Add a
>>> per-CPU ext_regs_buf to store the vector registers. The size of the
>>> buffer is ~2K. kzalloc_node() is used because there's a _guarantee_
>>> that all kmalloc()'s with powers of 2 are naturally aligned and also
>>> 64b aligned.
>>>
>>> Extend the support for both REGS_USER and REGS_INTR. For REGS_USER, the
>>> perf_get_regs_user() returns the regs from the task_pt_regs(current),
>>> which is struct pt_regs. Need to move it to local struct x86_perf_regs
>>> x86_user_regs.
>>> For PEBS, the HW support is still preferred. The XMM should be retrieved
>>> from PEBS records.
>>>
>>> There could be more vector registers supported later. Add ext_regs_mask
>>> to track the supported vector register group.
>>
>> I'm a little confused... *again* :-)
>>
>> Specifically, we should consider two sets of registers:
>>
>>  - the live set, as per the CPU (XSAVE)
>>  - the stored set, as per x86_task_fpu()
>>
>> regs_intr should always get a copy of the live set; however
>> regs_user should not. It might need a copy of the x86_task_fpu() instead
>> of the live set, depending on TIF_NEED_FPU_LOAD (more or less, we need
>> another variable set in kernel_fpu_begin_mask() *after*
>> save_fpregs_to_fpstate() is completed).
>>
>> I don't see this code make this distinction.
>>
>> Consider getting a sample while the kernel is doing some avx enhanced
>> crypto and such.
> The regs_user only needs a set when the NMI hits the user mode
> (user_mode(regs)) or a non-kernel thread (!(current->flags &
> PF_KTHREAD)). The live set is good enough for both cases.

It's fine if NMI hits user mode, but if NMI hits the kernel mode
(!(current->flags &PF_KTHREAD)), won't the kernel space SIMD/eGPR regs be
exposed to user space for user-regs option? I'm not sure if kernel space
really use these SIMD/eGPR regs right now, but it seems a risk.


>
> I think the kernel crypto should be to a kernel thread (current->flags &
> PF_KTHREAD). If so, the regs_user should return NULL.
>
> Thanks,
> Kan
>

