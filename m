Return-Path: <linux-kernel+bounces-768491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1733AB26196
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C50D1CC2C72
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC412F533C;
	Thu, 14 Aug 2025 09:50:11 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE52F546F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165010; cv=none; b=g++90TV3ne5LJsUlS/jdJkxeUvFwH7CrNKxrnW5Ie8YQiGb7pwp34tsweaPB+sjgV2Zac9u8Nhcclr3PwAmuCqC7j7olJkeR0LDK/zR8LoEdTvBmTagOrcH59qtOnkGgVYVmja+JKk6/Hfyn4EDPB2UZchXDMw/WTt2Mj6W+lfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165010; c=relaxed/simple;
	bh=d4poEPfc1gHjS1e7/MTpk9SUnwcA14+pExai2inW+4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPI0RGEzqCmqWLe3E4iWHFFPKBPCvxpc8YpzRIzZC4GoGzsLwkSKNJ+VLjqY3GCWIx2CzDC16VHHNxNenGTcA8kaaOW32lZH5B+e1julIPDK9yW4UonDdhc+OVGH8fDpAZCw63p5oh5iIUphzFqOYs7Fxx0m/h3uVogm5bFhAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8022243214;
	Thu, 14 Aug 2025 09:50:03 +0000 (UTC)
Message-ID: <77670b86-1212-4547-a119-a876e4948b33@ghiti.fr>
Date: Thu, 14 Aug 2025 11:50:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/13] mm/page_table_check: Reinstate address
 parameter in [__]page_table_check_pmd[s]_set()
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Cc: akpm@linux-foundation.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
 sweettea-kernel@dorminy.me, nicholas@linux.ibm.com,
 christophe.leroy@csgroup.eu, Rohan McLure <rmclure@linux.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
References: <20250813062614.51759-1-ajd@linux.ibm.com>
 <20250813062614.51759-5-ajd@linux.ibm.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250813062614.51759-5-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvvddruddtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheprghjugeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehli
 hhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 8/13/25 08:26, Andrew Donnellan wrote:
> From: Rohan McLure <rmclure@linux.ibm.com>
>
> This reverts commit a3b837130b58 ("mm/page_table_check: remove unused
> parameter in [__]page_table_check_pmd_set").
>
> Reinstate previously unused parameters for the purpose of supporting
> powerpc platforms, as many do not encode user/kernel ownership of the
> page in the pte, but instead in the address of the access.
>
> Apply this to __page_table_check_pmds_set(), page_table_check_pmd_set(), and
> the page_table_check_pmd_set() wrapper macro.
>
> [ajd@linux.ibm.com: rebase on arm64 + riscv changes, update commit message]
> Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>  # x86
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
> v13: remove inaccurate comment on riscv in the commit message
> v14: rebase
> v15: rebase, amend commit message
> ---
>   arch/arm64/include/asm/pgtable.h |  5 +++--
>   arch/riscv/include/asm/pgtable.h |  4 ++--
>   arch/x86/include/asm/pgtable.h   |  4 ++--
>   include/linux/page_table_check.h | 12 ++++++------
>   mm/page_table_check.c            |  4 ++--
>   5 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 8070b653c409..9fe3af8b4cad 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -709,7 +709,8 @@ static inline void __set_ptes_anysz(struct mm_struct *mm, unsigned long addr,
>   		page_table_check_ptes_set(mm, ptep, pte, nr);
>   		break;
>   	case PMD_SIZE:
> -		page_table_check_pmds_set(mm, (pmd_t *)ptep, pte_pmd(pte), nr);
> +		page_table_check_pmds_set(mm, addr, (pmd_t *)ptep,
> +					  pte_pmd(pte), nr);
>   		break;
>   #ifndef __PAGETABLE_PMD_FOLDED
>   	case PUD_SIZE:
> @@ -1514,7 +1515,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>   static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>   		unsigned long address, pmd_t *pmdp, pmd_t pmd)
>   {
> -	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
> +	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
>   	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
>   }
>   #endif
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 3ed0f5e4879d..6e8c3d19f96a 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -805,7 +805,7 @@ static inline pud_t pud_mkspecial(pud_t pud)
>   static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>   				pmd_t *pmdp, pmd_t pmd)
>   {
> -	page_table_check_pmd_set(mm, pmdp, pmd);
> +	page_table_check_pmd_set(mm, addr, pmdp, pmd);
>   	return __set_pte_at(mm, (pte_t *)pmdp, pmd_pte(pmd));
>   }
>   
> @@ -876,7 +876,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>   static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>   				unsigned long address, pmd_t *pmdp, pmd_t pmd)
>   {
> -	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
> +	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
>   	return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
>   }
>   
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 0603793acb3a..8ee301b16b50 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1213,7 +1213,7 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
>   static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>   			      pmd_t *pmdp, pmd_t pmd)
>   {
> -	page_table_check_pmd_set(mm, pmdp, pmd);
> +	page_table_check_pmd_set(mm, addr, pmdp, pmd);
>   	set_pmd(pmdp, pmd);
>   }
>   
> @@ -1356,7 +1356,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>   static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>   		unsigned long address, pmd_t *pmdp, pmd_t pmd)
>   {
> -	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
> +	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
>   	if (IS_ENABLED(CONFIG_SMP)) {
>   		return xchg(pmdp, pmd);
>   	} else {
> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
> index 0bf18b884a12..cf7c28d8d468 100644
> --- a/include/linux/page_table_check.h
> +++ b/include/linux/page_table_check.h
> @@ -19,8 +19,8 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd);
>   void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud);
>   void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
>   		unsigned int nr);
> -void __page_table_check_pmds_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd,
> -		unsigned int nr);
> +void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long addr,
> +		pmd_t *pmdp, pmd_t pmd, unsigned int nr);
>   void __page_table_check_puds_set(struct mm_struct *mm, unsigned long addr,
>   		pud_t *pudp, pud_t pud, unsigned int nr);
>   void __page_table_check_pte_clear_range(struct mm_struct *mm,
> @@ -77,12 +77,12 @@ static inline void page_table_check_ptes_set(struct mm_struct *mm,
>   }
>   
>   static inline void page_table_check_pmds_set(struct mm_struct *mm,
> -		pmd_t *pmdp, pmd_t pmd, unsigned int nr)
> +		unsigned long addr, pmd_t *pmdp, pmd_t pmd, unsigned int nr)
>   {
>   	if (static_branch_likely(&page_table_check_disabled))
>   		return;
>   
> -	__page_table_check_pmds_set(mm, pmdp, pmd, nr);
> +	__page_table_check_pmds_set(mm, addr, pmdp, pmd, nr);
>   }
>   
>   static inline void page_table_check_puds_set(struct mm_struct *mm,
> @@ -132,7 +132,7 @@ static inline void page_table_check_ptes_set(struct mm_struct *mm,
>   }
>   
>   static inline void page_table_check_pmds_set(struct mm_struct *mm,
> -		pmd_t *pmdp, pmd_t pmd, unsigned int nr)
> +		unsigned long addr, pmd_t *pmdp, pmd_t pmd, unsigned int nr)
>   {
>   }
>   
> @@ -149,7 +149,7 @@ static inline void page_table_check_pte_clear_range(struct mm_struct *mm,
>   
>   #endif /* CONFIG_PAGE_TABLE_CHECK */
>   
> -#define page_table_check_pmd_set(mm, pmdp, pmd)	page_table_check_pmds_set(mm, pmdp, pmd, 1)
> +#define page_table_check_pmd_set(mm, addr, pmdp, pmd)	page_table_check_pmds_set(mm, addr, pmdp, pmd, 1)
>   #define page_table_check_pud_set(mm, addr, pudp, pud)	page_table_check_puds_set(mm, addr, pudp, pud, 1)
>   
>   #endif /* __LINUX_PAGE_TABLE_CHECK_H */
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 3c39e4375886..09258f2ad93f 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -218,8 +218,8 @@ static inline void page_table_check_pmd_flags(pmd_t pmd)
>   		WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)));
>   }
>   
> -void __page_table_check_pmds_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd,
> -		unsigned int nr)
> +void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long addr,
> +		pmd_t *pmdp, pmd_t pmd, unsigned int nr)
>   {
>   	unsigned long stride = PMD_SIZE >> PAGE_SHIFT;
>   	unsigned int i;



Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks,

Alex


