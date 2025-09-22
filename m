Return-Path: <linux-kernel+bounces-826842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210F9B8F791
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B29317EF79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A71F2F3C19;
	Mon, 22 Sep 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rosC11Ip";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9bispL5/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rosC11Ip";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9bispL5/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D500B2FDC25
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529329; cv=none; b=n/87/acpFKkCpb3mopAOsmfeIG4z5nRZV0C9LbaaiM05iH0wsX+97uakjsSbEgGzPGxm0MEmgl1YtF239biMTtiSInTuziPPUknJIaiAqQt9Q+9mJ8jeR19ytEY3bK9wEAz4HfRntDCask47dGupEP8VBRS3+EKhcgQNgh3bJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529329; c=relaxed/simple;
	bh=IT7w8ZepnL0LFrCL2VHKZi5Ot5arph80yGQXN0XZUwM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ighM9E6kr/cVT4TiYV1fFERMFMzLc+9lA6y++ni3dNCPtR0WBxLVN8jWEW6anXcsP59Is0kap9/dWtiiSgREZ9RA0Vtep84kvX/AQppyvFMa9NWMixfsbvEuMaZeRnE6RWSppv+rOGqxoVctvbl5HD/HphRM+m0/W19X0Ry2Ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rosC11Ip; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9bispL5/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rosC11Ip; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9bispL5/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E0522273C;
	Mon, 22 Sep 2025 08:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758529326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glyH9ZOGOITwWu1HVftETD+CJLg0nR07lueBBmuvGZ4=;
	b=rosC11IpWGX1kk8sg6/GXqkfRssS+zVSwzchqod6Ho8YFWDcgkYi/w8cT4Mtl/Mjxb2rVF
	ScIREPRTmYiiB2giahN2+a33w26hZdQAyVn1aZWEgoFs7Mazvt893WcpGCR8BvU8P94Pc2
	+/4IqTECa3TEqOjb0Rgduw8LsTUGJ0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758529326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glyH9ZOGOITwWu1HVftETD+CJLg0nR07lueBBmuvGZ4=;
	b=9bispL5/umak162OJ/aHCwkX3EGya4VMj5QC0uCanlRA+KSGr8+tT7jFwPRqoBIbp6jTBk
	dQNSCPB7Qbx53NCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rosC11Ip;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9bispL5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758529326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glyH9ZOGOITwWu1HVftETD+CJLg0nR07lueBBmuvGZ4=;
	b=rosC11IpWGX1kk8sg6/GXqkfRssS+zVSwzchqod6Ho8YFWDcgkYi/w8cT4Mtl/Mjxb2rVF
	ScIREPRTmYiiB2giahN2+a33w26hZdQAyVn1aZWEgoFs7Mazvt893WcpGCR8BvU8P94Pc2
	+/4IqTECa3TEqOjb0Rgduw8LsTUGJ0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758529326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glyH9ZOGOITwWu1HVftETD+CJLg0nR07lueBBmuvGZ4=;
	b=9bispL5/umak162OJ/aHCwkX3EGya4VMj5QC0uCanlRA+KSGr8+tT7jFwPRqoBIbp6jTBk
	dQNSCPB7Qbx53NCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94F8B1388C;
	Mon, 22 Sep 2025 08:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b90bIy0H0WhyEQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Sep 2025 08:22:05 +0000
Date: Mon, 22 Sep 2025 10:22:05 +0200
Message-ID: <87a52mew2a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Baojun Xu <baojun.xu@ti.com>,
	andriy.shevchenko@linux.intel.com,
	13916275206@139.com,
	alsa-devel@alsa-project.org,
	shenghao-ding@ti.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	k-yi@ti.com,
	henry.lo@ti.com,
	robinchen@ti.com,
	jesse-ji@ti.com,
	will-wang@ti.com,
	jim.shil@goertek.com,
	toastcheng@google.com,
	chinkaiting@google.com
Subject: Re: [PATCH v1] ASoC: tas2781: Correct the wrong description and register address on tas2781
In-Reply-To: <aNEFtCV0Gm2koLKv@finisterre.sirena.org.uk>
References: <20250920062044.1904-1-baojun.xu@ti.com>
	<aNEFtCV0Gm2koLKv@finisterre.sirena.org.uk>
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[ti.com,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,gmail.com,kernel.org,goertek.com,google.com];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 2E0522273C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01

On Mon, 22 Sep 2025 10:15:48 +0200,
Mark Brown wrote:
> 
> On Sat, Sep 20, 2025 at 02:20:44PM +0800, Baojun Xu wrote:
> > Correct the wrong description for TAS257X. Combined TAS5825 with TAS2563,
> > as they use the same register address and number.
> > Correct the register address and number for TAS5827.
> 
> This depends on commits in Takashi's tree so it needs to go via there:
> 
> Acked-by: Mark Brown <broonie@kernel.org>

OK, applied now to for-next branch.


thanks,

Takashi

