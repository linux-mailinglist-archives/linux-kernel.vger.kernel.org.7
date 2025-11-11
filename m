Return-Path: <linux-kernel+bounces-895457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B5C4DFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DFB18C5464
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3134253B;
	Tue, 11 Nov 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oboVljkN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dL2i46Zu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HYYj6Uxm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J2EH876+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCA342536
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865310; cv=none; b=h+fGDZjbnMDI6ItYT053dqPcq5UvzukLDbpIXMQ3kzvnpA5W3p0tOR4wO01ykcgVYJmdJeO2HhjxmIw8cE4fmoWHmuLH5EXluOtKqMwtRg00JiMe6rMyBnyaZDknqOlcLitq/BVQ2KyyxNup8Hglr7mgfeLWCdL8bcEZGBfUiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865310; c=relaxed/simple;
	bh=90jukQcn3kjh0EjlcbkERMrxjQTf5a9Sfn3xWaGDZ9E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWe37CFzrh9AR+Om2SpwzM53Hk1Ee02/Axa3L7AzfRmbu7dPTS6FdDW8zKOiXG3W38l8CYwayiI/qVVo1GACeSSjJwcSjgeVHl1iLCBhKq8/eb6p6wwo9A43Ti9wTg4ki+XkxBj0H4x3imMKHFlbXBgewmItdw+2hwMr0SJtfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oboVljkN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dL2i46Zu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HYYj6Uxm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J2EH876+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BECFD1F79E;
	Tue, 11 Nov 2025 12:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762865306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=biLw0F6Wlrc4htiIY2rrlADzPtak4nNx083u8sPssfQ=;
	b=oboVljkN0cS/H9TOtenuac7NFl/WbjfaAEcysBUaSuNfKN6TdFylpCzmOmklUzlwi3hZ4z
	LUkHv32UMytyN0BnAnDbg+GsOTggAA0HIUbPZgKH9/swyyKQJjfMiA1FFVbDXs8Amu38qK
	4RK3n1jeuvyy9QI+eqMNNB8NAiH11Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762865306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=biLw0F6Wlrc4htiIY2rrlADzPtak4nNx083u8sPssfQ=;
	b=dL2i46ZuHqzt0xAbd9h0UYh//oe7XPgvR4HtQ+9K3oHMj79zcLYMjfTf3fjsW2Ctdx7rVT
	T3ZIWfuyUOp2JuBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HYYj6Uxm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J2EH876+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762865305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=biLw0F6Wlrc4htiIY2rrlADzPtak4nNx083u8sPssfQ=;
	b=HYYj6UxmoOej7eyJbfQN+iLraiiVclMS0Dk6MAEmhNxWqeop3fg+DmvTQ4PoMQX2Oewr5W
	ZzLCNBTXLDuijMWOYEVE8rrlqcaLrFrlL/poWd56fCl31EGctSL7GiuJAGf7zKozjJ8F1l
	LaXUdiSsF4t/qD+OTYKgcmIkjAQJVsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762865305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=biLw0F6Wlrc4htiIY2rrlADzPtak4nNx083u8sPssfQ=;
	b=J2EH876+TVWj8LY28TocVXv/sfb3umZl8qoc91xjUlpdKcW63qqvhu+GgiHh2W61kk2j9j
	7MHxn6K2akfzlQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAEFF14973;
	Tue, 11 Nov 2025 12:48:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MxgaKZkwE2noOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 11 Nov 2025 12:48:25 +0000
Date: Tue, 11 Nov 2025 13:48:25 +0100
Message-ID: <874ir03fc6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Haein Lee <lhi0729@kaist.ac.kr>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd
In-Reply-To: <vwh35su1p1d2.vwh35stxlm3p.g6@dooray.com>
References: <vwh35su1p1d2.vwh35stxlm3p.g6@dooray.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: BECFD1F79E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Tue, 11 Nov 2025 13:35:13 +0100,
Haein Lee wrote:
> 
> 
> In snd_usb_create_streams(), for UAC version 3 devices, the Interface
> Association Descriptor (IAD) is retrieved via usb_ifnum_to_if(). If this
> call fails, a fallback routine attempts to obtain the IAD from the next
> interface and sets a BADD profile. However, snd_usb_mixer_controls_badd()
> assumes the IAD retrieved from usb_ifnum_to_if() is always valid without
> performing a NULL check. This can lead to a NULL pointer dereference when
> usb_ifnum_to_if() fails to find the interface descriptor.
> 
> This patch adds a NULL pointer check after calling usb_ifnum_to_if() in
> snd_usb_mixer_controls_badd() to prevent the dereference.

Practically seen, this won't happen because the NULL intf_assoc is
already checked at snd_usb_create_streams() as a fatal error before
reaching this point.  But it would be still safer to have a sanity
check here, too.

In anyway, the patch seems to have a bad format that can't be
applied.  Tabs and spaces seem corrupted by your mailer.

Could you resubmit with a proper format (and add the information I
mentioned in the above)?


thanks,

Takashi

> ---
>  sound/usb/mixer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 6f00e0d52382..72b900505d2c 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -3086,6 +3086,8 @@ static int snd_usb_mixer_controls_badd(struct
> usb_mixer_interface *mixer,
>      int i;
>  
>      assoc = usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
> +    if (!assoc)
> +        return -EINVAL;
>  
>      /* Detect BADD capture/playback channels from AS EP descriptors */
>      for (i = 0; i < assoc->bInterfaceCount; i++) {
> -- 
> 2.34.1
> 
> [mail-r]
> 

