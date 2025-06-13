Return-Path: <linux-kernel+bounces-686123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF00AD9358
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 19:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB6189424D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6905215179;
	Fri, 13 Jun 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u9aG/XAy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ocT+pKRE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u9aG/XAy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ocT+pKRE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228219E7E2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834030; cv=none; b=Jjj5URl5mNK13xgIhubJn5phow4G6H+e+iZoCXE7Y3GEZ0KBlAvwN9Z2IC1RnGtGciitfp9pLiJCj9SNf+X2kVEDYxC4qpY1JtcHJezH13/muDrBXuzGYGw26xqNVWEJ5wvOpuZ8Yd9gSyzIWB8LVdZDx1d3pDbFXkTjZW3frhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834030; c=relaxed/simple;
	bh=Ee23bSYewgw1pZtLKYfWhlq/qzuBs8kymYq9pjayqSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASAz09QlXY3m5AZWlK83X+qlHz0HUfQV5pjsdIF9xFERycq/wjVloEQpxw/dvH/n4LMfpphwQDbouUbZpxNFh5s8GWeW2iqclppzbbKSY+peVShHWSdgqkf6/TDkR3mOi/i3AqsAqomKWIUgoSKa7y79XpvpABPmtMvPBiFhz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u9aG/XAy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ocT+pKRE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u9aG/XAy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ocT+pKRE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9339C1F892;
	Fri, 13 Jun 2025 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749834026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UievMDUraOnDMl0JUSi8sCjrJFjc+fcUJjXG5uHY0QQ=;
	b=u9aG/XAy248ET//vYRdstDzkp9e1gMhJ9a1HNBFgWBgkqQ+DzLQHTCdDuzdjJXNyc8sQsj
	tJc3ghB024EctTUGHt0guaki0rPUDLxL5DFjJKiMw905+EiBJYUwcxBNeS8E/WWZh42zr6
	W+MEoKdKBOaRPeamP6LjmhCF59/urCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749834026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UievMDUraOnDMl0JUSi8sCjrJFjc+fcUJjXG5uHY0QQ=;
	b=ocT+pKRE0yIBuDKH/NadiAPPUhisX2hRv3LVIi3nXKaMqJ6vwZH5DwuI1Zki5i8j1KTFCd
	UVHFb9xm6+EPziCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749834026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UievMDUraOnDMl0JUSi8sCjrJFjc+fcUJjXG5uHY0QQ=;
	b=u9aG/XAy248ET//vYRdstDzkp9e1gMhJ9a1HNBFgWBgkqQ+DzLQHTCdDuzdjJXNyc8sQsj
	tJc3ghB024EctTUGHt0guaki0rPUDLxL5DFjJKiMw905+EiBJYUwcxBNeS8E/WWZh42zr6
	W+MEoKdKBOaRPeamP6LjmhCF59/urCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749834026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UievMDUraOnDMl0JUSi8sCjrJFjc+fcUJjXG5uHY0QQ=;
	b=ocT+pKRE0yIBuDKH/NadiAPPUhisX2hRv3LVIi3nXKaMqJ6vwZH5DwuI1Zki5i8j1KTFCd
	UVHFb9xm6+EPziCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABD6713782;
	Fri, 13 Jun 2025 17:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LSjlJilZTGgwRAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 13 Jun 2025 17:00:25 +0000
Date: Fri, 13 Jun 2025 18:00:23 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Zi Yan <ziy@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, David Hildenbrand <david@redhat.com>, 
	Nico Pache <npache@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Deduplicate mm_get_unmapped_area()
Message-ID: <koa6s4cdbnch45vr55td2okarbpyirnmqlvovvfsnu6rdagdu3@ofp2jkeryoa7>
References: <20250613134111.469884-1-peterx@redhat.com>
 <20250613134111.469884-2-peterx@redhat.com>
 <1fa31b8c-4074-45c7-ad59-077b9f0ab8fb@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fa31b8c-4074-45c7-ad59-077b9f0ab8fb@lucifer.local>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri, Jun 13, 2025 at 04:57:12PM +0100, Lorenzo Stoakes wrote:
> You've not cc'd maintainers/reviewers of mm/mmap.c, please make sure to do so.
> 
> +cc Liam
> +cc Vlastimiil
> +cc Jann
> +cc Pedro
> 
> ...!
> 
> On Fri, Jun 13, 2025 at 09:41:07AM -0400, Peter Xu wrote:
> > Essentially it sets vm_flags==0 for mm_get_unmapped_area_vmflags().  Use
> > the helper instead to dedup the lines.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> This looks fine though, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Looks good, thanks!

-- 
Pedro

