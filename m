Return-Path: <linux-kernel+bounces-732949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152FEB06E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C37916F59F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E91A2877D9;
	Wed, 16 Jul 2025 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rtVhAxQ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qMoNayro";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rtVhAxQ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qMoNayro"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE60285404
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647725; cv=none; b=QDVO/2BcHhPHme/oHTxgeIWevM3PJ5Sg9+Gb/E3pqyuzF23BwLMFzHMGZ3/vGPaVrVu/NFNkOvKuFgGA9zJaPzfKee7dDzitbo1+/O5ZTnwlfrQKEorJ4lUMfutJ79QCXmVyGPhA2arZKHdyGY6/0bL+KplHsJLMA8NPPw16wKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647725; c=relaxed/simple;
	bh=WiihEydFxy7tsIuJydHJky6M+1qWAbvXlZGIPuFpyTQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9omUPGt6nw/0bAG+IRa1aW9NcdpBuDvnd1/BolXmN1d3Ltawswah5E7rF/B9ZMjghzzCPFpYhQjqVBrH7xRke2XMMdtCuPB6QV1IGJqWcf9l5GX15CRu1WxACDLdw6MR7UCeU1uIIyr6znNny8YJOEDwxdGa56YanLAum7YZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rtVhAxQ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qMoNayro; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rtVhAxQ0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qMoNayro; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0160921233;
	Wed, 16 Jul 2025 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752647722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alMo+CkPlqJsaxDmO1REexawjtJx6vWckzUN7h2I58M=;
	b=rtVhAxQ0DDi2A5yzWJJnZcGVbAs5CwPuqaz54/rJh63lc40YBQTkZHOY0aqZVEejoRc1PG
	1HOefQtzsAqgKdAyfko7M+/3Y+kzehCWyApXlzRj4L3asVDxvckGWYQvlIcb6Li/XzO+AE
	ZffWGfgJ0FwJkYDyknLKWj17e0qzg5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752647722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alMo+CkPlqJsaxDmO1REexawjtJx6vWckzUN7h2I58M=;
	b=qMoNayroj4gFIwGbw5LVdbDRHVNbl8B2xNxwLt1XBWoTwX9yvMkJA5dMTAATpN07yVDYPQ
	9LHpUjeKhOaOdrBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752647722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alMo+CkPlqJsaxDmO1REexawjtJx6vWckzUN7h2I58M=;
	b=rtVhAxQ0DDi2A5yzWJJnZcGVbAs5CwPuqaz54/rJh63lc40YBQTkZHOY0aqZVEejoRc1PG
	1HOefQtzsAqgKdAyfko7M+/3Y+kzehCWyApXlzRj4L3asVDxvckGWYQvlIcb6Li/XzO+AE
	ZffWGfgJ0FwJkYDyknLKWj17e0qzg5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752647722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alMo+CkPlqJsaxDmO1REexawjtJx6vWckzUN7h2I58M=;
	b=qMoNayroj4gFIwGbw5LVdbDRHVNbl8B2xNxwLt1XBWoTwX9yvMkJA5dMTAATpN07yVDYPQ
	9LHpUjeKhOaOdrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C390B138D2;
	Wed, 16 Jul 2025 06:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LNIGLilId2jYbQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 16 Jul 2025 06:35:21 +0000
Date: Wed, 16 Jul 2025 08:35:21 +0200
Message-ID: <87tt3c8wye.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr
Subject: Re: [PATCH] staging: sound: Adjust mutex unlock order
In-Reply-To: <20250716062331.375090-1-karanja99erick@gmail.com>
References: <20250716062331.375090-1-karanja99erick@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Wed, 16 Jul 2025 08:23:30 +0200,
Erick Karanja wrote:
> 
> The mutexes qdev_mutex and chip->mutex are acquired in that order
> throughout the driver. To preserve proper lock hierarchy and avoid
> potential deadlocks, they must be released in the reverse order
> of acquisition.
> 
> This change reorders the unlock sequence to first release chip->mutex
> followed by qdev_mutex, ensuring consistency with the locking pattern.
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  sound/usb/qcom/qc_audio_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
> index 3543b5a53592..ef144d2be7d2 100644
> --- a/sound/usb/qcom/qc_audio_offload.c
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -825,8 +825,8 @@ static int uaudio_sideband_notifier(struct usb_interface *intf,
>  		}
>  	}
>  
> -	mutex_unlock(&qdev_mutex);
>  	mutex_unlock(&chip->mutex);
> +	mutex_unlock(&qdev_mutex);
>  
>  	return 0;
>  }

The same pattern is found in qc_usb_audio_offload_disconnect() and
qc_usb_audio_offload_suspend(), too.
Care to address there as well?

Maybe it's better to replace with guard stuff, but it should be done
by another patch in later kernel releases.


thanks,

Takashi

