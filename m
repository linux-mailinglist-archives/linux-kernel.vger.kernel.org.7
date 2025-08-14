Return-Path: <linux-kernel+bounces-769287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D67B26C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8A07BB572
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBA424C664;
	Thu, 14 Aug 2025 16:23:03 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE121B9FC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188582; cv=none; b=EjSOQKi7Wf3rJYS3aGdUbTn4GL6M6kfxpH0xvGk2k5TvPBkQk4DcgJB8+r5mKVT0nV/Derl70QjLVHicHRpxxfepNQd2dMwAqk4WjyRs/G/DY2nbxnVdsss5kOIB4d+lQBg1NGEw/Ccit2m65e/pQ4Ho8y45/6uoy+NVlhiepCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188582; c=relaxed/simple;
	bh=jBLr9Jhg3pgGs3rbuX+2ChmDvIVm0JqTYULalpYUT58=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDEhJ7r6YqHhaQSkYNV/9lsz3gJszkA+TAbIDGQQivszSsZd3QCJDj/8qZTQVB50XEx6XVCOeH2XCS20kYx+IhdtP78z5B/mrESAB9+hStP/bnibluKv660JcnJO71K0gZxvlplr78ZvR4xzUQ6RajS5A780Rd9gE/6Rxy/j+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c2r7K1ch5z6L4wB;
	Fri, 15 Aug 2025 00:20:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AD6E714010C;
	Fri, 15 Aug 2025 00:22:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 14 Aug
 2025 18:22:57 +0200
Date: Thu, 14 Aug 2025 17:22:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, "Yang
 Shi" <yang@os.amperecomputing.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kevin Brodsky
	<kevin.brodsky@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Zhenhua Huang
	<quic_zhenhuah@quicinc.com>, Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH 1/2] arm64/mm: Allow __create_pgd_mapping() to propagate
 pgtable_alloc() errors
Message-ID: <20250814172255.000039ca@huawei.com>
In-Reply-To: <20250813145607.1612234-2-chaitanyas.prakash@arm.com>
References: <20250813145607.1612234-1-chaitanyas.prakash@arm.com>
	<20250813145607.1612234-2-chaitanyas.prakash@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 13 Aug 2025 20:26:06 +0530
Chaitanya S Prakash <chaitanyas.prakash@arm.com> wrote:

> arch_add_memory() is used to hotplug memory into a system but as a part
> of its implementation it calls __create_pgd_mapping(), which uses
> pgtable_alloc() in order to build intermediate page tables. As this path
> was initally only used during early boot pgtable_alloc() is designed to
> BUG_ON() on failure. However, in the event that memory hotplug is
> attempted when the system's memory is extremely tight and the allocation
> were to fail, it would lead to panicking the system, which is not
> desirable. Hence update __create_pgd_mapping and all it's callers to be
> non void and propagate -ENOMEM on allocation failure to allow system to
> fail gracefully.
> 
> But during early boot if there is an allocation failure, we want the
> system to panic, hence create a wrapper around __create_pgd_mapping()
> called ___create_pgd_mapping() which is designed to BUG_ON(ret), if ret
> is non zero value. All the init calls are updated to use the wrapper
> rather than the modified __create_pgd_mapping() to restore
> functionality.
> 
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 156 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 117 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 00ab1d648db62..db7f45ef16574 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -196,12 +196,13 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  	} while (ptep++, addr += PAGE_SIZE, addr != end);
>  }
>  
> -static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> +static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  				unsigned long end, phys_addr_t phys,
>  				pgprot_t prot,
>  				phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>  				int flags)
>  {
> +	int ret = 0;
>  	unsigned long next;
>  	pmd_t pmd = READ_ONCE(*pmdp);
>  	pte_t *ptep;
> @@ -215,6 +216,10 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  			pmdval |= PMD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pte_phys = pgtable_alloc(TABLE_PTE);
> +		if (!pte_phys) {
> +			ret = -ENOMEM;

return -ENOMEM;

When I saw this I wondered if local style was to always exit at the end of
functions, but it isn't so early returns should be fine and simplify this
a fair bit.

> +			goto out;
> +		}
>  		ptep = pte_set_fixmap(pte_phys);
>  		init_clear_pgtable(ptep);
>  		ptep += pte_index(addr);
> @@ -246,12 +251,16 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  	 * walker.
>  	 */
>  	pte_clear_fixmap();
> +
> +out:
> +	return ret;

	return 0;

>  }
>  
> -static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
> +static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		     phys_addr_t phys, pgprot_t prot,
>  		     phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
>  {
> +	int ret = 0;
>  	unsigned long next;
>  
>  	do {
> @@ -271,22 +280,27 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  			BUG_ON(!pgattr_change_is_safe(pmd_val(old_pmd),
>  						      READ_ONCE(pmd_val(*pmdp))));
>  		} else {
> -			alloc_init_cont_pte(pmdp, addr, next, phys, prot,
> -					    pgtable_alloc, flags);
> +			ret = alloc_init_cont_pte(pmdp, addr, next, phys, prot,
> +						  pgtable_alloc, flags);
> +			if (ret)
> +				break;

	return ret;

>  
>  			BUG_ON(pmd_val(old_pmd) != 0 &&
>  			       pmd_val(old_pmd) != READ_ONCE(pmd_val(*pmdp)));
>  		}
>  		phys += next - addr;
>  	} while (pmdp++, addr = next, addr != end);
> +
> +	return ret;
return 0;

Same in the other cases where there is nothing else to do and they are simply
early error returns.


>  }

>  
> -static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> +static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  				 unsigned long virt, phys_addr_t size,
>  				 pgprot_t prot,
>  				 phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>  				 int flags)
>  {
> +	int ret = 0;
> +
>  	mutex_lock(&fixmap_lock);
> -	__create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
> -				    pgtable_alloc, flags);
> +	ret = __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
> +					  pgtable_alloc, flags);
>  	mutex_unlock(&fixmap_lock);

Could use guard(mutex)(&fixmap_lock);
but maybe not worth introducing that stuff just to simplify this.

> +
> +	return ret;
> +}
> +
> +static void ___create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> +				  unsigned long virt, phys_addr_t size,
> +				  pgprot_t prot,
> +				  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +				  int flags)
> +{
> +	int ret = 0;
> +
> +	ret = __create_pgd_mapping(pgdir, phys, virt, size, prot, pgtable_alloc,
> +				   flags);
> +	BUG_ON(ret);
>  }
>  
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> @@ -485,9 +553,11 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>  {
>  	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
>  	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> -	phys_addr_t pa;
> +	phys_addr_t pa = 0;
> +
> +	if (!ptdesc)
> +		goto out;

I'd return 0 here.
>  
> -	BUG_ON(!ptdesc);
>  	pa = page_to_phys(ptdesc_page(ptdesc));
>  
>  	switch (pgtable_type) {
> @@ -505,6 +575,7 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>  		break;
>  	}
>  
> +out:
>  	return pa;
>  }
>  
> @@ -533,8 +604,8 @@ void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
>  			&phys, virt);
>  		return;
>  	}
> -	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> -			     NO_CONT_MAPPINGS);
> +	___create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> +			      NO_CONT_MAPPINGS);
>  }
>  
> @@ -1369,23 +1440,30 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (can_set_direct_map())
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> -	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> -			     size, params->pgprot, pgd_pgtable_alloc_init_mm,
> -			     flags);
> +	ret = __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> +				   size, params->pgprot, pgd_pgtable_alloc_init_mm,
> +				   flags);
> +
> +	if (ret)
> +		goto out;
>  
>  	memblock_clear_nomap(start, size);
>  
>  	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
>  			   params);
> -	if (ret)
> -		__remove_pgd_mapping(swapper_pg_dir,
> -				     __phys_to_virt(start), size);
> -	else {
> +	if (ret) {
> +		goto out;
> +	} else {
>  		/* Address of hotplugged memory can be smaller */
>  		max_pfn = max(max_pfn, PFN_UP(start + size));
>  		max_low_pfn = max_pfn;
>  	}
>  
> +	return 0;
> +
> +out:
> +	__remove_pgd_mapping(swapper_pg_dir,
> +			      __phys_to_virt(start), size);
This one is fine as common cleanup to do.

Jonathan

>  	return ret;
>  }
>  


