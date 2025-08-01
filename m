Return-Path: <linux-kernel+bounces-753117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FADB17ED8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93194E1622
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3321B9F6;
	Fri,  1 Aug 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcXugp8Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GoN+ii0L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcXugp8Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GoN+ii0L"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2321772A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039362; cv=none; b=bEZnFKY6VNjndhfbZE5KbVWGW432unjIAh71XTc0jeBY53U8yFR3KW/eGLyxcroB1xzkE/vHNqLiOcNu74Yqw7bA/nqRHkcS9IG9NzONjhp7+wdKPIPRGKfW0SsVEcZDEFl4Pa9431LMIIH60qZivE69rgmgmQ+Fb8L+yKBmMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039362; c=relaxed/simple;
	bh=dUgYmYjjeTzDgnASqFnWvj13ow2dWS6/77QxuYHwZSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vix5b5N+6E1dt60fzexU73kWIAkT/Vbk8SAdzOZn6F8uecA/W06B5kx5nO0mt3MWmJRA8tchfvqokWCOKrHW/f4f+K/4s+wMc9fmaPGKa6hHyyAQ1zQa1dIzIQqwLmKWM+8bG7mAQRel8OA/KowM5IYcLw+hNxSEMkvUamFyuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcXugp8Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GoN+ii0L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcXugp8Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GoN+ii0L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 585461F80E;
	Fri,  1 Aug 2025 09:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754039356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/nWfWjsRxa4zZXPCyYoVYdfMMPMyCon5WH9IIv4kj0w=;
	b=mcXugp8Q8keXtokLcOzWbt23XCBEIXNuByQw/W92gdUFVaZfgJpBh70Eoe7Z98ARcbzlV7
	RIASGKX55MQE1gZbgSRUsJb5A20ba8OJMtY9Aje18CdQXNg0mITM1Jdh+eKsmX03hROiq6
	sf5wvJDaUrPmcXFbWPaKGAaICAzgXVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754039356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/nWfWjsRxa4zZXPCyYoVYdfMMPMyCon5WH9IIv4kj0w=;
	b=GoN+ii0LAIUXDdF2VnCqC8K9Y4IoJE48bhgepE7XLdJNGSDThAg3LlncyE7T6K2Rh2x/RQ
	8hrzpjydIZWjeVCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mcXugp8Q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GoN+ii0L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754039356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/nWfWjsRxa4zZXPCyYoVYdfMMPMyCon5WH9IIv4kj0w=;
	b=mcXugp8Q8keXtokLcOzWbt23XCBEIXNuByQw/W92gdUFVaZfgJpBh70Eoe7Z98ARcbzlV7
	RIASGKX55MQE1gZbgSRUsJb5A20ba8OJMtY9Aje18CdQXNg0mITM1Jdh+eKsmX03hROiq6
	sf5wvJDaUrPmcXFbWPaKGAaICAzgXVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754039356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/nWfWjsRxa4zZXPCyYoVYdfMMPMyCon5WH9IIv4kj0w=;
	b=GoN+ii0LAIUXDdF2VnCqC8K9Y4IoJE48bhgepE7XLdJNGSDThAg3LlncyE7T6K2Rh2x/RQ
	8hrzpjydIZWjeVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 359FC13876;
	Fri,  1 Aug 2025 09:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VQvHDDyEjGiMNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 01 Aug 2025 09:09:16 +0000
Message-ID: <a58759b9-2847-4ffc-914b-c96336385c81@suse.cz>
Date: Fri, 1 Aug 2025 11:09:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: change vma_start_read() to drop RCU lock on
 failure
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250731151919.212829-1-surenb@google.com>
 <20250731151919.212829-2-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250731151919.212829-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 585461F80E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/31/25 17:19, Suren Baghdasaryan wrote:
> vma_start_read() can drop and reacquire RCU lock in certain failure
> cases. It's not apparent that the RCU session started by the caller of
> this function might be interrupted when vma_start_read() fails to lock
> the vma. This might become a source of subtle bugs and to prevent that
> we change the locking rules for vma_start_read() to drop RCU read lock
> upon failure. This way it's more obvious that RCU-protected objects are
> unsafe after vma locking fails.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>

IIRC you considered it yourself, I just convinced you to try :)

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I thought we didn't need the drop rcu lock for -EAGAIN, but that would just
made it more complex for little gain, so this looks good to me.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit:

> @@ -223,11 +227,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	MA_STATE(mas, &mm->mm_mt, address, address);
>  	struct vm_area_struct *vma;
>  
> -	rcu_read_lock();
>  retry:
> +	rcu_read_lock();
>  	vma = mas_walk(&mas);
> -	if (!vma)
> +	if (!vma) {
> +		rcu_read_unlock();
>  		goto inval;
> +	}
>  
>  	vma = vma_start_read(mm, vma);
>  	if (IS_ERR_OR_NULL(vma)) {
> @@ -241,6 +247,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  		/* Failed to lock the VMA */
>  		goto inval;
>  	}
> +
> +	rcu_read_unlock();

Would it make sense to put this under the comment below?

> +
>  	/*
>  	 * At this point, we have a stable reference to a VMA: The VMA is
>  	 * locked and we know it hasn't already been isolated.

Give it continues like this:

         * From here on, we can access the VMA without worrying about which

         * fields are accessible for RCU readers.

> @@ -249,16 +258,14 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	 */
>  
>  	/* Check if the vma we locked is the right one. */
> -	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
> -		goto inval_end_read;
> +	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
> +		vma_end_read(vma);
> +		goto inval;
> +	}
>  
> -	rcu_read_unlock();
>  	return vma;
>  
> -inval_end_read:
> -	vma_end_read(vma);
>  inval:
> -	rcu_read_unlock();
>  	count_vm_vma_lock_event(VMA_LOCK_ABORT);
>  	return NULL;
>  }

