Return-Path: <linux-kernel+bounces-808464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C420B50019
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB3C5E52E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F247E343D6B;
	Tue,  9 Sep 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZfE+0tUM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wbeIJSBx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZfE+0tUM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wbeIJSBx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7B23BCE3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429535; cv=none; b=RQuWkN65gALidP6gvq1dEGuZXmUgKeG0Q5t9rMED1T9WJecg1HJO+7M7cVr6f+9TQJjTBROHoFdMmQAU12SJtetcNmni74oUbaijFYH7dnyZxkKnyUVLRkSJnXVvJWGI1Vw/WyUwk7WcMhdkAEu0l8MvLW7zzeMqb/anxGGYL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429535; c=relaxed/simple;
	bh=uYkv+NHIsabkDuy6GtNMMoeVsFa9CfaGm+3WO8DsY3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRaFMFllhzRmlUA/Fn3Xt8zEm2bwtIxJWamkPyfkbM5flZqGa/sMhsjA/P3f9uML8tLrKsp6jy5NfNAdJPP0jF9f6LzJyB0/B3BsksU0EUhrLnDHiANNIkbKNAFPmvzzba/x81q5iMqVINUoQlQwFx8P+W/AOwE42QeZgxubqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZfE+0tUM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wbeIJSBx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZfE+0tUM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wbeIJSBx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B785E349B6;
	Tue,  9 Sep 2025 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757429529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQ9jOGPJtYrY9ZT/iPA3+VnBwmwNfrm2jKRpSJXGpz4=;
	b=ZfE+0tUMsHAOco1NIWu8fVqQaGI6druBSVAQrNpFrq6GYE1GsF+Udp5KqRyDfP7iBuL1/7
	HpFdBnAZVICwXSpjQ5LLFHlnktiuturDngqWJ9qIkWz2ZO8URb17hjXYk+2ERSvBYw6vVc
	1d8uu/HvuxJhWzwjy6BfM8j9eSmzQpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757429529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQ9jOGPJtYrY9ZT/iPA3+VnBwmwNfrm2jKRpSJXGpz4=;
	b=wbeIJSBx/54P1Q/wpoSdLd2ROsQIe/zviVK2jxgdre3zTexjK3w4waMkpSFeljpu0grEjo
	52CgLZKl7e8qc3Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZfE+0tUM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wbeIJSBx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757429529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQ9jOGPJtYrY9ZT/iPA3+VnBwmwNfrm2jKRpSJXGpz4=;
	b=ZfE+0tUMsHAOco1NIWu8fVqQaGI6druBSVAQrNpFrq6GYE1GsF+Udp5KqRyDfP7iBuL1/7
	HpFdBnAZVICwXSpjQ5LLFHlnktiuturDngqWJ9qIkWz2ZO8URb17hjXYk+2ERSvBYw6vVc
	1d8uu/HvuxJhWzwjy6BfM8j9eSmzQpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757429529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQ9jOGPJtYrY9ZT/iPA3+VnBwmwNfrm2jKRpSJXGpz4=;
	b=wbeIJSBx/54P1Q/wpoSdLd2ROsQIe/zviVK2jxgdre3zTexjK3w4waMkpSFeljpu0grEjo
	52CgLZKl7e8qc3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06D851388C;
	Tue,  9 Sep 2025 14:52:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U4LpORg/wGgzegAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 09 Sep 2025 14:52:08 +0000
Date: Tue, 9 Sep 2025 15:52:03 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Ye Liu <ye.liu@linux.dev>
Cc: Dev Jain <dev.jain@arm.com>, Hu Song <husong@kylinos.cn>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Use folio_nr_pages() in __free_slab()
Message-ID: <v5jeb6pbpkikzhjuno6pq65y6cdq76ucj5ebotakwpvzbmjl5h@7dtdjmqjxmp5>
References: <20250909074812.599030-1-husong@kylinos.cn>
 <c880df01-3041-4af0-b4d1-167193e8e6af@arm.com>
 <e058c588-2fa3-4763-bcc2-06b6fb6eddab@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e058c588-2fa3-4763-bcc2-06b6fb6eddab@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B785E349B6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Tue, Sep 09, 2025 at 04:59:37PM +0800, Ye Liu wrote:
> 
> 在 2025/9/9 16:46, Dev Jain 写道:
> >
> > On 09/09/25 1:18 pm, Hu Song wrote:
> >> Use folio_nr_pages() helper instead of manual calculation (1 << order)
> >> for better code readability and maintainability.
> >>
> >> Signed-off-by: Hu Song <husong@kylinos.cn>
> >> ---
> >>   mm/slub.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index d257141896c9..eba25461641a 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2719,7 +2719,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
> >>   {
> >>       struct folio *folio = slab_folio(slab);
> >>       int order = folio_order(folio);
> >> -    int pages = 1 << order;
> >> +    int pages = folio_nr_pages(folio);
> >>         __slab_clear_pfmemalloc(slab);
> >>       folio->mapping = NULL;
> >
> > I don't know, the current version is more readable to me. We literally
> > compute the order before, so we do a simple 1 << order. I'll leave it
> > to the rest.
> >
> >
> Is the reason for calculating 'order' first because it's needed later.

Yes, we use it 6 lines down.

-- 
Pedro

