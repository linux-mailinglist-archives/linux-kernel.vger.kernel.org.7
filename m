Return-Path: <linux-kernel+bounces-842070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB8BB8E45
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3888189FF98
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 13:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF794A06;
	Sat,  4 Oct 2025 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hAEuuoOr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="66JtpGwW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hAEuuoOr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="66JtpGwW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D535962
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759585635; cv=none; b=jRBNNMo+KLWBr0XkJ+PyXesZUqCvGZhgZbqhgogHn+0MSL5l0Q1D3YpxPFzYXhUCH7lpd7MQitaho6wcyWZG9Ah2tbh4HD2jTLuUvdfg4A8F1MawgyoX2WitW6ulL1ZYMnojgGfzBv1P9veVVUHQgWOsXEN9mgprxfHk7ug1sQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759585635; c=relaxed/simple;
	bh=JIj2cm2nUIViiv+LfV/uuvb8qkhNjv1i4cl+zcqy9pE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKOqJhSHxZU1sjzoXLwHDw5PJmtqdaUOfACk62Cn+/JY1A0vBWSZd+rGnq3GnDK6zP9kfmSn107Q29aguZwQKEdeh7j3tFhV9wlcRsSQcORFo+Cm3af9eFk3jUkdF6nFhQKh2DnDimzK4bvf5l54NSb0zNiVcBpXxDzZ8d0rYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hAEuuoOr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=66JtpGwW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hAEuuoOr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=66JtpGwW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D8E121270;
	Sat,  4 Oct 2025 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759585631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43mGxjOsbdOBzvMrUHnTNseAOfsZkr947+0HpMS51m8=;
	b=hAEuuoOrxdWFnYE6yIjcSuPNKwx870E8oakqMsIi023u4aHy0ZiDieFwCMDGr+Lzui0mhd
	gQWxU6HcSjmdmBv6314svqgr+4RgsRa+cE02v4SuoWvsnliohCKDox8fGADpn6O2M3Dxgy
	uZ42Yju0BO5f4lqCuGFdmcBRJB69MEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759585631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43mGxjOsbdOBzvMrUHnTNseAOfsZkr947+0HpMS51m8=;
	b=66JtpGwWirjeBrC3WpKXuwBsYRcFabivIvnVQB64yn1rau+AIvTz+VeDbpnZQa3uVPsbhC
	3iFQgv4VdG9QIWAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hAEuuoOr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=66JtpGwW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759585631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43mGxjOsbdOBzvMrUHnTNseAOfsZkr947+0HpMS51m8=;
	b=hAEuuoOrxdWFnYE6yIjcSuPNKwx870E8oakqMsIi023u4aHy0ZiDieFwCMDGr+Lzui0mhd
	gQWxU6HcSjmdmBv6314svqgr+4RgsRa+cE02v4SuoWvsnliohCKDox8fGADpn6O2M3Dxgy
	uZ42Yju0BO5f4lqCuGFdmcBRJB69MEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759585631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43mGxjOsbdOBzvMrUHnTNseAOfsZkr947+0HpMS51m8=;
	b=66JtpGwWirjeBrC3WpKXuwBsYRcFabivIvnVQB64yn1rau+AIvTz+VeDbpnZQa3uVPsbhC
	3iFQgv4VdG9QIWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AC5B1366F;
	Sat,  4 Oct 2025 13:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I49vFF8l4WhQNgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 04 Oct 2025 13:47:11 +0000
Date: Sat, 04 Oct 2025 15:47:10 +0200
Message-ID: <874isehj8h.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Adam Holliday <dochollidayxx@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for ASUS ROG Zephyrus Duo
In-Reply-To: <20250930150914.3103-1-dochollidayxx@gmail.com>
References: <87wm5gjetc.wl-tiwai@suse.de>
	<20250930150914.3103-1-dochollidayxx@gmail.com>
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
X-Rspamd-Queue-Id: 9D8E121270
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
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Tue, 30 Sep 2025 17:09:14 +0200,
Adam Holliday wrote:
> 
> The ASUS ROG Zephyrus Duo 15 SE (GX551QS) with ALC 289 codec requires specific
> pin configuration for proper volume control. Without this quirk, volume
> adjustments produce a muffled sound effect as only certain channels attenuate,
> leaving bass frequency at full volume.
> 
> Testing with hdajackretask confirms these pin tweaks fix the issue:
> - Pin 0x17: Internal Speaker (LFE)
> - Pin 0x1e: Internal Speaker
> 
> Signed-off-by: Adam Holliday <dochollidayxx@gmail.com>

Applied now.  Thanks.


Takashi

