Return-Path: <linux-kernel+bounces-892546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB90C45537
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF923B3546
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60F32F7ABA;
	Mon, 10 Nov 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X+CraUtY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w4ytOpwL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yVVsWHy4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QUue0kzI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DD221D92
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762458; cv=none; b=Rze2JWMuc/7o3zcUn/wWKLVDp8kJXJivsOnhSj/xmY63ZVNCJr27bTRlwZSs9a9gaMhgj7WzPDbRZpRNDQ1sWLkYRuOqkVF28srgy89YmoH2LqaNWx4aLDFDidOOfTNpruQX7IyUrOL44PQ7mRqmyh2pL3kljpspjcTqjj3qqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762458; c=relaxed/simple;
	bh=nmtfVvbzGml762p/PglmSztpK5U0oN717knAKcptlGo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNj5wiJnvKY1EYr/i/7WoMBs+grgqZczPH7nl5lwt6T5EYsd85wefAm6rgNjDb0UUF0mf88GMf9xtLmcwUiJO9+YKH9aDC5duWRdp1MJ6qS10EckxGSslkMw4d4Fj6nbuGU9Q71zVhlq1gjp0chLTOwWR7pRdFi77xsi28R/ppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X+CraUtY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w4ytOpwL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yVVsWHy4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QUue0kzI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 621771F399;
	Mon, 10 Nov 2025 08:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762762454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1sh5TmGoz6Jgc/8yxa7Z0cN9cWHOtB+XEJ7MN02YQ0=;
	b=X+CraUtYEnj5d2o57jTQqWsqtuF5/mSgSlPRZhtlw/M2NkgxLG7qIgQbGkntn9Df2yrWXV
	PtoO8tRzyjvIaC+G5bp26jlfKC+MK5mXG4o9doRUeC12HA8gvkC0G1SrbB+dK3Ja7eFWNf
	osy0j/zS7S1DGUx+qmd9pBLMgMOH/ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762762454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1sh5TmGoz6Jgc/8yxa7Z0cN9cWHOtB+XEJ7MN02YQ0=;
	b=w4ytOpwLHgPAeMgalPau+4o4NKbcJYxSmA7kqR3ji8t9s0VUYMniEi4x313XRWBoW7JmZL
	qobSq8dDqo/ozDAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yVVsWHy4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QUue0kzI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762762453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1sh5TmGoz6Jgc/8yxa7Z0cN9cWHOtB+XEJ7MN02YQ0=;
	b=yVVsWHy4USkZSr8H6dbCqxMmzZ2ORvSyqHdmZPMVGQEiedy7H+5ckHlVNOZFp+xovassFJ
	BNY6u1dJj/fcE0q1xKnRyPy52/ltj0NmNP3JkJBvnuXihlBNZ0GRAUBtVdWCktiNnGmZuY
	//T+sYF0+V1SUzXZnXX1t99YwLHzfGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762762453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1sh5TmGoz6Jgc/8yxa7Z0cN9cWHOtB+XEJ7MN02YQ0=;
	b=QUue0kzIYLwecTRF8IFmE5sw9X6lHIcl2wzAdiyxNPbVD2+4xycZd+xiEZ7nloIn7Bt9Fe
	xSsCeAbBQKA5cPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1109413BA4;
	Mon, 10 Nov 2025 08:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uVGTAtWeEWk7HwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 10 Nov 2025 08:14:13 +0000
Date: Mon, 10 Nov 2025 09:14:12 +0100
Message-ID: <87pl9qxq23.wl-tiwai@suse.de>
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
Subject: Re: [PATCH] ALSA: hda/realtek: Fix resource cleanup in alc_alloc_spec error path
In-Reply-To: <20251110072349.102169-1-wangdich9700@163.com>
References: <20251110072349.102169-1-wangdich9700@163.com>
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
X-Rspamd-Queue-Id: 621771F399
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,intel.com,vger.kernel.org,lists.infradead.org,kylinos.cn];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Mon, 10 Nov 2025 08:23:49 +0100,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdicheng@kylinos.cn>
> 
> Ensure proper resource cleanup when alc_codec_rename_from_preset() fails
> in alc_alloc_spec(). Currently, the error path only calls kfree(spec) but
> does not:
> 
> 1. Destroy the initialized coef_mutex mutex

It's rather an optional operation.  As of the probing phase, there is
really no much race, after all.
(And, it's not handled properly in your patch, either...)

> 2. Reset codec->spec to NULL, potentially leaving a dangling pointer

This is done in snd_hda_codec_cleanup_for_unbind() called in the error
handling of hda_codec_driver_probe().


thanks,

Takashi

> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
> ---
>  sound/hda/codecs/realtek/realtek.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/hda/codecs/realtek/realtek.c b/sound/hda/codecs/realtek/realtek.c
> index ca377a5adadb..9a358c072e50 100644
> --- a/sound/hda/codecs/realtek/realtek.c
> +++ b/sound/hda/codecs/realtek/realtek.c
> @@ -1029,6 +1029,7 @@ int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
>  {
>  	struct alc_spec *spec = kzalloc(sizeof(*spec), GFP_KERNEL);
>  	int err;
> +	bool mutex_initialized = false;
>  
>  	if (!spec)
>  		return -ENOMEM;
> @@ -1040,14 +1041,22 @@ int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
>  	/* FIXME: do we need this for all Realtek codec models? */
>  	codec->spdif_status_reset = 1;
>  	codec->forced_resume = 1;
> +
>  	mutex_init(&spec->coef_mutex);
>  
>  	err = alc_codec_rename_from_preset(codec);
>  	if (err < 0) {
> -		kfree(spec);
> -		return err;
> +		codec_err(codec, "Failed to rename codec: %d\n", err);
> +		goto error;
>  	}
>  	return 0;
> +
> +error:
> +	if (mutex_initialized)
> +		mutex_destroy(&spec->coef_mutex);
> +	codec->spec = NULL;
> +	kfree(spec);
> +	return err;
>  }
>  EXPORT_SYMBOL_NS_GPL(alc_alloc_spec, "SND_HDA_CODEC_REALTEK");
>  
> -- 
> 2.25.1
> 

