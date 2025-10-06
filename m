Return-Path: <linux-kernel+bounces-843006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33BBBE301
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D230B3ABB81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACE2D063C;
	Mon,  6 Oct 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e5FSunWt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="udmEe+sy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e5FSunWt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="udmEe+sy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67451296BC9
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757345; cv=none; b=jahQtNcrpb9VA4fHUXhFJ/jittYwZFRa2zMZuDmP42ckTMrb2Au+xhSxG5a4/Bm7nr+abHTKxsXklIsLDuSiaEm0ldrn+ceJq1sHxcO1tupW254ZSuAPKsPGI+PkoVO6VWpP6/qcB2zPt516ftuPpIrlfgfY9pMvVWxMGLZPxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757345; c=relaxed/simple;
	bh=/6FrrVCz4DgTsz5tcjhrj2pcVC3t7cYgtGxIFJtkqc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dlbx3kqQdJ160QZxcQ1HnTfb1LMgx+p9Kl6PG8Tu+3T2jt42dHC56RCMuKbWEFR+Lnp/heUQ6+gryfCN38eYUhj+pOJEEZK+jTV4M2LJMq2Oxl/5pJBaJQULAfosUmGhrV0grUcxJW1nqlcC/E4TfZIXKBBJ7qyYm5pNOreGHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e5FSunWt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=udmEe+sy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e5FSunWt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=udmEe+sy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6674B1F7C1;
	Mon,  6 Oct 2025 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759757340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmQkrksLlt0Dju/XPbVmLnx0iwCrgY81znO3vDFEw2o=;
	b=e5FSunWtnLxCK0NWpRn7i1aC8/XK3geJ4CKHRjTJateym0/L7RDOqwKK5e+6t5kmTCYRsB
	EPRwzGfp5nBJfLOOJl8S/3BAgdEii0RQZtJlMcq3VapCT6B7fgBGIuSvndiTYmhsq8YfXS
	LFed7MyVYYL2Eja14snDPJu82aLF4ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759757340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmQkrksLlt0Dju/XPbVmLnx0iwCrgY81znO3vDFEw2o=;
	b=udmEe+syEUzPxvOpywR7StoUmtqqjRk58CQIRWj0dyNq58xlrCTv3cqtV620Mq2FpLegpz
	2nF3jEdov6D6s3Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e5FSunWt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=udmEe+sy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759757340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmQkrksLlt0Dju/XPbVmLnx0iwCrgY81znO3vDFEw2o=;
	b=e5FSunWtnLxCK0NWpRn7i1aC8/XK3geJ4CKHRjTJateym0/L7RDOqwKK5e+6t5kmTCYRsB
	EPRwzGfp5nBJfLOOJl8S/3BAgdEii0RQZtJlMcq3VapCT6B7fgBGIuSvndiTYmhsq8YfXS
	LFed7MyVYYL2Eja14snDPJu82aLF4ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759757340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmQkrksLlt0Dju/XPbVmLnx0iwCrgY81znO3vDFEw2o=;
	b=udmEe+syEUzPxvOpywR7StoUmtqqjRk58CQIRWj0dyNq58xlrCTv3cqtV620Mq2FpLegpz
	2nF3jEdov6D6s3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CC9A13700;
	Mon,  6 Oct 2025 13:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yN+GIxvE42hUCwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 06 Oct 2025 13:28:59 +0000
Date: Mon, 6 Oct 2025 15:28:58 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: muchun.song@linux.dev, david@redhat.com, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	broonie@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] hugetlbfs: skip PMD unsharing when shareable lock
 unavailable
Message-ID: <aOPEGkWdbeY2htsH@localhost.localdomain>
References: <20251003174553.3078839-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003174553.3078839-1-kartikey406@gmail.com>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,appspotmail.com:email,localhost.localdomain:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[f26d7c75c26ec19790e7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,localhost.localdomain:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6674B1F7C1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On Fri, Oct 03, 2025 at 11:15:53PM +0530, Deepanshu Kartikey wrote:
> When hugetlb_vmdelete_list() cannot acquire the shareable lock for a VMA,
> the previous fix (dd83609b8898) skipped the entire VMA to avoid lock
> assertions in huge_pmd_unshare(). However, this prevented pages from being
> unmapped and freed, causing a regression in fallocate(PUNCH_HOLE) operations
> where pages were not freed immediately, as reported by Mark Brown.
> 
> The issue occurs because:
> 1. hugetlb_vmdelete_list() calls hugetlb_vma_trylock_write()
> 2. For shareable VMAs, this attempts to acquire the shareable lock
> 3. If successful, huge_pmd_unshare() expects the lock to be held
> 4. huge_pmd_unshare() asserts the lock via hugetlb_vma_assert_locked()
> 
> The v2 fix avoided calling code that requires locks, but this prevented
> page unmapping entirely, breaking the expected behavior where pages are
> freed during punch hole operations.
> 
> This v3 fix takes a different approach: instead of skipping the entire VMA,
> we skip only the PMD unsharing operation when we don't have the required
> lock, while still proceeding with page unmapping. This is safe because:
> 
> - PMD unsharing is an optimization to reduce shared page table overhead
> - Page unmapping can proceed safely with just the VMA write lock
> - Pages get freed immediately as expected by PUNCH_HOLE operations
> - The PMD metadata will be cleaned up when the VMA is destroyed
> 
> We introduce a new ZAP_FLAG_NO_UNSHARE flag that communicates to
> __unmap_hugepage_range() that it should skip huge_pmd_unshare() while
> still clearing page table entries and freeing pages.
> 
> Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Reported-by: Mark Brown <broonie@kernel.org>
> Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
> Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> ---
...
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 9c94ed8c3ab0..519497bc1045 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -474,29 +474,31 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>  	vma_interval_tree_foreach(vma, root, start, end ? end - 1 : ULONG_MAX) {
>  		unsigned long v_start;
>  		unsigned long v_end;
> +		bool have_shareable_lock;
> +		zap_flags_t local_flags = zap_flags;
>  
>  		if (!hugetlb_vma_trylock_write(vma))
>  			continue;
> -
> +
> +		have_shareable_lock = __vma_shareable_lock(vma);
> +
>  		/*
> -		 * Skip VMAs without shareable locks. Per the design in commit
> -		 * 40549ba8f8e0, these will be handled by remove_inode_hugepages()
> -		 * called after this function with proper locking.
> +		 * If we can't get the shareable lock, set ZAP_FLAG_NO_UNSHARE
> +		 * to skip PMD unsharing. We still proceed with unmapping to
> +		 * ensure pages are properly freed, which is critical for punch
> +		 * hole operations that expect immediate page freeing.
>  		 */
> -		if (!__vma_shareable_lock(vma))
> -			goto skip;
> -
> +		if (!have_shareable_lock)
> +			local_flags |= ZAP_FLAG_NO_UNSHARE;

This is quite a head-spinning thing.

First of all, as David pointed out, that comment is misleading as it looks like
__vma_shareable_lock() performs a taking action which is not true, so that should
reworded.

Now, the thing is:

- Prior to commit dd83609b8898("hugetlbfs: skip VMAs without shareable
  locks in hugetlb_vmdelete_list"), we were unconditionally calling
  huge_pmd_unshare(), which asserted the vma lock and we didn't hold it.
  My question would be that Mike's vma-lock addition happened in 2022,
  how's that we didn't see this sooner? It should be rather easy to
  trigger? I'm a bit puzzled.

- Ok, since there's nothing to unshare, we skip the vma here and
  remove_inode_hugepages() should take care of it.
  But that seems to be troublesome because on punch-hole operation pages
  don't get freed.

- So instead, we just skip the unsharing operation and keep carrying
  with the unmapping/freeing in __unmap_hugepage_range.

I don't know but to me it seems that we're going to large extends to fix
an assertion.
So, the thing is, can't we check __vma_shareable_lock in
__unmap_hugepage_range() and only call huge_pmd_unshare() if we need to?

 

-- 
Oscar Salvador
SUSE Labs

