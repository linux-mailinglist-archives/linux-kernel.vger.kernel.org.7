Return-Path: <linux-kernel+bounces-824520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61388B89754
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0727B1C84949
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E401DE2BF;
	Fri, 19 Sep 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lsUsd2UU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dRt2gYJd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lsUsd2UU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dRt2gYJd"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2F19AD89
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285135; cv=none; b=dIvvgs0VvCeKFPjta4+pliCvD1EY5qZqzgIEtsZPZt0wYA2+aYPdWEGPFlttvroGSRO5jdYMvXM0fUHh0L3ooV2F9prLZn44gmQ7TvysfM1J6wtYK8v6uIYdBFFkdJwf1K4Bg0r/ACyPQ9U1fU341NimvF4Qqwmi5PYXshTdvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285135; c=relaxed/simple;
	bh=rMjNbJA7qcOh5OJv8unaVyReVLTcdwUg64bV87PakBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NU1VYrvAprOQMH7gbaE3cYHIFc+c4nBiWX3CRjm79bxKOMfCPrwKFSVxM7o2q1FrDEWKfpHTmi1pL+Vrc+mYRBFWmBWooJ1pIpJ0DsSW8OvlFKqHufI8jxnZ3I5rKaL/JBCwaldQnNedz+G/yRVkVuuhrMgNwZKmr63sjUv6nLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lsUsd2UU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dRt2gYJd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lsUsd2UU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dRt2gYJd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07F1221D67;
	Fri, 19 Sep 2025 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758285131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ecT/d/iO9MHp5q4RbD25dFeGzBgJBi4NJtZOVh5yM=;
	b=lsUsd2UUCCDUjvNnFXxh7NBYeBi9j6LKswtKMsv9hjSokiEL9vBrTGDV2dzvgBjqgYZw7a
	hCyOv9Re9hOKoFjuQxkLklbkt6NmVViGvlYUcVM+YrJItIRVvBHK1UZUljgfN+isS/i9W4
	WJ7fOQARqVPYer+tm/JBKcIfka9Jwpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758285131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ecT/d/iO9MHp5q4RbD25dFeGzBgJBi4NJtZOVh5yM=;
	b=dRt2gYJdwCpG9JhWwasqlkSdH46dFEiATF5NEypIU94bl3KzFUBcHogR+w0gpD8UvkDXEN
	k8xaqD9nVuhDyjAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758285131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ecT/d/iO9MHp5q4RbD25dFeGzBgJBi4NJtZOVh5yM=;
	b=lsUsd2UUCCDUjvNnFXxh7NBYeBi9j6LKswtKMsv9hjSokiEL9vBrTGDV2dzvgBjqgYZw7a
	hCyOv9Re9hOKoFjuQxkLklbkt6NmVViGvlYUcVM+YrJItIRVvBHK1UZUljgfN+isS/i9W4
	WJ7fOQARqVPYer+tm/JBKcIfka9Jwpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758285131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ecT/d/iO9MHp5q4RbD25dFeGzBgJBi4NJtZOVh5yM=;
	b=dRt2gYJdwCpG9JhWwasqlkSdH46dFEiATF5NEypIU94bl3KzFUBcHogR+w0gpD8UvkDXEN
	k8xaqD9nVuhDyjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E09213A39;
	Fri, 19 Sep 2025 12:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lyc7HUpNzWhFfAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 12:32:10 +0000
Date: Fri, 19 Sep 2025 14:32:10 +0200
Message-ID: <87tt0y8vxx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	qaqland <anguoli@uniontech.com>,
	kernel@uniontech.com,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v4 1/5] ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
In-Reply-To: <20250918-sound-v4-1-82cf8123d61c@uniontech.com>
References: <20250918-sound-v4-0-82cf8123d61c@uniontech.com>
	<20250918-sound-v4-1-82cf8123d61c@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Thu, 18 Sep 2025 11:24:30 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -2446,6 +2446,62 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
>  	{} /* terminator */
>  };
>  
> +static const char *const snd_usb_audio_quirk_flag_names[] = {
> +	"get_sample_rate",
> +	"share_media_device",

I think it's worth to add a comment that this each entry corresponds
to QUIRK_FLAG_XXX.  Or another idea would be to define enums like:

enum {
	QUIRK_TYPE_GET_SAMPLE_RATE,
	QUIRK_TYPE_SHARE_MEDIA_DEVICE,
	....
};

then redefine QUIRK_FLAG_* like:

#define QUIRK_FLAG_GET_SAMPLE_RATE	BIT_U32(QUIRK_TYPE_GET_SAMPLE_RATE)
#define QUIRK_FLAG_SHARE_MEDIA_DEVICE	BIT_U32(QUIRK_TYPE_SHARE_MEDIA_DEVICE)
....
 
or

#define QUIRK_FLAG(x)	BIT_U32(QUIRK_TYPE_ ## x)

and use like QUIRK_FLAG(GET_SAMPLE_RATE).

With those changes, the above can be defined more safely like

static const char *const snd_usb_audio_quirk_flag_names[] = {
	[QUIRK_TYPE_GET_SAMPLE_RATE] = "get_sample_rate",
	....

or even more drastically by defining some macro for each entry like:

#define QUIRK_STRING_ENTRY(x) \
	[QUIRK_TYPE_ ## x] = __stringify(x)

and put like:

static const char *const snd_usb_audio_quirk_flag_names[] = {
	QUIRK_STRING_ENTRY(GET_SAMPLE_RATE),
	....
};

In this case, it'll become upper letters, so the parse would need to
deal with the case-insensitive comparison, though.

> +u32 snd_usb_quirk_flags_from_name(char *name)

Use const char *.

> +{
> +	u32 flag = 0;
> +	u32 i;

The iterator can be simple int.

> +	if (!name || !*name)
> +		return 0;
> +
> +	for (i = 0; snd_usb_audio_quirk_flag_names[i]; i++) {
> +		if (strcmp(name, snd_usb_audio_quirk_flag_names[i]) == 0) {
> +			flag = (1U << i);

Use BIT_U32(i)

> +			break;

We can return the value directly, so flag variable can be dropped.

>  void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
>  {
>  	const struct usb_audio_quirk_flags_table *p;
> @@ -2454,10 +2510,28 @@ void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
>  		if (chip->usb_id == p->id ||
>  		    (!USB_ID_PRODUCT(p->id) &&
>  		     USB_ID_VENDOR(chip->usb_id) == USB_ID_VENDOR(p->id))) {
> -			usb_audio_dbg(chip,
> -				      "Set quirk_flags 0x%x for device %04x:%04x\n",
> -				      p->flags, USB_ID_VENDOR(chip->usb_id),
> -				      USB_ID_PRODUCT(chip->usb_id));
> +			unsigned long flags = p->flags;
> +			unsigned long bit;
> +
> +			for_each_set_bit(bit, &flags,
> +					 BYTES_TO_BITS(sizeof(p->flags))) {
> +				const char *name =
> +					snd_usb_audio_quirk_flag_names[bit];
> +
> +				if (name)
> +					usb_audio_dbg(chip,
> +						      "Set quirk flag %s for device %04x:%04x\n",
> +						      name,
> +						      USB_ID_VENDOR(chip->usb_id),
> +						      USB_ID_PRODUCT(chip->usb_id));
> +				else
> +					usb_audio_warn(chip,
> +						       "Set unknown quirk flag 0x%lx for device %04x:%04x\n",
> +						       bit,
> +						       USB_ID_VENDOR(chip->usb_id),
> +						       USB_ID_PRODUCT(chip->usb_id));
> +			}

This could be better factored out as a function.


thanks,

Takashi

