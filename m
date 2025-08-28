Return-Path: <linux-kernel+bounces-790050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CEBB39EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0021C23AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A931195B;
	Thu, 28 Aug 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hBEXn8KX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kEcZSECW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hBEXn8KX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kEcZSECW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5921884A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387429; cv=none; b=dAWWMXY7J8lbIuovKyVupIsCl4NT/ElV79ZMhYx3SIoQBLBHDY8Qt+ZfVtaAW1OLSBZn6qIl4C6PNoL0CNRfdDLDFzWkViWgwQxnkoNFPlUFyKdMnUMBSc98sAiGHEkh1Tw5NuvMF+uEruq/BJt/JB0ifcsJ3FV5WfPm3VIwHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387429; c=relaxed/simple;
	bh=VBBE3H+IXE7pxGF1A+qvNsfQcwQ2C6xxdZr4qz8+QIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bZ2zkv/O+J/fBOr6smOLL4STP5+TyqzuA/FmjaSZZKBqM1AppkPHlUpC5GKqeEIVZUoRjLXF43RdARdAWVUzXXqEEJLSBwmk8A8JAQHnsqIdtfoJMIheRPIpRmH1nAFlFf/by7vUBsid3fKxlv9Vl2xbSFhntTjDzW+ipR1hjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hBEXn8KX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kEcZSECW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hBEXn8KX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kEcZSECW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55C2D22C04;
	Thu, 28 Aug 2025 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756387425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzA3RrGXg+BwZI8mI1kN1SfcK7fhlP/WEoccBcHeAV8=;
	b=hBEXn8KXVONCs1W4kHSavJsGwVqDTAYcmib39rJfykta9UwUXDOCFliQo0VDvVqRaBPRqc
	B1eSxl3tw9kC2UFkvJUm9BQJKs2kbEzdLFB8fd8y7Knrcvt3+gKepgm973NGMKKRyUPS65
	3GisMlhklCtnAiGlAV1pQsjs4qxPQzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756387425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzA3RrGXg+BwZI8mI1kN1SfcK7fhlP/WEoccBcHeAV8=;
	b=kEcZSECWlNzxQbGuEwkkEL7KIh1sdx6BP1HH+5SaQGioLPcOsF5a7HVPIJ3YOG8NScBk7b
	NC55gFBzdzom+ODQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hBEXn8KX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kEcZSECW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756387425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzA3RrGXg+BwZI8mI1kN1SfcK7fhlP/WEoccBcHeAV8=;
	b=hBEXn8KXVONCs1W4kHSavJsGwVqDTAYcmib39rJfykta9UwUXDOCFliQo0VDvVqRaBPRqc
	B1eSxl3tw9kC2UFkvJUm9BQJKs2kbEzdLFB8fd8y7Knrcvt3+gKepgm973NGMKKRyUPS65
	3GisMlhklCtnAiGlAV1pQsjs4qxPQzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756387425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzA3RrGXg+BwZI8mI1kN1SfcK7fhlP/WEoccBcHeAV8=;
	b=kEcZSECWlNzxQbGuEwkkEL7KIh1sdx6BP1HH+5SaQGioLPcOsF5a7HVPIJ3YOG8NScBk7b
	NC55gFBzdzom+ODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E9A113326;
	Thu, 28 Aug 2025 13:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dN/9DmFYsGjODAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 28 Aug 2025 13:23:45 +0000
Message-ID: <c1f290b7-b4e0-4ec5-b60c-b1e6d3e0f21d@suse.cz>
Date: Thu, 28 Aug 2025 15:23:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pagevec.h: add `const` to pointer parameters of getter
 functions
Content-Language: en-US
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250828130311.772993-1-max.kellermann@ionos.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250828130311.772993-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 55C2D22C04
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,oracle.com:email,suse.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 8/28/25 15:03, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Note that your Cc list is still not according to MAINTAINERS:

./scripts/get_maintainer.pl -f include/linux/pagevec.h 
Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT - CORE)
David Hildenbrand <david@redhat.com> (maintainer:MEMORY MANAGEMENT - CORE)
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (reviewer:MEMORY MANAGEMENT - CORE)
"Liam R. Howlett" <Liam.Howlett@oracle.com> (reviewer:MEMORY MANAGEMENT - CORE)
Vlastimil Babka <vbabka@suse.cz> (reviewer:MEMORY MANAGEMENT - CORE)
Mike Rapoport <rppt@kernel.org> (reviewer:MEMORY MANAGEMENT - CORE)
Suren Baghdasaryan <surenb@google.com> (reviewer:MEMORY MANAGEMENT - CORE)
Michal Hocko <mhocko@suse.com> (reviewer:MEMORY MANAGEMENT - CORE)
linux-mm@kvack.org (open list:MEMORY MANAGEMENT - CORE)
linux-kernel@vger.kernel.org (open list)

> ---
> v1->v2: reduced patch to just pagevec.h upon David Hildenbrand's suggestion

Assuming you don't intend to stop here, a series with multiple patches logically
gradually expanding the const scope would be better than sending a single patch?

Thanks,
Vlastimil

> ---
>  include/linux/pagevec.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 5d3a0cccc6bf..63be5a451627 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -51,12 +51,12 @@ static inline void folio_batch_reinit(struct folio_batch *fbatch)
>  	fbatch->i = 0;
>  }
>  
> -static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
> +static inline unsigned int folio_batch_count(const struct folio_batch *fbatch)
>  {
>  	return fbatch->nr;
>  }
>  
> -static inline unsigned int folio_batch_space(struct folio_batch *fbatch)
> +static inline unsigned int folio_batch_space(const struct folio_batch *fbatch)
>  {
>  	return PAGEVEC_SIZE - fbatch->nr;
>  }


