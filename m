Return-Path: <linux-kernel+bounces-787708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E84BB37A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BB63BCE71
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86813101DC;
	Wed, 27 Aug 2025 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vdM3fXRk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ubY41WTn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vdM3fXRk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ubY41WTn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944927AC34
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274191; cv=none; b=swIbcGLFJbtsq3TdJk/Ddp77IuqRwLHcj5tCqeUF/jfQXWVG9+II6B4CuLG6Uxmj0BuSyoqqjYtbXK8I99fh2LRcPN23oDCtzb+Cw0puBrkRgr9SQhhbbL0xGHgT2AR0v+y06hDYAhxzeQG9jopapeBRY3gS76lYNIb5MxrqBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274191; c=relaxed/simple;
	bh=8KGQ2U30WB0kF//3bk0bGjDhq+uOCKuLnyUORX8VUYI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIYYkO8ax7riwfJBWtJ+HbrHN4lV2sgjmvXuFb66cPTmj8saErSOuL0dH1HGjES6Lu4lo7QFuYXO6IDMMhaFc+kxQ1NrCVx3f4JqliPcj0LwD8dejdZCo9D0TkMAWGHit3y5CeGBDc0pIP0J9Bwkz0s7qZOeRL0RqiZrugzA8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vdM3fXRk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ubY41WTn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vdM3fXRk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ubY41WTn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 178261FDF0;
	Wed, 27 Aug 2025 05:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756274186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7l7PrgkDJSFVY+UvFVbNmqI5owAG0Awi1MO5Vsi6Hc=;
	b=vdM3fXRk4kU3gF15JsbgfiyZ2ihKQ2lz/mCLEZ4fVqFo5iTTDhe2axwZ0EVSnqfTF9pWC6
	cxS+2aIxv/d+gZFYm8xiPck94cIgGWvinwPRKbCHx3oqYUtZFj3J/ewVZhCQT/ReOQ0mQ/
	SZfqUSv3Xot8Xu9oG5fVvYQUCqQZ9D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756274186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7l7PrgkDJSFVY+UvFVbNmqI5owAG0Awi1MO5Vsi6Hc=;
	b=ubY41WTnwT6crFwBQ0wklHGYGHAOko0+eQ/0c8NDuF//LLeKLj17uVV/1oBqqaLd29l57o
	LIbMeiyZjHdHDpAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vdM3fXRk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ubY41WTn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756274186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7l7PrgkDJSFVY+UvFVbNmqI5owAG0Awi1MO5Vsi6Hc=;
	b=vdM3fXRk4kU3gF15JsbgfiyZ2ihKQ2lz/mCLEZ4fVqFo5iTTDhe2axwZ0EVSnqfTF9pWC6
	cxS+2aIxv/d+gZFYm8xiPck94cIgGWvinwPRKbCHx3oqYUtZFj3J/ewVZhCQT/ReOQ0mQ/
	SZfqUSv3Xot8Xu9oG5fVvYQUCqQZ9D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756274186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7l7PrgkDJSFVY+UvFVbNmqI5owAG0Awi1MO5Vsi6Hc=;
	b=ubY41WTnwT6crFwBQ0wklHGYGHAOko0+eQ/0c8NDuF//LLeKLj17uVV/1oBqqaLd29l57o
	LIbMeiyZjHdHDpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A584013310;
	Wed, 27 Aug 2025 05:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QjjfJgmermhpTwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 27 Aug 2025 05:56:25 +0000
Date: Wed, 27 Aug 2025 07:56:25 +0200
Message-ID: <874itti9yu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com,
	Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Wang Yuli <wangyuli@deepin.org>,
	Guan Wentao <guanwentao@uniontech.com>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	Guoli An <anguoli@uniontech.com>
Subject: Re: [PATCH] ALSA: usb-audio: move mixer_quirks' min_mute into common quirk
In-Reply-To: <20250827-sound-quirk-min-mute-v1-1-4717aa8a4f6a@uniontech.com>
References: <20250827-sound-quirk-min-mute-v1-1-4717aa8a4f6a@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,aosc.io,deepin.org,uniontech.com,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cryolitia.uniontech.com];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 178261FDF0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01

On Wed, 27 Aug 2025 05:29:02 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> We have found more and more devices that have the same problem, that
> the mixer's minimum value is muted. Accroding to pipewire's MR[1]
> and Arch Linux wiki[2], this should be a very common problem in USB
> audio devices. Move the quirk into common quirk,as a preparation of
> more devices' quirk's patch coming on the road[3].
> 
> 1. https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2514
> 2. https://wiki.archlinux.org/index.php?title=PipeWire&oldid=804138#No_sound_from_USB_DAC_until_30%_volume
> 3. On the road, in the physical sense. We have been buying ton of
>    these devices for testing the problem.
> 
> Tested-by: Guoli An <anguoli@uniontech.com>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
> I also would like to know if the quirk worth a kernel param.

If the workaround becomes common for various devices, it makes sense.
Applied now to for-linus branch.


thanks,

Takashi

