Return-Path: <linux-kernel+bounces-743997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB9EB106B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C877189D214
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A0252287;
	Thu, 24 Jul 2025 09:35:23 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71224DCEA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349722; cv=none; b=iu54HJFkEhpzfNzg2l8oezfySyK8aeBRrcWOG9oZnao8dFMQKLUCkE+yaKbZFDSbJbh+dod01Nt+R3KKTg3D5TPBsoYdHmMj/UVdkGVNYR8mHVWVnOCOE05O9fKUN5AtEd72mI2HbxCy5lFLU8SJTLJCL3xBrdIzqa2GsGLu/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349722; c=relaxed/simple;
	bh=MwYzkwplxjT8TFeYLLWOUaBok/od1wayyWGfll2r4bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EiKE1qT/ogp1uX2ShJvXeLkUqVo7u9HC3PeRwZavwYKrnlcX2mVa2nDxMa8uolQokD8dGHJwWsUOQ++DJSQ7bJzDh8bY9dWnh60PObIneCG+Gzn+bXaHgy6OnmsfQYQ86kXGWb0KIbvMacNX7gt5h2czvYggw2fvZtXg1YAz45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bnm4h4SPtz1R8kk;
	Thu, 24 Jul 2025 17:32:36 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BD09140109;
	Thu, 24 Jul 2025 17:35:17 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 17:35:16 +0800
Message-ID: <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com>
Date: Thu, 24 Jul 2025 17:35:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Barry Song <21cnbao@gmail.com>, <m.szyprowski@samsung.com>
CC: <robin.murphy@arm.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<iommu@lists.linux.dev>
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-3-xiaqinxin@huawei.com>
 <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
> On Thu, Jul 24, 2025 at 4:56 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> The padding field in the structure was previously reserved to
>> maintain a stable interface for potential new fields, ensuring
>> compatibility with user-space shared data structures.
>> However,it was accidentally removed by tiantao in a prior commit,
>> which may lead to incompatibility between user space and the kernel.
>>
>> This patch reinstates the padding to restore the original structure
>> layout and preserve compatibility.
>>
>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
>> Cc: stable@vger.kernel.org
>> Acked-by: Barry Song <baohua@kernel.org>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> 
> I don’t think these two patches should be part of the same series. This
> one is a bug fix and should be handled separately—ideally picked up on
> its own and backported to stable.
> 
> Also, the subject should not say "Add"—it should be "Restore". I assume
> Marek can handle it?
> 
>> ---
>>   include/linux/map_benchmark.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
>> index 62674c83bde4..2ac2fe52f248 100644
>> --- a/include/linux/map_benchmark.h
>> +++ b/include/linux/map_benchmark.h
>> @@ -27,5 +27,6 @@ struct map_benchmark {
>>          __u32 dma_dir; /* DMA data direction */
>>          __u32 dma_trans_ns; /* time for DMA transmission in ns */
>>          __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>> +       __u8 expansion[76];     /* For future use */
>>   };
>>   #endif /* _KERNEL_DMA_BENCHMARK_H */
>> --
>> 2.33.0
>>
> 
> Thanks
> Barry

Ok, I will send a new version to fix it.
Thanks

