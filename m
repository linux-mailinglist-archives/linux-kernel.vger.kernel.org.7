Return-Path: <linux-kernel+bounces-841059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B9CBB6281
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFB3D4E7E49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124E323D7E2;
	Fri,  3 Oct 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bEgpKn8Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="28LT4I65";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hIVPvxtC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="erQ5Zm9p"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9DB23AE9B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476112; cv=none; b=YHzXubDC6vR8CnvwX3jH1Dhir99l9zsC2m3dvMuL+3dAObQSjt3NwX0ibkQ5b167nErXAyhUorqgO2tDfxvMeXMVtr0GXifRAZVcEdvDOBNk64ohZm6V2BfYO6/Ko3bLrd3g8L6zSuW1kAEq+V0kYURiWpCb5TPDYPzxwgLBJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476112; c=relaxed/simple;
	bh=MF1ojK1e4qTMJpyC4kVXvIjqRe+VO3XJwjd/QevRJoA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQnAXhWP2STS3Pozam2xULfGoL5PkIyrQqdejCn+5SwOhhKgqsFJXFzQHAGBhlyl0nkjYCzjDI03ozleqWQPG/t/1Mh7he0Hy6j+JD2DSQ6CMqBIldgseTCyBeJ0v9VAsawthlbCfyjpbnBMv8pwmOcsvimoRTVU56/cbJk1seM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bEgpKn8Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=28LT4I65; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hIVPvxtC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=erQ5Zm9p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9132A33867;
	Fri,  3 Oct 2025 07:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759476098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvh/zyAvQe8sgpRHWRg4gdaK+6SZnI8zSJs6AZ9Y4ek=;
	b=bEgpKn8YpLSM/tYGoMKlyb4H+dntsKVt9+39JEoI8AOg2194BxQSqO4XTDDGTK+ZZQBsCR
	jCE2AKbjagTUsoQ8AuJSeB6nfhTDNr4lW1JWCDfA4+yM6Mp3p3NDGX3s0iUXlGteTINhgy
	h728Cg/FoJfzzZm9yrljsRfXkqlGRtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759476098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvh/zyAvQe8sgpRHWRg4gdaK+6SZnI8zSJs6AZ9Y4ek=;
	b=28LT4I65u+jCEfNlAo1sbNYBCNmowf3FR8UouoFQ3VC01A5s6dR8FKi7bSK1DydgfIWIez
	b5xedf4t0axH07DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759476097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvh/zyAvQe8sgpRHWRg4gdaK+6SZnI8zSJs6AZ9Y4ek=;
	b=hIVPvxtCG/If+Fwu9Ubyu8IgeMBQVsPY0+ouRZonojzpoAVVkG9n6XOCwqa35ww247NbRg
	PWJLwfoqGYPiQplLbCI7JtksrqnQ72iuFup6/RBxUvQFqNlHEhGHTzVLE2HGro92le+Ae7
	kweeBMbGJ+aS0VyDqf3otfGgdUDYZIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759476097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvh/zyAvQe8sgpRHWRg4gdaK+6SZnI8zSJs6AZ9Y4ek=;
	b=erQ5Zm9pRiHHHekinY7lZjDUJMrLMiHsJfDfsg3ApUb3ZzN/4fOs00BlqeP16tDOP8zn8f
	ewgIW+7hgF3QwuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 502B913990;
	Fri,  3 Oct 2025 07:21:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vrTzEYF532iyXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 Oct 2025 07:21:37 +0000
Date: Fri, 03 Oct 2025 09:21:36 +0200
Message-ID: <87o6qoh2m7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: hariconscious@gmail.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/core/seq: Initialize structure pointer to NULL to prevent undefined behavior
In-Reply-To: <20251002174301.15512-1-hariconscious@gmail.com>
References: <20251002174301.15512-1-hariconscious@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,kernel.org,gmail.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Thu, 02 Oct 2025 19:43:00 +0200,
hariconscious@gmail.com wrote:
> 
> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> This change ensures the structure pointer is explicitly initialized to
> NULL,preventing potential access to uninitialized memory. It improves
> code safety and avoids undefined behavior during pointer dereferencing.
> 
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> ---
> 
> Note:
> Turned on the settings needed for sequencer MIDI and built a kernel
> image with those settings. The system booted up fine with no errors.
> However, couldn¢t get the sequencer emulation to start.

Something really wrong in your test, I'm afraid.
See your patch below more closely:

> 
>  sound/core/seq/seq_midi_emul.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/core/seq/seq_midi_emul.c b/sound/core/seq/seq_midi_emul.c
> index 81d2ef5e5811..f24c5a475c41 100644
> --- a/sound/core/seq/seq_midi_emul.c
> +++ b/sound/core/seq/seq_midi_emul.c
> @@ -647,7 +647,7 @@ static void snd_midi_channel_init(struct snd_midi_channel *p, int n)
>   */
>  static struct snd_midi_channel *snd_midi_channel_init_set(int n)
>  {
> -	struct snd_midi_channel *chan;
> +	struct snd_midi_channel *chan = NULL;
>  	int  i;
>  
>  	chan = kmalloc_array(n, sizeof(struct snd_midi_channel), GFP_KERNEL);

The variable chan is initialized at the very beginning.
NULL initialization is utterly nonsense.

> @@ -686,7 +686,7 @@ reset_all_channels(struct snd_midi_channel_set *chset)
>   */
>  struct snd_midi_channel_set *snd_midi_channel_alloc_set(int n)
>  {
> -	struct snd_midi_channel_set *chset;
> +	struct snd_midi_channel_set *chset = NULL;
>  
>  	chset = kmalloc(sizeof(*chset), GFP_KERNEL);

Here, too.

So all changes make really no sense.


thanks,

Takashi

