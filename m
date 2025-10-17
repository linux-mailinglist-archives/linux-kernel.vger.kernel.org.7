Return-Path: <linux-kernel+bounces-858563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94EBEB267
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88E094E5C29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3631DD9B;
	Fri, 17 Oct 2025 18:06:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A28299A85
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724381; cv=none; b=VvLUfIyLClsLPBuWsVOpCaw284s9G408OI9GOSxpuF4v8hvS6FB7XEDUgsbUrFkmMpmt8eXSwiKedljSrodqPEw3OpczamMn5J4mAUdvl/taUgrKsm/Oy3eEo/CfLhMeM7oQ4ijaELRsemNNIpcU2S1v1Qfc+rYCoZQWon1hERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724381; c=relaxed/simple;
	bh=PRpIF8coTvyiXK1iielJL7vqdi95WfSextDIfNHf+BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IazHa0/i3Qkznr8SwkvmjADhjtL1N/HTKoDq/Rc8ocBpljvs5S2PG6waVB5Cx6Nq2EQpDkaPJOrYE6ROjf/BmFr+KKpAwPDjDdGEkeQriFAqw7GPqsTFmVhYUeZfYgIeQibW/GqPiMskAgHfRef1bxttRqGCYIGPmSXGRGzrYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76468C4CEE7;
	Fri, 17 Oct 2025 18:06:19 +0000 (UTC)
Date: Fri, 17 Oct 2025 19:06:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Gavin Shan <gshan@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] arm64, mm: avoid always making PTE dirty in pte_mkwrite()
Message-ID: <aPKFmHg-FrkGJxWd@arm.com>
References: <20251015023712.46598-1-ying.huang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015023712.46598-1-ying.huang@linux.alibaba.com>

On Wed, Oct 15, 2025 at 10:37:12AM +0800, Huang Ying wrote:
> Current pte_mkwrite_novma() makes PTE dirty unconditionally.  This may
> mark some pages that are never written dirty wrongly.  For example,
> do_swap_page() may map the exclusive pages with writable and clean PTEs
> if the VMA is writable and the page fault is for read access.
> However, current pte_mkwrite_novma() implementation always dirties the
> PTE.  This may cause unnecessary disk writing if the pages are
> never written before being reclaimed.
> 
> So, change pte_mkwrite_novma() to clear the PTE_RDONLY bit only if the
> PTE_DIRTY bit is set to make it possible to make the PTE writable and
> clean.
> 
> The current behavior was introduced in commit 73e86cb03cf2 ("arm64:
> Move PTE_RDONLY bit handling out of set_pte_at()").  Before that,
> pte_mkwrite() only sets the PTE_WRITE bit, while set_pte_at() only
> clears the PTE_RDONLY bit if both the PTE_WRITE and the PTE_DIRTY bits
> are set.
> 
> To test the performance impact of the patch, on an arm64 server
> machine, run 16 redis-server processes on socket 1 and 16
> memtier_benchmark processes on socket 0 with mostly get
> transactions (that is, redis-server will mostly read memory only).
> The memory footprint of redis-server is larger than the available
> memory, so swap out/in will be triggered.  Test results show that the
> patch can avoid most swapping out because the pages are mostly clean.
> And the benchmark throughput improves ~23.9% in the test.
> 
> Fixes: 73e86cb03cf2 ("arm64: Move PTE_RDONLY bit handling out of set_pte_at()")
> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Yicong Yang <yangyicong@hisilicon.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm64/include/asm/pgtable.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index aa89c2e67ebc..0944e296dd4a 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -293,7 +293,8 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
>  static inline pte_t pte_mkwrite_novma(pte_t pte)
>  {
>  	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
> -	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
> +	if (pte_sw_dirty(pte))
> +		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
>  	return pte;
>  }

This seems to be the right thing. I recall years ago I grep'ed
(obviously not hard enough) and most pte_mkwrite() places had a
pte_mkdirty(). But I missed do_swap_page() and possibly others.

For this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I wonder whether we should also add (as a separate patch):

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 830107b6dd08..df1c552ef11c 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -101,6 +101,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
 	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
 	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
+	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
 	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
 }

For completeness, also (and maybe other combinations):

	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));

I cc'ed linux-mm in case we missed anything. If nothing raised, I'll
queue it next week.

Thanks.

-- 
Catalin

