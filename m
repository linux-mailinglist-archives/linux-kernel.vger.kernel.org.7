Return-Path: <linux-kernel+bounces-889047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8431CC3C958
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A443B55AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1A303C85;
	Thu,  6 Nov 2025 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NWFQNtTB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hk+XRX9v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NWFQNtTB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hk+XRX9v"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6A308F25
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447272; cv=none; b=kS/NFuS7BnCtcTTTdwxyE5T1w7sdfx6QeXhIqgVkD3vsnnZxwG7f0TttWQuB9CO7EKmMyHffVyo3SyLjK8Q+X5f217Pfn3ymSN69RAtnfd3GFOY4DyWZHaib7WNNU9eLNovrq7AMvie8laPcnhBZaiSzN6Dk4q/GliHLkaC0nlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447272; c=relaxed/simple;
	bh=bShgRUXmwIigTJi4rYrvdghECfsg69LUPFjEV76bnpg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QS412mqE6mjn/sbPb3vf6cr4lsouB9v8HhoyuQsVFv+wpoYXkz4dvn84t584YqxuHGsBtYF7g0INWQ0UHX4d0bzTR5a/3JXPIslJK3WEpiRwKk3mzmmIiqJ5xoiQwjSySguxc73yEwiKx9j/4fd0VEAXRiD2P3JoE/wl4S+SgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NWFQNtTB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hk+XRX9v; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NWFQNtTB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hk+XRX9v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F53C2118C;
	Thu,  6 Nov 2025 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762447268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezyDHeZJvXEFUvSAJRuRbcS5CcZfuhP+O5ZMX2epjE0=;
	b=NWFQNtTB5ZTr+rlMV3LGfORGmHDL9FpXPsi+AjE7NER/O/B/J4WYeKQ5cK4N6Kw1+N6elB
	v7pYiP8HqYZFt6/P7wy01f2dIudL1gO2zqTiM+1i2nOUVO4hX+THnZAChNFPPtERAIS/3f
	LBLmq8MEdB4DJ95qUCuiM9jEXgyIosM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762447268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezyDHeZJvXEFUvSAJRuRbcS5CcZfuhP+O5ZMX2epjE0=;
	b=Hk+XRX9vm2Xrmv9ErrVak0XjuWcgYd62AkaRAFuKBYL7O6HyuJwc7JM+JPxpGsDa2A2j/f
	54jk5HXMk6U9n9Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762447268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezyDHeZJvXEFUvSAJRuRbcS5CcZfuhP+O5ZMX2epjE0=;
	b=NWFQNtTB5ZTr+rlMV3LGfORGmHDL9FpXPsi+AjE7NER/O/B/J4WYeKQ5cK4N6Kw1+N6elB
	v7pYiP8HqYZFt6/P7wy01f2dIudL1gO2zqTiM+1i2nOUVO4hX+THnZAChNFPPtERAIS/3f
	LBLmq8MEdB4DJ95qUCuiM9jEXgyIosM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762447268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezyDHeZJvXEFUvSAJRuRbcS5CcZfuhP+O5ZMX2epjE0=;
	b=Hk+XRX9vm2Xrmv9ErrVak0XjuWcgYd62AkaRAFuKBYL7O6HyuJwc7JM+JPxpGsDa2A2j/f
	54jk5HXMk6U9n9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 458F813A31;
	Thu,  6 Nov 2025 16:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hN+0D6TPDGnPSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 16:41:08 +0000
Date: Thu, 06 Nov 2025 17:41:07 +0100
Message-ID: <87h5v7ru58.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <tiwai@suse.de>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<perex@perex.cz>,
	<syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>,
	<tiwai@suse.com>
Subject: Re: [PATCH] ALSA: usb-audio: Prevent urb from writing out of bounds
In-Reply-To: <20251106143506.720545-1-lizhi.xu@windriver.com>
References: <87v7jnfkio.wl-tiwai@suse.de>
	<20251106143506.720545-1-lizhi.xu@windriver.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[bfd77469c8966de076f7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Thu, 06 Nov 2025 15:35:06 +0100,
Lizhi Xu wrote:
> 
> On Thu, 06 Nov 2025 12:49:51 +0100, Takashi Iwai wrote:
> > > > > The calculation rule for the actual data length written to the URB's
> > > > > transfer buffer differs from that used to allocate the URB's transfer
> > > > > buffer, and in this problem, the value used during allocation is smaller.
> > > > >
> > > > > This ultimately leads to write out-of-bounds errors when writing data to
> > > > > the transfer buffer.
> > > > >
> > > > > To prevent out-of-bounds writes to the transfer buffer, a check between
> > > > > the size of the bytes to be written and the size of the allocated bytes
> > > > > should be added before performing the write operation.
> > > > >
> > > > > When the written bytes are too large, -EPIPE is returned instead of
> > > > > -EAGAIN, because returning -EAGAIN might result in push back to ready
> > > > > list again.
> > > > >
> > > > > Based on the context of calculating the bytes to be written here, both
> > > > > copy_to_urb() and copy_to_urb_quirk() require a check for the size of
> > > > > the bytes to be written before execution.
> > > > >
> > > > > syzbot reported:
> > > > > BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > > > Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461
> > > > >
> > > > > Call Trace:
> > > > >  copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > > >  prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
> > > > >
> > > > > Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
> > > > > Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > > >
> > > > I'm afraid that this doesn't address the root cause at all.
> > > > The description above sounds plausible, but not pointing to "why".
> > > >
> > > > The bytes is frames * stride, so the question is why a too large
> > > > frames is calculated.  I couldn't have time to check the details, but
> > > > there should be rather some weird condition / parameters to trigger
> > > > this, and we should check that at first.
> > > During debugging, I discovered that the value of ep->packsize[0] is 22,
> > > which causes the counts calculated by
> > > counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
> > > to be 22, resulting in a frames value of 22 * 6 = 132;
> > > Meanwhile, the stride value is 2, which ultimately results in
> > > bytes = frames * stride = 132 * 2 = 264;
> > > @@ -1241,6 +1252,10 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
> > > 	u->buffer_size = maxsize * u->packets;
> > > 	...
> > > 	u->urb->transfer_buffer =
> > >                 usb_alloc_coherent(chip->dev, u->buffer_size,
> > >                                    GFP_KERNEL, &u->urb->transfer_dma);
> > >
> > > Here, when calculating u->buffer_size = maxsize * u->packets;
> > > maxsize = 9, packets = 6, which results in only 54 bytes allocated to
> > > transfer_buffer;
> > 
> > Hm, so the problem is rather the calculation of the buffer size.
> > The size sounds extremely small.  Which parameters (rates, formats,
> > etc) are used for achieving this?
> rates: 22050
> format: 2
> channels: 1
> /////////////////////////////
> stride: 2
> packets: 6
> data interval: 0
> frame_bits: 16
> > 
> > The calculation of u->buffer_size is a bit complex, as maxsize is
> > adjusted in many different ways.  Is it limited due to wMaxPacketSize
> > setup?
> Yes, it's because the value of ep->maxpacksize is 9 that the maxsize
> value is 9.

OK, then a fix like below would work?


thanks,

Takashi

--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1362,6 +1362,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	ep->sample_rem = ep->cur_rate % ep->pps;
 	ep->packsize[0] = ep->cur_rate / ep->pps;
 	ep->packsize[1] = (ep->cur_rate + (ep->pps - 1)) / ep->pps;
+	if (ep->packsize[1] > ep->maxpacksize) {
+		usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u / pps %u\n",
+			      ep->maxpacksize, ep->cur_rate, ep->pps);
+		return -EINVAL;
+	}
 
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;

