Return-Path: <linux-kernel+bounces-788206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE23B38137
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED0B5E4BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A62C0F78;
	Wed, 27 Aug 2025 11:37:48 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0AE2BDC37
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294668; cv=none; b=omjunK4TfeLsTQyqMe3DPadAwrW7ovfWcM2LIJCew0AheaaAAkUUnGwyR6ORNceDTNgsvUz2h30GWPofszkqyEug+SOUZre4B3yVO7C8djNt+RLCl/c57c0Ui5hcL5dPMBmG6GQmRB8YODm7jaQUVNm2PtXkOFQTavYEsuP6dsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294668; c=relaxed/simple;
	bh=9dnKcqc9ZxfIgifH4RbtjueN00a+MjNc8NfZpICC424=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tCkv9OZeMQTVj6VfWNJE3BrS8j8Oq4jPCHYt+QaCYbODmV5ik//JH1+ytzVE+TQThupAH/Sy7EWcEThz+CBNNkTT4F7eOjml3kKpjEX28YKYGfDFzvxnfwA/WOUHbra6uktbv+/VX6DjCdIJ3fXRLXFoltH9gDXBXqIXx0Aawxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cBj8C41csz2CgNN;
	Wed, 27 Aug 2025 19:33:15 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 70EFD1400D4;
	Wed, 27 Aug 2025 19:37:41 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 19:37:40 +0800
Message-ID: <890b1575-abab-4b3c-8953-110e1dd3f9ed@huawei.com>
Date: Wed, 27 Aug 2025 19:37:38 +0800
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
References: <20250827024244.58979-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250827024244.58979-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Hi SJ,

在 2025/8/27 10:42, SeongJae Park 写道:
> On Wed, 27 Aug 2025 10:21:41 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> 在 2025/8/26 22:21, SeongJae Park 写道:
>>> On Tue, 26 Aug 2025 12:51:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>>>
>>>> Hi SJ,
>>>>
>>>> 在 2025/8/26 11:21, SeongJae Park 写道:
>>>>> [...]
>>>>>
>>>>>>> ==== Attachment 0 (0001-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_pageo.patch) ====
>>>>>>>     From hackermail Thu Jan  1 00:00:00 1970
>>>>>>> From: SeongJae Park <sj@kernel.org>
>>>>>>> To: Andrew Morton <akpm@linux-foundation.org>
>>>>>>> Cc: SeongJae Park <sj@kernel.org>
>>>>>>> Cc: damon@lists.linux.dev
>>>>>>> Cc: kernel-team@meta.com
>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>> Cc: linux-mm@kvack.org
>>>>>>> Date: Mon, 25 Aug 2025 07:41:33 -0700
>>>>>>> Subject: [PATCH 1/3] mm/damon/paddr: use do_div() on i386 for damon_pa_pageout()
>>>>>>>              return value
>>>>>>>
>>>>>>> Otherwise, __udidi3 linking problem happens on certain configs.
>>>>>>>
>>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/
>>>>>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>>>>>> ---
>>>>>>>      mm/damon/paddr.c | 14 +++++++++++++-
>>>>>>>      1 file changed, 13 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>>>>>>> index 5fad2f9a99a0..09c87583af6c 100644
>>>>>>> --- a/mm/damon/paddr.c
>>>>>>> +++ b/mm/damon/paddr.c
>>>>>>> @@ -135,6 +135,18 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
>>>>>>>      	return false;
>>>>>>>      }
>>>>>>>      
>>>>>>> +/* convert physical address to core-layer address */
>>>>>>> +static unsigned long damon_pa_core_addr(phys_addr_t pa,
>>>>>>> +		unsigned long addr_unit)
>>>>>>> +{
>>>>>>> +#ifdef __i386__
>>>>>> Can we use the following condition instead?
>>>>>>
>>>>>> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
>>>>> To my understanding, this issue happens only on i386, not every 32bit
>>>>> architectures.  So I think i386 specific condition is better.
>>>> I understand. However, the aforementioned general condition is essential,
>>>> and we should propose a new patch to address this. After introducing addr_unit,
>>>> any 32-bit architecture should support monitoring of 64-bit phys_addr_t.
>>> The issue is that we cannot divide 64bit values with plain '/' operator on
>>> "i386", and hence this patch makes it to use do_div() instead of '/' on "i386".
>>> No such or other problems at supporting 64-bit phys_addr_t is found on other
>>> 32bit architectures, to my understanding.  My understanding is that at least
>>> you confirmed that on your arm-based test environment.  So we don't need a new
>>> patch to my understanding.
>>>
>>> Am I missing somthing?
>> This is because I seem to have made a mistake earlier: I adjusted the local
>> compilation toolchain. When the __udivdi3 issue mentioned above occurred, it
>> reminded me of a potential problem. After switching to a completely new environment
>> for testing, I discovered the __aeabi_uldivmod linking error in arm, which is similar
>> to the __udivdi3 issue.🙁
> Thank you for sharing this.  Then I agree the current fixup is insufficient.
>
> Andrew, could you please drop this patch series from mm tree for now?  I will
> further discuss with Quanmin about the proper fix and post next version of this
> series with the proper fixup.
>
>> To prevent similar environment-related problems in the
>> future, I suggest adjusting the condition to the following:
>>
>> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)
>>
>> Please consider approving this fix.
> I'm yet in travel, and I'd like to take more time on thinking about the proper
> fix.  Quanmin, could you share more details about your test setups, both for
> the compiling success case and failing case?

Apologies for disturbing you during your travels. Please allow me to explain:

When CONFIG_PHYS_ADDR_T_64BIT is enabled on "i386" [1], the phys_addr_t type
becomes 64-bit, requiring the use of the do_div function. We are in agreement
on this point.

On arm32, if LPAE (which we intend to support in this series) is enabled,
CONFIG_PHYS_ADDR_T_64BIT will also be enabled. In this case, pa / addr_unit
will involve 64-bit division and similarly require the do_div function.
Obviously, such link errors should normally occur under these circumstances.
Unfortunately, the expected anomalies did not manifest in my previous tests.
This may be related to some incorrect adjustments I had made to my local build
environment quite some time ago — though I cannot be entirely certain. That
said, I have since cleaned up the old configurations and ensured the current
environment is clean and normal. For now, we have confirmed the actual problem
and its root cause, shall we focus on fixing it?

In summary, after introducing addr_unit, we expect that any 32-bit architecture
should support monitoring of 64-bit phys_addr_t. Therefore, we can consider the
following adjustment:

#if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)

Or at least adjust it to:

#if defined(__i386__) || (defined(__arm__) && defined(CONFIG_PHYS_ADDR_T_64BIT))

I have thoroughly re-validated the feature functionality today and confirmed the
correctness of the aforementioned modifications. Therefore, could I kindly ask
you to consider the aforementioned modifications when you have some free time?

[1]https://download.01.org/0day-ci/archive/20250824/202508241831.EKwdwXZL-lkp@intel.com/config

Thanks,
Quanmin Yan

[...]


