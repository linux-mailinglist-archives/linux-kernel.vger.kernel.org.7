Return-Path: <linux-kernel+bounces-791296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23254B3B4CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0589841FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7922853FD;
	Fri, 29 Aug 2025 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N3tOgz2r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RReXZyzb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VuwX+BFU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="czpKl5gk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB85285041
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454115; cv=none; b=oYkpvCr88HMi+3tGfNa+KMz39nLrYbbWJhA4c+DhoHlGmdWBFBzsddOQZHcwuLeFPSu3psqO21BPOEvufgykNxpyA8RmngdiQFXbapTu1eQAyF0E4T1ogWH4tv07x5eHLgW9W9NA2HpVxHa8uLEYxxxkCJ6v6HMT7crI6J07w6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454115; c=relaxed/simple;
	bh=k3v2fJVcyeVJCZQlqSt9kNdDpgpKXuGZOPu1XpDLYag=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRSgVCFZJSh7FAecunbRGryLoZ8JqBr5CkMBAH9l7Hx5g979V8XlQ7+/7/DpSx0VvxhfHBo1tasfgNBD5vyAACU9JQRUry2wgZRGboVz59JbzI0H+/U0XhHXEY/q7Zd2hAPfqcP1tOnQxwWbNZoE1vl8SMBE9qrBX/iToYXy/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N3tOgz2r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RReXZyzb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VuwX+BFU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=czpKl5gk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E58A021D65;
	Fri, 29 Aug 2025 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756454111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5xCdNAt/TMvWbdElAdCeAl9J1q/hpSEni3jvDwsZ588=;
	b=N3tOgz2rVq2XklwAHsU6KhLr5MGvZzmEWctxmmdpcMNcKEP68y7YJ5Jds6NAk31IXYE8LB
	b77LWq66ooK/nuEq6dseFu37T9YDRplc4RNDw2OLNTScNd12wfMhlKVOkhteYZRYC+1t+m
	lrR33lmqd67Kd6DiXbpyH6CfqeibmiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756454111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5xCdNAt/TMvWbdElAdCeAl9J1q/hpSEni3jvDwsZ588=;
	b=RReXZyzbLlZFooLL0ir1dEiiaPZViukX2XQ69kCVra7Xqu+b38JFDwaMtPzQItSaK0/3TM
	eIoHD0rJ1e8e+uCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756454110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5xCdNAt/TMvWbdElAdCeAl9J1q/hpSEni3jvDwsZ588=;
	b=VuwX+BFUmJLEzCi3+6T4AK8BrL+nIviEVEalOGSBGv3Q4apU9zfrtBT4b4FASq13Iyx4v1
	LwzcCTqIqQsi4xdgCiv+eVH2h8fDk3+ivYYufpOzyVkNmPRK4N9U5RydaWytmRlLsg5Ysx
	AACG/nKC4iPC+c0DB0CQKQ068pcQuUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756454110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5xCdNAt/TMvWbdElAdCeAl9J1q/hpSEni3jvDwsZ588=;
	b=czpKl5gkcztpG6SQL+RYjF1uzIcAg41lGfhrEnCoF4u9hKYLtToGd6wi2FLUODFjoRcpg7
	F5BsV9SEhSQgL2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88CB713A3E;
	Fri, 29 Aug 2025 07:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NjMoIN5csWiPEwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Aug 2025 07:55:10 +0000
Date: Fri, 29 Aug 2025 09:55:10 +0200
Message-ID: <87bjnyimu9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Wang Yuli <wangyuli@deepin.org>,
	Guan Wentao <guanwentao@uniontech.com>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	Guoli An <anguoli@uniontech.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Add module param mixer_min_mute
In-Reply-To: <20250829-sound-param-v1-1-3c2f67cd7c97@uniontech.com>
References: <20250829-sound-param-v1-0-3c2f67cd7c97@uniontech.com>
	<20250829-sound-param-v1-1-3c2f67cd7c97@uniontech.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,lwn.net,vger.kernel.org,aosc.io,deepin.org,uniontech.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Fri, 29 Aug 2025 07:10:59 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> As already discussed[1], a module parameter called mixer_min_mute is
> added to make it easier for end users to debug the widespread problem
> without recompiling the kernel, where USB audio devices are muted when
> the volume is set to the minimum value.
> 
> 1.
> https://lore.kernel.org/all/20250827-sound-quirk-min-mute-v1-1-4717aa8a4f6a@uniontech.com/
> 
> Tested-by: Guoli An <anguoli@uniontech.com>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Err, maybe I misunderstood your suggestion in the previous patch.
I didn't mean to add a new option, but only about adding the quirk
bit.

Honestly speaking, I don't want to add yet new option for a specific
quirk behavior.  Once when we add, it's sticking almost forever and we
can't delete it any longer.  Also, this option will apply to all USB
connected USB-audio devices, which may have ill effect, too.

What I had in mind instead is to extend the syntax of quirk option.
e.g. it can accept a string like "mixer_min_mute" not only the integer
value.  Or it may have a form like "$vendor:$value" so that it can be
applied no matter which slot it's assigned.


thanks,

Takashi

> ---
>  sound/usb/card.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 0265206a8e8cf31133e8463c98fe0497d8ace89e..bf65727ad213f2897d735c1f3c55bfc3f85971cf 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -74,6 +74,7 @@ static char *quirk_alias[SNDRV_CARDS];
>  static char *delayed_register[SNDRV_CARDS];
>  static bool implicit_fb[SNDRV_CARDS];
>  static unsigned int quirk_flags[SNDRV_CARDS];
> +static bool mixer_min_mute;
>  
>  bool snd_usb_use_vmalloc = true;
>  bool snd_usb_skip_validation;
> @@ -109,6 +110,9 @@ module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
>  MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
>  module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
>  MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no).");
> +module_param(mixer_min_mute, bool, 0444);
> +MODULE_PARM_DESC(mixer_min_mute,
> +		 "Set minimum volume control value as mute (default: no).");
>  
>  /*
>   * we keep the snd_usb_audio_t instances by ourselves for merging
> @@ -959,6 +963,9 @@ static int usb_audio_probe(struct usb_interface *intf,
>  	if (ignore_ctl_error)
>  		chip->quirk_flags |= QUIRK_FLAG_IGNORE_CTL_ERROR;
>  
> +	if (mixer_min_mute)
> +		chip->quirk_flags |= QUIRK_FLAG_MIXER_MIN_MUTE;
> +
>  	if (chip->quirk_flags & QUIRK_FLAG_DISABLE_AUTOSUSPEND)
>  		usb_disable_autosuspend(interface_to_usbdev(intf));
>  
> 
> -- 
> 2.51.0
> 
> 

