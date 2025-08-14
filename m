Return-Path: <linux-kernel+bounces-768212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BA4B25E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A498175DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0897E2E613D;
	Thu, 14 Aug 2025 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jx/+p6Cz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1KxjGCGh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eox4opzr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zsPRxrq/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE02E5437
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158607; cv=none; b=GvZbYjZ4D17f3ihOH3Cxv7fsMf8ebjLqhjqlIgzvbRsa4pAprfi500LYqijb8lM1Bpr2ePU4/mDzR3k//+6KMWZgNOJKETjWfbwWCRTIqjZ4mIq9FKREKSD2AX6ZUQDr6H2FtFRdmlT2bigKMK1UKAD7kOi+JOv3spfDfmCaOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158607; c=relaxed/simple;
	bh=s6/hnmcN04cU2TOT762i+HEcwdgbhWuHlBGmU3vUhMw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qodYk258vrng0hUvQ5xGv5cxCQZxhOgfzojxBJhV/kn8ak+MpQIfuaHFhRlzsN9FRyoH3pOvyVz1C/gVScedmTF/gR1wnDwJRyFjcRCVkxDQwukQGGl1R4/90/P5oKI8z2cfKtk+voMnMqzdTGd75FsZlWbQOzTNQWZZQq/oyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jx/+p6Cz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1KxjGCGh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eox4opzr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zsPRxrq/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE79E1F7CB;
	Thu, 14 Aug 2025 08:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755158604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlimYzKPsCEda21QkYMD52T/yxbElWfMlAcYmFen9S4=;
	b=Jx/+p6CzPqXSGWIrxDQhHFqiCQwbKsOSFdXbiZ+94m+6zmrHc/FvtaQGmt8kJTO2LbgLJj
	PmHhnE6Uy4N1jBSmGDdLCNDew3WiUKq1d8pFYfNIphZQaeemJUBcQgz7JgmJNblFdiPMyF
	tiYH1DzTZnhWLsd/8oNOSxyTOXVcetY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755158604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlimYzKPsCEda21QkYMD52T/yxbElWfMlAcYmFen9S4=;
	b=1KxjGCGhqLJRdAFQj3eExr/OcOe9Sxrrc9OquP5B5EnvbwwfDL1ACVaUteSoJMavQtQhyZ
	LOiuXuSeQVVJcmBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eox4opzr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="zsPRxrq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755158603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlimYzKPsCEda21QkYMD52T/yxbElWfMlAcYmFen9S4=;
	b=eox4opzrZJZvgG8p9309XU852DSJ1vxopr5AUky1/EhVcZMurSeQxJegxB2ylFTYsYEdQO
	Bul7qLmqsAdHtAMT4LY6Kcg021/c7zqW38sEwJzlh8QIp0/ayo3sCG6/RnCQgcH0cMS3Y8
	N+4zsZ2e5rL/GkkPIfY26ebj33sYbPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755158603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlimYzKPsCEda21QkYMD52T/yxbElWfMlAcYmFen9S4=;
	b=zsPRxrq/dDiYXbE1VHdZtf81N+RQHaGQtAIDFNttAZCrp6fSayy/uyAthy4t22MjvJ5uiW
	6/mEhH4YB8TQYwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9701E136AE;
	Thu, 14 Aug 2025 08:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GYkUI0uYnWgmCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Aug 2025 08:03:23 +0000
Date: Thu, 14 Aug 2025 10:03:23 +0200
Message-ID: <87ldnmuy7o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 5/7] ALSA: usb-audio: us144mkii: Add MIDI support and mixer controls
In-Reply-To: <20250813131518.18985-6-ramiserifpersia@gmail.com>
References: <20250813131518.18985-1-ramiserifpersia@gmail.com>
	<20250813131518.18985-6-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CE79E1F7CB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.51

On Wed, 13 Aug 2025 15:15:16 +0200,
©erif Rami wrote:
> 
> +static int tascam_samplerate_get(struct snd_kcontrol *kcontrol,
> +				 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct tascam_card *tascam =
> +		(struct tascam_card *)snd_kcontrol_chip(kcontrol);
> +	u8 *buf __free(kfree) = NULL;
> +	int err;
> +	u32 rate = 0;
> +
> +	guard(spinlock_irqsave)(&tascam->lock);
> +	if (tascam->current_rate > 0) {
> +		ucontrol->value.integer.value[0] = tascam->current_rate;
> +		return 0;
> +	}
> +	// Lock is released here before kmalloc and usb_control_msg

No, the lock isn't released!
You must use scoped_guard() in this case.

> +void tascam_midi_out_urb_complete(struct urb *urb)
> +{
....
> +	{
> +		guard(spinlock_irqsave)(&tascam->midi_out_lock);

Use scoped_guard().

> +static void tascam_midi_out_work_handler(struct work_struct *work)
> +{
....
> +		{
> +			guard(spinlock_irqsave)(&tascam->midi_out_lock);

Ditto.

> +			{
> +				guard(spinlock_irqsave)(&tascam->midi_out_lock);

Here, too.

Try to grep and check similar patterns are seen in other patches,
too.  I might have overlooked.


thanks,

Takashi

