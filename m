Return-Path: <linux-kernel+bounces-834891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B026DBA5C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483462A2406
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F93283FF0;
	Sat, 27 Sep 2025 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xTQf6Zpu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aOHogPmr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xTQf6Zpu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aOHogPmr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E19298CC9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965413; cv=none; b=IUqIuOmhAd+YY9LtoqxCkhotr47bn8yJx9JlxluLnNSELNhD2U8n7wBFCz7U1jr8CV3YW+eKL/3ni9G+gphqPnr7J2b2YwyoLZc76aU2K7BSh2S2xcIGJGGFv4C+ArzPlzFMyegxWFshf/BUFkTQ6dc+1GPVshCbHbxoeXmVF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965413; c=relaxed/simple;
	bh=FIfj9nbNXNqq82jj1REvJ1edaD5755XR7Lu1NtnFqiI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkuqkgJJHbaw3MeksaOnGPJEsmyNExRQv7tUxshaFHAdRq2fH0yPZhuDc6rS0frsTTxScbbf6uSXyy5m0JG46qqh2Q/2bT2Ww0d/2/MzxHz/GzXax+FTLB1dGLCl3hKgbScOrSzIivIgqJYA6agCJnxY2DH4rDs2o5okdhm/NTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xTQf6Zpu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aOHogPmr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xTQf6Zpu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aOHogPmr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B37B33B2C;
	Sat, 27 Sep 2025 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758965408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QIit9pdRXiv+9DfQ+mNd8Ou3Bw4mFlhWWOd86zUu/OE=;
	b=xTQf6ZpuFEIi65wjETg9gaq74/fhj9IcruKoKZuw6tHv16ZBWSDiNBhG3gBme0s/vQWYQG
	SuUdsbYDgZDgUgxpSCtYKVZfOSRpg0MHfO4YTCksY4Ogs017S3DBnyhuiyYV0yiiVnBWtS
	n+/Rh71FVhSUUkASSF272kvsRefDvrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758965408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QIit9pdRXiv+9DfQ+mNd8Ou3Bw4mFlhWWOd86zUu/OE=;
	b=aOHogPmrwtKN63ME2jAAFCD+HFoupc8RpH9ug1DYlGrecbGdlBnAZOtEInQZ71hM8EAdVw
	pk0xctB4lPTbSQDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xTQf6Zpu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aOHogPmr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758965408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QIit9pdRXiv+9DfQ+mNd8Ou3Bw4mFlhWWOd86zUu/OE=;
	b=xTQf6ZpuFEIi65wjETg9gaq74/fhj9IcruKoKZuw6tHv16ZBWSDiNBhG3gBme0s/vQWYQG
	SuUdsbYDgZDgUgxpSCtYKVZfOSRpg0MHfO4YTCksY4Ogs017S3DBnyhuiyYV0yiiVnBWtS
	n+/Rh71FVhSUUkASSF272kvsRefDvrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758965408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QIit9pdRXiv+9DfQ+mNd8Ou3Bw4mFlhWWOd86zUu/OE=;
	b=aOHogPmrwtKN63ME2jAAFCD+HFoupc8RpH9ug1DYlGrecbGdlBnAZOtEInQZ71hM8EAdVw
	pk0xctB4lPTbSQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4E8C1373E;
	Sat, 27 Sep 2025 09:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ui14Jp+u12glSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 09:30:07 +0000
Date: Sat, 27 Sep 2025 11:30:07 +0200
Message-ID: <873488b5uo.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v5 2/4] ALSA: usb-audio: improve module param quirk_flags
In-Reply-To: <20250925-sound-v5-2-2593586ff350@uniontech.com>
References: <20250925-sound-v5-0-2593586ff350@uniontech.com>
	<20250925-sound-v5-2-2593586ff350@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 2B37B33B2C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 25 Sep 2025 11:25:17 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> +static void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
> +{
> +	/* add or correct quirk bits from options */
> +	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++) {
> +		if (!quirk_flags[i] || !*quirk_flags[i])
> +			break;
> +
> +		val = kstrdup(quirk_flags[i], GFP_KERNEL);
> +
> +		if (!val)
> +			return;
> +
> +		snd_usb_init_quirk_flags_parse_string(chip, val);
> +
> +		kfree(val);

For a temporary string allocation, nowadays it's better to use
__free(kfree):

	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++) {
		if (!quirk_flags[i] || !*quirk_flags[i])
			break;

		char *val __free(kfree) = 
			kstrdup(quirk_flags[i], GFP_KERNEL);
		if (!val)
			return;

		snd_usb_init_quirk_flags_parse_string(chip, val);
	}

Or maybe it's even safer to pass the original string (with const) and
do kstrdup() in the callee side.  You can use __free(kfree) in the
same way in snd_usb_init_quirk_flags_parse_string().


thanks,

Takashi

