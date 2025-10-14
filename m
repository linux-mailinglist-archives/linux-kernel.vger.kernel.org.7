Return-Path: <linux-kernel+bounces-852073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AFBD81BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE0318A00D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C305A3074AC;
	Tue, 14 Oct 2025 08:08:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932E330DEB6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429322; cv=none; b=B3EZ5son/l+bo1Wrc57/dtkHWwvV5KThgJ6cZN7e93SjI2SHyeKlVjV/qUEFPW46HmLAktkYbWIrtXfMZWQiVjQ34i+N/hI/Fd3e9vBFzi2qMyTBsBOuoR8bj9Nc+grBEmzJHUNBfuMP/QRz/kQCLnMurUp+vQXLp3f5q/ZrOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429322; c=relaxed/simple;
	bh=U082kiNJks56nUau37vHGWQ7iF35vD0dHRbASbE6BjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKPnEv5hEQcnozKbQBpPdsNVFRWn3kgN7grHsk+UH4wV8RFz+FHLu8c6a1pThCfsEsFDIVSKXDqNVDdxj8uc6o0SOA/dq2YfJ1TQvDr0E6C3dtEiGw+suu6lhaltJmWtBq1s3/bQTBsxTTzeJ0QlCQJi2P43RZFfAS8DH+DxGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 084D21A9A;
	Tue, 14 Oct 2025 01:08:32 -0700 (PDT)
Received: from [10.57.83.223] (unknown [10.57.83.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831123F6A8;
	Tue, 14 Oct 2025 01:08:38 -0700 (PDT)
Message-ID: <f6e31f0d-a256-4d58-adfb-4d3d97dbaef2@arm.com>
Date: Tue, 14 Oct 2025 09:08:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: mm: relax VM_ALLOW_HUGE_VMAP if BBML2_NOABORT
 is supported
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, dev.jain@arm.com, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
 <20251013232803.3065100-3-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251013232803.3065100-3-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 00:27, Yang Shi wrote:
> When changing permissions for vmalloc area, VM_ALLOW_HUGE_VMAP area is
> exclueded because kernel can't split the va mapping if it is called on
> partial range.
> It is no longer true if the machines support BBML2_NOABORT after commit
> a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full").
> So we can relax this restriction and update the comments accordingly.

Is there actually any user that benefits from this modified behaviour in the
current kernel? If not, then I'd prefer to leave this for Dev to modify
systematically as part of his series to enable VM_ALLOW_HUGE_VMAP by default for
arm64. I believe he's planning to post that soon.

Thanks,
Ryan

> 
> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/mm/pageattr.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index c21a2c319028..b4dcae6273a8 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -157,13 +157,13 @@ static int change_memory_common(unsigned long addr, int numpages,
>  
>  	/*
>  	 * Kernel VA mappings are always live, and splitting live section
> -	 * mappings into page mappings may cause TLB conflicts. This means
> -	 * we have to ensure that changing the permission bits of the range
> -	 * we are operating on does not result in such splitting.
> +	 * mappings into page mappings may cause TLB conflicts on the machines
> +	 * which don't support BBML2_NOABORT.
>  	 *
>  	 * Let's restrict ourselves to mappings created by vmalloc (or vmap).
> -	 * Disallow VM_ALLOW_HUGE_VMAP mappings to guarantee that only page
> -	 * mappings are updated and splitting is never needed.
> +	 * Disallow VM_ALLOW_HUGE_VMAP mappings if the systems don't support
> +	 * BBML2_NOABORT to guarantee that only page mappings are updated and
> +	 * splitting is never needed on those machines.
>  	 *
>  	 * So check whether the [addr, addr + size) interval is entirely
>  	 * covered by precisely one VM area that has the VM_ALLOC flag set.
> @@ -171,7 +171,8 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	area = find_vm_area((void *)addr);
>  	if (!area ||
>  	    end > (unsigned long)kasan_reset_tag(area->addr) + area->size ||
> -	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
> +	    !(area->flags & VM_ALLOC) || ((area->flags & VM_ALLOW_HUGE_VMAP) &&
> +	    !system_supports_bbml2_noabort()))
>  		return -EINVAL;
>  
>  	if (!numpages)


