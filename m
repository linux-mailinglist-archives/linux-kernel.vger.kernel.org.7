Return-Path: <linux-kernel+bounces-725120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4566AFFB01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CE756776F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF719E7D1;
	Thu, 10 Jul 2025 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TohO5Eis";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mqFknoYS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XoLv0PGO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NVRzdLsl"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC8289809
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132945; cv=none; b=o3ZNxsm6X6ptyyaCTzOpK3tPST7WBJSi0Ve7BR5QLIq6a/3FlT6/QJ/bELaEl7hGBqmBuN5NRLK64tBKu32mO+2tWrZg8ht7ohmjJNMcU1mMWHUBXSlHSyqis9ZLvVsqiydKWF1c9VIn5o7+yFOGdeK5wWy5s88nsVTtn6r2bWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132945; c=relaxed/simple;
	bh=OXaJ3J8sbKBSWqPPIUXgvb0M3b6JgtTe6d8u0bmkjs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKPldA0DPUMLx4xK+YNLweyme/W8s29CUGyeP/7aN2C9nM4M3Cd9nNoIcn7aZze/6pci7qNTFQlinfmfnJs44YNgPkkndmAw2nTSawMU5DmZs4x/R+JraRm0hUKbUXXPPIkXV49qeCwt4Zhf5Ef6RVFUcM9LR9K8/UYnfNXEm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TohO5Eis; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mqFknoYS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XoLv0PGO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NVRzdLsl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E847421169;
	Thu, 10 Jul 2025 07:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752132942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MREVp03PPfyBs0emfcgRIIQr8ZJsDSL0PVYOhbsl6R4=;
	b=TohO5EisaQ6Bj6NPEtm2+jBV/dfyp7saXIVz3SF+fXeaB78D/PaoA7bJcjasDaMrIsBNu7
	sm+u2zZ1aDUKeMO9F12r7p3qkquoNkAwL/t7my160rmEfqfzizDMURTBRjp2zQD/YRl9+0
	sQhaQSDt3Sp7mzz5ouYvsiRx4hoPQQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752132942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MREVp03PPfyBs0emfcgRIIQr8ZJsDSL0PVYOhbsl6R4=;
	b=mqFknoYSYK4kfUd4RnZvb+sLsrqbfpaDrh98Zj9/6NIUG14S9raMuOjb+kfqJIVELsInwU
	cZYqusjCKhLZ4JCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752132941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MREVp03PPfyBs0emfcgRIIQr8ZJsDSL0PVYOhbsl6R4=;
	b=XoLv0PGOe8dLecVm5HR0Ka/aYOxpWKSN6qDQrb/5HIbogrElsGwcIM1yMGzPRtiT5Lf1Yc
	nmE2d4nOamxpYXtGPeWk1wWYlqIkmaFpZqKJL0b4X0GlPanNU7nFlK4Wl9BkMYuWS04YrL
	2FJ+evVZug/jq6PZWjXnVEwwqyvW5mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752132941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MREVp03PPfyBs0emfcgRIIQr8ZJsDSL0PVYOhbsl6R4=;
	b=NVRzdLsl0bJ7QH7ULTz7OjOwNAE36kacGDXYg7/sf7aMG2cTzb6kpSagv7ozkZx5EsQjVy
	E8Jyxk++hEos6WBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBE5E136DC;
	Thu, 10 Jul 2025 07:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4gZuMU1tb2jzJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 10 Jul 2025 07:35:41 +0000
Message-ID: <df9c25ac-c290-4c65-ac70-729cddf2aee4@suse.cz>
Date: Thu, 10 Jul 2025 09:35:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: implement "memory.oops_if_bad_pte=1" boot option
To: Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>
References: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
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
In-Reply-To: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/9/25 20:10, Alexey Dobriyan wrote:
> Implement
> 
> 	memory.oops_if_bad_pte=1
> 
> boot option which oopses the machine instead of dreadful
> 
> 	BUG: Bad page map in process
> 
> message.
> 
> This is intended
> for people who want to panic at the slightest provocation and
> for people who ruled out hardware problems which in turn means that
> delaying vmcore collection is counter-productive.
> 
> Linux doesn't (never?) panicked on PTE corruption and even implemented
> ratelimited version of the message meaning it can go for minutes and
> even hours without anyone noticing which is exactly the opposite of what
> should be done to facilitate debugging.
> 
> Not enabled by default.
> 
> Not advertised.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Could we just reuse the existing panic_on_oops? Would anyone want to panic
in this particular without the others, or vice versa?

> ---
> 
>  mm/memory.c                                 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b0cda5aab398..90b92b312802 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -42,6 +42,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/moduleparam.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/numa_balancing.h>
>  #include <linux/sched/task.h>
> @@ -480,6 +481,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
>  			add_mm_counter(mm, i, rss[i]);
>  }
>  
> +/*
> + * Oops instead of printing "Bad page map in process" message and
> + * trying to continue.
> + */
> +static bool oops_if_bad_pte __ro_after_init = false;
> +module_param(oops_if_bad_pte, bool, 0444);
> +
>  /*
>   * This function is called to print an error when a bad pte
>   * is found. For example, we might have a PFN-mapped pte in
> @@ -490,6 +498,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
>  static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  			  pte_t pte, struct page *page)
>  {
> +	/*
> +	 * This line is a formality to collect vmcore ASAP. Real bug
> +	 * (hardware or software) happened earlier, current registers and
> +	 * backtrace aren't interesting.
> +	 */
> +	BUG_ON(oops_if_bad_pte);
> +
>  	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
>  	p4d_t *p4d = p4d_offset(pgd, addr);
>  	pud_t *pud = pud_offset(p4d, addr);


