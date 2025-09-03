Return-Path: <linux-kernel+bounces-798113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D9BB419A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B755E1892414
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D42ED853;
	Wed,  3 Sep 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BC2KR7m8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lTVqWkOT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n/eQEnMw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X3ydiXUP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19272DAFBA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890667; cv=none; b=b5rH25SvaRKkq7LlO4V34PaQDyQzY1xT2krPY/ihIY4w1YVrYkwDEGfJSlQ6LFdueA/uxZ1o04XMBINhEZt5NNZn5vjr90F5c4B0SPi1U24N7hTffv4dcy6Tya0EbLVBN4pmLUkOrZNSUuWXsOJPN1wY1Pf97uGzQmssEXViJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890667; c=relaxed/simple;
	bh=zAWoGnz2y7CwLjX58jB83OvAck2B6JWBzTw/V8aAOp4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJLE/7MEz+DtmftkRRt3rtzQTWa42TsAdgrXMQ4TA0/GJy/XesanQ+6cDp37k1i1lcoAx2axZ3qCPwrc/Jpq1b/WZul2tq+DcmJhhFac/VuE71tfYfJgKlUmjLGjW7zlX/KJIjmoGt/rOPhkN4Fs70tVEryTT0QLfCh+qUaxcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BC2KR7m8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lTVqWkOT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n/eQEnMw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X3ydiXUP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 863E32191F;
	Wed,  3 Sep 2025 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756890654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqJ0qVbciWWxeZgsRG9NGeP3cguWzw91eI2DWW2hyoo=;
	b=BC2KR7m887TJoozq4pIfds8w9RbfAbjWReiYUEpbcNCqlZnqp+MWkGasTZWozKakWY85ez
	wenDMS9smjH8Zo30lGgqgtJv20JapkkKTqrZ5jalSKSccB0fulVZK49yenSlTE6sZJ/8V9
	Z57B40QMGfuqBaPC9mrtpm6oKucBL6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756890654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqJ0qVbciWWxeZgsRG9NGeP3cguWzw91eI2DWW2hyoo=;
	b=lTVqWkOT6NB7mFiHEiGQKJvUe17w1RuZy1yTS8W1cirOaEksMSN0a+w/U3ATiXHVJ9iklc
	YtWULPOn4/+rULAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756890653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqJ0qVbciWWxeZgsRG9NGeP3cguWzw91eI2DWW2hyoo=;
	b=n/eQEnMwD7lr+y1npLQ/jMmQv7syXQ/WSKaaKeVqRzc5DfUblKBv0Dx6igaflxo8EfHO+4
	ljuQT04zdk9PoH8sp1757g26rYL3qCun++6bBNds4W6uSnkw5xRM2nzDv3Rr+juejsCpyo
	e2cvuNHrzH5LRI/4m+UDT2Gjq4KtcWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756890653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TqJ0qVbciWWxeZgsRG9NGeP3cguWzw91eI2DWW2hyoo=;
	b=X3ydiXUPXyY6chf77547uS8RkskxAfv71xY+A1rpfZaaMhDdVrOLkjMaz3791ADQCT7BIr
	FrTz4WehiSb0EBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D9D913888;
	Wed,  3 Sep 2025 09:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 98fIDR0GuGjgYQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 03 Sep 2025 09:10:53 +0000
Date: Wed, 03 Sep 2025 11:10:52 +0200
Message-ID: <875xdzx5nn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Fix the order of TAS2781 calibrated-data
In-Reply-To: <20250903041351.143-1-shenghao-ding@ti.com>
References: <20250903041351.143-1-shenghao-ding@ti.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Wed, 03 Sep 2025 06:13:51 +0200,
Shenghao Ding wrote:
> 
> A bug reported by one of my customers that the order of TAS2781
> calibrated-data is incorrect, the correct way is to move R0_Low
> and insert it between R0 and InvR0.
> 
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> v2:
>  - Submit to sound branch maintianed by Tiwai instead of linux-next branch
>  - drop other fix
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda.c | 38 ++++++++++++++++++----
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codecs/side-codecs/tas2781_hda.c
> index f46d2e06c64f..cd9990869e18 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
> @@ -33,6 +33,32 @@ const efi_guid_t tasdev_fct_efi_guid[] = {
>  };
>  EXPORT_SYMBOL_NS_GPL(tasdev_fct_efi_guid, "SND_HDA_SCODEC_TAS2781");
>  
> +/*
> + * The order of calibrated-data writing is a bit different from the order
> + * in UEFI. Here is the conversion to match the order of calibrated-data
> + * writing.
> + */
> +static void cali_cnv(unsigned char *data, unsigned int base, int offset)
> +{
> +	__be32 bedata[TASDEV_CALIB_N];
> +	int i;
> +
> +	/* r0_reg */
> +	bedata[0] = cpu_to_be32(*(uint32_t *)&data[base]);
> +	/* r0_low_reg */
> +	bedata[1] = cpu_to_be32(*(uint32_t *)&data[base + 8]);
> +	/* invr0_reg */
> +	bedata[2] = cpu_to_be32(*(uint32_t *)&data[base + 4]);
> +	/* pow_reg */
> +	bedata[3] = cpu_to_be32(*(uint32_t *)&data[base + 12]);
> +	/* tlimit_reg */
> +	bedata[4] = cpu_to_be32(*(uint32_t *)&data[base + 16]);
> +
> +	for (i = 0; i < TASDEV_CALIB_N; i++)
> +		memcpy(&data[offset + i * 4 + 1], &bedata[i],
> +			sizeof(bedata[i]));
> +}

IMO, this can be more readable when you use struct calidata, e.g.

static void cali_cnv(unsigned char *data, unsigned int base, int offset)
{
	struct calidata reg;

	reg.r0_reg = *(u32 *)&data[base]
	reg.r0_low_reg = *(u32 *)&data[base + 8]
	reg.invr0_reg = *(u32 *)&data[base + 4]
	reg.pow_reg = *(u32 *)&data[base + 12];
	reg.tlimit_reg = *(u32 *)&data[base + 16]);

	cpu_to_be32_array((__force __be32 *)(data + offset + 1), &reg,
			  TASDEV_CALIB_N);
}

... or even simpler like:

static void cali_cnv(unsigned char *data, unsigned int base, int offset)
{
	struct calidata reg;

	memcpy(&reg, data, sizeof(reg));
	/* the data order has to be swapped between r0_low_reg and inv0_reg */
	swap(reg.r0_low_reg, reg.invr0_reg);

	cpu_to_be32_array((__force __be32 *)(data + offset + 1), &reg,
			  TASDEV_CALIB_N);
}

>  static void tas2781_apply_calib(struct tasdevice_priv *p)
>  {
>  	struct calidata *cali_data = &p->cali_data;
> @@ -86,6 +112,7 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
>  
>  		for (j = 0, k = 0; j < node_num; j++) {
>  			oft = j * 6 + 3;
> +			/* Calibration registers address */

Don't try to add unrelated changes.  This comment won't fix or explain
what your patch does.  If any, make another patch to update / add more
comments.
Putting unrelated changes disturbs the patch readability *a lot*

>  			if (tmp_val[oft] == TASDEV_UEFI_CALI_REG_ADDR_FLG) {
>  				for (i = 0; i < TASDEV_CALIB_N; i++) {
>  					buf = &data[(oft + i + 1) * 4];
> @@ -93,6 +120,7 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
>  						buf[2], buf[3]);
>  				}
>  			} else {
> +				/* Calibrated data */

Ditto.

> @@ -127,12 +154,11 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
>  			dev_err(p->dev, "%s: V1 CRC error\n", __func__);
>  			return;
>  		}
> -
> +		/* reverse rearrangement in case of overlap */

Ditto.


thanks,

Takashi

