Return-Path: <linux-kernel+bounces-843182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A694EBBE93A
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2C974EFB8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783662D6E49;
	Mon,  6 Oct 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7qGExnU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1934BA37
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766517; cv=none; b=hxt2CoEZxcOYnZ1TCmCde7N4DSlQ+a/46Q78h+SBYIabnPiDPsPkoBUiIG6rGG29I4lXwtCgqSkxXZrGOYuV6+JS3SAFna1Hua4XPKI6+KTo0DpwPRi9fgh2CcijG4c+jl99GoAmpdCJyVVfP1wx4bWqHuy0xsJgDq7L7rIWV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766517; c=relaxed/simple;
	bh=gK0gwx/5nj8BxIOYpHUVKbNTrU6HPqVCyFo2NZIq2+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPwzjK8zF7sA+cIVNY7n1kvtggukklSbdE9jOP6ZT2iGoUuIdzZpFfWNQWc5mydJ8vHsbEVmnAgMrSkhji23YATuG38F9JXJXhBBnr2ztrbZTc1av5vVP2sem0q7qe8RSuHb/etJfXXNdeVq7ZSAdjtBfMfMoM6lGV4vm66DHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7qGExnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8C5C4CEF5;
	Mon,  6 Oct 2025 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759766517;
	bh=gK0gwx/5nj8BxIOYpHUVKbNTrU6HPqVCyFo2NZIq2+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7qGExnUygst8ikG9goN/tgOsUmyvjcgYxBGRVWOScnCNadcuWzvwAYa7xl0hNNqK
	 KCIeWJ5pJBUx7TxT8eJre9GkPzR8APx6WUmv7D/2djvoMp0qow9OhHqZjXr9opb93i
	 Ixks72TZ16TA6qZTuhTLIIXGXIo4fnfaG7uI0kDZPgDJ3O78gf73gNIbPd+QZqXG7V
	 AniUAE9YhLTxC4KJTHcDvdM8u4sbnz4brrxJzUpjVCqMdq2ejlACdLz9KdqVek2Zkk
	 zWJc+R3wkToxIbdNF3H01Mt+H1tBxGJuDZWVgZA79AukmuWmddv8zBwC1AfGBLeYnt
	 2FUCERGgr0lhA==
Date: Mon, 6 Oct 2025 18:01:53 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: =?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Melissa Wen <mwen@igalia.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, =?utf-8?Q?Miko=C5=82aj?= Wasiak <mikolaj.wasiak@intel.com>, 
	Christian Brauner <brauner@kernel.org>, Nitin Gote <nitin.r.gote@intel.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Christopher Healy <healych@amazon.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-mm@kvack.org, kernel@collabora.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 01/10] drm/shmem-helper: Add huge page fault handler
Message-ID: <fbfii7x7ypvbsowp63zuayzykqmpjpdjvzjdpyswwhfttuwemd@wbs7qxp5zie6>
References: <20251004093054.21388-1-loic.molinari@collabora.com>
 <20251004093054.21388-2-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004093054.21388-2-loic.molinari@collabora.com>

Hi Loic,

...

> +					   unsigned int order)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct drm_gem_object *obj = vma->vm_private_data;
> @@ -582,6 +583,10 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>  	vm_fault_t ret;

we could initialize ret to VM_FAULT_FALLBACK and avoid the else's
and the default case.

>  	struct page *page;
>  	pgoff_t page_offset;
> +	unsigned long pfn;
> +#if defined(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) || defined(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP)
> +	unsigned long paddr;
> +#endif

we could declare paddr inside the switch case in order to avoid
some extra ifdefs.

>  	/* We don't use vmf->pgoff since that has the fake offset */
>  	page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> @@ -592,17 +597,57 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>  	    drm_WARN_ON_ONCE(obj->dev, !shmem->pages) ||
>  	    shmem->madv < 0) {
>  		ret = VM_FAULT_SIGBUS;
> -	} else {
> -		page = shmem->pages[page_offset];
> +		goto out;
> +	}
>  
> -		ret = vmf_insert_pfn(vma, vmf->address, page_to_pfn(page));
> +	page = shmem->pages[page_offset];
> +	pfn = page_to_pfn(page);
> +
> +	switch (order) {
> +	case 0:

'0' needs to be defined, what does '0' mean? (I know what it
means, but for consistency I think it should have its own name).

Andi

> +		ret = vmf_insert_pfn(vma, vmf->address, pfn);
> +		break;

