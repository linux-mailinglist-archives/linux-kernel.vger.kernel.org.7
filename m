Return-Path: <linux-kernel+bounces-758152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C44B1CBAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7628C18C54BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C2A29CB40;
	Wed,  6 Aug 2025 18:07:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8B029C33C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503654; cv=none; b=aG65Xj49cmOavuw7ty5xaHCQSF31jCULw5ceS1b00DZCrTJz52/v3ncht+VulWwiXe9S9AB3bfIrvCitkUlgXBZEDR3WHUDvvVVKw2lAJJfZkTjtMnYZwVAnUK8slep8TV8AiLeGS1wbuCiG0WW3pKfPHRJDmBsMInLaMw1Vbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503654; c=relaxed/simple;
	bh=CaKjL0++SnUx3gkCzYPtfs3Eu4ajclGP5HvZ0b6cm9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3CJvOu8Koq11BzNOrnrMobXUEKGHPh/jxeFK1yPGVyvGdnOawsoP0ibn8FODQJ32wcEWnjNXfewjiIw/cSfFUJgtdOjGI52quv26JlFOiFMOAu+kY40Lp1nKr8zlGy7l1yhPUTejmqucblTRpWVBaYdlBX8GVg0SGqCieAG2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0745819F0;
	Wed,  6 Aug 2025 11:07:23 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39D283F738;
	Wed,  6 Aug 2025 11:07:27 -0700 (PDT)
Message-ID: <2164fca1-0a78-4c72-b93b-2b95d5f41e08@arm.com>
Date: Wed, 6 Aug 2025 19:07:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/36] arm_mpam: Add cpuhp callbacks to probe MSC
 hardware
To: Baisheng Gao <baisheng.gao@unisoc.com>
Cc: amitsinght@marvell.com, baolin.wang@linux.alibaba.com,
 ben.horgan@arm.com, bobo.shaobowang@huawei.com, carl@os.amperecomputing.com,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 kobak@nvidia.com, lcherian@marvell.com, lecopzerc@nvidia.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, quic_jiles@quicinc.com, rex.nie@jaguarmicro.com,
 robh@kernel.org, rohit.mathew@arm.com, scott@os.amperecomputing.com,
 sdonthineni@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 tan.shaopeng@fujitsu.com, xhao@linux.alibaba.com, zengheng4@huawei.com,
 hao_hao.wang@unisoc.com
References: <20250711183648.30766-18-james.morse@arm.com>
 <20250729061127.206-1-baisheng.gao@unisoc.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250729061127.206-1-baisheng.gao@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Baisheng,

On 29/07/2025 07:11, Baisheng Gao wrote:
>> Because an MSC can only by accessed from the CPUs in its cpu-affinity
>> set we need to be running on one of those CPUs to probe the MSC
>> hardware.
>>
>> Do this work in the cpuhp callback. Probing the hardware will only
>> happen before MPAM is enabled, walk all the MSCs and probe those we can
>> reach that haven't already been probed.
>>
>> Later once MPAM is enabled, this cpuhp callback will be replaced by
>> one that avoids the global list.
>>
>> Enabling a static key will also take the cpuhp lock, so can't be done
>> from the cpuhp callback. Whenever a new MSC has been probed schedule
>> work to test if all the MSCs have now been probed.


>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
>> index 0d6d5180903b..89434ae3efa6 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
>> @@ -513,9 +541,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>> +static void mpam_register_cpuhp_callbacks(int (*online)(unsigned int online),
>> +					  int (*offline)(unsigned int offline))
>> +{
>> +	mutex_lock(&mpam_cpuhp_state_lock);
>> +	if (mpam_cpuhp_state) {
>> +		cpuhp_remove_state(mpam_cpuhp_state);
>> +		mpam_cpuhp_state = 0;
>> +	}
>> +
>> +	mpam_cpuhp_state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mpam:online",
>> +					     online, offline);
>> +	if (mpam_cpuhp_state <= 0) {
>> +		pr_err("Failed to register cpuhp callbacks");
>> +		mpam_cpuhp_state = 0;
>> +	}
>> +	mutex_unlock(&mpam_cpuhp_state_lock);
>>  }
>>  
>>  static int mpam_dt_count_msc(void)

>> @@ -797,6 +900,46 @@ static struct platform_driver mpam_msc_driver = {
>> +static void mpam_enable_once(void)
>> +{
>> +	mutex_lock(&mpam_cpuhp_state_lock);
>> +	cpuhp_remove_state(mpam_cpuhp_state);
>> +	mpam_cpuhp_state = 0;
>> +	mutex_unlock(&mpam_cpuhp_state_lock);

> Deleting the above 4 lines?
> The mpam_cpuhp_state will be removed firstly in mpam_register_cpuhp_callbacks
> if the mpam_cpuhp_state isn't 0.

Yup - this is a pointless appendage because of the way the code evolved!
Thanks for catching it


James

>> +
>> +	mpam_register_cpuhp_callbacks(mpam_cpu_online, mpam_cpu_offline);
>> +
>> +	pr_info("MPAM enabled\n");
>> +}


