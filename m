Return-Path: <linux-kernel+bounces-744056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28120B10788
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18B2189602F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF926056C;
	Thu, 24 Jul 2025 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nLYGEiFm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3pZ1FqzC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pXb2Y2nA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qCLsHA3A"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2AF25F995
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352084; cv=none; b=uY/u+WL0OZL295GgPDd5VgSwfaIZtaWm1a30DFwOQ6n8ulUmbIpBtpa9WYXBQVc3NEc5wz/Idu25ALMwCx8INFBKEXcg4GsWyxL6QuyrM/2rx3qY18m+zTmBVSwg2vsRhaPOc5Cj0v3zhCuQ3tFQsU5k7d/Wo7XNFBsZ6Ikm5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352084; c=relaxed/simple;
	bh=kvSXqq7PScJCLdtSOUtnbUeNRpLXZRuYSSdiMck7zRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rl46nZHMb+ED49HTUdTIa2MSWiYmF4SxJ9g5sx3HO22w6YElWZ+C5xV04633Iqw3U4rVUuvpkBjSMrf7tJzJbUwm/gdF6bZWV+huMBE+ott8/N1ta3916eCOXl8sjDPvxa3kRgh890anHeUnf9L6vfsd4jGCFjTMLkzluKPkk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nLYGEiFm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3pZ1FqzC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pXb2Y2nA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qCLsHA3A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E71B81F394;
	Thu, 24 Jul 2025 10:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753352075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Cb3/++MEwl7Z6VekxEpy01dqQjPmNLRWlpN/hgrJ/0=;
	b=nLYGEiFmJWcNZBbspiqCJwcNcMunIUHTB60lvcPgvxIcIE/XJAuWTDWEwMHfeObvM8/mrz
	CxpabEYPF/Ft8tdIIEY+rqSPXk5UU5LTkwGkZRE4t6PzSJ9UlPchBvzKtrYK2yfvsQiWLo
	I7QB+3qrQrIGg8eqTctUNhNKka376as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753352075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Cb3/++MEwl7Z6VekxEpy01dqQjPmNLRWlpN/hgrJ/0=;
	b=3pZ1FqzCngimCdeVftWke/jvyzKpGeawiUtGe4sxuDTnxwqDMXrfsihFbOUbjW7setThRN
	08zR/bAzYNi9ssAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pXb2Y2nA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qCLsHA3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753352074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Cb3/++MEwl7Z6VekxEpy01dqQjPmNLRWlpN/hgrJ/0=;
	b=pXb2Y2nA7gnPs0wQRFBGmFLFOMHVdrjoha8c1iaEen+cFPiUR8H9tJ6Lf2YzFE3YckcWoj
	5YkGPL6PC62tEby/+360OS/lCPBRci94BEBRaBTlvJErhUVUuTmvRwZcA868vtFit4GRJv
	RTDyrkIXfqhIgahq57ErRCdsGmRptFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753352074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Cb3/++MEwl7Z6VekxEpy01dqQjPmNLRWlpN/hgrJ/0=;
	b=qCLsHA3A5D7w1CNsjxh7caLdz7/xGHhI4RxMjyx5KTK87zG2ksYKYOYL6Sg0Cp8DXjz8xF
	690yjisK+nkGXyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D15D4136DC;
	Thu, 24 Jul 2025 10:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hii9MooHgmiUYgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 24 Jul 2025 10:14:34 +0000
Message-ID: <45cd4505-39a0-404d-9840-a0a75fcc707f@suse.cz>
Date: Thu, 24 Jul 2025 12:14:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: skip quarantine if object is still accessible
 under RCU
Content-Language: en-US
To: Jann Horn <jannh@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250723-kasan-tsbrcu-noquarantine-v1-1-846c8645976c@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250723-kasan-tsbrcu-noquarantine-v1-1-846c8645976c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E71B81F394
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,arm.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -3.01

On 7/23/25 16:59, Jann Horn wrote:
> Currently, enabling KASAN masks bugs where a lockless lookup path gets a
> pointer to a SLAB_TYPESAFE_BY_RCU object that might concurrently be
> recycled and is insufficiently careful about handling recycled objects:
> KASAN puts freed objects in SLAB_TYPESAFE_BY_RCU slabs onto its quarantine
> queues, even when it can't actually detect UAF in these objects, and the
> quarantine prevents fast recycling.
> 
> When I introduced CONFIG_SLUB_RCU_DEBUG, my intention was that enabling
> CONFIG_SLUB_RCU_DEBUG should cause KASAN to mark such objects as freed
> after an RCU grace period and put them on the quarantine, while disabling
> CONFIG_SLUB_RCU_DEBUG should allow such objects to be reused immediately;
> but that hasn't actually been working.

Was the "allow reuse immediately" not working also before you introduced
CONFIG_SLUB_RCU_DEBUG, or is it a side-effect of that? IOW should we add a
Fixes: here?

> I discovered such a UAF bug involving SLAB_TYPESAFE_BY_RCU yesterday; I
> could only trigger this bug in a KASAN build by disabling
> CONFIG_SLUB_RCU_DEBUG and applying this patch.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/kasan/common.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index ed4873e18c75..9142964ab9c9 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -230,16 +230,12 @@ static bool check_slab_allocation(struct kmem_cache *cache, void *object,
>  }
>  
>  static inline void poison_slab_object(struct kmem_cache *cache, void *object,
> -				      bool init, bool still_accessible)
> +				      bool init)
>  {
>  	void *tagged_object = object;
>  
>  	object = kasan_reset_tag(object);
>  
> -	/* RCU slabs could be legally used after free within the RCU period. */
> -	if (unlikely(still_accessible))
> -		return;
> -
>  	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
>  			KASAN_SLAB_FREE, init);
>  
> @@ -261,7 +257,22 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>  	if (!kasan_arch_is_ready() || is_kfence_address(object))
>  		return false;
>  
> -	poison_slab_object(cache, object, init, still_accessible);
> +	/*
> +	 * If this point is reached with an object that must still be
> +	 * accessible under RCU, we can't poison it; in that case, also skip the
> +	 * quarantine. This should mostly only happen when CONFIG_SLUB_RCU_DEBUG
> +	 * has been disabled manually.
> +	 *
> +	 * Putting the object on the quarantine wouldn't help catch UAFs (since
> +	 * we can't poison it here), and it would mask bugs caused by
> +	 * SLAB_TYPESAFE_BY_RCU users not being careful enough about object
> +	 * reuse; so overall, putting the object into the quarantine here would
> +	 * be counterproductive.
> +	 */
> +	if (still_accessible)
> +		return false;
> +
> +	poison_slab_object(cache, object, init);
>  
>  	/*
>  	 * If the object is put into quarantine, do not let slab put the object
> @@ -519,7 +530,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
>  	if (check_slab_allocation(slab->slab_cache, ptr, ip))
>  		return false;
>  
> -	poison_slab_object(slab->slab_cache, ptr, false, false);
> +	poison_slab_object(slab->slab_cache, ptr, false);
>  	return true;
>  }
>  
> 
> ---
> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
> change-id: 20250723-kasan-tsbrcu-noquarantine-e207bb990e24
> 


