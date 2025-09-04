Return-Path: <linux-kernel+bounces-801151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FADDB4407A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BDA3B00CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26FF247283;
	Thu,  4 Sep 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kjXAefPq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kC7i+lo0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kjXAefPq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kC7i+lo0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811D23DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999503; cv=none; b=ERovtwsi0vP7mc890a/UfcfyhhxQ8B1Scc4prEbV+NvEGf+ROBtOgXBmQ0cUe3D57YGYVa9d4I38ls48f+xM5Huf+ReYNKo+lGL5r3AIODNTgm+QQcHgWViOrWc8jsOkb8MNYXsCBSd1LTbWDJq5s8ZNC7FdCH0FsL0YQr0+aKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999503; c=relaxed/simple;
	bh=8uxjB77zh93nvtozwDdXq/cGprU9Bl+cGE/at4e7Er0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsbUCZFkiOldfqIh9gg8Y/HNAk29zzBQt80guvJswPJvRT2lQb5KHMMm7iKFMQiVe929MlKPo3GpMDk1pnSS6idujLcIzAABCK5evxN82R3iNSQjlJcWoZ2rtirAZEk1ynRW3D9D840gsJCyBgDkK89Q8wbbrtG2Acc/a/6/sh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kjXAefPq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kC7i+lo0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kjXAefPq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kC7i+lo0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EB1C603E6;
	Thu,  4 Sep 2025 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756999499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL8T0f8bsgsh8WsNAI90N4zr5/umNEqCtxWVlPWGNG0=;
	b=kjXAefPqYoNG8Ma0IpSoGZOwQgheUlxRs57VnudLeaqkoz31z4UEzPJsJq1CkdEU3m3NlO
	772chMlSZSeqgSk8xXFNyhRzEg2IhEmUk5le9vCPUIBARh6lxmU2Gnw/vGu+sSIKjc12dT
	OORWQclkjaTHB98YkTbLCzB83lTIzBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756999499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL8T0f8bsgsh8WsNAI90N4zr5/umNEqCtxWVlPWGNG0=;
	b=kC7i+lo0lDkYWwCT0+zRR/hUhf5nKlwHNcGXmgG3RoBMp6q33uZnBWim7zwQZAoXxU3aoh
	EfVeyNYpNj6StyAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756999499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL8T0f8bsgsh8WsNAI90N4zr5/umNEqCtxWVlPWGNG0=;
	b=kjXAefPqYoNG8Ma0IpSoGZOwQgheUlxRs57VnudLeaqkoz31z4UEzPJsJq1CkdEU3m3NlO
	772chMlSZSeqgSk8xXFNyhRzEg2IhEmUk5le9vCPUIBARh6lxmU2Gnw/vGu+sSIKjc12dT
	OORWQclkjaTHB98YkTbLCzB83lTIzBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756999499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL8T0f8bsgsh8WsNAI90N4zr5/umNEqCtxWVlPWGNG0=;
	b=kC7i+lo0lDkYWwCT0+zRR/hUhf5nKlwHNcGXmgG3RoBMp6q33uZnBWim7zwQZAoXxU3aoh
	EfVeyNYpNj6StyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E82C13AA0;
	Thu,  4 Sep 2025 15:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VmvfE0qvuWhLCwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 04 Sep 2025 15:24:58 +0000
Date: Thu, 4 Sep 2025 16:24:56 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, 
	lorenzo.stoakes@oracle.com, kernel-team@android.com, android-mm@google.com, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
Message-ID: <7eh332fqbhxak2afcwt6mwzaxu7s3dj2tx4hrtt7ivo3oxovcg@avz6uniwdzpi>
References: <20250903232437.1454293-1-kaleshsingh@google.com>
 <qa7b7pvrycejnn6pjytxysu57xckhexupjrzefmk4j5hlaxka3@ayeg2vzpfe3r>
 <CAC_TJvd0SnHpEv0MSwXsF4UFpP0MNvRc033=JS1xTEHAOjQY5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvd0SnHpEv0MSwXsF4UFpP0MNvRc033=JS1xTEHAOjQY5A@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Wed, Sep 03, 2025 at 08:01:50PM -0700, Kalesh Singh wrote:
> On Wed, Sep 3, 2025 at 4:46 PM Pedro Falcato <pfalcato@suse.de> wrote:
> >
<snip>
> > >
> > >       /* Too many mappings? */
> > > -     if (mm->map_count > sysctl_max_map_count)
> > > +     if (exceeds_max_map_count(mm, 0))
> > >               return -ENOMEM;
> >
> > If the brk example is incorrect, isn't this also wrong? /me is confused
> 
> Ahh you are right, this will also go over by 1 once we return from
> mmap_region(). I'll batch this with the do_brk_flags() fix.
> 
> > >
> > >       /*
> > > @@ -1504,6 +1504,19 @@ struct vm_area_struct *_install_special_mapping(
> > >  int sysctl_legacy_va_layout;
> > >  #endif
> > >
> > > +static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
> > > +
> > > +bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vmas)
> > > +{
> > > +     if (unlikely(mm->map_count + new_vmas > sysctl_max_map_count)) {
> > > +             pr_warn_ratelimited("%s (%d): Map count limit %u exceeded\n",
> > > +                                 current->comm, current->pid,
> > > +                                 sysctl_max_map_count);
> >
> > I'm not entirely sold on the map count warn, even if it's rate limited. It
> > sounds like something you can hit in nasty edge cases and nevertheless flood
> > your dmesg (more frustrating if you can't fix the damn program).
> 
> I don't feel strongly about this, I can drop it in the next revision.

FWIW, I don't feel strongly about it either, and I would not mind if there's a
way to shut it up (cmdline, or even sysctl knob?). Let's see if anyone has a
stronger opinion.

> 
> >
> > In any case, if we are to make the checks more strict, we should also add
> > asserts around the place. Though there's a little case in munmap() we can indeed
> > go over temporarily, on purpose.
> 
> To confirm, do you mean we should WARN_ON() checks where map count is
> being incremented?

Yes, _possibly_ gated off by CONFIG_DEBUG_VM.

> 
> >  Though there's a little case in munmap() we can indeed
> >  go over temporarily, on purpose.
> 
> For the 3 way split we need 1 additional VMA after munmap completed as
> one of the 3 gets unmapped. The check is done in the caller beforehand
> as __split_vma() explicitly doesn't check map_count. Though if we add
> asserts we'll need a variant of vma_complete() or the like that
> doesn't enforce the threshold.

Right, it might get a little hairy, which is partly why I'm not super into
the idea. But definitely worth considering as a way to help prevent these
sorts of problems in the future.

-- 
Pedro

