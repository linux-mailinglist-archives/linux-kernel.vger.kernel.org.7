Return-Path: <linux-kernel+bounces-787545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D00EB377AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6BA1B6537A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7A272E6D;
	Wed, 27 Aug 2025 02:21:48 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2106272E41
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261308; cv=none; b=NOuBSs9KmwexekQ3nYqdUwLlCxO5913G8k/H6Fr2CFW3JnkUsC87tO7cjaLmKNoF/2l9PlHmv+6Fw8orzVgKp2b6fZmVyhBuIMyuB0PzKlFx4PKfojXwTPBZIIP9GSfCNIZiI6K7ObWICJFi/AAMNAG4gziHj1nq/Pfky9tag9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261308; c=relaxed/simple;
	bh=ktnruOQJp0fW0crf6QDh/6+fpHsg16g3FKNiZsNX5xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pwUvnIFurGgC6zEiIodWm48yzKQo75rm+jxlpzs8ApreFRQOFJVwbIaQZSqfu7UX05XLDR3CSgimbP+F+yYGSBMBRb/QpnQR854Pw96u3k+c4WH8QsMZtWxL9OwOZ/3ZkwWCi7GaJyzRuObqQhFzPVmwoHMiImyYB4fi1kf/XF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cBStj6npGztTWx;
	Wed, 27 Aug 2025 10:20:45 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id A172F1800B1;
	Wed, 27 Aug 2025 10:21:43 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 10:21:42 +0800
Message-ID: <c8c3d0d5-e9e1-44de-8722-1e7d09786b51@huawei.com>
Date: Wed, 27 Aug 2025 10:21:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for
 DAMOS_PAGEOUT
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>, <kernel-team@meta.com>,
	kernel test robot <lkp@intel.com>
References: <20250826142155.53632-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250826142155.53632-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf200018.china.huawei.com (7.185.36.31)


在 2025/8/26 22:21, SeongJae Park 写道:
> On Tue, 26 Aug 2025 12:51:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> Hi SJ,
>>
>> 在 2025/8/26 11:21, SeongJae Park 写道:
>>> [...]
>>>
>>>>> ==== Attachment 0 (0001-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_pageo.patch) ====
>>>>>    From hackermail Thu Jan  1 00:00:00 1970
>>>>> From: SeongJae Park <sj@kernel.org>
>>>>> To: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: SeongJae Park <sj@kernel.org>
>>>>> Cc: damon@lists.linux.dev
>>>>> Cc: kernel-team@meta.com
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Cc: linux-mm@kvack.org
>>>>> Date: Mon, 25 Aug 2025 07:41:33 -0700
>>>>> Subject: [PATCH 1/3] mm/damon/paddr: use do_div() on i386 for damon_pa_pageout()
>>>>>             return value
>>>>>
>>>>> Otherwise, __udidi3 linking problem happens on certain configs.
>>>>>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/
>>>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>>>> ---
>>>>>     mm/damon/paddr.c | 14 +++++++++++++-
>>>>>     1 file changed, 13 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>>>>> index 5fad2f9a99a0..09c87583af6c 100644
>>>>> --- a/mm/damon/paddr.c
>>>>> +++ b/mm/damon/paddr.c
>>>>> @@ -135,6 +135,18 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
>>>>>     	return false;
>>>>>     }
>>>>>     
>>>>> +/* convert physical address to core-layer address */
>>>>> +static unsigned long damon_pa_core_addr(phys_addr_t pa,
>>>>> +		unsigned long addr_unit)
>>>>> +{
>>>>> +#ifdef __i386__
>>>> Can we use the following condition instead?
>>>>
>>>> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
>>> To my understanding, this issue happens only on i386, not every 32bit
>>> architectures.  So I think i386 specific condition is better.
>> I understand. However, the aforementioned general condition is essential,
>> and we should propose a new patch to address this. After introducing addr_unit,
>> any 32-bit architecture should support monitoring of 64-bit phys_addr_t.
> The issue is that we cannot divide 64bit values with plain '/' operator on
> "i386", and hence this patch makes it to use do_div() instead of '/' on "i386".
> No such or other problems at supporting 64-bit phys_addr_t is found on other
> 32bit architectures, to my understanding.  My understanding is that at least
> you confirmed that on your arm-based test environment.  So we don't need a new
> patch to my understanding.
>
> Am I missing somthing?

This is because I seem to have made a mistake earlier: I adjusted the local
compilation toolchain. When the __udivdi3 issue mentioned above occurred, it
reminded me of a potential problem. After switching to a completely new environment
for testing, I discovered the __aeabi_uldivmod linking error in arm, which is similar
to the __udivdi3 issue.🙁 To prevent similar environment-related problems in the
future, I suggest adjusting the condition to the following:

#if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)

Please consider approving this fix.


Best regards,
Quanmin Yan


[...]


