Return-Path: <linux-kernel+bounces-871276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9688BC0CCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC5F44F12E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E742F3C23;
	Mon, 27 Oct 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hJhThr6T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ncxeZr/B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+PNqcrg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5v2b7Iyf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F2419E968
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558958; cv=none; b=RRL2H8DZfsy7qh2JfoPXH3l0TL1KS17gsEbtnFWEyXM+fkuvGStbjpEqLqQltR0O3s+WU76Gl3zPGhwBlF/KA7p0Tqkz3UGiboFCfbbYYgyQZAMh2LzYcPDEZuEkwrJSqCoIxnWUlHW776QIgXztzHVWLFvrhdzs+9NTAGyXdrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558958; c=relaxed/simple;
	bh=UfCLvv3D/FHQpRiOiHwlLZb87bJPcCR06sZGGlg/3Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3vD3mlqLwdDTtSFCsJ8ExZ9CRUPjYP23HmlcCB+PbZfTCGp/8kowTItw/Cs9+ivROYUQ1Lz6H0STYzcT5HfKwcGM2FglocO+zvPly2BapIZqqZFs9YEwSnRcB7R/a1meUgRq+IUH9V7QLLNfwT4TKbocs5rQ8IPUIuODk/XEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hJhThr6T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ncxeZr/B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+PNqcrg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5v2b7Iyf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23BEF218F8;
	Mon, 27 Oct 2025 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761558955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TESXJivhsVzke6gCi9MxzocOEMcQDQbrv8+ih2jzD8=;
	b=hJhThr6T29fzVREluqb3hIvyxRa7ZFpoBH1rzIqnaqF/e+uPZeJ658pOM6rmZaTvWMhhLl
	2YqvpxJzwxmxJ7M7aI29PmM9M5COPkwNuoCeJWbMmfBueV79sTdWc0Sq/26cUtLa+AsqPB
	OOZYhbBqU0Vp7uLQFTLCgguKziz1KHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761558955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TESXJivhsVzke6gCi9MxzocOEMcQDQbrv8+ih2jzD8=;
	b=ncxeZr/BP5AH59oDaQyNeCiyZCMKqNQ9apFx+yUld0ikRHW8ZbeQeHwJGYRof1i63NH1DM
	Pu8lV8oziMIB9PBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o+PNqcrg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5v2b7Iyf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761558954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TESXJivhsVzke6gCi9MxzocOEMcQDQbrv8+ih2jzD8=;
	b=o+PNqcrgTPKZwZkneY6s38vHrTrY+zFw5l5oink1F2DPPpVAa2kUQwHz3JxEmmIaRDKTh3
	9K3Mvo5hspGHEcdsNXKcPGeMVh6hWMujdNy4dO8QIEYmREgkP83wNxTGYm2gAukKlAXuVW
	MFDEZx2HTauA8iayTBZ4WUqCAyVqhmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761558954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TESXJivhsVzke6gCi9MxzocOEMcQDQbrv8+ih2jzD8=;
	b=5v2b7IyfNkSKtv5HjNWUqzjFlVTbs3nE3L6zbSBnhnEaqMyv5xpjVsPBCFjVxCobcSQC1n
	s7apbN2iCAB9HTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C2CA136CF;
	Mon, 27 Oct 2025 09:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yv24E6lB/2iNeAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 Oct 2025 09:55:53 +0000
Date: Mon, 27 Oct 2025 10:55:52 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <aP9BqHy3ksstIxfU@localhost.localdomain>
References: <20251024192849.2765667-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024192849.2765667-1-gourry@gourry.net>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 23BEF218F8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,meta.com,linux-foundation.org,suse.cz,google.com,suse.com,cmpxchg.org,nvidia.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

On Fri, Oct 24, 2025 at 03:28:49PM -0400, Gregory Price wrote:
> We presently skip regions with hugepages entirely when trying to do
> contiguous page allocation.  Instead, if hugepage migration is enabled,
> consider regions with hugepages smaller than the target contiguous
> allocation request as valid targets for allocation.
> 
> isolate_migrate_pages_block() already expects requests with hugepages
> to originate from alloc_contig, and hugetlb code also does a migratable
> check when isolating in folio_isolate_hugetlb().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

