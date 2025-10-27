Return-Path: <linux-kernel+bounces-871191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDAC0C986
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3245D19A4816
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D62367B5;
	Mon, 27 Oct 2025 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jf+wOeo7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WqgEE3C3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jf+wOeo7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WqgEE3C3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B58134BD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556172; cv=none; b=mN7QoSDz2l2WMJzKXNL/TddgiA5+S1qN4v5qGtEvSf1tgLbo7vP4HzTH+2gmL3SmqebAs2YOl/zS3Jsy3dm2B3/92Rui+xcxvHhrB/L39LL7ZVy2OnaVyOEBshZ4SRflwlMQxyU4cR/psM5BTyHg549Dio68gVIm3gy4TtpqDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556172; c=relaxed/simple;
	bh=Gtcui8dqa/qQGi4qt9IgdDczsIPejIwG0darUD5Wml0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kui3IU47r5XX0+GlHXReqck1BKJWZD1d6SMupZm9EXGYyqGbqGvo/g1mqHU4db65Lhd5Qnp7g37Ux7IF1JAtjxTM8zHU6WoL7WvYlT5rfFQ4o1Qwvd1J2Paxm9U8n58es6QWKc4ZbPpGK23TstyOosDLAv1cqt0jxpr9zuwchpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jf+wOeo7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WqgEE3C3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jf+wOeo7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WqgEE3C3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34A471F385;
	Mon, 27 Oct 2025 09:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761556169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vul14eerM87A+4Tvr8jejTW2bah93jw1wD7M5xM7ZQY=;
	b=jf+wOeo7ATSQ5XpsC9xOboLrFdt0Pa8ta2NJrojjXM0oW/lG2E8P7/weFDpqqIfdI6Iuql
	mUj6nt3+fE82yK5StKL4n1adnwUrZiVMYq1jIDy+zT7sLIwrFD4MoMXQ2rwRH+OFa04qFD
	lND44gEtdcBevzsSWDdEkFZIe7y/mUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761556169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vul14eerM87A+4Tvr8jejTW2bah93jw1wD7M5xM7ZQY=;
	b=WqgEE3C3lGqeTL8PcGF8a7WnTr3m70gVe/zC49oTIIpF7rjBYMDvLMtT0Q8P6bhhy10SAI
	u67knSb7BOUhoIDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jf+wOeo7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WqgEE3C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761556169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vul14eerM87A+4Tvr8jejTW2bah93jw1wD7M5xM7ZQY=;
	b=jf+wOeo7ATSQ5XpsC9xOboLrFdt0Pa8ta2NJrojjXM0oW/lG2E8P7/weFDpqqIfdI6Iuql
	mUj6nt3+fE82yK5StKL4n1adnwUrZiVMYq1jIDy+zT7sLIwrFD4MoMXQ2rwRH+OFa04qFD
	lND44gEtdcBevzsSWDdEkFZIe7y/mUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761556169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vul14eerM87A+4Tvr8jejTW2bah93jw1wD7M5xM7ZQY=;
	b=WqgEE3C3lGqeTL8PcGF8a7WnTr3m70gVe/zC49oTIIpF7rjBYMDvLMtT0Q8P6bhhy10SAI
	u67knSb7BOUhoIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6FAB136CF;
	Mon, 27 Oct 2025 09:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a8VDK8g2/2hwSAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 Oct 2025 09:09:28 +0000
Date: Mon, 27 Oct 2025 10:09:28 +0100
Message-ID: <87frb43e47.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 04/21] ALSA: rename BITS to R_BITS
In-Reply-To: <20251025162858.305236-5-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
	<20251025162858.305236-5-yury.norov@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 34A471F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 

On Sat, 25 Oct 2025 18:28:40 +0200,
Yury Norov (NVIDIA) wrote:
> 
> In preparation for adding generic BITS() macro, rename the local one.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

I suppose it'll be taken together with other patches?
If so,

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

> ---
>  sound/core/oss/rate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/core/oss/rate.c b/sound/core/oss/rate.c
> index b56eeda5e30e..90a40221e4ce 100644
> --- a/sound/core/oss/rate.c
> +++ b/sound/core/oss/rate.c
> @@ -25,8 +25,8 @@
>  #include "pcm_plugin.h"
>  
>  #define SHIFT	11
> -#define BITS	(1<<SHIFT)
> -#define R_MASK	(BITS-1)
> +#define R_BITS	(1<<SHIFT)
> +#define R_MASK	(R_BITS-1)
>  
>  /*
>   *  Basic rate conversion plugin
> @@ -104,7 +104,7 @@ static void resample_expand(struct snd_pcm_plugin *plugin,
>  					src += src_step;
>  				}
>  			}
> -			val = S1 + ((S2 - S1) * (signed int)pos) / BITS;
> +			val = S1 + ((S2 - S1) * (signed int)pos) / R_BITS;
>  			if (val < -32768)
>  				val = -32768;
>  			else if (val > 32767)
> @@ -162,7 +162,7 @@ static void resample_shrink(struct snd_pcm_plugin *plugin,
>  			}
>  			if (pos & ~R_MASK) {
>  				pos &= R_MASK;
> -				val = S1 + ((S2 - S1) * (signed int)pos) / BITS;
> +				val = S1 + ((S2 - S1) * (signed int)pos) / R_BITS;
>  				if (val < -32768)
>  					val = -32768;
>  				else if (val > 32767)
> @@ -191,7 +191,7 @@ static snd_pcm_sframes_t rate_src_frames(struct snd_pcm_plugin *plugin, snd_pcm_
>  		return 0;
>  	data = (struct rate_priv *)plugin->extra_data;
>  	if (plugin->src_format.rate < plugin->dst_format.rate) {
> -		res = (((frames * data->pitch) + (BITS/2)) >> SHIFT);
> +		res = (((frames * data->pitch) + (R_BITS/2)) >> SHIFT);
>  	} else {
>  		res = DIV_ROUND_CLOSEST(frames << SHIFT, data->pitch);
>  	}
> @@ -226,7 +226,7 @@ static snd_pcm_sframes_t rate_dst_frames(struct snd_pcm_plugin *plugin, snd_pcm_
>  	if (plugin->src_format.rate < plugin->dst_format.rate) {
>  		res = DIV_ROUND_CLOSEST(frames << SHIFT, data->pitch);
>  	} else {
> -		res = (((frames * data->pitch) + (BITS/2)) >> SHIFT);
> +		res = (((frames * data->pitch) + (R_BITS/2)) >> SHIFT);
>  	}
>  	if (data->old_dst_frames > 0) {
>  		snd_pcm_sframes_t frames1 = frames, res1 = data->old_src_frames;
> -- 
> 2.43.0
> 

