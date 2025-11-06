Return-Path: <linux-kernel+bounces-888179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64921C3A1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52FFD502DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA95313524;
	Thu,  6 Nov 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2WoqG/Ps";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r1ZJn/Ke";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G5PSDi1/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VDj28k4H"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26130F7EE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423345; cv=none; b=ABhUdgMNGwiIFe/BzgvclJug1IUwx10tBu5SmSY2GhDPX1nSWrPqKiUazAKYjpmt7im+EQHz+876a1CBv/R5BDnsv09bTZTw8lPeWBb035T/PLXjXuUYZDnNdPMZipy7SWvUSdq0nDof/vaaDrsJvVIvAF97Rof+IeBtS2n1HNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423345; c=relaxed/simple;
	bh=9ZQn3Mz4Bsl3vtRlfOjP7aq3hwjqIkhB3KLkp3lT3Mw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPqre4D31oGAjENio6Uq7u370MV9CxvmZGy0AsrBzve6H2DJJqGEevL/U48Ob1NtuGY9NQFqT6W714ipI9yTr77ZMMJlbqmSr0CnZiWPFeFYS8RKrxnA7XacPzLa9waepFxAOMOcsqs8JDqCZPQ+rRHCX/vqo1oFhE99zSHYFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2WoqG/Ps; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r1ZJn/Ke; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G5PSDi1/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VDj28k4H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E0721F393;
	Thu,  6 Nov 2025 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VM/DHgU+8v7UtiujNpPprWigWOD/5K0rxkxM+oWHKL4=;
	b=2WoqG/PsYCk865209nFd+hKy51PC+wQsT6gImARcj0qVYxX6Lx1YRHNZM8jcer6bdh/uoq
	smcm8F6FSCxhjXwbgpi6NIO+/sBldw2ugFjDZJR2diecCEHkXlX59rqYQLZtuP48hkmvO5
	mGU3c8cZNyMgrrnoi9LFhPzPZ5FAt+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VM/DHgU+8v7UtiujNpPprWigWOD/5K0rxkxM+oWHKL4=;
	b=r1ZJn/KeWdvrIyfwd4piQcVKCREkU2XwKUhErWlPzWfNYX2Z74FeaMMl+Kebr9UXB4WLPr
	LsIMTRSAq5/qHhCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="G5PSDi1/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VDj28k4H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VM/DHgU+8v7UtiujNpPprWigWOD/5K0rxkxM+oWHKL4=;
	b=G5PSDi1/Z6f9Czj5XhFbXN0IZuwA+t1BSNULzV7p1bOT/L/DNRqu4i5xjWZ5yVBqLNlyxs
	i6vrczMUp0/2p0oSct53zyckF86xHcWjGtNEeS0YuVrXn5v7oFJC8M3ngzYNQtGmDyHjxV
	8HV2z6KGCahtl6y1LArENGsNPLI/cC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VM/DHgU+8v7UtiujNpPprWigWOD/5K0rxkxM+oWHKL4=;
	b=VDj28k4HeexNGzUQfWZzecA3YYgqikHX2pGR56wHlbvddd28DWQNXXKNnMkrVgAaOVnDwH
	BA0IMeN8dYO86hAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 329D913A31;
	Thu,  6 Nov 2025 10:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +V3hCiFyDGl2NwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 10:02:09 +0000
Date: Thu, 06 Nov 2025 11:02:08 +0100
Message-ID: <87a50zh42n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<perex@perex.cz>,
	<syzkaller-bugs@googlegroups.com>,
	<tiwai@suse.com>
Subject: Re: [PATCH] ALSA: usb-audio: Prevent urb from writing out of bounds
In-Reply-To: <20251106083300.2947700-1-lizhi.xu@windriver.com>
References: <690b6b46.050a0220.3d0d33.0054.GAE@google.com>
	<20251106083300.2947700-1-lizhi.xu@windriver.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6E0721F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[bfd77469c8966de076f7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -2.01

On Thu, 06 Nov 2025 09:33:00 +0100,
Lizhi Xu wrote:
> 
> The calculation rule for the actual data length written to the URB's
> transfer buffer differs from that used to allocate the URB's transfer
> buffer, and in this problem, the value used during allocation is smaller.
> 
> This ultimately leads to write out-of-bounds errors when writing data to
> the transfer buffer.
> 
> To prevent out-of-bounds writes to the transfer buffer, a check between
> the size of the bytes to be written and the size of the allocated bytes
> should be added before performing the write operation.
> 
> When the written bytes are too large, -EPIPE is returned instead of
> -EAGAIN, because returning -EAGAIN might result in push back to ready
> list again.
> 
> Based on the context of calculating the bytes to be written here, both
> copy_to_urb() and copy_to_urb_quirk() require a check for the size of
> the bytes to be written before execution.
> 
> syzbot reported:
> BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461
> 
> Call Trace:
>  copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
>  prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
> 
> Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
> Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

I'm afraid that this doesn't address the root cause at all.
The description above sounds plausible, but not pointing to "why".

The bytes is frames * stride, so the question is why a too large
frames is calculated.  I couldn't have time to check the details, but
there should be rather some weird condition / parameters to trigger
this, and we should check that at first.


thanks,

Takashi


> ---
>  sound/usb/pcm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 54d01dfd820f..a4c0ea685b8a 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -1606,6 +1606,9 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
>  				    subs->cur_audiofmt->dsd_bitrev)) {
>  			fill_playback_urb_dsd_bitrev(subs, urb, bytes);
>  		} else {
> +			if (bytes > ctx->buffer_size)
> +				return -EPIPE;
> +
>  			/* usual PCM */
>  			if (!subs->tx_length_quirk)
>  				copy_to_urb(subs, urb, 0, stride, bytes);
> -- 
> 2.43.0
> 

