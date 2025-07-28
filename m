Return-Path: <linux-kernel+bounces-747689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFCB136D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0495D188650E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39402220F30;
	Mon, 28 Jul 2025 08:37:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA721CC5B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691872; cv=none; b=u5tCPLOqHbpfDllmjQJWkBmbJ5Dnh08hObHVq2JfLIX93Z8Yz6R8Le5bGR7zmoVxe2FYuuU8znPVWVyv9yOw+5PNLwHI7vTSWpK93qoHryNGWTyVMG5X2YPzFB+eQmVR860lcG8wy9rlGP7LEe82OkdDE7Rw2A4U8IwC9Ebyb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691872; c=relaxed/simple;
	bh=jLahd8ERP63WgTSf7meyqkC0WOm3tKsaAaqAwyju330=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9G7u65wS5VH1BtqOQqsLwhCg7qt4lmrrQd78igRRTxtLxAmpPzETgWW4sKvuFA0pEQXHGMCS18ledAx1lcYpot1pjdVDBbcwN5BR1qc1wqBeLhRpqlBrWVkMhCRuDQZywcAYW4ugyBzw9yuRjmGTBiiYSddXcS4hqnxZ8RpKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ECAC1596;
	Mon, 28 Jul 2025 01:37:42 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26F6A3F673;
	Mon, 28 Jul 2025 01:37:46 -0700 (PDT)
Message-ID: <f14db9e0-95c8-4389-9a27-69f0ba9b5329@arm.com>
Date: Mon, 28 Jul 2025 09:37:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/36] cacheinfo: Expose the code to generate a
 cache-id from a device_node
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-5-james.morse@arm.com>
 <bfc4d1b5-c8c4-45de-b52a-833486368336@arm.com>
 <ccbf2f40-7e69-4b51-953f-113695b8c16e@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <ccbf2f40-7e69-4b51-953f-113695b8c16e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 7/25/25 18:08, James Morse wrote:
> Hi Ben,
> 
> On 14/07/2025 12:40, Ben Horgan wrote:
>> On 7/11/25 19:36, James Morse wrote:
>>> The MPAM driver identifies caches by id for use with resctrl. It
>>> needs to know the cache-id when probe-ing, but the value isn't set
>>> in cacheinfo until device_initcall().
>>>
>>> Expose the code that generates the cache-id. The parts of the MPAM
>>> driver that run early can use this to set up the resctrl structures
>>> before cacheinfo is ready in device_initcall().
> 
>>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>>> index 613410705a47..0fdd6358ee73 100644
>>> --- a/drivers/base/cacheinfo.c
>>> +++ b/drivers/base/cacheinfo.c
>>> @@ -207,8 +207,7 @@ static bool match_cache_node(struct device_node *cpu,
>>>    #define arch_compact_of_hwid(_x)    (_x)
>>>    #endif
>>>    -static void cache_of_set_id(struct cacheinfo *this_leaf,
>>> -                struct device_node *cache_node)
>>> +unsigned long cache_of_calculate_id(struct device_node *cache_node)
>>>    {
>>>        struct device_node *cpu;
>>>        u32 min_id = ~0;
>>> @@ -219,15 +218,23 @@ static void cache_of_set_id(struct cacheinfo *this_leaf,
>>>            id = arch_compact_of_hwid(id);
>>>            if (FIELD_GET(GENMASK_ULL(63, 32), id)) {
>>>                of_node_put(cpu);
>>> -            return;
>>> +            return ~0UL;
>>>            }
>>>              if (match_cache_node(cpu, cache_node))
>>>                min_id = min(min_id, id);
>>>        }
>>>    -    if (min_id != ~0) {
>>> -        this_leaf->id = min_id;
>>> +    return min_id;
> 
>> Looks like some 32bit/64bit confusion. Don't we want to return ~0UL if min_id == ~0?
> 
> Certainly some confusion - yup, because cache_of_calculate_id() needs to return something
> that is out of range and (u32)-1 might be valid...
> 
> I think changing min_id to be defined as:
> |	unsigned long min_id = ~0UL;
> 
> fixes this - any trip round the loop that doesn't match anything will eventually return ~0UL.
Yes, that would work.

> 
> 
> Thanks! - I always get the 'UL' suffixes wrong.
> 
> James

Thanks,

Ben


