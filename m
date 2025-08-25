Return-Path: <linux-kernel+bounces-784613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217BFB33E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14CF3B77A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC12D23B5;
	Mon, 25 Aug 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BLdfv054";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O7drp4zQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxlNOytD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2reUtbC+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE32D0610
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122783; cv=none; b=X4qJEQaiL9wvWA7y6lbKoV8dxkW3qZsAx4v/mFu9KVZlfRSJWk/xWc08d2cCqtGjtbdQdRfZSQEKTrmC837stmEoiLMVT9z+9o/wo4uEN/3vx+PMWx9r+LhQO1wOmSYQSJqA9lSC58ctlmJa44BUnxHrOwfWiyKSXa2/R4jIV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122783; c=relaxed/simple;
	bh=mO9D8KO0GMii4ykgGLFrX0lUlEpO8p/2zockucV+A40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJttabz0llBPYmiXl4SHQ8UqRV8W/hiBMZhVbgopdhL5r65KdqpveOoyaqTs6gTUddcSxtmzsavlOM5TpcH+c7NoE8UOt/HoQyuCBoMPnV70xCiGC83j7Gn8T85FVUsgwNJ33m/IrrMrgIZpBzMlwYoSHFP9O/zQso9sd2qf8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BLdfv054; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O7drp4zQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxlNOytD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2reUtbC+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D67D91F79A;
	Mon, 25 Aug 2025 11:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756122779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nTexNPNCcUbIAPjVulE+NnEcHNOirgIMW9iyl6DGTw=;
	b=BLdfv054/p/malDxY9teiJzF9lSukSG4D6BpJmBipN0NdWdSW+xQ78Zp+mX96AOFCJ4or6
	zbtqKq1WT7TjodcVLV0bt7J1MZOfzgwccf3JUIl6s8+kVZikdeS2skIvtGyG2OhlZoKg6Q
	JUss4nIpYcq8CgiicsCS81+f175aL1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756122779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nTexNPNCcUbIAPjVulE+NnEcHNOirgIMW9iyl6DGTw=;
	b=O7drp4zQKKa11N3xPKWzBS/Q0YDI7TmPrZK8qGmy4XbGkcAVUk/3ZlwnODZ9si0dCo8+P7
	5I/V+iy8CB2E8QBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hxlNOytD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2reUtbC+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756122778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nTexNPNCcUbIAPjVulE+NnEcHNOirgIMW9iyl6DGTw=;
	b=hxlNOytD4XOs/AoLjAcVDIzjRMdvyScfjPWrBeLqnx0djwZ/JXkk86x1sLkDhnlw/4E/ni
	uYxxucfiTI9vedgKCrWJcx7BY+QluNhfdm4l2MpQlzHhl1brp6XTlNTSvpowKMI6Sw5rkX
	USEgKImf2GD1KiVkKNFJec81wPqbFec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756122778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nTexNPNCcUbIAPjVulE+NnEcHNOirgIMW9iyl6DGTw=;
	b=2reUtbC+KuaceUTmG97zLnb9fIt9VqqRYRCJqi9iT5L3d2xW2yZVplRnOVQlakwqC3C18m
	1Nr4U8+V7VDSZaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAD161368F;
	Mon, 25 Aug 2025 11:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Scl9MZpOrGivCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 Aug 2025 11:52:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FDFAA0A6B; Mon, 25 Aug 2025 10:16:40 +0200 (CEST)
Date: Mon, 25 Aug 2025 10:16:40 +0200
From: Jan Kara <jack@suse.cz>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm: readahead: improve mmap_miss heuristic for
 concurrent faults
Message-ID: <nbhyazac6tig3u753upst4brgmlo6qlwdntxdgwtfslpmmvp6h@gakfswzn3p75>
References: <20250815183224.62007-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815183224.62007-1-roman.gushchin@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D67D91F79A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Fri 15-08-25 11:32:24, Roman Gushchin wrote:
> If two or more threads of an application faulting on the same folio,
> the mmap_miss counter can be decreased multiple times. It breaks the
> mmap_miss heuristic and keeps the readahead enabled even under extreme
> levels of memory pressure.
> 
> It happens often if file folios backing a multi-threaded application
> are getting evicted and re-faulted.
> 
> Fix it by skipping decreasing mmap_miss if the folio is locked.
> 
> This change was evaluated on several hundred thousands hosts in Google's
> production over a couple of weeks. The number of containers being
> stuck in a vicious reclaim cycle for a long time was reduced several
> fold (~10-20x), as well as the overall fleet-wide cpu time spent in
> direct memory reclaim was meaningfully reduced. No regressions were
> observed.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c21e98657e0b..983ba1019674 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3324,9 +3324,17 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
>  		return fpin;
>  
> -	mmap_miss = READ_ONCE(ra->mmap_miss);
> -	if (mmap_miss)
> -		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> +	/*
> +	 * If the folio is locked, we're likely racing against another fault.
> +	 * Don't touch the mmap_miss counter to avoid decreasing it multiple
> +	 * times for a single folio and break the balance with mmap_miss
> +	 * increase in do_sync_mmap_readahead().
> +	 */
> +	if (likely(!folio_test_locked(folio))) {
> +		mmap_miss = READ_ONCE(ra->mmap_miss);
> +		if (mmap_miss)
> +			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> +	}
>  
>  	if (folio_test_readahead(folio)) {
>  		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -- 
> 2.50.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

