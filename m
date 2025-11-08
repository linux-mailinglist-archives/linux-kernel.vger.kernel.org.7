Return-Path: <linux-kernel+bounces-891375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6800EC428FA
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CED43B3712
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4B2D77E2;
	Sat,  8 Nov 2025 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wpkdcoip";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iSsZBQjn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wpkdcoip";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iSsZBQjn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F81A9F96
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762588455; cv=none; b=hnN7Oy/miE0workGBb6oDDdiDsi2REtNNXP5U1axrWPcyp5ta9ThwsZSsS9c5A5NpFlaVPcptXc38h5xLebcm6L+E6gHVBCaDDL//PlM5Nw0aQXhgCMygvt4ZLKsAclg8Pm7BzGf4UWuQq2gTRZak7HotE1FX6urIc2w/l1qE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762588455; c=relaxed/simple;
	bh=x9Cvk2w3Be44QRSRnD3QOpRGh8ixKMMdaM8/6JAiIK0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBc7Ubu9kcLyyYt7ijEPbUZS9JH+An2aBkaXQR8Mdvxjqi+5kECdpTR+39Umtl8L+eRXeBskL+pe4NhwV0RKJASC5SFXiuJgGwEawMHdrxGMCbj7N//p2CkMSlFwjGkqCTpoVNB/9DwOI/iPLPZXkDVXuz0TTf6ySyFSw5iOIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wpkdcoip; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iSsZBQjn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wpkdcoip; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iSsZBQjn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 363E033AB5;
	Sat,  8 Nov 2025 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762588449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClCydj//lm9b3U053b1+/bXfAX4WMW9Kn0vFpuj8bwk=;
	b=Wpkdcoip/T5Sc03dlJonr7Z+vUgFbGdtC/5pGakctguyZnbRk7w5L8IL5KHe+sAeP12Sk9
	BPnbFHkqMSlTMZ4qQsw+wpUwtAreEOi/oynxAUH+6cNHLR9D9tkT3TlonEEpyP/8OhbBEp
	gSQG2v2sVitUmDgsiiBPj9swdH5Ozic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762588449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClCydj//lm9b3U053b1+/bXfAX4WMW9Kn0vFpuj8bwk=;
	b=iSsZBQjnqzy79Q2ZTocqo1fbsfXkfv/H3USzQY7YoSBrY5OAobIrAI61YXZNpMHK26lSUk
	Nn3UEwgOxdI4EKDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wpkdcoip;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iSsZBQjn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762588449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClCydj//lm9b3U053b1+/bXfAX4WMW9Kn0vFpuj8bwk=;
	b=Wpkdcoip/T5Sc03dlJonr7Z+vUgFbGdtC/5pGakctguyZnbRk7w5L8IL5KHe+sAeP12Sk9
	BPnbFHkqMSlTMZ4qQsw+wpUwtAreEOi/oynxAUH+6cNHLR9D9tkT3TlonEEpyP/8OhbBEp
	gSQG2v2sVitUmDgsiiBPj9swdH5Ozic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762588449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ClCydj//lm9b3U053b1+/bXfAX4WMW9Kn0vFpuj8bwk=;
	b=iSsZBQjnqzy79Q2ZTocqo1fbsfXkfv/H3USzQY7YoSBrY5OAobIrAI61YXZNpMHK26lSUk
	Nn3UEwgOxdI4EKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E538213675;
	Sat,  8 Nov 2025 07:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nf9ONiD3DmlBcQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 08 Nov 2025 07:54:08 +0000
Date: Sat, 08 Nov 2025 08:54:08 +0100
Message-ID: <87bjldq7rz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <tiwai@suse.de>,
	<hdanton@sina.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<perex@perex.cz>,
	<syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ALSA: usb-audio: Prevent urb from writing out of bounds
In-Reply-To: <20251107011327.3634361-1-lizhi.xu@windriver.com>
References: <20251107005420.3537826-1-lizhi.xu@windriver.com>
	<20251107011327.3634361-1-lizhi.xu@windriver.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 363E033AB5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[bfd77469c8966de076f7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,sina.com,vger.kernel.org,perex.cz,syzkaller.appspotmail.com,googlegroups.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 

On Fri, 07 Nov 2025 02:13:27 +0100,
Lizhi Xu wrote:
> 
> On Fri, 7 Nov 2025 08:54:20 +0800, Lizhi Xu wrote:
> > > > > > > > The calculation rule for the actual data length written to the URB's
> > > > > > > > transfer buffer differs from that used to allocate the URB's transfer
> > > > > > > > buffer, and in this problem, the value used during allocation is smaller.
> > > > > > > >
> > > > > > > > This ultimately leads to write out-of-bounds errors when writing data to
> > > > > > > > the transfer buffer.
> > > > > > > >
> > > > > > > > To prevent out-of-bounds writes to the transfer buffer, a check between
> > > > > > > > the size of the bytes to be written and the size of the allocated bytes
> > > > > > > > should be added before performing the write operation.
> > > > > > > >
> > > > > > > > When the written bytes are too large, -EPIPE is returned instead of
> > > > > > > > -EAGAIN, because returning -EAGAIN might result in push back to ready
> > > > > > > > list again.
> > > > > > > >
> > > > > > > > Based on the context of calculating the bytes to be written here, both
> > > > > > > > copy_to_urb() and copy_to_urb_quirk() require a check for the size of
> > > > > > > > the bytes to be written before execution.
> > > > > > > >
> > > > > > > > syzbot reported:
> > > > > > > > BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > > > > > > Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461
> > > > > > > >
> > > > > > > > Call Trace:
> > > > > > > >  copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > > > > > >  prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
> > > > > > > >
> > > > > > > > Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
> > > > > > > > Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > > > > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > > > > > >
> > > > > > > I'm afraid that this doesn't address the root cause at all.
> > > > > > > The description above sounds plausible, but not pointing to "why".
> > > > > > >
> > > > > > > The bytes is frames * stride, so the question is why a too large
> > > > > > > frames is calculated.  I couldn't have time to check the details, but
> > > > > > > there should be rather some weird condition / parameters to trigger
> > > > > > > this, and we should check that at first.
> > > > > > During debugging, I discovered that the value of ep->packsize[0] is 22,
> > > > > > which causes the counts calculated by
> > > > > > counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
> > > > > > to be 22, resulting in a frames value of 22 * 6 = 132;
> > > > > > Meanwhile, the stride value is 2, which ultimately results in
> > > > > > bytes = frames * stride = 132 * 2 = 264;
> > > > > > @@ -1241,6 +1252,10 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
> > > > > > 	u->buffer_size = maxsize * u->packets;
> > > > > > 	...
> > > > > > 	u->urb->transfer_buffer =
> > > > > >                 usb_alloc_coherent(chip->dev, u->buffer_size,
> > > > > >                                    GFP_KERNEL, &u->urb->transfer_dma);
> > > > > >
> > > > > > Here, when calculating u->buffer_size = maxsize * u->packets;
> > > > > > maxsize = 9, packets = 6, which results in only 54 bytes allocated to
> > > > > > transfer_buffer;
> > > > >
> > > > > Hm, so the problem is rather the calculation of the buffer size.
> > > > > The size sounds extremely small.  Which parameters (rates, formats,
> > > > > etc) are used for achieving this?
> > > > rates: 22050
> > > > format: 2
> > > > channels: 1
> > > > /////////////////////////////
> > > > stride: 2
> > > > packets: 6
> > > > data interval: 0
> > > > frame_bits: 16
> > > > >
> > > > > The calculation of u->buffer_size is a bit complex, as maxsize is
> > > > > adjusted in many different ways.  Is it limited due to wMaxPacketSize
> > > > > setup?
> > > > Yes, it's because the value of ep->maxpacksize is 9 that the maxsize
> > > > value is 9.
> > > 
> > > OK, then a fix like below would work?
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > > --- a/sound/usb/endpoint.c
> > > +++ b/sound/usb/endpoint.c
> > > @@ -1362,6 +1362,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
> > >  	ep->sample_rem = ep->cur_rate % ep->pps;
> > >  	ep->packsize[0] = ep->cur_rate / ep->pps;
> > >  	ep->packsize[1] = (ep->cur_rate + (ep->pps - 1)) / ep->pps;
> > > +	if (ep->packsize[1] > ep->maxpacksize) {
> > > +		usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u / pps %u\n",
> > > +			      ep->maxpacksize, ep->cur_rate, ep->pps);
> > > +		return -EINVAL;
> > > +	}
> > > 
> > >  	/* calculate the frequency in 16.16 format */
> > >  	ep->freqm = ep->freqn;
> > Of course, this fix was added after packsize[0] was assigned a value,
> > and Hillf Danton has already tested it.
> > 
> > However, to be more precise, although both packsize[1] and packsize[0]
> > exceed maxpacksize, this example is about packsize[0], so judging packsize[0]
> > is more rigorous.
> Of course, since packsize[1] is always greater than packsize[0] when pps
> is greater than 1, judging only packsize[1] is sufficient to avoid judging
> packsize[0] and packsize[1].

Right, that's the reason it checks only packsize[1].

I think it's fine to add another check like your patch in addition for
more safety, too.  But then it should better in copy_to_urb() for
both size and offset.  And, it should be with WARN_ON() or such, as
the OOB must not happen after packsize[] sanity check.


thanks,

Takashi

