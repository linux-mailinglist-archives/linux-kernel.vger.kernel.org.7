Return-Path: <linux-kernel+bounces-843105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F85BBE697
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 918A534914F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73921FF48;
	Mon,  6 Oct 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2aMSnF0v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M5eZAvfL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2aMSnF0v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M5eZAvfL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312052D481F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762523; cv=none; b=vEeIpTFvdSn9vFBp+/G1QqbFYu4NZwFx+jcoaeQOCfRB1Qz6GrsZV+IwtKSeo5JAsX2CO4irvvIi82CLosCqWswmI2P0Xb7s2LNA70+GC90x6E+g6ePDmGV0cbTQJPI2jlOvMwLN2FSNuZc+kT5xsoac77MJujMqDTsEZ9D+zKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762523; c=relaxed/simple;
	bh=w+cd5BeBhK7+SgKfhDfuS2FPWZ8nSANcTGLN9fpYGI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3akf2+o9v6gB6jFib7Wkpl/GGwDAzyAK/IK6jymowHGrhnTr1idbcvw+ZtbG9TdtSqqD+N+ruwHJmnEXgP3bEbBKJGnhRV63+VQqzUPbuEXnsw7KsqEmSvT2PmQubH92xjb/oS6kHt9zWzb643NU1Wn7yg6/zsoKA7fPU20EWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2aMSnF0v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M5eZAvfL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2aMSnF0v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M5eZAvfL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 179442227F;
	Mon,  6 Oct 2025 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759762519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fqqFaLRqApP2CnNxjsITNJnHLiuJAc6kIlab9Tf0uA=;
	b=2aMSnF0vFaUTQlRjBeQC73mAUaJTiKhdaESayJJ7YIWh5slZz+JplwjOH9AQcRWxItehy9
	q/JF7THrUN1SgjARnPr79+jlwXqYvCA9XWXB7azw4seXgLKhauwx3vrJGbVNhCGR1uIZ0L
	Z20kEFq43f6quNgNrSVGvKEXbBxG24k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759762519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fqqFaLRqApP2CnNxjsITNJnHLiuJAc6kIlab9Tf0uA=;
	b=M5eZAvfLOdBG4iQO2ffuDrnOH69ngkkcpu7+bOKxVaJMVvSED9zYyCAoDDkHJ6gOqsbKEL
	NGcUGsk6NFbu4YCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2aMSnF0v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=M5eZAvfL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759762519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fqqFaLRqApP2CnNxjsITNJnHLiuJAc6kIlab9Tf0uA=;
	b=2aMSnF0vFaUTQlRjBeQC73mAUaJTiKhdaESayJJ7YIWh5slZz+JplwjOH9AQcRWxItehy9
	q/JF7THrUN1SgjARnPr79+jlwXqYvCA9XWXB7azw4seXgLKhauwx3vrJGbVNhCGR1uIZ0L
	Z20kEFq43f6quNgNrSVGvKEXbBxG24k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759762519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fqqFaLRqApP2CnNxjsITNJnHLiuJAc6kIlab9Tf0uA=;
	b=M5eZAvfLOdBG4iQO2ffuDrnOH69ngkkcpu7+bOKxVaJMVvSED9zYyCAoDDkHJ6gOqsbKEL
	NGcUGsk6NFbu4YCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F173013995;
	Mon,  6 Oct 2025 14:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQnvOlbY42jVJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Oct 2025 14:55:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A3EAA0ABF; Mon,  6 Oct 2025 16:55:14 +0200 (CEST)
Date: Mon, 6 Oct 2025 16:55:14 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Amir Goldstein <amir73il@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
Message-ID: <uyh6y4qjuj6vcpsdnexwl2xqf2jnp6ejj7esr3g3hix66ml2zi@pqsbsjtt6apl>
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003155238.2147410-1-ryan.roberts@arm.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,gmail.com,kvack.org,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 179442227F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Fri 03-10-25 16:52:36, Ryan Roberts wrote:
> fsnotify_mmap_perm() requires a byte offset for the file about to be
> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
> Previously the conversion was done incorrectly so let's fix it, being
> careful not to overflow on 32-bit platforms.
> 
> Discovered during code review.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> Applies against today's mm-unstable (aa05a436eca8).

Thanks Ryan! I've added the patch to my tree. As a side note, I know the
callsite is in mm/ but since this is clearly impacting fsnotify, it would
be good to add to CC relevant people (I'm not following linux-mm nor
linux-kernel) and discovered this only because of Kiryl's link...

								Honza

>  mm/util.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 6c1d64ed0221..8989d5767528 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -566,6 +566,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>  	unsigned long len, unsigned long prot,
>  	unsigned long flag, unsigned long pgoff)
>  {
> +	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
>  	unsigned long ret;
>  	struct mm_struct *mm = current->mm;
>  	unsigned long populate;
> @@ -573,7 +574,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
> 
>  	ret = security_mmap_file(file, prot, flag);
>  	if (!ret)
> -		ret = fsnotify_mmap_perm(file, prot, pgoff >> PAGE_SHIFT, len);
> +		ret = fsnotify_mmap_perm(file, prot, off, len);
>  	if (!ret) {
>  		if (mmap_write_lock_killable(mm))
>  			return -EINTR;
> --
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

