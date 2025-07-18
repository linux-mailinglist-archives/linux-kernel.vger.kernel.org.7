Return-Path: <linux-kernel+bounces-736131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968FAB0993B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C1C561C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211CF14A0BC;
	Fri, 18 Jul 2025 01:37:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C159137E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802674; cv=none; b=goaGlq8ujla8fkQTAUqlDKdF8YOZMBs4I3RW15VMv/lq50g237DEPJtwrUrnspLxZdFhHT4E5U2y73PHyMfPMkCVX8+pQ54E2uspIoGvuPslZjbDggnw6ZjunHvQV5OUbeAJaPgngIlXYt8RqE3dDxLmr4z41VL5z38QuGt1BY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802674; c=relaxed/simple;
	bh=HjXSsauJZqFLcl7USIHO95W9ZqmoOlf/nTrHHv1ZGFg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z2/RfKVeVZxLhF2gLRrsUqxuEy2W1QeYlK3msk3bp5kFzURlOzkyMQ7RXcSflG8WdnIO0O6cez9L3L20w9sxOPRY2/yL9wE+z7Dfdu5rb9Q6ihUDClKCSi2AyJ7QrZd/pk6MgwfUwmeX6Fx2EDG0+xcUCaYQtAXUA7v1PTcbsgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bjspN3JfqztSbx;
	Fri, 18 Jul 2025 09:36:44 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A62C180486;
	Fri, 18 Jul 2025 09:37:49 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 09:37:48 +0800
Message-ID: <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
Date: Fri, 18 Jul 2025 09:37:48 +0800
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
 <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <aHj8mfecDhJJZW1Y@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/7/17 21:37, Mike Rapoport wrote:
> On Thu, Jul 17, 2025 at 07:06:52PM +0800, mawupeng wrote:
>>
>> On 2025/7/17 18:29, Mike Rapoport wrote:
>>> On Thu, Jul 17, 2025 at 04:57:23PM +0800, Wupeng Ma wrote:
>>>> When memory mirroring is enabled, the BIOS may reserve memory regions
>>>> at the start of the physical address space without the MR flag. This will
>>>> lead to zone_movable_pfn to be updated to the start of these reserved
>>>> regions, resulting in subsequent mirrored memory being ignored.
>>>>
>>>> Here is the log with efi=debug enabled:
>>>>   efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>>>>   efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|...|WB|WT|WC|  ]
>>>>   efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>>>>   efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |...|WB|WT|WC|  ]
>>>> ...
>>>>   efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |...|WB|WT|WC|  ]
>>>>
>>>> Since this kind of memory can not be used by kernel. ignore nomap memory to fix
>>>> this issue.
>>
>> Since the first non-mirror pfn of this node is 0x084000000000, then zone_movable_pfn 
>> for this node will be updated to this. This will lead to Mirror Region 
>>   - 0x084004000000-0x0842bf37ffff
>>   - 0x0842bf380000-0x0842c21effff 
>>   - 0x0842c21f0000-0x0847ffffffff
>> be seen as non-mirror memory since zone_movable_pfn will be the start_pfn of this node
>> in adjust_zone_range_for_zone_movable().
> 
> What do you mean by "seen as non-mirror memory"?

It mean these memory range will be add to movable zone.

> 
> What is the problem with having movable zone on that node start at
> 0x084000000000?
> 
> Can you post the kernel log up to "Memory: nK/mK available" line for more
> context?

Memory: nK/mK available can not see be problem here, since there is nothing wrong
with the total memory. However this problem can be shown via lsmem --output-all

w/o this patch
[root@localhost ~]# lsmem --output-all
RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable

w/ this patch
[root@localhost ~]# lsmem --output-all
RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable


As shown above, All memory in this node is added to Zone Movable even some range of the memory
is mirror memory. With this patch, 0x0000084000000000-0x00000847ffffffff will be added to
zone normal as expected since the MR attribute.


>  
>> So igore nomap memory to fix this problem.
>>
>>>
>>> If the memory is nomap it won't be used by the kernel anyway.
>>> What's the actual issue you are trying to fix?
>>>  
>>>> Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
>>>> ---
>>>>  mm/mm_init.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>> index f2944748f526..1c36518f0fe4 100644
>>>> --- a/mm/mm_init.c
>>>> +++ b/mm/mm_init.c
>>>> @@ -405,7 +405,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>>>>  		}
>>>>  
>>>>  		for_each_mem_region(r) {
>>>> -			if (memblock_is_mirror(r))
>>>> +			if (memblock_is_mirror(r) || memblock_is_nomap(r))
>>>>  				continue;
>>>>  
>>>>  			nid = memblock_get_region_node(r);
>>>> -- 
>>>> 2.43.0
>>>>
>>>
>>
> 


