Return-Path: <linux-kernel+bounces-625553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239DAA1727
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9D71B64906
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266EC2517A4;
	Tue, 29 Apr 2025 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTYx6A2v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65249251780
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948676; cv=none; b=LaCeiDi/xfJjA0CHO1B+F6CTvgBFwU4IjXIq6FQkBUY2+rDNOPTi4CiMWFCbug2Ie7EoQIlxr2dq4xS458O5qveteznvgo1kLDNkBNQJM5qq5oTbx0w5JrlwpUvVCDAfVkP/H6TxkWztXi+G1V8NqeN7FcqnR+i5Pu2JNfqXy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948676; c=relaxed/simple;
	bh=YihdS4lIlPx1QvCRHI6VlfjDGJoGrUsNEFaaqylzs1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl13CA+qyw7nEWSjBbOodasxK+IkISaCgVUMjGHNJ/fEVlsRgBxAfhR5hU7SJaF7GovjJnbUkYp+5jpbfjcggHO1vtMvEwnh1atpgM0SRvIIH2LV0x+Se5HSod0+ut1IObeQhy34SO91vbFytLP137/7eeyGo3VpS6gpXzTUCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTYx6A2v; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745948675; x=1777484675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YihdS4lIlPx1QvCRHI6VlfjDGJoGrUsNEFaaqylzs1A=;
  b=dTYx6A2vqR+qMu4UCJL7xmattwR2pY+1R63e9D64qJxK1A2ztOcpIoLM
   VCsQasW0zMFBw1EW0UUfMJNyQzlcn4RZyW0DnR2rkZvTiJBgsxhEGyyZs
   v17a54Zm+a5I3/U9VUEyjP20crVC+mE4ub4LohJlQnYh8rDqHnX26jyyL
   X4qS2Kwkon79WXYinPcgl5OU4COJd5jLMII7HM4Nk5l+i/11iYh7BvYY4
   AHCdBpV9jIK3vkpoTJNuozQLbWQv8hGIZnChIWiEnLNm9x0YkD1iBP+1j
   oBiteWwvClTvv+ADn708IGiz/RBT1LwJpct7Hn2N3iTZuonjPxqtzsnhZ
   A==;
X-CSE-ConnectionGUID: u2f9m2laQrWP9BKpeXTYDQ==
X-CSE-MsgGUID: kT0wzBatTJycQsiKQclrEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="64999828"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="64999828"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:44:34 -0700
X-CSE-ConnectionGUID: 71ZXWDiaR8mGsyo071y1aQ==
X-CSE-MsgGUID: ZUYBiCRvRZWmgpkXX6ipMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="139077844"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 29 Apr 2025 10:44:29 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 29 Apr 2025 20:44:27 +0300
Date: Tue, 29 Apr 2025 20:44:27 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
	david@redhat.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
	ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	Eero Tamminen <eero.t.tamminen@intel.com>
Subject: [REGRESSION] Re: [PATCH v3 3/6] mm: shmem: add large folio support
 for tmpfs
Message-ID: <aBEP-6iFhIC87zmb@intel.com>
References: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
 <035bf55fbdebeff65f5cb2cdb9907b7d632c3228.1732779148.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <035bf55fbdebeff65f5cb2cdb9907b7d632c3228.1732779148.git.baolin.wang@linux.alibaba.com>
X-Patchwork-Hint: comment

On Thu, Nov 28, 2024 at 03:40:41PM +0800, Baolin Wang wrote:
> Add large folio support for tmpfs write and fallocate paths matching the
> same high order preference mechanism used in the iomap buffered IO path
> as used in __filemap_get_folio().
> 
> Add shmem_mapping_size_orders() to get a hint for the orders of the folio
> based on the file size which takes care of the mapping requirements.
> 
> Traditionally, tmpfs only supported PMD-sized large folios. However nowadays
> with other file systems supporting any sized large folios, and extending
> anonymous to support mTHP, we should not restrict tmpfs to allocating only
> PMD-sized large folios, making it more special. Instead, we should allow
> tmpfs can allocate any sized large folios.
> 
> Considering that tmpfs already has the 'huge=' option to control the PMD-sized
> large folios allocation, we can extend the 'huge=' option to allow any sized
> large folios. The semantics of the 'huge=' mount option are:
> 
> huge=never: no any sized large folios
> huge=always: any sized large folios
> huge=within_size: like 'always' but respect the i_size
> huge=advise: like 'always' if requested with madvise()
> 
> Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
> allocate the PMD-sized huge folios if huge=always/within_size/advise is set.
> 
> Moreover, the 'deny' and 'force' testing options controlled by
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
> semantics. The 'deny' can disable any sized large folios for tmpfs, while
> the 'force' can enable PMD sized large folios for tmpfs.
> 
> Co-developed-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Hi,

This causes a huge regression in Intel iGPU texturing performance.

I haven't had time to look at this in detail, but presumably the
problem is that we're no longer getting huge pages from our
private tmpfs mount (done in i915_gemfs_init()).

Some more details at
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13845

> ---
>  mm/shmem.c | 99 ++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 81 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7595c3db4c1c..54eaa724c153 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -554,34 +554,100 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>  
>  static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>  
> +/**
> + * shmem_mapping_size_orders - Get allowable folio orders for the given file size.
> + * @mapping: Target address_space.
> + * @index: The page index.
> + * @write_end: end of a write, could extend inode size.
> + *
> + * This returns huge orders for folios (when supported) based on the file size
> + * which the mapping currently allows at the given index. The index is relevant
> + * due to alignment considerations the mapping might have. The returned order
> + * may be less than the size passed.
> + *
> + * Return: The orders.
> + */
> +static inline unsigned int
> +shmem_mapping_size_orders(struct address_space *mapping, pgoff_t index, loff_t write_end)
> +{
> +	unsigned int order;
> +	size_t size;
> +
> +	if (!mapping_large_folio_support(mapping) || !write_end)
> +		return 0;
> +
> +	/* Calculate the write size based on the write_end */
> +	size = write_end - (index << PAGE_SHIFT);
> +	order = filemap_get_order(size);
> +	if (!order)
> +		return 0;
> +
> +	/* If we're not aligned, allocate a smaller folio */
> +	if (index & ((1UL << order) - 1))
> +		order = __ffs(index);
> +
> +	order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
> +	return order > 0 ? BIT(order + 1) - 1 : 0;
> +}
> +
>  static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>  					      loff_t write_end, bool shmem_huge_force,
> +					      struct vm_area_struct *vma,
>  					      unsigned long vm_flags)
>  {
> +	unsigned int maybe_pmd_order = HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER ?
> +		0 : BIT(HPAGE_PMD_ORDER);
> +	unsigned long within_size_orders;
> +	unsigned int order;
> +	pgoff_t aligned_index;
>  	loff_t i_size;
>  
> -	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
> -		return 0;
>  	if (!S_ISREG(inode->i_mode))
>  		return 0;
>  	if (shmem_huge == SHMEM_HUGE_DENY)
>  		return 0;
>  	if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
> -		return BIT(HPAGE_PMD_ORDER);
> +		return maybe_pmd_order;
>  
> +	/*
> +	 * The huge order allocation for anon shmem is controlled through
> +	 * the mTHP interface, so we still use PMD-sized huge order to
> +	 * check whether global control is enabled.
> +	 *
> +	 * For tmpfs mmap()'s huge order, we still use PMD-sized order to
> +	 * allocate huge pages due to lack of a write size hint.
> +	 *
> +	 * Otherwise, tmpfs will allow getting a highest order hint based on
> +	 * the size of write and fallocate paths, then will try each allowable
> +	 * huge orders.
> +	 */
>  	switch (SHMEM_SB(inode->i_sb)->huge) {
>  	case SHMEM_HUGE_ALWAYS:
> -		return BIT(HPAGE_PMD_ORDER);
> +		if (vma)
> +			return maybe_pmd_order;
> +
> +		return shmem_mapping_size_orders(inode->i_mapping, index, write_end);
>  	case SHMEM_HUGE_WITHIN_SIZE:
> -		index = round_up(index + 1, HPAGE_PMD_NR);
> -		i_size = max(write_end, i_size_read(inode));
> -		i_size = round_up(i_size, PAGE_SIZE);
> -		if (i_size >> PAGE_SHIFT >= index)
> -			return BIT(HPAGE_PMD_ORDER);
> +		if (vma)
> +			within_size_orders = maybe_pmd_order;
> +		else
> +			within_size_orders = shmem_mapping_size_orders(inode->i_mapping,
> +								       index, write_end);
> +
> +		order = highest_order(within_size_orders);
> +		while (within_size_orders) {
> +			aligned_index = round_up(index + 1, 1 << order);
> +			i_size = max(write_end, i_size_read(inode));
> +			i_size = round_up(i_size, PAGE_SIZE);
> +			if (i_size >> PAGE_SHIFT >= aligned_index)
> +				return within_size_orders;
> +
> +			order = next_order(&within_size_orders, order);
> +		}
>  		fallthrough;
>  	case SHMEM_HUGE_ADVISE:
>  		if (vm_flags & VM_HUGEPAGE)
> -			return BIT(HPAGE_PMD_ORDER);
> +			return maybe_pmd_order;
>  		fallthrough;
>  	default:
>  		return 0;
> @@ -781,6 +847,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>  
>  static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>  					      loff_t write_end, bool shmem_huge_force,
> +					      struct vm_area_struct *vma,
>  					      unsigned long vm_flags)
>  {
>  	return 0;
> @@ -1176,7 +1243,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>  			STATX_ATTR_NODUMP);
>  	generic_fillattr(idmap, request_mask, inode, stat);
>  
> -	if (shmem_huge_global_enabled(inode, 0, 0, false, 0))
> +	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
>  		stat->blksize = HPAGE_PMD_SIZE;
>  
>  	if (request_mask & STATX_BTIME) {
> @@ -1693,14 +1760,10 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  		return 0;
>  
>  	global_orders = shmem_huge_global_enabled(inode, index, write_end,
> -						  shmem_huge_force, vm_flags);
> -	if (!vma || !vma_is_anon_shmem(vma)) {
> -		/*
> -		 * For tmpfs, we now only support PMD sized THP if huge page
> -		 * is enabled, otherwise fallback to order 0.
> -		 */
> +						  shmem_huge_force, vma, vm_flags);
> +	/* Tmpfs huge pages allocation */
> +	if (!vma || !vma_is_anon_shmem(vma))
>  		return global_orders;
> -	}
>  
>  	/*
>  	 * Following the 'deny' semantics of the top level, force the huge
> -- 
> 2.39.3
> 

-- 
Ville Syrj�l�
Intel

