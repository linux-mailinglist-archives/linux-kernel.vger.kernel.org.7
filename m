Return-Path: <linux-kernel+bounces-842946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B7BBE06B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112623B0C29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42E327EFE3;
	Mon,  6 Oct 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BVO08Xak";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FQBKHr63";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FOaW6HcY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c0UbS7nI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EDE2905
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753799; cv=none; b=unl5iuyXbPt+71wLiQtmFHQeCl/w6UcsFLU6TgW310z6xqDy+s9jdVHwFyQtml9KPT6lWHGYHOKSDigSTW2Wr6Cn1uNyzQ6jwDbsggf6HMkoji496TVJUKdXT8RYD2D5hlN0ZQ9C+iUU7DnDwctKVwMZa+52yzPlEHD4RILjPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753799; c=relaxed/simple;
	bh=rJV2QWWexz/u0UURI2j55GPs/Gx87LLnUU8nWbheVYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxzx0Pq9K1//EQSoi3qK9zrcm5mTG8LhQwE6UASOLtO4I/Zj948sfjv9q+Vo7b0nvEs3K8+ba6nm1GLpsK9/sckGZHCHWAaJz3ZIdbJk6MZCuOVfBZvf8Zbg+8t82nQjT+RxGu2cEpmfX/15zVsQy9YByyp4704sOxfrHgLN5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BVO08Xak; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FQBKHr63; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FOaW6HcY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c0UbS7nI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3559336CB;
	Mon,  6 Oct 2025 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759753796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyqW8nLiPWPAJiRXQpuxsOwKZY0xb3ZGoJOwx1jSOEc=;
	b=BVO08XakPjP8ynKlZGbGmlAnXcsax7UXmUWkJSs8ggIpvrhElXSNsopOyvSOS7aiv/2c19
	NugUKam6hQ/yxBP/f5fuQCX8o74wSr6yz+tld3uDqmMaMAijTBBLJX5inRwJwhO1sGKgSN
	FKjUS2FhVvhHA/mIZU4d40fRsV8xwc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759753796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyqW8nLiPWPAJiRXQpuxsOwKZY0xb3ZGoJOwx1jSOEc=;
	b=FQBKHr63ktNeqRo3Bqv302IpiLoTCtI9tp7iXRuml8GcnAtNnFEkdbvoCi2WzScv+bnqp/
	hnuKAUlWdkk80qBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FOaW6HcY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c0UbS7nI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759753795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyqW8nLiPWPAJiRXQpuxsOwKZY0xb3ZGoJOwx1jSOEc=;
	b=FOaW6HcY9xIY65f1Sm98M98UVJNzuuVaGnpt6GhleB/mOJAnD50sqwOYurJiq7q7vVfYiO
	yphHOF8mqYWwoRXAG4Gk3j0qPn/xMsOed6+qe/3Hp9rcNlH6S2uE5P4a3RTMy1IpIKDphM
	naCP5llUSuZkr2GHd7aZQL8aaORwWGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759753795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyqW8nLiPWPAJiRXQpuxsOwKZY0xb3ZGoJOwx1jSOEc=;
	b=c0UbS7nItRm4ET6nFbYZ+yAvL3DFRpSNNV3quxBgsEc806Kp4U9NdlfJ4DSKlYFAxXkdON
	W5TkGQmtPE/QXbBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3132113995;
	Mon,  6 Oct 2025 12:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xwdACUO242gfdwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 06 Oct 2025 12:29:55 +0000
Date: Mon, 6 Oct 2025 14:29:53 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Consistently use current->mm in
 mm_get_unmapped_area()
Message-ID: <aOO2QbLSTYXL2dMb@localhost.localdomain>
References: <20251003155306.2147572-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003155306.2147572-1-ryan.roberts@arm.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,arm.com:email,localhost.localdomain:mid,suse.de:email,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D3559336CB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On Fri, Oct 03, 2025 at 04:53:04PM +0100, Ryan Roberts wrote:
> mm_get_unmapped_area() is a wrapper around arch_get_unmapped_area() /
> arch_get_unmapped_area_topdown(), both of which search current->mm for
> some free space. Neither take an mm_struct - they implicitly operate on
> current->mm.
> 
> But the wrapper takes an mm_struct and uses it to decide whether to
> search bottom up or top down. All callers pass in current->mm for this,
> so everything is working consistently. But it feels like an accident
> waiting to happen; eventually someone will call that function with a
> different mm, expecting to find free space in it, but what gets returned
> is free space in the current mm.
> 
> So let's simplify by removing the parameter and have the wrapper use
> current->mm to decide which end to start at. Now everything is
> consistent and self-documenting.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

I think it looks cleaner:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

