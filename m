Return-Path: <linux-kernel+bounces-899284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75E6C5746B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CE93AF2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291634A763;
	Thu, 13 Nov 2025 11:55:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E445299AA3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034953; cv=none; b=BfrnQ0DZQdn0p3m1gIHetdwZlvxCgf96AWLuxnSkj36T1tr4tPzPlY+nLDHv6q1UjY/KDquO1Av3PASUPfKqsQMNYp0KcjI5tN6Agup6U2c6EowIKxnJ0a15lrWAUTYWWFjS2TsM/Unz+OvmgwDI3hbz6UWC4hTzWk8ppuIBzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034953; c=relaxed/simple;
	bh=SeJ/WzyXEKJSUbI9hAVu4ICNYMT/JTl35fXdHsDRKG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhyaIQkeZWCY/ZH6gVMycT5pruQpWf3mJoh26oUXtfZt1uN5ILOXe+Oi5XFglmG9sNlBV+s6wH9uSIIweT4x5oBeAfiy6uSyahMpyQJ9ZlKvTJqGPxMK+H4dvOz95hmcRAhejCgqRDmH+kuhX5jhfuavzyZypGICbAt/VhvGp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C339D12FC;
	Thu, 13 Nov 2025 03:55:43 -0800 (PST)
Received: from [10.57.88.12] (unknown [10.57.88.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 274493F5A1;
	Thu, 13 Nov 2025 03:55:50 -0800 (PST)
Message-ID: <6bc0fac0-3c00-4ecf-948e-5648584ec939@arm.com>
Date: Thu, 13 Nov 2025 11:55:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64/pageattr: Propagate return value from
 __change_memory_common
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: rppt@kernel.org, shijie@os.amperecomputing.com,
 yang@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251112062716.64801-1-dev.jain@arm.com>
 <20251112062716.64801-2-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251112062716.64801-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2025 06:27, Dev Jain wrote:
> The rodata=on security measure requires that any code path which does
> vmalloc -> set_memory_ro/set_memory_rox must protect the linear map alias
> too. Therefore, if such a call fails, we must abort set_memory_* and caller
> must take appropriate action; currently we are suppressing the error, and
> there is a real chance of such an error arising post commit a166563e7ec3
> ("arm64: mm: support large block mapping when rodata=full"). Therefore,
> propagate any error to the caller.
> 
> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

It would be good to get this into v6.18 I guess?

Although I think this will conflict with a patch from Yang that makes this work
with a partial vm area range - But I think that one will only go to v6.19.

Thanks,
Ryan

> ---
> v1 of this patch: https://lore.kernel.org/all/20251103061306.82034-1-dev.jain@arm.com/
> I have dropped stable since no real chance of failure was there.
> 
>  arch/arm64/mm/pageattr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 5135f2d66958..b4ea86cd3a71 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	unsigned long size = PAGE_SIZE * numpages;
>  	unsigned long end = start + size;
>  	struct vm_struct *area;
> +	int ret;
>  	int i;
>  
>  	if (!PAGE_ALIGNED(addr)) {
> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>  			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>  		for (i = 0; i < area->nr_pages; i++) {
> -			__change_memory_common((u64)page_address(area->pages[i]),
> +			ret = __change_memory_common((u64)page_address(area->pages[i]),
>  					       PAGE_SIZE, set_mask, clear_mask);
> +			if (ret)
> +				return ret;
>  		}
>  	}
>  


