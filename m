Return-Path: <linux-kernel+bounces-770631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B93B27D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F6DAC1529
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAE52FAC13;
	Fri, 15 Aug 2025 09:38:04 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC82F8BCA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250683; cv=none; b=qL3286xCleilqKN/xQcuf9v0bmkMtjzd7qDGuvw47MIjYK8nXL2OwAfnCSfKFAXTmLiTzQU09fCTSEAmb5sWelmvWtMMYxfKAKi2/0/ugP6h3RjqJv18A+6vu9HfjwEcrPYsEyUEFEZTYO/SHAXctHlrAt5M9km8VuBaUEoXiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250683; c=relaxed/simple;
	bh=KaAbjUDKXRcCuA+7QEp4VpyM7NO+ivnlH82NEJU9BJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cgQX4v8UyjaK5XA6vfgYDpt+2ulBXL40tdiLZRkB+YecvRNaqdH5CT8MOdqmmJnv9q7S+cl6aU6IHve/ASnFMGuWho8A+6udQb0CViihOcdSIkZGAQI1hYpytIVgFXllpuWOs9bfMzQxaCX25afLMGhJo1wLf3cL/t+FrdDOBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c3H3j0LPGzdcDM;
	Fri, 15 Aug 2025 17:33:37 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id C3E66140258;
	Fri, 15 Aug 2025 17:37:57 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 17:37:57 +0800
Message-ID: <74a6ad14-efd8-4056-aad0-ad5ab4b30968@huawei.com>
Date: Fri, 15 Aug 2025 17:37:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: add myself and Barry to
 dma_map_benchmark maintainers
To: Barry Song <21cnbao@gmail.com>
CC: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <yangyicong@huawei.com>
References: <20250814133527.2679261-1-xiaqinxin@huawei.com>
 <20250814133527.2679261-3-xiaqinxin@huawei.com>
 <CAGsJ_4zM5Qcr88Z+Rs_XwFcEJ_x+tZMUXycxDTHE+vCsydQYdw@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4zM5Qcr88Z+Rs_XwFcEJ_x+tZMUXycxDTHE+vCsydQYdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/8/15 17:28:07, Barry Song <21cnbao@gmail.com> wrote:
> On Fri, Aug 15, 2025 at 1:35 AM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> Since Chenxiang has left HiSilicon, Barry and I will jointly
>> maintain this module.
>>
>> Cc: Barry Song <baohua@kernel.org>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   MAINTAINERS | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a5f17a58ffee..21e623b53a7f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7219,10 +7219,11 @@ F:      include/linux/dmaengine.h
>>   F:     include/linux/of_dma.h
>>
>>   DMA MAPPING BENCHMARK
>> -M:     Xiang Chen <chenxiang66@hisilicon.com>
>> +M:     Barry Song <baohua@kernel.org>
>> +M:     Qinxin Xia <xiaqinxin@huawei.com>
>>   L:     iommu@lists.linux.dev
>>   F:     kernel/dma/map_benchmark.c
>> -F:     tools/testing/selftests/dma/
>> +F:     tools/dma/
> 
> That seems a bit odd — this change should have been included in the
> previous patch. Alternatively, you could submit the maintainer change
> before moving the `tools/dma` folder. In short, this diff belongs with
> the folder move.
> 
> These two patches appear unrelated. Should they be a single series
> rather than two separate patches?
> 
> 
OK, I'll separate them in the next version. By the way, is there any 
suggestion for another patch's Makefile?>>
>>   DMA MAPPING HELPERS
>>   M:     Marek Szyprowski <m.szyprowski@samsung.com>
>> --
>> 2.33.0
>>
> 
> Thanks
> Barry


