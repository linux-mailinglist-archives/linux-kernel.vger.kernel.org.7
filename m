Return-Path: <linux-kernel+bounces-756134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A6B1B067
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6A63A46B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7012580CC;
	Tue,  5 Aug 2025 08:47:38 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61E1991CA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383657; cv=none; b=UX8DtMGJkYRI0JpKW7rlgo6PWfGr71Bpp8ye5p7hB2LCknk5k9TtQ37i8g+kNN7ibSgJWGcWKnceMRyCgGZlbWEMF9NScDEJ8qDVdqJnkCxDnF/nY1l/AUMHg2Qy/jAApxXO6RujYVqvN0iMDIlIv3+dR9XzBO3rl5CBElFr+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383657; c=relaxed/simple;
	bh=t5sUobVv3IAUQGKZ7IuQx7dyska2s1kbZf8JKHo+D0M=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R62sSL8IoqiD+jogCqzPEMvAY4M/hqBCp+FG4Y6Ooq9cu4vKdJTjA3U6hJgc+FNHkeHkmToDzjoLgy44ouQQnJZEpNlcPFH8inhn9TTGXvprfemb5LJUtemK4Hel6x16anR/3Tk5M6Xd8TqHdLbNc3Wsnl2Dwan9waPDiq2f5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bx6QD1Xj8z2Cg3h;
	Tue,  5 Aug 2025 16:43:16 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 33DC5140143;
	Tue,  5 Aug 2025 16:47:32 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 16:47:31 +0800
Message-ID: <113b914f-1597-41ca-b714-7ea048c3c6df@huawei.com>
Date: Tue, 5 Aug 2025 16:47:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
To: <rppt@kernel.org>, <ardb@kernel.org>
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org>
 <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org>
 <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org>
 <CAMj1kXGKGXeKGKWT3VzkBtACtjFyz8ntiyoTU26DA4aR6mi88g@mail.gmail.com>
 <aH9JMT93itrztZ+m@kernel.org>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <aH9JMT93itrztZ+m@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/7/22 16:17, Mike Rapoport wrote:
> Hi Ard,
> 
> On Mon, Jul 21, 2025 at 03:08:48PM +1000, Ard Biesheuvel wrote:
>> On Sun, 20 Jul 2025 at 22:38, Mike Rapoport <rppt@kernel.org> wrote:
>>>
>> ...
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
>>>
>>
>> That assumption seems highly problematic to me on non-x86
>> architectures: why should mirrored (or 'more reliable' in EFI speak)
>> memory always appear before ordinary memory in the physical memory
>> map?
> 
> It's not really x86, although historically it probably comes from there.
> ZONE_NORMAL is always before ZONE_MOVABLE, so in order to have ZONE_NORMAL
> with mirrored (more reliable) memory, the mirrored memory should be before
> non-mirrored.
>  
>>> So to workaround this firmware issue you propose a hack that would skip
>>> NOMAP regions while calculating zone_movable_pfn because your particular
>>> firmware reports the reserved mirrored memory as NOMAP.
>>>
>>
>> NOMAP is a Linux construct - the particular firmware reports a
>> 'reserved' memory region, but other more widely used memory types such
>> as EfiRuntimeServicesCode or *Data would result in an omitted region
>> as well, and can appear anywhere in the physical memory map. There is
>> no requirement for the firmware to do anything here wrt the
>> MORE_RELIABLE attribute even though such regions may be carved out of
>> a block of memory that is reported as such to the OS.
>>
>> So I agree with Wupeng Ma that there is an issue here: reporting it as
>> mirrored even though it is reserved should not be needed to prevent
>> the kernel from mishandling it.
> 
> But a check for NOMAP won't actually fix it in the general case, especially
> if it can appear anywhere in the physical memory map. E.g. if there's an MR
> region followed by two reserved regions and one of these regions is not
> NOMAP and then MR region again, ZONE_NORMAL will only include the first MR
> region.

What kind of memory is reserved and is not nomap.

> 
> We may want to consider scanning the entire memblock.memory to find all
> mirrored regions in a and than make a decision where to cut ZONE_NORMAL
> based on that.

AFICT, mirrored memory should always locate at the top of numa memory
region due the linux's zone management. there maybe no good decision
based on memblock.memory rather that use the the first non-mirror
usable memory pfn to cut.

> 


