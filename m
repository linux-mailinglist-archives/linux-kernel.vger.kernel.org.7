Return-Path: <linux-kernel+bounces-837857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63F4BADBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E567A79CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FCC2FD1DD;
	Tue, 30 Sep 2025 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wa3ooWwz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iMDiVHkC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wa3ooWwz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iMDiVHkC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD33064B9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245640; cv=none; b=j75Ynejm4Hpte5plDUBHlwBvz0eEcHfTph8P1E5yeyBITZxlQomOG/GFNqEHk+srnmNetCmSHmAw09SC0kL4ToOxohoIAvbaY01Oka+6w5VBueV1JtqXgJUUi/6evsC3Q/33hUylPnw4Nu2yD9ywPhk572e8QjuTqnrMCYcLJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245640; c=relaxed/simple;
	bh=I2SYnV3DK+ZS+dO0yzqZccRYN1BXhg8zpAfFlXEI5CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na65jIyqYpbwS0pn2b7GN6Z8nVHrWMwGrsWnBXRVo3bL7mEnZfDPb+rsyUH9O5wGTGHLCUBV0utKB49K0Q/KKagEBcbFOwO5c4S1EOQtp56vbhSJLYLvoMmBhTtnuTQ/2//hlv5lUY/nRBl+2NCHRMRY0R90JxPuEGBn5obJkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wa3ooWwz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iMDiVHkC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wa3ooWwz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iMDiVHkC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4845E33694;
	Tue, 30 Sep 2025 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759245635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gd2qT68HUE4EIRZvibhNEqpEUn00xzNgkHBgMBOCgts=;
	b=wa3ooWwzTJsztv853h+TJU4PhMezZDPlASPLWLPPWi9hrK9eZzsFf/HezvGFP0lV1VHDUB
	RA+ZDby28/38iCKSN89M/zqnXs6I5F8MTI7596a6tWLbTLOYhg6cW28dpeArbNbiiDhG92
	vdmmQ4OkVjjwGprXuq+9lF/NuBmGhlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759245635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gd2qT68HUE4EIRZvibhNEqpEUn00xzNgkHBgMBOCgts=;
	b=iMDiVHkC3gUrFDletyifwdSwtGl2Rz/jIG3SVSOq9+i1DJY3i0am4wcMDJ79825NWAi4yG
	79Jm/LdWVm3eb6Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wa3ooWwz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iMDiVHkC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759245635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gd2qT68HUE4EIRZvibhNEqpEUn00xzNgkHBgMBOCgts=;
	b=wa3ooWwzTJsztv853h+TJU4PhMezZDPlASPLWLPPWi9hrK9eZzsFf/HezvGFP0lV1VHDUB
	RA+ZDby28/38iCKSN89M/zqnXs6I5F8MTI7596a6tWLbTLOYhg6cW28dpeArbNbiiDhG92
	vdmmQ4OkVjjwGprXuq+9lF/NuBmGhlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759245635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gd2qT68HUE4EIRZvibhNEqpEUn00xzNgkHBgMBOCgts=;
	b=iMDiVHkC3gUrFDletyifwdSwtGl2Rz/jIG3SVSOq9+i1DJY3i0am4wcMDJ79825NWAi4yG
	79Jm/LdWVm3eb6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 275F21342D;
	Tue, 30 Sep 2025 15:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u8rBB0P122ijaAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Sep 2025 15:20:35 +0000
Message-ID: <5181a289-eee7-42c1-8bdb-7b7bb463babc@suse.cz>
Date: Tue, 30 Sep 2025 17:20:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0] mm/page_alloc: Cleanup for __del_page_from_free_list()
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc: zhongjinji <zhongjinji@honor.com>, akpm@linux-foundation.org,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, liulu.liu@honor.com,
 feng.han@honor.com
References: <20250925085006.23684-1-zhongjinji@honor.com>
 <6fa0e2e3-045e-446f-8ef3-955711b6aa82@suse.cz>
 <F1AB428D-73B3-4E40-939C-2A7BAEA1E73A@nvidia.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <F1AB428D-73B3-4E40-939C-2A7BAEA1E73A@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4845E33694
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,bootlin.com:url,suse.cz:dkim,suse.cz:mid,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 9/30/25 16:28, Zi Yan wrote:
> On 30 Sep 2025, at 9:55, Vlastimil Babka wrote:
> 
>> On 9/25/25 10:50, zhongjinji wrote:
>>> It is unnecessary to set page->private in __del_page_from_free_list().
>>>
>>> If the page is about to be allocated, page->private will be cleared by
>>> post_alloc_hook() before the page is handed out. If the page is expanded
>>> or merged, page->private will be reset by set_buddy_order, and no one
>>> will retrieve the page's buddy_order without the PageBuddy flag being set.
>>> If the page is isolated, it will also reset page->private when it
>>> succeeds.
>>
>> Seems correct.
> 
> This means high order free pages will have head[2N].private set to a non-zero
> value, where head[N*2].private is 1, head[N*(2^2)].private is 2, ...
> head[N*(2^M)].private is M and head[0].private is the actual free page order.

Hm right, tail pages...

> If such a high order free page is used as high order folio, it should be fine.

We don't reinterpret the private field in any of the first X tail pages for
folios? That would be bad too.

> But if user allocates a non-compound high order page and uses split_page()
> to get a list of order-0 pages from this high order page, some pages will
> have non zero private. I wonder if these users are prepared for that.
> 
> For example, kernel/events/ring_buffer.c does it. In its comment, it says
> “set its first page's private to this order; !PagePrivate(page) means it's
> just a normal page.”
> (see https://elixir.bootlin.com/linux/v6.17/source/kernel/events/ring_buffer.c#L634)
> 
> I wonder if non zero page->private would cause any issue there.
> 
> Maybe split_page() should set all page->private to 0.
> 
> Let me know if I get anything wrong.

Maybe we could postpone this optimization until struct pages are shrunk.

>>
>>> Since __del_page_from_free_list() is a hot path in the kernel, it would be
>>> better to remove the unnecessary set_page_private().
>>>
>>> Signed-off-by: zhongjinji <zhongjinji@honor.com>
>>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>
>>> ---
>>>  mm/page_alloc.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index d1d037f97c5f..1999eb7e7c14 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -868,7 +868,6 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
>>>
>>>  	list_del(&page->buddy_list);
>>>  	__ClearPageBuddy(page);
>>> -	set_page_private(page, 0);
>>>  	zone->free_area[order].nr_free--;
>>>
>>>  	if (order >= pageblock_order && !is_migrate_isolate(migratetype))
> 
> 
> Best Regards,
> Yan, Zi


