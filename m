Return-Path: <linux-kernel+bounces-768202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E530B25E21
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010AD7B000E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946602E336E;
	Thu, 14 Aug 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aBEysE5O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NnaMvJwf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aBEysE5O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NnaMvJwf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2E26FA46
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158120; cv=none; b=pQ8J49N5LBpTCDZdC2WKB0r4Wbc/7bYSe5wQtKvKIzaXM4eLlo+bu3gwq3tSf9Ih26LzCUOM8l46/KN3CBKev4TH7wbu/2swW/iaY6L3JHGeM0E/kL/LPLVCfKgFuJ24avhTWemPUg+kQLjbWxV4m+VaicicLdwwjw13UASM62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158120; c=relaxed/simple;
	bh=fefpR7HIQVC5nyOFx5Rqw6lX1qR/ixNKElZIWkcATeg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cehYYSd/p+jkPkQK8kOjbvw5sO0xyQg0B/ssyWAtibG3DSjP4lKcZFljwdzS61Y17MI5NIheoCAnTugzYmjjCH6XH+oNiLH9thrF3xIQLS2yz2PggL9M5FQibhMLj9HA9NF+IybPkJOTQJhZzQ1OarheGqcklCN54FDD+zeKVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aBEysE5O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NnaMvJwf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aBEysE5O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NnaMvJwf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EB761F7CD;
	Thu, 14 Aug 2025 07:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755158117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXP3BY0pXsZwFnoczLxeiGYVjQi1ieFC1ZhuiD+4f8Q=;
	b=aBEysE5OkOkLoA6LePzeD+uv9ONyuFzfT/UzKo9e51KgpYOTclGTwZ+TXG3DQYZ821rX3f
	kjgM8Y97u/YzQQJNcPUQ/dTiiwq2T/15umptwd9Pu54hQbnLq3lb9qActEHq4IBRMkYSC8
	/uPm3YYl3JL7f3rOypYxNgd2maKrrJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755158117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXP3BY0pXsZwFnoczLxeiGYVjQi1ieFC1ZhuiD+4f8Q=;
	b=NnaMvJwfSgmTCuUl6N1nWCMmIxrFeuyBZtyRiarKp5sSML3fdDZ0ko31fRA6uJA03llepL
	i0X3fusdbnS0YzBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aBEysE5O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NnaMvJwf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755158117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXP3BY0pXsZwFnoczLxeiGYVjQi1ieFC1ZhuiD+4f8Q=;
	b=aBEysE5OkOkLoA6LePzeD+uv9ONyuFzfT/UzKo9e51KgpYOTclGTwZ+TXG3DQYZ821rX3f
	kjgM8Y97u/YzQQJNcPUQ/dTiiwq2T/15umptwd9Pu54hQbnLq3lb9qActEHq4IBRMkYSC8
	/uPm3YYl3JL7f3rOypYxNgd2maKrrJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755158117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXP3BY0pXsZwFnoczLxeiGYVjQi1ieFC1ZhuiD+4f8Q=;
	b=NnaMvJwfSgmTCuUl6N1nWCMmIxrFeuyBZtyRiarKp5sSML3fdDZ0ko31fRA6uJA03llepL
	i0X3fusdbnS0YzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E70B3136AE;
	Thu, 14 Aug 2025 07:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YHE/NWSWnWh7BgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Aug 2025 07:55:16 +0000
Date: Thu, 14 Aug 2025 09:55:16 +0200
Message-ID: <87o6siuyl7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 2/7] ALSA: usb-audio: us144mkii: Add PCM core infrastructure
In-Reply-To: <20250813131518.18985-3-ramiserifpersia@gmail.com>
References: <20250813131518.18985-1-ramiserifpersia@gmail.com>
	<20250813131518.18985-3-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1EB761F7CD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Wed, 13 Aug 2025 15:15:13 +0200,
©erif Rami wrote:
> 
> +static snd_pcm_uframes_t
> +tascam_capture_pointer(struct snd_pcm_substream *substream)
> +{
> +	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	u64 pos;
> +
> +	if (!atomic_read(&tascam->capture_active))
> +		return 0;
> +
> +	guard(spinlock_irqsave)(&tascam->lock);
> +	pos = tascam->capture_frames_processed;
> +
> +	if (runtime->buffer_size == 0)
> +		return 0;
> +
> +	u64 remainder = do_div(pos, runtime->buffer_size);
> +
> +	return runtime ? remainder : 0;

If runtime is NULL, it already hits Oops, so this NULL check makes
little sense.

Also, the "u64 remainder" declaration should be put at the beginning
of the function (although nowadays allowed in the middle).
But, judging the code, you don't have to assign but just return
do_div().


> +static snd_pcm_uframes_t
> +tascam_playback_pointer(struct snd_pcm_substream *substream)
> +{
> +	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	u64 pos;
> +
> +	if (!atomic_read(&tascam->playback_active))
> +		return 0;
> +
> +	guard(spinlock_irqsave)(&tascam->lock);
> +	pos = tascam->playback_frames_consumed;
> +
> +	if (runtime->buffer_size == 0)
> +		return 0;
> +
> +	u64 remainder = do_div(pos, runtime->buffer_size);
> +
> +	return runtime ? remainder : 0;

Ditto.
	

thanks,

Takashi

