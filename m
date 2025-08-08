Return-Path: <linux-kernel+bounces-759823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D99B6B1E33A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A186018A3878
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BC1244E8C;
	Fri,  8 Aug 2025 07:20:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3B522FF2D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637639; cv=none; b=eP7r6wbqs3JmkMZLM981UzaByK0keloinLjS7Q0/3TbQWk4e4R7btOSzvJICztZDLhz2GySBNjxwQF/ThFIkRIlhlHjACozJKRZsmQM69mWhnGnOF+NnJA74eS5jhA3uWnouLYDUQxBeMjiznp7nGlljfjyNLBz8Yp2QWLbygOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637639; c=relaxed/simple;
	bh=IkCAf5t6UkYyC1UKhTiX+pCqKezVhF7+B1DJtNHte7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uICyQukspboeAg5CnaXNAI/Oo6eDwSeacVKZOXOPgNAyPa14SilqejcInnzf92mJeZFYLsgyMTwGL0TEQqUw5Kv6UjZ4/hKEFZW/1h/Gt163tVJrDwf3n+7o3NEpT7DCIqOzZUVWkjaCu532Gr7BOUw/v6seIOvGJN1Z2swc4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2171122EA;
	Fri,  8 Aug 2025 00:20:28 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F9B33F673;
	Fri,  8 Aug 2025 00:20:31 -0700 (PDT)
Message-ID: <99531c99-0430-4248-960a-a55fcdba79da@arm.com>
Date: Fri, 8 Aug 2025 08:20:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/36] arm_mpam: Probe the hardware features resctrl
 supports
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-21-james.morse@arm.com>
 <46e49e66-1da3-433c-bdad-9468133c78a2@arm.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <46e49e66-1da3-433c-bdad-9468133c78a2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 28/07/2025 09:56, Ben Horgan wrote:
> On 7/11/25 19:36, James Morse wrote:
>> Expand the probing support with the control and monitor types
>> we can use with resctrl.

>> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/
>> mpam_internal.h
>> index 42a454d5f914..ae6fd1f62cc4 100644
>> --- a/drivers/platform/arm64/mpam/mpam_internal.h
>> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
>> @@ -136,6 +136,55 @@ static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
>>           lockdep_assert_preemption_enabled();
>>   }
>>   +/*
>> + * When we compact the supported features, we don't care what they are.
>> + * Storing them as a bitmap makes life easy.
>> + */
>> +typedef u16 mpam_features_t;
>> +
>> +/* Bits for mpam_features_t */
>> +enum mpam_device_features {
>> +    mpam_feat_ccap_part = 0,
>> +    mpam_feat_cpor_part,
>> +    mpam_feat_mbw_part,
>> +    mpam_feat_mbw_min,
>> +    mpam_feat_mbw_max,
>> +    mpam_feat_mbw_prop,
>> +    mpam_feat_msmon,
>> +    mpam_feat_msmon_csu,
>> +    mpam_feat_msmon_csu_capture,
>> +    mpam_feat_msmon_csu_hw_nrdy,
>> +    mpam_feat_msmon_mbwu,
>> +    mpam_feat_msmon_mbwu_capture,
>> +    mpam_feat_msmon_mbwu_rwbw,
>> +    mpam_feat_msmon_mbwu_hw_nrdy,
>> +    mpam_feat_msmon_capt,
>> +    MPAM_FEATURE_LAST,
>> +};
>> +#define MPAM_ALL_FEATURES      ((1 << MPAM_FEATURE_LAST) - 1)
> 
> Consider a static assert to check the type is big enough.
> 
> static_assert(BITS_PER_TYPE(mpam_features_t) >= MPAM_FEATURE_LAST);

Fancy.
There used to be an uglier one - not sure what happened to it!



Thanks,

James

