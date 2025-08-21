Return-Path: <linux-kernel+bounces-778742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A52B2E9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FFE1887F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84E91E5B70;
	Thu, 21 Aug 2025 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crESVaX0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA13B29E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738055; cv=none; b=VAAJUuLwxQzF2A7hYLlCZ14Qsg4kVa7di3mq8EvfqWmXXQ0HzFmZlo0xwWkNPX2UOHhMGz5H8KInDHDYQyT4qPuMVQfQtgryYxMa3WU71CvChRqxGMXquDhqcXAO+dQJtzb7sxuZ++7aCW+0qkpRGIoy83R5XlivE7NwjRSvOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738055; c=relaxed/simple;
	bh=OmOgrn3ENXD+NRu+t7TCwo1QQXtRWir/zLxY8vIxEks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEishMz/+syKC0lDA5AqG4v9+0nMniquqMz11ojj60nZnKzwyZOTASMXugNlO15S+DYYrs8toYv9GaO4+RbMjI7GCrZKgKq0zf8sikGFbns5W0R3u6DwhCmH0PMTkl421hlEXjowWHFU9/fxHzFog5W0P79wGV56ah5yFrOpUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crESVaX0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755738054; x=1787274054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OmOgrn3ENXD+NRu+t7TCwo1QQXtRWir/zLxY8vIxEks=;
  b=crESVaX0MeIg90K0qxpVrQsv0Cx2k+ZwFutsAMlCcD8P+mc/amjOYRSB
   tq4VkzPmM0NhRXsmUdBuy8fDv5tcyJWO+/SFtPuBEUSd62mvVPVpvy5Ja
   PiuaNPcfeLMhR/RIV9cZcXVK96NQcbx5U48E/vSD3SdvJ6gOKhclQgRjv
   cluBLAaQXr23N0mJIT+pea9Xt1jBBPl5jvgAv1BPyMcXFOp+u9q1beZRb
   DbRS0dL4B3iFsy7m4THq4wwiVNfDWOiLUkH0SsYQJAbVZ2u+gAsH2FsOD
   1gcSwXOz80PDNEXTdWx2dMFy2OwTof4DJi/OsxDnlxFzgXxbpB11WS+uv
   g==;
X-CSE-ConnectionGUID: du0kTvFqQeCdztxc3ay7Xg==
X-CSE-MsgGUID: RI/DWi+DRmux1xaQW/iJQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="80610386"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="80610386"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 18:00:53 -0700
X-CSE-ConnectionGUID: IvObkcrCQvepXrLMCrffRg==
X-CSE-MsgGUID: vl+Zm4LLRWCPW58eV9t1BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168197736"
Received: from cuijunya-mobl1.ccr.corp.intel.com (HELO [10.124.233.125]) ([10.124.233.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 18:00:48 -0700
Message-ID: <dbd28326-1d47-462e-947c-34e3c4a08ec6@linux.intel.com>
Date: Thu, 21 Aug 2025 09:00:45 +0800
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
 <47cbf0f3-9480-497a-ad88-5eb0c50dd88a@linux.intel.com>
 <53aebb23-2520-4016-ae71-18b66dec452f@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <53aebb23-2520-4016-ae71-18b66dec452f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/21/2025 2:03 AM, Liang, Kan wrote:
>
> On 2025-08-20 2:46 a.m., Mi, Dapeng wrote:
>> On 8/19/2025 11:55 PM, Liang, Kan wrote:
>>> On 2025-08-19 6:39 a.m., Peter Zijlstra wrote:
>>>> On Fri, Aug 15, 2025 at 02:34:23PM -0700, kan.liang@linux.intel.com wrote:
>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> Collecting the XMM registers in a PEBS record has been supported since
>>>>> the Icelake. But non-PEBS events don't support the feature. It's
>>>>> possible to retrieve the XMM registers from the XSAVE for non-PEBS.
>>>>> Add it to make the feature complete.
>>>>>
>>>>> To utilize the XSAVE, a 64-byte aligned buffer is required. Add a
>>>>> per-CPU ext_regs_buf to store the vector registers. The size of the
>>>>> buffer is ~2K. kzalloc_node() is used because there's a _guarantee_
>>>>> that all kmalloc()'s with powers of 2 are naturally aligned and also
>>>>> 64b aligned.
>>>>>
>>>>> Extend the support for both REGS_USER and REGS_INTR. For REGS_USER, the
>>>>> perf_get_regs_user() returns the regs from the task_pt_regs(current),
>>>>> which is struct pt_regs. Need to move it to local struct x86_perf_regs
>>>>> x86_user_regs.
>>>>> For PEBS, the HW support is still preferred. The XMM should be retrieved
>>>>> from PEBS records.
>>>>>
>>>>> There could be more vector registers supported later. Add ext_regs_mask
>>>>> to track the supported vector register group.
>>>> I'm a little confused... *again* :-)
>>>>
>>>> Specifically, we should consider two sets of registers:
>>>>
>>>>  - the live set, as per the CPU (XSAVE)
>>>>  - the stored set, as per x86_task_fpu()
>>>>
>>>> regs_intr should always get a copy of the live set; however
>>>> regs_user should not. It might need a copy of the x86_task_fpu() instead
>>>> of the live set, depending on TIF_NEED_FPU_LOAD (more or less, we need
>>>> another variable set in kernel_fpu_begin_mask() *after*
>>>> save_fpregs_to_fpstate() is completed).
>>>>
>>>> I don't see this code make this distinction.
>>>>
>>>> Consider getting a sample while the kernel is doing some avx enhanced
>>>> crypto and such.
>>> The regs_user only needs a set when the NMI hits the user mode
>>> (user_mode(regs)) or a non-kernel thread (!(current->flags &
>>> PF_KTHREAD)). The live set is good enough for both cases.
>> It's fine if NMI hits user mode, but if NMI hits the kernel mode
>> (!(current->flags &PF_KTHREAD)), won't the kernel space SIMD/eGPR regs be
>> exposed to user space for user-regs option? I'm not sure if kernel space
>> really use these SIMD/eGPR regs right now, but it seems a risk.
>>
>>
> I don't think it's possible for the existing kernel. But I cannot
> guarantee future usage.
>
> If the kernel mode handling is still a concern, I think we should drop
> the SIMD/eGPR regs for the case for now. Because
> - To profile a userspace application which requires SIMD/eGPR regs, the
> NMI usually hits the usersapce. It's not common to hit the kernel mode.
> - The SIMD/eGPR cannot be retrieved from the task_pt_regs(). Although
> it's possible to retrieve the values when the TIF_NEED_FPU_LOAD flag is
> set, I don't think it's worth introducing such complexity to handle an
> uncommon case in the critical path.
> - Furthermore, only checking the TIF_NEED_FPU_LOAD flag cannot cure
> everything. Some corner cases cannot be handled either. For example, an
> NMI can happen when the flag just switched, but still in the kernel mode.
>
> We can always add the support later if someone thinks it's important to
> retrieve the user SIMD/eGPR regs during the kernel syscall.

+1


>
> Thanks,
> Kan
>>> I think the kernel crypto should be to a kernel thread (current->flags &
>>> PF_KTHREAD). If so, the regs_user should return NULL.
>>>
>>> Thanks,
>>> Kan
>>>

