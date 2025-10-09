Return-Path: <linux-kernel+bounces-846162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D5BC72B6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22023347FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EDF19922D;
	Thu,  9 Oct 2025 02:03:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0B41397;
	Thu,  9 Oct 2025 02:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975394; cv=none; b=R+C/QkF38p6ZMDHOaA1cTK3S9K6+9xIiH6yBny3bgvBCF+GtFOByCMUPSII8AWOk7aBmPCQ0uEHOGX2qfuh4Fys1+Gy0waiPxME3SdQ8G1I5ZwMnExuynUNzsK8DcFJfAZuaeQ/K5Ew1YUUzo7aBcjScir47rk1TmRb6ztQiD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975394; c=relaxed/simple;
	bh=FYeKjXCSa+sugLZNOvMXe+AcFfKj2MNmosBD05Z/05g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t087YLUUKXhLORZBdeovZlP9FdjrmuA1NBF5QI9x7Vvx4iGjuV8smIdincY/xJ1GRNK6SdF82xqBZNTzRxXmGdhEn+Sncaem6BCI2w7816p6dmM4E62WpVoEiMAJEbmgjhaBrlyxIMam3QVludhGlrxvIYpN9MrwYO/4yvwv5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5AFA1A32;
	Wed,  8 Oct 2025 19:03:02 -0700 (PDT)
Received: from [10.163.35.84] (unknown [10.163.35.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E94173F738;
	Wed,  8 Oct 2025 19:03:06 -0700 (PDT)
Message-ID: <24beaa64-d144-42c3-945f-a37e1cac384d@arm.com>
Date: Thu, 9 Oct 2025 07:33:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] perf/core: Replace READ_ONCE() with standard
 page table accessors
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Conor Dooley <conor@kernel.org>,
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>,
 Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
 <20251009015839.3460231-3-samuel.holland@sifive.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251009015839.3460231-3-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/10/25 7:27 AM, Samuel Holland wrote:
> Replace READ_ONCE() with standard page table accessors, i.e. pXXp_get(),
> which have a default implementation of READ_ONCE() if the architecture
> does not override them.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v2:
>  - New patch for v2
> 
>  kernel/events/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 820127536e62b..952ba4e3d8815 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8110,7 +8110,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>  	pte_t *ptep, pte;
>  
>  	pgdp = pgd_offset(mm, addr);
> -	pgd = READ_ONCE(*pgdp);
> +	pgd = pgdp_get(pgdp);
>  	if (pgd_none(pgd))
>  		return 0;
>  
> @@ -8118,7 +8118,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>  		return pgd_leaf_size(pgd);
>  
>  	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
> -	p4d = READ_ONCE(*p4dp);
> +	p4d = p4dp_get(p4dp);
>  	if (!p4d_present(p4d))
>  		return 0;
>  
> @@ -8126,7 +8126,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>  		return p4d_leaf_size(p4d);
>  
>  	pudp = pud_offset_lockless(p4dp, p4d, addr);
> -	pud = READ_ONCE(*pudp);
> +	pud = pudp_get(pudp);
>  	if (!pud_present(pud))
>  		return 0;
>  

This is already under discussion here.

https://lore.kernel.org/all/20251006042622.1743675-1-anshuman.khandual@arm.com/


