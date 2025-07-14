Return-Path: <linux-kernel+bounces-730374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0EDB043C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6087B7BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5FA25BEF4;
	Mon, 14 Jul 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nxdXJQJj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/9owpvsE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UEp/JhV3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8ymYQLTy"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB919F43A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506625; cv=none; b=mb3+cTryZRvN17yiaRB1spH0vSiiFS2xmBv2v6hgu8tkEOJqvxNKplIGFGOzsfMh721B4U/YTe1D5skfyoe92HiIcqLAT8UnlK6MZprfVPO6OS65TTfYDxH6g0HW9WY9tp6NvxTkZVeeXxnDwR1cRdZkF+JKkm4KTYsMj+/3SRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506625; c=relaxed/simple;
	bh=m9yCiSNZSmJwgUxoqijTBdCZ95opNkeTLt0JzyhQJEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M89EKjQbn/6TGJc6xOgacnkLwzkjPhtszSKmwzsq+xmSJGWOn0VPyPFTpJqY6FuOFNeMiUGIOx6td+PXVAxxQIWaY4b2aoiRi3cX4yAgkyGWf9YdgxUiUnf6K4SPJrwipIcilsDQDid0XGpkOCIEPdmVxPdEEtA0WOrnAI4rJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nxdXJQJj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/9owpvsE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UEp/JhV3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8ymYQLTy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E4E021182;
	Mon, 14 Jul 2025 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igW3S1j6dab1xsXokYHODMX9e/lWyaqpQ1rt1YYZsQk=;
	b=nxdXJQJj8Svbg2QZsy1dTnKhb/DemJqit491tiWHBzb6kpWeazsPMS9fw0m/2di9JVWTjW
	TEzTj0KlZkNB7oRX8VLDDJUhEn3jtuix4cPMBkJmSjyMhlLvcXWX+YdNRLAdgBlrmd/lIe
	b6su+3H37obswteLZGEqWeDZQRNUxR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igW3S1j6dab1xsXokYHODMX9e/lWyaqpQ1rt1YYZsQk=;
	b=/9owpvsEpEfkgHwgoBpGw+3Ou7+7kZPs9As4UHtQ5aTM8zfbWr05SnV6V8Xx1zHfOJ4C0A
	UqSJqr4gfwHGmQDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="UEp/JhV3";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8ymYQLTy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752506620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igW3S1j6dab1xsXokYHODMX9e/lWyaqpQ1rt1YYZsQk=;
	b=UEp/JhV3Eo6fnkYJquT2iPie8qpvSctmvBTHlFK5kQTd3JWh+uOLX+dhZp3ArCvtptxCZF
	uRg1MfwG7XLIrXDomaAmd9ub4OvZZDOJjThOULOv5hENmKePYAlP3x4DgLMwboBMaQ3xdt
	iNkKp8xMJZLeuztWaF6VHQUOo6SshKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752506620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igW3S1j6dab1xsXokYHODMX9e/lWyaqpQ1rt1YYZsQk=;
	b=8ymYQLTy+zVlB1aU9tSWWE/GbkyceqEVEfsH2itBKo6eNfdl/5+nskJwQJFOPf/Tx9S8Ml
	VtYsU5Osi1exAPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 775F9138A1;
	Mon, 14 Jul 2025 15:23:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uwDeGPsgdWiKNAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 14 Jul 2025 15:23:39 +0000
Date: Mon, 14 Jul 2025 16:23:37 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 3/5] mm/mseal: small cleanups
Message-ID: <4ivcbimxvtojuvawrxnasgnhbepeohpix6owvm5y5scpyq45ui@3dutrp66wsgz>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <4df6b55c407b5e6890429d4d7cc39e8f28948975.1752497324.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df6b55c407b5e6890429d4d7cc39e8f28948975.1752497324.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2E4E021182
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Mon, Jul 14, 2025 at 02:00:38PM +0100, Lorenzo Stoakes wrote:
> Drop the wholly unnecessary set_vma_sealed() and vma_is_sealed() helpers
> which are used only once, and place VMA_ITERATOR() declarations in the
> correct place.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mseal.c |  9 +--------
>  mm/vma.h   | 16 ++--------------
>  2 files changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 1308e88ab184..adbcc65e9660 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -15,11 +15,6 @@
>  #include <linux/sched.h>
>  #include "internal.h"
> 
> -static inline void set_vma_sealed(struct vm_area_struct *vma)
> -{
> -	vm_flags_set(vma, VM_SEALED);
> -}
> -
>  static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		struct vm_area_struct **prev, unsigned long start,
>  		unsigned long end, vm_flags_t newflags)
> @@ -36,7 +31,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		goto out;
>  	}
> 
> -	set_vma_sealed(vma);
> +	vm_flags_set(vma, VM_SEALED);
>  out:
>  	*prev = vma;
>  	return ret;
> @@ -53,7 +48,6 @@ static int check_mm_seal(unsigned long start, unsigned long end)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long nstart = start;
> -
>  	VMA_ITERATOR(vmi, current->mm, start);
> 
>  	/* going through each vma to check. */
> @@ -78,7 +72,6 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
>  {
>  	unsigned long nstart;
>  	struct vm_area_struct *vma, *prev;
> -
>  	VMA_ITERATOR(vmi, current->mm, start);
> 
>  	vma = vma_iter_load(&vmi);
> diff --git a/mm/vma.h b/mm/vma.h
> index 6515045ba342..d17f560cf53d 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -560,31 +560,19 @@ struct vm_area_struct *vma_iter_next_rewind(struct vma_iterator *vmi,
>  }
> 
>  #ifdef CONFIG_64BIT
> -
> -static inline bool vma_is_sealed(struct vm_area_struct *vma)
> -{
> -	return (vma->vm_flags & VM_SEALED);
> -}

I actually don't hate this helper...

> -
> -/*
> - * check if a vma is sealed for modification.
> - * return true, if modification is allowed.
> - */
> +/* Check if a vma is sealed for modification. */
>  static inline bool can_modify_vma(struct vm_area_struct *vma)

As you're in the area, vma_can_modify() maybe?

In any case, LGTM.

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

