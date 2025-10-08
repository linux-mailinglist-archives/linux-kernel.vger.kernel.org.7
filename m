Return-Path: <linux-kernel+bounces-845017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63926BC34A2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138853A7E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0412BE7C3;
	Wed,  8 Oct 2025 04:25:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1C11799F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897535; cv=none; b=m9gBztxCbulbTQ7Tf2bOgIerjDT69MTFhA0DDLn7PzTAy7u2d2lG0gpH0y6qqLInu0qiE3rdVuiANxLF6mdKjHMnNqdhJYoXiXiGg8jD7DByfqSIPFwLfTUC4ol7pFy+wMxkpDqCTtiCdI7CkmBktbRUI1FfaMo0F2GlQP4eYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897535; c=relaxed/simple;
	bh=jKEXlct6Rf7OrDLOu0C95ftu6OrVnaetHPVagll4+7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hvlnx/O7gZXZ7HPJk9obNcfZKoZHI4kP7feiHBzlOAWZREu5WPM0qYiC7Wlj87T2dwpmPngT0FZcDnY1EtAd0mmX3ts+rPw3QTLgDfaYcxnvyXJUORYo7pr/JVCYfgXpNyKcGfR7Rq7mAiivhXpxdUE4WLKE+SFW+I5zTxLa92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C70E022EE;
	Tue,  7 Oct 2025 21:25:24 -0700 (PDT)
Received: from [10.163.36.4] (unknown [10.163.36.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 595B63F738;
	Tue,  7 Oct 2025 21:25:31 -0700 (PDT)
Message-ID: <4bf3894a-1825-447a-8efd-64ecc09e2dc6@arm.com>
Date: Wed, 8 Oct 2025 09:55:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/sgi-gru: Use pxdp_get() for page table access
To: linux-kernel@vger.kernel.org
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251008042126.2408106-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251008042126.2408106-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/10/25 9:51 AM, Anshuman Khandual wrote:
> Replace all READ_ONCE() with a standard page table accessors i.e pxdp_get()
> that default into READ_ONCE() in cases where platforms do not override.
> 
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/misc/sgi-gru/grufault.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index 3557d78ee47a..60e55facd8d7 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -212,19 +212,19 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
>  	pte_t pte;
>  
>  	pgdp = pgd_offset(vma->vm_mm, vaddr);
> -	if (unlikely(pgd_none(*pgdp)))
> +	if (unlikely(pgd_none(pgdp_get(pgdp))))
>  		goto err;
>  
>  	p4dp = p4d_offset(pgdp, vaddr);
> -	if (unlikely(p4d_none(*p4dp)))
> +	if (unlikely(p4d_none(p4dp_get(p4dp))))
>  		goto err;
>  
>  	pudp = pud_offset(p4dp, vaddr);
> -	if (unlikely(pud_none(*pudp)))
> +	if (unlikely(pud_none(pudp_get(pudp))))
>  		goto err;
>  
>  	pmdp = pmd_offset(pudp, vaddr);
> -	if (unlikely(pmd_none(*pmdp)))
> +	if (unlikely(pmd_none(pmdp_get(pmdp))))
>  		goto err;
>  #ifdef CONFIG_X86_64
>  	if (unlikely(pmd_leaf(*pmdp)))

Please ignore this patch as it does not replace any READ_ONCE()
based page table accesses in this file. My bad.

