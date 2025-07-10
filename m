Return-Path: <linux-kernel+bounces-725541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B08B0007D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733655A3A87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97272D6406;
	Thu, 10 Jul 2025 11:24:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2529ACEE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146647; cv=none; b=eNTKbEbrZkZkVkSphwTQ5muopl7/Em8j34Ctw0eiedAymJNHmjkpwAUig0lYnG2XwwgXG/geW44uJHChBxK92rhyG3Rl0aXSvVZ5isw9uHv9yCyTj1f67tk2jYVmhJSO4wNsRQ+v5KqH9DqYPTUPvwRv8FZkalgP4WAU68uZtV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146647; c=relaxed/simple;
	bh=3lddK2NashgZvLHKo08Q6rYmJQsChH9qlGTiXQcPl54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlozC7qaeW4K0GKAUggc7+jRGMRE5PP6pXEogc8Xj2WJBA+emn0t4WqyjPRJznCHhTsOSk3qvis8dj+Lp7+uzs4nFC8h6PxGgkRG0HTcSlUaiyXdxwkJaVhVo8iKpopQppQI231OSV8bEnfqLGNqQAZJ55sZhHogyAD7DSNsmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC1C21EA6;
	Thu, 10 Jul 2025 04:23:53 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F5473F66E;
	Thu, 10 Jul 2025 04:24:03 -0700 (PDT)
Message-ID: <9a1ae272-3128-425b-828d-50b2289a6cb8@arm.com>
Date: Thu, 10 Jul 2025 12:24:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cacheinfo: Set cache 'id' based on DT data
To: James Morse <james.morse@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, sudeep.holla@arm.com,
 Rob Herring <robh@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 WillDeaconwill@kernel.org
References: <20250704173826.13025-1-james.morse@arm.com>
 <20250704173826.13025-2-james.morse@arm.com>
 <9495df36-053e-49a3-8046-1e6aed63b4af@arm.com>
 <20250707133207.00001b88@huawei.com>
 <89c6f2a2-e084-4899-a6d6-819917eb6324@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <89c6f2a2-e084-4899-a6d6-819917eb6324@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James and Jonathan,

On 7/10/25 12:15, James Morse wrote:
> Hi Ben, Jonathan,
> 
> On 07/07/2025 13:32, Jonathan Cameron wrote:
>> On Mon, 7 Jul 2025 11:27:06 +0100
>> Ben Horgan <ben.horgan@arm.com> wrote:
>>> On 7/4/25 18:38, James Morse wrote:
>>>> From: Rob Herring <robh@kernel.org>
>>>> Use the minimum CPU h/w id of the CPUs associated with the cache for the
>>>> cache 'id'. This will provide a stable id value for a given system. As
>>>> we need to check all possible CPUs, we can't use the shared_cpu_map
>>>> which is just online CPUs. As there's not a cache to CPUs mapping in DT,
>>>> we have to walk all CPU nodes and then walk cache levels.
>>>>
>>>> The cache_id exposed to user-space has historically been 32 bits, and
>>>> is too late to change. This value is parsed into a u32 by user-space
>>>> libraries such as libvirt:
>>>> https://github.com/libvirt/libvirt/blob/master/src/util/virresctrl.c#L1588
>>>>
>>>> Give up on assigning cache-id's if a CPU h/w id greater than 32 bits
>>>> is found.
> 
>>>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>>>> index cf0d455209d7..df593da0d5f7 100644
>>>> --- a/drivers/base/cacheinfo.c
>>>> +++ b/drivers/base/cacheinfo.c
>>>> @@ -183,6 +184,42 @@ static bool cache_node_is_unified(struct cacheinfo *this_leaf,
>>>>    	return of_property_read_bool(np, "cache-unified");
>>>>    }
>>>>    
>>>> +static bool match_cache_node(struct device_node *cpu,
>>>> +			     const struct device_node *cache_node)
>>>> +{
>>>> +	for (struct device_node *cache __free(device_node) = of_find_next_cache_node(cpu);
>>> Looks like the creation of this helper function has upset the
>>> device_node reference counting. This first __free(device_node) will only
>>> cause of_node_put() to be called in the case of the early return from
>>> the loop. You've dropped the second __free(device_node) which accounts
>>> for 'cache' changing on each iteration.
> 
> Heh, I just took this hunk verbatim. Fixing this up with the __free() magic is tricky as
> the existing patterns all drop the reference to cpu, which we don't want to do here. I
> think at this point the __free() magic is just making this harder to understand. How about
> the old fashioned way:
> 
> | static bool match_cache_node(struct device_node *cpu,
> |                              const struct device_node *cache_node)
> | {
> |         struct device_node *prev, *cache = of_find_next_cache_node(cpu);
> |
> |         while (cache) {
> |                 if (cache == cache_node) {
> |                         of_node_put(cache);
> |                         return true;
> |                 }
> |
> |                 prev = cache;
> |                 cache = of_find_next_cache_node(cache);
> |                 of_node_put(prev);
> |         }
> |
> |         return false;
> | }
Ok with me.
> 
> 
>> Good catch - this behaves differently from many of the of_get_next* type
>> helpers in that it doesn't drop the reference to the previous iteration
>> within the call.
>>
>> Maybe it should?
>>
>> I checked a few of the call sites and some would be simplified if it did
>> others would need some more complex restructuring but might benefit as
>> well.
> 
> If it did, we'd end up dropping the reference to cpu on the way in, which
> of_get_next_cpu_node() in for_each_of_cpu_node() was expecting to do.

Yes, I think the blurring of the lines between a cpu node and cache node 
is at least partially to blame for the confusion here.
> 
> 
> Thanks,
> 
> James

Thanks,

Ben


