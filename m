Return-Path: <linux-kernel+bounces-851232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C123BD5D87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DD53B5D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6D2C21FE;
	Mon, 13 Oct 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yl9S8MeH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7jnFHV+5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a9+aWCgQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9258aH5c"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D22C0F87
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382248; cv=none; b=rLix0KXnDDo2t3j4nntMGtmGT/qpNQ2ss4ReIeNmgVxvHgo9lDmg1iSktV1aJZqa0bFB9/pwcRlvkTsb59IMQybMNLaS2LUJ22HR7xywb3TJh7FhGioo88UAK6AfQXjzMoJysbRxGgmrnu44mO7E388bcELrIFerNSqMetyYs9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382248; c=relaxed/simple;
	bh=PFpRI8q30Gr4F9PAlDtVRZZ7i+Rk+d1ShYLcWQZYE4o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmBmOxM+Hw2mgj1gBRXMisn1FAsEeElAuRECpo0YOhvo0C4MLCyVlIZPBvV1h8ohah9ivLkPP1rI6Nh04KbX5rhKrg6dNxtE9nqn1FbRoH4MLmTzcU3ikCzBujc42e9AUT9rBJHdpO12ogA4uHocO6K3t6nJxMq5GEZaDMWjBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yl9S8MeH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7jnFHV+5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a9+aWCgQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9258aH5c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D48D621222;
	Mon, 13 Oct 2025 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760382243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+4C/RUUwRebhBJxbPX1nu6PHPWN+jMJsXkFnCGPddw=;
	b=yl9S8MeHTQTOAWbwRV3xWjMWQSlWiSNwEELlK+bR7m+jxHDnZT3P3P/MJJgvaMcHzgh6G7
	MO/5l9IM67iyu/9VgGyc9xJf7yWZ5Tgya8Of/w1AmB6k8PIB3ryxL2Ucntb6bB5AX0zZb/
	eZFHexF6FvxO8+f3wvnX5e8TsWdOH78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760382243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+4C/RUUwRebhBJxbPX1nu6PHPWN+jMJsXkFnCGPddw=;
	b=7jnFHV+59DQG/CJqk6219zd5Izac7TxntTKSjUE2FMS23ZZB/npX0N/ptkrhNFsXXMXsAD
	t8YPqZi59ZusckAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a9+aWCgQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9258aH5c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760382242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+4C/RUUwRebhBJxbPX1nu6PHPWN+jMJsXkFnCGPddw=;
	b=a9+aWCgQm+nxTpngpzW8o/yMDRZZLWP000PkOQ8AJebnmZ71Rqc50DlGlo0CVeS3t2j8Oj
	dI2fOwlK6KaT/JhS0z5NO/zaTxYe582dcxXNuici+vys/jtej6RFKh42YpvmiB3SFu61GG
	3E5zycwYZTLBA5kTeTLDL4oq9ZyQNpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760382242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+4C/RUUwRebhBJxbPX1nu6PHPWN+jMJsXkFnCGPddw=;
	b=9258aH5cNVCG+UKX5KJSYBCxj/tc5xsnKEJZMgcEI5kfHBLaEH45rttj/LltkDqd2t7KcL
	mRarXnYRoIGCqOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4E7E1374A;
	Mon, 13 Oct 2025 19:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y3mTJiJN7WjMJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Oct 2025 19:04:02 +0000
Date: Mon, 13 Oct 2025 21:04:02 +0200
Message-ID: <87a51u8vz1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: add mixer_playback_min_mute quirk for Logitech H390
In-Reply-To: <72c83ff44985b3de59ad35189e6757212bb3998c.1760375830.git.pav@iki.fi>
References: <72c83ff44985b3de59ad35189e6757212bb3998c.1760375830.git.pav@iki.fi>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: D48D621222
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Mon, 13 Oct 2025 19:33:06 +0200,
Pauli Virtanen wrote:
> 
> ID 046d:0a8f Logitech, Inc. H390 headset with microphone
> is reported to have muted min playback volume. Apply quirk for that.
> 
> Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4929
> Signed-off-by: Pauli Virtanen <pav@iki.fi>

Applied now.  Thanks.


Takashi

