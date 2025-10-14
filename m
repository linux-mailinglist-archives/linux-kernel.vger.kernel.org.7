Return-Path: <linux-kernel+bounces-852066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC87BD818F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525261921E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD630F932;
	Tue, 14 Oct 2025 08:05:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4E30F81D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429118; cv=none; b=ApYqXyxOO/9bEs48wTbAHDpffPuhWanZc/GjUzcWyIdHPA+v3iynvHwwlP9e2TX7/4facK/y8vDTEDqt6QSL8KtQPChluKg/Lxq8T2N3QlLhsyMC6KTTIH59sVNK8d6l6uDD8OMoW9D4k257V4Y4kxRMN9OS8TOk027wJ/SL6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429118; c=relaxed/simple;
	bh=Je/X8s/Isbsk4WW67TXPPuKS2NnhKLHW9CEvGPYXlSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeRcxXBEWh82GpnHd42a7bzANfReep0CCLekK6h/Ik7zwrZsdiZPOopV0nZtVhcMuB2EAke2xwfJnqG8hMYDGJh66KSPGR6VDjACkn3K3c1u4DiP7OR17B2N4pGDjoG+SYiIJ3AwSgUUzRTvq7uFU5+yrIO2Gc/zpGwU8A9Nf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5842A1A9A;
	Tue, 14 Oct 2025 01:05:02 -0700 (PDT)
Received: from [10.57.83.223] (unknown [10.57.83.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583033F6A8;
	Tue, 14 Oct 2025 01:05:08 -0700 (PDT)
Message-ID: <973e36b9-e89a-43b2-bb85-b00343dd4e36@arm.com>
Date: Tue, 14 Oct 2025 09:05:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: mm: make linear mapping permission update more
 robust for patial range
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, dev.jain@arm.com, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
 <20251013232803.3065100-2-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251013232803.3065100-2-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 00:27, Yang Shi wrote:
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

I don't think this is the correct commit. I think this theoretical issue was
present before that. But it is only theoretical AFAIK? In which case, I'd be
inclined to just drop the tag.

Otherwise, LGTM:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/mm/pageattr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 5135f2d66958..c21a2c319028 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -148,7 +148,6 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	unsigned long size = PAGE_SIZE * numpages;
>  	unsigned long end = start + size;
>  	struct vm_struct *area;
> -	int i;
>  
>  	if (!PAGE_ALIGNED(addr)) {
>  		start &= PAGE_MASK;
> @@ -184,8 +183,9 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	 */
>  	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>  			    pgprot_val(clear_mask) == PTE_RDONLY)) {
> -		for (i = 0; i < area->nr_pages; i++) {
> -			__change_memory_common((u64)page_address(area->pages[i]),
> +		unsigned long idx = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
> +		for (int i = 0; i < numpages; i++) {
> +			__change_memory_common((u64)page_address(area->pages[idx++]),
>  					       PAGE_SIZE, set_mask, clear_mask);
>  		}
>  	}


