Return-Path: <linux-kernel+bounces-705718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B639AEACBA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 04:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71347188DBED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F02278F2E;
	Fri, 27 Jun 2025 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qy+yHzYF"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2040219EB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990607; cv=none; b=pOMgM+vgfLd0oYG64INilMKL7YtjeHuTob2JUQLyM2vGoQd0952nB3kVJ41kj0T0Mczw/WE9exCEHladxPfAs5Icla79b+pw2LI6sw6OcKGn6Q7zBLIBd9/JQHxE62vn7bGLbKfFR4tx/coOqWGbHEmQv+iqIoLz72ZpHY/pXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990607; c=relaxed/simple;
	bh=pZsPe42CiZoGGMQSeeHGeXnuo34X8knlQoD8r/oOmIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx09vaht4bX59wdIFr35u2qiM3Ti6TgJC4L0Lu9basdYvOKGFY+JFXo9NDZKq2/0FOr7h4WzpLPkb9XYBKrrwsmrflRyErec8HCHIqnNcHzAd+H3ci9+5lL4J5zR8LdD53mQCwdTRTnilwsBWFvzUNsA9bzRE29ZJcc1QYikQDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qy+yHzYF; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Jun 2025 22:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750990593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U144Ph4RXxj4gGppJr9qT0Dw0b6wY2GgPOKo6Yovtog=;
	b=qy+yHzYFPd5ntOkc9N8/MwGXmHEUwJV01+b6dEnJ5EqsJ3Tm8V7fMSzGl+jPJM8uK1APRB
	9r2Jehd557lAkcgloXsi7Jg2jwVOpRsVCJ8aLNXiGF7E6ZqXpL6ESMr+QEgZ0lfIqHl4Xv
	WgdAIK8IjpWW56gl1zjvMQD1iwRapgc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/2] bcachefs: Simplify bch2_bio_map()
Message-ID: <e6r3mzeb33xidr6e24ylrdop2v2hr7ztcqxl5uoskvfsmfbid2@2qztfbarr5bx>
References: <20250605020639.6868-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605020639.6868-1-youling.tang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 05, 2025 at 10:06:38AM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> For the part of directly mapping the kernel virtual address, there is no
> need to increase to bio page-by-page. It can be directly replaced by
> bio_add_virt_nofail().
> 
> For the address part of the vmalloc region, its physical address is
> discontinuous and needs to be increased page-by-page to bio. The helper
> function bio_add_vmalloc() can be used to simplify the implementation of
> bch2_bio_map().
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

Thanks, I'll apply this

> ---
> NOTE:
> The following patch needs to be applied (because the bcachefs.git repository
> has not been synchronized to the latest):
> commit 850e210d5ad2 ("block: add a bio_add_virt_nofail helper")
> commit 8dd16f5e3469 ("block: add a bio_add_vmalloc helpers")
> 
>  fs/bcachefs/util.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
> index dc3817f545fa..5e5075630bc6 100644
> --- a/fs/bcachefs/util.c
> +++ b/fs/bcachefs/util.c
> @@ -623,17 +623,10 @@ void bch2_pd_controller_debug_to_text(struct printbuf *out, struct bch_pd_contro
>  
>  void bch2_bio_map(struct bio *bio, void *base, size_t size)
>  {
> -	while (size) {
> -		struct page *page = is_vmalloc_addr(base)
> -				? vmalloc_to_page(base)
> -				: virt_to_page(base);
> -		unsigned offset = offset_in_page(base);
> -		unsigned len = min_t(size_t, PAGE_SIZE - offset, size);
> -
> -		BUG_ON(!bio_add_page(bio, page, len, offset));
> -		size -= len;
> -		base += len;
> -	}
> +	if (is_vmalloc_addr(base))
> +		bio_add_vmalloc(bio, base, size);
> +	else
> +		bio_add_virt_nofail(bio, base, size);
>  }
>  
>  int bch2_bio_alloc_pages(struct bio *bio, size_t size, gfp_t gfp_mask)
> -- 
> 2.34.1
> 

