Return-Path: <linux-kernel+bounces-730344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20148B0436B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997EC4E1154
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5BC25F97C;
	Mon, 14 Jul 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfwhpM4x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5XAJ7Mkj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kdkptHNX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="75D590Bj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6FE1FF1A0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506222; cv=none; b=ltrCuomdEh4pz7oa3eaWZKIP9CwBabTr6FyQ0VfemNOEA3ILAgOSf2w7FxMh2R3SMBgaQYp4JAEFsF9SGjLU9rST4BPCmntmcD/45Ib86usI7h39NHV5LxXN0CRpZD7yNuRpxy0LnZFSn3hdea/bH9U9UkAd3NJCB6QXZHkL5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506222; c=relaxed/simple;
	bh=MfETYpRLsGbIqOvVSb4mRdE9sasKk8lzf64CSMzo25E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8qK58tghDq1I91ZanSkWtc/sm1fQo3Ycxk0geHn1LpaU61eXkckcUxeq9rVFRJ4DDQQjeExOpjuKUy9k1Qz1ucQNjt2AafGf4e+2qYozBNOFATLnI+FG3HdTlr3kAxKZ8ku7Cigu0LxCuZ6he4RUc8YuyOOV9FncAxT0uJ8Fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfwhpM4x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5XAJ7Mkj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kdkptHNX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=75D590Bj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33FE52115E;
	Mon, 14 Jul 2025 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752506213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0zCSwLeyGaWwD67hNeIU4ApHxfUm2so5D3bGdJtdMY=;
	b=BfwhpM4xYGgh7zh/o/ve31KUtw40u4LaaSdbuWGqAD0q+C/9F2krxPO+wSo660kN54Kqtk
	zt4cv2PFR2g6Tz305n3BEr0fMu69S0e9FPLsL+f7Nu0EAzjv9eiDHm+wkiIE7mn9fBxpYv
	DuzgEljtA0pQcOHIEdzekReVZQ15ztU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752506213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0zCSwLeyGaWwD67hNeIU4ApHxfUm2so5D3bGdJtdMY=;
	b=5XAJ7MkjteMeLcPT8X+3QhMOPR0zZwlJlB8yj1pl4i6fH7z55WAbLJHw8gFC/MHA6iMB1l
	zeUup+Q9Zk9NuzDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kdkptHNX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=75D590Bj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752506212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0zCSwLeyGaWwD67hNeIU4ApHxfUm2so5D3bGdJtdMY=;
	b=kdkptHNXFgS7qPrTY1iTEf4WN3PtWgQ6At923ISkD4TrySkiTO3X9Lvh/kWEtogwmqqi+Y
	WWpQewqmMQbX7gPpINvE3iVk1nUfmwnqRWDKNrzJLh8PYPWIIbM8FllfKekDbrQNTPjGti
	ZpOIEl7GdSiDEwa72xE4grZTXP07pio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752506212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0zCSwLeyGaWwD67hNeIU4ApHxfUm2so5D3bGdJtdMY=;
	b=75D590BjlWc9Hyb81ViH55LSpLmw/TYMOisroang9xClZ0kxqdiIQgLKb3F+YE/Yrl8kqa
	QayeGRJEu/MaCqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28E6113A57;
	Mon, 14 Jul 2025 15:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x9/3CWQfdWj2MQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Jul 2025 15:16:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C26EDA0998; Mon, 14 Jul 2025 17:16:51 +0200 (CEST)
Date: Mon, 14 Jul 2025 17:16:51 +0200
From: Jan Kara <jack@suse.cz>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: consider disabling readahead if there are signs of
 thrashing
Message-ID: <at4ojyziprhhktjgtfmuyzrqwfmomnly6fubkvmbtxkdnx6hpb@5nldc3vipwny>
References: <20250710195232.124790-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710195232.124790-1-roman.gushchin@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 33FE52115E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Thu 10-07-25 12:52:32, Roman Gushchin wrote:
> We've noticed in production that under a very heavy memory pressure
> the readahead behavior becomes unstable causing spikes in memory
> pressure and CPU contention on zone locks.
> 
> The current mmap_miss heuristics considers minor pagefaults as a
> good reason to decrease mmap_miss and conditionally start async
> readahead. This creates a vicious cycle: asynchronous readahead
> loads more pages, which in turn causes more minor pagefaults.
> This problem is especially pronounced when multiple threads of
> an application fault on consecutive pages of an evicted executable,
> aggressively lowering the mmap_miss counter and preventing readahead
> from being disabled.

I think you're talking about filemap_map_pages() logic of handling
mmap_miss. It would be nice to mention it in the changelog. There's one
thing that doesn't quite make sense to me: When there's memory pressure,
I'd expect the pages to be reclaimed from memory and not just unmapped. 
Also given your solution uses !uptodate folios suggests the pages were
actually fully reclaimed and the problem really is that filemap_map_pages()
treats as minor page fault (i.e., cache hit) what is in fact a major page
fault (i.e., cache miss)?

Actually, now that I digged deeper I've remembered that based on Liu
Shixin's report
(https://lore.kernel.org/all/20240201100835.1626685-1-liushixin2@huawei.com/)
which sounds a lot like what you're reporting, we have eventually merged his
fixes (ended up as commits 0fd44ab213bc ("mm/readahead: break read-ahead
loop if filemap_add_folio return -ENOMEM"), 5c46d5319bde ("mm/filemap:
don't decrease mmap_miss when folio has workingset flag")). Did you test a
kernel with these fixes (6.10 or later)? In particular after these fixes
the !folio_test_workingset() check in filemap_map_folio_range() and
filemap_map_order0_folio() should make sure we don't decrease mmap_miss
when faulting fresh pages. Or was in your case page evicted so long ago
that workingset bit is already clear?

Once we better understand the situation, let me also mention that I have
two patches which I originally proposed to fix Liu's problems. They didn't
quite fix them so his patches got merged in the end but the problems
described there are still somewhat valid:

    mm/readahead: Improve page readaround miss detection
    
    filemap_map_pages() decreases ra->mmap_miss for every page it maps. This
    however overestimates number of real cache hits because we have no idea
    whether the application will use the pages we map or not. This is
    problematic in particular in memory constrained situations where we
    think we have great readahead success rate although in fact we are just
    trashing page cache & disk. Change filemap_map_pages() to count only
    success of mapping the page we are faulting in. This should be actually
    enough to keep mmap_miss close to 0 for workloads doing sequential reads
    because filemap_map_pages() does not map page with readahead flag and
    thus these are going to contribute to decreasing the mmap_miss counter.

    Fixes: f1820361f83d ("mm: implement ->map_pages for page cache")

-
    mm/readahead: Fix readahead miss detection with FAULT_FLAG_RETRY_NOWAIT
    
    When the page fault happens with FAULT_FLAG_RETRY_NOWAIT (which is
    common) we will bail out of the page fault after issuing reads and retry
    the fault. That will then find the created pages in filemap_map_pages()
    and hence will be treated as cache hit canceling out the cache miss in
    do_sync_mmap_readahead(). Increment mmap_miss by two in
    do_sync_mmap_readahead() in case FAULT_FLAG_RETRY_NOWAIT is set to
    account for the following expected hit. If the page gets evicted even
    before we manage to retry the fault, we are under so heavy memory
    pressure that increasing mmap_miss by two is fine.

    Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transfer")

In particular the second problem described could still lead to mmap_miss
not growing as fast as it should so maybe it would be worth reviving it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

