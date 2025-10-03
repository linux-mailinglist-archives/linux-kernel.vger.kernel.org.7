Return-Path: <linux-kernel+bounces-841091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA768BB63DC
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3568419E212C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1626CE05;
	Fri,  3 Oct 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LDSFop/T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W4Z6NyaZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LDSFop/T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W4Z6NyaZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89FE22259F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759480550; cv=none; b=ojE8YxOqAZa8w1SDXt/Ro7awdfks+ybzBv+bJuzKkgTdBaglNtlNlS2lBIF4P7qB6wE7GbmpDbWUuuwg58+AJvXM2kv3qPCloXIOm2q0YsK53cJV6QywmB7otgUFEe8B4kwy4H6fstbjskVkxbniR2I1F2ddKYi1VQX1dt4kuEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759480550; c=relaxed/simple;
	bh=qogdZ1D3k4wKKtBr0C98EA6glsjMmWlojCQFB9UIUaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDshEnQ+XxH5ZLD5W48rCyc/heJ7K9FnwMjXPLpvmd2FSpwPQ3PLu4askcGaFe8/kowtilmlOE2W6acv/caYELUnJ2XpxxGHZ8z753McTcG8BqHqxeZML1K0rSAADgE3lI/6zWwuc5M0yKOun2IUOhyosQ6FyEMHD92h7XUASt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LDSFop/T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W4Z6NyaZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LDSFop/T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W4Z6NyaZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98E0E1F388;
	Fri,  3 Oct 2025 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759480546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKhGqKWYXB0Whi2FFFvg79+OnJq6OL+eV6niiEbIzNY=;
	b=LDSFop/ThKXqPoH/QB/KoM7KcPKAWzHsfQw0YMqySe/G6hma5O759ouoSZEpd/ZdvzsPhQ
	ztvzFErbzg5jdtKegWt4F24xxg8TsECp5Iwb8WzL/CqLoamhZSb8Ceqxs//egXcEolujap
	XaJg47rPCv4cDmoeQs/kiGQ8joqbL5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759480546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKhGqKWYXB0Whi2FFFvg79+OnJq6OL+eV6niiEbIzNY=;
	b=W4Z6NyaZQX364XOSjJoKQDHMnvB0rhPlY2A1q9IbodVBxL8GuxRNWbQlcM2VgEBsG1GPXQ
	XxqtGiZfqNIxY4CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759480546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKhGqKWYXB0Whi2FFFvg79+OnJq6OL+eV6niiEbIzNY=;
	b=LDSFop/ThKXqPoH/QB/KoM7KcPKAWzHsfQw0YMqySe/G6hma5O759ouoSZEpd/ZdvzsPhQ
	ztvzFErbzg5jdtKegWt4F24xxg8TsECp5Iwb8WzL/CqLoamhZSb8Ceqxs//egXcEolujap
	XaJg47rPCv4cDmoeQs/kiGQ8joqbL5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759480546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKhGqKWYXB0Whi2FFFvg79+OnJq6OL+eV6niiEbIzNY=;
	b=W4Z6NyaZQX364XOSjJoKQDHMnvB0rhPlY2A1q9IbodVBxL8GuxRNWbQlcM2VgEBsG1GPXQ
	XxqtGiZfqNIxY4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 764E513AAD;
	Fri,  3 Oct 2025 08:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xeiGHOKK32gNcgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 03 Oct 2025 08:35:46 +0000
Message-ID: <db51bcc5-aaf6-4cb4-ab62-fed9d40d6caa@suse.cz>
Date: Fri, 3 Oct 2025 10:35:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in
 drain_pages_zone
Content-Language: en-US
To: Hillf Danton <hdanton@sina.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com, Chris Mason <clm@fb.com>,
 Kiryl Shutsemau <kirill@shutemov.name>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Hillf Danton <hdanton@sina.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
References: <20251001234814.7896-1-hdanton@sina.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20251001234814.7896-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,vger.kernel.org,kvack.org,meta.com,fb.com,shutemov.name,oracle.com,google.com,redhat.com,suse.com,kernel.org,suse.cz,nvidia.com,sina.com];
	FREEMAIL_TO(0.00)[sina.com,gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 10/2/25 01:48, Hillf Danton wrote:
> On Wed,  1 Oct 2025 08:37:16 -0700 Joshua Hahn wrote:
>> 
>> While I definitely agree that spreading out 1TB across multiple NUMA nodes
>> is an option that should be considered, I am unsure if it makes sense to
>> dismiss this issue as simply a misconfiguration problem.
>> 
>> The reality is that these machines do exist, and we see zone lock contention
>> on these machines. You can also see that I ran performance evaluation tests
>> on relatively smaller machines (250G) and saw some performance gains.
>> 
> If NUMA node could not be an option, there is still much room in the zone types
> for adding new zones on top of the current pcp and zone mechanism to mitigate
> zone lock contention, see diff below. Then the issue falls in the config category.
> 
>> The other point that I wanted to mention is that simply adding more NUMA
>> nodes is not always strictly beneficial; it changes how the scheduler
>> has to work, workloads would require more numa-aware tuning, etc.
> 
> Feel safe to sit back with Netflix on as PeterZ is taking care of NUMA nodes
> and eevdf, haha.

Feel free to stop making such weird "jokes"?

Also you should really stop dropping CC's on your replies, especially for
maintainers of given code. I've only learned in the v3 changelog from "as
suggested by Hillf Danton" that there was this subthread. This is not
acceptable. When the feedback is wrong and uncorrected by others, it can
mislead the patch author to do wrong changes in the next version.

If this Cc reduction is due to a problem with your e-mail provider, get a
different one?

> --- x/include/linux/mmzone.h
> +++ y/include/linux/mmzone.h
> @@ -779,6 +779,9 @@ enum zone_type {
>  #ifdef CONFIG_ZONE_DMA32
>  	ZONE_DMA32,
>  #endif
> +#ifdef CONFIG_ZONE_EXP
> +	ZONE_EXP0, ZONE_EXP1, ZONE_EXP2, /* experiment */
> +#endif
>  	/*
>  	 * Normal addressable memory is in ZONE_NORMAL. DMA operations can be
>  	 * performed on pages in ZONE_NORMAL if the DMA devices support
> 


