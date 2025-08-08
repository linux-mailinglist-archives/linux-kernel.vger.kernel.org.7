Return-Path: <linux-kernel+bounces-760366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F09B1EA36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6901AA648B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9032737E3;
	Fri,  8 Aug 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yTD960BM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WynrgH2g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yTD960BM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WynrgH2g"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DA38F91
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662753; cv=none; b=E7TolLSJmSwp2DFbDjZNzzLueElCZY21P0jo+XrdZMLOFapm7ujiKvWGA05C0VE52kNxH836lqsA/eT4V8nO7FAhfKtzlLjDDnEK4LqXwZQPp261mRBmnjy5+ePDoQZVuQyt/IspH/fAUEtZREtelVYvbR7fjCkvm8PqE7eV0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662753; c=relaxed/simple;
	bh=Qjbl47brAlL9xEuf++I1YboBYd8Lf8aJeYmCyUqcMAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZQ1NZGhTYO13GkYgauVxCqTIQ/UrdjGtBUs9cU+JVdzvpaTVre8HqVMQheAvcLjRrPfH8vuwmhUaCXimOp3NBww8cZPCh/D9kLSWu/OHunruBgbfAbzArU/WpUF70aPmCLdcxb4aEDqMiJLCe+JzJRFd88JPMfxdEuQB+f0p/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yTD960BM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WynrgH2g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yTD960BM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WynrgH2g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7983225DD;
	Fri,  8 Aug 2025 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754662749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1GRMQSPxhTZ+osWx629SSW9svJoXEBjayeIwedE8efI=;
	b=yTD960BMWvZFl65pKovXWnG9Sr86Zaq7tPpCLYrHqUOyEPLjyBsOrQBfa50FDk3GSzyX92
	dA4DTboTrPktvecX+PtxwGslST1rMYjBi1KI9btKiKS1hEokNpbB3dJisd8pb48VlfZEJ1
	+8kQxkZeBWaRREEso9j2GRpqrgFd8j8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754662749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1GRMQSPxhTZ+osWx629SSW9svJoXEBjayeIwedE8efI=;
	b=WynrgH2g+K8FPi5dEzooNNv9te2KjW3x8Ytg5C/Hhy+kSvnwe3xEfu8tgFhxYFRKG6fKxY
	kPh8XokrUUjbEQCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yTD960BM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WynrgH2g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754662749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1GRMQSPxhTZ+osWx629SSW9svJoXEBjayeIwedE8efI=;
	b=yTD960BMWvZFl65pKovXWnG9Sr86Zaq7tPpCLYrHqUOyEPLjyBsOrQBfa50FDk3GSzyX92
	dA4DTboTrPktvecX+PtxwGslST1rMYjBi1KI9btKiKS1hEokNpbB3dJisd8pb48VlfZEJ1
	+8kQxkZeBWaRREEso9j2GRpqrgFd8j8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754662749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1GRMQSPxhTZ+osWx629SSW9svJoXEBjayeIwedE8efI=;
	b=WynrgH2g+K8FPi5dEzooNNv9te2KjW3x8Ytg5C/Hhy+kSvnwe3xEfu8tgFhxYFRKG6fKxY
	kPh8XokrUUjbEQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CED31392A;
	Fri,  8 Aug 2025 14:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FdIAIl0HlmghMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 08 Aug 2025 14:19:09 +0000
Message-ID: <571c0a24-6bdf-47cd-b336-efff34f48010@suse.cz>
Date: Fri, 8 Aug 2025 16:19:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 2/3] mm/mremap: catch invalid multi VMA moves earlier
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1754218667.git.lorenzo.stoakes@oracle.com>
 <2b5aad5681573be85b5b8fac61399af6fb6b68b6.1754218667.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <2b5aad5681573be85b5b8fac61399af6fb6b68b6.1754218667.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A7983225DD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 8/3/25 13:11, Lorenzo Stoakes wrote:
> In remap_move() we must account for both a single VMA case, where we are
> permitted to move a single VMA regardless of multi-VMA move eligiblity, and
> multiple VMAs which, of course, must be eligible for such an operation.
> 
> We determine this via vma_multi_allowed().
> 
> Currently, if the first VMA is not eligible, but others are, we will move
> the first then return an error. This is not ideal, as we are performing an
> operation which we don't need to do which has an impact on the memory
> mapping.
> 
> We can very easily determine if this is a multi VMA move prior to the move
> of the first VMA, by checking vma->vm_end vs. the specified end address.
> 
> Therefore this patch does so, and as a result eliminates unnecessary logic
> around tracking whether the first VMA was permitted or not.
> 
> This is most useful for cases where a user attempts to erroneously move
> mutliple VMAs which are not eligible for non-transient reasons - for
> instance, UFFD-armed VMAs, or file-backed VMAs backed by a file system or
> driver which specifies a custom f_op->get_unmapped_area.
> 
> In the less likely instance of a failure due to transient issues such as
> out of memory or mapping limits being hit, the issue is already likely
> fatal and so the fact the operation may be partially complete is
> acceptable.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mremap.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 46f9f3160dff..f61a9ea0b244 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1816,10 +1816,11 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
>  	unsigned long start = vrm->addr;
>  	unsigned long end = vrm->addr + vrm->old_len;
>  	unsigned long new_addr = vrm->new_addr;
> -	bool allowed = true, seen_vma = false;
>  	unsigned long target_addr = new_addr;
>  	unsigned long res = -EFAULT;
>  	unsigned long last_end;
> +	bool seen_vma = false;
> +
>  	VMA_ITERATOR(vmi, current->mm, start);
>  
>  	/*
> @@ -1833,9 +1834,6 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
>  		unsigned long len = min(end, vma->vm_end) - addr;
>  		unsigned long offset, res_vma;
>  
> -		if (!allowed)
> -			return -EFAULT;
> -
>  		/* No gap permitted at the start of the range. */
>  		if (!seen_vma && start < vma->vm_start)
>  			return -EFAULT;
> @@ -1863,9 +1861,14 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
>  		vrm->new_addr = target_addr + offset;
>  		vrm->old_len = vrm->new_len = len;
>  
> -		allowed = vma_multi_allowed(vma);
> -		if (seen_vma && !allowed)
> -			return -EFAULT;
> +		if (!vma_multi_allowed(vma)) {
> +			/* This is not the first VMA, abort immediately. */
> +			if (seen_vma)
> +				return -EFAULT;
> +			/* This is the first, but there are more, abort. */
> +			if (vma->vm_end < end)
> +				return -EFAULT;

Hm there can just also be a gap, and we permit gaps at the end (unlike at
the start), right?

So we might be denying a multi vma mremap for !vma_multi_allowed() reasons
even if it's a single vma and a gap.

AFAICS this is not regressing the behavior prior to d23cb648e365
("mm/mremap: permit mremap() move of multiple VMAs") as such mremap() would
be denied anyway by the "/* We can't remap across vm area boundaries */"
check in check_prep_vma().

So the question is just if we want this odd corner case to behave like this,
and if yes then be more explicit about it perhaps.

> +		}
>  
>  		res_vma = check_prep_vma(vrm);
>  		if (!res_vma)
> @@ -1874,7 +1877,8 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
>  			return res_vma;
>  
>  		if (!seen_vma) {
> -			VM_WARN_ON_ONCE(allowed && res_vma != new_addr);
> +			VM_WARN_ON_ONCE(vma_multi_allowed(vma) &&
> +					res_vma != new_addr);
>  			res = res_vma;
>  		}
>  


