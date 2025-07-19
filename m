Return-Path: <linux-kernel+bounces-737703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C30B0AF94
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5BA3BB4AE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C3A222560;
	Sat, 19 Jul 2025 11:20:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9461EA73
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752924047; cv=none; b=kWbD83PlT+GJRIo40u/YAL1fkKVH2drF5Fn0XG1/EtGqriwfX8esQVRKepm72Z29k1l6uCJXwF7RvUVVpeB1nutWqLYTQMxkjL2CCczmf7jTeFlm3sPIowtU+3xW2d4fKO0PQdwQyya4zGWJAHzxBjYgia0O1XZzSKoMnzibfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752924047; c=relaxed/simple;
	bh=wKRcmvvNZsjEh4pQ5owyaR96v2/zfvFFwGK+Ts+x8Fc=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fdSiX5dUdjlZCaLO6Jp21EzPD8ZVdwRuDbJypZCnI5/u87pQGK9Xx/hcz/wHFmTJwTltXNDB0IyAMhOIRJ37m6fPSMQpuJ1iz2AvwpSvoApn8t6Qc4Rd27blcEzlWlwz6UhrJRRcHVwmXrVYAC3h7nzR4zBW8+bOBgirU0r4xEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bkkgF3rS4z2FbN6;
	Sat, 19 Jul 2025 19:18:33 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 55DB31800B2;
	Sat, 19 Jul 2025 19:20:41 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 19:20:41 +0800
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 19:20:40 +0800
Subject: Re: [PATCH v2 3/3] coresight: tmc: Decouple the perf buffer
 allocation from sysfs mode
To: Leo Yan <leo.yan@arm.com>
References: <20250620075412.952934-1-hejunhao3@huawei.com>
 <20250620075412.952934-4-hejunhao3@huawei.com>
 <20250702170827.GB1039028@e132581.arm.com>
CC: <suzuki.poulose@arm.com>, <james.clark@arm.com>,
	<anshuman.khandual@arm.com>, <coresight@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<yangyicong@huawei.com>, <prime.zeng@hisilicon.com>
From: hejunhao <hejunhao3@huawei.com>
Message-ID: <32bbc3dc-d723-6034-ba39-bf01dfbcf81e@huawei.com>
Date: Sat, 19 Jul 2025 19:20:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250702170827.GB1039028@e132581.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn500004.china.huawei.com (7.202.194.145)


On 2025/7/3 1:08, Leo Yan wrote:
> On Fri, Jun 20, 2025 at 03:54:12PM +0800, Junhao He wrote:
>
> [..]
>
>> @@ -1341,33 +1339,24 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
>>   	unsigned long size;
>>   
>>   	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
>> -	/*
>> -	 * Try to match the perf ring buffer size if it is larger
>> -	 * than the size requested via sysfs.
>> -	 */
>> -	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
>> -		etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << PAGE_SHIFT),
>> -					    0, node, NULL);
>> -		if (!IS_ERR(etr_buf))
>> -			goto done;
>> -	}
>> +
>> +	/* Use the minimum limit if the required size is smaller */
>> +	size = (unsigned long)nr_pages << PAGE_SHIFT;
> Please change the size's type to ssize_t, then:
>
>          size = nr_pages << PAGE_SHIFT;
>
>> +	if (size < TMC_ETR_PERF_MIN_BUF_SIZE)
>> +		size = TMC_ETR_PERF_MIN_BUF_SIZE;
> size = min_t(ssize_t, size, TMC_ETR_PERF_MIN_BUF_SIZE);

Sure, I will do that.

>>   
>>   	/*
>> -	 * Else switch to configured size for this ETR
>> -	 * and scale down until we hit the minimum limit.
>> +	 * Try to allocate the required size for this ETR, if failed scale
>> +	 * down until we hit the minimum limit.
>>   	 */
>> -	size = drvdata->size;
>>   	do {
>>   		etr_buf = tmc_alloc_etr_buf(drvdata, size, 0, node, NULL);
>>   		if (!IS_ERR(etr_buf))
>> -			goto done;
>> +			return etr_buf;
>>   		size /= 2;
>>   	} while (size >= TMC_ETR_PERF_MIN_BUF_SIZE);
> Do we really need to scale down buffer size for failure cases?
> I would like a straightforward code:
>
>          etr_buf = tmc_alloc_etr_buf(drvdata, size, 0, node, NULL);
>          if (IS_ERR_OR_NULL(etr_buf))
>                  return etr_buf;
>
> Just a side topic, we know tmc_alloc_etr_buf() should not return NULL
> pointer. For a sanity check, the callers (alloc_etr_buf(),
> tmc_etr_get_sysfs_buffer(), etc) should valid a buffer pointer with
> IS_ERR_OR_NULL() rather than IS_ERR(). This can be a separate patch.

A new patch will be added to achieve this.

Thank you for your comments.
Junhao.

> Thanks,
> Leo
>
>>   	return ERR_PTR(-ENOMEM);
>> -
>> -done:
>> -	return etr_buf;
>>   }
>>   
>>   static struct etr_buf *
>> -- 
>> 2.33.0
>>
> .
>


