Return-Path: <linux-kernel+bounces-888205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84624C3A2FA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98F774FFAEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A3330FF24;
	Thu,  6 Nov 2025 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ltX8MbQa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sy1bMSgR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="leFc1KCW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sTlomgEk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A42DC784
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423586; cv=none; b=KIOiFvAkp0pVU2KwV6elTuVdtX/wM5seheVdMRbZgBRIfBobdAK5eUWYEyhfOxmV3Aq7QmlESIazEDOAFSCP9nxFhRziq7WgDcBNbyPi/RuELBPJQaarUAcF9cDOTMwSd5lI61y1ZZvCa7BDKKx8PvR4ofYlfu7Ls9oBZ7MdIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423586; c=relaxed/simple;
	bh=I0MJBcmdkYPp3l1kvLV6d/G7Rj5nqzS08z07pJzmZvI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqgBO8KBUHMWavrozkNia4QBiInCcWOo6ffsW46qPZzQW8texPYq3hvceqqUNN7NT11k6soIFXPi4XMCHm46zHowXBwLfqC7RxuGSnFLYkstf1zjjq/281+3L9etlh82E2nN1izCG6r1BXka4gm0L2S80tpiDiCktfx2SESxSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ltX8MbQa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sy1bMSgR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=leFc1KCW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sTlomgEk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A43C61F393;
	Thu,  6 Nov 2025 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jvi0Iaf+/csCxjpFObwc35qa1a6MdGB2jlu9D0Jc6o8=;
	b=ltX8MbQagWfvLsNl88IH7CgBOrmXbE9fiDKw/x+3Fcxv9TqNLCwtUzdFj5+2nWZpvmxtLb
	J9Zw7+HmJRxu0nQJuI8WsT+p0hlJzQc3+aEbEgJWmCv0V6cUBs7ZakZIV600v34IlF+nAT
	o1XA+YTX6zaCBszJObTATgsk30lIkzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jvi0Iaf+/csCxjpFObwc35qa1a6MdGB2jlu9D0Jc6o8=;
	b=sy1bMSgRgyAB+LGwwMJRnEY67MNpNlP8EuFB9HEmmNrIzRfus/6UscSinDZNaCNi+ThRdW
	vtUOXArfmFCbrGCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jvi0Iaf+/csCxjpFObwc35qa1a6MdGB2jlu9D0Jc6o8=;
	b=leFc1KCWzrresVwOiVLInOC4KGk1bsGrDlDllzKNISAJb/+i6G1aFoR/ak+l1lBXAmdm1X
	gIrD4FIJNAOAVI737lQqyhroP3cNux7zo4IxpgBggAzbRBqncoQ2ToO9eNS+t821Ds+Dgf
	zQwWU6Os5j7+vqqxdUvzIUk6/cX5ZSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jvi0Iaf+/csCxjpFObwc35qa1a6MdGB2jlu9D0Jc6o8=;
	b=sTlomgEkfuMVNE4KRWvDNUd4P+3yydTHjgUIIW668nzMQbSe0CmwePUBEVIN4AuXInG0H1
	BT5DqtXeKjQ7klCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 613E313A31;
	Thu,  6 Nov 2025 10:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J9JPFh1zDGmCOwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 10:06:21 +0000
Date: Thu, 06 Nov 2025 11:06:21 +0100
Message-ID: <874ir7h3vm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdich9700@163.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH] ALSA: hda/senary: Fix potential resource leak in set_beep_amp
In-Reply-To: <20251106063546.115197-1-wangdich9700@163.com>
References: <20251106063546.115197-1-wangdich9700@163.com>
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org,lists.infradead.org,kylinos.cn];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Thu, 06 Nov 2025 07:35:46 +0100,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdich9700@163.com>
> 
> Add proper error handling in set_beep_amp function to avoid potential
> resource leaks when snd_hda_gen_add_kctl fails.
> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>

Please align both From and Signed-off-by addresses.
And in this patch...

> ---
>  sound/hda/codecs/senarytech.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/hda/codecs/senarytech.c b/sound/hda/codecs/senarytech.c
> index 9aa1e9bcd9ec..99af8d5e51db 100644
> --- a/sound/hda/codecs/senarytech.c
> +++ b/sound/hda/codecs/senarytech.c
> @@ -47,17 +47,28 @@ static int set_beep_amp(struct senary_spec *spec, hda_nid_t nid,
>  {
>  	struct snd_kcontrol_new *knew;
>  	unsigned int beep_amp = HDA_COMPOSE_AMP_VAL(nid, 1, idx, dir);
> -	int i;
> +	int i, err;
>  
>  	spec->gen.beep_nid = nid;
>  	for (i = 0; i < ARRAY_SIZE(senary_beep_mixer); i++) {
>  		knew = snd_hda_gen_add_kctl(&spec->gen, NULL,
>  					    &senary_beep_mixer[i]);
> -		if (!knew)
> -			return -ENOMEM;
> +		if (!knew) {
> +			err = -ENOMEM;
> +			goto error;
> +		}
>  		knew->private_value = beep_amp;
>  	}
>  	return 0;
> +
> +error:
> +	/* Clean up any successfully added controls */
> +	while (i-- > 0) {
> +		/* The gen spec will be cleaned up in senary_remove,
> +		 * so we don't need individual cleanup here
> +		 */
> +	}
> +	return err;
>  }

So the "error handling" you added is just an empty loop.
What really does this patch "fix"?
As of this, it looks like just adding some garbage.


thanks,

Takashi

