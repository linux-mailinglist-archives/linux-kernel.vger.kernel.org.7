Return-Path: <linux-kernel+bounces-768494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCFAB26198
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551763BB387
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F822F60C2;
	Thu, 14 Aug 2025 09:50:45 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9D2F2912
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165044; cv=none; b=KE2uCXq5RGFbdOq0dkvqPbKjEKGlhf7gxoxzRW8osZCeWVe+R/0CnHro5car/CQN2vG5dL5KdAewDGk6Ouwdpa9O5fzOK1oCuWbBJ/HEkn1mY5KtneOdjrNbgmV2MMInSOCZMTjlOG+XSoZFPtnbEw31uek5hz2fTxO+lUKP2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165044; c=relaxed/simple;
	bh=4HTWaJbyZwY5TtUz/OMxupEV36Tdy9K7XmoRi4R/Tj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiFxK8bBIysr2TWOCGl1SNLnQh7++enJ4p6D+nnBASgCnAa08X17sMZVkjzGY/pKGts7649RYtZmRDQk4EC8bk2u7TpzpTDpLaE/RZATKe4cBhdvLVOr7ucQYAz8V8lzkwO8nZ8pHdiYwaidFYMUYZELggZvM3nYZX2SboBc04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8036443391;
	Thu, 14 Aug 2025 09:50:37 +0000 (UTC)
Message-ID: <1a7d8550-127a-4f72-8b20-5d5898d0a5ef@ghiti.fr>
Date: Thu, 14 Aug 2025 11:50:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/13] mm/page_table_check: Provide addr parameter to
 page_table_check_ptes_set()
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Cc: akpm@linux-foundation.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
 sweettea-kernel@dorminy.me, nicholas@linux.ibm.com,
 christophe.leroy@csgroup.eu, Rohan McLure <rmclure@linux.ibm.com>
References: <20250813062614.51759-1-ajd@linux.ibm.com>
 <20250813062614.51759-6-ajd@linux.ibm.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250813062614.51759-6-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvvddruddtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheprghjugeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehli
 hhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 8/13/25 08:26, Andrew Donnellan wrote:
> From: Rohan McLure <rmclure@linux.ibm.com>
>
> To provide support for powerpc platforms, provide an addr parameter to
> the __page_table_check_ptes_set() and page_table_check_ptes_set() routines.
> This parameter is needed on some powerpc platforms which do not encode whether
> a mapping is for user or kernel in the pte. On such platforms, this can be
> inferred from the addr parameter.
>
> [ajd@linux.ibm.com: rebase on arm64 + riscv changes, update commit message]
> Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
> v15: rebase, amend commit message
> ---
>   arch/arm64/include/asm/pgtable.h |  2 +-
>   arch/riscv/include/asm/pgtable.h |  2 +-
>   include/linux/page_table_check.h | 12 +++++++-----
>   include/linux/pgtable.h          |  2 +-
>   mm/page_table_check.c            |  4 ++--
>   5 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9fe3af8b4cad..06ea6a4f300b 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -706,7 +706,7 @@ static inline void __set_ptes_anysz(struct mm_struct *mm, unsigned long addr,
>   
>   	switch (pgsize) {
>   	case PAGE_SIZE:
> -		page_table_check_ptes_set(mm, ptep, pte, nr);
> +		page_table_check_ptes_set(mm, addr, ptep, pte, nr);
>   		break;
>   	case PMD_SIZE:
>   		page_table_check_pmds_set(mm, addr, (pmd_t *)ptep,
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 6e8c3d19f96a..2484c0788012 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -560,7 +560,7 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
>   static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>   		pte_t *ptep, pte_t pteval, unsigned int nr)
>   {
> -	page_table_check_ptes_set(mm, ptep, pteval, nr);
> +	page_table_check_ptes_set(mm, addr, ptep, pteval, nr);
>   
>   	for (;;) {
>   		__set_pte_at(mm, ptep, pteval);
> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
> index cf7c28d8d468..66e109238416 100644
> --- a/include/linux/page_table_check.h
> +++ b/include/linux/page_table_check.h
> @@ -17,8 +17,8 @@ void __page_table_check_zero(struct page *page, unsigned int order);
>   void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte);
>   void __page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd);
>   void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud);
> -void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
> -		unsigned int nr);
> +void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr);
>   void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long addr,
>   		pmd_t *pmdp, pmd_t pmd, unsigned int nr);
>   void __page_table_check_puds_set(struct mm_struct *mm, unsigned long addr,
> @@ -68,12 +68,13 @@ static inline void page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
>   }
>   
>   static inline void page_table_check_ptes_set(struct mm_struct *mm,
> -		pte_t *ptep, pte_t pte, unsigned int nr)
> +					     unsigned long addr, pte_t *ptep,
> +					     pte_t pte, unsigned int nr)
>   {
>   	if (static_branch_likely(&page_table_check_disabled))
>   		return;
>   
> -	__page_table_check_ptes_set(mm, ptep, pte, nr);
> +	__page_table_check_ptes_set(mm, addr, ptep, pte, nr);
>   }
>   
>   static inline void page_table_check_pmds_set(struct mm_struct *mm,
> @@ -127,7 +128,8 @@ static inline void page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
>   }
>   
>   static inline void page_table_check_ptes_set(struct mm_struct *mm,
> -		pte_t *ptep, pte_t pte, unsigned int nr)
> +					     unsigned long addr, pte_t *ptep,
> +					     pte_t pte, unsigned int nr)
>   {
>   }
>   
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 4c035637eeb7..8aab3fa19c85 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -289,7 +289,7 @@ static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
>   static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>   		pte_t *ptep, pte_t pte, unsigned int nr)
>   {
> -	page_table_check_ptes_set(mm, ptep, pte, nr);
> +	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
>   
>   	for (;;) {
>   		set_pte(ptep, pte);
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 09258f2ad93f..0957767a2940 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -193,8 +193,8 @@ static inline void page_table_check_pte_flags(pte_t pte)
>   		WARN_ON_ONCE(swap_cached_writable(pte_to_swp_entry(pte)));
>   }
>   
> -void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
> -		unsigned int nr)
> +void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
> +				 pte_t *ptep, pte_t pte, unsigned int nr)
>   {
>   	unsigned int i;
>   

Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks,

Alex


