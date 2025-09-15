Return-Path: <linux-kernel+bounces-817836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECC4B58741
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302FD18813A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C082C0285;
	Mon, 15 Sep 2025 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB4kjVRM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1D23957D;
	Mon, 15 Sep 2025 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974482; cv=none; b=KeDqihAza6gRT/h0050QWNLTsLANYGK6NO9neXCDPz5Ffw2OjZPSAfEO4rUWJz+uSr0KrhrPt3CbbZUILUvZ5wq0pCtf+xnyR+W2vzCfTpRmpbvjKirR5Nux9PIhtiZcCgVKjd9e1Acf3Tq+DL1sFrnony0J21s0xhN8tRhE9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974482; c=relaxed/simple;
	bh=42PF0UhqIVstyAZvj9Oxhvu2NgizRC3FkzlZTmN8t2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIUBatP7BBwZDl27dZClZHjd/9pfZYxOV0y0WRUn0zZ9j+5sJO/LczbIesgfe8o4nP1tP+j/LcT/gieimvccIyt4wPOeN0FVPIeUxNqS5WQ2DxYeiMpTv3Q0+4iju3mC7RklLaDPIjlS+MdjpuQCS+f4GxfR5UXcD6txrfA2lOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB4kjVRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A2FC4CEF9;
	Mon, 15 Sep 2025 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757974481;
	bh=42PF0UhqIVstyAZvj9Oxhvu2NgizRC3FkzlZTmN8t2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YB4kjVRMGqWWTf5wx+xKc4Av/dO5yqwEAym1wFCSV/5nWHnbNo5Lld+08DaWnhr7x
	 9V3+gQGc8/EdEMv/AXCrXZMaL6yampUroqB8aArDG751VC+NlbtWXOKP2qaWOMKdpr
	 B5/Wi7CWNBdNHM6JvaKQ7lEPQ9wXwvFJJQNTzQLUhwHovt8/LAajy0/kqRGbP8Mc4a
	 RSqs8xBQwTTXpNMB1qMqjuTPXJxY7UmzvcoEOWizaWFp2/kRf8eL0PEC+fd0vHKzQ/
	 mzNgMyB7qF6OJeezzh65LYAxBFVzQbUwWAl78Pc9ls9Iui6l2lAd0wrOKu0m63EhQ6
	 4UXoVFJZKOu2Q==
Date: Mon, 15 Sep 2025 15:14:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] kexec: Remove unused code in
 kimage_load_cma_segment()
Message-ID: <20250915221436.GA925462@ax162>
References: <20250915155543.2912469-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915155543.2912469-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Mon, Sep 15, 2025 at 05:55:43PM +0200, Andy Shevchenko wrote:
> clang is not happy about set but unused variable:
> 
> kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
>   745 |         unsigned long maddr;
>       |                       ^
> 1 error generated.
> 
> Fix the compilation breakage (`make W=1` build) by removing unused variable.
> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")

I don't think this fixes tag is right. maddr definitely looks used in
that diff. I think it is a follow up simplification that introduces
this.

Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Otherwise, this patch looks correct to me and GCC 16 will warn on this
as well.

  kernel/kexec_core.c: In function 'kimage_load_cma_segment':
  kernel/kexec_core.c:745:23: error: variable 'maddr' set but not used [-Werror=unused-but-set-variable=]
    745 |         unsigned long maddr;
        |                       ^~~~~

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

>  kernel/kexec_core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5357ed39e9d1..32722926bc7e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -742,7 +742,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  	struct kexec_segment *segment = &image->segment[idx];
>  	struct page *cma = image->segment_cma[idx];
>  	char *ptr = page_address(cma);
> -	unsigned long maddr;
>  	size_t ubytes, mbytes;
>  	int result = 0;
>  	unsigned char __user *buf = NULL;
> @@ -754,7 +753,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  		buf = segment->buf;
>  	ubytes = segment->bufsz;
>  	mbytes = segment->memsz;
> -	maddr = segment->mem;
>  
>  	/* Then copy from source buffer to the CMA one */
>  	while (mbytes) {
> @@ -782,7 +780,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  		}
>  
>  		ptr    += mchunk;
> -		maddr  += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> -- 
> 2.50.1
> 

