Return-Path: <linux-kernel+bounces-834521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B4BA4DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6251C02B01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81FA2FE568;
	Fri, 26 Sep 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MW8kK8WU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GCfxIpNk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0yYp4A0Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nPFm1wL2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE0223705
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910394; cv=none; b=BWZmfTOPlLTUcFth9ywVwfTaYAUwkQf+4qF/stzW2YXSBJe0N85A+CwH5f1mxnchu07jEZpmq4nX+lNBCTJ2Dx0Qdfjuff+tMGiAWjPGA/jxK6o9YZUC/NQW8n9ErAzqwUlAjI/i5oNUbb8luZqGVeDvINVhjXiU6FUDdqgzE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910394; c=relaxed/simple;
	bh=0+W1Na4CAb7UCDasIjvvPSb7/qVXNolxFmrc3sFe238=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqmoMmmp1re9knM2Gmfo9fXx1fknJFbeerUbA5Om4uPu/FKseGU0ClI0T3pOs81vfCZRsVwWdy0D9SsXjQTlXVlsYm2AH4+eHo9dgxrLzj6/8SmocDCOksmHz/G1Wbs+qzfSVayIYQ4cKUhu+rR6nnefNusqvl0BANB6qzKLsQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MW8kK8WU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GCfxIpNk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0yYp4A0Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nPFm1wL2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFD0922132;
	Fri, 26 Sep 2025 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758910389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2fR5fMHUJBEiytnVArGr5QfpX9gLSLu8Btxg4OIEmY=;
	b=MW8kK8WUaF34Ly8qdyUjbxChbw0y5E9pPwHXpYY9HveavDj+6d3QT0bACtiUHJ777fE9hx
	9dsuAlJkTWRsaGIBIp3tQ2np68WQrsmoGpHj9uEnvLBixPtJdMuxgDJ8HnbghAESXvG126
	vRUZVZP5U7pejlxJm7wUca1682mqsDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758910389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2fR5fMHUJBEiytnVArGr5QfpX9gLSLu8Btxg4OIEmY=;
	b=GCfxIpNkdYF5Cw1hikH8B7gygjJk9sTyM9QPZKJm2AkRON9qSkbL99TcOgGodFuyz0GR/K
	AJxMvY134B+FKTBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758910387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2fR5fMHUJBEiytnVArGr5QfpX9gLSLu8Btxg4OIEmY=;
	b=0yYp4A0Zq1yC6ADWBKoHwe/rowHUz8mxabRRnrJ1cTSNdmbCNQDFgAmB1oNwg0XTxA95tz
	Vel5/Pwrb6AyCn2+ptmv7ea6bmHSK5EWTqO0rPz8uS40S09LDizmm1RBqBb6UMwAvH36N2
	TOlU5YY3dLLsNRwOWjyxucFziEoD/Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758910387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2fR5fMHUJBEiytnVArGr5QfpX9gLSLu8Btxg4OIEmY=;
	b=nPFm1wL2+ov3lHngOnzyzbAlO+XaJKf4ZdX8Ah0Xw+LkDYoTPX8zu+eBPPkvl3fHkvFspC
	JYfgIb6BKoLyr5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EF441386E;
	Fri, 26 Sep 2025 18:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +SeJFbPX1mhHMgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 26 Sep 2025 18:13:07 +0000
Date: Fri, 26 Sep 2025 20:13:06 +0200
Message-ID: <87ldm1axql.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<shenghao-ding@ti.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<lgirdwood@gmail.com>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>,
	<k-yi@ti.com>,
	<henry.lo@ti.com>,
	<robinchen@ti.com>,
	<jesse-ji@ti.com>,
	<will-wang@ti.com>,
	<jim.shil@goertek.com>,
	<toastcheng@google.com>,
	<chinkaiting@google.com>
Subject: Re: [PATCH v2 1/2] ASoC: tas2781: Add tas5828 support
In-Reply-To: <20250926043339.8419-1-baojun.xu@ti.com>
References: <20250926043339.8419-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,ti.com,vger.kernel.org,gmail.com,goertek.com,google.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Fri, 26 Sep 2025 06:33:38 +0200,
Baojun Xu wrote:
> 
> TAS5828 have on-chip DSP without current/voltage feedback.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Please use a different subject for each patch.  Both patches are 100%
identical subject, and that makes harder to identify.


thanks,

Takashi

> 
> ---
> v2:
>  - Update description for TAS5828
>  - Change commit tree to .../tiwai/sound.git.
> ---
>  include/sound/tas2781.h        | 1 +
>  sound/soc/codecs/tas2781-i2c.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
> index ddd997ac3..a37b4d67c 100644
> --- a/include/sound/tas2781.h
> +++ b/include/sound/tas2781.h
> @@ -122,6 +122,7 @@ enum audio_device {
>  	TAS2781,
>  	TAS5825,
>  	TAS5827,
> +	TAS5828,
>  	TAS_OTHERS,
>  };
>  
> diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
> index 1539b7088..f62a71dca 100644
> --- a/sound/soc/codecs/tas2781-i2c.c
> +++ b/sound/soc/codecs/tas2781-i2c.c
> @@ -110,6 +110,7 @@ static const struct i2c_device_id tasdevice_id[] = {
>  	{ "tas2781", TAS2781 },
>  	{ "tas5825", TAS5825 },
>  	{ "tas5827", TAS5827 },
> +	{ "tas5828", TAS5828 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, tasdevice_id);
> @@ -126,6 +127,7 @@ static const struct of_device_id tasdevice_of_match[] = {
>  	{ .compatible = "ti,tas2781" },
>  	{ .compatible = "ti,tas5825" },
>  	{ .compatible = "ti,tas5827" },
> +	{ .compatible = "ti,tas5828" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, tasdevice_of_match);
> @@ -1665,7 +1667,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
>  	}
>  	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
>  
> -	/* There is no calibration required for TAS5825/TAS5827. */
> +	/* There is no calibration required for TAS5825/TAS5827/TAS5828. */
>  	if (tas_priv->chip_id < TAS5825) {
>  		ret = tasdevice_create_cali_ctrls(tas_priv);
>  		if (ret) {
> @@ -1722,6 +1724,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
>  		case TAS2781:
>  		case TAS5825:
>  		case TAS5827:
> +		case TAS5828:
>  			/* If DSP FW fail, DSP kcontrol won't be created. */
>  			tasdevice_dsp_remove(tas_priv);
>  		}
> @@ -1884,6 +1887,7 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
>  		break;
>  	case TAS5825:
>  	case TAS5827:
> +	case TAS5828:
>  		p = (struct snd_kcontrol_new *)tas5825_snd_controls;
>  		size = ARRAY_SIZE(tas5825_snd_controls);
>  		break;
> @@ -2056,6 +2060,7 @@ static const struct acpi_device_id tasdevice_acpi_match[] = {
>  	{ "TXNW2781", TAS2781 },
>  	{ "TXNW5825", TAS5825 },
>  	{ "TXNW5827", TAS5827 },
> +	{ "TXNW5828", TAS5828 },
>  	{},
>  };
>  
> -- 
> 2.25.1
> 

