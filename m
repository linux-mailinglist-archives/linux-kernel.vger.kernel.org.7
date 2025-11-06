Return-Path: <linux-kernel+bounces-888230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D62C3A41A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4837218891CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BD52D94AC;
	Thu,  6 Nov 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bb8hFQAE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wwWmp2qy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="izEmMzlL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xzf/5/Xo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0728726E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424652; cv=none; b=SFA6RGVKfQXskYKM/r8H9QdEZfb29NcTWTHD4tf2GY2Ut1FtXy+2Lk88ghtS1TCXLr0GoIkV1PAYQ+ArVIlucWKevRO3E1qs0DwtBn6Q8Prd/bwdq5uTkbKgg4TXt5HCCqs2RNG0Pb6jEhkmuLeF2uc+LCbKjnYdrfMboZv8q0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424652; c=relaxed/simple;
	bh=qavZbl+4d9Auzi5x68FVpqsK2Og3mcO4H6nFIWFrYhE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+aDFeSbnCF7UkJ3YDBnUsfsedJOt/I112Hs4QT42Swmv6lI+XGf6YAi+fyV5tENACnHh3GCJYJ5RQTpD06r6Zcjgw9FuKjWHPGW5+DdLzzRWSBlmpwqtBoEJ+HtCSq5RdHNb/qW54wib2761aY1eDVsD8fvGUy6+ii0uR96pwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bb8hFQAE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wwWmp2qy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=izEmMzlL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xzf/5/Xo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD3D31F457;
	Thu,  6 Nov 2025 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762424649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqCJ3U/dPBQGaV7i7k/kR7atpy/cVN5b99fapvM1uOs=;
	b=Bb8hFQAEuSZnXsy25UAs1Y+hk+z0ks/G/sifw2viOzyvExgcyxxYEGm3/afKlEhtWKoBV2
	F6UK3FYCzscG2CYbGlkD0mWbJChzyjaVGnePMEJZGD0PNOUZ9boeAsZZx8jj6jPKJLWSzV
	GW5RTMH2Ex2b5uzVgL/m9nD+4Y3ncEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762424649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqCJ3U/dPBQGaV7i7k/kR7atpy/cVN5b99fapvM1uOs=;
	b=wwWmp2qyvkHAne2YQTKe96siCokd5zgk3lJsD4v6ZyEwwxw9RFAFfAx+NH982wSaTH5ssg
	/KZ8Mf2Z5DHmIIDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762424648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqCJ3U/dPBQGaV7i7k/kR7atpy/cVN5b99fapvM1uOs=;
	b=izEmMzlLr8p7R9KnNOS2tOsBfnagLWGsm7Vuh0DgtR+Fa+uPN7QQHGnBEr+A0lPkTr28Ed
	lovcdVuH9BmhrSbHiU8rqLXp2szENMsUKc4r4FRnu/GsSBkJP+9Pmma0tALmiJSEPMEcMA
	ra28UEhvpC9jCL2v96lkrmrz9eSQ9Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762424648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqCJ3U/dPBQGaV7i7k/kR7atpy/cVN5b99fapvM1uOs=;
	b=Xzf/5/XoHJMiLaiYgcUq0ksQp8xe9wr/VTd48oxcAL+nVZg7k6yipfyiDr/cO0Gtc4XyET
	yGeaD5lMImjpH5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F3B213A31;
	Thu,  6 Nov 2025 10:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TnqQIUh3DGmITQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 10:24:08 +0000
Date: Thu, 06 Nov 2025 11:24:08 +0100
Message-ID: <871pmbh31z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdich9700@163.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH] [PATCH v3] ALSA: hda/conexant: Fix pop noise on CX11880/SN6140 codecs
In-Reply-To: <20251106063459.115006-1-wangdich9700@163.com>
References: <20251106063459.115006-1-wangdich9700@163.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,intel.com,vger.kernel.org,lists.infradead.org,kylinos.cn];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,kylinos.cn:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Thu, 06 Nov 2025 07:34:59 +0100,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdich9700@163.com>
> 
> Pop noise mitigation: When headphones are unplugged during playback, mute
> speaker DAC (0x17) immediately and restore after 20ms delay to avoid
> audible popping. This fix is specifically for CX11880 (0x14f11f86) and
> SN6140 (0x14f11f87) codecs based on testing verification.
> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
> ---
> V2 -> V3:
> - Fixed container_of usage by storing codec pointer in spec structure
> - Added cancellation of delayed work when headphone is re-plugged
> - Limited the fix to specific device IDs (0x14f11f86, 0x14f11f87) based on testing
> - Added proper cleanup in remove function

Thanks for the patch, but unfortunately the patch isn't in a good
enough shape.

First off, the code change doesn't consider about the runtime PM.
That is, the work itself might wake up the runtime resume.

The other points are:
- The patch contains lots of magic numbers that should have been
  represented with the defined constants.
- It touches the HD-audio codec verbs directly for pin detections and
  amps, which should be rather done via the standard helpers --
  otherwise it will break the whole regmap caches.  This might be
  intentional, but if so, it must be clearly commented.
- The work must be synced properly at suspend or similar operations,
  too.
- The code assumes the fixed pin definitions without checking the
  actual pin configurations.  It won't work when the pin config
  differs.

And, the most important point is that it's better to do the root cause
analysis again.  Does this happen with the driver's auto-mute feature?
Or it's triggered by user-space like pulseaudio / pipewire?
And, if it's drivers' auto-mute, setting spec->gen.auto_mute_via_amp
has any influence?


thanks,

Takashi


> 
>  sound/hda/codecs/conexant.c | 73 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
> index 5fcbc1312c69..f2f447ab749e 100644
> --- a/sound/hda/codecs/conexant.c
> +++ b/sound/hda/codecs/conexant.c
> @@ -43,6 +43,10 @@ struct conexant_spec {
>  	unsigned int gpio_mute_led_mask;
>  	unsigned int gpio_mic_led_mask;
>  	bool is_cx11880_sn6140;
> +
> +	/* Pop noise mitigation */
> +	struct hda_codec *codec;
> +	struct delayed_work pop_mitigation_work;
>  };
>  
>  
> @@ -212,10 +216,74 @@ static void cx_auto_shutdown(struct hda_codec *codec)
>  
>  static void cx_remove(struct hda_codec *codec)
>  {
> +	struct conexant_spec *spec = codec->spec;
> +
> +	cancel_delayed_work_sync(&spec->pop_mitigation_work);
>  	cx_auto_shutdown(codec);
>  	snd_hda_gen_remove(codec);
>  }
>  
> +static void mute_unmute_speaker(struct hda_codec *codec, hda_nid_t nid, bool mute)
> +{
> +	unsigned int conn_sel, dac, conn_list, gain_left, gain_right;
> +
> +	conn_sel = snd_hda_codec_read(codec, nid, 0, 0xf01, 0x0);
> +	conn_list = snd_hda_codec_read(codec, nid, 0, 0xf02, 0x0);
> +
> +	dac = ((conn_list >> (conn_sel * 8)) & 0xff);
> +	if (dac == 0)
> +		return;
> +
> +	gain_left = snd_hda_codec_read(codec, dac, 0, 0xba0, 0x0);
> +	gain_right = snd_hda_codec_read(codec, dac, 0, 0xb80, 0x0);
> +
> +	if (mute) {
> +		gain_left |= 0x80;
> +		gain_right |= 0x80;
> +	} else {
> +		gain_left &= (~(0x80));
> +		gain_right &= (~(0x80));
> +	}
> +
> +	snd_hda_codec_write(codec, dac, 0, 0x3a0, gain_left);
> +	snd_hda_codec_write(codec, dac, 0, 0x390, gain_right);
> +
> +	if (mute) {
> +		snd_hda_codec_write(codec, nid, 0, 0x707, 0);
> +		codec_dbg(codec, "mute_speaker, set 0x%x PinCtrl to 0.\n", nid);
> +	} else {
> +		snd_hda_codec_write(codec, nid, 0, 0x707, 0x40);
> +		codec_dbg(codec, "unmute_speaker, set 0x%x PinCtrl to 0x40.\n", nid);
> +	}
> +}
> +
> +static void pop_mitigation_worker(struct work_struct *work)
> +{
> +	struct conexant_spec *spec = container_of(work, struct conexant_spec,
> +			pop_mitigation_work.work);
> +	struct hda_codec *codec = spec->codec;
> +
> +	mute_unmute_speaker(codec, 0x17, false);
> +}
> +
> +static void cx_auto_pop_mitigation(struct hda_codec *codec,
> +		struct hda_jack_callback *event)
> +{
> +	struct conexant_spec *spec = codec->spec;
> +	int phone_present;
> +
> +	phone_present = snd_hda_codec_read(codec, 0x16, 0, 0xf09, 0x0);
> +	if (!(phone_present & 0x80000000)) {
> +		/* Headphone unplugged, mute speaker immediately */
> +		mute_unmute_speaker(codec, 0x17, true);
> +		/* Schedule unmute after 20ms delay */
> +		schedule_delayed_work(&spec->pop_mitigation_work, msecs_to_jiffies(20));
> +	} else {
> +		/* Headphone plugged in, cancel any pending unmute */
> +		cancel_delayed_work_sync(&spec->pop_mitigation_work);
> +	}
> +}
> +
>  static void cx_process_headset_plugin(struct hda_codec *codec)
>  {
>  	unsigned int val;
> @@ -1178,6 +1246,9 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
>  	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
>  	if (!spec)
>  		return -ENOMEM;
> +
> +	spec->codec = codec;
> +	INIT_DELAYED_WORK(&spec->pop_mitigation_work, pop_mitigation_worker);
>  	snd_hda_gen_spec_init(&spec->gen);
>  	codec->spec = spec;
>  
> @@ -1187,6 +1258,8 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
>  	case 0x14f11f87:
>  		spec->is_cx11880_sn6140 = true;
>  		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
> +		/* Enable pop noise mitigation for both codecs */
> +		snd_hda_jack_detect_enable_callback(codec, 0x16, cx_auto_pop_mitigation);
>  		break;
>  	}
>  
> -- 
> 2.25.1
> 

