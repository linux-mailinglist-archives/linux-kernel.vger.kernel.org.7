Return-Path: <linux-kernel+bounces-750435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C5B15B50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6401A3ABDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9581C84A0;
	Wed, 30 Jul 2025 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T6xLMsBt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ujvIOBrz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4EpAC/Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7oHL5EC/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602D10E3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867026; cv=none; b=qCjQTPouuC+IMBEvnWojkUq0YRS9uphXVr9ZBhX8XuQTiRMIaBzMBZ1IfXYFmTRPTH+0iKDNX0jRHhlY1R/iVhvA/e2lBtGwwBYYgWpw0DpldB/EqrJQ9cjquShGAPVLNe+i/HyhE745DPGwxnZiGb3tzEohUiNBuP9ioRvgeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867026; c=relaxed/simple;
	bh=sd1hwqGknesAWFyz4gWdFs5KDPlVQMMOBlMdOMOzJv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sddu95ChHFXdFu8Pel52FJIvy29Ojc4Ccv4jNiEcQlV0vsXRjszSaawVxw7DJqzUk9ZRIYhP3ZmGI4MBNd3UtyTJiRgNm+bKk1RS7xd/KD01HT4YCGSdZK0yz+r0bGXbVa8uKOO8ZsTPbjjw+f1QJ8u60OBlmH2T848CsmEkygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T6xLMsBt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ujvIOBrz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I4EpAC/Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7oHL5EC/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC8381F385;
	Wed, 30 Jul 2025 09:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753867017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fxv796BLHEU1HhOUKFxcqZahPQ+5Hc8Qams6OBkyyHY=;
	b=T6xLMsBt/L2+qtNKFM/r0thMmtXo8qWTXlPEkTyxhBma1bguKmqI99zv2xzqZiwz+Q6jka
	DWOvkB9RgbcwEhKnwmytIjz2NEZ1/4Q728fx/Zg/4rcNZGH39onfH+lZyiT1plCwLKigSE
	rHmhVqyRVuAAvhW+vU82D/L9HNma9/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753867017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fxv796BLHEU1HhOUKFxcqZahPQ+5Hc8Qams6OBkyyHY=;
	b=ujvIOBrzlr3Taby2iJuxU8MpMeQv8xcXT9AoKrFEDBw2y2jVI7n+rMruKI//D+qV+CvOL0
	nupy7l9HACAG9aDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753867016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fxv796BLHEU1HhOUKFxcqZahPQ+5Hc8Qams6OBkyyHY=;
	b=I4EpAC/Q0BrvTxpw5SCoMHqCAmH8NCg3pUIQdxaAhQ00H0IwMs/TW/4fJpvjw9VatCr30j
	r9/w8nm6nBNWLWgqroS9oLhxx5qnyH6Cuxs0Q0vayCf1zQ5xk0yp58HXBRkvkq1mS4Xog3
	4EiXAh1FwI6XyeycSn0Ngz0X8lLQnAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753867016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fxv796BLHEU1HhOUKFxcqZahPQ+5Hc8Qams6OBkyyHY=;
	b=7oHL5EC/LkMsLcXsENcSdwY8UYDQ85TaqJOTpXHS71nyDH+eae9gEuNp84KqixpRgRfImX
	xOCeL+gPcffuuRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4DC213942;
	Wed, 30 Jul 2025 09:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tLS/LwjjiWjbZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Jul 2025 09:16:56 +0000
Message-ID: <b084962f-b702-42fb-b2ab-345c57f837d5@suse.cz>
Date: Wed, 30 Jul 2025 11:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: correct type for vmalloc vm_flags fields
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>
References: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,google.com,suse.com,suse.de,kvack.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:mid,oracle.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/29/25 13:49, Lorenzo Stoakes wrote:
> Several functions refer to the unfortunately named 'vm_flags' field when
> referencing vmalloc flags, which happens to be the precise same name used
> for VMA flags.
> 
> As a result these were erroneously changed to use the vm_flags_t type
> (which currently is a typedef equivalent to unsigned long).
> 
> Currently this has no impact, but in future when vm_flags_t changes this
> will result in issues, so change the type to unsigned long to account for
> this.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Harry Yoo <harry.yoo@oracle.com>
> Closes: https://lore.kernel.org/all/aIgSpAnU8EaIcqd9@hyeyoo/

Acked-by: Vlastimil Babka <vbabka@suse.cz>

also for "mm: fixup very disguised vmalloc flags parameter" later in this thread

> ---
>  mm/execmem.c  | 8 ++++----
>  mm/internal.h | 2 +-
>  mm/nommu.c    | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 627e6cf64f4f..2b683e7d864d 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -26,7 +26,7 @@ static struct execmem_info default_execmem_info __ro_after_init;
> 
>  #ifdef CONFIG_MMU
>  static void *execmem_vmalloc(struct execmem_range *range, size_t size,
> -			     pgprot_t pgprot, vm_flags_t vm_flags)
> +			     pgprot_t pgprot, unsigned long vm_flags)
>  {
>  	bool kasan = range->flags & EXECMEM_KASAN_SHADOW;
>  	gfp_t gfp_flags = GFP_KERNEL | __GFP_NOWARN;
> @@ -82,7 +82,7 @@ struct vm_struct *execmem_vmap(size_t size)
>  }
>  #else
>  static void *execmem_vmalloc(struct execmem_range *range, size_t size,
> -			     pgprot_t pgprot, vm_flags_t vm_flags)
> +			     pgprot_t pgprot, unsigned long vm_flags)
>  {
>  	return vmalloc(size);
>  }
> @@ -256,7 +256,7 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
> 
>  static int execmem_cache_populate(struct execmem_range *range, size_t size)
>  {
> -	vm_flags_t vm_flags = VM_ALLOW_HUGE_VMAP;
> +	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
>  	struct vm_struct *vm;
>  	size_t alloc_size;
>  	int err = -ENOMEM;
> @@ -373,7 +373,7 @@ void *execmem_alloc(enum execmem_type type, size_t size)
>  {
>  	struct execmem_range *range = &execmem_info->ranges[type];
>  	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
> -	vm_flags_t vm_flags = VM_FLUSH_RESET_PERMS;
> +	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
>  	pgprot_t pgprot = range->pgprot;
>  	void *p;
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 28d2d5b051df..142d9302c2ae 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1391,7 +1391,7 @@ int migrate_device_coherent_folio(struct folio *folio);
> 
>  struct vm_struct *__get_vm_area_node(unsigned long size,
>  				     unsigned long align, unsigned long shift,
> -				     vm_flags_t vm_flags, unsigned long start,
> +				     unsigned long vm_flags, unsigned long start,
>  				     unsigned long end, int node, gfp_t gfp_mask,
>  				     const void *caller);
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 87e1acab0d64..07504d666d6a 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -126,7 +126,7 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> 
>  void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		unsigned long start, unsigned long end, gfp_t gfp_mask,
> -		pgprot_t prot, vm_flags_t vm_flags, int node,
> +		pgprot_t prot, unsigned long vm_flags, int node,
>  		const void *caller)
>  {
>  	return __vmalloc_noprof(size, gfp_mask);
> --
> 2.50.1


