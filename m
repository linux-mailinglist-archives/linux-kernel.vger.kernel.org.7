Return-Path: <linux-kernel+bounces-778357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B11B2E499
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197BF1BC842B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A92475E3;
	Wed, 20 Aug 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQudd5ab"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D325EFBF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713031; cv=none; b=vFM8QVLRigrpPyLW8jtpdUIChx52EC2b5f+7Bz6lOOhubVnTzG9i0YuV8HTf3AmWWjawmVPf5rYwGV9dH1JieW5XM1rcQpQydvhKB51D3bLrckzPoIsl0rzq900cqw06Z/stDAKKUE+kx0Xj64cnkDf1DpAJ3PcaMRU2NHuh+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713031; c=relaxed/simple;
	bh=rKv98XLHwvEm5WMdFuF2YJ4XeKCnSZd7Pvd6o2ymfjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSiZBZ3v5BHuLNc8Et+iSezhzxbzLxIp+0sKLFIq7idlfl+mhfE2MSWKYYpDWrgRmZb4yUCJkWDNpzaW3Spm0auY4TuLI4puJmssXIIh/lSsJ7pa2HVVT3DLFKp6J2VTItLUpCtm/IIQ2a2RKUeX7+9cuwos9Ij9b0ieSUUmI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQudd5ab; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755713030; x=1787249030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rKv98XLHwvEm5WMdFuF2YJ4XeKCnSZd7Pvd6o2ymfjY=;
  b=aQudd5aboLHFUbClOWttkOO6568/6sbcmKlfInKYkq2Rm77DOh/7Z/5k
   h6PF19hT5aY/JoVsixGSmVVVQOaJZUEhluY0/+8Pch5Qnc9zvCMpYYZhK
   pJfuP6njvND5zcVlJ5nR9jQ3rnL2sKPd8ULYSNBT2blj/R1WMjKGJUT3C
   oYwan+HympD02W8EdcaH/pdbstbSG6VQhRkth78Kl0lOvlHMRtQHVQZ5T
   XAHeKFeDU2JYgqqprIaQfefsQtXrA8r8oQb1paJRLbQNi6bZ2ToxxkL3S
   lHI7f8WWLlAPnuDlR2PfBkRNQKesg0d2I6r4Rgbpmt5vC8GnwBqx6n7hE
   g==;
X-CSE-ConnectionGUID: WuI0H7iyREivaySpCodarA==
X-CSE-MsgGUID: B7tlrbc0T0WGjaRczTUpcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="60617630"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="60617630"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:03:48 -0700
X-CSE-ConnectionGUID: G7KAgankQRSpaU4xYHmx9w==
X-CSE-MsgGUID: U2NMvFT6TveCWltat3PufA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="205346610"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:03:48 -0700
Received: from [10.246.144.138] (kliang2-mobl1.ccr.corp.intel.com [10.246.144.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 77A9520B571C;
	Wed, 20 Aug 2025 11:03:45 -0700 (PDT)
Message-ID: <53aebb23-2520-4016-ae71-18b66dec452f@linux.intel.com>
Date: Wed, 20 Aug 2025 11:03:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/17] perf/x86: Support XMM register for non-PEBS and
 REGS_USER
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <47cbf0f3-9480-497a-ad88-5eb0c50dd88a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-20 2:46 a.m., Mi, Dapeng wrote:
> 
> On 8/19/2025 11:55 PM, Liang, Kan wrote:
>>
>> On 2025-08-19 6:39 a.m., Peter Zijlstra wrote:
>>> On Fri, Aug 15, 2025 at 02:34:23PM -0700, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Collecting the XMM registers in a PEBS record has been supported since
>>>> the Icelake. But non-PEBS events don't support the feature. It's
>>>> possible to retrieve the XMM registers from the XSAVE for non-PEBS.
>>>> Add it to make the feature complete.
>>>>
>>>> To utilize the XSAVE, a 64-byte aligned buffer is required. Add a
>>>> per-CPU ext_regs_buf to store the vector registers. The size of the
>>>> buffer is ~2K. kzalloc_node() is used because there's a _guarantee_
>>>> that all kmalloc()'s with powers of 2 are naturally aligned and also
>>>> 64b aligned.
>>>>
>>>> Extend the support for both REGS_USER and REGS_INTR. For REGS_USER, the
>>>> perf_get_regs_user() returns the regs from the task_pt_regs(current),
>>>> which is struct pt_regs. Need to move it to local struct x86_perf_regs
>>>> x86_user_regs.
>>>> For PEBS, the HW support is still preferred. The XMM should be retrieved
>>>> from PEBS records.
>>>>
>>>> There could be more vector registers supported later. Add ext_regs_mask
>>>> to track the supported vector register group.
>>>
>>> I'm a little confused... *again* :-)
>>>
>>> Specifically, we should consider two sets of registers:
>>>
>>>  - the live set, as per the CPU (XSAVE)
>>>  - the stored set, as per x86_task_fpu()
>>>
>>> regs_intr should always get a copy of the live set; however
>>> regs_user should not. It might need a copy of the x86_task_fpu() instead
>>> of the live set, depending on TIF_NEED_FPU_LOAD (more or less, we need
>>> another variable set in kernel_fpu_begin_mask() *after*
>>> save_fpregs_to_fpstate() is completed).
>>>
>>> I don't see this code make this distinction.
>>>
>>> Consider getting a sample while the kernel is doing some avx enhanced
>>> crypto and such.
>> The regs_user only needs a set when the NMI hits the user mode
>> (user_mode(regs)) or a non-kernel thread (!(current->flags &
>> PF_KTHREAD)). The live set is good enough for both cases.
> 
> It's fine if NMI hits user mode, but if NMI hits the kernel mode
> (!(current->flags &PF_KTHREAD)), won't the kernel space SIMD/eGPR regs be
> exposed to user space for user-regs option? I'm not sure if kernel space
> really use these SIMD/eGPR regs right now, but it seems a risk.
> 
>

I don't think it's possible for the existing kernel. But I cannot
guarantee future usage.

If the kernel mode handling is still a concern, I think we should drop
the SIMD/eGPR regs for the case for now. Because
- To profile a userspace application which requires SIMD/eGPR regs, the
NMI usually hits the usersapce. It's not common to hit the kernel mode.
- The SIMD/eGPR cannot be retrieved from the task_pt_regs(). Although
it's possible to retrieve the values when the TIF_NEED_FPU_LOAD flag is
set, I don't think it's worth introducing such complexity to handle an
uncommon case in the critical path.
- Furthermore, only checking the TIF_NEED_FPU_LOAD flag cannot cure
everything. Some corner cases cannot be handled either. For example, an
NMI can happen when the flag just switched, but still in the kernel mode.

We can always add the support later if someone thinks it's important to
retrieve the user SIMD/eGPR regs during the kernel syscall.

Thanks,
Kan
>>
>> I think the kernel crypto should be to a kernel thread (current->flags &
>> PF_KTHREAD). If so, the regs_user should return NULL.
>>
>> Thanks,
>> Kan
>>
> 


