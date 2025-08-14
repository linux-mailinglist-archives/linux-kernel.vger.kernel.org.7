Return-Path: <linux-kernel+bounces-768508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F0B261CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A499A21727
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E66301466;
	Thu, 14 Aug 2025 10:00:30 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8883009ED
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165629; cv=none; b=phMiYz91CDFsHzv7DjV3n/+bc1rkQ3NLPnDYGWc6RaA2Hm0uYR9en5ltDLYMJ24J5W4sb4V+LT/ikhFLItlCkyA5Rb5K6+Q4EVO3jznHM7GpiQXC6Iqi4YwrJk2eGwbfWTCQYNOtSrgnVyKN83X96C1zAnmgLiNL1Lc/QW13KEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165629; c=relaxed/simple;
	bh=XNmipozB4d0cSlkaPH5GoZaJgKHzbOFYk5uNFClZD+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgYj1Q3TgCGq/Xk01zfQi3dsPRXPviXmX441mFESg9LIkDcDQuEkEYPkOarPrJ9RJXKP/KfWyS+8cTsAKGT464g8KaN5EyMvbj2NmqFu2HMhiT8PA/Cfxk7o9ptGuX9D7lQjULmlvsLVWWp0PkA/dwF5Kuub13zSsb6E4R6RLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C73B432BC;
	Thu, 14 Aug 2025 10:00:16 +0000 (UTC)
Message-ID: <10fd7e8b-90ae-40e7-836a-23aedcafc822@ghiti.fr>
Date: Thu, 14 Aug 2025 12:00:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 08/13] mm/page_table_check: Reinstate address
 parameter in [__]page_table_check_pte_clear()
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Cc: akpm@linux-foundation.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
 sweettea-kernel@dorminy.me, nicholas@linux.ibm.com,
 christophe.leroy@csgroup.eu, Rohan McLure <rmclure@linux.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
References: <20250813062614.51759-1-ajd@linux.ibm.com>
 <20250813062614.51759-9-ajd@linux.ibm.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250813062614.51759-9-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvvddruddtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheprghjugeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehli
 hhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 8/13/25 08:26, Andrew Donnellan wrote:
> From: Rohan McLure <rmclure@linux.ibm.com>
>
> This reverts commit aa232204c468 ("mm/page_table_check: remove unused
> parameter in [__]page_table_check_pte_clear").
>
> Reinstate previously unused parameters for the purpose of supporting
> powerpc platforms, as many do not encode user/kernel ownership of the
> page in the pte, but instead in the address of the access.
>
> [ajd@linux.ibm.com: rebase, fix additional occurrence and loop handling]
> Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>  # x86
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
> v13: fix an additional occurrence
> v15: rebase, fix loop handling
> ---
>   arch/arm64/include/asm/pgtable.h |  2 +-
>   arch/riscv/include/asm/pgtable.h |  2 +-
>   arch/x86/include/asm/pgtable.h   |  4 ++--
>   include/linux/page_table_check.h | 11 +++++++----
>   include/linux/pgtable.h          |  4 ++--
>   mm/page_table_check.c            |  7 ++++---
>   6 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index dfcdf051b114..2203ebac81d9 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1367,7 +1367,7 @@ static inline pte_t __ptep_get_and_clear_anysz(struct mm_struct *mm,
>   
>   	switch (pgsize) {
>   	case PAGE_SIZE:
> -		page_table_check_pte_clear(mm, pte);
> +		page_table_check_pte_clear(mm, address, pte);
>   		break;
>   	case PMD_SIZE:
>   		page_table_check_pmd_clear(mm, address, pte_pmd(pte));
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index d11fc6333606..d60e1604852d 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -591,7 +591,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>   {
>   	pte_t pte = __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
>   
> -	page_table_check_pte_clear(mm, pte);
> +	page_table_check_pte_clear(mm, address, pte);
>   
>   	return pte;
>   }
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index b68bea15f32d..63350b76c0c6 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1251,7 +1251,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>   				       pte_t *ptep)
>   {
>   	pte_t pte = native_ptep_get_and_clear(ptep);
> -	page_table_check_pte_clear(mm, pte);
> +	page_table_check_pte_clear(mm, addr, pte);
>   	return pte;
>   }
>   
> @@ -1267,7 +1267,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>   		 * care about updates and native needs no locking
>   		 */
>   		pte = native_local_ptep_get_and_clear(ptep);
> -		page_table_check_pte_clear(mm, pte);
> +		page_table_check_pte_clear(mm, addr, pte);
>   	} else {
>   		pte = ptep_get_and_clear(mm, addr, ptep);
>   	}
> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
> index 3973b69ae294..12268a32e8be 100644
> --- a/include/linux/page_table_check.h
> +++ b/include/linux/page_table_check.h
> @@ -14,7 +14,8 @@ extern struct static_key_true page_table_check_disabled;
>   extern struct page_ext_operations page_table_check_ops;
>   
>   void __page_table_check_zero(struct page *page, unsigned int order);
> -void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte);
> +void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
> +				  pte_t pte);
>   void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>   				  pmd_t pmd);
>   void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
> @@ -45,12 +46,13 @@ static inline void page_table_check_free(struct page *page, unsigned int order)
>   	__page_table_check_zero(page, order);
>   }
>   
> -static inline void page_table_check_pte_clear(struct mm_struct *mm, pte_t pte)
> +static inline void page_table_check_pte_clear(struct mm_struct *mm,
> +					      unsigned long addr, pte_t pte)
>   {
>   	if (static_branch_likely(&page_table_check_disabled))
>   		return;
>   
> -	__page_table_check_pte_clear(mm, pte);
> +	__page_table_check_pte_clear(mm, addr, pte);
>   }
>   
>   static inline void page_table_check_pmd_clear(struct mm_struct *mm,
> @@ -119,7 +121,8 @@ static inline void page_table_check_free(struct page *page, unsigned int order)
>   {
>   }
>   
> -static inline void page_table_check_pte_clear(struct mm_struct *mm, pte_t pte)
> +static inline void page_table_check_pte_clear(struct mm_struct *mm,
> +					      unsigned long addr, pte_t pte)
>   {
>   }
>   
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index d97f40f1365d..c85e0e1c1f97 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -494,7 +494,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>   {
>   	pte_t pte = ptep_get(ptep);
>   	pte_clear(mm, address, ptep);
> -	page_table_check_pte_clear(mm, pte);
> +	page_table_check_pte_clear(mm, address, pte);
>   	return pte;
>   }
>   #endif
> @@ -553,7 +553,7 @@ static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>   	 * No need for ptep_get_and_clear(): page table check doesn't care about
>   	 * any bits that could have been set by HW concurrently.
>   	 */
> -	page_table_check_pte_clear(mm, pte);
> +	page_table_check_pte_clear(mm, addr, pte);
>   }
>   
>   #ifdef CONFIG_GUP_GET_PXX_LOW_HIGH
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index e8c26b616aed..1c33439b9c0b 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -145,7 +145,8 @@ void __page_table_check_zero(struct page *page, unsigned int order)
>   	rcu_read_unlock();
>   }
>   
> -void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte)
> +void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
> +				  pte_t pte)
>   {
>   	if (&init_mm == mm)
>   		return;
> @@ -206,7 +207,7 @@ void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
>   	page_table_check_pte_flags(pte);
>   
>   	for (i = 0; i < nr; i++)
> -		__page_table_check_pte_clear(mm, ptep_get(ptep + i));
> +		__page_table_check_pte_clear(mm, addr + PAGE_SIZE * i, ptep_get(ptep + i));
>   	if (pte_user_accessible_page(pte))
>   		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
>   }
> @@ -268,7 +269,7 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
>   		if (WARN_ON(!ptep))
>   			return;
>   		for (i = 0; i < PTRS_PER_PTE; i++) {
> -			__page_table_check_pte_clear(mm, ptep_get(ptep));
> +			__page_table_check_pte_clear(mm, addr, ptep_get(ptep));
>   			addr += PAGE_SIZE;
>   			ptep++;
>   		}


Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks,

Alex


