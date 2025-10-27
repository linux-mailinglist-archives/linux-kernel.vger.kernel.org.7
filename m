Return-Path: <linux-kernel+bounces-871166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4CEC0C8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D456B189A6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9FE2F25FA;
	Mon, 27 Oct 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p/+LU4LE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WpccB66u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p/+LU4LE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WpccB66u"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A025D2E5B08
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555731; cv=none; b=NiZs+oS35+C+CLDjX2gpMiAPj7JwxgvfUpqgSxGGeB0ay10lD81lV3JPdxn/49V3hLqEr5sO3KlnbSp9rM7D3J2vuaGlwf6jr5z3G9z0FdMwpSO2gKdNjvxh/Zje0RpgKesJSWAulGzed5AdewlwFr6Ldk4XX11USAjSRnHSuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555731; c=relaxed/simple;
	bh=5yDMD5SPHiQ/2N0GD+XLRmqOKlTDVH/VQHlyBzIFPBM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNvHZeQFDEfP4OQwOr6Jibg2P6RUEDMgQtZMSr6M5iPfruhITO9XdsDR4CltEO1wnReLgGEJwajdU2TAUSydzLQljFIdTjd8w2wdJCAbeB4YURQXvrwbYE4GhRYgYlgfmo5YZEvUNHpmd9Eu3Wq9d7btrx+X5CeKzIuT7wg74vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p/+LU4LE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WpccB66u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p/+LU4LE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WpccB66u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B31971F385;
	Mon, 27 Oct 2025 09:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761555727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grxlaZtodfngfRM/DpYNmglZ5nY6vDltXt0NMp0Ywjw=;
	b=p/+LU4LEeVq08aML9tInxaCAvvb2HImNkg/740OqJiPxBlVB6dWdmlFSvEI0X2vS6451Sj
	aBh6QoXFWaHnMa5l9npFTR57lYxcXwWF9r+G+0wtq56t7AirPe5MZIMq2csBbDAKHZyyUI
	P3Krowt2QMI7q7YtK1VhMO2SBQeAnnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761555727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grxlaZtodfngfRM/DpYNmglZ5nY6vDltXt0NMp0Ywjw=;
	b=WpccB66uxh+epXC99yIGrQ9vk5HkoWmcmkxmafIuCwZSl1O08tBByvCjc+Ww+YfdxAw90h
	UXev+KrZLUbckfBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="p/+LU4LE";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WpccB66u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761555727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grxlaZtodfngfRM/DpYNmglZ5nY6vDltXt0NMp0Ywjw=;
	b=p/+LU4LEeVq08aML9tInxaCAvvb2HImNkg/740OqJiPxBlVB6dWdmlFSvEI0X2vS6451Sj
	aBh6QoXFWaHnMa5l9npFTR57lYxcXwWF9r+G+0wtq56t7AirPe5MZIMq2csBbDAKHZyyUI
	P3Krowt2QMI7q7YtK1VhMO2SBQeAnnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761555727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grxlaZtodfngfRM/DpYNmglZ5nY6vDltXt0NMp0Ywjw=;
	b=WpccB66uxh+epXC99yIGrQ9vk5HkoWmcmkxmafIuCwZSl1O08tBByvCjc+Ww+YfdxAw90h
	UXev+KrZLUbckfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79281136CF;
	Mon, 27 Oct 2025 09:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kr4rHA81/2ikQQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 Oct 2025 09:02:07 +0000
Date: Mon, 27 Oct 2025 10:02:07 +0100
Message-ID: <87jz0g3egg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 00/11] ALSA: cs35l56: Add support for factory calibration
In-Reply-To: <c45840e4-af1e-4658-9e13-bd6b9f66598f@sirena.org.uk>
References: <20251021105022.1013685-1-rf@opensource.cirrus.com>
	<c45840e4-af1e-4658-9e13-bd6b9f66598f@sirena.org.uk>
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
X-Rspamd-Queue-Id: B31971F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Wed, 22 Oct 2025 21:14:45 +0200,
Mark Brown wrote:
> 
> On Tue, Oct 21, 2025 at 11:50:11AM +0100, Richard Fitzgerald wrote:
> 
> > NOTE: unfortunately this is yet another series that is mainly ASoC but
> > also needs some changes to the HDA driver, and they have build dependencies
> > on the ASoC code. I suggest taking this all through Mark's tree and we'll
> > avoid sending any other commits to the HDA driver until it has all landed
> > in Takashi's tree.
> 
> That seems like a reasonable plan to me, Takashi?

Sorry for the late reaction, as I was off in the last week.

Let's get them through Mark's tree as suggested.
Feel free to take my ack:

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

