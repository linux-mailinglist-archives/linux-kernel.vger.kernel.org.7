Return-Path: <linux-kernel+bounces-888397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233FAC3AB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7081F464A5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E6313E2A;
	Thu,  6 Nov 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1mfB4Pch";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="al70Odhe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gvV5Y9vK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Adds/Bqu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E67315790
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429797; cv=none; b=FgOtpLBgYgjsC3IPSCRwDmdi6wb+BG+Y1yDwERku7GTwRXKlrevQGoRmj/lRbJzT9DmK3BKwXTc2x+KhUdUMUusrOdckJfm6X5jO9h6kbRdwS/ZDvCRHvk3QytrmkDzAsrgoz/snNieZSBmEKRmwvvh6sm3ow7xoU6KteNp5qMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429797; c=relaxed/simple;
	bh=5U0Dsfy6+dGrTQIai6+GvxJqcEgXBlOWqZ+UcpPi2OQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=us/vDJUYxdAYJfV5o95WJu2fuH7Rwl9na+pZutWpw9/TYyQAN+O4xWb1x/e2GxbZZZsW5sMFubnunA7januDFRaIk4Bz07utfWJp91jEnBeha+bQ8woZb1DgxArpq/ETESsN9/C1COuBWXx8IsRKwdrfdG5r4TQbMes4Bk9mXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1mfB4Pch; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=al70Odhe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gvV5Y9vK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Adds/Bqu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7252E211D3;
	Thu,  6 Nov 2025 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762429793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPRWc41BFF5QTMOp0qqUH5UPi5ucu5QPRL9AR420E2Q=;
	b=1mfB4PchN3vSmTWmT5qvE6bLQsBX5GVZvQRVrbU94R/f1l7U6zh3IOQ7QDeg4LWlDQy7e7
	6Jlgzm/VpZ9OSabcWb5jYAYzvl1zr3orf304ZIK48ZRNuQFymwUblxYcn/hlbNKRzBIOVX
	NVO0x/pTlvbWqFKx4DHCUppqF4hUcRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762429793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPRWc41BFF5QTMOp0qqUH5UPi5ucu5QPRL9AR420E2Q=;
	b=al70OdheNAzgV7agJkhwyKMgEfPWscsxHg82tBYkkH6ZfAmPL1BVSSMbaVGuScBuCeII36
	/7gflFMwzTzL0NCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gvV5Y9vK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Adds/Bqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762429792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPRWc41BFF5QTMOp0qqUH5UPi5ucu5QPRL9AR420E2Q=;
	b=gvV5Y9vKqE9pO+yL2tjq86tFg7juLBV6VLUvMK3Krc/zqrAoYtnMQpVGWgKZ3DDmePvO7C
	vpcr7rQn9GoV2flwbmJUS9LXAoNhFzfufghhttEpiB9f63LBYE+evGhRgQZiUf5kH9nOBN
	B8evEwPV6rjfBVwS0gfA+kQOn3mzwtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762429792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPRWc41BFF5QTMOp0qqUH5UPi5ucu5QPRL9AR420E2Q=;
	b=Adds/BquqWQderonQZBHFIt8ps/2Klr43hvsll/PzKS/czcrPtmsJTS/WgyqASstjoqhzY
	8HNEHQAQS79rzXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3009D139A9;
	Thu,  6 Nov 2025 11:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ZB2CmCLDGldJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 11:49:52 +0000
Date: Thu, 06 Nov 2025 12:49:51 +0100
Message-ID: <87v7jnfkio.wl-tiwai@suse.de>
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
In-Reply-To: <20251106113121.4064298-1-lizhi.xu@windriver.com>
References: <87a50zh42n.wl-tiwai@suse.de>
	<20251106113121.4064298-1-lizhi.xu@windriver.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 7252E211D3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[bfd77469c8966de076f7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,syzkaller.appspot.com:url,windriver.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,appspotmail.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 

On Thu, 06 Nov 2025 12:31:21 +0100,
Lizhi Xu wrote:
> 
> On Thu, 06 Nov 2025 11:02:08 +0100, Takashi Iwai wrote:
> > > The calculation rule for the actual data length written to the URB's
> > > transfer buffer differs from that used to allocate the URB's transfer
> > > buffer, and in this problem, the value used during allocation is smaller.
> > > 
> > > This ultimately leads to write out-of-bounds errors when writing data to
> > > the transfer buffer.
> > > 
> > > To prevent out-of-bounds writes to the transfer buffer, a check between
> > > the size of the bytes to be written and the size of the allocated bytes
> > > should be added before performing the write operation.
> > > 
> > > When the written bytes are too large, -EPIPE is returned instead of
> > > -EAGAIN, because returning -EAGAIN might result in push back to ready
> > > list again.
> > > 
> > > Based on the context of calculating the bytes to be written here, both
> > > copy_to_urb() and copy_to_urb_quirk() require a check for the size of
> > > the bytes to be written before execution.
> > > 
> > > syzbot reported:
> > > BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461
> > > 
> > > Call Trace:
> > >  copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > >  prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
> > > 
> > > Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
> > > Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > 
> > I'm afraid that this doesn't address the root cause at all.
> > The description above sounds plausible, but not pointing to "why".
> > 
> > The bytes is frames * stride, so the question is why a too large
> > frames is calculated.  I couldn't have time to check the details, but
> > there should be rather some weird condition / parameters to trigger
> > this, and we should check that at first.
> During debugging, I discovered that the value of ep->packsize[0] is 22,
> which causes the counts calculated by 
> counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
> to be 22, resulting in a frames value of 22 * 6 = 132; 
> Meanwhile, the stride value is 2, which ultimately results in 
> bytes = frames * stride = 132 * 2 = 264;
> @@ -1241,6 +1252,10 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
> 	u->buffer_size = maxsize * u->packets;
> 	...
> 	u->urb->transfer_buffer =
>                 usb_alloc_coherent(chip->dev, u->buffer_size,
>                                    GFP_KERNEL, &u->urb->transfer_dma);
> 
> Here, when calculating u->buffer_size = maxsize * u->packets;
> maxsize = 9, packets = 6, which results in only 54 bytes allocated to
> transfer_buffer;

Hm, so the problem is rather the calculation of the buffer size.
The size sounds extremely small.  Which parameters (rates, formats,
etc) are used for achieving this?

The calculation of u->buffer_size is a bit complex, as maxsize is
adjusted in many different ways.  Is it limited due to wMaxPacketSize
setup?


thanks,

Takashi

