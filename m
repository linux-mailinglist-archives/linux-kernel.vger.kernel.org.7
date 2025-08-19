Return-Path: <linux-kernel+bounces-776122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3557B2C8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6776625BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336E2BD5B3;
	Tue, 19 Aug 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lErp9xWm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8281FBCA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618904; cv=none; b=naUFW/T4VX1PbwLUjufsDch97o/UULC8hi0brXIZhMVC09A5dxdhF4YPWQWHLM2ajfWIO/SNwGJDcW5TkUXAxX+GVclAkFRlO09H5/QfwI1U5Sl7h953Qc/pXKcpfgmPhENo7RTD2todmOt6rU+t9CfmePBhIK4MpI25ax54lho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618904; c=relaxed/simple;
	bh=elzsazoJGhT/l3YkPSTCJFVisXIqXWwRZRIMxSpG5e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pp+QGdSj4aNbAFb3hxGwp+AXup/p1ZUhBGV90el0N2VtwvNt0lk+K2vkFcc0AzAE7v01nfZtnqZAvbiRz9R78/xC6WuzJtYKY6L/QWWVDiXi78ubGJFIi3n7yP6rA8P1UWf3WpSc4yLipiHz1HXHMavhhci00fUcIWWY76J1E/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lErp9xWm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755618902; x=1787154902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=elzsazoJGhT/l3YkPSTCJFVisXIqXWwRZRIMxSpG5e4=;
  b=lErp9xWmo6ESf8KZXRZXkFi3P02zkqvohK6pw9hizksHj7S3dm5JAqgY
   ut3pSQ2+8cbROIMyPG145i+gIDX0D8zp+u/Plc/1dtcP4uPsfo0WBzwmp
   oohlcjTNMzqB0sR+RtfLZ9qrNO1Qs+XWjjTHKVpYeUT5wAdyy86AqGtOx
   PnxA3+8XSEBkdeS90zTIPQL1BbzBARuL0zLIbWIctLy+EyO4vMgP62Wc1
   SFQIB6se88A1vV5laD5J0ClgeSBEfnx/bYowKfQSmG5HVFxz5PLwma4q4
   PaJbeSylac57aHOwo6kxXgsauzUjTFNKRiiliP8KzAjdTGfVrmvBBm4VF
   g==;
X-CSE-ConnectionGUID: DwpU7X7UTT+cNap5x5hzxg==
X-CSE-MsgGUID: YFD6XGMmQPyf5pnfNbrpSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="45439293"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="45439293"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:55:01 -0700
X-CSE-ConnectionGUID: vUzDyHHWQS2x3DESsEsdkA==
X-CSE-MsgGUID: +vEhkGqpTe+jFMa1S3r4UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167845710"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:55:01 -0700
Received: from [10.246.164.250] (kliang2-mobl1.ccr.corp.intel.com [10.246.164.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8E7A320B571C;
	Tue, 19 Aug 2025 08:55:00 -0700 (PDT)
Message-ID: <7009606d-0c47-4c3f-a7f9-0ae1922c9e5f@linux.intel.com>
Date: Tue, 19 Aug 2025 08:55:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/17] perf/x86: Support XMM register for non-PEBS and
 REGS_USER
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, dave.hansen@linux.intel.com, irogers@google.com,
 adrian.hunter@intel.com, jolsa@kernel.org,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 dapeng1.mi@linux.intel.com, ak@linux.intel.com, zide.chen@intel.com,
 mark.rutland@arm.com, broonie@kernel.org, ravi.bangoria@amd.com,
 eranian@google.com
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
 <20250815213435.1702022-6-kan.liang@linux.intel.com>
 <20250819133902.GJ4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250819133902.GJ4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-19 6:39 a.m., Peter Zijlstra wrote:
> On Fri, Aug 15, 2025 at 02:34:23PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Collecting the XMM registers in a PEBS record has been supported since
>> the Icelake. But non-PEBS events don't support the feature. It's
>> possible to retrieve the XMM registers from the XSAVE for non-PEBS.
>> Add it to make the feature complete.
>>
>> To utilize the XSAVE, a 64-byte aligned buffer is required. Add a
>> per-CPU ext_regs_buf to store the vector registers. The size of the
>> buffer is ~2K. kzalloc_node() is used because there's a _guarantee_
>> that all kmalloc()'s with powers of 2 are naturally aligned and also
>> 64b aligned.
>>
>> Extend the support for both REGS_USER and REGS_INTR. For REGS_USER, the
>> perf_get_regs_user() returns the regs from the task_pt_regs(current),
>> which is struct pt_regs. Need to move it to local struct x86_perf_regs
>> x86_user_regs.
>> For PEBS, the HW support is still preferred. The XMM should be retrieved
>> from PEBS records.
>>
>> There could be more vector registers supported later. Add ext_regs_mask
>> to track the supported vector register group.
> 
> 
> I'm a little confused... *again* :-)
> 
> Specifically, we should consider two sets of registers:
> 
>  - the live set, as per the CPU (XSAVE)
>  - the stored set, as per x86_task_fpu()
> 
> regs_intr should always get a copy of the live set; however
> regs_user should not. It might need a copy of the x86_task_fpu() instead
> of the live set, depending on TIF_NEED_FPU_LOAD (more or less, we need
> another variable set in kernel_fpu_begin_mask() *after*
> save_fpregs_to_fpstate() is completed).
> 
> I don't see this code make this distinction.
> 
> Consider getting a sample while the kernel is doing some avx enhanced
> crypto and such.

The regs_user only needs a set when the NMI hits the user mode
(user_mode(regs)) or a non-kernel thread (!(current->flags &
PF_KTHREAD)). The live set is good enough for both cases.

I think the kernel crypto should be to a kernel thread (current->flags &
PF_KTHREAD). If so, the regs_user should return NULL.

Thanks,
Kan


