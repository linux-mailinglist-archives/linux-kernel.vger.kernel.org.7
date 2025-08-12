Return-Path: <linux-kernel+bounces-764146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4041EB21E99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CF36206AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169B2475C8;
	Tue, 12 Aug 2025 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="COr5Q049";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TNUql2R3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="COr5Q049";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TNUql2R3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CA21D3F5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981337; cv=none; b=hwtXaGATSDhsqnPfWdXXESkppARAtjh3CLQEMBHlCyOqE9MIlik3QigsKu+krATV7VtP+DJt8PoESWPgaLfLFqnMdqJ/a0giy4wuSCYBmx/8FeKHHLoJ7ZlBxVFT5BgMhHUR66ajKDXznKfCo++o+dRX5qExisoMm0qjIRxCGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981337; c=relaxed/simple;
	bh=QV51PAAZiiy8yMEWPLPGWvSqHqWPbLdXOHYKp939S0c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4d3q7QuKsyxCLyktlBcHCdGX9Je1lSWotxStatyqqNmEAnde8XqJDnk6/f1rTTU5U2Y8mJb3UvJitGx27wjCsGvwegUvw0i6+uwMPE9fDx50o+jCq57oSeuKmm4vXSAPbZpDwgIhblSwC2VbR1aaVnGjoVFLFV1/3D+tFP+QpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=COr5Q049; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TNUql2R3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=COr5Q049; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TNUql2R3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 948C121170;
	Tue, 12 Aug 2025 06:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754981333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fmzm+jXCiCsLVw7nuGXgeBX/GB9YrIukEbwxuJ5aod4=;
	b=COr5Q049szG7EiSLxfrcFl0KjUDLQxGsXSQtRk+nYStDRHZoE8qKNwR6peNmXqDXfMsAPv
	y6KoOlWQ/ZyEC6WpYRlJ3bB6ynItItPGACK6KTTPdXgcxMFCFSymc1RqcO7yt+wqqgVh4o
	DyxW+2GtvX7yVRKztNSyc+0hRZ1eoeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754981333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fmzm+jXCiCsLVw7nuGXgeBX/GB9YrIukEbwxuJ5aod4=;
	b=TNUql2R3fdHexssq4ifokATRQI039sGVsWb0R4i7P8Gw4xwJrYF857jsc+F4WlhHz34syu
	YfIDHWrgASH8PDBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=COr5Q049;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TNUql2R3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754981333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fmzm+jXCiCsLVw7nuGXgeBX/GB9YrIukEbwxuJ5aod4=;
	b=COr5Q049szG7EiSLxfrcFl0KjUDLQxGsXSQtRk+nYStDRHZoE8qKNwR6peNmXqDXfMsAPv
	y6KoOlWQ/ZyEC6WpYRlJ3bB6ynItItPGACK6KTTPdXgcxMFCFSymc1RqcO7yt+wqqgVh4o
	DyxW+2GtvX7yVRKztNSyc+0hRZ1eoeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754981333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fmzm+jXCiCsLVw7nuGXgeBX/GB9YrIukEbwxuJ5aod4=;
	b=TNUql2R3fdHexssq4ifokATRQI039sGVsWb0R4i7P8Gw4xwJrYF857jsc+F4WlhHz34syu
	YfIDHWrgASH8PDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B59C1351A;
	Tue, 12 Aug 2025 06:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2oa/F9XjmmjtSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 12 Aug 2025 06:48:53 +0000
Date: Tue, 12 Aug 2025 08:48:52 +0200
Message-ID: <87sehxyqzv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] ALSA: usb-audio: us144mkii: Implement audio playback and feedback
In-Reply-To: <20250810124958.25309-4-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
	<20250810124958.25309-4-ramiserifpersia@gmail.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 948C121170
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Sun, 10 Aug 2025 14:49:54 +0200,
©erif Rami wrote:
> 
> +/**
> + * fpoInitPattern() - Generates a packet distribution pattern.
> + * @size: The number of elements in the pattern array (e.g., 8).
> + * @pattern_array: Pointer to the array to be populated.
> + * @initial_value: The base value to initialize each element with.
> + * @target_sum: The desired sum of all elements in the final array.
> + *
> + * This function initializes an array with a base value and then iteratively
> + * adjusts the elements to match a target sum, distributing the difference
> + * as evenly as possible.
> + */
> +static void fpoInitPattern(unsigned int size, unsigned int *pattern_array,
> +			   unsigned int initial_value, int target_sum)

Any need for camel case only for this?

> +int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int rate)
> +{
> +	struct usb_device *dev = tascam->dev;
> +	u8 *rate_payload_buf;
> +	u16 rate_vendor_wValue;
> +	int err = 0;
> +	const u8 *current_payload_src;

Use __free(kfree) for temporary allocation/free for this function.

> @@ -36,29 +209,82 @@ int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  {
>  	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
>  	int err = 0;
> +	int i;
> +	bool do_start = false;
> +	bool do_stop = false;
>  
> -	guard(spinlock_irqsave)(&tascam->lock);
> -	switch (cmd) {
> -	case SNDRV_PCM_TRIGGER_START:
> -	case SNDRV_PCM_TRIGGER_RESUME:
> -		if (!atomic_read(&tascam->playback_active)) {
> -			atomic_set(&tascam->playback_active, 1);
> -			atomic_set(&tascam->capture_active, 1);
> +	{
> +		guard(spinlock_irqsave)(&tascam->lock);

You can use scoped_guard() instead, e.g.

	scoped_guard(spinlock_irqsave, &tascam->lock) {
		switch (cmd) {
		.....
		}
	}


thanks,

Takashi

