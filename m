Return-Path: <linux-kernel+bounces-844182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B73BC13EF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EBC24F4C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A062D9EE7;
	Tue,  7 Oct 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cd9/Sv7m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpUKT5Al";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cd9/Sv7m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpUKT5Al"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028A2D46BB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837297; cv=none; b=BLo5ClfMEVFxMeSzhajkbbkAQ0zB2oaaWUekqlcPgmfFUVKy4/Tm9b7q7iPAvkVSAJGicAxFinI137pbsMpdESDl/MNwI4nnBwHYdyhBNKLhkF8u3axMbMrHp+Clr7FyXPi/BGwCLfuv8jAsfGN/8XAFrBtwM6QXigVNyefm21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837297; c=relaxed/simple;
	bh=RjIXSKYIdKIYXdlnQrpbaLOxAZNaI9Tt8cazDlYhhRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwTmiSByMwIxeEkkuAL4xcihWAUjggKxjVHP76QyaBRwffFBHxJPeWmW2FtSgxlpGtWufT22ez1yS47oSD72BYpd0yP/ZkLAt3kX58p1P6NAEcQbjL07IqK/h+dEj0xbnxf+0JZpAIVVl3xVDYvamRzInyHaj7THUGmUp156wec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cd9/Sv7m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpUKT5Al; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cd9/Sv7m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpUKT5Al; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 475591F44F;
	Tue,  7 Oct 2025 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759837293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZkgiUG8s/GGxknPnnCcFa5imKmgKW71ZK0Go84byCA=;
	b=cd9/Sv7mbpynR0vya1gE3ucWIpSg3BoLSgUPV+Uf/PPVYRuwYktGc5g90fPwDNF/2joFZC
	hBAYZxjYlcQRqZJnynu3FYyHNPO1yTn4MT2hrkUnMpVCPN9zsPTEN49CvBdhFoTSW37R3o
	PfUlYOpn1TUOe9ea+dlL4H7ruajbadU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759837293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZkgiUG8s/GGxknPnnCcFa5imKmgKW71ZK0Go84byCA=;
	b=rpUKT5AlcUCjq3cJ9UJebhZPr0XORcscgMMXrQuhKsqksuJUp7us2S/3ACi99bhjxM1FBk
	wBEXj03Jdem6TYBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="cd9/Sv7m";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rpUKT5Al
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759837293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZkgiUG8s/GGxknPnnCcFa5imKmgKW71ZK0Go84byCA=;
	b=cd9/Sv7mbpynR0vya1gE3ucWIpSg3BoLSgUPV+Uf/PPVYRuwYktGc5g90fPwDNF/2joFZC
	hBAYZxjYlcQRqZJnynu3FYyHNPO1yTn4MT2hrkUnMpVCPN9zsPTEN49CvBdhFoTSW37R3o
	PfUlYOpn1TUOe9ea+dlL4H7ruajbadU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759837293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZkgiUG8s/GGxknPnnCcFa5imKmgKW71ZK0Go84byCA=;
	b=rpUKT5AlcUCjq3cJ9UJebhZPr0XORcscgMMXrQuhKsqksuJUp7us2S/3ACi99bhjxM1FBk
	wBEXj03Jdem6TYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BB4613693;
	Tue,  7 Oct 2025 11:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2+WMDm385GgnfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 Oct 2025 11:41:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1051A0A58; Tue,  7 Oct 2025 13:41:28 +0200 (CEST)
Date: Tue, 7 Oct 2025 13:41:28 +0200
From: Jan Kara <jack@suse.cz>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: readahead: make thp readahead conditional to
 mmap_miss logic
Message-ID: <3hgw6hizjyjz3c7hpuyyevehd4lqasucuitgphh37rmtztfmcd@q4j7ytdnnwje>
References: <20251006175106.377411-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006175106.377411-1-roman.gushchin@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 475591F44F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Mon 06-10-25 10:51:06, Roman Gushchin wrote:
> Commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> introduced a special handling for VM_HUGEPAGE mappings: even if the
> readahead is disabled, 1 or 2 HPAGE_PMD_ORDER pages are
> allocated.
> 
> This change causes a significant regression for containers with a
> tight memory.max limit, if VM_HUGEPAGE is widely used. Prior to this
> commit, mmap_miss logic would eventually lead to the readahead
> disablement, effectively reducing the memory pressure in the
> cgroup. With this change the kernel is trying to allocate 1-2 huge
> pages for each fault, no matter if these pages are used or not
> before being evicted, increasing the memory pressure multi-fold.
> 
> To fix the regression, let's make the new VM_HUGEPAGE conditional
> to the mmap_miss check, but keep independent from the ra->ra_pages.
> This way the main intention of commit 4687fdbb805a ("mm/filemap:
> Support VM_HUGEPAGE for file mappings") stays intact, but the
> regression is resolved.
> 
> The logic behind this changes is simple: even if a user explicitly
> requests using huge pages to back the file mapping (using VM_HUGEPAGE
> flag), under a very strong memory pressure it's better to fall back
> to ordinary pages.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: linux-mm@kvack.org

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> --
> 
> v3: fixed VM_SEQ_READ handling for the THP case (by Jan Kara)
> v2: fixed VM_SEQ_READ handling (by Dev Jain)
> ---
>  mm/filemap.c | 68 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a52dd38d2b4a..ec731ac05551 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3235,11 +3235,47 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
>  	struct file *fpin = NULL;
>  	vm_flags_t vm_flags = vmf->vma->vm_flags;
> +	bool force_thp_readahead = false;
>  	unsigned short mmap_miss;
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	/* Use the readahead code, even if readahead is disabled */
> -	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
> +		force_thp_readahead = true;
> +
> +	if (!force_thp_readahead) {
> +		/*
> +		 * If we don't want any read-ahead, don't bother.
> +		 * VM_EXEC case below is already intended for random access.
> +		 */
> +		if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
> +			return fpin;
> +
> +		if (!ra->ra_pages)
> +			return fpin;
> +
> +		if (vm_flags & VM_SEQ_READ) {
> +			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> +			page_cache_sync_ra(&ractl, ra->ra_pages);
> +			return fpin;
> +		}
> +	}
> +
> +	if (!(vm_flags & VM_SEQ_READ)) {
> +		/* Avoid banging the cache line if not needed */
> +		mmap_miss = READ_ONCE(ra->mmap_miss);
> +		if (mmap_miss < MMAP_LOTSAMISS * 10)
> +			WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
> +
> +		/*
> +		 * Do we miss much more than hit in this file? If so,
> +		 * stop bothering with read-ahead. It will only hurt.
> +		 */
> +		if (mmap_miss > MMAP_LOTSAMISS)
> +			return fpin;
> +	}
> +
> +	if (force_thp_readahead) {
>  		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
>  		ra->size = HPAGE_PMD_NR;
> @@ -3254,34 +3290,6 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		page_cache_ra_order(&ractl, ra);
>  		return fpin;
>  	}
> -#endif
> -
> -	/*
> -	 * If we don't want any read-ahead, don't bother. VM_EXEC case below is
> -	 * already intended for random access.
> -	 */
> -	if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
> -		return fpin;
> -	if (!ra->ra_pages)
> -		return fpin;
> -
> -	if (vm_flags & VM_SEQ_READ) {
> -		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -		page_cache_sync_ra(&ractl, ra->ra_pages);
> -		return fpin;
> -	}
> -
> -	/* Avoid banging the cache line if not needed */
> -	mmap_miss = READ_ONCE(ra->mmap_miss);
> -	if (mmap_miss < MMAP_LOTSAMISS * 10)
> -		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
> -
> -	/*
> -	 * Do we miss much more than hit in this file? If so,
> -	 * stop bothering with read-ahead. It will only hurt.
> -	 */
> -	if (mmap_miss > MMAP_LOTSAMISS)
> -		return fpin;
>  
>  	if (vm_flags & VM_EXEC) {
>  		/*
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

