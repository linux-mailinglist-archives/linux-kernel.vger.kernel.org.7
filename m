Return-Path: <linux-kernel+bounces-891376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC75C428FD
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA19534B4AA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9424F2C11C4;
	Sat,  8 Nov 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LoxxDRRC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N8Hsa3ce";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BaRo542r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LAyvKMXw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522523AB9D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762588512; cv=none; b=YLF+2SJq5EKT58sJJufaBJRTAPb7ukpmECiCwSxdULWfQXPzn0uIPZ5Zqcf9miw0HrlQqaLCz798Rs3Qzabcyb78r7joepTJomMU5gLEqvWNb1W6uuz/l58wZKsQ3chBbjruYjDmeT88crkaZhBky2+IlF/km4/xOa9fmKfSInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762588512; c=relaxed/simple;
	bh=sxkA0qasv2XTig+2EirF6ZXh516Ts3G8bDOC6mLQZOc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f18h6OoEbVou7ZdFNWH7XmsoZiE+imO/6zfioAv1uHybHw5650GfevLO+PME5Ef+eehP+6fi7MC1F3PyuMK6MTavxy0nFyDfUrkY26cOR0kMr9n+0s3ZMZUfqBWXlzHfVUwWXvsxM9Ogpxrc6poNVNB8TWLkLbSKjewKh5tS/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LoxxDRRC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N8Hsa3ce; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BaRo542r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LAyvKMXw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94BE7338D7;
	Sat,  8 Nov 2025 07:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762588508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGdoZognkXIiV0HydNaGqmGNn2PJy1yzawAViXgjG8s=;
	b=LoxxDRRC2MtBarFArNz8UE89GztHUPawhICNckaG76WTjng11YLpVI4nYT5ZKTCoy7eyoO
	/WclqEwyCPCwlHgtkctWIGEp5lcVRw0wGQdlBOjjS/1pGYaRY+XTptFOCHBYsEb7XF9q+2
	rNUVp6IQLhk9NFx7i1y7mV9mqZpD4XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762588508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGdoZognkXIiV0HydNaGqmGNn2PJy1yzawAViXgjG8s=;
	b=N8Hsa3ceVc8iGJV2lMysSJL50RkGC7lqfTzSVpXgb5el8bdrFUlZY1rnRi+PoKHxZfDiyz
	YJfFXsIuxGFOyhCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BaRo542r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LAyvKMXw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762588507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGdoZognkXIiV0HydNaGqmGNn2PJy1yzawAViXgjG8s=;
	b=BaRo542rfa8do4d7KG9vDUgeeEuGlQk8EdtKTcF72iM8tlE70lmgAZJJIqxDzKmYHQHQJg
	/T4di/58wnrTDHCOLsPm//imM3UIHlKApW+S+BlgZWh7Jws0Vvch5D9H7MQcAEFjyDLS3B
	VNKAK96Zo0PNRjws52yReIwsXVFbffs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762588507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGdoZognkXIiV0HydNaGqmGNn2PJy1yzawAViXgjG8s=;
	b=LAyvKMXw2eQcrzeRzeFrcdVhem07cp3qqX2DgkK/MAD4u4PgTBJpxA6vjegH/obsMCZFYr
	IjJMBVpYUngu1dAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50F9113675;
	Sat,  8 Nov 2025 07:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DeBmElv3DmmEcgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 08 Nov 2025 07:55:07 +0000
Date: Sat, 08 Nov 2025 08:55:06 +0100
Message-ID: <87a50xq7qd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdich9700@163.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH v2] ALSA: hda/senary: Replace magic numbers with defined constants
In-Reply-To: <20251107024030.36712-1-wangdich9700@163.com>
References: <20251107024030.36712-1-wangdich9700@163.com>
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
X-Rspamd-Queue-Id: 94BE7338D7
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,intel.com,vger.kernel.org,lists.infradead.org,kylinos.cn];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,kylinos.cn:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Fri, 07 Nov 2025 03:40:30 +0100,
wangdich9700@163.com wrote:
> 
> From: wangdicheng <wangdicheng@kylinos.cn>
> 
> Replace hardcoded GPIO node value with a defined constant for better
> code readability and maintainability.
> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
> ---
> 
> v1->v2:
> -Align both From and Signed-off-by addresses

Applied to for-next branch now.  Thanks.


Takashi

