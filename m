Return-Path: <linux-kernel+bounces-807443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C22CEB4A469
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413007A52D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF8224338F;
	Tue,  9 Sep 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DOlcoyBH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NEfLVv7t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DOlcoyBH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NEfLVv7t"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090D241665
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404834; cv=none; b=tU9mKcYMBwSDI5m1DGHyw7yunK7oUi0YdVGqym/2aDM33qi58YE4XqUlsXqoLg9H4eqQKl5ymw84Sxi/BL40C4xGBMNfDuOD9k/gPQ1f2jwhe+q2j1opVOmuZsPlzxu8306371l4TSXZI331aBL0CEfT8B1yF3sUdDCMoF6T3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404834; c=relaxed/simple;
	bh=Rg/2hVeYTpEtcMeCtgcqQY8MOdlO0uZYax8gwXLF8Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZDcrbPH7DvXaqBwOpF7z7VWNajZBx9hNc/WGOj2rB+eSedosbd4WbTr0SRc4Lh0pnDs2i94gmv3kLiIQ+ttVtdwlJMzHP8/Q2PDfgugR3OBFA7tGPeXpPAit4vVgZrYpfSbYZf2NtNyCGmTX87xuPP8xEZCJtcGErZtaofSr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DOlcoyBH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NEfLVv7t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DOlcoyBH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NEfLVv7t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFAA42A00C;
	Tue,  9 Sep 2025 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757404830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvUkPTxLnNWcwdRJR5b+fZTc1llU3CirdTSgIFnoxGk=;
	b=DOlcoyBHTMsysprimbITprbGAngs268qJe2ViwrT7luCpfo7boReGo70C9EQ3+Z7OOuS2t
	+ZeAKGqsD8TU+7zTJNseLXNUMD3j3Z8GORmNuOL3T0+O01rLRIxMciL1bjN4fxR4/3e8hf
	Lod4jNtj1B1DxRJFi1msN3QnnkGhtNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757404830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvUkPTxLnNWcwdRJR5b+fZTc1llU3CirdTSgIFnoxGk=;
	b=NEfLVv7t47IZL6oJO+HxOtv4VjIdCpB+QWn/oSohjX8DrYioUZGEPWFSAAGcjA25G3wJXh
	8AuClsUqLg3iGjDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757404830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvUkPTxLnNWcwdRJR5b+fZTc1llU3CirdTSgIFnoxGk=;
	b=DOlcoyBHTMsysprimbITprbGAngs268qJe2ViwrT7luCpfo7boReGo70C9EQ3+Z7OOuS2t
	+ZeAKGqsD8TU+7zTJNseLXNUMD3j3Z8GORmNuOL3T0+O01rLRIxMciL1bjN4fxR4/3e8hf
	Lod4jNtj1B1DxRJFi1msN3QnnkGhtNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757404830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvUkPTxLnNWcwdRJR5b+fZTc1llU3CirdTSgIFnoxGk=;
	b=NEfLVv7t47IZL6oJO+HxOtv4VjIdCpB+QWn/oSohjX8DrYioUZGEPWFSAAGcjA25G3wJXh
	8AuClsUqLg3iGjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E8221388C;
	Tue,  9 Sep 2025 08:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jUiAEJ7ev2hIbgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 09 Sep 2025 08:00:30 +0000
Date: Tue, 9 Sep 2025 10:00:24 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Hu Song <husong@kylinos.cn>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Use folio_nr_pages() in __free_slab()
Message-ID: <aL_emHbGN3xA5i_c@localhost.localdomain>
References: <20250909074812.599030-1-husong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909074812.599030-1-husong@kylinos.cn>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Tue, Sep 09, 2025 at 03:48:11PM +0800, Hu Song wrote:
> Use folio_nr_pages() helper instead of manual calculation (1 << order)
> for better code readability and maintainability.
> 
> Signed-off-by: Hu Song <husong@kylinos.cn>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d257141896c9..eba25461641a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2719,7 +2719,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>  {
>  	struct folio *folio = slab_folio(slab);
>  	int order = folio_order(folio);
> -	int pages = 1 << order;
> +	int pages = folio_nr_pages(folio);

Sure nothing might happen, but I find a bit weird that folio_nr_pages()
returns a 'long' and we store it in an 'int' type.
And then sure we handle that to mm_account_reclaimed_pages() which gets
'unsigned long', but that's another story.

 

-- 
Oscar Salvador
SUSE Labs

