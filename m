Return-Path: <linux-kernel+bounces-846242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E4BC75B4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7DA94E506C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42555244684;
	Thu,  9 Oct 2025 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uQa7EfYx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B61F2B88
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759983435; cv=none; b=JHRHfOSBWaP6BSl3bXRh7RfT0lcVhPR3u2+1HjiNzmMqW5y6A/zHPnLb7QJZJdpLg/lVJ6bc9Cp8ODMAyq/ABFFafO3f/QUxezaYqNpjk1NEaDPCnY2oLtgMjErjX3JfBhugiolvQ4lhLBvNGkbkX8eafEj4pFpp9un5YtyCzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759983435; c=relaxed/simple;
	bh=3uG/Vs/0psPbLhiDn8iBOyy3csJVGPxngDZ9WLc2d2U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GV5rf+UtN8+ycl5N6mBvBNa+WJLX9HjMo98n0AlGL3rzxd9W9h4KPduLmZNZp2kmVEXg0M/oR2VkWjFO+jDWhnhTA2/8V/9tRDB9ziJd2YodWHt6viT5itmxgbpnXjYnYQmCtjzb7sz2ROndlu8Pk7JAeUnR9zhQ48kG67pw0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uQa7EfYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B67C4CEE7;
	Thu,  9 Oct 2025 04:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759983435;
	bh=3uG/Vs/0psPbLhiDn8iBOyy3csJVGPxngDZ9WLc2d2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQa7EfYx+Z7ahsddpGbj6XGhDKy2ExftXPTZ1vR+AXbdfB5egqQyvwH4Hl4rg/jXD
	 F+IU56sCCYgMpZ/5cQnza9ud0LbmMXB3F8x4CD0wVHNYZ+V0PH73Ycl+aCH3bXKGjP
	 yjn2gziGhnryGoY4+jS8lrQv/OSD4Ks/w/XRQpKY=
Date: Wed, 8 Oct 2025 21:17:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yadong Qi <yadong.qi@linux.alibaba.com>
Cc: urezki@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ying.huang@linux.alibaba.com
Subject: Re: [PATCH] mm: vmalloc: BUG_ON if mapping size is not PAGE_SIZE
 aligned
Message-Id: <20251008211714.5a8b9fbb57dbe454cd4a9c6d@linux-foundation.org>
In-Reply-To: <20251009035943.526-1-yadong.qi@linux.alibaba.com>
References: <20251009035943.526-1-yadong.qi@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Oct 2025 11:59:43 +0800 Yadong Qi <yadong.qi@linux.alibaba.com> wrote:

> In mm/vmalloc.c, the function vmap_pte_range() assumes that the
> mapping size is aligned to PAGE_SIZE. If this assumption is
> violated, the loop will become infinite because the termination
> condition (`addr != end`) will never be met. This can lead to
> overwriting other VA ranges and/or random pages physically follow
> the page table.
> 
> It's the caller's responsibility to ensure that the mapping size
> is aligned to PAGE_SIZE. However, the memory corruption is hard
> to root cause. To identify the programming error in the caller
> easier, check whether the mapping size is PAGE_SIZE aligned with
> BUG_ON().
> 
> ..
>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -100,6 +100,8 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	struct page *page;
>  	unsigned long size = PAGE_SIZE;
>  
> +	BUG_ON(!PAGE_ALIGNED(end - addr));
> +
>  	pfn = phys_addr >> PAGE_SHIFT;
>  	pte = pte_alloc_kernel_track(pmd, addr, mask);
>  	if (!pte)

We try to avoid adding BUG()s - deliberately crashing the kernel is
pretty cruel to the user.  It's far better to WARN and to continue in
some fashion so the user can at least gather logs, etc.

How about

	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
		return -ENOMEM;

?

(Or VM_WARN_ON)

