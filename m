Return-Path: <linux-kernel+bounces-779121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2BCB2EF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8DA1CC2A42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726AF2DFA39;
	Thu, 21 Aug 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sYkEH7lW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kWvwr3a/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JOaCCOjC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+dHVBNS/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263602D97A9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760647; cv=none; b=pUb2Z2jn55bTnXwPCmszTlyteMdJblRU46gp+9E1eIngM7R2TQ7uf8mG3vABzxI7pBpmZqv8mSPJ9UUTN6G8GRhNFilLonRGAVorVWtXD1r3++zSQDJq2R+jcMOEs90R5d528hIWEEfRfvmM5F92U3pyi7YkZ6KNoHcBeK69xzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760647; c=relaxed/simple;
	bh=iGo9CUPN9ePue4vBGmdnfH4LbpOHm6JPYCguMRG6zYc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ot4a6p4P43up79xzSgUXrDixbgumAE8LdmC8S0D65VYu4XNm5zlVaUsRjivadzmgsRD+iNdXP3Ghv1J7Q2h6FuCb8OOLW9AbtOMbH6pRgSvg8IVEvWK9slJBOR/eSz0yudoYa7LfMEs3gt/JutBMbJ82MiWvMyH8El0vegnuayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sYkEH7lW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kWvwr3a/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JOaCCOjC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+dHVBNS/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A394F1F7C7;
	Thu, 21 Aug 2025 07:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755760644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/y9JmkXq3GtO/yb5Oh0UJaNAR3IXYSrNhBxF4GnFXs=;
	b=sYkEH7lW1ZnwoTrjSpY+13OELTt/CVBWCg7+SKtaA4dz+dXBrNpzFXTkU2u21ct9mi1NZP
	yM5qQ4Jy2XWssK8TeSUZq6C3RImMoKBSLooHjzVmNlo5X3do0403czIOqybuQGn3HciKtC
	ds3TBlCoILJvGnxWHNrYFGlq2b0F25E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755760644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/y9JmkXq3GtO/yb5Oh0UJaNAR3IXYSrNhBxF4GnFXs=;
	b=kWvwr3a/1GnyJXknRVjmyC/Fd8UHb8UQetUGQzwb+Fm/bhOOig0+QQSkke7lVIY0YHwTkn
	+hyok7wzm7mJH8CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755760643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/y9JmkXq3GtO/yb5Oh0UJaNAR3IXYSrNhBxF4GnFXs=;
	b=JOaCCOjCc+HWVhC1xtRpoSfyL16QJFO6rTeJKir3hUtY/yEjIIllcm4pagyMIXTUEf8C7m
	zXUZBlpjS1HOHdhcJqiKQXqUiFfv27Pt5HjRzACO9C7JdzheCa94OrS2yhCELdl7Vr4M6B
	oj5oqiRer2cY6Nr72jkfMYjzhtoPhtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755760643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/y9JmkXq3GtO/yb5Oh0UJaNAR3IXYSrNhBxF4GnFXs=;
	b=+dHVBNS/oBLakwMkAwwUtkrKiDEBeORJQjTa9//OdHdnYIl4kpYnlL7rwCKdw1B3Ze9y9s
	mL7Zua5RmsSXl5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 554BA13867;
	Thu, 21 Aug 2025 07:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EElcEwPIpmgsAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 21 Aug 2025 07:17:23 +0000
Date: Thu, 21 Aug 2025 09:17:22 +0200
Message-ID: <87cy8p6t4t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>,
	<jesse-ji@ti.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Enable init_profile_id for device initialization
In-Reply-To: <20250820082123.1125-1-shenghao-ding@ti.com>
References: <20250820082123.1125-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,ti.com:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Wed, 20 Aug 2025 10:21:23 +0200,
Shenghao Ding wrote:
> 
> Optimize the time consumption of profile switching, init_profile saves
> the common settings of different profiles, such as the dsp coefficients,
> etc, which can greatly reduce the profile switching time comsumption and
> remove the repetitive settings.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> index 318f8c58ae61..97c33fee9660 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> @@ -477,6 +477,12 @@ static void tasdevice_dspfw_init(void *context)
>  	if (tas_priv->fmw->nr_configurations > 0)
>  		tas_priv->cur_conf = 0;
>  
> +	/* Init common setting for different audio profiles */
> +	if (tas_priv->rcabin.init_profile_id >= 0)
> +		tasdevice_select_cfg_blk(tas_priv,
> +			tas_priv->rcabin.init_profile_id,
> +			TASDEVICE_BIN_BLK_PRE_POWER_UP);
> +
>  	/* If calibrated data occurs error, dsp will still works with default
>  	 * calibrated data inside algo.
>  	 */
> @@ -779,6 +785,12 @@ static int tas2781_system_resume(struct device *dev)
>  	tasdevice_reset(tas_hda->priv);
>  	tasdevice_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
>  
> +	/* Init common setting for different audio profiles */
> +	if (tas_hda->priv->rcabin.init_profile_id >= 0)
> +		tasdevice_select_cfg_blk(tas_hda->priv,
> +			tas_hda->priv->rcabin.init_profile_id,
> +			TASDEVICE_BIN_BLK_PRE_POWER_UP);
> +
>  	if (tas_hda->priv->playback_started)
>  		tasdevice_tuning_switch(tas_hda->priv, 0);

The patch causes build errors:

sound/hda/codecs/side-codecs/tas2781_hda_i2c.c: In function ¡tasdevice_dspfw_init¢:
sound/hda/codecs/side-codecs/tas2781_hda_i2c.c:468:29: error: ¡struct tasdevice_rca¢ has no member named ¡init_profile_id¢
  468 |         if (tas_priv->rcabin.init_profile_id >= 0)
      |                             ^
....

Something still not landed in my tree yet.


thanks,

Takashi

