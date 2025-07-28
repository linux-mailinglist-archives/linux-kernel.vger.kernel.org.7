Return-Path: <linux-kernel+bounces-747727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B6AB1375C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101243A612E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14011D5146;
	Mon, 28 Jul 2025 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dRjYDqIN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ER9dxc2P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dRjYDqIN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ER9dxc2P"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D61A704B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694212; cv=none; b=XiA4kqRxzK73bXpNeLOLSMXfKn0XRgYXa7M0FfCXKGQ43QosU+qqTiQieyeV8XHFoPcqCPZT7SXPXFxsAiFW3OOKenqBmb3Php0qssxPeB38+jH+rYaWu1yj5LbxvE2c1m77YvPungFKECU24LOVUUlfhjewMS7gVb1D62JFUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694212; c=relaxed/simple;
	bh=q41JUvTl8y4IDPwr0bIfiqiaFim7UBkE0XbvdwSRfdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL330ANId6q19bdAJ2NmVuuRrydi9c4E8Q95lS0f0dkqPs4wLQSh6FYQTp5+pUJu0l6tj/j10+/3Pgdym91e3EtcBqFuRw+uRjvS/uIlwBM1/OSnKVfu4ybfzHPBUjle1eBxSlPX2Mwy0F72VF6W+z0E5HNK75HHHDeB5rjF9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dRjYDqIN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ER9dxc2P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dRjYDqIN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ER9dxc2P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 721281F444;
	Mon, 28 Jul 2025 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753694208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYLUO9SCf1ieYOdxJxUxSy5fSnkL9djEjNOnTob6B2I=;
	b=dRjYDqINkB8IfY5WERe3po7VH8WaAY55O4GX3/ntxX8DEtV3gavcVgkbDjZptHr3xyQevy
	pSm6F+ozqD9RHcYpp5DquFwAsnjmUraUVH9sHHUCyt1fRtR5gs2eb52d+WKYa9tI0GpvT7
	atZlMDhhBML5fh0dA+CCwGbxnCLKQ0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753694208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYLUO9SCf1ieYOdxJxUxSy5fSnkL9djEjNOnTob6B2I=;
	b=ER9dxc2PXA706q2avaItvdjrQFqUQGJQd2IprxgVNlwL4UsB0q2juT07TkOEGBOOy1CTYo
	qtvkf4QAWk5BV0Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dRjYDqIN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ER9dxc2P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753694208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYLUO9SCf1ieYOdxJxUxSy5fSnkL9djEjNOnTob6B2I=;
	b=dRjYDqINkB8IfY5WERe3po7VH8WaAY55O4GX3/ntxX8DEtV3gavcVgkbDjZptHr3xyQevy
	pSm6F+ozqD9RHcYpp5DquFwAsnjmUraUVH9sHHUCyt1fRtR5gs2eb52d+WKYa9tI0GpvT7
	atZlMDhhBML5fh0dA+CCwGbxnCLKQ0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753694208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYLUO9SCf1ieYOdxJxUxSy5fSnkL9djEjNOnTob6B2I=;
	b=ER9dxc2PXA706q2avaItvdjrQFqUQGJQd2IprxgVNlwL4UsB0q2juT07TkOEGBOOy1CTYo
	qtvkf4QAWk5BV0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 684E41368A;
	Mon, 28 Jul 2025 09:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cSxyGQBAh2hSKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Jul 2025 09:16:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 11615A09BE; Mon, 28 Jul 2025 11:16:40 +0200 (CEST)
Date: Mon, 28 Jul 2025 11:16:40 +0200
From: Jan Kara <jack@suse.cz>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: consider disabling readahead if there are signs of
 thrashing
Message-ID: <khtydy2lpwip3cysfjiw7sa7effaagpx7tcbvgopqhsdb2h3fc@4xveh6pjxuoq>
References: <20250710195232.124790-1-roman.gushchin@linux.dev>
 <at4ojyziprhhktjgtfmuyzrqwfmomnly6fubkvmbtxkdnx6hpb@5nldc3vipwny>
 <875xffsxj4.fsf@linux.dev>
 <87jz3vdf9e.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz3vdf9e.fsf@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[linux.dev:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 721281F444
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Fri 25-07-25 16:25:49, Roman Gushchin wrote:
> Roman Gushchin <roman.gushchin@linux.dev> writes:
> > Jan Kara <jack@suse.cz> writes:
> >> On Thu 10-07-25 12:52:32, Roman Gushchin wrote:
> >>> We've noticed in production that under a very heavy memory pressure
> >>> the readahead behavior becomes unstable causing spikes in memory
> >>> pressure and CPU contention on zone locks.
> >>> 
> >>> The current mmap_miss heuristics considers minor pagefaults as a
> >>> good reason to decrease mmap_miss and conditionally start async
> >>> readahead. This creates a vicious cycle: asynchronous readahead
> >>> loads more pages, which in turn causes more minor pagefaults.
> >>> This problem is especially pronounced when multiple threads of
> >>> an application fault on consecutive pages of an evicted executable,
> >>> aggressively lowering the mmap_miss counter and preventing readahead
> >>> from being disabled.
> >>
> >> I think you're talking about filemap_map_pages() logic of handling
> >> mmap_miss. It would be nice to mention it in the changelog. There's one
> >> thing that doesn't quite make sense to me: When there's memory pressure,
> >> I'd expect the pages to be reclaimed from memory and not just unmapped. 
> >> Also given your solution uses !uptodate folios suggests the pages were
> >> actually fully reclaimed and the problem really is that filemap_map_pages()
> >> treats as minor page fault (i.e., cache hit) what is in fact a major page
> >> fault (i.e., cache miss)?
> >>
> >> Actually, now that I digged deeper I've remembered that based on Liu
> >> Shixin's report
> >> (https://lore.kernel.org/all/20240201100835.1626685-1-liushixin2@huawei.com/)
> >> which sounds a lot like what you're reporting, we have eventually merged his
> >> fixes (ended up as commits 0fd44ab213bc ("mm/readahead: break read-ahead
> >> loop if filemap_add_folio return -ENOMEM"), 5c46d5319bde ("mm/filemap:
> >> don't decrease mmap_miss when folio has workingset flag")). Did you test a
> >> kernel with these fixes (6.10 or later)? In particular after these fixes
> >> the !folio_test_workingset() check in filemap_map_folio_range() and
> >> filemap_map_order0_folio() should make sure we don't decrease mmap_miss
> >> when faulting fresh pages. Or was in your case page evicted so long ago
> >> that workingset bit is already clear?
> >>
> >> Once we better understand the situation, let me also mention that I have
> >> two patches which I originally proposed to fix Liu's problems. They didn't
> >> quite fix them so his patches got merged in the end but the problems
> >> described there are still somewhat valid:
> >
> > Ok, I got a better understanding of the situation now. Basically we have
> > a multi-threaded application which is under very heavy memory pressure.
> > I multiple threads are faulting simultaneously into the same page,
> > do_sync_mmap_readahead() can be called multiple times for the same page.
> > This creates a negative pressure on the mmap_miss counter, which can't be
> > matched by do_sync_mmap_readahead(), which is be called only once
> > for every page. This basically keeps the readahead on, despite the heavy
> > memory pressure.
> >
> > The following patch solves the problem, at least in my test scenario.
> > Wdyt?
> 
> Actually, a better version is below. We don't have to avoid the actual
> readahead, just not decrease mmap_miss if the page is locked.
> 
> --
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 0d0369fb5fa1..1756690dd275 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3323,9 +3323,15 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>         if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
>                 return fpin;
>  
> -       mmap_miss = READ_ONCE(ra->mmap_miss);
> -       if (mmap_miss)
> -               WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> +       /* If folio is locked, we're likely racing against another fault,
> +        * don't decrease the mmap_miss counter to avoid decreasing it
> +        * multiple times for the same page and break the balance.
> +        */
> +       if (likely(!folio_test_locked(folio))) {

I like this, although even more understandable to me would be to have

	  if (likely(folio_test_uptodate(folio)))

which should be more or less equivalent for your situation but would better
express, whether this is indeed a cache hit or not. But I can live with
either variant.

								Honza

> +               mmap_miss = READ_ONCE(ra->mmap_miss);
> +               if (mmap_miss)
> +                       WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> +       }
>  
>         if (folio_test_readahead(folio)) {
>                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

