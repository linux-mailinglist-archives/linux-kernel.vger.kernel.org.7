Return-Path: <linux-kernel+bounces-729913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F2CB03D80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C679E7A2DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B927246797;
	Mon, 14 Jul 2025 11:40:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC8230278
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493217; cv=none; b=Nes+iqJGGlK+ojTiwy3dFYT67ntZfPYFvvbm8C8UGhKksIMR6oVn6RGccT3QJUopIz3DmC811huZhV/suRnKz3n/zcfUntAEyK5kschIRhmIREJHtCzBlH4AJ8Y1MMlzHMs9T2N3SEYfxRsJlTaphO8H1TbnY5lpzg14cVPNGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493217; c=relaxed/simple;
	bh=sgpiVqFhfBlwkMB09h5GPNBzjQ5ubf8tm+IVrkeGXK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ygi5rVvujeOAnfTn9aDsJbmlBDvTBflDgilPkb6zjpuuurKrCLAIiOAok9ouaY9oj+qB+IHs1YH/EicJKsBHJUnYi4FN80NKRmXD2wlxfiMEPwqV7i42E5+v1tcJBp7r4KjPHei0HIDqPbNjkafibk2DYddIBSWSYE4AutK98gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 190571BC0;
	Mon, 14 Jul 2025 04:40:04 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20B393F694;
	Mon, 14 Jul 2025 04:40:10 -0700 (PDT)
Message-ID: <bfc4d1b5-c8c4-45de-b52a-833486368336@arm.com>
Date: Mon, 14 Jul 2025 12:40:08 +0100
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
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250711183648.30766-5-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/11/25 19:36, James Morse wrote:
> The MPAM driver identifies caches by id for use with resctrl. It
> needs to know the cache-id when probe-ing, but the value isn't set
> in cacheinfo until device_initcall().
> 
> Expose the code that generates the cache-id. The parts of the MPAM
> driver that run early can use this to set up the resctrl structures
> before cacheinfo is ready in device_initcall().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Renamed cache_of_get_id() cache_of_calculate_id().
> ---
>   drivers/base/cacheinfo.c  | 17 ++++++++++++-----
>   include/linux/cacheinfo.h |  1 +
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 613410705a47..0fdd6358ee73 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -207,8 +207,7 @@ static bool match_cache_node(struct device_node *cpu,
>   #define arch_compact_of_hwid(_x)	(_x)
>   #endif
>   
> -static void cache_of_set_id(struct cacheinfo *this_leaf,
> -			    struct device_node *cache_node)
> +unsigned long cache_of_calculate_id(struct device_node *cache_node)
>   {
>   	struct device_node *cpu;
>   	u32 min_id = ~0;
> @@ -219,15 +218,23 @@ static void cache_of_set_id(struct cacheinfo *this_leaf,
>   		id = arch_compact_of_hwid(id);
>   		if (FIELD_GET(GENMASK_ULL(63, 32), id)) {
>   			of_node_put(cpu);
> -			return;
> +			return ~0UL;
>   		}
>   
>   		if (match_cache_node(cpu, cache_node))
>   			min_id = min(min_id, id);
>   	}
>   
> -	if (min_id != ~0) {
> -		this_leaf->id = min_id;
> +	return min_id;
Looks like some 32bit/64bit confusion. Don't we want to return ~0UL if 
min_id == ~0?
> +}
> +
> +static void cache_of_set_id(struct cacheinfo *this_leaf,
> +			    struct device_node *cache_node)
> +{
> +	unsigned long id = cache_of_calculate_id(cache_node);
> +
> +	if (id != ~0UL) {
> +		this_leaf->id = id;
>   		this_leaf->attributes |= CACHE_ID;
>   	}
>   }
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index c8f4f0a0b874..2dcbb69139e9 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -112,6 +112,7 @@ int acpi_get_cache_info(unsigned int cpu,
>   #endif
>   
>   const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
> +unsigned long cache_of_calculate_id(struct device_node *np);
>   
>   /*
>    * Get the cacheinfo structure for the cache associated with @cpu at

Thanks,

Ben


