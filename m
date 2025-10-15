Return-Path: <linux-kernel+bounces-853875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D4BDCCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ABA3A4895
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4107313263;
	Wed, 15 Oct 2025 06:51:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59767310771
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511061; cv=none; b=U6RdPTn5ey3+v2FZ7j2A6I5cCHfvTORHM3zJIFmjsgxNAErUVTqRb9E04lnAxY8+KRFkavo5pSCZaWStUMEXjk1qZDr0H+MUJBKoUW8/N4+w5KZO15PQ3I53CHRgb5zxDeP3vCD9GobhmCIqUkn/eD7unKc5I6U9QRqGFOEVoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511061; c=relaxed/simple;
	bh=k/l99g2DMhOXivwXETyV0lCBacqRU31kteEqdOBea9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9YTTMdKdimMvl/3kcU2WowhVmFXBWPaFhYZnu9FVD0i2CdRX9mOOAH1gEfwYrKiEL0lm1tDKCGcfnkokioYLfDDT+WBI8v6/7DkJuFjuqxXYtIvoJsxy1IhBJiJxOZ2janoEY5RChlWWB4ohBZVw0svIRztGcVEUK+9NLAEreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAF671A32;
	Tue, 14 Oct 2025 23:50:50 -0700 (PDT)
Received: from [10.163.67.182] (unknown [10.163.67.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FE483F6A8;
	Tue, 14 Oct 2025 23:50:54 -0700 (PDT)
Message-ID: <eaa67b0d-e256-4db6-82e7-c4d56df70c09@arm.com>
Date: Wed, 15 Oct 2025 12:20:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: mm: relax VM_ALLOW_HUGE_VMAP if BBML2_NOABORT
 is supported
To: Yang Shi <yang@os.amperecomputing.com>, ryan.roberts@arm.com,
 cl@gentwo.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
 <20251013232803.3065100-3-yang@os.amperecomputing.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251013232803.3065100-3-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 14/10/25 4:57 am, Yang Shi wrote:
> When changing permissions for vmalloc area, VM_ALLOW_HUGE_VMAP area is
> exclueded because kernel can't split the va mapping if it is called on
> partial range.
> It is no longer true if the machines support BBML2_NOABORT after commit
> a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full").
> So we can relax this restriction and update the comments accordingly.
>
> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   arch/arm64/mm/pageattr.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index c21a2c319028..b4dcae6273a8 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -157,13 +157,13 @@ static int change_memory_common(unsigned long addr, int numpages,
>   
>   	/*
>   	 * Kernel VA mappings are always live, and splitting live section
> -	 * mappings into page mappings may cause TLB conflicts. This means
> -	 * we have to ensure that changing the permission bits of the range
> -	 * we are operating on does not result in such splitting.
> +	 * mappings into page mappings may cause TLB conflicts on the machines
> +	 * which don't support BBML2_NOABORT.
>   	 *
>   	 * Let's restrict ourselves to mappings created by vmalloc (or vmap).
> -	 * Disallow VM_ALLOW_HUGE_VMAP mappings to guarantee that only page
> -	 * mappings are updated and splitting is never needed.
> +	 * Disallow VM_ALLOW_HUGE_VMAP mappings if the systems don't support
> +	 * BBML2_NOABORT to guarantee that only page mappings are updated and
> +	 * splitting is never needed on those machines.
>   	 *
>   	 * So check whether the [addr, addr + size) interval is entirely
>   	 * covered by precisely one VM area that has the VM_ALLOC flag set.
> @@ -171,7 +171,8 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	area = find_vm_area((void *)addr);
>   	if (!area ||
>   	    end > (unsigned long)kasan_reset_tag(area->addr) + area->size ||
> -	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
> +	    !(area->flags & VM_ALLOC) || ((area->flags & VM_ALLOW_HUGE_VMAP) &&
> +	    !system_supports_bbml2_noabort()))
>   		return -EINVAL;
>   
>   	if (!numpages)

This will conflict with my upcoming vmalloc-huge series, so best to leave it to me,
I already have this included :)


