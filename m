Return-Path: <linux-kernel+bounces-741742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83064B0E870
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6983AF9DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79909197A76;
	Wed, 23 Jul 2025 02:02:29 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C51CD15
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753236148; cv=none; b=Eplj87yPZwly29+o1nF09KITKqasQ2nuRxrhJ8uAPJ9m84sHvrWsLUSaE08i3s7Za7hv0+whifbvQT5BlNLIF4yK3E+CuQwnCLrKohB9CgyIhGnhZOUauFBmhHwjilg0v0YvShxiqkyGkUmtNqy4EsswmOnF6cbpaoSkANwXUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753236148; c=relaxed/simple;
	bh=bIF0Zgu+qxHRJ4xD5URl++aOpyxYOKOmrjUsTEaQcKk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=f5C1R6EgPlmJo43P0WEfpNtVZvv/YGRWf7jSi1fBT3xKQk0CaOZb1g2IXF8WEM6YBsQ2mwiuxTo0onjcg08j1LGCyG9XV5Zc7hlXI4fio7XPy7jeBK/xj8IZnxVgsNlAdblTN8xFJpTq7aY68LLWEDdKnb16Pro3CFnq9k0NzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bmy8p0YMDz16TKP;
	Wed, 23 Jul 2025 10:03:22 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id DC5DD140257;
	Wed, 23 Jul 2025 10:02:21 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 10:02:21 +0800
Message-ID: <d197fe6c-9541-444f-91b9-15653ea70644@huawei.com>
Date: Wed, 23 Jul 2025 10:02:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: mawupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
To: <rppt@kernel.org>
CC: <mawupeng1@huawei.com>, <akpm@linux-foundation.org>, <ardb@kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org>
 <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org>
 <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org>
 <205873c9-b8cd-4aa7-822e-3c1d6a5a5ea7@huawei.com>
 <aH9KfV8XM5fNsR/Y@kernel.org>
In-Reply-To: <aH9KfV8XM5fNsR/Y@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/7/22 16:23, Mike Rapoport wrote:
> On Mon, Jul 21, 2025 at 10:11:11AM +0800, mawupeng wrote:
>> On 2025/7/20 20:38, Mike Rapoport wrote:
>>> On Fri, Jul 18, 2025 at 09:37:48AM +0800, mawupeng wrote:
>>>>
>>>>
>>>> On 2025/7/17 21:37, Mike Rapoport wrote:
>>>>> On Thu, Jul 17, 2025 at 07:06:52PM +0800, mawupeng wrote:
>>>>>>
>>>>>> On 2025/7/17 18:29, Mike Rapoport wrote:
>>>>>>> On Thu, Jul 17, 2025 at 04:57:23PM +0800, Wupeng Ma wrote:
>>>>>>>> When memory mirroring is enabled, the BIOS may reserve memory regions
>>>>>>>> at the start of the physical address space without the MR flag. This will
>>>>>>>> lead to zone_movable_pfn to be updated to the start of these reserved
>>>>>>>> regions, resulting in subsequent mirrored memory being ignored.
>>>>>>>>
>>>>>>>> Here is the log with efi=debug enabled:
>>>>>>>>   efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>>>>>>>>   efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|...|WB|WT|WC|  ]
>>>>>>>>   efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>>>>>>>>   efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |...|WB|WT|WC|  ]
>>>>>>>> ...
>>>>>>>>   efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |...|WB|WT|WC|  ]
>>>>>>>>
>>>>>>>> Since this kind of memory can not be used by kernel. ignore nomap memory to fix
>>>>>>>> this issue.
>>>>>>
>>>>>> Since the first non-mirror pfn of this node is 0x084000000000, then zone_movable_pfn 
>>>>>> for this node will be updated to this. This will lead to Mirror Region 
>>>>>>   - 0x084004000000-0x0842bf37ffff
>>>>>>   - 0x0842bf380000-0x0842c21effff 
>>>>>>   - 0x0842c21f0000-0x0847ffffffff
>>>>>> be seen as non-mirror memory since zone_movable_pfn will be the start_pfn of this node
>>>>>> in adjust_zone_range_for_zone_movable().
>>>>>
>>>>> What do you mean by "seen as non-mirror memory"?
>>>>
>>>> It mean these memory range will be add to movable zone.
>>>>
>>>>>
>>>>> What is the problem with having movable zone on that node start at
>>>>> 0x084000000000?
>>>>>
>>>>> Can you post the kernel log up to "Memory: nK/mK available" line for more
>>>>> context?
>>>>
>>>> Memory: nK/mK available can not see be problem here, since there is nothing wrong
>>>> with the total memory. However this problem can be shown via lsmem --output-all
>>>
>>> I didn't ask for that particular line but for *up to that line*.
>>>  
>>>> w/o this patch
>>>> [root@localhost ~]# lsmem --output-all
>>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
>>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
>>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
>>>>
>>>> w/ this patch
>>>> [root@localhost ~]# lsmem --output-all
>>>> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
>>>> 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
>>>> 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable
>>>
>>> As I see the problem, you have a problematic firmware that fails to report
>>> memory as mirrored because it reserved for firmware own use. This causes
>>> for non-mirrored memory to appear before mirrored memory. And this breaks
>>> an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
>>> always has lower addresses than non-mirrored memory and you end up wiht
>>> having all the memory in movable zone.
>>
>> Yes.
>>
>>>
>>> So to workaround this firmware issue you propose a hack that would skip
>>> NOMAP regions while calculating zone_movable_pfn because your particular
>>> firmware reports the reserved mirrored memory as NOMAP.
>>>
>>> Why don't you simply pass "kernelcore=32G" on the command line and you'll
>>> get the same result.
>>
>> Since mirrored memory are in each node, not only one, "kernelcore=32G" can
>> not fix this problem.
> 
> I don't see other nodes in lsmem output. And I asked for the kernel log
> exactly to see how kernel sees the memory on the system.

Sorry for my mistake.

[    0.000000] efi: Processing EFI memory map:
[    0.000000] efi:   0x00005fff0000-0x00005fffefff [Conventional|   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x00005ffff000-0x00005fffffff [Boot Data   |   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x000060000000-0x00007fffffff [Conventional|   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x082080000000-0x08247fffffff [Conventional|   |  |MR|  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x082880000000-0x083fffffffff [Conventional|   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x282000000000-0x2820ffffffff [Conventional|   |  |MR|  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x282200000000-0x283f9bffffff [Conventional|   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x283f9c000000-0x283fffffffff [Loader Code |   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x284000000000-0x2841ffffffff [Conventional|   |  |MR|  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x284400000000-0x285fffffffff [Conventional|   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x000000000000-0x000003ffffff [Reserved    |   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x000004000000-0x000007dfffff [Reserved    |   |  |  |  |  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x000007e00000-0x000007efffff [Reserved    |   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x000007f00000-0x000007f5ffff [Reserved    |   |  |  |  |  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x000008000000-0x00000bffffff [Reserved    |   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x00000c200000-0x00000fffffff [Reserved    |   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x00001c000000-0x00001fffffff [Reserved    |   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi:   0x0004002c0000-0x0004002cffff [MMIO        |RUN|  |  |  |  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x008410000000-0x008410000fff [MMIO        |RUN|  |  |  |  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x00c580030000-0x00c580030fff [MMIO        |RUN|  |  |  |  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |  |  |  |  |  |  |  |   |WB|WT|WC|  ]
[    0.000000] efi: Memory: 61376M/462861M mirrored memory
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x82080000000-0x83fffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x84000000000-0x85fffffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x00000000-0x7fffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x282000000000-0x283fffffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x284000000000-0x285fffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x847ffff0b00-0x847ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x8247fff0b00-0x8247fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x2841fffc9b00-0x2841fffd8fff]
[    0.000000] NUMA: NODE_DATA [mem 0x2820ffff0b00-0x2820ffffffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000285fffffffff]
[    0.000000]   ExtMem   empty
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000]   Node 0: 0x0000084000000000
[    0.000000]   Node 1: 0x0000082880000000
[    0.000000]   Node 2: 0x0000284400000000
[    0.000000]   Node 3: 0x0000282200000000
[    0.000000] Early memory node ranges
[    0.000000]   node   1: [mem 0x0000000000000000-0x0000000003ffffff]
[    0.000000]   node   1: [mem 0x0000000007e00000-0x0000000007efffff]
[    0.000000]   node   1: [mem 0x0000000008000000-0x000000000bffffff]
[    0.000000]   node   1: [mem 0x000000000c200000-0x000000000fffffff]
[    0.000000]   node   1: [mem 0x0000000011000000-0x000000001bffffff]
[    0.000000]   node   1: [mem 0x000000001c000000-0x000000001fffffff]
[    0.000000]   node   1: [mem 0x0000000020000000-0x000000005e26ffff]
[    0.000000]   node   1: [mem 0x000000005e270000-0x000000005fbeffff]
[    0.000000]   node   1: [mem 0x000000005fbf0000-0x000000007fffffff]
[    0.000000]   node   1: [mem 0x0000082080000000-0x000008247fffffff]
[    0.000000]   node   1: [mem 0x0000082880000000-0x0000083fffffffff]
[    0.000000]   node   0: [mem 0x0000084000000000-0x0000084003ffffff]
[    0.000000]   node   0: [mem 0x0000084004000000-0x00000847ffffffff]
[    0.000000]   node   0: [mem 0x0000085000000000-0x0000085fffffffff]
[    0.000000]   node   3: [mem 0x0000282000000000-0x00002820ffffffff]
[    0.000000]   node   3: [mem 0x0000282200000000-0x0000283fffffffff]
[    0.000000]   node   2: [mem 0x0000284000000000-0x00002841ffffffff]
[    0.000000]   node   2: [mem 0x0000284400000000-0x0000285fffffffff]
[    0.000000] mminit::pageflags_layout_widths Section 0 Node 8 Zone 3 Lastcpupid 20 Kasantag 0 Gen 3 Tier 2 Flags 26
[    0.000000] mminit::pageflags_layout_shifts Section 21 Node 8 Zone 3 Lastcpupid 20 Kasantag 0
[    0.000000] mminit::pageflags_layout_pgshifts Section 0 Node 56 Zone 53 Lastcpupid 33 Kasantag 0
[    0.000000] mminit::pageflags_layout_nodezoneid Node/Zone ID: 64 -> 53
[    0.000000] mminit::pageflags_layout_usage location: 64 -> 28 layout 28 -> 26 unused 26 -> 0 page-flags
[    0.000000] Initmem setup node 0 [mem 0x0000084000000000-0x0000085fffffffff]
[    0.000000] mminit::memmap_init Initialising map node 0 zone 4 pfns 2214592512 -> 2248146944
[    0.000000] Initmem setup node 1 [mem 0x0000000000000000-0x0000083fffffffff]
[    0.000000] mminit::memmap_init Initialising map node 1 zone 0 pfns 0 -> 1048576
[    0.000000] mminit::memmap_init Initialising map node 1 zone 2 pfns 1048576 -> 2214592512
[    0.000000] mminit::memmap_init Initialising map node 1 zone 4 pfns 2189950976 -> 2214592512
[    0.000000] Initmem setup node 2 [mem 0x0000284000000000-0x0000285fffffffff]
[    0.000000] mminit::memmap_init Initialising map node 2 zone 2 pfns 10804527104 -> 10838081536
[    0.000000] mminit::memmap_init Initialising map node 2 zone 4 pfns 10808721408 -> 10838081536
[    0.000000] Initmem setup node 3 [mem 0x0000282000000000-0x0000283fffffffff]
[    0.000000] zone_type: 0, zone_low: 0x0, zone_high: 0x100000
[    0.000000] mminit::memmap_init Initialising map node 3 zone 2 pfns 10770972672 -> 10804527104
[    0.000000] mminit::memmap_init Initialising map node 3 zone 4 pfns 10773069824 -> 10804527104
[    0.000000] On node 1, zone DMA: 15872 pages in unavailable ranges
[    0.000000] On node 1, zone DMA: 256 pages in unavailable ranges
[    0.000000] On node 1, zone DMA: 512 pages in unavailable ranges
[    0.000000] On node 1, zone DMA: 4096 pages in unavailable ranges
[    0.000000] Fallback order for Node 0: 0 1 2 3 
[    0.000000] Fallback order for Node 1: 1 0 2 3 
[    0.000000] Fallback order for Node 2: 2 3 0 1 
[    0.000000] Fallback order for Node 3: 3 2 0 1 
[    0.000000] mminit::zonelist general 0:Movable = 0:Movable 1:Movable 1:Normal 1:DMA 2:Movable 2:Normal 3:Movable 3:Normal 
[    0.000000] mminit::zonelist thisnode 0:Movable = 0:Movable 
[    0.000000] mminit::zonelist general 1:DMA = 1:DMA 
[    0.000000] mminit::zonelist general 1:Normal = 1:Normal 1:DMA 2:Normal 3:Normal 
[    0.000000] mminit::zonelist general 1:Movable = 1:Movable 1:Normal 1:DMA 0:Movable 2:Movable 2:Normal 3:Movable 3:Normal 
[    0.000000] mminit::zonelist thisnode 1:DMA = 1:DMA 
[    0.000000] mminit::zonelist thisnode 1:Normal = 1:Normal 1:DMA 
[    0.000000] mminit::zonelist thisnode 1:Movable = 1:Movable 1:Normal 1:DMA 
[    0.000000] mminit::zonelist general 2:Normal = 2:Normal 3:Normal 1:Normal 1:DMA 
[    0.000000] mminit::zonelist general 2:Movable = 2:Movable 2:Normal 3:Movable 3:Normal 0:Movable 1:Movable 1:Normal 1:DMA 
[    0.000000] mminit::zonelist thisnode 2:Normal = 2:Normal 
[    0.000000] mminit::zonelist thisnode 2:Movable = 2:Movable 2:Normal 
[    0.000000] mminit::zonelist general 3:Normal = 3:Normal 2:Normal 1:Normal 1:DMA 
[    0.000000] mminit::zonelist general 3:Movable = 3:Movable 3:Normal 2:Movable 2:Normal 0:Movable 1:Movable 1:Normal 1:DMA 
[    0.000000] mminit::zonelist thisnode 3:Normal = 3:Normal 
[    0.000000] mminit::zonelist thisnode 3:Movable = 3:Movable 3:Normal 
[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 108375876
[    0.000000] Policy zone: Normal
[    0.000000] Memory: 464660912K/440384512K available (14848K kernel code, 5388K rwdata, 10340K rodata, 5696K init, 10981K bss, 18446744073685275216K reserved, 0K cma-reserved)

>  
> Another question is do you really need ZONE_MOVABLE? Most of the time MM
> core operates on the pageblock granularity and even if all the memory are
> in ZONE_NORMAL the pageblocks are still movable.

With feature kenrelcore=mirror, movable zone is needed to limit kernel memory usage.
The kernel and drivers default to allocating memory from mirrored memory, enhancing
reliability during Uncorrectable Errors (UE).

> 


