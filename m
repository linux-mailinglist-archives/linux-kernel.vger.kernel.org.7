Return-Path: <linux-kernel+bounces-896824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071E5C51501
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406473A434F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A832FDC5B;
	Wed, 12 Nov 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xTn4hJmo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h4g1xlLI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xTn4hJmo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h4g1xlLI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00C2FD692
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938820; cv=none; b=EgSFzsGlg6n3OXW+xN9rARlxc8PIIvB17VJVeDxZp4B60sl8Lq8KEPv3BkMgUbfGfjeWTSt5o/ETmcjiUzMqeWA0t0g0DCA3l8DlN2YsolnSSGoLqVsa3LfVgrYMQ99gdR1POPG7UlKQ8Y9hhq/XnKqdciJKzf8Q0z0obMjv1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938820; c=relaxed/simple;
	bh=zM5TRUCmMmraWW0t8JZQRhV6yxwUUTHiXmGBDI6fs0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q40cnI8S44x4P/wNRqUctCakWY40DSKlvHw5JO4s8n5Kt2b+fvE/x7kGxnZhapfvj93EFsQEmga2sfAwD9NJW54q2Xt2Yr2ZT2yhLC0Do3ZPmMkFyVeQo5rjgoN6yH/+zpLg89ZwcpmXBfagndaVs/cszfxXKEC15CdU0MM6RvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xTn4hJmo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h4g1xlLI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xTn4hJmo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h4g1xlLI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DB7A1F45E;
	Wed, 12 Nov 2025 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762938816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOkexIAv3v1duPJ1ViOi5rMNa1miLiwCtXPhdmXLxp0=;
	b=xTn4hJmoP9BdmIdEZZL+ENruH10vR6IjNXoBgVIDacRFj0dj9+C8I+wpFgqvnhh9wrEQVF
	ZP49g6jiBAZDvAcZqw9j1LyhpW7do6s6zpgFmmvWUeeN7vL8N55WbgCJtSw4cir1JX9p+8
	7pAB5Xuyz+ZMEMCorsjRX954lI5LmU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762938816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOkexIAv3v1duPJ1ViOi5rMNa1miLiwCtXPhdmXLxp0=;
	b=h4g1xlLIKRO8zI6qtfxagw+bHr+RCvDq3wwpTdTCPXXC4sq84KVWoWCwmxmLn98Pkns8Mi
	8IGK4AexbxaINtDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762938816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOkexIAv3v1duPJ1ViOi5rMNa1miLiwCtXPhdmXLxp0=;
	b=xTn4hJmoP9BdmIdEZZL+ENruH10vR6IjNXoBgVIDacRFj0dj9+C8I+wpFgqvnhh9wrEQVF
	ZP49g6jiBAZDvAcZqw9j1LyhpW7do6s6zpgFmmvWUeeN7vL8N55WbgCJtSw4cir1JX9p+8
	7pAB5Xuyz+ZMEMCorsjRX954lI5LmU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762938816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOkexIAv3v1duPJ1ViOi5rMNa1miLiwCtXPhdmXLxp0=;
	b=h4g1xlLIKRO8zI6qtfxagw+bHr+RCvDq3wwpTdTCPXXC4sq84KVWoWCwmxmLn98Pkns8Mi
	8IGK4AexbxaINtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A12E23EA61;
	Wed, 12 Nov 2025 09:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5gSIJL9PFGk2cAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 12 Nov 2025 09:13:35 +0000
Date: Wed, 12 Nov 2025 10:13:34 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Hugh Dickins <hughd@google.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/memfd: clear hugetlb pages on allocation
Message-ID: <aRRPvn4DYAhuGtq3@localhost.localdomain>
References: <20251112031631.2315651-1-kartikey406@gmail.com>
 <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[linux.dev,redhat.com,gmail.com,intel.com,linux.alibaba.com,linux-foundation.org,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[f64019ba229e3a5c411b];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Tue, Nov 11, 2025 at 10:55:03PM -0800, Hugh Dickins wrote:
> Thanks a lot, Deepanshu and syzbot: this sounds horrid, and important
> to fix very soon; and wlll need a Fixes tag (with stable Cc'ed when
> the fix goes into mm.git), I presume it's
> 
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> 
> But although my name appears against mm/memfd.c, the truth is I know
> little of hugetlb (maintainers now addressed), and when its folios
> are supposed to get zeroed (would a __GFP_ZERO somewhere be better?).
> 
> I was puzzled by how udmabuf came into the picture, since hugetlbfs
> has always supported the read (not write) system call: but see now
> that there is this surprising backdoor into the hugetlb subsystem,
> via memfd and GUP pinning.
> 
> And where does that folio get marked uptodate, or is "uptodate"
> irrelevant on hugetlbfs?  Are the right locks taken, or could
> there be races when adding to hugetlbfs cache in this way?

Thanks Hugh for raising this up.

memfd_alloc_folio() seems to try to recreate what hugetlb_no_page()
would do (slightly different though).

The thing is that as far as I know, we should grab hugetlb mutex before
trying to add a new page in the pagecache, per comment in
hugetlb_fault():

 "
   /*
    * Serialize hugepage allocation and instantiation, so that we don't
    * get spurious allocation failures if two CPUs race to instantiate
    * the same page in the page cache.
    */
 "

and at least that is what all callers of hugetlb_add_to_page_cache() do
at this moment, all except memfd_alloc_folio(), so I guess this one
needs fixing.

Regarding the uptodate question, I do not see what is special about this situation
that we would not need it.
We seem to be marking the folio uptodate every time we do allocate a folio __and__
before adding it into the pagecache (which is expected, right?).

Now, for the GFP_ZERO question.
This one is nasty.
hugetlb_reserve_pages() will allocate surplus folios without zeroing, but those
will be zeroed in the faulting path before mapping them into userspace pagetables
(see folio_zero_user() in hugetlb_no_page()).
So unless I am missing something we need to zero them in this case as well.


-- 
Oscar Salvador
SUSE Labs

