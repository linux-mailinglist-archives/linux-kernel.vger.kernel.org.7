Return-Path: <linux-kernel+bounces-787720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87460B37A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7D7219AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FEF268C40;
	Wed, 27 Aug 2025 06:21:50 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B728E7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275710; cv=none; b=YnxXMNxH+WN59IRr+F+o23naP4+jcoA3U2tUG/LCN2evphWe7p36iloDvjkrG+HrL933enEepPgRN9yICp/Qlf3M0ybqMtW6GO6NTsKFEw+hLZr74w97my5hk61gqXAcuSDlPY8CtFP61N8RQWIhzKYixE2opps6UmIuwomHQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275710; c=relaxed/simple;
	bh=qkUIUlq5HFOeb/0xRuJpsy0OFYcAYQqv4Etjukxf/yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ItlIaMW5Ylldd3e0fu47sV5djDLmWH0rQQ3PgVptnLaVT/DY3TC+dzjyy7ILMWBeUpdL7phB3UyeIYPykWMN+FLuSprUAM9m7cMcsKscIRNjNLJOTBhLB4p2B2lmc+sI9XCCn3XKZrYA2ivJVigX/6A3++cwYzSKIRsM8Xxkd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cBZDW4XS3z14Mbr;
	Wed, 27 Aug 2025 14:21:31 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E6A918049C;
	Wed, 27 Aug 2025 14:21:38 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 14:21:38 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 14:21:37 +0800
Message-ID: <9465540b-44da-4f53-a8e9-97a648a0c023@huawei.com>
Date: Wed, 27 Aug 2025 14:21:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] drivers/perf: hisi: Add support for L3C PMU v3
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <yangyicong@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@h-partners.com>
References: <20250821135049.2010220-1-wangyushan12@huawei.com>
 <20250821135049.2010220-8-wangyushan12@huawei.com>
 <20250826141235.000028b8@huawei.com>
Content-Language: en-US
From: wangyushan <wangyushan12@huawei.com>
In-Reply-To: <20250826141235.000028b8@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)



On 8/26/2025 9:12 PM, Jonathan Cameron wrote:
> On Thu, 21 Aug 2025 21:50:47 +0800
> Yushan Wang <wangyushan12@huawei.com> wrote:
>
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> This patch adds support for L3C PMU v3. The v3 L3C PMU supports
>> an extended events space which can be controlled in up to 2 extra
>> address spaces with separate overflow interrupts. The layout
>> of the control/event registers are kept the same. The extended events
>> with original ones together cover the monitoring job of all transactions
>> on L3C.
>>
>> The extended events is specified with `ext=[1|2]` option for the
>> driver to distinguish, like below:
>>
>> perf stat -e hisi_sccl0_l3c0_0/event=<event_id>,ext=1/
>>
>> Currently only event option using config bit [7, 0]. There's
>> still plenty unused space. Make ext using config [16, 17] and
>> reserve bit [15, 8] for event option for future extension.
>>
>> With the capability of extra counters, number of counters for HiSilicon
>> uncore PMU could reach up to 24, the usedmap is extended accordingly.
>>
>> The hw_perf_event::event_base is initialized to the base MMIO
>> address of the event and will be used for later control,
>> overflow handling and counts readout.
>>
>> We still make use of the Uncore PMU framework for handling the
>> events and interrupt migration on CPU hotplug. The framework's
>> cpuhp callback will handle the event migration and interrupt
>> migration of orginial event, if PMU supports extended events
>> then the interrupt of extended events is migrated to the same
>> CPU choosed by the framework.
>>
>> A new HID of HISI0215 is used for this version of L3C PMU.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Co-developed-by: Yushan Wang <wangyushan12@huawei.com>
>> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> One minor formatting thing I missed in internal reviews. With that
> tidied up (check other patches for this as well)
>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>>   
>>   static void hisi_l3c_pmu_stop_counters(struct hisi_pmu *l3c_pmu)
>>   {
>> +	struct hisi_l3c_pmu *hisi_l3c_pmu = to_hisi_l3c_pmu(l3c_pmu);
>> +	unsigned long *used_mask = l3c_pmu->pmu_events.used_mask;
>> +	unsigned long bit = find_first_bit(used_mask, l3c_pmu->num_counters);
>>   	u32 val;
>> +	int i;
>>   
>>   	/*
>> -	 * Clear perf_enable bit in L3C_PERF_CTRL register to stop counting
>> -	 * for all enabled counters.
>> +	 * Check if any counter belongs to the normal range (instead of ext
>> +	 * range). If so, stop it.
>>   	 */
>> -	val = readl(l3c_pmu->base + L3C_PERF_CTRL);
>> -	val &= ~(L3C_PERF_CTRL_EN);
>> -	writel(val, l3c_pmu->base + L3C_PERF_CTRL);
>> +	if (bit < L3C_NR_COUNTERS) {
>> +		val = readl(l3c_pmu->base + L3C_PERF_CTRL);
>> +		val &= ~(L3C_PERF_CTRL_EN);
> Brackets not adding anything here and inconsistently applied.
> Please clean these up.

Sure, sorry for the noises.

Will fix that and look for other similar issues in the patches.

Thanks!

>> +		writel(val, l3c_pmu->base + L3C_PERF_CTRL);
>> +	}
>> +
>> +	/* If not, do stop it on ext ranges. */
>> +	for (i = 0; i < hisi_l3c_pmu->ext_num; i++) {
>> +		bit = find_next_bit(used_mask, L3C_NR_COUNTERS * (i + 2),
>> +				    L3C_NR_COUNTERS * (i + 1));
>> +		if (L3C_CNTR_EXT(bit) != i + 1)
>> +			continue;
>> +
>> +		val = readl(hisi_l3c_pmu->ext_base[i] + L3C_PERF_CTRL);
>> +		val &= ~L3C_PERF_CTRL_EN;
>> +		writel(val, hisi_l3c_pmu->ext_base[i] + L3C_PERF_CTRL);
>> +	}
>>   }


