Return-Path: <linux-kernel+bounces-757605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E30CB1C41E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E0D62366F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89628A71C;
	Wed,  6 Aug 2025 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VTF7ly1E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vnYqMu7f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A4qB39q1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nfq0QB6H"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530D1922C0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475626; cv=none; b=TE1lZyzZM1YjlMbHIsO+LK7xjaWDuGSodiNSphNO52t6uzVJVuXxeHEfDj0hbe7O+Vlnsssew1+jcbOE2DBjT7mOu7tbYtgwt6DqLqCNc68xYMiwst1AXK+6TgyRdF6MXepnGkBb75TRQF61Pa2zHLaeinLprIabbGwVOKYnGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475626; c=relaxed/simple;
	bh=hz65t57/m1x5fjEO+8+5AT6u36mGdtC/uLbFmKdXfOo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+/IGZh+txUBK2jzRrCVqq5gAM1ThIs8Ol41XV9flnxlte0CSkC2mMBJnQ/ovA8NOltWskyEi06TljQTVCgZREixt+Jj8FZqQWimgu5rXDs/xG9jcWQQ82v+yBtgDcx0Z5pXZXxWXLZm+C+KzTJsXcf1jFnJqq8WWBUWWIKhhzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VTF7ly1E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vnYqMu7f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A4qB39q1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nfq0QB6H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76F0C21241;
	Wed,  6 Aug 2025 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754475622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFFPp9EM3GvVUWkraSvSCTNKuPEXbGOhmRF4SL4Qq+U=;
	b=VTF7ly1EO9zrWehsk9qKEe9JxCW1R7d+UoxP+66022gZB+27a2j2rXVWtyc7LqlYYCxdyH
	jo5a3oaU3zXxfYbrs3bzWmNsyKv4XyzgYlnDPwzth3YwdcfqJskMn5DuZSweJDA+iuknBH
	UzihOCAD6MriZ4QLhW7PHZkTjNYKZyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754475622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFFPp9EM3GvVUWkraSvSCTNKuPEXbGOhmRF4SL4Qq+U=;
	b=vnYqMu7fP+d6QyGNbxRZRM6e5HOJyHi662W2Vm/XTwhSRZ7ummqQlF7YZ9m6OoIZFk6IJB
	ZhbGcX4aVjyPKNBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A4qB39q1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nfq0QB6H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754475621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFFPp9EM3GvVUWkraSvSCTNKuPEXbGOhmRF4SL4Qq+U=;
	b=A4qB39q1dGl+vsB7xAfD1t9vfyVWbXmJZj8xaPmkLvS5DsU0VZXS1TX4uym37Wl3V+qyEs
	uc7k4mY0Q8ao7YDjt4jf13HwxQTRQvjJpuByE9M8x+MPtG2kq2UXN3EW4C9XN8NqOcHLXJ
	bMEyNSD/frH8xmC6nMMnx8KApfirRtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754475621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFFPp9EM3GvVUWkraSvSCTNKuPEXbGOhmRF4SL4Qq+U=;
	b=Nfq0QB6HhnG6zWDyL/rnkJuJ2vY677m91UbqU5RrVqTraEwFnc0rxCuYd8vXJjaekofTXW
	91Ne26eUbzVmiwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00FB313AFB;
	Wed,  6 Aug 2025 10:20:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JJaOGQsk2heMAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 06 Aug 2025 10:20:20 +0000
Date: Wed, 6 Aug 2025 11:20:19 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] maple_tree: Use kfree_rcu in ma_free_rcu
Message-ID: <tbm6emntje2lcwmg5xa6whlhsghwflbyb6p7m4y72dffenttqz@g2hftzczixxx>
References: <20250718172138.103116-1-pfalcato@suse.de>
 <l7kladnev3bfxcg2n2rk6hdi757vro5warlwp44ripj3qmnsfr@2jlwi7hhsfot>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l7kladnev3bfxcg2n2rk6hdi757vro5warlwp44ripj3qmnsfr@2jlwi7hhsfot>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 76F0C21241
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Tue, Aug 05, 2025 at 09:25:13PM -0400, Liam R. Howlett wrote:
> * Pedro Falcato <pfalcato@suse.de> [250718 13:21]:
> > kfree_rcu is an optimized version of call_rcu + kfree. It used to not be
> > possible to call it on non-kmalloc objects, but this restriction was
> > lifted ever since SLOB was dropped from the kernel, and since commit
> > 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()").
> > 
> > Thus, replace call_rcu + mt_free_rcu with kfree_rcu.
> [snip]
> >  static void mt_set_height(struct maple_tree *mt, unsigned char height)
> > @@ -5281,7 +5274,7 @@ static void mt_free_walk(struct rcu_head *head)
> >  	mt_free_bulk(node->slot_len, slots);
> >  
> >  free_leaf:
> > -	mt_free_rcu(&node->rcu);
> > +	mt_free_one(node);
> 
> Why are we still using mt_free_one()?  Couldn't this also be dropped in
> favour of kfree() or does kfree() not work for kmem_cache?

kfree() also works (since SLOB was dropped). I thought you wanted mt_free_one
for style points, but I can replace all calls with a direct kfree() if you prefer.

-- 
Pedro

