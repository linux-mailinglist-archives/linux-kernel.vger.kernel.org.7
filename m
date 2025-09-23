Return-Path: <linux-kernel+bounces-828393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB3BB94881
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E5E7B0DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B656630F547;
	Tue, 23 Sep 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aL2Q5Jgq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dzYYVhyQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aL2Q5Jgq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dzYYVhyQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF430E0F2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608216; cv=none; b=c4FnfjO78KgxH4GlQ7+92z8xyDUWGSoL5LyULW2LLD3zFNUqtl/Bf+RAP0I5DMf43NO9y7Rrb9gkf6TcCciNjjIIuCcdKCfcFPr5dI+kOTZF8U9hpB8l1YdIQZJ6DDVcxEaKgNMT9vEPC/Bhj4rWR3L+isuK0cuHzQGnf63xM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608216; c=relaxed/simple;
	bh=O6UZBIFr/8dJ/szM90Rvb2v7Zrryc51CQWUSzEMKE1k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTzLwDfRK7/tM6k6/TDc+iGeMS60ZKfHzCWa2HE4b1TJ0H323EIUinhQPuhsIz2KAK72QUv9v9VfU3tkAcr0C5jzGfvXLJ+fJ1RSo4xL7DhpINo33KFDULjy6Ya//ZHZ9r1XK/2OoeU6uAvg6HtDdXCFaaiR0PwTK+tEV6jOW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aL2Q5Jgq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dzYYVhyQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aL2Q5Jgq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dzYYVhyQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19D2D2268A;
	Tue, 23 Sep 2025 06:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758608206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQoL8SOuGRB0ekzPeOtupj2pttzN+8hBSFOtCyMsG+E=;
	b=aL2Q5JgqKEXg5lCD74pvyphtvXfk9XBEgfKUTRWoFWLHqRfjpizahLwndvb3tJqkkkgemO
	SkSzyOLJ8FWv/TXdNx66lUMYbL4CKDr0+wT6zvGRbttLqYAX5vCoTW5pnLpSi4D2aSt82f
	LGG3RIcO/nQ+2mJDTE7xSs5+CV/lMnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758608206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQoL8SOuGRB0ekzPeOtupj2pttzN+8hBSFOtCyMsG+E=;
	b=dzYYVhyQK3RTyANKL9LTgmhhbmlY+zeYa57o9lKIsi/XJZqsXHIsRGi8NJEND3u4ELnaSo
	Ge6WDHXWUvY9wiCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758608206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQoL8SOuGRB0ekzPeOtupj2pttzN+8hBSFOtCyMsG+E=;
	b=aL2Q5JgqKEXg5lCD74pvyphtvXfk9XBEgfKUTRWoFWLHqRfjpizahLwndvb3tJqkkkgemO
	SkSzyOLJ8FWv/TXdNx66lUMYbL4CKDr0+wT6zvGRbttLqYAX5vCoTW5pnLpSi4D2aSt82f
	LGG3RIcO/nQ+2mJDTE7xSs5+CV/lMnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758608206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQoL8SOuGRB0ekzPeOtupj2pttzN+8hBSFOtCyMsG+E=;
	b=dzYYVhyQK3RTyANKL9LTgmhhbmlY+zeYa57o9lKIsi/XJZqsXHIsRGi8NJEND3u4ELnaSo
	Ge6WDHXWUvY9wiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDE4C132C9;
	Tue, 23 Sep 2025 06:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5m2WLE070mhCFwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 23 Sep 2025 06:16:45 +0000
Date: Tue, 23 Sep 2025 08:16:45 +0200
Message-ID: <87plbhn16a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Brahmajit Das <listout@listout.xyz>,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	clemens@ladisch.de,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH 1/1] ALSA: usb-audio: Avoid NULL dereference in snd_usbmidi_do_output()
In-Reply-To: <43ab3d0e-4b56-4292-aa51-2473e766dca5@rowland.harvard.edu>
References: <68d17f44.050a0220.13cd81.05b7.GAE@google.com>
	<20250922231720.3603805-1-listout@listout.xyz>
	<43ab3d0e-4b56-4292-aa51-2473e766dca5@rowland.harvard.edu>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[f02665daa2abeef4a947];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,syzkaller.appspot.com:url,appspotmail.com:email]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Tue, 23 Sep 2025 04:40:13 +0200,
Alan Stern wrote:
> 
> On Tue, Sep 23, 2025 at 04:47:20AM +0530, Brahmajit Das wrote:
> > Syzkaller reported a general protection fault in snd_usbmidi_do_output(),
> > caused by dereferencing a NULL URB pointer when accessing
> > ep->urbs[urb_index].urb.
> > 
> > This can happen in rare race conditions where the URB was not initialized
> > or was already freed (e.g. during disconnect or after errors), and the
> > output timer or other path tries to reuse it.
> > 
> > Fix this by checking if the URB is NULL before accessing it, and skipping
> > the current slot if it is.
> > 
> > Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
> > 
> > Signed-off-by: Brahmajit Das <listout@listout.xyz>
> > ---
> >  sound/usb/midi.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> > index acb3bf92857c..7919a39decb4 100644
> > --- a/sound/usb/midi.c
> > +++ b/sound/usb/midi.c
> > @@ -307,6 +307,10 @@ static void snd_usbmidi_do_output(struct snd_usb_midi_out_endpoint *ep)
> >  	for (;;) {
> >  		if (!(ep->active_urbs & (1 << urb_index))) {
> >  			urb = ep->urbs[urb_index].urb;
> > +			if (!urb) {
> > +				// Skip this urb
> > +				goto next_urb;
> > +			}
> 
> What prevents the URB from being freed right here?  If this happens, 
> the code below would access memory that was deallocated.
> 
> To prevent races, you have to use some sort of lock or other 
> synchronization mechanism.  A simple test won't work.

Yes.  The timer instance itself should have been killed before
releasing the resources.

I guess the patch below could cover it, but since I'm traveling, I
can't check it for now.  Will check later once after I'm back.


thanks,

Takashi

--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1511,6 +1511,7 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	timer_shutdown_sync(&umidi->error_timer);
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
 		if (ep->out)
@@ -1519,7 +1520,6 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 			snd_usbmidi_in_endpoint_delete(ep->in);
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 

