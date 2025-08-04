Return-Path: <linux-kernel+bounces-754727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405FCB19B7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE37D18921D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06F22B5B8;
	Mon,  4 Aug 2025 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nw3qtEMy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gRS8aiPH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nw3qtEMy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gRS8aiPH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C59126BF7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288283; cv=none; b=pfgQ76OhU9NlF+Ykk+5yfoLEG6uOaeWkZwgbs9JCT5TqeiHA6kXaWYB2nrd9pmM/HOfMyzFAWmPdRCJr+WPJ69z70Rg59cesbIPU92HiC1SpgJ2RQpbTPIJyWGCEUSP7tNL+Gr93RjnMFtTeG6RJZh00NJl6ltw53bI3a3UoiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288283; c=relaxed/simple;
	bh=pZR6Fp4Yv4RhcWDZhwuCygJQCcbVzEFbJY3vPJYFIHM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uE1x85S2my8Ox4j82f8U7eCCcbnNMGfPRE/eq3eIlCxTbaQk/LoY0CNMdvuy5Pqqa0NtVqsI0WM8hYNAjZxQf4gs1+xm98xidUh/jTcj5OqD66PqNDDsnReKVL9W7Zrz5AxVjjBlTj31tVywNTbqg4Xxk0l7cVp1OmUtrL2tzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nw3qtEMy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gRS8aiPH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nw3qtEMy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gRS8aiPH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85E80219D1;
	Mon,  4 Aug 2025 06:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754288279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RukyBN40PONlQvCueCmqpoFDv23wRZpAVWtMPEeXZMc=;
	b=Nw3qtEMysFaBPKUPEx3SYETmskzrptg/DBQyWt8IBYdzUatqmiKCDuJ0+SvoSy1f8cYISd
	/OIiZdnHWI9EdvnWuQmVoTgsFxAVeii5FGX0C6nUK8/m1bKKduzXp4lWvgYUyT8izg2hF4
	EUCWD6SweV+vHHEkoERX/AzOnFAn3pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754288279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RukyBN40PONlQvCueCmqpoFDv23wRZpAVWtMPEeXZMc=;
	b=gRS8aiPHV6AUV4bSuv1najAf4hexbPW5pFqwlQnvXhoXPfKWU3yY+1fzDzCPWE+96ccpNa
	YOHNMobcCxMRtbAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nw3qtEMy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gRS8aiPH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754288279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RukyBN40PONlQvCueCmqpoFDv23wRZpAVWtMPEeXZMc=;
	b=Nw3qtEMysFaBPKUPEx3SYETmskzrptg/DBQyWt8IBYdzUatqmiKCDuJ0+SvoSy1f8cYISd
	/OIiZdnHWI9EdvnWuQmVoTgsFxAVeii5FGX0C6nUK8/m1bKKduzXp4lWvgYUyT8izg2hF4
	EUCWD6SweV+vHHEkoERX/AzOnFAn3pY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754288279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RukyBN40PONlQvCueCmqpoFDv23wRZpAVWtMPEeXZMc=;
	b=gRS8aiPHV6AUV4bSuv1najAf4hexbPW5pFqwlQnvXhoXPfKWU3yY+1fzDzCPWE+96ccpNa
	YOHNMobcCxMRtbAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C40B13695;
	Mon,  4 Aug 2025 06:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f1ULDZdQkGi4RQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 Aug 2025 06:17:59 +0000
Date: Mon, 04 Aug 2025 08:17:58 +0200
Message-ID: <87jz3j1ug9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdich9700@163.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Accelerate the front MIC charging and discharging of the 897 codec
In-Reply-To: <20250804030518.424229-1-wangdich9700@163.com>
References: <20250804030518.424229-1-wangdich9700@163.com>
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
X-Rspamd-Queue-Id: 85E80219D1
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[163.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org,alsa-project.org,lists.infradead.org,kylinos.cn];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -3.51

On Mon, 04 Aug 2025 05:05:17 +0200,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdicheng@kylinos.cn>
> 
> The front MIC capacitance of the Inspur board is too large, resulting in a longer charging and discharging time required,
> which in turn prevents recording for 5 seconds before startup.
> Therefore, software is used to increase the delay by 2 seconds to avoid this issue.

First off, the HD-audio code was replaced in the latest Linus tree to
sound/hda/* directories, so please adapt the patches accordingly.

About the code change:

- The 2.5 seconds wait is way too long and inappropriate to be put in
  the resume callback.  It has to be fixed differently.

- Does it apply really to all devices with 0x10ec1304?  It's Realtek's
  vendor id, so this can match to many devices.

- Last but not least, it's not nice to have a code that depends on the
  certain vendor id there.  Again, please implement in a different way
  so that it can be handled in more device-specific code rather than
  the common function.


thanks,

Takashi

> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
> ---
>  sound/pci/hda/patch_realtek.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 877137cb09ac..88675eae9447 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -1001,6 +1001,14 @@ static int alc_resume(struct hda_codec *codec)
>  	if (!spec->no_depop_delay)
>  		msleep(150); /* to avoid pop noise */
>  	codec->patch_ops.init(codec);
> +
> +	if (codec->core.subsystem_id == 0x10ec1304) {
> +		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
> +		msleep(50);
> +		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
> +		msleep(2000);
> +		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80);
> +	}
>  	snd_hda_regmap_sync(codec);
>  	hda_call_check_power_status(codec, 0x01);
>  	return 0;
> -- 
> 2.25.1
> 

