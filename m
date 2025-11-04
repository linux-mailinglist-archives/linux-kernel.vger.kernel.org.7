Return-Path: <linux-kernel+bounces-884526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804DEC305F5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715AB3BD146
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2FC313271;
	Tue,  4 Nov 2025 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GbO+OX7l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5kp4RDr+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GbO+OX7l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5kp4RDr+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7E8296BD3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249828; cv=none; b=CSo/MS6ke0IN5ywjc+cW/lL/uKOWvRLW7GQUs+8hIJsP252U5SCmaXbJVTSAMrP7u/ykqHMyX4Av8VZ13QtS7tB12nb36FN7g4VRbj9HsX4XPpQu77pXemVVYoN08T9Lk8VOJlVy/dqialMpZgABkfwD3xLOISjgwCGXQrbVqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249828; c=relaxed/simple;
	bh=1UOHNO/Mi/HiNuPQq+hgxnBrFG85PWnm3d6+oN/2Hy0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSiBPtRiuObYpLs/WncSq2Ua5iYdYeIMCgmqrO3DsFurTlfAknTnl2pWxTB6z72MLt8LUInUvFOLiuPtoGccyg9pnt3WsjP70WFu8LPeLXFqmMpXzTtjB3KICg1kquNbHQRbveKeZ4fH7I+kKzDnax5bChle5Av64wYCa4gBZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GbO+OX7l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5kp4RDr+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GbO+OX7l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5kp4RDr+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E6271F385;
	Tue,  4 Nov 2025 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762249824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeCCumOciFLPQuXSWJwXSouB5HzPJhlo9Atjut+zRAM=;
	b=GbO+OX7ll48RTtKB34QgDdWWw6A02tRJbx9SsC2ML3avWutuSLFrMzaXKn7ZYgSbK3nqGX
	2ndzcy/eidICyYddQNz2sO5z7Rjfn82BuuyxVcWI8xGv09MlQ3rqs1C2G6CdERhp2lkw9k
	/jD5lBpTkHa5QoWJSE7peEL6e7ZdIJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762249824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeCCumOciFLPQuXSWJwXSouB5HzPJhlo9Atjut+zRAM=;
	b=5kp4RDr+9Q5EKogaOIoKwzTqAZi2Z1I78fPOxH5uKxf5f3IFasOqFbEbYBvxTRDhaVcMEx
	a2c4h5+Xh0rgjqDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762249824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeCCumOciFLPQuXSWJwXSouB5HzPJhlo9Atjut+zRAM=;
	b=GbO+OX7ll48RTtKB34QgDdWWw6A02tRJbx9SsC2ML3avWutuSLFrMzaXKn7ZYgSbK3nqGX
	2ndzcy/eidICyYddQNz2sO5z7Rjfn82BuuyxVcWI8xGv09MlQ3rqs1C2G6CdERhp2lkw9k
	/jD5lBpTkHa5QoWJSE7peEL6e7ZdIJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762249824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeCCumOciFLPQuXSWJwXSouB5HzPJhlo9Atjut+zRAM=;
	b=5kp4RDr+9Q5EKogaOIoKwzTqAZi2Z1I78fPOxH5uKxf5f3IFasOqFbEbYBvxTRDhaVcMEx
	a2c4h5+Xh0rgjqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20001136D1;
	Tue,  4 Nov 2025 09:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LSNpBmDMCWnfLwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Nov 2025 09:50:24 +0000
Date: Tue, 04 Nov 2025 10:50:23 +0100
Message-ID: <875xbqi0tc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: hariconscious@gmail.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	mingo@kernel.org,
	tglx@linutronix.de,
	thorsten.blum@linux.dev,
	mengdewei@cqsoftware.com.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: timer: Fix null dereference of 'timer->card' reported by smatch
In-Reply-To: <20251103114902.11423-2-hariconscious@gmail.com>
References: <20251103114902.11423-2-hariconscious@gmail.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,kernel.org,gmail.com,linutronix.de,linux.dev,cqsoftware.com.cn,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Mon, 03 Nov 2025 12:49:03 +0100,
hariconscious@gmail.com wrote:
> 
> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> Fix null dereference in snd_timer_proc_read().
> 
> Smatch reported that  was previously assumed to be null
> at line 1226, but later accessed without a check.
> This could lead to a null pointer dereference under certain conditions.
> 
> Add a null check before accessing to ensure safe execution.
> 
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> ---
> This patch addresses a null pointer dereference in snd_timer_proc_read()
> by adding a proper check for timer->card.The issue was flagged by Smatch,
> which noted that timer->card was previously assumed to be null at
> line 1226 but accessed without validation.To ensure safe access, a
> conditional check has been introduced before referencing timer->card.
> The fix was verified by booting the kernel and performing audio playback
> using ALSA commands. Additionally, the /proc/asound/timers
> interface was inspected to confirm that timer information is
> correctly populated and accessible without errors.
> Note: Couldn't simulate a scenario where 'timer->card' is null and
> 'timer->card->shutdown' is 1 (shutdown initiated).

timer->card is guaranteed to be non-NULL for SNDRV_TIMER_CLASS_CARD
timer->and SNDRV_TIMER_CLASS_PCM at the creation in snd_timer_new().
So this check is superfluous.


thanks,

Takashi

> 
>  sound/core/timer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/core/timer.c b/sound/core/timer.c
> index d9fff5c87613..d65e8bcb2f46 100644
> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -1231,10 +1231,11 @@ static void snd_timer_proc_read(struct snd_info_entry *entry,
>  			break;
>  		case SNDRV_TIMER_CLASS_CARD:
>  			snd_iprintf(buffer, "C%i-%i: ",
> -				    timer->card->number, timer->tmr_device);
> +				    timer->card ? timer->card->number : -1, timer->tmr_device);
>  			break;
>  		case SNDRV_TIMER_CLASS_PCM:
> -			snd_iprintf(buffer, "P%i-%i-%i: ", timer->card->number,
> +			snd_iprintf(buffer, "P%i-%i-%i: ",
> +				    timer->card ? timer->card->number : -1,
>  				    timer->tmr_device, timer->tmr_subdevice);
>  			break;
>  		default:
> 
> base-commit: 6093a688a07da07808f0122f9aa2a3eed250d853
> -- 
> 2.43.0
> 

