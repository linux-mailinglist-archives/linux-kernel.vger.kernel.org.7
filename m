Return-Path: <linux-kernel+bounces-853865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE15BDCC94
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A246425CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0C5313E1A;
	Wed, 15 Oct 2025 06:46:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6885313E26
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510789; cv=none; b=cw1UY3fG6OFe2zg9wU/wx4D2D/8o8KdukB06CwhCIEYQ4vYDX0i54u22DE6jnLanyfb+gFaM1NmNW9NmVeegfEuJcCojDcF/PzN8VuZv6ue4ngtc4SkSFCYowmnEf7SbOjT0YiLSl3KmVZoH4uuz78NHuP3mvpdxkxd9Yh2GFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510789; c=relaxed/simple;
	bh=jdO6iUffukrVUTW8YZ+T3nrokT9QURV2O59Xbm4Chgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ia28jKqJlz0mjMJPJ1G5vowiaJ6N08kSl2OyBSGwVfbAI5YIINZNLfqHezhkXqguXVFItMGURpujXSJ0QrH+Z/kRGeA+1EN6L2JnKVJfLqO7cmh2va2Dxhcf31p5thzzuDmhEFLfqMSHhVPDxc3O5riBha2qV4uTlUSkauj8Y/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21BAA1A32;
	Tue, 14 Oct 2025 23:46:17 -0700 (PDT)
Received: from [10.163.67.182] (unknown [10.163.67.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 334E83F6A8;
	Tue, 14 Oct 2025 23:46:21 -0700 (PDT)
Message-ID: <00bf0498-8f11-466e-9f2a-f7e656ecddf9@arm.com>
Date: Wed, 15 Oct 2025 12:16:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: mm: make linear mapping permission update more
 robust for patial range
To: Yang Shi <yang@os.amperecomputing.com>, ryan.roberts@arm.com,
 cl@gentwo.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
 <20251013232803.3065100-2-yang@os.amperecomputing.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251013232803.3065100-2-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 14/10/25 4:57 am, Yang Shi wrote:
> The commit fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when changing
> permissions for vmalloc_huge mappings") made permission update for
> partial range more robust. But the linear mapping permission update
> still assumes update the whole range by iterating from the first page
> all the way to the last page of the area.
>
> Make it more robust by updating the linear mapping permission from the
> page mapped by start address, and update the number of numpages.
>
> Fixes: fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when changing permissions for vmalloc_huge mappings")
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   arch/arm64/mm/pageattr.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 5135f2d66958..c21a2c319028 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -148,7 +148,6 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	unsigned long size = PAGE_SIZE * numpages;
>   	unsigned long end = start + size;
>   	struct vm_struct *area;
> -	int i;
>   
>   	if (!PAGE_ALIGNED(addr)) {
>   		start &= PAGE_MASK;
> @@ -184,8 +183,9 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	 */
>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
> -		for (i = 0; i < area->nr_pages; i++) {
> -			__change_memory_common((u64)page_address(area->pages[i]),
> +		unsigned long idx = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
> +		for (int i = 0; i < numpages; i++) {
> +			__change_memory_common((u64)page_address(area->pages[idx++]),
>   					       PAGE_SIZE, set_mask, clear_mask);

Why not just use idx as the iterator in the for loop? Using i and then incrementing
idx is confusing.

As noted by Ryan, the fixes commit is wrong. The issues persists from commit c55191e.

After fixing these:

Reviewed-by: Dev Jain <dev.jain@arm.com>

>   		}
>   	}

