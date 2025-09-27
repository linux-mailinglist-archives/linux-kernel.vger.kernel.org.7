Return-Path: <linux-kernel+bounces-834892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5366BA5C5F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC06D1B2187C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13850298CC9;
	Sat, 27 Sep 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DTBFMkaV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2aT+yO5F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DTBFMkaV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2aT+yO5F"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA91A0728
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965555; cv=none; b=ci1F8pDCDYs2QaKJ/PzHamsj/Lg7FRuVmsi8qoBXA/XgNxUoe6Nzf229ubjiGQJDBB+F2ym7ZLnRWg7E4ROPBfBY/WiAxFqKZzjEtjA8/ZCxRXgRiKs2PJAvBS+OXiYdFKafFWa2UILstRVmtDdq+ZN5NiNYdAPhotmBl4lRPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965555; c=relaxed/simple;
	bh=qDpAaM09RH7pF3DYY4fE/b94eImYiswwDc+xpxHns+A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noweLr9WdROyRJB4YXOC7nk6pL61bO2B6bSsRQuEJwQXvoKy/GiUDoBkpq+hvfuSZTWGBBGkPSzBsw9MHz8Ny3L0TECwMKGetKQQohfALq5vGgw0spbAf6I9IsCsAkqE5ttH1xI5FZGD2lnpOud9IC7HUTRyf8+BKzHORSUMZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DTBFMkaV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2aT+yO5F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DTBFMkaV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2aT+yO5F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 866E517C89;
	Sat, 27 Sep 2025 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758965551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0EPLADaAwKoUQgJqGceqbKETR1bnScylM2id9gToSBE=;
	b=DTBFMkaVRkiuuB32SeoS9ioC4CqRezrhDgvTaxywKhQ6XLIqtZ4DmztYq7mH192d+TJxY5
	g01wJjGrytN8svrP0Nuh6uLvB4UpvokmgqsmI7l+dgBYuCuOTVtUJiE04aB12ZS6ruP6Jc
	TaQ7AY5+4atO/S6mx8f/YYa+2Ko16Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758965551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0EPLADaAwKoUQgJqGceqbKETR1bnScylM2id9gToSBE=;
	b=2aT+yO5FK1ArFFYXAGssGm+DUMa+zkvj8NKYANPFeuoOgiEqpLZKvlmsa1CpdfHfvwQPHZ
	2nOsep3l+NX+0kAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DTBFMkaV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2aT+yO5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758965551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0EPLADaAwKoUQgJqGceqbKETR1bnScylM2id9gToSBE=;
	b=DTBFMkaVRkiuuB32SeoS9ioC4CqRezrhDgvTaxywKhQ6XLIqtZ4DmztYq7mH192d+TJxY5
	g01wJjGrytN8svrP0Nuh6uLvB4UpvokmgqsmI7l+dgBYuCuOTVtUJiE04aB12ZS6ruP6Jc
	TaQ7AY5+4atO/S6mx8f/YYa+2Ko16Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758965551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0EPLADaAwKoUQgJqGceqbKETR1bnScylM2id9gToSBE=;
	b=2aT+yO5FK1ArFFYXAGssGm+DUMa+zkvj8NKYANPFeuoOgiEqpLZKvlmsa1CpdfHfvwQPHZ
	2nOsep3l+NX+0kAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12A7C1373E;
	Sat, 27 Sep 2025 09:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ss95Ai+v12jISwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 09:32:31 +0000
Date: Sat, 27 Sep 2025 11:32:30 +0200
Message-ID: <871pnsb5qp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	qaqland <anguoli@uniontech.com>,
	kernel@uniontech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v5 3/4] ALSA: usb-audio: make param quirk_flags change-able in runtime
In-Reply-To: <20250925-sound-v5-3-2593586ff350@uniontech.com>
References: <20250925-sound-v5-0-2593586ff350@uniontech.com>
	<20250925-sound-v5-3-2593586ff350@uniontech.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 866E517C89
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 25 Sep 2025 11:25:18 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> +/* protects quirk_flags */
> +DEFINE_MUTEX(quirk_flags_mutex);

This can be static?

> +static int param_set_quirkp(const char *val,
> +			    const struct kernel_param *kp)
> +{
> +	guard(mutex)(&quirk_flags_mutex);
> +	return param_set_charp(val, kp);
> +}
> +
> +static const struct kernel_param_ops param_ops_quirkp = {
> +	.set = param_set_quirkp,
> +	.get = param_get_charp,
> +	.free = param_free_charp,
> +};
> +
> +#define param_check_quirkp param_check_charp
> +
> +module_param_array(quirk_flags, quirkp, NULL, 0644);
> +MODULE_PARM_DESC(quirk_flags, "Add/modify USB audio quirks");
> +
>  /*
>   * we keep the snd_usb_audio_t instances by ourselves for merging
>   * the all interfaces on the same card as one sound device.
> @@ -697,15 +716,13 @@ static void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
>  	char *val;
>  	size_t i;
>  
> +	mutex_lock(&quirk_flags_mutexn);

Use guard().  Then you can avoid ugly goto.


thanks,

Takashi

