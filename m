Return-Path: <linux-kernel+bounces-740585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EAB0D611
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FA31755A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2342DCF77;
	Tue, 22 Jul 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZMlSY12o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="26VzZVir";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZMlSY12o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="26VzZVir"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33A28A1ED
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177135; cv=none; b=Xoue9cXkFwOE8Nqs8ItIG5C9wsQQQucoI2qVmKfKd6KXxibNO6NWlctZjgz35o9JmMkbJUMTZQSOdgf3ywWP8LMBFk9a/jRYbEp6sq3tTuvXUY6I4sbFdTdgyPWvskMF2oPEk28jvBGjrpB8pn2nGazkmykvZOIhjUWqfVPilJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177135; c=relaxed/simple;
	bh=Xyk0jcwD15euS1z3ItogSFyVK6+29Yaj004qwAqolPU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPACiCGq727tml4zUtlf8FbS1PfWjX4MfHK7nz2yvUQwMTvNmnBp0tnayouArhH+OXAZlaGvBxqfOjQHsoAq3dAOe4RST70SoETsL0w7jGhV2e9F9t5b5qLpCJsKeYG+6eu789KOs2Uo7svqa2UvCPiQ34joK41qL74KzyacXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZMlSY12o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=26VzZVir; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZMlSY12o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=26VzZVir; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70E881F785;
	Tue, 22 Jul 2025 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753177130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgWmGxZiWSqJ+I6Z5+BpJDEDvM5KgJywCe3kOSoHUbM=;
	b=ZMlSY12oPv8+jmGYopD9s4FKajkwG3iJJdWrbX4iUfoR2/5FRKOaB6TaI71aiX1n3lqux+
	cQp7M2HgfGFBR8/Uiil2d3hbmn+qBfq1MruPoW/+jqJhG3SjAto8TByC7/Qnt0hlG2Y1EG
	uvrfgmAI7ULWaZEsZLaWu+OKXdRaHEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753177130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgWmGxZiWSqJ+I6Z5+BpJDEDvM5KgJywCe3kOSoHUbM=;
	b=26VzZVirgjGUcFZGgAK3ejygmFRcxmh9k7mKX1dYJbt4apNJjXeiK3CFwPfn+EU+mUSwFD
	QUIvUxCoBUtViQBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZMlSY12o;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=26VzZVir
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753177130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgWmGxZiWSqJ+I6Z5+BpJDEDvM5KgJywCe3kOSoHUbM=;
	b=ZMlSY12oPv8+jmGYopD9s4FKajkwG3iJJdWrbX4iUfoR2/5FRKOaB6TaI71aiX1n3lqux+
	cQp7M2HgfGFBR8/Uiil2d3hbmn+qBfq1MruPoW/+jqJhG3SjAto8TByC7/Qnt0hlG2Y1EG
	uvrfgmAI7ULWaZEsZLaWu+OKXdRaHEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753177130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgWmGxZiWSqJ+I6Z5+BpJDEDvM5KgJywCe3kOSoHUbM=;
	b=26VzZVirgjGUcFZGgAK3ejygmFRcxmh9k7mKX1dYJbt4apNJjXeiK3CFwPfn+EU+mUSwFD
	QUIvUxCoBUtViQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C60813A32;
	Tue, 22 Jul 2025 09:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gXsBFipcf2gKJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 22 Jul 2025 09:38:50 +0000
Date: Tue, 22 Jul 2025 11:38:50 +0200
Message-ID: <87ms8wo991.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ALSA: usb-audio: qcom: Adjust mutex unlock order
In-Reply-To: <20250721114554.1666104-1-karanja99erick@gmail.com>
References: <20250721114554.1666104-1-karanja99erick@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 70E881F785
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Mon, 21 Jul 2025 13:45:53 +0200,
Erick Karanja wrote:
> 
> The mutexes qdev_mutex and chip->mutex are acquired in that order
> throughout the driver. To preserve proper lock hierarchy and avoid
> potential deadlocks, they must be released in the reverse
> order of acquisition.
> 
> This change reorders the unlock sequence to first release chip->mutex
> followed by qdev_mutex, ensuring consistency with the locking pattern.
> 
> Fixes: 326bbc348298a ("ALSA: usb-audio: qcom: Introduce QC USB
>                       SND offloading support")

This has to be a single line without folding.

> changes since v3:
>  - Add the correct fixes tag.
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  sound/usb/qcom/qc_audio_offload.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
> index 3543b5a53592..711f5612a83a 100644
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
> @@ -1865,8 +1865,8 @@ static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
>  
>  	/* Device has already been cleaned up, or never populated */
>  	if (!dev->chip) {
> -		mutex_unlock(&qdev_mutex);
>  		mutex_unlock(&chip->mutex);
> +		mutex_unlock(&qdev_mutex);
>  		return;
>  	}
>  
> @@ -1921,8 +1921,8 @@ static void qc_usb_audio_offload_suspend(struct usb_interface *intf,
>  
>  	uaudio_send_disconnect_ind(chip);
>  
> +        mutex_unlock(&chip->mutex);
>  	mutex_unlock(&qdev_mutex);
> -	mutex_unlock(&chip->mutex);

The above used spaces instead of tabs, and I corrected in my side.
Such a failure could be spotted out by running scripts/checkpatch.pl.
At the next time, please run and test it before submissions.

In anyway, I applied the patch now.


thanks,

Takashi

