Return-Path: <linux-kernel+bounces-768757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9BB26518
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF7D1CC5B09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3712FD7B1;
	Thu, 14 Aug 2025 12:11:53 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B872FD1AF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173512; cv=none; b=GB/D0xeSQvl2+nHzVSj2HDtxaxmC5xyEcldCQOJ5aQo9dj5z8HntLXQZNzDri98zX0xu9YXJJMO4xA6+cQTz7X1LoKoT6bXiJKWhCJJvAZ/b/zfz1W5ON7+rsccmDdoYojF5up+zK48S5c/jtwJM4B5DkxL51aIBtm8WHrU/gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173512; c=relaxed/simple;
	bh=oacW6elFEt7q132ppNYkPmW40DNQ7eO/3WbfdJF29Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9ly6YcyE/C5p2itkZUTtZXYups3DsNc58Ebq5rI4BykldkzlhCRAy2jrB7Mzo8xwwUPJky1OGmtDiaiwFe6EmSVUGKw4gJ8eNi51gDVUGT823M3TKLc2EvolDQGYT3V8cCo0gDH4wTHu+iPASO4vQTRPRn9ZxktVs2c10+s/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E68F2059F;
	Thu, 14 Aug 2025 12:11:45 +0000 (UTC)
Message-ID: <5aa057d0-dc76-4723-80d1-82065320a428@ghiti.fr>
Date: Thu, 14 Aug 2025 14:11:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 06/13] mm/page_table_check: Reinstate address
 parameter in [__]page_table_check_pud_clear()
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Cc: akpm@linux-foundation.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
 sweettea-kernel@dorminy.me, nicholas@linux.ibm.com,
 christophe.leroy@csgroup.eu, Rohan McLure <rmclure@linux.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
References: <20250813062614.51759-1-ajd@linux.ibm.com>
 <20250813062614.51759-7-ajd@linux.ibm.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250813062614.51759-7-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhhfdutdevgeelgeegfeeltdduhfduledvteduhfegffffiefggfektefhjedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleefrdeffedrheejrdduleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelfedrfeefrdehjedrudelledphhgvlhhopegludelvddrudeikedrvddvrddutddungdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegrjhgusehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

On 8/13/25 08:26, Andrew Donnellan wrote:
> From: Rohan McLure <rmclure@linux.ibm.com>
>
> This reverts commit 931c38e16499 ("mm/page_table_check: remove unused
> parameter in [__]page_table_check_pud_clear").
>
> Reinstate previously unused parameters for the purpose of supporting
> powerpc platforms, as many do not encode user/kernel ownership of the
> page in the pte, but instead in the address of the access.
>
> [ajd@linux.ibm.com: rebase on arm64 changes]
> Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>  # x86
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
> v15: rebase
> ---
>   arch/arm64/include/asm/pgtable.h |  2 +-
>   arch/x86/include/asm/pgtable.h   |  2 +-
>   include/linux/page_table_check.h | 11 +++++++----
>   include/linux/pgtable.h          |  2 +-
>   mm/page_table_check.c            |  5 +++--
>   5 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 06ea6a4f300b..81f06e5e32b2 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1374,7 +1374,7 @@ static inline pte_t __ptep_get_and_clear_anysz(struct mm_struct *mm,
>   		break;
>   #ifndef __PAGETABLE_PMD_FOLDED
>   	case PUD_SIZE:
> -		page_table_check_pud_clear(mm, pte_pud(pte));
> +		page_table_check_pud_clear(mm, address, pte_pud(pte));
>   		break;
>   #endif
>   	default:
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 8ee301b16b50..8b45e0c41923 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1329,7 +1329,7 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
>   {
>   	pud_t pud = native_pudp_get_and_clear(pudp);
>   
> -	page_table_check_pud_clear(mm, pud);
> +	page_table_check_pud_clear(mm, addr, pud);
>   
>   	return pud;
>   }
> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
> index 66e109238416..808cc3a48c28 100644
> --- a/include/linux/page_table_check.h
> +++ b/include/linux/page_table_check.h
> @@ -16,7 +16,8 @@ extern struct page_ext_operations page_table_check_ops;
>   void __page_table_check_zero(struct page *page, unsigned int order);
>   void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte);
>   void __page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd);
> -void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud);
> +void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
> +				  pud_t pud);
>   void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
>   		pte_t *ptep, pte_t pte, unsigned int nr);
>   void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long addr,
> @@ -59,12 +60,13 @@ static inline void page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd)
>   	__page_table_check_pmd_clear(mm, pmd);
>   }
>   
> -static inline void page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
> +static inline void page_table_check_pud_clear(struct mm_struct *mm,
> +					      unsigned long addr, pud_t pud)
>   {
>   	if (static_branch_likely(&page_table_check_disabled))
>   		return;
>   
> -	__page_table_check_pud_clear(mm, pud);
> +	__page_table_check_pud_clear(mm, addr, pud);
>   }
>   
>   static inline void page_table_check_ptes_set(struct mm_struct *mm,
> @@ -123,7 +125,8 @@ static inline void page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd)
>   {
>   }
>   
> -static inline void page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
> +static inline void page_table_check_pud_clear(struct mm_struct *mm,
> +					      unsigned long addr, pud_t pud)
>   {
>   }
>   
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8aab3fa19c85..28fcff844b63 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -661,7 +661,7 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
>   	pud_t pud = *pudp;
>   
>   	pud_clear(pudp);
> -	page_table_check_pud_clear(mm, pud);
> +	page_table_check_pud_clear(mm, address, pud);
>   
>   	return pud;
>   }
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 0957767a2940..bd1242087a35 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -167,7 +167,8 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd)
>   }
>   EXPORT_SYMBOL(__page_table_check_pmd_clear);
>   
> -void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
> +void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
> +				  pud_t pud)
>   {
>   	if (&init_mm == mm)
>   		return;
> @@ -246,7 +247,7 @@ void __page_table_check_puds_set(struct mm_struct *mm, unsigned long addr,
>   		return;
>   
>   	for (i = 0; i < nr; i++)
> -		__page_table_check_pud_clear(mm, *(pudp + i));
> +		__page_table_check_pud_clear(mm, addr + PUD_SIZE * i, *(pudp + i));
>   	if (pud_user_accessible_page(pud))
>   		page_table_check_set(pud_pfn(pud), stride * nr, pud_write(pud));
>   }


So this made me realize we (riscv) did not implement 
pudp_huge_get_and_clear(), which was a mistake since we support THP PUD. 
I have implemented this function in this patch 
https://lore.kernel.org/all/20250814-dev-alex-thp_pud_xchg-v1-1-b4704dfae206@rivosinc.com/T/#u

That's a fix so I'll merge it in 6.17 (at least I'll try) so your 
patchset will break the build on riscv, I'll keep you posted when it 
gets merged!

Thanks,

Alex


