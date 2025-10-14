Return-Path: <linux-kernel+bounces-853328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35423BDB4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509B742648D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D81306D49;
	Tue, 14 Oct 2025 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YALW1a/l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fbttqre+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3H0+biV7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IavnuAfd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662B2DE6F5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474712; cv=none; b=ZTwfGyiy8vLYobterNM0VMZek8+T2vI2a2X1wzKcnD9voRGqO8E91NkQ4ekc5t67xq4uAUay5qoSxa2HS/1gpNasOcQJqP4t2HQq1ULO0NGwihziFDlIu6mU8m2rXY2NZDgx1t5B5x5epBlYLOqMZEqOKfNYu1UOAq5Zdk2hx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474712; c=relaxed/simple;
	bh=Dd3WNXoQ/owcZvMPTJmB0fXCkt1Mfov5Jm1xf5z1CHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giVL3QNgWAydDQP6OJbNmyk/4ywS27CKUYJT91wTqpeVWJ7XOSgpoKp2bIwMmgbmWbj71nLvfcjAZf1jiYXL5TS8NSmToU80TOve5MK6TUpCWw6oUO94LJt4inoMGHGNtPNR8LU+XPp61g5f2FeWD2pI496bnHyXHIvol0S+Pro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YALW1a/l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fbttqre+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3H0+biV7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IavnuAfd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F7C121D69;
	Tue, 14 Oct 2025 20:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760474708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DFB4VLZVNkhkwmFjrnl3j5HQXx6c9X+PtZHCBSlbb+k=;
	b=YALW1a/liwYXGW9N/46t7X9vtpUHF+XQyj8cFJ8hL4pq96N8KM84i2UJqoSfF64mn5403g
	caEO8LbtwJlN/ymLljYsHXwAOxAEMcfg1eYrOm8khkMjBK7A7Gt2FmsURrIvSwp9RKpYda
	TlM+HyZBodpIfqfWAckuIY5swo/27Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760474708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DFB4VLZVNkhkwmFjrnl3j5HQXx6c9X+PtZHCBSlbb+k=;
	b=fbttqre+La237CmAVxZL9iQXX8LyCZqS0sGkF4fxYmTF6D6AleVMs9AVMOTg3U9BR7jir4
	5qNxtriM7MLvFhAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760474707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DFB4VLZVNkhkwmFjrnl3j5HQXx6c9X+PtZHCBSlbb+k=;
	b=3H0+biV7xd6tUhXprGiINLQJA+Vf71yt3zB2HXTYhQp4SfiNK/Ozqak9WNVMZs0PWTACVi
	C//+nl/l3WDRYitR0O/IR3bxZnsUPeShQ/R3Hv6HOx2a+1fU0rxRyQuS76eYtI9aJBWN2o
	NdtUEDjCugC34NJjbZ3xxwxbNxr20EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760474707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DFB4VLZVNkhkwmFjrnl3j5HQXx6c9X+PtZHCBSlbb+k=;
	b=IavnuAfd7L9gFwmo/tloQti+B1s4YfBjvyAZaY6Cj22Nn+bUFu6jOatv51lUU++eZS1YKB
	v6fixdAVf7FNvJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F7DC13A44;
	Tue, 14 Oct 2025 20:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CuHWDlO27mgMZAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 14 Oct 2025 20:45:07 +0000
Message-ID: <20564b23-a3eb-4282-acec-be8913a84daa@suse.cz>
Date: Tue, 14 Oct 2025 22:45:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Batch page freeing in
 free_frozen_page_commit
Content-Language: en-US
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>, Kiryl Shutsemau <kirill@shutemov.name>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel-team@meta.com
References: <20251014192827.851389-1-joshua.hahnjy@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251014192827.851389-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.980];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 10/14/25 21:28, Joshua Hahn wrote:
> On Tue, 14 Oct 2025 07:50:10 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
>> Before returning, free_frozen_page_commit calls free_pcppages_bulk using
>> nr_pcp_free to determine how many pages can appropritately be freed,
>> based on the tunable parameters stored in pcp. While this number is an
>> accurate representation of how many pages should be freed in total, it
>> is not an appropriate number of pages to free at once using
>> free_pcppages_bulk, since we have seen the value consistently go above
>> 2000 in the Meta fleet on larger machines.
>> 
>> As such, perform batched page freeing in free_pcppages_bulk by using
>> pcp->batch. In order to ensure that other processes are not starved of the
>> zone lock, free both the zone lock and pcp lock to yield to other threads.
>> 
>> Note that because free_frozen_page_commit now performs a spinlock inside the
>> function (and can fail), the function may now return with a freed pcp.
>> To handle this, return true if the pcp is locked on exit and false otherwise.
>> 
>> In addition, since free_frozen_page_commit must now be aware of what UP
>> flags were stored at the time of the spin lock, and because we must be
>> able to report new UP flags to the callers, add a new unsigned long*
>> parameter UP_flags to keep track of this.
> 
> [...snip...]
> 
> Hello Andrew, I hope you are doing well! I was wondering if you could help
> adding this as a fixlet for the patch I am writing this reply to. Vlastimil
> kindly pointed out that they should never go negative, so checking for
> 0-ness should be sufficient and more readable than the <= checks.
> 
> I think it is OK to leave the changelog in 0/3 unchanged, since it will not go
> into the commit history and Vlastimil has already left a correction. But
> please let me know if you would like me to add a correction for that as well.
> 
> Thank you as always, for your help! I hope you have a great day!
> Joshua
> 
> ...
> 
> Since to_free and pcp->count cannot become negative, make the checks into an
> equality check instead.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

For the patch with this fixup:

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6d544521e49c..fd46a982ce3c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2884,7 +2884,7 @@ static bool free_frozen_page_commit(struct zone *zone,
>                 free_pcppages_bulk(zone, to_free_batched, pcp, pindex);
>                 to_free -= to_free_batched;
> 
> -               if (to_free <= 0 || pcp->count <= 0)
> +               if (to_free == 0 || pcp->count == 0)
>                         break;
> 
>                 pcp_spin_unlock(pcp);


