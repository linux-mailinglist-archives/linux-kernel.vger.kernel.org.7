Return-Path: <linux-kernel+bounces-759426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6396AB1DD68
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4CF1AA575B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6895E273D65;
	Thu,  7 Aug 2025 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LId+bL/F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i4iZDg0n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o6MzfGBc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tdtb7sUM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5F4438B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754594054; cv=none; b=MjV5YdnU6LJCF/+cIPoxktIalayMML70PvkiGBDKn0edHjBFK4AlTfGgzVHI6fCp9upugJ4a2AYjehQ3sCma0PRnYMmGPYejEGD7mTuKfbCfgHnNqPFliKclZJlpWU/TCedNPxQE7D4HqkZ2Lm6Cw1jhzicP15/CSYC/Z7krSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754594054; c=relaxed/simple;
	bh=7RwhRdLpuCEjLqXRUdNTvCNGrIFjCeiqk/hgxLu1RsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJpR12xshm9UKAQYmYsyY+9qNYOAHBmssdnjuxBMPIDLlPaBULCWhDrskSIPkjsc/xg07UBXsywO4lTpugl7s//PAq6Jlwg/vDZhh3aQe9Qs1XE5JgYYt9ZkKmGo2IB1iFMP6UkxSPKVvxbMtgUSmfLLdvAjlVhXDQZhGIo2Xuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LId+bL/F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i4iZDg0n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o6MzfGBc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tdtb7sUM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17BBC1F855;
	Thu,  7 Aug 2025 19:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754594050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/gfEkfDLpTTAagakFGe8yIgKtQIh/Q1iMY2XUDy4Fo=;
	b=LId+bL/FjOVqyYx5UQow/lX2psBGdXMJGlip1Q2PfFPaE1qMtjSr9+EYmXrCHVRTIgg9Eo
	YQugun8SrPQ3iIblustN3rZ4nM3qvQpcuMBA4dLmxbfzonq/MZlWAfU8OIZ0IU9U8K3N5W
	uB8m09oTSxORGFIvkSXUFzeTjQdH1JM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754594050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/gfEkfDLpTTAagakFGe8yIgKtQIh/Q1iMY2XUDy4Fo=;
	b=i4iZDg0nVy2YdWjJ42cZz00wcAt+EtjVfw3W+lg+miz5K/OoiqkJAP9epUeXYexn07p2Pa
	KMZqgxIkcjE35yBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o6MzfGBc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tdtb7sUM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754594049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/gfEkfDLpTTAagakFGe8yIgKtQIh/Q1iMY2XUDy4Fo=;
	b=o6MzfGBcHeLQwPEkO7A5Py8is8IobReja9NrGDS3EnwCenhsaDz4wei5hD+1JEYn4sGxg3
	u0NHUxAHDqaFyeKI8FuKzf6f11QdH9epZV7zLZtg3j5NyIv0YXd2UKVkdOvhwjE0W5abvT
	Kwtb98L/fdydn28/EH/gfIaG5jnEJGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754594049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/gfEkfDLpTTAagakFGe8yIgKtQIh/Q1iMY2XUDy4Fo=;
	b=tdtb7sUM6JS1bFcW0dL30pGJDLPdVDojpVLkRk9RIyaQjr8DFgJ4Pzcm8cEKKGIsjS/xvI
	pXSyrl+/jH1mCwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6554713969;
	Thu,  7 Aug 2025 19:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +k4vFQD7lGg0cAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 07 Aug 2025 19:14:08 +0000
Date: Thu, 7 Aug 2025 20:14:09 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
Message-ID: <ujfeyn2awquoc4pc7qxcnavgqcu57kvmdb66x2hyaeoiasq3w4@u5qlyyklfrld>
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 17BBC1F855
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,intel.com:email,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Thu, Aug 07, 2025 at 07:58:19PM +0100, Lorenzo Stoakes wrote:
> It was discovered in the attached report that commit f822a9a81a31 ("mm:
> optimize mremap() by PTE batching") introduced a significant performance
> regression on a number of metrics on x86-64, most notably
> stress-ng.bigheap.realloc_calls_per_sec - indicating a 37.3% regression in
> number of mremap() calls per second.
> 
> I was able to reproduce this locally on an intel x86-64 raptor lake system,
> noting an average of 143,857 realloc calls/sec (with a stddev of 4,531 or
> 3.1%) prior to this patch being applied, and 81,503 afterwards (stddev of
> 2,131 or 2.6%) - a 43.3% regression.
> 
> During testing I was able to determine that there was no meaningful
> difference in efforts to optimise the folio_pte_batch() operation, nor
> checking folio_test_large().
> 
> This is within expectation, as a regression this large is likely to
> indicate we are accessing memory that is not yet in a cache line (and
> perhaps may even cause a main memory fetch).
> 
> The expectation by those discussing this from the start was that
> vm_normal_folio() (invoked by mremap_folio_pte_batch()) would likely be the
> culprit due to having to retrieve memory from the vmemmap (which mremap()
> page table moves does not otherwise do, meaning this is inevitably cold
> memory).
> 
> I was able to definitively determine that this theory is indeed correct and
> the cause of the issue.
> 
> The solution is to restore part of an approach previously discarded on
> review, that is to invoke pte_batch_hint() which explicitly determines,
> through reference to the PTE alone (thus no vmemmap lookup), what the PTE
> batch size may be.
> 
> On platforms other than arm64 this is currently hardcoded to return 1, so
> this naturally resolves the issue for x86-64, and for arm64 introduces
> little to no overhead as the pte cache line will be hot.
> 
> With this patch applied, we move from 81,503 realloc calls/sec to
> 138,701 (stddev of 496.1 or 0.4%), which is a -3.6% regression, however
> accounting for the variance in the original result, this is broadly
> restoring performance to its prior state.
>

So, do we still have a regression then? If so, do we have any idea why?

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508071609.4e743d7c-lkp@intel.com
> Fixes: f822a9a81a31 ("mm: optimize mremap() by PTE batching")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Fix looks great, thanks!

Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

