Return-Path: <linux-kernel+bounces-791376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCD4B3B61C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EE116F5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439BD2882A7;
	Fri, 29 Aug 2025 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LD1Nrqu5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ReWrNDcr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ec5Fgr2o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g93LYDPC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C2285419
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456708; cv=none; b=G1DDPhYR6f6EEneySrh+AhUm+Xb8Px8/TYcHX3m2UoEtWGhaZrzNZh7i6gv/pGdOxOnGmJI3/D4Q6p15KzSSwJrlyqawIbenQeCZC1UaVmoq2olMdbg3fhwx28dJ7ozeZ17Xokxg57uJiRVmcibaszIT7jHp4dSl2SJVeTJ/rsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456708; c=relaxed/simple;
	bh=h3aoMguPpHdYtM+ZBswlJsTKmCRnkWrfNqHOLMaRWrg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RsXMMtYaIXWwg6jXBJ3WUZae28k11mGZnokc5kWeDUMpwGoHJ9asS10pyECCH7zMM4x8x0VSacyJxQj0nKi/YqCp8owXED08uv64B9w8vw7lle4Dn4RrmrDz4gZB1sTXDCvq+YBsL+B0P5U1QDPgIjYMZd4XRx14rxiCwYFltbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LD1Nrqu5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ReWrNDcr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ec5Fgr2o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g93LYDPC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7BF420544;
	Fri, 29 Aug 2025 08:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756456705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z7GKbEJp2q0NJZLK9xT8xoBwCMAwop0nDLxGQi+CYvs=;
	b=LD1Nrqu5miXvXeMlejIPLJhx71Lsqnj9/g2MzaQ7HrJlIokC4kuBpHBniyDm53tCC8y4E5
	Y+QiIYZtBbZ5X4g2EvSL8iM15lcvCkj8uwMYtSkheMedX8apLxk+nNnjQU1uyc30aGotIJ
	sVl+M8NofbzOPeowzKHtrQNmzOIa1v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756456705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z7GKbEJp2q0NJZLK9xT8xoBwCMAwop0nDLxGQi+CYvs=;
	b=ReWrNDcrmlc0zUcS457iKwyc82Ll1+7PbSJdv08rE6pjRWVM0lzw52PiT0cUZb1J5pXB9R
	+KAxWEDg8RfcYvCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ec5Fgr2o;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g93LYDPC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756456704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z7GKbEJp2q0NJZLK9xT8xoBwCMAwop0nDLxGQi+CYvs=;
	b=ec5Fgr2ofFtsnDAcNSeGjZ5qqdTkSUh/GQR9RfBHOCWF267zjJnLulZUIxXSA69OhPCxtY
	Ca59y8MOEuY4HCIldpV5lIKYj6HSzJjhVeGyvUAZS3/BIkHpEfCfWRB3H/Fawqf3LLgVV4
	A3fMBepXvJrCQTOY1ArR1zOc3xWi7po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756456704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z7GKbEJp2q0NJZLK9xT8xoBwCMAwop0nDLxGQi+CYvs=;
	b=g93LYDPCILhrhfTopoUnYlnAwa/Q9q8sGWT4FL40wUX2bePTUmpfwhInx3/CFIbGU2WYIH
	ktD7hMrSFz5h32Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F27C13A3E;
	Fri, 29 Aug 2025 08:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NdA6JQBnsWjmIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 29 Aug 2025 08:38:24 +0000
Message-ID: <77058118-b481-4c45-8f86-d9a67ea6a187@suse.cz>
Date: Fri, 29 Aug 2025 10:38:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH
 allocations
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Mel Gorman <mgorman@techsingularity.net>,
 kernel-dev@igalia.com, Helen Koike <koike@igalia.com>,
 Matthew Wilcox <willy@infradead.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, neil@brown.name
References: <20250814172245.1259625-1-cascardo@igalia.com>
 <10cdada2-f28f-4868-b821-4a13ed627e76@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <10cdada2-f28f-4868-b821-4a13ed627e76@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,google.com,suse.com,cmpxchg.org,nvidia.com,techsingularity.net,igalia.com,infradead.org,gmail.com,chromium.org,brown.name];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email,suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C7BF420544
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 8/29/25 10:36, Vlastimil Babka wrote:
> On 8/14/25 19:22, Thadeu Lima de Souza Cascardo wrote:
>> Commit 524c48072e56 ("mm/page_alloc: rename ALLOC_HIGH to
>> ALLOC_MIN_RESERVE") is the start of a series that explains how __GFP_HIGH,
>> which implies ALLOC_MIN_RESERVE, is going to be used instead of
>> __GFP_ATOMIC for high atomic reserves.
>> 
>> Commit eb2e2b425c69 ("mm/page_alloc: explicitly record high-order atomic
>> allocations in alloc_flags") introduced ALLOC_HIGHATOMIC for such
>> allocations of order higher than 0. It still used __GFP_ATOMIC, though.
>> 
>> Then, commit 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
>> non-blocking allocations accesses reserves") just turned that check for
>> !__GFP_DIRECT_RECLAIM, ignoring that high atomic reserves were expected to
>> test for __GFP_HIGH.
>> 
>> This leads to high atomic reserves being added for high-order GFP_NOWAIT
>> allocations and others that clear __GFP_DIRECT_RECLAIM, which is
>> unexpected. Later, those reserves lead to 0-order allocations going to the
>> slow path and starting reclaim.
>> 
>> From /proc/pagetypeinfo, without the patch:
>> 
>> Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
>> Node    0, zone    DMA32, type   HighAtomic      1      8     10      9      7      3      0      0      0      0      0
>> Node    0, zone   Normal, type   HighAtomic     64     20     12      5      0      0      0      0      0      0      0
>> 
>> With the patch:
>> 
>> Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
>> Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
>> Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
>> 
>> Fixes: 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves")
>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>> Tested-by: Helen Koike <koike@igalia.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: NeilBrown <neilb@suse.de>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
> 
> Agreed with others that this change matches the original intention and it
> must have been an oversight. Also found nothing to the contrary in the
> original threads.

Oops, forgot to add

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

>> ---
>>  mm/page_alloc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 2ef3c07266b3..bf52e3bef626 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4219,7 +4219,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>>  		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
>>  			alloc_flags |= ALLOC_NON_BLOCK;
>>  
>> -			if (order > 0)
>> +			if (order > 0 && (alloc_flags & ALLOC_MIN_RESERVE))
>>  				alloc_flags |= ALLOC_HIGHATOMIC;
>>  		}
>>  
> 


