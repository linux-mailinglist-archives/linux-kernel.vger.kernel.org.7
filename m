Return-Path: <linux-kernel+bounces-764153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E26B21EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6D77AA265
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089962BCF47;
	Tue, 12 Aug 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RMrkyik1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/PquIW72";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RMrkyik1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/PquIW72"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70123C2C9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981948; cv=none; b=ea2N1ba3z3gD1hlBxAeYDmTsTPWfWlYhCZIwuN74T0HVarH5lJtRSqd5izPz9aWeiGcpJZuG0DT6ol3XrhkjPTpY7eiFiAvE5KxwLaUnNGOtl8qwvDkP2dqJ4F87BNg9PIkEIZrRNB42pxFD8mpNCC2TpwNI8YPK9Hiu2qexRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981948; c=relaxed/simple;
	bh=TLq5M/mc6fxqOeoLjp+2eQHZWF4OBZSaQQWvLUxNxSs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITSjbBNi8xklIRUtLwXbL3JnJeXB6lHIagqLvw+/1ozLvcT9G6kZDR9v05XjinPiZ8a7E7etWy2c54vnEmbEehT5jKSYaiK3oeer2cO3NFb+Gvj4utUl85AnrAkSPQLWCW8Loa5jpMRrHowsOjyo9Wk5+HpGvkxIzRF/0gwzROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RMrkyik1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/PquIW72; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RMrkyik1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/PquIW72; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8663A2174F;
	Tue, 12 Aug 2025 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754981944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZhpgNEEjBSLHO+jCd6inXzbaJT2Rb8vaB59NJtE9XA=;
	b=RMrkyik1HIVZkdMcvpuw3oBPW4SUHbNB0lvP/ANnMnxLZSZcUSdddBMaqukfm5ksbO3eTa
	kCy5xRgKPauLSYcxVQ4bx41tfG6dOWrjXswUtHBJ0qYEDUCCGUdlS6tgmjptq5Xl6Cucm0
	GDAyYeJ0Gr7P3qT2bVBlN7hX0leUALQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754981944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZhpgNEEjBSLHO+jCd6inXzbaJT2Rb8vaB59NJtE9XA=;
	b=/PquIW72ma7MbE9eTcJEVretlH8RtNHX1gjAUuRmslCGlOD/faK7/OEVZb4N3ggAyXKl82
	4LwnwSo7mUk6DmCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RMrkyik1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/PquIW72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754981944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZhpgNEEjBSLHO+jCd6inXzbaJT2Rb8vaB59NJtE9XA=;
	b=RMrkyik1HIVZkdMcvpuw3oBPW4SUHbNB0lvP/ANnMnxLZSZcUSdddBMaqukfm5ksbO3eTa
	kCy5xRgKPauLSYcxVQ4bx41tfG6dOWrjXswUtHBJ0qYEDUCCGUdlS6tgmjptq5Xl6Cucm0
	GDAyYeJ0Gr7P3qT2bVBlN7hX0leUALQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754981944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZhpgNEEjBSLHO+jCd6inXzbaJT2Rb8vaB59NJtE9XA=;
	b=/PquIW72ma7MbE9eTcJEVretlH8RtNHX1gjAUuRmslCGlOD/faK7/OEVZb4N3ggAyXKl82
	4LwnwSo7mUk6DmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 542DC1351A;
	Tue, 12 Aug 2025 06:59:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UqT7Ejjmmmh2TgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 12 Aug 2025 06:59:04 +0000
Date: Tue, 12 Aug 2025 08:59:03 +0200
Message-ID: <87qzxhyqiw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] ALSA: usb-audio: us144mkii: Add MIDI support and mixer controls
In-Reply-To: <20250810124958.25309-6-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
	<20250810124958.25309-6-ramiserifpersia@gmail.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8663A2174F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Sun, 10 Aug 2025 14:49:56 +0200,
©erif Rami wrote:
> +/**
> + * @brief Text descriptions for playback output source options.
> + *
> + * Used by ALSA kcontrol elements to provide user-friendly names for
> + * the playback routing options (e.g., "Playback 1-2", "Playback 3-4").
> + */
> +static const char *const playback_source_texts[] = { "Playback 1-2",
> +						     "Playback 3-4" };
> +
> +/**
> + * @brief Text descriptions for capture input source options.
> + *
> + * Used by ALSA kcontrol elements to provide user-friendly names for
> + * the capture routing options (e.g., "Analog In", "Digital In").
> + */
> +static const char *const capture_source_texts[] = { "Analog In", "Digital In" };
> +
> +/**
> + * tascam_playback_source_info() - ALSA control info callback for playback
> + * source.
> + * @kcontrol: The ALSA kcontrol instance.
> + * @uinfo: The ALSA control element info structure to fill.
> + *
> + * This function provides information about the enumerated playback source
> + * control, including its type, count, and available items (Playback 1-2,
> + * Playback 3-4).
> + *
> + * Return: 0 on success.
> + */
> +static int tascam_playback_source_info(struct snd_kcontrol *kcontrol,
> +				       struct snd_ctl_elem_info *uinfo)
> +{
> +	return snd_ctl_enum_info(uinfo, 1, 2, playback_source_texts);
> +}
> +
> +/**
> + * tascam_line_out_get() - ALSA control get callback for Line Outputs Source.
> + * @kcontrol: The ALSA kcontrol instance.
> + * @ucontrol: The ALSA control element value structure to fill.
> + *
> + * This function retrieves the current selection for the Line Outputs source
> + * (Playback 1-2 or Playback 3-4) from the driver's private data and populates
> + * the ALSA control element value.
> + *
> + * Return: 0 on success.
> + */
> +static int tascam_line_out_get(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
> +
> +	ucontrol->value.enumerated.item[0] = tascam->line_out_source;
> +	return 0;
> +}
> +
> +/**
> + * tascam_line_out_put() - ALSA control put callback for Line Outputs Source.
> + * @kcontrol: The ALSA kcontrol instance.
> + * @ucontrol: The ALSA control element value structure containing the new value.
> + *
> + * This function sets the Line Outputs source (Playback 1-2 or Playback 3-4)
> + * based on the user's selection from the ALSA control element. It validates
> + * the input and updates the driver's private data.
> + *
> + * Return: 1 if the value was changed, 0 if unchanged, or a negative error code.
> + */
> +static int tascam_line_out_put(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
> +
> +	if (ucontrol->value.enumerated.item[0] > 1)
> +		return -EINVAL;
> +	if (tascam->line_out_source == ucontrol->value.enumerated.item[0])
> +		return 0;
> +	tascam->line_out_source = ucontrol->value.enumerated.item[0];
> +	return 1;
> +}
> +
> +/**
> + * tascam_line_out_control - ALSA kcontrol definition for Line Outputs Source.
> + *
> + * This defines a new ALSA mixer control named "Line OUTPUTS Source" that allows
> + * the user to select between "Playback 1-2" and "Playback 3-4" for the analog
> + * line outputs of the device. It uses the `tascam_playback_source_info` for
> + * information and `tascam_line_out_get`/`tascam_line_out_put` for value
> + * handling.
> + */
> +static const struct snd_kcontrol_new tascam_line_out_control = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name = "Line OUTPUTS Source",

The control name is always a difficult question.
For following the standards, it'd be better to be a name like
"Line Playback Source" (i.e. prefix + direction + suffix where
direction is either "Playback" or "Capture").

> +static const struct snd_kcontrol_new tascam_digital_out_control = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name = "Digital OUTPUTS Source",

Ditto.

> +static const struct snd_kcontrol_new tascam_capture_12_control = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name = "ch1 and ch2 Source",

This should be "... Capture Source", then, and what comes at the
prefix is another difficult question.  I find better to have capital
letters, or combine like "Ch1/2 Capture Source".

> +static const struct snd_kcontrol_new tascam_capture_34_control = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name = "ch3 and ch4 Source",

Ditto.

> +static int tascam_samplerate_get(struct snd_kcontrol *kcontrol,
> +				 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct tascam_card *tascam =
> +		(struct tascam_card *)snd_kcontrol_chip(kcontrol);
> +	u8 *buf __free(kfree);

Don't forget NULL initialization.


thanks,

Takashi

