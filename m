Return-Path: <linux-kernel+bounces-768509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84542B261D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E86621E72
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F72F7461;
	Thu, 14 Aug 2025 10:01:26 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCA2264CF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165686; cv=none; b=Yu5cukXLVMhWgFjS+hhq6K7L2v7nHb4VAF4sOfW2utNBKI5zDdj86goslmEpYwIM1Yt8ydRA6Pvvddf+/eJw5QHLGQ5NhPnT+/DC0mVIAw9xpiNng4TVgLnmZcOkpPMefvo2ivgxsBtJJ4/bQ1xsd39o9w7LS03VrDknsh1DICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165686; c=relaxed/simple;
	bh=CXYXs0dPEYMhtU9PbUst0aP64RMhqEm11qe4bE8+W84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrETlwM8sBGO1Xwy0CmDjhUPiww/B/w4pMlCAJ0piNHYbGPq7TC0d2o//Sm1OW/FISZJN/BhuuDhm+E+BEB4DrBjNhdQrmH5uGBb5i8pkfsDaVUKLxKri1uOc99NCwLKXGDMLzArLjELARgs0H3WaQLvmiS3UZegrhI0OQRtLWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B06E43380;
	Thu, 14 Aug 2025 10:01:21 +0000 (UTC)
Message-ID: <ce64a10b-74ff-407f-a8a8-94c114f753bf@ghiti.fr>
Date: Thu, 14 Aug 2025 12:01:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 09/13] mm: Provide address parameter to
 p{te,md,ud}_user_accessible_page()
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Cc: akpm@linux-foundation.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
 sweettea-kernel@dorminy.me, nicholas@linux.ibm.com,
 christophe.leroy@csgroup.eu, Rohan McLure <rmclure@linux.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
References: <20250813062614.51759-1-ajd@linux.ibm.com>
 <20250813062614.51759-10-ajd@linux.ibm.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250813062614.51759-10-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvvddruddtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheprghjugeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehli
 hhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 8/13/25 08:26, Andrew Donnellan wrote:
> From: Rohan McLure <rmclure@linux.ibm.com>
>
> On several powerpc platforms, a page table entry may not imply whether
> the relevant mapping is for userspace or kernelspace. Instead, such
> platforms infer this by the address which is being accessed.
>
> Add an additional address argument to each of these routines in order to
> provide support for page table check on powerpc.
>
> [ajd@linux.ibm.com: rebase on arm64 changes]
> Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>  # x86
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
> v15: rebase
> ---
>   arch/arm64/include/asm/pgtable.h |  6 +++---
>   arch/riscv/include/asm/pgtable.h |  6 +++---
>   arch/x86/include/asm/pgtable.h   |  6 +++---
>   mm/page_table_check.c            | 12 ++++++------
>   4 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2203ebac81d9..254265e9a423 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1290,17 +1290,17 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
>   #endif
>   
>   #ifdef CONFIG_PAGE_TABLE_CHECK
> -static inline bool pte_user_accessible_page(pte_t pte)
> +static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
>   {
>   	return pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte));
>   }
>   
> -static inline bool pmd_user_accessible_page(pmd_t pmd)
> +static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long addr)
>   {
>   	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>   }
>   
> -static inline bool pud_user_accessible_page(pud_t pud)
> +static inline bool pud_user_accessible_page(pud_t pud, unsigned long addr)
>   {
>   	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
>   }
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index d60e1604852d..f3dd94929d58 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -817,17 +817,17 @@ static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
>   }
>   
>   #ifdef CONFIG_PAGE_TABLE_CHECK
> -static inline bool pte_user_accessible_page(pte_t pte)
> +static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
>   {
>   	return pte_present(pte) && pte_user(pte);
>   }
>   
> -static inline bool pmd_user_accessible_page(pmd_t pmd)
> +static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long addr)
>   {
>   	return pmd_leaf(pmd) && pmd_user(pmd);
>   }
>   
> -static inline bool pud_user_accessible_page(pud_t pud)
> +static inline bool pud_user_accessible_page(pud_t pud, unsigned long addr)
>   {
>   	return pud_leaf(pud) && pud_user(pud);
>   }
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 63350b76c0c6..b977cebb5f44 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1679,17 +1679,17 @@ static inline bool arch_has_hw_nonleaf_pmd_young(void)
>   #endif
>   
>   #ifdef CONFIG_PAGE_TABLE_CHECK
> -static inline bool pte_user_accessible_page(pte_t pte)
> +static inline bool pte_user_accessible_page(pte_t pte, unsigned long addr)
>   {
>   	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
>   }
>   
> -static inline bool pmd_user_accessible_page(pmd_t pmd)
> +static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long addr)
>   {
>   	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) && (pmd_val(pmd) & _PAGE_USER);
>   }
>   
> -static inline bool pud_user_accessible_page(pud_t pud)
> +static inline bool pud_user_accessible_page(pud_t pud, unsigned long addr)
>   {
>   	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) && (pud_val(pud) & _PAGE_USER);
>   }
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 1c33439b9c0b..abc2232ceb39 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -151,7 +151,7 @@ void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
>   	if (&init_mm == mm)
>   		return;
>   
> -	if (pte_user_accessible_page(pte)) {
> +	if (pte_user_accessible_page(pte, addr)) {
>   		page_table_check_clear(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT);
>   	}
>   }
> @@ -163,7 +163,7 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>   	if (&init_mm == mm)
>   		return;
>   
> -	if (pmd_user_accessible_page(pmd)) {
> +	if (pmd_user_accessible_page(pmd, addr)) {
>   		page_table_check_clear(pmd_pfn(pmd), PMD_SIZE >> PAGE_SHIFT);
>   	}
>   }
> @@ -175,7 +175,7 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>   	if (&init_mm == mm)
>   		return;
>   
> -	if (pud_user_accessible_page(pud)) {
> +	if (pud_user_accessible_page(pud, addr)) {
>   		page_table_check_clear(pud_pfn(pud), PUD_SIZE >> PAGE_SHIFT);
>   	}
>   }
> @@ -208,7 +208,7 @@ void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
>   
>   	for (i = 0; i < nr; i++)
>   		__page_table_check_pte_clear(mm, addr + PAGE_SIZE * i, ptep_get(ptep + i));
> -	if (pte_user_accessible_page(pte))
> +	if (pte_user_accessible_page(pte, addr))
>   		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
>   }
>   EXPORT_SYMBOL(__page_table_check_ptes_set);
> @@ -234,7 +234,7 @@ void __page_table_check_pmds_set(struct mm_struct *mm, unsigned long addr,
>   
>   	for (i = 0; i < nr; i++)
>   		__page_table_check_pmd_clear(mm, addr + PMD_SIZE * i, *(pmdp + i));
> -	if (pmd_user_accessible_page(pmd))
> +	if (pmd_user_accessible_page(pmd, addr))
>   		page_table_check_set(pmd_pfn(pmd), stride * nr, pmd_write(pmd));
>   }
>   EXPORT_SYMBOL(__page_table_check_pmds_set);
> @@ -250,7 +250,7 @@ void __page_table_check_puds_set(struct mm_struct *mm, unsigned long addr,
>   
>   	for (i = 0; i < nr; i++)
>   		__page_table_check_pud_clear(mm, addr + PUD_SIZE * i, *(pudp + i));
> -	if (pud_user_accessible_page(pud))
> +	if (pud_user_accessible_page(pud, addr))
>   		page_table_check_set(pud_pfn(pud), stride * nr, pud_write(pud));
>   }
>   EXPORT_SYMBOL(__page_table_check_puds_set);


Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks,

Alex


