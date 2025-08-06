Return-Path: <linux-kernel+bounces-757619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E178DB1C462
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900F418A55D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F0925A64C;
	Wed,  6 Aug 2025 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wa2wGgFn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8fT/7Dyr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yuUMPAUu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HLtTDCyS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1923A41
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476505; cv=none; b=nR4Y0LonXsU9nTgR0MMn0q9tujzTkhGO97eTmK4WHu/B64Ny4c9dPOM9WPJlsl2M6CWHlxaTZ8L6rqVekEfRM2c5CJHIt8cWsWPlwKsW90v39ZPARANK8bqFGMH9QpR+ShWui4dP4db6NfkMZbr8xC0TbRK1aWJOczQLhjOrT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476505; c=relaxed/simple;
	bh=jOv27bYas95QkeECm3PnrDh5I1MRkQkwmE/50PTvqts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJjpKWlOeVepsq6LuH/VNChzptNc8IW+HPXTinbOiJiW3yJ2IYLQTlp35FvRGWaOJCxoT1FKCpAaEV43MwWqgmeARjnkBwRlxUf/gTT34oFY5Z+fC3h9aMqNZya+vgyHYT+SOxqSjFVFuprXhIKwoBqNG0NNCCv83t6wiEwXk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wa2wGgFn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8fT/7Dyr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yuUMPAUu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HLtTDCyS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE805211E0;
	Wed,  6 Aug 2025 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754476501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7vXoJTyUOofn7iNpjbcuqYrzqeHk3HW6mJEtsTB0bk=;
	b=Wa2wGgFn9z5q6vRBMQ+z4njDof4QUAq9hyWYNrjDVNju7giFzzC/7iJARLyuXaTWqbFEkA
	Qs4xJ/WQwQWmvEXcRMwvXMaGi8Hhx3PyR0uTd4qBggYlZQ3spijR22Qeo+dixSpqMvbziq
	h/F/Y1VKmH/BpV8X5TasmuU0GYsIsZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754476501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7vXoJTyUOofn7iNpjbcuqYrzqeHk3HW6mJEtsTB0bk=;
	b=8fT/7DyrYwhJhV7ps1uut07EsEfi4JQKSX7fasxAUKkQdge78mFAvX5Ao3sgNu66iRuIAu
	9L2Ne4fM8CGizdDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754476499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7vXoJTyUOofn7iNpjbcuqYrzqeHk3HW6mJEtsTB0bk=;
	b=yuUMPAUuGv4E3V/oiEfpLyQbbPOJw+zjzvqcp4Q6UleSxIQkYJf4JtBe91RB/Uhvia7xZ9
	kemVn5AYxRoF8PeCGFBEA/DR8HdOIHIeBYLZlNvaSfHCoRfgq85gf4meSj2/poYmYwYGXD
	uaSomXEeLmAEp2bXdBTks5P8lviW5I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754476499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7vXoJTyUOofn7iNpjbcuqYrzqeHk3HW6mJEtsTB0bk=;
	b=HLtTDCySyCi6YR8MCMBb/aW3/vozaivzhtlXuImiRB+4MFZlF/hDnqZvstxo8TV7ATlH2j
	vPHmxeiNOLLnDsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8A0B13ABE;
	Wed,  6 Aug 2025 10:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ve+1LdIvk2gyNQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 06 Aug 2025 10:34:58 +0000
Date: Wed, 6 Aug 2025 11:34:57 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, wang lian <lianux.mm@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Jann Horn <jannh@google.com>, Kairui Song <ryncsn@gmail.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value
 correctly.
Message-ID: <vahlhhwb3vh33c7nh67usxfraeotqq5pw5cwfak5ke3ysegv5l@bgtlqmv2wqyf>
References: <20250805175140.241656-1-ziy@nvidia.com>
 <7eaa1660-06d3-49b9-ba5e-28df1c35dcd1@lucifer.local>
 <6E5CCF4D-CB63-4E4C-BEDA-6FE533E0DFCD@nvidia.com>
 <dc139b0b-e461-4edb-ba1d-fc824f875142@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc139b0b-e461-4edb-ba1d-fc824f875142@lucifer.local>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,linux-foundation.org,kvack.org,redhat.com,kernel.org,google.com,oracle.com,suse.cz,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[godbolt.org:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Tue, Aug 05, 2025 at 08:21:23PM +0100, Lorenzo Stoakes wrote:
> +cc Pedro
> 
> On Tue, Aug 05, 2025 at 03:09:54PM -0400, Zi Yan wrote:
> > On 5 Aug 2025, at 15:00, Lorenzo Stoakes wrote:
> >
> > > On Tue, Aug 05, 2025 at 01:51:40PM -0400, Zi Yan wrote:
> > >> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> > >> index c20298ae98ea..b55d1809debc 100644
> > >> --- a/tools/testing/selftests/mm/vm_util.h
> > >> +++ b/tools/testing/selftests/mm/vm_util.h
> > >> @@ -23,7 +23,7 @@
> > >>   * anything with it in order to trigger a read page fault. We therefore must use
> > >>   * volatile to stop the compiler from optimising this away.
> > >>   */
> > >> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> > >> +#define FORCE_READ(x) (*(const volatile typeof(x) *)&(x))
> > >
> > > NIT: but wonder if const is necessary, and also (as discussed off-list
> >
> > I just used READ_ONCE() code, but it is not necessary.
> 
> It's not end of the world though.
> 
> >
> > > again :) will this work with a (void) prefixed, just to a. make it clear
> > > we're reading but discarding and b. to avoid any possible compiler warning
> > > on this?
> >
> > Adding (void) makes no difference, at least from godbolt.
>

I disagree with adding (void), because volatile being properly propagated into
the type should hide any Wunused-value warnings (because volatile reads can have
side effects, so discarding a read is most definitely valid).

And as I was seeing in https://godbolt.org/z/jnWsET1vx yesterday, GCC (and clang)
can silently drop the volatile qualifier For Some Reason.

-- 
Pedro

