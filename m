Return-Path: <linux-kernel+bounces-801093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E11B43FC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65CB1C81291
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4416930507F;
	Thu,  4 Sep 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hcbtI2fT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2GemctlR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hcbtI2fT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2GemctlR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A51302CDA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997890; cv=none; b=UpFUR1ymxY6TIWCvIkTeG504sbgqw7g08I4A/JMWv50ysck/4zUyqzdsecD4dR1omyd3CM/q7/9O5xqIt7gNgO3ncLI7/pEdqeUfrS1sF/ezRyEGhoLuerdWTWzzWQPkCFc5VlHZAmHB1emB+CSfWMPGQu1vyGArZ/B+LI0IcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997890; c=relaxed/simple;
	bh=LDo7n+ht/14Y2XxvRALbph5m3OXHQeh08/h3UV9pPWI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEQsojW8yfFYrEi4OSYmfH8A4JDt80GtAbuBP2frSyeeKJ8oMb3WM41B/zqicym6mHcuocyIwHZyS4byxfTBYqcxvvVhnZfiRh7eUL9pkSWj1RLEVdlnQgYyveRKrSQoC7M0+e5eCkgcMQxgVQPIwtkH/LQWSK42fghZXI6KhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hcbtI2fT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2GemctlR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hcbtI2fT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2GemctlR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 071A6601D5;
	Thu,  4 Sep 2025 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756997887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbEeFL6F/XMBChxR0YsDAt6KZRAz0SzeG+xlv6ufwOE=;
	b=hcbtI2fTu4A+43wTHlk454t5pvwo3ZgHNZiFMZI0EK/XsaGQfpf8FrkFDsfL4FBM9elI/c
	T7+7F8JJy1sSD6q/BKPQGNkGlCjrao0kJ8g7V6PNNS9jijv/zes3Vb8P8yQJUe/MH26Ymk
	ejxYiZ+UAPyJG0wnalq3pTnCU9TxnB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756997887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbEeFL6F/XMBChxR0YsDAt6KZRAz0SzeG+xlv6ufwOE=;
	b=2GemctlR/8JqFIP5JSI0OqmQXICfNygbZzoQCFmeH03b5LOJOgRvDjT5j+Waky4hCbnY/J
	EOtrZWGMKZLgCjDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hcbtI2fT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2GemctlR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756997887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbEeFL6F/XMBChxR0YsDAt6KZRAz0SzeG+xlv6ufwOE=;
	b=hcbtI2fTu4A+43wTHlk454t5pvwo3ZgHNZiFMZI0EK/XsaGQfpf8FrkFDsfL4FBM9elI/c
	T7+7F8JJy1sSD6q/BKPQGNkGlCjrao0kJ8g7V6PNNS9jijv/zes3Vb8P8yQJUe/MH26Ymk
	ejxYiZ+UAPyJG0wnalq3pTnCU9TxnB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756997887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbEeFL6F/XMBChxR0YsDAt6KZRAz0SzeG+xlv6ufwOE=;
	b=2GemctlR/8JqFIP5JSI0OqmQXICfNygbZzoQCFmeH03b5LOJOgRvDjT5j+Waky4hCbnY/J
	EOtrZWGMKZLgCjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7F1913675;
	Thu,  4 Sep 2025 14:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3F/WJ/6ouWg7AwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Sep 2025 14:58:06 +0000
Date: Thu, 04 Sep 2025 16:58:06 +0200
Message-ID: <87frd2s1s1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	Celeste Liu <uwu@coelacanthus.name>,
	qaqland <anguoli@uniontech.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] ALSA: usb-audio: series of improvements to min_mute
In-Reply-To: <20250903-sound-v1-0-d4ca777b8512@uniontech.com>
References: <20250903-sound-v1-0-d4ca777b8512@uniontech.com>
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
X-Rspamd-Queue-Id: 071A6601D5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Wed, 03 Sep 2025 07:09:44 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
> Cryolitia PukNgae (4):
>       ALSA: usb-audio: rename QUIRK_FLAG_MIXER_MIN_MUTE to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE
>       ALSA: usb-audio: add quirk QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE
>       ALSA: usb-audio: apply "mixer_min_mute" quirks on some devices
>       ALSA: usb-audio: apply quirk for MOONDROP Quark2

Now applied for 6.18.  Thanks.


Takashi

