Return-Path: <linux-kernel+bounces-864373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A57BFAA48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BED1E506936
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A64A2FD663;
	Wed, 22 Oct 2025 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4qfcI6r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X0RTACQM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K83XgDro";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+6wW0A1s"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D62FB628
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118915; cv=none; b=NhIeWbIt52HusElMkND/uxdw/Jzd2f/rkuzCCD6saDmOpzG6O3unOOCWdB1yaPtlOBL7TNMkXBbLcg7HSnEruZVnRDG9+9E8+JlOBgJBbXeMw0V9ZVWQd7ub8bQ5KiYBkktGjN7pDTbJRVJfwr8j2veCudwzdWxgcfy0sBETNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118915; c=relaxed/simple;
	bh=WO01mj/+wlpLQf0/2MGpIA101ai/vXdRNvf95sDfD6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LR6dL/9hij7VQ4G1+EXA2MVq8QvpIorZBDh1VMZF2HOCQhJJ15eE39q112HlokUTqZSU8qcCblI5Jfx9K2NcRF9nhc/R+yglRGi8t+Cwg9JW8/nFWnSYHWagkkijRnOF/BITVPqE4AAVVnoU39hcot0oSffYbsH+R3miLaqpmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4qfcI6r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X0RTACQM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K83XgDro; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+6wW0A1s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0B4E1F391;
	Wed, 22 Oct 2025 07:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761118907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IyMepcd4W5MPP+4gvZWdITUoUK6eWB4LJfO2TGYih3A=;
	b=N4qfcI6rt57CUtIaQc6nrgU0p7OzqAlREmluxXMM6nL9oA5XSUP1hDS6h3vHCBxu64jGG1
	xxdh+9l3wG7RmbnvZEvo6PtaXi6oYld9nBejctIGjxVtwxH9n2djsC8FVpQvUL5ztFc9qA
	hJ58uKabubYS7C88yJ70cnulg0k9gGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761118907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IyMepcd4W5MPP+4gvZWdITUoUK6eWB4LJfO2TGYih3A=;
	b=X0RTACQMH1wVYG6SLYNXbD7nYU3lhCSDd49BoZUCtxAtlmE0j/1QmVygCjUgcLKVTLlboF
	cFRYkEbJdMxoN5Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761118903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IyMepcd4W5MPP+4gvZWdITUoUK6eWB4LJfO2TGYih3A=;
	b=K83XgDro23x0GxnfL0xB7ImodBzV6YWr1ypYTLcC2zcS8qX4RGBBTRRURTbHVj5uEbxWKf
	ver6b5ICUFcrPYqiwAro8sXhs5Iws1yFOz2ypjJ8xOkx9VrMH0kYarEFS/gaYtd1IwOuPF
	HqwYRzirDVsrly4kcckvp6M7mcFJZmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761118903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IyMepcd4W5MPP+4gvZWdITUoUK6eWB4LJfO2TGYih3A=;
	b=+6wW0A1s5sffs4tcTetxyvMthnyqjI2fmi17/znVHyopXAqHbtfU+qXe4M5ExETTig3n5l
	NocvmL0zZLD2paAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99D401339F;
	Wed, 22 Oct 2025 07:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cMrEJLeK+Gj0HwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 22 Oct 2025 07:41:43 +0000
Message-ID: <1ed60558-cd6d-43c4-b8e2-e9492e5aac2e@suse.cz>
Date: Wed, 22 Oct 2025 09:41:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Consider PCP pages as part of
To: jinji zhong <jinji.z.zhong@gmail.com>, joshua.hahnjy@gmail.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, david@redhat.com, feng.han@honor.com,
 hannes@cmpxchg.org, jackmanb@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, liulu.liu@honor.com, lorenzo.stoakes@oracle.com,
 mhocko@suse.com, rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com,
 weixugc@google.com, yuanchu@google.com, zhengqi.arch@bytedance.com,
 zhongjinji@honor.com, ziy@nvidia.com
References: <20251021145427.3580609-1-joshua.hahnjy@gmail.com>
 <20251021180435.11789-1-jinji.z.zhong@gmail.com>
Content-Language: en-US
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
In-Reply-To: <20251021180435.11789-1-jinji.z.zhong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 10/21/25 20:04, jinji zhong wrote:
>> Zhongjinji, thank you for your patch!

Hi,

>>> When free_pages becomes critically low, the kernel prevents other tasks
>>> from entering the slow path to ensure that reclaiming tasks can
>>> successfully allocate memory.
>>> 
>>> This blocking is important to avoid memory contention with reclaiming
>>> tasks. However, in some cases it is unnecessary because the PCP list may
>>> already contain sufficient pages, as freed pages are first placed there
>>> and are not immediately visible to the buddy system.
>>
>>Based on my limiting understanding of pcp free pages, I had a concern here
>>on whether this would really provide the desired effect. That is, the pages
>>in the pcp are not available to the buddy allocator unless we drain the pcp
>>lists (and this operation is not free), I was unsure if there was a clear
>>benefit to allowing the system to go unblocked.
> 
> The purpose of this patch is to account for the memory in the pcp list
> within memalloc_reserve, which would allow more tasks to enter the slow
> path. For critical tasks, entering the slow path represents a better
> alternative than being throttled until kswapd wakes up.

Were you able to measure the benefits of the patch? What are the "critical
tasks"? Usually such task use mlockall() to avoid allocating memory during
operation. Maybe we should instead extempt some task priority classes from
being throttled?

>>If we are already at the point where we need the pcp pages to have enough
>>free pages to go over the watermark, perhaps it makes sense to just block
>>tasks for now, and enter direct reclaim? Allowing more allocations might
>>lead the system to be in a worse state than before, and will have to
>>go through direct reclaim anyways.
>>
>>Please let me know if this makes sense!
>> 
>>> By accounting PCP pages as part of pfmemalloc_reserve, we can reduce
>>> unnecessary blocking and improve system responsiveness under low-memory
>>> conditions.
>>> 
>>> Signed-off-by: zhongjinji <zhongjinji@honor.com>
>>
>>[...snip...]
>>
>>> +int zone_pcp_pages_count(struct zone *zone)
>>> +{
>>> +	struct per_cpu_pages *pcp;
>>> +	int total_pcp_pages = 0;
>>> +	int cpu;
>>> +
>>> +	for_each_online_cpu(cpu) {
>>> +		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>>> +		total_pcp_pages += pcp->count;
>>
>>Could this be racy? What is stopping the pcp count from decreasing while we
>>are iterating over each online cpu, over each managed zone? Under the
>>memory pressure conditions that this patch is aiming to fix, I think that
>>there is a good chance the numer we get here will be very outdated by the time
>>we try to take action based on it, and we may require the system to be
>>further stalled since we don't take action to reclaim memory.
> 
> Thank you, Joshua. Indeed, the pcp->count might be outdated by the time. 
> And kswapd will fail to allocate memory if the pages in the pcp lists are
> on other CPUs. While drain_all_pages() may be triggered by direct reclaim
> on other CPUs, some hard-to-predict scenarios might still exist.
> 
> Perhaps performing drain_all_pages() before actually calling
> throttle_direct_reclaim() would be better.

Draining makes more sense indeed. But it should be backed by data showing
improvement. As you say, draining is probably already happening via direct
reclaim.

> Like the following code.
> 
> @@ -6535,6 +6535,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
>  static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
>  					nodemask_t *nodemask)
>  {
> +	bool drained = false;
>  	struct zoneref *z;
>  	struct zone *zone;
>  	pg_data_t *pgdat = NULL;
> @@ -6570,6 +6571,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
>  	 * for remote pfmemalloc reserves and processes on different nodes
>  	 * should make reasonable progress.
>  	 */
> +retry:
>  	for_each_zone_zonelist_nodemask(zone, z, zonelist,
>  					gfp_zone(gfp_mask), nodemask) {
>  		if (zone_idx(zone) > ZONE_NORMAL)
> @@ -6586,6 +6588,12 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
>  	if (!pgdat)
>  		goto out;
>  
> +	if (!drained) {
> +		drained = true;
> +		drain_all_pages(NULL);
> +		goto retry;
> +	}
> +
>  	/* Account for the throttling */
>  	count_vm_event(PGSCAN_DIRECT_THROTTLE);
> 
>>[...snip...]
>>
>>Please feel free to let me know if I am missing something obvious. Again,
>>I am not very familiar with the pcp code, so there is a good chance that
>>you are seeing something that I am not : -)
>>
>>Thank you for the patch, I hope you have a great day!
>>Joshua
>>


