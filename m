Return-Path: <linux-kernel+bounces-842699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA38BBD530
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A417118946DF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE3A25CC42;
	Mon,  6 Oct 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J3WgEZ5B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bkrIDvaA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J3WgEZ5B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bkrIDvaA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C43223DED
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738808; cv=none; b=COcAqxtPJ5kQ2Wacz4VHmDypi4xWS80rAPIoGu40Deqlh8JZkC5dfO6AmJHQSGi8MpIVvring8nGyQXV4eCgL6M700v9jFlYnGO1IjkT95Y6d/bHToPWqrbc9hFzJ1JynDRxdeZ5rUMn3x+5vrwlyr21ih9mkvFcbfBT8C+n1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738808; c=relaxed/simple;
	bh=PYLxdVVocNyMEQwZ9hkjM5Awt28FbgMEvZQmw9oAPhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plupm0BNQdYPRixI8tFNPIzb20z6SFvwrOBDOOM0ygBcoIc/XUcluoQXDuKJ7WB8Xr9D8tQnQmRFCbMSRR3/mfWQ7OWT6bbXh0OD9WTwOZJQYNohkD/BTa0a4tfIzPlLTeXWTaekTqDABki9bf7jPOxn/C/bHQXsaP8HjVjA3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J3WgEZ5B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bkrIDvaA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J3WgEZ5B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bkrIDvaA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D488336CB;
	Mon,  6 Oct 2025 08:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759738804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91nFhmvjOlSuh257mCaBP5+wVYdOBnUlRIsTLkrttYM=;
	b=J3WgEZ5B78Wf6D0vRriyJcTdMF8A0lAUcn8+Hi2fa3ZRBE7CjyYzBCU8VnvRUEOvmp1vh0
	qWHeJEE1GFluDXwDXw7nMKT7KFNeFtBZ03CIaFldpoHV3ZUrES1smQ4h0R6nLryerc+TUi
	t/kg041ZOiPFtcel7x6LXRd0Fia7eAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759738804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91nFhmvjOlSuh257mCaBP5+wVYdOBnUlRIsTLkrttYM=;
	b=bkrIDvaAwa0PudhD/XVNV/19jACImrGiwZpucwSEt9t5i/Ic4SlNL2h6s9sdQLEuYlTEs6
	NhxgM1u1FksI6hDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759738804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91nFhmvjOlSuh257mCaBP5+wVYdOBnUlRIsTLkrttYM=;
	b=J3WgEZ5B78Wf6D0vRriyJcTdMF8A0lAUcn8+Hi2fa3ZRBE7CjyYzBCU8VnvRUEOvmp1vh0
	qWHeJEE1GFluDXwDXw7nMKT7KFNeFtBZ03CIaFldpoHV3ZUrES1smQ4h0R6nLryerc+TUi
	t/kg041ZOiPFtcel7x6LXRd0Fia7eAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759738804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91nFhmvjOlSuh257mCaBP5+wVYdOBnUlRIsTLkrttYM=;
	b=bkrIDvaAwa0PudhD/XVNV/19jACImrGiwZpucwSEt9t5i/Ic4SlNL2h6s9sdQLEuYlTEs6
	NhxgM1u1FksI6hDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 026E913995;
	Mon,  6 Oct 2025 08:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PIuWALR742jUKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Oct 2025 08:20:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94A39A0A48; Mon,  6 Oct 2025 10:20:03 +0200 (CEST)
Date: Mon, 6 Oct 2025 10:20:03 +0200
From: Jan Kara <jack@suse.cz>
To: Dev Jain <dev.jain@arm.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: readahead: make thp readahead conditional to
 mmap_miss logic
Message-ID: <mxhut4yy3xqqv2gchlakiqu4bhjzbmu4bwl7xtdrwqqygcgwxk@cggnjvpola7g>
References: <20250930054815.132075-1-roman.gushchin@linux.dev>
 <766f5a8a-851f-4178-8931-5355472d5558@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <766f5a8a-851f-4178-8931-5355472d5558@arm.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[kvack.org:email,imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.com:email,suse.cz:email,infradead.org:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sat 04-10-25 18:38:25, Dev Jain wrote:
> 
> On 30/09/25 11:18 am, Roman Gushchin wrote:
> > Commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> > introduced a special handling for VM_HUGEPAGE mappings: even if the
> > readahead is disabled, 1 or 2 HPAGE_PMD_ORDER pages are
> > allocated.
> > 
> > This change causes a significant regression for containers with a
> > tight memory.max limit, if VM_HUGEPAGE is widely used. Prior to this
> > commit, mmap_miss logic would eventually lead to the readahead
> > disablement, effectively reducing the memory pressure in the
> > cgroup. With this change the kernel is trying to allocate 1-2 huge
> > pages for each fault, no matter if these pages are used or not
> > before being evicted, increasing the memory pressure multi-fold.
> > 
> > To fix the regression, let's make the new VM_HUGEPAGE conditional
> > to the mmap_miss check, but keep independent from the ra->ra_pages.
> > This way the main intention of commit 4687fdbb805a ("mm/filemap:
> > Support VM_HUGEPAGE for file mappings") stays intact, but the
> > regression is resolved.
> > 
> > The logic behind this changes is simple: even if a user explicitly
> > requests using huge pages to back the file mapping (using VM_HUGEPAGE
> > flag), under a very strong memory pressure it's better to fall back
> > to ordinary pages.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: linux-mm@kvack.org
> > ---
> >   mm/filemap.c | 40 +++++++++++++++++++++-------------------
> >   1 file changed, 21 insertions(+), 19 deletions(-)
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index a52dd38d2b4a..b67d7981fafb 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3235,34 +3235,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> >   	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
> >   	struct file *fpin = NULL;
> >   	vm_flags_t vm_flags = vmf->vma->vm_flags;
> > +	bool force_thp_readahead = false;
> >   	unsigned short mmap_miss;
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >   	/* Use the readahead code, even if readahead is disabled */
> > -	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
> > -		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> > -		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
> > -		ra->size = HPAGE_PMD_NR;
> > -		/*
> > -		 * Fetch two PMD folios, so we get the chance to actually
> > -		 * readahead, unless we've been told not to.
> > -		 */
> > -		if (!(vm_flags & VM_RAND_READ))
> > -			ra->size *= 2;
> > -		ra->async_size = HPAGE_PMD_NR;
> > -		ra->order = HPAGE_PMD_ORDER;
> > -		page_cache_ra_order(&ractl, ra);
> > -		return fpin;
> > -	}
> > -#endif
> > -
> > +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > +	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
> > +		force_thp_readahead = true;
> >   	/*
> >   	 * If we don't want any read-ahead, don't bother. VM_EXEC case below is
> >   	 * already intended for random access.
> >   	 */
> >   	if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
> >   		return fpin;
> > -	if (!ra->ra_pages)
> > +	if (!ra->ra_pages && !force_thp_readahead)
> >   		return fpin;
> >   	if (vm_flags & VM_SEQ_READ) {
> > @@ -3283,6 +3269,22 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> >   	if (mmap_miss > MMAP_LOTSAMISS)
> >   		return fpin;
> 
> You have moved the PMD-THP logic below the VM_SEQ_READ check, is that intentional?
> So VMAs on which sequential read is expected will now use the common readahead algorithm,
> instead of always benefitting from reduced TLB pressure through PMD mapping, if my understanding
> is correct?

Hum, that's a good point. We should preserve the logic for VM_SEQ_READ
vmas. I've missed this during my review. Thanks for catching this.

								Honza

> 
> > +	if (force_thp_readahead) {
> > +		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> > +		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
> > +		ra->size = HPAGE_PMD_NR;
> > +		/*
> > +		 * Fetch two PMD folios, so we get the chance to actually
> > +		 * readahead, unless we've been told not to.
> > +		 */
> > +		if (!(vm_flags & VM_RAND_READ))
> > +			ra->size *= 2;
> > +		ra->async_size = HPAGE_PMD_NR;
> > +		ra->order = HPAGE_PMD_ORDER;
> > +		page_cache_ra_order(&ractl, ra);
> > +		return fpin;
> > +	}
> > +
> >   	if (vm_flags & VM_EXEC) {
> >   		/*
> >   		 * Allow arch to request a preferred minimum folio order for
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

