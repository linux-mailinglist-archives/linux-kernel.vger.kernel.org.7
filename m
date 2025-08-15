Return-Path: <linux-kernel+bounces-770855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE24B27FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353DB1BC416C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364730100E;
	Fri, 15 Aug 2025 12:00:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A13002D5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259215; cv=none; b=NrkJWhGtQEJ+N8hhMrDBEMhIHqp1tFzPNBoUF0Ox9tgof+0fLC/D54Sv4Z5484KpoQpJgmBQ1+QmrjC3LaZK/yTaRQYJrO/gZxAoWfuIjjV15seT68y+4qwm+x4hP3grCEAPVprsuCSsRcYM8MTtmDECaNXH3zpnuApRcO5Z5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259215; c=relaxed/simple;
	bh=LMzVDr/shl8HO8Hn1wYHasxEqupCk2HZVfOT2KMky0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usiJD1aTkhC60EWWlHXVLfHgVznGvzV8kT3sA1fBkwKXiZSzE2y8kbrH/dJyxDFXsdbcqwWn6VegRBiqVaQYFGtwAVVdBfhfQkpCD+/ZUrr0RPt9jvyDmV4iHdkxlhk8njtLB4RkEWRv7d3G06FT6QdnyBxNZvtDZihSUZtVPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B3531691;
	Fri, 15 Aug 2025 05:00:05 -0700 (PDT)
Received: from [10.57.56.228] (unknown [10.57.56.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4A373F738;
	Fri, 15 Aug 2025 05:00:09 -0700 (PDT)
Message-ID: <34ce1000-8d15-4d7e-bf67-11e2bcd135a5@arm.com>
Date: Fri, 15 Aug 2025 14:00:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64/mm: Update create_kpti_ng_temp_pgd() to handle
 pgtable_alloc failure
To: Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Joey Gouly <joey.gouly@arm.com>
References: <20250813145607.1612234-1-chaitanyas.prakash@arm.com>
 <20250813145607.1612234-3-chaitanyas.prakash@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20250813145607.1612234-3-chaitanyas.prakash@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2025 16:56, Chaitanya S Prakash wrote:
> create_kpti_ng_temp_pgd() was created as an alias for void returning
> __create_pgd_mapping_locked() and relied on pgtable_alloc() to BUG_ON()
> if an allocation failure occurred. But as __create_pgd_mapping_locked()
> has been updated as a part of the error propagation patch to return a
> non-void value, update create_kpti_ng_temp_pgd() to act as a wrapper
> around __create_pgd_mapping_locked() and BUG_ON() on ret being a non
> zero value.
>
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index db7f45ef16574..19cbabceb38bd 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -76,6 +76,14 @@ EXPORT_SYMBOL(empty_zero_page);
>  static DEFINE_SPINLOCK(swapper_pgdir_lock);
>  static DEFINE_MUTEX(fixmap_lock);
>  
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys,
> +			     unsigned long virt, phys_addr_t size,
> +			     pgprot_t prot,
> +			     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			     int flags);

I'm not sure I understand why we'd now need this declaration?

That function should really be declared in some header instead of the
strange declaration in cpufeature.c, but that's unrelated to this patch.

- Kevin

> +#endif
> +
>  void noinstr set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
>  	pgd_t *fixmap_pgdp;
> @@ -541,11 +549,17 @@ static void ___create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  }
>  
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> -extern __alias(__create_pgd_mapping_locked)
>  void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>  			     phys_addr_t size, pgprot_t prot,
>  			     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> -			     int flags);
> +			     int flags)
> +{
> +	int ret = 0;
> +
> +	ret = __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
> +					  pgtable_alloc, flags);
> +	BUG_ON(ret);
> +}
>  #endif
>  
>  static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,

