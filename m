Return-Path: <linux-kernel+bounces-799561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E6CB42D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E21176644
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EA82C15B0;
	Wed,  3 Sep 2025 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mba1dxRk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b+4sSnp/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mba1dxRk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b+4sSnp/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046B1DE4FB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943195; cv=none; b=F03g1Qp4+m5t672amp+1XerH3LRgPi30tPPldNk5qL3Ys1ekkI4sTzg3gY2gE2BN24z6lCOVQgBaOJAEKcnZvwpjc/xChGDOPemWe6ge5P2i4tVsA+8Qjy7scGMSDCr3EIErekJ7uyOQICbKznbeWuO/Yl+hwodbekKUjQq/p2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943195; c=relaxed/simple;
	bh=Q4ffysBcSzkUpQ/xL/imoRgYt4YkMlsZAVyAi4gwY84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr/wxksSPbKSgDUz6hGHO5l4SI+eEFUvknbvRLmbIc2sh1R8WwiRdPAJDy0SqVuCvF3d15qo7gmRuaUs9Nt+kfE+hzkNgHJkofZxCrUAkS8OppPJlt3QtTT2kC+KvBsTVymNz3ocoyqyE+43vpHQNfpK4VkkIQmTtLpoPbmLkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mba1dxRk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b+4sSnp/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mba1dxRk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b+4sSnp/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82E621F453;
	Wed,  3 Sep 2025 23:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756943191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eMNILRIi5fl/7TwqQWQ4yuaKzHKs01WiGg9m5ceGQU=;
	b=Mba1dxRk6YJ+ojtmKh2eM23n6aBa7qmcScqSqLFlBjjaBao1ruTriFaPSPqjQ3KQDQ6Xbr
	94tKTa1feEyu68WFWI2SOVhSzeB7tU/AUrZfalq0VTFS/J80Pet1EAWL7g1LT8tpkldqHA
	dCgAxpn8X+Uydy7q6utrteKOJeNf5Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756943191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eMNILRIi5fl/7TwqQWQ4yuaKzHKs01WiGg9m5ceGQU=;
	b=b+4sSnp/O2EzFyl1Y0ZcQT+8n7OZ8LNQdSgw5SGiJmEfAEDyw8B4GFxhbqXhUMdp+iZFo6
	/prhKG/x4D7hudCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756943191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eMNILRIi5fl/7TwqQWQ4yuaKzHKs01WiGg9m5ceGQU=;
	b=Mba1dxRk6YJ+ojtmKh2eM23n6aBa7qmcScqSqLFlBjjaBao1ruTriFaPSPqjQ3KQDQ6Xbr
	94tKTa1feEyu68WFWI2SOVhSzeB7tU/AUrZfalq0VTFS/J80Pet1EAWL7g1LT8tpkldqHA
	dCgAxpn8X+Uydy7q6utrteKOJeNf5Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756943191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eMNILRIi5fl/7TwqQWQ4yuaKzHKs01WiGg9m5ceGQU=;
	b=b+4sSnp/O2EzFyl1Y0ZcQT+8n7OZ8LNQdSgw5SGiJmEfAEDyw8B4GFxhbqXhUMdp+iZFo6
	/prhKG/x4D7hudCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BDF713888;
	Wed,  3 Sep 2025 23:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qZlTHlbTuGiObwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 03 Sep 2025 23:46:30 +0000
Date: Thu, 4 Sep 2025 00:46:34 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, 
	lorenzo.stoakes@oracle.com, kernel-team@android.com, android-mm@google.com, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
Message-ID: <qa7b7pvrycejnn6pjytxysu57xckhexupjrzefmk4j5hlaxka3@ayeg2vzpfe3r>
References: <20250903232437.1454293-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903232437.1454293-1-kaleshsingh@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed, Sep 03, 2025 at 04:24:35PM -0700, Kalesh Singh wrote:
> The check against the max map count (sysctl_max_map_count) was
> open-coded in several places. This led to inconsistent enforcement
> and subtle bugs where the limit could be exceeded.
> 
> For example, some paths would check map_count > sysctl_max_map_count
> before allocating a new VMA and incrementing the count, allowing the
> process to reach sysctl_max_map_count + 1:
> 
>     int do_brk_flags(...)
>     {
>         if (mm->map_count > sysctl_max_map_count)
>             return -ENOMEM;
> 
>         /* We can get here with mm->map_count == sysctl_max_map_count */
> 
>         vma = vm_area_alloc(mm);
>         ...
>         mm->map_count++   /* We've now exceeded the threshold. */
>     }

I think this should be fixed separately, and sent for stable.

> 
> To fix this and unify the logic, introduce a new function,
> exceeds_max_map_count(), to consolidate the check. All open-coded
> checks are replaced with calls to this new function, ensuring the
> limit is applied uniformly and correctly.

Thanks! In general I like the idea.

> 
> To improve encapsulation, sysctl_max_map_count is now static to
> mm/mmap.c. The new helper also adds a rate-limited warning to make
> debugging applications that exhaust their VMA limit easier.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  include/linux/mm.h | 11 ++++++++++-
>  mm/mmap.c          | 15 ++++++++++++++-
>  mm/mremap.c        |  7 ++++---
>  mm/nommu.c         |  2 +-
>  mm/util.c          |  1 -
>  mm/vma.c           |  6 +++---
>  6 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..d4e64e6a9814 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -192,7 +192,16 @@ static inline void __mm_zero_struct_page(struct page *page)
>  #define MAPCOUNT_ELF_CORE_MARGIN	(5)
>  #define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
>  
> -extern int sysctl_max_map_count;
> +/**
> + * exceeds_max_map_count - check if a VMA operation would exceed max_map_count
> + * @mm: The memory descriptor for the process.
> + * @new_vmas: The number of new VMAs the operation will create.
> + *
> + * Returns true if the operation would cause the number of VMAs to exceed
> + * the sysctl_max_map_count limit, false otherwise. A rate-limited warning
> + * is logged if the limit is exceeded.
> + */
> +extern bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vmas);

No new "extern" in func declarations please.

>  
>  extern unsigned long sysctl_user_reserve_kbytes;
>  extern unsigned long sysctl_admin_reserve_kbytes;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7306253cc3b5..693a0105e6a5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		return -EOVERFLOW;
>  
>  	/* Too many mappings? */
> -	if (mm->map_count > sysctl_max_map_count)
> +	if (exceeds_max_map_count(mm, 0))
>  		return -ENOMEM;

If the brk example is incorrect, isn't this also wrong? /me is confused
>  
>  	/*
> @@ -1504,6 +1504,19 @@ struct vm_area_struct *_install_special_mapping(
>  int sysctl_legacy_va_layout;
>  #endif
>  
> +static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
> +
> +bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vmas)
> +{
> +	if (unlikely(mm->map_count + new_vmas > sysctl_max_map_count)) {
> +		pr_warn_ratelimited("%s (%d): Map count limit %u exceeded\n",
> +				    current->comm, current->pid,
> +				    sysctl_max_map_count);

I'm not entirely sold on the map count warn, even if it's rate limited. It
sounds like something you can hit in nasty edge cases and nevertheless flood
your dmesg (more frustrating if you can't fix the damn program).

In any case, if we are to make the checks more strict, we should also add
asserts around the place. Though there's a little case in munmap() we can indeed
go over temporarily, on purpose.

-- 
Pedro

