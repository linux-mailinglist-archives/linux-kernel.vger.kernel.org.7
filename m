Return-Path: <linux-kernel+bounces-741471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75567B0E489
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E1A3B1933
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17212820B2;
	Tue, 22 Jul 2025 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OZ95R17l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91921FF3E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214843; cv=none; b=I6Rp4+HTNTt6myrS88bdCLtjrjxI8Z96ppG9X8OiJCtIVvz0UY4ctOhQ4ZVfaUACdLSotHDblS2D2wjcu2+z6oMgFbbsrIWE2YIGJ2Em0IG3Rie2ge2Z9j0MDNA049iVhXxiIP/tej/aQbjyTzi9nh/KrhGQtsXt0a/97MAzIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214843; c=relaxed/simple;
	bh=A9U10LdyLRNTz78nkxw/9fL65JMOLX7O4NaZFljiv6s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F+O/g6UxBjiySOns8RRp0URo2D8I+hJKnteEhBJmw5brypURZRbeGSxZsjK2i+KH+MF36keDH2t+bpbTQ1v+OMtkybv+yI4J+SFPR7gbuQCb8x1WLxvF6c4Pd025r6dvmkPdOyLxxj5ywHC/0hDAk6/09XhD/ndB5iqnQNhiEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OZ95R17l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4B1C4CEEB;
	Tue, 22 Jul 2025 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753214842;
	bh=A9U10LdyLRNTz78nkxw/9fL65JMOLX7O4NaZFljiv6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZ95R17ljE7FLT7YxbnUbAL7zPf2GHea6OsnFTItLRRuwg8bfXeNCg+KkVV9PSB6+
	 Ln6BhMG6sYRxWR0tTHq+NkHiVGCQPDy5X9NX9HwmcVAf4DVjGHt0pUK96NXlTpGtQP
	 oP5DcJl4eR1LKWv4rd+hL02r3116GUoKCW5eRqnY=
Date: Tue, 22 Jul 2025 13:07:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Francois Dugast <francois.dugast@intel.com>
Cc: balbirs@nvidia.com, airlied@gmail.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, dakr@kernel.org,
 david@redhat.com, donettom@linux.ibm.com, jane.chu@oracle.com,
 jglisse@redhat.com, kherbst@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lyude@redhat.com, matthew.brost@intel.com,
 peterx@redhat.com, ryan.roberts@arm.com, shuah@kernel.org, simona@ffwll.ch,
 wangkefeng.wang@huawei.com, willy@infradead.org, ziy@nvidia.com
Subject: Re: [PATCH] mm/hmm: Do not fault in device private pages owned by
 the caller
Message-Id: <20250722130721.9169d564eeeb28807e18635a@linux-foundation.org>
In-Reply-To: <20250722193445.1588348-1-francois.dugast@intel.com>
References: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
	<20250722193445.1588348-1-francois.dugast@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 21:34:45 +0200 Francois Dugast <francois.dugast@intel.com> wrote:

> When the PMD swap entry is device private and owned by the caller,
> skip the range faulting and instead just set the correct HMM PFNs.
> This is similar to the logic for PTEs in hmm_vma_handle_pte().

Please always tell us why a patch does something, not only what it does.

> For now, each hmm_pfns[i] entry is populated as it is currently done
> in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
> optimization could be to make use of the order and skip populating
> subsequent PFNs.

I infer from this paragraph that this patch is a performance
optimization?  Have its effects been measured?

> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -355,6 +355,31 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  	}
>  
>  	if (!pmd_present(pmd)) {
> +		swp_entry_t entry = pmd_to_swp_entry(pmd);
> +
> +		/*
> +		 * Don't fault in device private pages owned by the caller,
> +		 * just report the PFNs.
> +		 */

Similarly, this tells us "what" it does, which is fairly obvious from
the code itself.  What is not obvious from the code is the "why".

> +		if (is_device_private_entry(entry) &&
> +		    pfn_swap_entry_folio(entry)->pgmap->owner ==
> +		    range->dev_private_owner) {
> +			unsigned long cpu_flags = HMM_PFN_VALID |
> +				hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
> +			unsigned long pfn = swp_offset_pfn(entry);
> +			unsigned long i;
> +
> +			if (is_writable_device_private_entry(entry))
> +				cpu_flags |= HMM_PFN_WRITE;
> +
> +			for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> +				hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> +				hmm_pfns[i] |= pfn | cpu_flags;
> +			}
> +
> +			return 0;
> +		}
> +
>  		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
>  			return -EFAULT;
>  		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);


