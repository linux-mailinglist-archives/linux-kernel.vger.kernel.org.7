Return-Path: <linux-kernel+bounces-738550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C3B0B9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1971898C47
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D65199920;
	Mon, 21 Jul 2025 02:11:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33D17996
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753063885; cv=none; b=PPan4fK1EHzMW3aODG2I0ekpeYb8Ck1/Hhp+vTBZyvkg9YL86FCnWwRg7dFfFnaam5svVhtdxyLi+rw5gvl62G0x5bT3fK7shhL62nWQBVsrT3X0/2FZPH6gh33r9G3x0sXHbpnORIff9pi01nbtQSVTfAjVVowbNfZNkICzj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753063885; c=relaxed/simple;
	bh=GnZ2TEuNxnkcMofYrl6ElPv83wgLIs45oTobtFsXBPU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K4cb+x1GmwLu4xCutT99Mt6lqgbVgLuy30Ia97P7OUc2HpQnlIJ+dBDw2KOkYJe2eJ1pP8IHL0+/6gtCFv5lnXFZN3cVf2yJT+K8nLefC24F17XI281mBjJdUDaTniLiUa5jIK/XDt/FGEQIqbhZ2M3sLatErB6tizrqbVCAcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4blkMh5hXQz2gKkV;
	Mon, 21 Jul 2025 10:08:32 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EDFB1401F2;
	Mon, 21 Jul 2025 10:11:12 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Jul 2025 10:11:11 +0800
Message-ID: <205873c9-b8cd-4aa7-822e-3c1d6a5a5ea7@huawei.com>
Date: Mon, 21 Jul 2025 10:11:11 +0800
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
 <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <aHzjOxg_oPp06blC@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/7/20 20:38, Mike Rapoport wrote:
> On Fri, Jul 18, 2025 at 09:37:48AM +0800, mawupeng wrote:
>>
>>
>> On 2025/7/17 21:37, Mike Rapoport wrote:
>>> On Thu, Jul 17, 2025 at 07:06:52PM +0800, mawupeng wrote:
>>>>
>>>> On 2025/7/17 18:29, Mike Rapoport wrote:
>>>>> On Thu, Jul 17, 2025 at 04:57:23PM +0800, Wupeng Ma wrote:
>>>>>> When memory mirroring is enabled, the BIOS may reserve memory regions
>>>>>> at the start of the physical address space without the MR flag. This will
>>>>>> lead to zone_movable_pfn to be updated to the start of these reserved
>>>>>> regions, resulting in subsequent mirrored memory being ignored.
>>>>>>
>>>>>> Here is the log with efi=debug enabled:
>>>>>>   efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>>>>>>   efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|...|WB|WT|WC|  ]
>>>>>>   efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>>>>>>   efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |...|WB|WT|WC|  ]
>>>>>> ...
>>>>>>   efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |...|WB|WT|WC|  ]
>>>>>>
>>>>>> Since this kind of memory can not be used by kernel. ignore nomap memory to fix
>>>>>> this issue.
>>>>
>>>> Since the first non-mirror pfn of this node is 0x084000000000, then zone_movable_pfn 
>>>> for this node will be updated to this. This will lead to Mirror Region 
>>>>   - 0x084004000000-0x0842bf37ffff
>>>>   - 0x0842bf380000-0x0842c21effff 
>>>>   - 0x0842c21f0000-0x0847ffffffff
>>>> be seen as non-mirror memory since zone_movable_pfn will be the start_pfn of this node
>>>> in adjust_zone_range_for_zone_movable().
>>>
>>> What do you mean by "seen as non-mirror memory"?
>>
>> It mean these memory range will be add to movable zone.
>>
>>>
>>> What is the problem with having movable zone on that node start at
>>> 0x084000000000?
>>>
>>> Can you post the kernel log up to "Memory: nK/mK available" line for more
>>> context?
>>
>> Memory: nK/mK available can not see be problem here, since there is nothing wrong
>> with the total memory. However this problem can be shown via lsmem --output-all
> 
> I didn't ask for that particular line but for *up to that line*.
>  
>> w/o this patch
>> [root@localhost ~]# lsmem --output-all
>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
>>
>> w/ this patch
>> [root@localhost ~]# lsmem --output-all
>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable
> 
> As I see the problem, you have a problematic firmware that fails to report
> memory as mirrored because it reserved for firmware own use. This causes
> for non-mirrored memory to appear before mirrored memory. And this breaks
> an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
> always has lower addresses than non-mirrored memory and you end up wiht
> having all the memory in movable zone.

Yes.

> 
> So to workaround this firmware issue you propose a hack that would skip
> NOMAP regions while calculating zone_movable_pfn because your particular
> firmware reports the reserved mirrored memory as NOMAP.
> 
> Why don't you simply pass "kernelcore=32G" on the command line and you'll
> get the same result.

Since mirrored memory are in each node, not only one, "kernelcore=32G" can
not fix this problem.

Since nomap memory can not be used by kernel anyway. AFICT ignore this during
mirror memory init is the right thing to do.

> 
>> As shown above, All memory in this node is added to Zone Movable even some range of the memory
>> is mirror memory. With this patch, 0x0000084000000000-0x00000847ffffffff will be added to
>> zone normal as expected since the MR attribute.
> 


