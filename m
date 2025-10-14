Return-Path: <linux-kernel+bounces-852223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3435EBD879C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613F5189F60B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162462EAD0F;
	Tue, 14 Oct 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nj7rRfsj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c4Xca0Am";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Io0poZM3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4PUfDwN7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A942E7BD3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434686; cv=none; b=LmSjOxXiOg7vw0yeKpUtozzktfEbGYykhrBap/F/gDEljAq7HHRZ6ee1CC77WBg9kP/9/BqGqujsWF/mFUwRwKfEjw/vSAd93PTQQ7DfgEitrG1kSW40fdccIhZqkMcjNDZe7+hLr6u7PVPw5nkfuvPZO4UeNJOPN5irf0H69hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434686; c=relaxed/simple;
	bh=HmCr2+1qBtDqADmfcVVa5ig0Y2l/CFGpX+vnBAqMG68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTpqQRCVlt1r9X4tLyxu/o9+gsUu7MmCeu+kmA5g9L0/66KtLYhCt12ppt0GKIVkThBA30G5rwzOmth3mh5BFpKTlqsp5IPqn7w9epTaIUn1SZqWDVNKFHnanYKoUqshHzmJZU+MZXCHfyGEFPBrNTvGs8YpZBC4S0SiuQ2lTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nj7rRfsj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c4Xca0Am; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Io0poZM3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4PUfDwN7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3581621C6D;
	Tue, 14 Oct 2025 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760434682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GxweviCfbHTzHfkDC+5iB0uWxUZ2QwSsss9bq+bzTM0=;
	b=nj7rRfsjcIadwIJ0Zd1MIOHuJ8TdDwYFe4kFeaKlnRgYAiJ8/hzLjIM9iDZEoEJkhT3f9H
	BScO+j/M2Ki+lQzcEwElQkCxCD2ZrSs+TrBe32jnqFWrWTwJVyF4BFlS8Ax4lha6ZS2yLM
	eN9nWdMjQjgxFWdTd/0zr/j3bxVC+Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760434682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GxweviCfbHTzHfkDC+5iB0uWxUZ2QwSsss9bq+bzTM0=;
	b=c4Xca0AmwyuIuLLGlF/coPlT4yrN+uxiyBP9zqfR2kSAIp48Zazkz8p9bEEOa9NFMPUV/P
	FnPH5LzMC2L6u8AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Io0poZM3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4PUfDwN7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760434681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GxweviCfbHTzHfkDC+5iB0uWxUZ2QwSsss9bq+bzTM0=;
	b=Io0poZM3x0cLILcQ8Le1VQ7Xzo6N2QZVIPimwZLsRFAEe2rTmZDHLdepQr1a1aU010TgQD
	+j1LzpH9zW6Ai45V4hn0nIG65y9TmIr7dlLb2OSSQxU2SFZoJ6MoecYUCcY0PGUk70Yjpz
	zFxGEk7GnHfwjMimXD9cc+n7MqAllzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760434681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GxweviCfbHTzHfkDC+5iB0uWxUZ2QwSsss9bq+bzTM0=;
	b=4PUfDwN7JyzyfPeeeF5UFS0HEBJ8cuapXo5PF8jU96pC6/YlxQLGPkYvjqNEEdxkslctXl
	wJCe5Htc/gHSjoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CFC6139B0;
	Tue, 14 Oct 2025 09:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1yS0BvkZ7miNVwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 14 Oct 2025 09:38:01 +0000
Message-ID: <428ec528-5471-4152-bcb6-d36dd32c3311@suse.cz>
Date: Tue, 14 Oct 2025 11:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mm/page_alloc: Batch page freeing in
 free_frozen_page_commit
Content-Language: en-US
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>, Kiryl Shutsemau <kirill@shutemov.name>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel-team@meta.com
References: <20251013190812.787205-1-joshua.hahnjy@gmail.com>
 <20251013190812.787205-4-joshua.hahnjy@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251013190812.787205-4-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3581621C6D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,cmpxchg.org:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

On 10/13/25 21:08, Joshua Hahn wrote:
> Before returning, free_frozen_page_commit calls free_pcppages_bulk using
> nr_pcp_free to determine how many pages can appropritately be freed,
> based on the tunable parameters stored in pcp. While this number is an
> accurate representation of how many pages should be freed in total, it
> is not an appropriate number of pages to free at once using
> free_pcppages_bulk, since we have seen the value consistently go above
> 2000 in the Meta fleet on larger machines.
> 
> As such, perform batched page freeing in free_pcppages_bulk by using
> pcp->batch member. In order to ensure that other processes are not
> starved of the zone lock, free both the zone lock and pcp lock to yield to
> other threads.
> 
> Note that because free_frozen_page_commit now performs a spinlock inside the
> function (and can fail), the function may now return with a freed pcp.
> To handle this, return true if the pcp is locked on exit and false otherwise.
> 
> In addition, since free_frozen_page_commit must now be aware of what UP
> flags were stored at the time of the spin lock, and because we must be
> able to report new UP flags to the callers, add a new unsigned long*
> parameter UP_flags to keep track of this.
> 
> The following are a few synthetic benchmarks, made on three machines. The
> first is a large machine with 754GiB memory and 316 processors.
> The second is a relatively smaller machine with 251GiB memory and 176
> processors. The third and final is the smallest of the three, which has 62GiB
> memory and 36 processors.
> 
> On all machines, I kick off a kernel build with -j$(nproc).
> Negative delta is better (faster compilation)
> 
> Large machine (754GiB memory, 316 processors)
> make -j$(nproc)
> +------------+---------------+-----------+
> | Metric (s) | Variation (%) | Delta(%)  |
> +------------+---------------+-----------+
> | real       |        0.8070 |  - 1.4865 |
> | user       |        0.2823 |  + 0.4081 |
> | sys        |        5.0267 |  -11.8737 |
> +------------+---------------+-----------+
> 
> Medium machine (251GiB memory, 176 processors)
> make -j$(nproc)
> +------------+---------------+----------+
> | Metric (s) | Variation (%) | Delta(%) |
> +------------+---------------+----------+
> | real       |        0.2806 |  +0.0351 |
> | user       |        0.0994 |  +0.3170 |
> | sys        |        0.6229 |  -0.6277 |
> +------------+---------------+----------+
> 
> Small machine (62GiB memory, 36 processors)
> make -j$(nproc)
> +------------+---------------+----------+
> | Metric (s) | Variation (%) | Delta(%) |
> +------------+---------------+----------+
> | real       |        0.1503 |  -2.6585 |
> | user       |        0.0431 |  -2.2984 |
> | sys        |        0.1870 |  -3.2013 |
> +------------+---------------+----------+
> 
> Here, variation is the coefficient of variation, i.e. standard deviation / mean.
> 
> Suggested-by: Chris Mason <clm@fb.com>
> Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  mm/page_alloc.c | 66 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8ecd48be8bdd..e85770dd54bd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2818,12 +2818,22 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
>  	return high;
>  }
>  
> -static void free_frozen_page_commit(struct zone *zone,
> +/*
> + * Tune pcp alloc factor and adjust count & free_count. Free pages to bring the
> + * pcp's watermarks below high.
> + *
> + * May return a freed pcp, if during page freeing the pcp spinlock cannot be
> + * reacquired. Return true if pcp is locked, false otherwise.
> + */
> +static bool free_frozen_page_commit(struct zone *zone,
>  		struct per_cpu_pages *pcp, struct page *page, int migratetype,
> -		unsigned int order, fpi_t fpi_flags)
> +		unsigned int order, fpi_t fpi_flags, unsigned long *UP_flags)
>  {
>  	int high, batch;
> +	int to_free, to_free_batched;
>  	int pindex;
> +	int cpu = smp_processor_id();
> +	int ret = true;
>  	bool free_high = false;
>  
>  	/*
> @@ -2861,15 +2871,47 @@ static void free_frozen_page_commit(struct zone *zone,
>  		 * Do not attempt to take a zone lock. Let pcp->count get
>  		 * over high mark temporarily.
>  		 */
> -		return;
> +		return true;
>  	}
>  
>  	high = nr_pcp_high(pcp, zone, batch, free_high);
>  	if (pcp->count < high)
> -		return;
> +		return true;
> +
> +	to_free = nr_pcp_free(pcp, batch, high, free_high);
> +	if (to_free == 0)
> +		return true;

I think this is an unnecessary shortcut. The while() condition covers this
and it's likely rare enough that we don't gain anything (if the goal was to
skip the ZONE_BELOW_HIGH check below).

> +
> +	while (to_free > 0 && pcp->count >= high) {

The "&& pcp->count >= high" is AFAICS still changing how much we free
compared to before the patch. I.e. we might terminate as soon as freeing
"to_free_batched" in some iteration gets us below "high", while previously
we would free the whole "to_free" and get way further below the "high".

It should be changed to "&& pcp->count > 0" intended only to prevent useless
iterations that decrement to_free by to_free_batched while
free_pcppages_bulk() does nothing.

> +		to_free_batched = min(to_free, batch);
> +		free_pcppages_bulk(zone, to_free_batched, pcp, pindex);
> +		to_free -= to_free_batched;
> +		if (pcp->count >= high) {
> +			pcp_spin_unlock(pcp);
> +			pcp_trylock_finish(*UP_flags);
> +
> +			pcp_trylock_prepare(*UP_flags);
> +			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
> +			if (!pcp) {
> +				pcp_trylock_finish(*UP_flags);
> +				ret = false;
> +				break;
> +			}
> +
> +			/*
> +			 * Check if this thread has been migrated to a different
> +			 * CPU. If that is the case, give up and indicate that
> +			 * the pcp is returned in an unlocked state.
> +			 */
> +			if (smp_processor_id() != cpu) {
> +				pcp_spin_unlock(pcp);
> +				pcp_trylock_finish(*UP_flags);
> +				ret = false;
> +				break;
> +			}
> +		}
> +	}
>  
> -	free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
> -			   pcp, pindex);
>  	if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
>  	    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
>  			      ZONE_MOVABLE, 0)) {
> @@ -2887,6 +2929,7 @@ static void free_frozen_page_commit(struct zone *zone,
>  		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
>  			atomic_set(&pgdat->kswapd_failures, 0);
>  	}
> +	return ret;
>  }
>  
>  /*
> @@ -2934,7 +2977,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
>  	pcp_trylock_prepare(UP_flags);
>  	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
>  	if (pcp) {
> -		free_frozen_page_commit(zone, pcp, page, migratetype, order, fpi_flags);
> +		if (!free_frozen_page_commit(zone, pcp, page, migratetype,
> +						order, fpi_flags, &UP_flags))
> +			return;
>  		pcp_spin_unlock(pcp);
>  	} else {
>  		free_one_page(zone, page, pfn, order, fpi_flags);
> @@ -3034,8 +3079,11 @@ void free_unref_folios(struct folio_batch *folios)
>  			migratetype = MIGRATE_MOVABLE;
>  
>  		trace_mm_page_free_batched(&folio->page);
> -		free_frozen_page_commit(zone, pcp, &folio->page, migratetype,
> -					order, FPI_NONE);
> +		if (!free_frozen_page_commit(zone, pcp, &folio->page,
> +				migratetype, order, FPI_NONE, &UP_flags)) {
> +			pcp = NULL;
> +			locked_zone = NULL;
> +		}
>  	}
>  
>  	if (pcp) {


