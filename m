Return-Path: <linux-kernel+bounces-822557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939B7B8421C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351D2188115B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5E2F549E;
	Thu, 18 Sep 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm9RBWiC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEE2868AF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191620; cv=none; b=R9dIB8hr8ysqTYGNWJJPI6e8mdtAiy/X8US306fg/NC5bRAc0+506E6TIcc3r1yeJoQlpqC2ShSS0PcmNwyoWFvf/k1RsP/oJUAAOTwSlwXX3GMZo438L5YKadw5OuzS7AXRMX8kgx4MU46IvaJ10D6hvju1r21gSIUmK5Nqnwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191620; c=relaxed/simple;
	bh=TVVwkNO7iGB7t5rAzhUJHNIbjpPOZCjci5g14ssAF1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfkF/l22HjagQs0wyRoPKj8LsGhzDcsJeoggtWvqB6bJZTd8lwqqC4wNV/scjE97DnRqyRpVrtyVY5rMEPXcWN1rfLjHtdtAM2Y7GhCmSDfk3WO+zOo/sFpXAWbj0PKXCbcRDK1UMHD0CkPZwAV+yge50r7zvRFrVuMLDtoEE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm9RBWiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E100C4CEE7;
	Thu, 18 Sep 2025 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191619;
	bh=TVVwkNO7iGB7t5rAzhUJHNIbjpPOZCjci5g14ssAF1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qm9RBWiCNRRPZwoAE/MGVvcH1Fb0Bq5Z4VYyttWdudvb2XA3c15rpA8dayNhJTmUa
	 WNyM7eDlgDYa4S5PYFDRhR9bf89NkOoLmgy62i3y7aIpt3H2QeEXuEpwRX2w6ft4Ia
	 mAy0zTswlIo2jcv1xq/37MZNbvndohUPQTV6gNGXj+zj/8zpI2s8EJU7Gz46n+4fKs
	 +hIpY7IKelaY2ulXUQRL5H1nMWAFaIfYUb8xvZtt0cnXzP80i+SgENOLx4OsCPvxvI
	 4oj3coRJv6+0ENBXpkuR0kBSE7Luhf587W4eu/ohVWswm934fBm/qIsHgCppYefjcS
	 7RMb12iu8M4gA==
Date: Thu, 18 Sep 2025 13:33:33 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove PMD alignment constraint in execmem_vmalloc()
Message-ID: <aMvf_R4ttLibbnQ1@kernel.org>
References: <20250918093453.75676-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918093453.75676-1-dev.jain@arm.com>

On Thu, Sep 18, 2025 at 03:04:53PM +0530, Dev Jain wrote:
> When using vmalloc with VM_ALLOW_HUGE_VMAP flag, it will set the alignment
> to PMD_SIZE internally, if it deems huge mappings to be eligible.
> Therefore, setting the alignment in execmem_vmalloc is redundant. Apart
> from this, it also reduces the probability of allocation in case vmalloc
> fails to allocate hugepages - in the fallback case, vmalloc tries to use
> the original alignment and allocate basepages, which unfortunately will
> again be PMD_SIZE passed over from execmem_vmalloc, thus constraining
> the search for a free space in vmalloc region.
> 
> Therefore, remove this constraint.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> mm-selftests pass, but I am not sure if they touch execmem code, and I
> have no experience with this code.
> 
>  mm/execmem.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 0822305413ec..810a4ba9c924 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -38,9 +38,6 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
>  	if (kasan)
>  		vm_flags |= VM_DEFER_KMEMLEAK;
>  
> -	if (vm_flags & VM_ALLOW_HUGE_VMAP)
> -		align = PMD_SIZE;
> -
>  	p = __vmalloc_node_range(size, align, start, end, gfp_flags,
>  				 pgprot, vm_flags, NUMA_NO_NODE,
>  				 __builtin_return_address(0));
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.

