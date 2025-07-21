Return-Path: <linux-kernel+bounces-739485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94549B0C6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899FC4E038D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290F2DECDD;
	Mon, 21 Jul 2025 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2vWZ28ax";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9WO+WbrX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2vWZ28ax";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9WO+WbrX"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841062DCBEC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109147; cv=none; b=XjqG7Rff3FG7OwHq6HJnt5mrkgZxVoo5uUGCdssGwfnL2F3TiTL45cVmdz5sZ5lvBEo8ELQHtWbORWANg7lj7PnwvCbuhOCTqVSyd9P8OWnhuo7KVbX7PHBSW2kwLSvGs7FGBpyxJdQN0IVtzwqXMEKocJrAl71EU28AVccaSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109147; c=relaxed/simple;
	bh=42xK17JgjuuWFYA6/LJbkmYX83RYBSGOU6LfFyFQKpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ru/vxOhHEXh2Ys5UuHPuy1HIQPaPgb1spduwiscxML8+X5Hz99Y8mIvKNWB1c6GB/Q3gRVyqfomx9wmzaycYJwCPbPc0uLYsuF1DuZSHz5pvgXOupQvbnf4mycmd2Crrau+h2vugBZQyn21L5bojs0CwBdHX1TeJRvjCXrFakTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2vWZ28ax; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9WO+WbrX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2vWZ28ax; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9WO+WbrX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8530621752;
	Mon, 21 Jul 2025 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753109143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d7SGCVYtEjDNaXFaQZ2ssh+nlngfPMA8MpKwS0BkF5A=;
	b=2vWZ28axOHJI25NNgRDTmLDZsm4uOIcQNruz5VoGfCYvHYuJ9GwZdIQXolpLPVi4EswjJ+
	28zIXqVf/vzwZGHHReB4opkY2mAii8+3O6aQWswI6487Sc2nuQT4TybHD6JzUhDfHw+8fb
	Hg+pQBylHwlSt1sv8YbhiH4uux8Ff2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753109143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d7SGCVYtEjDNaXFaQZ2ssh+nlngfPMA8MpKwS0BkF5A=;
	b=9WO+WbrXKxPXjr6s/BHLKV3kycNnITAUL/i8AROkWh4HaCOZu+mv5TidakOODY7EHavh5b
	7EhPiVPx3yvhpEDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753109143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d7SGCVYtEjDNaXFaQZ2ssh+nlngfPMA8MpKwS0BkF5A=;
	b=2vWZ28axOHJI25NNgRDTmLDZsm4uOIcQNruz5VoGfCYvHYuJ9GwZdIQXolpLPVi4EswjJ+
	28zIXqVf/vzwZGHHReB4opkY2mAii8+3O6aQWswI6487Sc2nuQT4TybHD6JzUhDfHw+8fb
	Hg+pQBylHwlSt1sv8YbhiH4uux8Ff2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753109143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d7SGCVYtEjDNaXFaQZ2ssh+nlngfPMA8MpKwS0BkF5A=;
	b=9WO+WbrXKxPXjr6s/BHLKV3kycNnITAUL/i8AROkWh4HaCOZu+mv5TidakOODY7EHavh5b
	7EhPiVPx3yvhpEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EC88136A8;
	Mon, 21 Jul 2025 14:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tlq/GpdSfmjAawAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Jul 2025 14:45:43 +0000
Message-ID: <8d6ab730-985e-4ac1-bd3b-0eb240f9eaff@suse.cz>
Date: Mon, 21 Jul 2025 16:45:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] stackdepot: Make max number of pools boot-time
 configurable
Content-Language: en-US
To: Matt Fleming <matt@readmodwrite.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
 Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Oscar Salvador <osalvador@suse.de>, Matt Fleming <mfleming@cloudflare.com>
References: <20250718153928.94229-1-matt@readmodwrite.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250718153928.94229-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cloudflare.com,google.com,gmail.com,suse.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/18/25 17:39, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> We're hitting the WARN in depot_init_pool() about reaching the stack
> depot limit because we have long stacks that don't dedup very well.
> 
> Introduce a new start-up parameter to allow users to set the number of
> maximum stack depot pools.
> 
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -36,11 +36,11 @@
>  #include <linux/memblock.h>
>  #include <linux/kasan-enabled.h>
>  
> -#define DEPOT_POOLS_CAP 8192
> -/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
> -#define DEPOT_MAX_POOLS \
> -	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
> -	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
> +/*
> + * The pool_index is offset by 1 so the first record does not have a 0 handle.
> + */
> +static unsigned int stack_max_pools __read_mostly =
> +	MIN((1LL << DEPOT_POOL_INDEX_BITS) - 1, 8192);
>  
>  static bool stack_depot_disabled;
>  static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
> @@ -62,7 +62,7 @@ static unsigned int stack_bucket_number_order;
>  static unsigned int stack_hash_mask;
>  
>  /* Array of memory regions that store stack records. */
> -static void *stack_pools[DEPOT_MAX_POOLS];
> +static void **stack_pools;

Also nice that (AFAIU) we now save this previously statically allocated
array's memory if stackdepot is built-in but not used by anything.

>  /* Newly allocated pool that is not yet added to stack_pools. */
>  static void *new_pool;
>  /* Number of pools in stack_pools. */
> @@ -101,6 +101,34 @@ static int __init disable_stack_depot(char *str)
>  }
>  early_param("stack_depot_disable", disable_stack_depot);
>  
> +static int __init parse_max_pools(char *str)
> +{
> +	const long long limit = (1LL << (DEPOT_POOL_INDEX_BITS)) - 1;
> +	unsigned int max_pools;
> +	int rv;
> +
> +	rv = kstrtouint(str, 0, &max_pools);
> +	if (rv)
> +		return rv;
> +
> +	if (max_pools < 1024) {
> +		pr_err("stack_depot_max_pools below 1024, using default of %u\n",
> +		       stack_max_pools);
> +		goto out;
> +	}
> +
> +	if (max_pools > limit) {
> +		pr_err("stack_depot_max_pools exceeds %lld, using default of %u\n",
> +		       limit, stack_max_pools);
> +		goto out;
> +	}

Maybe we could bound the requested value to between 1024 and limit instead
of falling back to the default and completely ignoring it when it's out of
the range?

> +	stack_max_pools = max_pools;
> +out:
> +	return 0;
> +}
> +early_param("stack_depot_max_pools", parse_max_pools);
> +

