Return-Path: <linux-kernel+bounces-810225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E34B51769
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A4D44E34E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B093203B0;
	Wed, 10 Sep 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zrNMJfWy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Opm/xw4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zrNMJfWy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Opm/xw4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38FE31DDAC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509026; cv=none; b=nXdDAPS8zii7GxWz7X9wDvhxFPDr3QdJQ2HeiHpVcAoWnGVXbMh/gINAjXKpg3RJZZcPcYBS1d9MoZrQmIvINfpucr7iScPhKxoA/MVikrO99PQ7nvpIKOxF1WG8YK7oO5lxkaGeUYqPg7kd5rczwpcqd5aZzZJuyyeGD6ULRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509026; c=relaxed/simple;
	bh=D2huvoDV0kEVwHSxNyxi49TbGRr+Cb2KtSCruwfqdnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luo7bbYoR7k8SwzsLiTbJSKArvMgZna4XzgIxAf3JsBaD2IRR6UcQ8x4J4N/wvt5ygckTUThWO/01MQn/SwFi/Q8q80AhP7PvV5y/uwuG+N8j3lHCSYVYAIbiv4WQ2v/HW4AlwOEJv2yj3ct/ZIQ3OIXhLhRZdQZxb2O8O3HBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zrNMJfWy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Opm/xw4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zrNMJfWy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Opm/xw4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9F0A34AD5;
	Wed, 10 Sep 2025 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mwinq8gsjwiHlcc0O4dms+YN1QO5jIp+XwdfQBarGdk=;
	b=zrNMJfWyTUAJv9/QajN+dxw1lowq1b5xo7iYC33VNiutR13Y0lEpGCugpEYkjJURRCkxSZ
	mxk6mrguZS5K0i8Hfga+ftK/8uO4y+WqJINm/Ezo7gYoy/OWI5Yc1gRoSKiOGn6T4tWsQU
	XnRHR3s1ZN8qpdbw0N7VemCelr+gV30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mwinq8gsjwiHlcc0O4dms+YN1QO5jIp+XwdfQBarGdk=;
	b=+Opm/xw4Gd6mN2XQHPUz9IXWZ2mnZucVz5+xsMOZFbF911FoFRNImuxdMNfz//GY/4p20v
	Bb3tifOUHCaEZ1Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757509022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mwinq8gsjwiHlcc0O4dms+YN1QO5jIp+XwdfQBarGdk=;
	b=zrNMJfWyTUAJv9/QajN+dxw1lowq1b5xo7iYC33VNiutR13Y0lEpGCugpEYkjJURRCkxSZ
	mxk6mrguZS5K0i8Hfga+ftK/8uO4y+WqJINm/Ezo7gYoy/OWI5Yc1gRoSKiOGn6T4tWsQU
	XnRHR3s1ZN8qpdbw0N7VemCelr+gV30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757509022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mwinq8gsjwiHlcc0O4dms+YN1QO5jIp+XwdfQBarGdk=;
	b=+Opm/xw4Gd6mN2XQHPUz9IXWZ2mnZucVz5+xsMOZFbF911FoFRNImuxdMNfz//GY/4p20v
	Bb3tifOUHCaEZ1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91AA813301;
	Wed, 10 Sep 2025 12:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sqhiIJ11wWjwBAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 10 Sep 2025 12:57:01 +0000
Date: Wed, 10 Sep 2025 13:56:59 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 3/9] mm/vma: Add limits to unmap_region() for vmas
Message-ID: <k45ojp4yjaqp56azyuobcsxyqmm5uslo5gq3ddujwfi3ynvkqz@2oncyj3tbnhy>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-4-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-4-Liam.Howlett@oracle.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lists.infradead.org,kvack.org,vger.kernel.org,redhat.com,oracle.com,suse.cz,google.com,suse.com,quicinc.com,huaweicloud.com,tencent.com,gmail.com,kernel.org,infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue, Sep 09, 2025 at 03:09:39PM -0400, Liam R. Howlett wrote:
> Add a limit to the vma search instead of using the start and end of the
> one passed in.
> 
> No functional changes intended.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/vma.c | 6 ++++--
>  mm/vma.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index abe0da33c8446..a648e0555c873 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -474,6 +474,7 @@ void remove_vma(struct vm_area_struct *vma)
>   * Called with the mm semaphore held.
>   */
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> +		unsigned long vma_min, unsigned long vma_max,
>  		struct vm_area_struct *prev, struct vm_area_struct *next)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -481,7 +482,7 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  
>  	tlb_gather_mmu(&tlb, mm);
>  	update_hiwater_rss(mm);
> -	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
> +	unmap_vmas(&tlb, mas, vma, vma_min, vma_max, vma_max,
>  		   /* mm_wr_locked = */ true);
>  	mas_set(mas, vma->vm_end);
>  	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
> @@ -2417,7 +2418,8 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>  
>  		vma_iter_set(vmi, vma->vm_end);
>  		/* Undo any partial mapping done by a device driver. */
> -		unmap_region(&vmi->mas, vma, map->prev, map->next);
> +		unmap_region(&vmi->mas, vma, vma->vm_start, vma->vm_end,
> +			     map->prev, map->next);
>  
>  		return error;
>  	}
> diff --git a/mm/vma.h b/mm/vma.h
> index 9183fe5490090..a9d0cef684ddb 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -261,6 +261,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  void remove_vma(struct vm_area_struct *vma);
>  
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> +		unsigned long min, unsigned long max,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
>  

nit: min and max don't match the arg names in the actual definition of the function

Reviewed-by: Pedro Falcato <pfalcato@suse.de>


-- 
Pedro

