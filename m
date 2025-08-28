Return-Path: <linux-kernel+bounces-790372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EBDB3A631
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA41C23397
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B9322A00;
	Thu, 28 Aug 2025 16:26:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F230ACF7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398367; cv=none; b=geVq3uEjBDO7m/3bsC/vy3TFhUORqRAGBWQ/ABbfqkh1eozp/wzhcjUsoZYQUo1poJLmMFL1B3T+0fsyt4KhR7LgcC9+NuJ85U6ooRSF7wSDy/S3U0vtN2VaKx6C6uxbB95q9NeC9H5uZi9rj9/IMT+J7OH3nsWkOt0qbXxdLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398367; c=relaxed/simple;
	bh=QJo8kDgZqI4y2bkdKil84w5i19JgGLFIOhkmDloZCDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT/9QGRDBwddlrX7Z9uhNN9kMMVPimShIBIuoPZ+ILxj1cYDvH6yf7yrLZnRkt3RjSrF5E0b4W8AGdcsU++TXSMABupQKsbDZUYs0jxGXmpvwiwSjfNa24KA/nYlPyDBlsGoACruxCDHojFgPrbGylOw45QF9EUKEKGE31xg5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F137C4CEEB;
	Thu, 28 Aug 2025 16:26:04 +0000 (UTC)
Date: Thu, 28 Aug 2025 17:26:02 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
	akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
	dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 1/4] arm64: Enable permission change on arm64
 kernel block mappings
Message-ID: <aLCDGlobH1wG8iqx@arm.com>
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805081350.3854670-2-ryan.roberts@arm.com>

On Tue, Aug 05, 2025 at 09:13:46AM +0100, Ryan Roberts wrote:
> From: Dev Jain <dev.jain@arm.com>
> 
> This patch paves the path to enable huge mappings in vmalloc space and
> linear map space by default on arm64. For this we must ensure that we
> can handle any permission games on the kernel (init_mm) pagetable.
> Currently, __change_memory_common() uses apply_to_page_range() which
> does not support changing permissions for block mappings. We attempt to
> move away from this by using the pagewalk API, similar to what riscv
> does right now; however, it is the responsibility of the caller to
> ensure that we do not pass a range overlapping a partial block mapping
> or cont mapping; in such a case, the system must be able to support
> range splitting.
> 
> This patch is tied with Yang Shi's attempt [1] at using huge mappings in
> the linear mapping in case the system supports BBML2, in which case we
> will be able to split the linear mapping if needed without
> break-before-make. Thus, Yang's series, IIUC, will be one such user of
> my patch; suppose we are changing permissions on a range of the linear
> map backed by PMD-hugepages, then the sequence of operations should look
> like the following:
> 
> split_range(start)
> split_range(end);
> __change_memory_common(start, end);
> 
> However, this patch can be used independently of Yang's; since currently
> permission games are being played only on pte mappings (due to
> apply_to_page_range not supporting otherwise), this patch provides the
> mechanism for enabling huge mappings for various kernel mappings like
> linear map and vmalloc.
[...]

I think some of this text needs to be trimmed down, avoid references to
other series if they are merged at the same time.

> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index 682472c15495..8212e8f2d2d5 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -134,6 +134,9 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>  int walk_kernel_page_table_range(unsigned long start,
>  		unsigned long end, const struct mm_walk_ops *ops,
>  		pgd_t *pgd, void *private);
> +int walk_kernel_page_table_range_lockless(unsigned long start,
> +		unsigned long end, const struct mm_walk_ops *ops,
> +		void *private);
>  int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end, const struct mm_walk_ops *ops,
>  			void *private);
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 648038247a8d..18a675ab87cf 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -633,6 +633,30 @@ int walk_kernel_page_table_range(unsigned long start, unsigned long end,
>  	return walk_pgd_range(start, end, &walk);
>  }
>  
> +/*
> + * Use this function to walk the kernel page tables locklessly. It should be
> + * guaranteed that the caller has exclusive access over the range they are
> + * operating on - that there should be no concurrent access, for example,
> + * changing permissions for vmalloc objects.
> + */
> +int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end,
> +		const struct mm_walk_ops *ops, void *private)
> +{
> +	struct mm_walk walk = {
> +		.ops		= ops,
> +		.mm		= &init_mm,
> +		.private	= private,
> +		.no_vma		= true
> +	};
> +
> +	if (start >= end)
> +		return -EINVAL;
> +	if (!check_ops_valid(ops))
> +		return -EINVAL;
> +
> +	return walk_pgd_range(start, end, &walk);
> +}

More of a nit: we could change walk_kernel_page_table_range() to call
this function after checking the mm lock as they look nearly identical.
The existing function has a pgd argument but it doesn't seem to be used
anywhere and could be removed (or add it here for consistency).

Either way, the patch looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

