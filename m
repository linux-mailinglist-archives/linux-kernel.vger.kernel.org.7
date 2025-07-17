Return-Path: <linux-kernel+bounces-735152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87ECB08B85
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D484A590C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F7D22D7B0;
	Thu, 17 Jul 2025 11:06:58 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6C1BD01D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752750418; cv=none; b=u8FUscyzIbVv9gFtiimLKnIEVp+1CjaZVlyp4U0hnX77OJVr8uXjFGwMMX8F/hleIuXeMoWFBGk25vmJhVft16ywiSrJcWQXy3v3KHz5BmONGjQjT9qdwUZsWyBmUJHCbxlc4cnwwDZtI28wEsf4D+m4iqBCRh/lzuLhxQI+5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752750418; c=relaxed/simple;
	bh=5ZuIdNq66XW5+6DgewpR7mWk0Mzg3Fi1u6aYppAUYM8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UEazeF+m764V2b1N6DQAxAyXXBn71STVXJ5/H6/0ILqcxGy9MGfGtQvkl0AC4oNOJIVeALG14O7ps78mWyW0kH2t+vMUBcluJgVhAmhzS8mQ64W+vROHNLiJbK4axw3pd51RQSd3Cgsi+WqVID7S+hNLaTOLOn/HMjgKLOdk/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bjVSH66N6z2FbPX;
	Thu, 17 Jul 2025 19:04:47 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FEBF1A016C;
	Thu, 17 Jul 2025 19:06:53 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 19:06:52 +0800
Message-ID: <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
Date: Thu, 17 Jul 2025 19:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <akpm@linux-foundation.org>, <ardb@kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
To: <rppt@kernel.org>
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <aHjQp9zPVPuPyP3B@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/7/17 18:29, Mike Rapoport wrote:
> On Thu, Jul 17, 2025 at 04:57:23PM +0800, Wupeng Ma wrote:
>> When memory mirroring is enabled, the BIOS may reserve memory regions
>> at the start of the physical address space without the MR flag. This will
>> lead to zone_movable_pfn to be updated to the start of these reserved
>> regions, resulting in subsequent mirrored memory being ignored.
>>
>> Here is the log with efi=debug enabled:
>>   efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>>   efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|...|WB|WT|WC|  ]
>>   efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>>   efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |...|WB|WT|WC|  ]
>> ...
>>   efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |...|WB|WT|WC|  ]
>>
>> Since this kind of memory can not be used by kernel. ignore nomap memory to fix
>> this issue.

Since the first non-mirror pfn of this node is 0x084000000000, then zone_movable_pfn 
for this node will be updated to this. This will lead to Mirror Region 
  - 0x084004000000-0x0842bf37ffff
  - 0x0842bf380000-0x0842c21effff 
  - 0x0842c21f0000-0x0847ffffffff
be seen as non-mirror memory since zone_movable_pfn will be the start_pfn of this node
in adjust_zone_range_for_zone_movable().

So igore nomap memory to fix this problem.

> 
> If the memory is nomap it won't be used by the kernel anyway.
> What's the actual issue you are trying to fix?
>  
>> Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
>> ---
>>  mm/mm_init.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index f2944748f526..1c36518f0fe4 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -405,7 +405,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>>  		}
>>  
>>  		for_each_mem_region(r) {
>> -			if (memblock_is_mirror(r))
>> +			if (memblock_is_mirror(r) || memblock_is_nomap(r))
>>  				continue;
>>  
>>  			nid = memblock_get_region_node(r);
>> -- 
>> 2.43.0
>>
> 


