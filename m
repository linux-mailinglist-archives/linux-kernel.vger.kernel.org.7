Return-Path: <linux-kernel+bounces-850109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 161F9BD1E62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B21F83489C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80CB2E7F2F;
	Mon, 13 Oct 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DTgCzLUY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A2YAIP6G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DTgCzLUY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A2YAIP6G"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE934BA46
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342431; cv=none; b=fy1cP41Q8ivJplKmhNEUz96kH81N1xpai1CHYE27qxqyG8pqH4mvCnwKCSpIkH3C+En/egCQ+yenb4pNMhcMeatRh/TmKCbzm4bnto9oAEmFrMrjnuN3fqX/3O2ZSmrB03Wal5trNJdZ5Dx3X6s5fhGJsSewxdyYmOkMZuI0biY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342431; c=relaxed/simple;
	bh=Mp38y6dJpiL63UJyrFnenakvqUylSUJIpM0Fja98ow0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0piEkXPqmZsWXwtmbdk9jPDmuDAZ3CyElqyWkDP6M+L6KhFYFeOiXvSLBk+HnFtOjldsLUIS/gRkOEUufk0YlwPppGP0z+t5ktASrZennBTaARFvLXCi5cn1nVG36y7kNV7MAHnFEIYVyELxjgJZE29HbNSaQJhDWfhHyG65Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DTgCzLUY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A2YAIP6G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DTgCzLUY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A2YAIP6G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B156621221;
	Mon, 13 Oct 2025 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8t58zwnbBpGazmpfJwigZplemtrFKud6dUJScz2Wcb4=;
	b=DTgCzLUY0ad8E5MyNbrkArk0eE/wvMEH12RuNqcAtldq7n1aIISIhF4rhVLK/BXvFxNWxv
	+2c7Z2NMawHiyT8aQ+mdEekUeye61OKJTiNRcZcQ3sbIkqpulexnVZcalAGWkwb3so4qA6
	dTXYim4ey1ywpKU8Pl8cYhT236rDqDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8t58zwnbBpGazmpfJwigZplemtrFKud6dUJScz2Wcb4=;
	b=A2YAIP6GqGRuraijN+d6sG5wlkWRahixq2bxKuvr+idEKO30rEGNHV9pl5Gy2ltlDrTMX1
	cnlGPBGK61chaLAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760342427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8t58zwnbBpGazmpfJwigZplemtrFKud6dUJScz2Wcb4=;
	b=DTgCzLUY0ad8E5MyNbrkArk0eE/wvMEH12RuNqcAtldq7n1aIISIhF4rhVLK/BXvFxNWxv
	+2c7Z2NMawHiyT8aQ+mdEekUeye61OKJTiNRcZcQ3sbIkqpulexnVZcalAGWkwb3so4qA6
	dTXYim4ey1ywpKU8Pl8cYhT236rDqDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760342427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8t58zwnbBpGazmpfJwigZplemtrFKud6dUJScz2Wcb4=;
	b=A2YAIP6GqGRuraijN+d6sG5wlkWRahixq2bxKuvr+idEKO30rEGNHV9pl5Gy2ltlDrTMX1
	cnlGPBGK61chaLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02ECC13874;
	Mon, 13 Oct 2025 08:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nsRjOZqx7GijEQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 13 Oct 2025 08:00:26 +0000
Date: Mon, 13 Oct 2025 10:00:21 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Usama Arif <usamaarif642@gmail.com>
Cc: muchun.song@linux.dev, david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, shakeel.butt@linux.dev,
	linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com,
	kas@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] mm/hugetlb: allow overcommitting gigantic
 hugepages
Message-ID: <aOyxle8OJPMKlVWX@localhost.localdomain>
References: <20251009172433.4158118-1-usamaarif642@gmail.com>
 <20251009172433.4158118-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009172433.4158118-2-usamaarif642@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,localhost.localdomain:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Thu, Oct 09, 2025 at 06:24:31PM +0100, Usama Arif wrote:
> Currently, gigantic hugepages cannot use the overcommit mechanism
> (nr_overcommit_hugepages), forcing users to permanently reserve memory via
> nr_hugepages even when pages might not be actively used.
> 
> The restriction was added in 2011 [1], which was before there was support
> for reserving 1G hugepages at runtime.
> Remove this blanket restriction on gigantic hugepage overcommit.
> This will bring the same benefits to gigantic pages as hugepages:
> 
> - Memory is only taken out of regular use when actually needed
> - Unused surplus pages can be returned to the system
> - Better memory utilization, especially with CMA backing which can
>   significantly increase the changes of hugepage allocation
> 
> Without this patch:
> echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
> bash: echo: write error: Invalid argument
> 
> With this patch:
> echo 3 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_overcommit_hugepages
> ./mmap_hugetlb_test
> Successfully allocated huge pages at address: 0x7f9d40000000
> 
> cat mmap_hugetlb_test.c
> ...
>     unsigned long ALLOC_SIZE = 3 * (unsigned long) HUGE_PAGE_SIZE;
>     addr = mmap(NULL,
>                 ALLOC_SIZE, // 3GB
>                 PROT_READ | PROT_WRITE,
>                 MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_HUGE_1GB,
>                 -1,
>                 0);
> 
>     if (addr == MAP_FAILED) {
>         fprintf(stderr, "mmap failed: %s\n", strerror(errno));
>         return 1;
>     }
>     printf("Successfully allocated huge pages at address: %p\n", addr);
> ...
> 
> [1] https://git.zx2c4.com/linux-rng/commit/mm/hugetlb.c?id=adbe8726dc2a3805630d517270db17e3af86e526
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

I guess nobody bothered to do this after we added support for 1GB hugepages because
creating those at runtime is tricky, and in my experience, almost everybody reserves
those at boot time.
But I do not have objections to make them behave as normal hugepages:

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

