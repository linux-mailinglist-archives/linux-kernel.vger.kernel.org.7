Return-Path: <linux-kernel+bounces-746260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C1B124B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED9B1CC3CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F56F23183B;
	Fri, 25 Jul 2025 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tbYE3nSx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ypVB8EjO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tbYE3nSx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ypVB8EjO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FB2D052
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753471965; cv=none; b=FBnPAh7TJsMM/ghzxvLPIrk7oN5b06/L0MgkMnGehn79BmEdZfvXts2WaWnPSxFgPmBLFtC5leOWPzGj7X9fifi2T9FP7iwvYyAZZ7v+BstoHSQSU5uZpmd+XH57bA0WXD9RT2ZcGfOOC7oo+HSEQ87wxlJAA95UWGSKa4zthRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753471965; c=relaxed/simple;
	bh=Fks1e3mxBnx57DY4awwAjAvjafouj/9mrpHu3CMS9oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6Nd4nz3nl1eFcfrI0x10nXp1j4AB/gBllHXQQwLsAg2Gj7pRsEwRpRzp39No3TRyooS7AtTsecSCsl4HzY5q7SX/5vMDBkopoER8Q6fTfx9SS1bLaoMs8Nw9mAaZwS1ZvSGXwapzrR6DC6GKI9mhja26uXD4QB4GmuFpSsTKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tbYE3nSx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ypVB8EjO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tbYE3nSx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ypVB8EjO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C46B1F387;
	Fri, 25 Jul 2025 19:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753471962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kF1KhrizHk8cMYmAS/UV7ZSg8lZF5MTa6MQ61yemQmU=;
	b=tbYE3nSxKmQALecEW7NbGT3lWMUCn8tUX6YvE4JmFZDZ9aZN8V8bT7ps52h2guZqVOQdqp
	X6xqTY1xP3UXqq5rpDjwWCYbz7bAcEvF88Zf3KP4bDIpLhkVgYY1Lk5OTuaPcGgJJzyIoB
	fi9tqxuL5Lz4+8SX5VyRLa6qW8fTgMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753471962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kF1KhrizHk8cMYmAS/UV7ZSg8lZF5MTa6MQ61yemQmU=;
	b=ypVB8EjOsj8rZTptp/A0jJntVhnTUJerguaNCzT6YA5lAttNGkmZ8xsM/CM+zzLd8ro9XZ
	jnNfWmP45jIdNWCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tbYE3nSx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ypVB8EjO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753471962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kF1KhrizHk8cMYmAS/UV7ZSg8lZF5MTa6MQ61yemQmU=;
	b=tbYE3nSxKmQALecEW7NbGT3lWMUCn8tUX6YvE4JmFZDZ9aZN8V8bT7ps52h2guZqVOQdqp
	X6xqTY1xP3UXqq5rpDjwWCYbz7bAcEvF88Zf3KP4bDIpLhkVgYY1Lk5OTuaPcGgJJzyIoB
	fi9tqxuL5Lz4+8SX5VyRLa6qW8fTgMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753471962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kF1KhrizHk8cMYmAS/UV7ZSg8lZF5MTa6MQ61yemQmU=;
	b=ypVB8EjOsj8rZTptp/A0jJntVhnTUJerguaNCzT6YA5lAttNGkmZ8xsM/CM+zzLd8ro9XZ
	jnNfWmP45jIdNWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59166134E8;
	Fri, 25 Jul 2025 19:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NXx4Etnbg2g3KwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 25 Jul 2025 19:32:41 +0000
Date: Fri, 25 Jul 2025 20:32:40 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 4/5] mm/mseal: simplify and rename VMA gap check
Message-ID: <bsyihkvtwxqofkccmfr2g3e7efhob7hzwcgup7jlaryvg7uqtc@qgtcv2i4amdo>
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
 <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
 <CABi2SkVeHWt+SKWWodXUNhXZi1Wv9YazEOGWEUJLvgPbopqBrA@mail.gmail.com>
 <ca6af6bc-1c5b-47fc-a00b-11d46867b5e7@lucifer.local>
 <CABi2SkVRmuRp459g0RBwyTbd5dACwe6AiHrpxYuPXj41MxHp+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVRmuRp459g0RBwyTbd5dACwe6AiHrpxYuPXj41MxHp+A@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,oracle.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0C46B1F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Fri, Jul 25, 2025 at 11:09:13AM -0700, Jeff Xu wrote:
> Hi Lorenzo
> 
> On Fri, Jul 25, 2025 at 10:43 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Fri, Jul 25, 2025 at 10:30:08AM -0700, Jeff Xu wrote:
> > > Hi Lorenzo,
> > >
> > > On Fri, Jul 25, 2025 at 1:30 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > The check_mm_seal() function is doing something general - checking whether
> > > > a range contains only VMAs (or rather that it does NOT contain any
> > > > unmapped regions).
> > > >
> > > > So rename this function to range_contains_unmapped().
> > > >
> > > Thanks for keeping the comments.
> >
> > You're welcome.
> >
> > >
> > > In the prior version of this patch, I requested that we keep the
> > > check_mm_seal()  and its comments. And this version keeps the comments
> > > but removes the check_mm_seal() name.
> >
> > I didn't catch that being your request.
> >
> > >
> > > As I said, check_mm_seal() with its comments is a contract for
> > > entry-check for mseal().  My understanding is that you are going to
> > > move range_contains_unmapped() to vma.c. When that happens, mseal()
> > > will lose this entry-check contract.
> >
> > This is just bizarre.
> >
> > Code doesn't stop working if you put it in another function.
> >
> > And you're now reviewing me for stuff I haven't done? :P
> >
> > >
> > > Contact is a great way to hide implementation details. Could you
> > > please keep check_mm_seal() in mseal.c and create
> > > range_contains_unmapped() in vma.c. Then you can refactor as needed.
> >
> > Wait what?
> >
> > OK maybe now I see what you mean, you want a function that just wraps
> > range_contains_unmapped() with a comment explaining the 'contract'.
> >
> Yes. You can view it that way from an implementation point of view.
> 
> Contract mainly serves as a way to help design and abstract the code.
>

What code? This is an extremely simple file. We don't need deep design
and abstractions here.

> > range_contains_unmapped() enforces your required contract and the comments
> > make it extremely explicit, so this is not a reasonable request, sorry.
> 
> Technically, this contract belongs to mseal, but if you have strong
> opinions on this, that's fine, as long as range_contains_unmapped()
> doesn't accidentally remove those comments in the future, which I'm
> sure you won't.
> 

As far as I'm concerned, mseal() has little to no contract - we still don't have
a solid definition of what mseal() is supposed to do, things are still fluctuating,
and there's no man page (and no one is going to look into random kernel comments
for this).

FTR: I entirely plan on axing this function in the near future (or will try to).
There's no valid reason for this to exist, and it's causing extra burden on the
implementation - besides serving as a poor example for future mmap-ish syscalls.

-- 
Pedro

