Return-Path: <linux-kernel+bounces-835029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F513BA6151
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 18:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E3D384424
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738602E54A8;
	Sat, 27 Sep 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AmrHyGWc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0lbHmIrC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fwK1QUJk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZlNFxdJ/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29432253A0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758989279; cv=none; b=R4wP9acy0x4Lrc1ibJrjo0TIMiIMF7Lp3GZhbo1ghSOvdyl5ACZYy/scPnZQv9wNPTs18sv8p31vjJTCyRJOe4eSQ9PSfh0ypdTgRtSPpuVnH1Ipm3rNZ1Bm+ebjmo0+pU0mbypkG7zOXGGZq20RIH08+uZKukzKZYrRpoqFlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758989279; c=relaxed/simple;
	bh=pEFjrWx+b4bwiFhn5YAcCDGCk0P675GLoLEYae3scTI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2gqdj4lBQMGfiqB0G5CKAkyhn3DY9G+9fmeKxPcCgoPTgHFJeRkihACL2EBlk43TbQeD+X1Pjc67r1h7TCVQ68MGDsPcQhwPwxK2alU4HqHihpNqdJ76qbwNcenTte1FmYNW3j3Oob159JaBNvQtDMkJ99lSaRKUPRGajT8xbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AmrHyGWc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0lbHmIrC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fwK1QUJk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZlNFxdJ/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD9C05BFBE;
	Sat, 27 Sep 2025 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758989276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWB3G0iRY8R8yfzfB76bPBUcUAb8hj+8GUu+T9YOPr0=;
	b=AmrHyGWcn03Besu5yY0pwxBToat1nmu7OvYMmhPQOrDk20Iap1QZRSM27r/6gFwTnGgp5y
	TgdmGdlX9P7XwcoU5eNsZj+/XG1LwSp1BiZZtpLEyPYf/0C11DrZ6cpyhC0XGsRiNgB3Un
	OK/akDYS7XzfoVUlzDKDi/8eO4TA/Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758989276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWB3G0iRY8R8yfzfB76bPBUcUAb8hj+8GUu+T9YOPr0=;
	b=0lbHmIrCzA+zxHtnosJV12xVH4vdB7tRGFds2IDbROvanWjBEh/Xw3XXQW0MqVClp5A+jI
	NaF8RCZ4IDMmo9Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758989275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWB3G0iRY8R8yfzfB76bPBUcUAb8hj+8GUu+T9YOPr0=;
	b=fwK1QUJkH+5hkTiyq+dWx100XIQ1H1od1z3TSDvMAl0Go5d3Rni7zvvyiap4blS6v6lWmU
	nETj5vLIDmet7ZvXzZpDqZ5QFV2mi3FDJMaliUV35L0C0C+IT5j4aNS3lCUISAprMgOtnp
	zCGHcwjiXHrTK1oICh3pbH/3Wy+kTJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758989275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWB3G0iRY8R8yfzfB76bPBUcUAb8hj+8GUu+T9YOPr0=;
	b=ZlNFxdJ/5rvMy5Z27z86nPWVeZ2k8SYCMJ0uANpz4Ow2ZMb+Weq5JcD7quuoaIzHciXNJQ
	lsJd5eKCAjhe/XDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80C0F1373E;
	Sat, 27 Sep 2025 16:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id au1xHdsL2GicOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 16:07:55 +0000
Date: Sat, 27 Sep 2025 18:07:55 +0200
Message-ID: <87cy7banfo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jeongjun Park <aha310510@gmail.com>
Cc: tiwai@suse.de,
	clemens@ladisch.de,
	hdanton@sina.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
In-Reply-To: <20250927154109.879926-1-aha310510@gmail.com>
References: <87o6qw9koa.wl-tiwai@suse.de>
	<20250927154109.879926-1-aha310510@gmail.com>
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[f02665daa2abeef4a947];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,ladisch.de,sina.com,vger.kernel.org,perex.cz,syzkaller.appspotmail.com,googlegroups.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Sat, 27 Sep 2025 17:41:09 +0200,
Jeongjun Park wrote:
> 
> Hi,
> 
> Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Sat, 27 Sep 2025 12:36:07 +0200,
> > Jeongjun Park wrote:
> > >
> > > syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > KASAN: slab-use-after-free Write in snd_usbmidi_in_urb_complete
> > > >
> > > > ==================================================================
> > > > BUG: KASAN: slab-use-after-free in snd_usbmidi_in_urb_complete+0x389/0x3c0 sound/usb/midi.c:251
> > > > Write of size 1 at addr ffff888074717943 by task kworker/1:3/5866
> > > >
> > >
> > > Wow, the UAF bug still occurs?
> > >
> > > But... this UAF seems to be a problem with how midi handles urb rather
> > > than a problem with my patch.
> > >
> > > Is there something wrong with the way snd_usbmidi_in_urb_complete() is
> > > implemented?
> >
> > This can be rather a missing kill-and-cleanup in the code path.
> > So the patch like below.
> >
> > Could you check whether this works for you instead of your fix, too?
> > timer_shutdown_sync() is already called in snd_usbmidi_disconnect(),
> > and the call in snd_usbmidi_free() should be superfluous after this
> > change.
> >
> 
> Since both my tests and syzbot tests did not cause any bugs when applying
> this patch, I think the root cause of this vulnerability is the missing
> kill error_timer + urb.
> 
> So, I think it would be okay to patch it this way, but in addition, since
> most of the endpoint delete-related code that existed in
> snd_usbmidi_free() is now done in snd_usbmidi_disconnect(),
> I think it would be appropriate to modify it to only perform
> kfree(ep->out) as in this patch below.

Yes, it makes sense.


thanks,

Takashi


> ---
>  sound/usb/midi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index acb3bf92857c..97e7e7662b12 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -1522,15 +1522,14 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
>  {
>  	int i;
>  
> +	if (!umidi->disconnected)
> +		snd_usbmidi_disconnect(&umidi->list);
> +
>  	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
>  		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
> -		if (ep->out)
> -			snd_usbmidi_out_endpoint_delete(ep->out);
> -		if (ep->in)
> -			snd_usbmidi_in_endpoint_delete(ep->in);
> +		kfree(ep->out);
>  	}
>  	mutex_destroy(&umidi->mutex);
> -	timer_shutdown_sync(&umidi->error_timer);
>  	kfree(umidi);
>  }
>  
> --
> 
> >
> > thanks,
> >
> > Takashi
> >
> > --- a/sound/usb/midi.c
> > +++ b/sound/usb/midi.c
> > @@ -1522,6 +1522,9 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
> >  {
> >         int i;
> >
> > +       if (!umidi->disconnected)
> > +               snd_usbmidi_disconnect(&umidi->list);
> > +
> >         for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
> >                 struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
> >                 if (ep->out)
> 
> Regards,
> Jeongjun Park

