Return-Path: <linux-kernel+bounces-766269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730C3B2447F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22DE167596
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1F02EFD88;
	Wed, 13 Aug 2025 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="puErx3WZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kS+fo+w0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U7im+hNh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="14jvDW+e"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B02ECD3C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074329; cv=none; b=f000w90E/wFz9DQxDQBuQwBBNwijMtTbJizIbIOeXlRdCcFyglF4leU6gUtbzGfppJsEcodo35cqcROuvCf8HC2QXinJc6212FXSC6sFOBMmIAJgJHW/axdE9Z9LkRJtXLGCNICTwxXBB7b+xLxq2P4h7FHP6/wxFBA3MXNchfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074329; c=relaxed/simple;
	bh=844aZHkvxDRAWVuu/Wdd+pTXJlQtzDS/3c/thWOMJwY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA6hhLN6Q7Jn3ek2axuNFpcXjbPUvCs82jei4Qq5AckfBUXhFzIANSTaM76UJOZ8YQWfl45/y4tPT5ONXimTM2NEzVZ3FTU8e4TMi302Pbxpq7bjzVQGD7RaOu6MjX7FXyxzFX+o0dD4TMvQN5JsHeCQEdTj2JTVDnvuQvLCPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=puErx3WZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kS+fo+w0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U7im+hNh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=14jvDW+e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF83A1F74B;
	Wed, 13 Aug 2025 08:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755074326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UCShqX79ChNicLLpMjsUElajc/V/Ezvn5/JnTOEYVA=;
	b=puErx3WZIziaTLbU+A/iHst4YGOsnnmOgHWrclFl7lP8CHTftYhNOcpP1KN59D5B/FeSam
	hslO4bP+g+9N7w+20VjQjh0dAVOL7yGhipsyTvSkr7fJumneIezao4PulUS9CNqcxcUS/Y
	AaBCfl8RVTmZ1gXpbmTUafFpVKsrUfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755074326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UCShqX79ChNicLLpMjsUElajc/V/Ezvn5/JnTOEYVA=;
	b=kS+fo+w0VabBagvF8gIFpRkbRAKMoMzPHCln6uubXRwxkVCAlv36MxCpL4EULs7dr5ow2B
	nZ0p2FnDi5MTUAAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U7im+hNh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=14jvDW+e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755074325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UCShqX79ChNicLLpMjsUElajc/V/Ezvn5/JnTOEYVA=;
	b=U7im+hNhS0aP6rprqCiZuPpzxTzywzW5xBpHmnRKm2QNlSCztZucsXX6J7ACkd8hc0i5J/
	R9UseQf6hZFeRq/8efThGE3rhkNj7eieQqtIKLI3m1h2g13KNu85YNTjthw0llGxBwqmSE
	qBVGKpQT0AV/YCPpZ6FX4TaNLwvxJGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755074325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UCShqX79ChNicLLpMjsUElajc/V/Ezvn5/JnTOEYVA=;
	b=14jvDW+e6ZBmFDdDurNvzmP78I/QXADCvN/TzUgTmUdpIqO01VOpc1P4uGlxxMpkCNBhWG
	4TR7jW9WSbs4tvCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C21B413479;
	Wed, 13 Aug 2025 08:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ha9jLRVPnGj2DAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Aug 2025 08:38:45 +0000
Date: Wed, 13 Aug 2025 10:38:45 +0200
Message-ID: <87jz37y5t6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 3/7] ALSA: usb-audio: us144mkii: Implement audio playback and feedback
In-Reply-To: <20250812132209.83728-4-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
	<20250812132209.83728-1-ramiserifpersia@gmail.com>
	<20250812132209.83728-4-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: EF83A1F74B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Tue, 12 Aug 2025 15:22:05 +0200,
©erif Rami wrote:
> 
> +/**
> + * fpoInitPattern() - Generates a packet distribution pattern.

You forgot to correct the name here :)

> +int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int rate)
> +{
> +	struct usb_device *dev = tascam->dev;
> +

Drop a blank line here.

> +	u8 *rate_payload_buf __free(kfree) = NULL;

So you're using __free(kfree), then...


> +	if (err < 0)
> +		goto fail;
> +
> +	kfree(rate_payload_buf);

You shouldn't use kfree(), otherwise it results in the double-free.

> +	return 0;
> +
> +fail:
> +	dev_err(&dev->dev,
> +		"Device configuration failed at rate %d with error %d\n", rate,
> +		err);
> +	kfree(rate_payload_buf);

Here, too.  Just drop kfree() calls, and that's the advantage of
__free(kfree), after all.

> +void playback_urb_complete(struct urb *urb)
....
> +	{
> +		guard(spinlock_irqsave)(&tascam->lock);

Use scoped_guard() instead.  I think a similar pattern is seen in a
few other places in patches, too.


thanks,

Takashi

