Return-Path: <linux-kernel+bounces-731362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92847B0532F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3163AC3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC4926FDBF;
	Tue, 15 Jul 2025 07:27:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B119626E707
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564425; cv=none; b=VS5yOTj0+JZOwiselK6WQRo0Z/NEbS2N7xXXtM6FF6Iv/i1wWeP3nowTxKcSpAL9GFeiJ3xrnEI3b6Z2DG0p55jnwErmvy9zdYcBBI+w2LPUpsiFTJFzhaqU799XG9Z+pHzhqkOY0QYNHGbxY4rDmD3HvAc23tFQKAXYOPmaEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564425; c=relaxed/simple;
	bh=onk1e5r1O6PPbFvMmE4bHIccZnEMOarirjqrIdphFf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmpXlnddoXH6jMT+8WFw037JR3jC2eZftI23+Hw2VZCWjRTencyx7wqtxbfDZmYcbJ2IZqusUOlgutG4nu2OVQBczCzpvfr3Ig4t9FwgkJqTOAMxItPNBCVUBDLMJrAxtjoQNio2EpIRZ1mZZeVHnNcnJIHFeUHgwN3ulREot2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0AC912FC;
	Tue, 15 Jul 2025 00:26:52 -0700 (PDT)
Received: from [10.163.92.132] (unknown [10.163.92.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CA1A3F66E;
	Tue, 15 Jul 2025 00:26:57 -0700 (PDT)
Message-ID: <09f9d195-7f3c-4cf1-95da-7e29c398ebcc@arm.com>
Date: Tue, 15 Jul 2025 12:56:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/28] coresight: etm4x: Always set tracer's device
 mode on target CPU
To: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Yabin Cui <yabinc@google.com>, Keita Morisaki <keyz@google.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250701-arm_cs_pm_fix_v3-v2-0-23ebb864fcc1@arm.com>
 <20250701-arm_cs_pm_fix_v3-v2-2-23ebb864fcc1@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250701-arm_cs_pm_fix_v3-v2-2-23ebb864fcc1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/07/25 8:23 PM, Leo Yan wrote:
> When enabling a tracer via SysFS interface, the device mode may be set
> by any CPU - not necessarily the target CPU. This can lead to race
> condition in SMP, and may result in incorrect mode values being read.
> 
> Consider the following example, where CPU0 attempts to enable the tracer
> on CPU1 (the target CPU):
> 
>  CPU0                                    CPU1
>  etm4_enable()
>   ` coresight_take_mode(SYSFS)
>   ` etm4_enable_sysfs()
>      ` smp_call_function_single() ---->  etm4_enable_hw_smp_call()
>      			                /
>                                        /  CPU idle:
>                                       /   etm4_cpu_save()
>                                      /     ` coresight_get_mode()
> 	       Failed to enable h/w /         ^^^
>   ` coresight_set_mode(DISABLED) <-'          Read the intermediate SYSFS mode

The problem is - CPU1's HW state and CPU1's sysfs mode state might not
remain in sync if CPU1 goes into idle state just after an unsuccessful
etm4_enable_sysfs() attempt from CPU0. In which case a subsequent read
coresight_get_mode() on CPU1 might erroneously give us DISABLED state,
which actually does not seem to be too bad as the earlier enablement
attempt had failed anyway. Just trying to understand what is the real
problem here.

> 
> In this case, CPU0 initiates the operation by taking the SYSFS mode to
> avoid conflicts with the Perf mode. It then sends an IPI to CPU1 to
> configure the tracer registers. If any error occurs during this process,

What kind of error can happen during this process ?

> CPU0 rolls back by setting the mode to DISABLED.

Which seems OK.

> 
> However, if CPU1 enters an idle state during this time, it might read
> the intermediate SYSFS mode. As a result, the CPU PM flow could wrongly
> save and restore tracer context that is actually disabled.

Right but CPU0 had marked the CPU1' state as DISABLED after the enable
attempt had failed. So what is the problem ?

> 
> To resolve the issue, this commit moves the device mode setting logic on
> the target CPU. This ensures that the device mode is only modified by
> the target CPU, eliminating race condition between mode writes and reads
> across CPUs.
> 
> An additional change introduces the etm4_disable_hw_smp_call() function
> for SMP calls, which disables the tracer and explicitly set the mode to
> DISABLED during SysFS operations.
> 
> The flow is updated with this change:
> 
>  CPU0                                    CPU1
>  etm4_enable()
>   ` etm4_enable_sysfs()
>      ` smp_call_function_single() ---->  etm4_enable_hw_smp_call()
>                                           ` coresight_take_mode(SYSFS)
> 	                                    Failed, set back to DISABLED
>                                           ` coresight_set_mode(DISABLED)
> 
>                                           CPU idle:
>                                           etm4_cpu_save()
>                                            ` coresight_get_mode()
>                                               ^^^
>                                               Read out the DISABLED mode
> 
> Fixes: c38a9ec2b2c1 ("coresight: etm4x: moving etm_drvdata::enable to atomic field")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 48 +++++++++++++++-------
>  1 file changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 42e5d37403addc6ec81f2e3184522d67d1677c04..ee405c88ea5faa130819f96b00b8307f8764d58a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -590,10 +590,23 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  static void etm4_enable_hw_smp_call(void *info)
>  {
>  	struct etm4_enable_arg *arg = info;
> +	struct coresight_device *csdev;
>  
>  	if (WARN_ON(!arg))
>  		return;
> +
> +	csdev = arg->drvdata->csdev;
> +	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
> +		/* Someone is already using the tracer */
> +		arg->rc = -EBUSY;
> +		return;
> +	}
> +
>  	arg->rc = etm4_enable_hw(arg->drvdata);
> +
> +	/* The tracer didn't start */
> +	if (arg->rc)
> +		coresight_set_mode(csdev, CS_MODE_DISABLED);
>  }
>  
>  /*
> @@ -809,6 +822,9 @@ static int etm4_enable_perf(struct coresight_device *csdev,
>  	int ret = 0;
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> +	if (!coresight_take_mode(csdev, CS_MODE_PERF))
> +		return -EBUSY;
> +
>  	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id())) {
>  		ret = -EINVAL;
>  		goto out;
> @@ -828,6 +844,9 @@ static int etm4_enable_perf(struct coresight_device *csdev,
>  	ret = etm4_enable_hw(drvdata);
>  
>  out:
> +	/* The tracer didn't start */
> +	if (ret)
> +		coresight_set_mode(csdev, CS_MODE_DISABLED);
>  	return ret;
>  }
>  
> @@ -880,11 +899,6 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
>  {
>  	int ret;
>  
> -	if (!coresight_take_mode(csdev, mode)) {
> -		/* Someone is already using the tracer */
> -		return -EBUSY;
> -	}
> -
>  	switch (mode) {
>  	case CS_MODE_SYSFS:
>  		ret = etm4_enable_sysfs(csdev, path);
> @@ -896,10 +910,6 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
>  		ret = -EINVAL;
>  	}
>  
> -	/* The tracer didn't start */
> -	if (ret)
> -		coresight_set_mode(csdev, CS_MODE_DISABLED);
> -
>  	return ret;
>  }
>  
> @@ -951,10 +961,9 @@ static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
>  	isb();
>  }
>  
> -static void etm4_disable_hw(void *info)
> +static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>  {
>  	u32 control;
> -	struct etmv4_drvdata *drvdata = info;
>  	struct etmv4_config *config = &drvdata->config;
>  	struct coresight_device *csdev = drvdata->csdev;
>  	struct csdev_access *csa = &csdev->access;
> @@ -991,6 +1000,15 @@ static void etm4_disable_hw(void *info)
>  		"cpu: %d disable smp call done\n", drvdata->cpu);
>  }
>  
> +static void etm4_disable_hw_smp_call(void *info)
> +{
> +	struct etmv4_drvdata *drvdata = info;
> +
> +	etm4_disable_hw(drvdata);
> +
> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> +}
> +
>  static int etm4_disable_perf(struct coresight_device *csdev,
>  			     struct perf_event *event)
>  {
> @@ -1020,6 +1038,8 @@ static int etm4_disable_perf(struct coresight_device *csdev,
>  	/* TRCVICTLR::SSSTATUS, bit[9] */
>  	filters->ssstatus = (control & BIT(9));
>  
> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> +
>  	/*
>  	 * perf will release trace ids when _free_aux() is
>  	 * called at the end of the session.
> @@ -1045,7 +1065,8 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>  	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
>  	 * ensures that register writes occur when cpu is powered.
>  	 */
> -	smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
> +	smp_call_function_single(drvdata->cpu, etm4_disable_hw_smp_call,
> +				 drvdata, 1);
>  
>  	raw_spin_unlock(&drvdata->spinlock);
>  
> @@ -1085,9 +1106,6 @@ static void etm4_disable(struct coresight_device *csdev,
>  		etm4_disable_perf(csdev, event);
>  		break;
>  	}
> -
> -	if (mode)
> -		coresight_set_mode(csdev, CS_MODE_DISABLED);
>  }
>  
>  static int etm4_resume_perf(struct coresight_device *csdev)
> 


