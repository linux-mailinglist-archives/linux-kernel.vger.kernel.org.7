Return-Path: <linux-kernel+bounces-842947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEE1BBE077
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 210664EC37B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A146627F727;
	Mon,  6 Oct 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7bxAt3E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W3epdj9H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7bxAt3E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W3epdj9H"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B457262FC0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753874; cv=none; b=qXMn9vCXrmveIViUxe2pbks8P5xSHaj2NAAbwx2MCRVnk4F8WNMYsTfkjNQMQeGwb7ORJlaogov7QHKphbePLGPfaygXymG8sw3pvzk7jdnDJrBoGNw1/XFtaAkWFfYB56dwFk9jz5s1I0jrds7ZQdRquNqQK/ugCWuy9nQgc6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753874; c=relaxed/simple;
	bh=qYpXHNJYoDQ5EDWwqi8rr7ZMXCqmlUy/3dCALT/o210=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMr0rWKAJE1n4DAdQxL2I2HoOJW/D2YAbzv+JBQb3OdUF5V0V8VqHukSm201amJqBDBGP0aQpQIrPZdRmRXRnEX8CCL5ypCcoX2XGwmkWfKBcp0j2fq5IHVR2Phpg9A7H7S79efOL0IGZt5vT9TXxinkvZH4LXWNG83RNS2Owdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J7bxAt3E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W3epdj9H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J7bxAt3E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W3epdj9H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 234DF336EF;
	Mon,  6 Oct 2025 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759753871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EP7uvhEtK4igyHtfrvI5g+ND5YjZHvOvQglSG3RCGgM=;
	b=J7bxAt3ELKNOAW28bhqZq0mY0RJEYp7iq7J4R6EqC7DMrUv0hGCYc+ly2p79RcqQ881Ynk
	OyZ+VZF8grYf49d3xn4RmOtlvNhPbMTpOb7mqdy1d8yCW0kAEg8Ui7kQSxIFJbsHFUa1yv
	8HdTTyzrA6M8n22eannfyX8JdTJcxQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759753871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EP7uvhEtK4igyHtfrvI5g+ND5YjZHvOvQglSG3RCGgM=;
	b=W3epdj9H4NDcUQVz0ue68CavaFu/fe5hEBIGypSP6KhRt33Z8dguMbvpUHfKuaz9b6dOR2
	VwybxvJm3x6v86BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J7bxAt3E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=W3epdj9H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759753871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EP7uvhEtK4igyHtfrvI5g+ND5YjZHvOvQglSG3RCGgM=;
	b=J7bxAt3ELKNOAW28bhqZq0mY0RJEYp7iq7J4R6EqC7DMrUv0hGCYc+ly2p79RcqQ881Ynk
	OyZ+VZF8grYf49d3xn4RmOtlvNhPbMTpOb7mqdy1d8yCW0kAEg8Ui7kQSxIFJbsHFUa1yv
	8HdTTyzrA6M8n22eannfyX8JdTJcxQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759753871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EP7uvhEtK4igyHtfrvI5g+ND5YjZHvOvQglSG3RCGgM=;
	b=W3epdj9H4NDcUQVz0ue68CavaFu/fe5hEBIGypSP6KhRt33Z8dguMbvpUHfKuaz9b6dOR2
	VwybxvJm3x6v86BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 131CC13995;
	Mon,  6 Oct 2025 12:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bUWjBI+242i2dwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Oct 2025 12:31:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B1508A0ABD; Mon,  6 Oct 2025 14:31:06 +0200 (CEST)
Date: Mon, 6 Oct 2025 14:31:06 +0200
From: Jan Kara <jack@suse.cz>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: readahead: make thp readahead conditional to
 mmap_miss logic
Message-ID: <e2zblaknfnzjtlo3df4aozoxuir6zgnycdjj4ywbu7rsnpw6hr@ocemkpucjd2d>
References: <20251006015409.342697-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006015409.342697-1-roman.gushchin@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,arm.com:email,suse.com:email,kvack.org:email,suse.cz:email,suse.cz:dkim];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 234DF336EF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Sun 05-10-25 18:54:09, Roman Gushchin wrote:
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
> Reviewed-by: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: linux-mm@kvack.org
> 
> --
> 
> v2: fixed VM_SEQ_READ handling (by Dev Jain)

OK, but now we'll do mmap_miss detection and bail-out even for VM_SEQ_READ
| VM_HUGEPAGE vmas. And without VM_HUGEPAGE we won't do it which is really
odd. So I think you want to make the whole mmap_miss logic conditional on
!VM_SEQ_READ...

								Honza

> ---
>  mm/filemap.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a52dd38d2b4a..446e591d57e5 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3235,37 +3235,23 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
>  	struct file *fpin = NULL;
>  	vm_flags_t vm_flags = vmf->vma->vm_flags;
> +	bool force_thp_readahead = false;
>  	unsigned short mmap_miss;
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	/* Use the readahead code, even if readahead is disabled */
> -	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
> -		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
> -		ra->size = HPAGE_PMD_NR;
> -		/*
> -		 * Fetch two PMD folios, so we get the chance to actually
> -		 * readahead, unless we've been told not to.
> -		 */
> -		if (!(vm_flags & VM_RAND_READ))
> -			ra->size *= 2;
> -		ra->async_size = HPAGE_PMD_NR;
> -		ra->order = HPAGE_PMD_ORDER;
> -		page_cache_ra_order(&ractl, ra);
> -		return fpin;
> -	}
> -#endif
> -
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
> +		force_thp_readahead = true;
>  	/*
>  	 * If we don't want any read-ahead, don't bother. VM_EXEC case below is
>  	 * already intended for random access.
>  	 */
>  	if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
>  		return fpin;
> -	if (!ra->ra_pages)
> +	if (!ra->ra_pages && !force_thp_readahead)
>  		return fpin;
>  
> -	if (vm_flags & VM_SEQ_READ) {
> +	if ((vm_flags & VM_SEQ_READ) && !force_thp_readahead) {
>  		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  		page_cache_sync_ra(&ractl, ra->ra_pages);
>  		return fpin;
> @@ -3283,6 +3269,22 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	if (mmap_miss > MMAP_LOTSAMISS)
>  		return fpin;
>  
> +	if (force_thp_readahead) {
> +		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> +		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
> +		ra->size = HPAGE_PMD_NR;
> +		/*
> +		 * Fetch two PMD folios, so we get the chance to actually
> +		 * readahead, unless we've been told not to.
> +		 */
> +		if (!(vm_flags & VM_RAND_READ))
> +			ra->size *= 2;
> +		ra->async_size = HPAGE_PMD_NR;
> +		ra->order = HPAGE_PMD_ORDER;
> +		page_cache_ra_order(&ractl, ra);
> +		return fpin;
> +	}
> +
>  	if (vm_flags & VM_EXEC) {
>  		/*
>  		 * Allow arch to request a preferred minimum folio order for
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

