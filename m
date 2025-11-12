Return-Path: <linux-kernel+bounces-897162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133AC52306
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D923BD865
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5431C56A;
	Wed, 12 Nov 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w9nOhYJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jAac+cRE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w9nOhYJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jAac+cRE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705B31B82C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948620; cv=none; b=tUOI0ywytQ8hEQfsYFYIrOnv6zRzZlMQKH/n+GYMSsqho8nQ9Rc17HiFX2Kz/+x+xp0V5/aRLwxLSXKJfmB4pXuTWpk1AVSOVjNA+NniKl2cn2f/6AXEtMZ1tkyv4NGWVeO1IQIWAb8lWllabdOxcHZdf3qqoN03OBnqrCb6XC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948620; c=relaxed/simple;
	bh=nTxD04cgtxr5bIVSmvuAPorv6FrKbuExdhDGOEhl1AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zlg12YfKTR0gTWPjsu5tcw8EfDzKvJHCg5UzFQ5cqB1Q/shEaFkhtCu6ZG+c9yoE11IUgxJTxNsoCSes3P8Z4xjlVIIcJIlXRvoPoZ/1ogJ2cbJpx7TM/EikPyOPjVKKGQ1FFf7xwLVR0LWssbK7s8Opg0WZKuq/6Ig0sxCdrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w9nOhYJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jAac+cRE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w9nOhYJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jAac+cRE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CAEF1F45B;
	Wed, 12 Nov 2025 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762948616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0g2ZQGhI6iBBn2VcyWKzEcG+U4eJ7lGhaFDWj+BTHYQ=;
	b=w9nOhYJeRdw9nlV17PNOpINUgL9gTQyOFMOsYdfybI8OGqvUCcUmK6lzPmOYXCh0GVNJkv
	w8akBR0W0u0ovF5ITBxrgJxuvM2PzyfoUzQhfldntgG2qOHjkBvEryb4T8dXK8yh9IbFfz
	8MMc2FS6UBh06sng3Hz35XVKB75Iisw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762948616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0g2ZQGhI6iBBn2VcyWKzEcG+U4eJ7lGhaFDWj+BTHYQ=;
	b=jAac+cREUcPC2hYeqBGKcKTu0WDrmg+Qr74YJjX7dmSW3tT/4wz6itAyP6ydhSxd3dDYZm
	EDXH4FSXh8+pyVAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762948616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0g2ZQGhI6iBBn2VcyWKzEcG+U4eJ7lGhaFDWj+BTHYQ=;
	b=w9nOhYJeRdw9nlV17PNOpINUgL9gTQyOFMOsYdfybI8OGqvUCcUmK6lzPmOYXCh0GVNJkv
	w8akBR0W0u0ovF5ITBxrgJxuvM2PzyfoUzQhfldntgG2qOHjkBvEryb4T8dXK8yh9IbFfz
	8MMc2FS6UBh06sng3Hz35XVKB75Iisw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762948616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0g2ZQGhI6iBBn2VcyWKzEcG+U4eJ7lGhaFDWj+BTHYQ=;
	b=jAac+cREUcPC2hYeqBGKcKTu0WDrmg+Qr74YJjX7dmSW3tT/4wz6itAyP6ydhSxd3dDYZm
	EDXH4FSXh8+pyVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD9823EA61;
	Wed, 12 Nov 2025 11:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6YJwLwd2FGmJFQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 12 Nov 2025 11:56:55 +0000
Date: Wed, 12 Nov 2025 12:56:49 +0100
From: Oscar Salvador <osalvador@suse.de>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Muchun Song <muchun.song@linux.dev>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/memfd: clear hugetlb pages on allocation
Message-ID: <aRR2AV7_R20i4qi8@localhost.localdomain>
References: <20251112031631.2315651-1-kartikey406@gmail.com>
 <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com>
 <aRRPvn4DYAhuGtq3@localhost.localdomain>
 <6a63dbb8-58f7-4511-8090-18a58c3206d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a63dbb8-58f7-4511-8090-18a58c3206d8@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[f64019ba229e3a5c411b];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.dev,gmail.com,intel.com,linux.alibaba.com,linux-foundation.org,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Wed, Nov 12, 2025 at 11:09:51AM +0100, David Hildenbrand (Red Hat) wrote:
> On 12.11.25 10:13, Oscar Salvador wrote:
> > memfd_alloc_folio() seems to try to recreate what hugetlb_no_page()
> > would do (slightly different though).
> 
> Can we factor that out to merge both paths?

I guess it is worth looking into it, I shall fiddle with it.

> > Regarding the uptodate question, I do not see what is special about this situation
> > that we would not need it.
> > We seem to be marking the folio uptodate every time we do allocate a folio __and__
> > before adding it into the pagecache (which is expected, right?).
> 
> Right, at least filemap.c heavily depends on it being set (I don't think
> hugetlb itself needs it).

Yes, you are probably right.

> > Now, for the GFP_ZERO question.
> > This one is nasty.
> > hugetlb_reserve_pages() will allocate surplus folios without zeroing, but those
> > will be zeroed in the faulting path before mapping them into userspace pagetables
> > (see folio_zero_user() in hugetlb_no_page()).
> > So unless I am missing something we need to zero them in this case as well.
> 
> I assume we want to avoid GFP_ZERO and use folio_zero_user(), which is
> optimized for zeroing huge/gigantic pages.

Yes, I would go with folio_zero_user() as well, to match what we do in
all paths.
Maybe if we can factor it out, we can simplifiy it as right now seems a
small-duplication of hugetlb_no_page (and more so once we add what is
missing: mutex, uptodate and folio_zero_user).
 

-- 
Oscar Salvador
SUSE Labs

