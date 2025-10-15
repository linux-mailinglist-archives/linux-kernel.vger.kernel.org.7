Return-Path: <linux-kernel+bounces-854550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F22BDEB14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8447D507246
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ACA32A3DE;
	Wed, 15 Oct 2025 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GHGDsIXc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/SqK4l1+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GHGDsIXc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/SqK4l1+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4F2F5A01
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533916; cv=none; b=K/fsTjs3/3hs9HCyhzfTWC/uofh0qVwjBmMNXqC3VDQ5FdMVG+RSB9JOXOaXTWx54/DVw86C8sLWD7N6Zekm9eMJMf+MnEgLzaLoLEm5qJZvzTdKMhvxzbuP06WvkMC2Z1OVehiRVin0VJZneKxIQr6hEwNl0rerWKEHd8Es8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533916; c=relaxed/simple;
	bh=L8tgYCvezrXpgXYvuiq70Pm4O62l02+U0kZQJxNs1Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiCQ3gS9P/oKhLzxg2nwVSfaiAHKh0HTi/HmMIKNzGzMa00tomPmf5JazCF6Af8Q2Dzu4U2C0h9dCXeoFS4XLc8VMdh448pSZ8MfYh4XwIfQx+pWftlbeQ9DTp/pjofzw8epeSNQZh1WkJ1qr6XQxZLqRpQNK4IyBXOU4qdI3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GHGDsIXc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/SqK4l1+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GHGDsIXc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/SqK4l1+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EA9B1FC31;
	Wed, 15 Oct 2025 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760533912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AQi+dhYrJXBSl35q86HIQWqi7/gBcyLZtUjN+URTrIw=;
	b=GHGDsIXcxEv/qA3WtSEleATzL8n9WUyhWSuW4rUwe2e27Sue8pBRKzauOfTu4K+W/HK+1j
	KVFeO5Ig4zWfouc6/BGf3rukn686T73O7ygvTHcR1XQapU+3KURgK9BeujH+ZDGB3WfIqP
	gCqCHpfQ2uZL6GeeqQeEJbjYN3TdJao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760533912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AQi+dhYrJXBSl35q86HIQWqi7/gBcyLZtUjN+URTrIw=;
	b=/SqK4l1+xY1NZEwTQgtgkeFKYwvPHejVfo+N4AlHaoz1WSXhV/ycQ6bz0TPZdpa0nVs4hM
	2zdCJ14m1uVS7vBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760533912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AQi+dhYrJXBSl35q86HIQWqi7/gBcyLZtUjN+URTrIw=;
	b=GHGDsIXcxEv/qA3WtSEleATzL8n9WUyhWSuW4rUwe2e27Sue8pBRKzauOfTu4K+W/HK+1j
	KVFeO5Ig4zWfouc6/BGf3rukn686T73O7ygvTHcR1XQapU+3KURgK9BeujH+ZDGB3WfIqP
	gCqCHpfQ2uZL6GeeqQeEJbjYN3TdJao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760533912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AQi+dhYrJXBSl35q86HIQWqi7/gBcyLZtUjN+URTrIw=;
	b=/SqK4l1+xY1NZEwTQgtgkeFKYwvPHejVfo+N4AlHaoz1WSXhV/ycQ6bz0TPZdpa0nVs4hM
	2zdCJ14m1uVS7vBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 088C313A29;
	Wed, 15 Oct 2025 13:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IdTBAZid72gXOwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Oct 2025 13:11:52 +0000
Message-ID: <06b0c6fb-0123-4482-ac07-80f0faec3532@suse.cz>
Date: Wed, 15 Oct 2025 15:11:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] slab: clear OBJEXTS_ALLOC_FAIL when freeing a slab
Content-Language: en-US
To: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20251015125945.481950-1-hao.ge@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251015125945.481950-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,oracle.com:email,kylinos.cn:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/15/25 14:59, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
> But we did not clear it when freeing the slab. Since OBJEXTS_ALLOC_FAIL and
> MEMCG_DATA_OBJEXTS currently share the same bit position, during the
> release of the associated folio, a VM_BUG_ON_FOLIO() check in
> folio_memcg_kmem() is triggered because it was mistakenly assumed that
> a valid folio->memcg_data was not cleared before freeing the folio.
> 
> When freeing a slab, we clear slab->obj_exts if the obj_ext array has been
> successfully allocated. So let's clear OBJEXTS_ALLOC_FAIL when freeing
> a slab if the obj_ext array allocated fail to allow them to be returned
> to the buddy system more smoothly.

Thanks!

> Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Since we changed the approach completely, I think we should not carry over
the previously added review tags in this case.

> ---
> v4: Based on the discussion between Vlastimil and Harry,
>     modify the solution to clear OBJEXTS_ALLOC_FAIL when freeing a slab.
>     This does seem more reasonable. Thank you both.
> ---
>  mm/slab.h | 26 ++++++++++++++++++++++++++
>  mm/slub.c |  6 ++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 078daecc7cf5..52424d6871bd 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -547,6 +547,28 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
>  }
>  
> +/*
> + * objexts_clear_alloc_fail -  Clear the OBJEXTS_ALLOC_FAIL for
> + * the slab object extension vector associated with a slab.
> + * @slab: a pointer to the slab struct
> + */
> +static inline void objexts_clear_alloc_fail(struct slab *slab)
> +{
> +	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
> +
> +#ifdef CONFIG_MEMCG
> +	/*
> +	 * obj_exts should be either NULL, a valid pointer with
> +	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
> +	 */
> +	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
> +		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
> +	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
> +#endif
> +
> +	obj_exts &= ~OBJEXTS_ALLOC_FAIL;
> +	WRITE_ONCE(slab->obj_exts, obj_exts);
> +}

This is much larger than necessary I think. See below.

>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>                          gfp_t gfp, bool new_slab);
>  
> @@ -557,6 +579,10 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>  	return NULL;
>  }
>  
> +static inline void objexts_clear_alloc_fail(struct slab *slab)
> +{
> +}
> +
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>  
>  static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
> diff --git a/mm/slub.c b/mm/slub.c
> index b1f15598fbfd..80166a4a62f9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2169,6 +2169,12 @@ static inline void free_slab_obj_exts(struct slab *slab)
>  {
>  	struct slabobj_ext *obj_exts;
>  
> +	/*
> +	 * If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
> +	 * Therefore, we should clear the OBJEXTS_ALLOC_FAIL flag first when freeing a slab.
> +	 */
> +	objexts_clear_alloc_fail(slab);
> +
>  	obj_exts = slab_obj_exts(slab);
>  	if (!obj_exts)
>  		return;

It should be enough that this return path does "slab->obj_exts = 0;" no?



