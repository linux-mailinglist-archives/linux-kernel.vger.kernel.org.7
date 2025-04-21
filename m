Return-Path: <linux-kernel+bounces-612710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE76A952E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 16:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53761893A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8F1A5B91;
	Mon, 21 Apr 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mB5pmiQc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qkOpN9im";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mB5pmiQc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qkOpN9im"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6113AD1C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745246201; cv=none; b=LtVVkhdz4E/O6Un919Y+rJp7PjEKx7VEMTvvnHo1nsHUOB6TYzxTH7R5F34i7qxBnZ67XFJGzaKmNLZZRu11HrEBMiVhG4RLHRtTV/D66nvifIfn3pVO4GCV+4/if0hCh/87LkGNqcFSHshIN8mqlh9OmQiYIKIRKsQEgsfjahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745246201; c=relaxed/simple;
	bh=9NMCgPXMWqcwVbn9nvCNFGTuOp/p5VOnW2lVP6iy51U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwSQjTqXpqXyplqgYoETQP5iORvoLSJhNoJgD5G7Wj1XVQEd2h2gvIz+kpvXMrDANofaSw59jwKrsAhmcTs8z7bmTEvLxoXy5HfUsNYxs3U+Yv3vTFHaxAeAhYoe/732qKpCVIK7cHVlVCqcRCIjs0eq+2SMf30mcGzpmtdBtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mB5pmiQc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qkOpN9im; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mB5pmiQc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qkOpN9im; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FAB721200;
	Mon, 21 Apr 2025 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745246191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdgkOOhZ7i98IOUO6H+ogiBUcPrXO/Q5S/x1s1hKcW8=;
	b=mB5pmiQcDf2Sj2MiJIjzSpa7q2+nqUl1FjbKtb0xrbhpw7iHf6Ba6b6MPAgVAW6CgTpIn+
	Vt+w2KR/Jvfx7ZbfcdBIzutJGSqJprRGQgAvoD2MLbzylkMRa+y/2dKCwdRrT3qD9KsUhR
	mwY346vsKJS6Myis+2MxlF/vpXn4ouE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745246191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdgkOOhZ7i98IOUO6H+ogiBUcPrXO/Q5S/x1s1hKcW8=;
	b=qkOpN9imYW/3WrDDKdaxk4OOjqWyoUxi4a3u1qFXJIwgIPUsIXIIMqB2pigL/Nnlb7HhaE
	/lziII47NBQCFmAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745246191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdgkOOhZ7i98IOUO6H+ogiBUcPrXO/Q5S/x1s1hKcW8=;
	b=mB5pmiQcDf2Sj2MiJIjzSpa7q2+nqUl1FjbKtb0xrbhpw7iHf6Ba6b6MPAgVAW6CgTpIn+
	Vt+w2KR/Jvfx7ZbfcdBIzutJGSqJprRGQgAvoD2MLbzylkMRa+y/2dKCwdRrT3qD9KsUhR
	mwY346vsKJS6Myis+2MxlF/vpXn4ouE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745246191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PdgkOOhZ7i98IOUO6H+ogiBUcPrXO/Q5S/x1s1hKcW8=;
	b=qkOpN9imYW/3WrDDKdaxk4OOjqWyoUxi4a3u1qFXJIwgIPUsIXIIMqB2pigL/Nnlb7HhaE
	/lziII47NBQCFmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3551213A3D;
	Mon, 21 Apr 2025 14:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0dkMC+9XBmgvQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 21 Apr 2025 14:36:31 +0000
Date: Mon, 21 Apr 2025 16:36:30 +0200
Message-ID: <878qnttwcx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hillf Danton <hdanton@sina.com>
Cc: alsa-devel@alsa-project.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] ALSA: usb-audio: Fix possible race at sync of urb completions
In-Reply-To: <20250421104343.4197-1-hdanton@sina.com>
References: <20210929080844.11583-1-tiwai@suse.de>
	<20210929080844.11583-3-tiwai@suse.de>
	<20250418103533.4078-1-hdanton@sina.com>
	<87a58dvia7.wl-tiwai@suse.de>
	<20250418144518.4097-1-hdanton@sina.com>
	<875xj0ve49.wl-tiwai@suse.de>
	<20250419080410.4148-1-hdanton@sina.com>
	<871ptnuvad.wl-tiwai@suse.de>
	<87mscat1tq.wl-tiwai@suse.de>
	<20250421104343.4197-1-hdanton@sina.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[sina.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[alsa-project.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Mon, 21 Apr 2025 12:43:42 +0200,
Hillf Danton wrote:
> 
> On Mon, 21 Apr 2025 09:23:45 +0200 Takashi Iwai wrote:
> >On Mon, 21 Apr 2025 07:18:31 +0200, Hillf Danton wrote:
> >> On Sun, 20 Apr 2025 09:49:46 +0200 Takashi Iwai wrote:
> >> >On Sat, 19 Apr 2025 10:04:08 +0200, Hillf Danton wrote:
> >> >> On Sat, 19 Apr 2025 08:50:46 +0200 Takashi Iwai wrote:
> >> >> >On Fri, 18 Apr 2025 16:45:17 +0200, Hillf Danton wrote:
> >> >> >> On Fri, 18 Apr 2025 13:08:32 +0200 Takashi Iwai wrote:
> >> >> >> > On Fri, 18 Apr 2025 12:35:32 +0200 Hillf Danton wrote:
> >> >> >> > > On Wed, 29 Sep 2021 10:08:37 +0200 Takashi Iwai wrote:
> >> >> >> > > > USB-audio driver tries to sync with the clear of all pending URBs in
> >> >> >> > > > wait_clear_urbs(), and it waits for all bits in active_mask getting
> >> >> >> > > > cleared.  This works fine for the normal operations, but when a stream
> >> >> >> > > > is managed in the implicit feedback mode, there is still a very thin
> >> >> >> > > > race window: namely, in snd_complete_usb(), the active_mask bit for
> >> >> >> > > > the current URB is once cleared before re-submitted in
> >> >> >> > > > queue_pending_output_urbs().  If wait_clear_urbs() is called during
> >> >> >> > > > that period, it may pass the test and go forward even though there may
> >> >> >> > > > be a still pending URB.
> >> >> >> > > > 
> >> >> >> > > > For covering it, this patch adds a new counter to each endpoint to
> >> >> >> > > > keep the number of in-flight URBs, and changes wait_clear_urbs()
> >> >> >> > > > checking this number instead.  The counter is decremented at the end
> >> >> >> > > > of URB complete, hence the reference is kept as long as the URB
> >> >> >> > > > complete is in process.
> >> >> >> > > > 
> >> >> >> > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >> >> >> > > > ---
> >> >> >> > > >  sound/usb/card.h     | 1 +
> >> >> >> > > >  sound/usb/endpoint.c | 7 ++++++-
> >> >> >> > > >  2 files changed, 7 insertions(+), 1 deletion(-)
> >> >> >> > > > 
> >> >> >> > > > diff --git a/sound/usb/card.h b/sound/usb/card.h
> >> >> >> > > > index 3329ce710cb9..746a765b2437 100644
> >> >> >> > > > --- a/sound/usb/card.h
> >> >> >> > > > +++ b/sound/usb/card.h
> >> >> >> > > > @@ -97,6 +97,7 @@ struct snd_usb_endpoint {
> >> >> >> > > >  	unsigned int nominal_queue_size; /* total buffer sizes in URBs */
> >> >> >> > > >  	unsigned long active_mask;	/* bitmask of active urbs */
> >> >> >> > > >  	unsigned long unlink_mask;	/* bitmask of unlinked urbs */
> >> >> >> > > > +	atomic_t submitted_urbs;	/* currently submitted urbs */
> >> >> >> > > >  	char *syncbuf;			/* sync buffer for all sync URBs */
> >> >> >> > > >  	dma_addr_t sync_dma;		/* DMA address of syncbuf */
> >> >> >> > > >  
> >> >> >> > > > diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> >> >> >> > > > index 29c4865966f5..06241568abf7 100644
> >> >> >> > > > --- a/sound/usb/endpoint.c
> >> >> >> > > > +++ b/sound/usb/endpoint.c
> >> >> >> > > > @@ -451,6 +451,7 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
> >> >> >> > > >  		}
> >> >> >> > > >  
> >> >> >> > > >  		set_bit(ctx->index, &ep->active_mask);
> >> >> >> > > > +		atomic_inc(&ep->submitted_urbs);
> >> >> >> > > >  	}
> >> >> >> > > >  }
> >> >> >> > > >  
> >> >> >> > > > @@ -488,6 +489,7 @@ static void snd_complete_urb(struct urb *urb)
> >> >> >> > > >  			clear_bit(ctx->index, &ep->active_mask);
> >> >> >> > > >  			spin_unlock_irqrestore(&ep->lock, flags);
> >> >> >> > > >  			queue_pending_output_urbs(ep);
> >> >> >> > > 
> >> >> >> > > 			smp_mb();
> >> >> >> > > 
> >> >> >> > > > +			atomic_dec(&ep->submitted_urbs); /* decrement at last */
> >> >> >> > > 
> >> >> >> > > Does it match the comment to add a mb?
> >> >> >> > 
> >> >> >> > How...?  I don't understand your intention.
> >> >> >> > 
> >> >> >> In addition to the UAF report [1], I saw a customer report of list
> >> >> >> corruption of linux-6.1.99 on arm64 this week without reproducer.
> >> >> >> 
> >> >> >> 	list corruption
> >> >> >> 	list_add_tail();
> >> >> >> 	push_back_to_ready_list();
> >> >> >> 	snd_complete_urb();
> >> >> >> 
> >> >> >> And after another look at this patch I wonder if the race can not be
> >> >> >> erased without the certainty that ep will be no longer used after the
> >> >> >> atomic decrement.
> >> >> >
> >> >> > But why adding more barrier if you perform the atomic op...?
> >> >> >
> >> >> Because atomic op != ordering, see 26fbe9772b8c ("USB: core: Fix hang 
> >> >> in usb_kill_urb by adding memory barriers") for detail for example.
> >> >> And c5b2cbdbdac5 ("ipc/mqueue.c: update/document memory barriers") as well.
> >> >
> >> > Still don't get it.  Which reads and writes are you trying to solve?
> >> >
> >> See a simpler UAF case IIUIC.
> >> 
> >> 	cpu1		cpu2
> >> 			atomic_dec(&ep->submitted_urbs);
> >> 
> >> 	if (!atomic_read(&ep->submitted_urbs))
> >> 		kfree(ep);
> >> 
> >> 			a = ep->xxx; // UAF
> >
> > That's what I don't get it.  Which place does this UAF happen, more
> > specifically?  In the whole conversations, the context is missing, and
> > you provided only a snippet of the patch.
> >
> I misread "Which reads and writes are you trying to solve?" though I
> showed the read/write, but it is a bad case particulay with UAF.
> 
> Could you tell us what will happen if the race is not fixed? Could ep
> be freed with in-flight urbs for example?

Before the patch, wait_clear_urbs() might return earlier than actually
all pending eps are finished, so it can be UAF.

> Is it still race if the wait loop in wait_clear_urbs() ends before the
> urb complete callbace completes, given the last sentence in your commit
> message? If nope, igore my noise please.

Well, your concern about the missing barrier -- that would
wait_clear_urbs() missing the refcount decrement, hence it would be
rather to make the return delayed.  So it shouldn't lead to further
UAF, but at most it might lead to an unnecessary delay.

That said, I'm willing to take a fix even for a theoretical issue if
it clarifies what it really fixes.  But scratching a random surface
isn't what we want.


Takashi

