Return-Path: <linux-kernel+bounces-725901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F24B00540
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F6464644D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C22741AB;
	Thu, 10 Jul 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hg0/mGFV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="REXiblts";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hg0/mGFV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="REXiblts"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429021D3E8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157686; cv=none; b=tyTl1pPL/lo++6G+7Ogok4QtAAeSZpoTLQiRs+JQRP4n7wJ67y97I/I/VEogdSFAU0w3B0zbKfK/49RKkyiGHaENYyN74ht4ogAECbKKXOtfWKB7boKHXdBGISgaitT5dQ3bECfQPlRLktvG9vZmG7u6zVY0D+Al0RGVHWCac9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157686; c=relaxed/simple;
	bh=kOGsh3fkrbz0BzYbYQ6lOODvQ0YEI7n6IjLBLsXp5xM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Phvn7ewtQqOG/w968uMR+OcFMWPMBuXnFSbZKuYW+j/CUeW8f4btQmNTVaM7u6PrK62kIVlWpEnOB5UJW9Y1Ws8Vg6Dj6+MgTmrDfDT2FK8DZ7ApGPI6vLxSWIer5XIwBQXr+D4xD41ZXOc2mFRhLUeYvW1XPOibVw/7RLbaojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hg0/mGFV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=REXiblts; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hg0/mGFV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=REXiblts; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 218482174D;
	Thu, 10 Jul 2025 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752157681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu+1RY9GxNNi2MLgALISTgh4+czoUf0Xk8OUPLnLugw=;
	b=hg0/mGFVfCvogWsJH3maUlB8YTstKR8oPjFnB+k3v2G3CgzKYw6PqB0JojsMrVE7yXUhDt
	IH9d7FQ3rrMX8QukXDnClOzpPd5Qj+QmeUnhNftx6Sz/9ujrghJvrOqN+bOCoTC9laMA04
	OdulQbuteOHL84DhAEQFMDOPTfGouWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752157681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu+1RY9GxNNi2MLgALISTgh4+czoUf0Xk8OUPLnLugw=;
	b=REXibltsevF5BeSDvJm5fBUm5s1BAJNQ74OmTX2hPP02PotyVJ9X0dLnQZqdgw+7IMGIPP
	5RbavPW0QS9kFvDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="hg0/mGFV";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=REXiblts
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752157681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu+1RY9GxNNi2MLgALISTgh4+czoUf0Xk8OUPLnLugw=;
	b=hg0/mGFVfCvogWsJH3maUlB8YTstKR8oPjFnB+k3v2G3CgzKYw6PqB0JojsMrVE7yXUhDt
	IH9d7FQ3rrMX8QukXDnClOzpPd5Qj+QmeUnhNftx6Sz/9ujrghJvrOqN+bOCoTC9laMA04
	OdulQbuteOHL84DhAEQFMDOPTfGouWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752157681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu+1RY9GxNNi2MLgALISTgh4+czoUf0Xk8OUPLnLugw=;
	b=REXibltsevF5BeSDvJm5fBUm5s1BAJNQ74OmTX2hPP02PotyVJ9X0dLnQZqdgw+7IMGIPP
	5RbavPW0QS9kFvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECE9A136DC;
	Thu, 10 Jul 2025 14:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zESbOPDNb2i3NAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 10 Jul 2025 14:28:00 +0000
Date: Thu, 10 Jul 2025 16:28:00 +0200
Message-ID: <87tt3kw26n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ahelenia =?ISO-8859-2?Q?Ziemia=F1ska?=
 <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: emu10k1: fix "for/take a while" typos
In-Reply-To: <e4owjda3hf5vjc2237m3ctokey4qglfrciga6ho24bd4os5awk@tarta.nabijaczleweli.xyz>
References: <e4owjda3hf5vjc2237m3ctokey4qglfrciga6ho24bd4os5awk@tarta.nabijaczleweli.xyz>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 218482174D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 03 Jul 2025 20:21:29 +0200,
Ahelenia Ziemiañska wrote:
> 
> Signed-off-by: Ahelenia Ziemiañska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz/t/#u

Well, "awhile" is a proper word, AFAIK.


thanks,

Takashi

> 
>  sound/pci/emu10k1/emu10k1_main.c | 2 +-
>  sound/pci/emu10k1/emupcm.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
> index bbe252b8916c..6050201851b1 100644
> --- a/sound/pci/emu10k1/emu10k1_main.c
> +++ b/sound/pci/emu10k1/emu10k1_main.c
> @@ -606,7 +606,7 @@ static int snd_emu10k1_ecard_init(struct snd_emu10k1 *emu)
>  	/* Step 2: Calibrate the ADC and DAC */
>  	snd_emu10k1_ecard_write(emu, EC_DACCAL | EC_LEDN | EC_TRIM_CSN);
>  
> -	/* Step 3: Wait for awhile;   XXX We can't get away with this
> +	/* Step 3: Wait for a while;   XXX We can't get away with this
>  	 * under a real operating system; we'll need to block and wait that
>  	 * way. */
>  	snd_emu10k1_wait(emu, 48000);
> diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
> index 1bf6e3d652f8..ca4b03317539 100644
> --- a/sound/pci/emu10k1/emupcm.c
> +++ b/sound/pci/emu10k1/emupcm.c
> @@ -991,7 +991,7 @@ static snd_pcm_uframes_t snd_emu10k1_capture_pointer(struct snd_pcm_substream *s
>  	if (!epcm->running)
>  		return 0;
>  	if (epcm->first_ptr) {
> -		udelay(50);	/* hack, it takes awhile until capture is started */
> +		udelay(50);	/* hack, it takes a while until capture is started */
>  		epcm->first_ptr = 0;
>  	}
>  	ptr = snd_emu10k1_ptr_read(emu, epcm->capture_idx_reg, 0) & 0x0000ffff;
> -- 
> 2.39.5
> Verifying...

