Return-Path: <linux-kernel+bounces-834890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D02EBA5C50
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346154C6397
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6042D6409;
	Sat, 27 Sep 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ti2OADmK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xvY1MNwn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X43Kqo9O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fDdHaqjg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF218DB26
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965088; cv=none; b=cFb+u66UASdLOVm8nuNWiyJwHGCyiNZw2iQZXoSFYfwR+e7jFtXeKTvhKd+/DOwSLwmT5cX89i0vqkg2cE2h3dZC+/g435G8sXUWr5L/dPHFgkw9ypyhrOVmtl5aizVyHS+pxbZ3yosk00P69spZFDVM7Yl8hKYwzjDZ6L3fkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965088; c=relaxed/simple;
	bh=B9HqoGKt827Sb8tQA2XSl3IYQDCZjeu6Lc6qe2EPVUk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQ/52LzMHms8RqfTS9W61andlPbnKt3gCaBfUsY+o+awy5g1aidpFjIUaGyJed4M3eQPOIE9upuCvIkgLTmRiNQLJTJjDx38Qhe2+yOvTp+LytnM+ryWftgAJ2ALdJecrX4VyfIOqEPjcLYuULRWGXBhj8x1dEF+tkFKNllp0lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ti2OADmK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xvY1MNwn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X43Kqo9O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fDdHaqjg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5443247FE;
	Sat, 27 Sep 2025 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758965084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkmwLVo5IcDDq2WtRYiGbEXGWT49S2YdLSwGl/HpoHs=;
	b=ti2OADmKs6iNjH8+vtHT04r6Ul4/tnOHnStOa0YPJIycQFQWSW32bS5msqJEvhGKkg0I+b
	PMav5OHij4VH0FWJtYf09O5HElWv/UEZ1aU9ssxHmMfMKNuEBPeMi0hvk/c3DOjTkZ/J7k
	yP5uDnDElJK5fXWg6Ax5zhgzmnUpRiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758965084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkmwLVo5IcDDq2WtRYiGbEXGWT49S2YdLSwGl/HpoHs=;
	b=xvY1MNwnvFkq9m9RZLPwaKrVr25BH6YYwpz0Qo/ZLX9GbC6WCB9nf4AAskb4cHjrUAvZWv
	yMUtZgpDFwTdhgAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X43Kqo9O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fDdHaqjg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758965083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkmwLVo5IcDDq2WtRYiGbEXGWT49S2YdLSwGl/HpoHs=;
	b=X43Kqo9OqCLCtaPLpt/GCCl6IrTJ/5wS6KstIoHPiiTzQMXp7ubLR2hXpwVKkK6PKwKrtG
	qVjNEHp4NkErzeyAT2qQyoL18tJI39fxNL/KRLgxCIVlLZsLF2qFFt0fRoCuje4GM6GcP6
	p1DDcsEhZ5nWQCJEAMDb6UfBE6EGL6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758965083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkmwLVo5IcDDq2WtRYiGbEXGWT49S2YdLSwGl/HpoHs=;
	b=fDdHaqjgssHS/3JluV48YIqrVnosRZ3N1QfaaZJGHQy4VT0OY4QG8enzq2QwEQvoMrV0RD
	6iG2AyUty/2AjJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73FF91373E;
	Sat, 27 Sep 2025 09:24:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9Be2Glut12ixSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 09:24:43 +0000
Date: Sat, 27 Sep 2025 11:24:43 +0200
Message-ID: <874isob63o.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v5 1/4] ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
In-Reply-To: <20250925-sound-v5-1-2593586ff350@uniontech.com>
References: <20250925-sound-v5-0-2593586ff350@uniontech.com>
	<20250925-sound-v5-1-2593586ff350@uniontech.com>
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Rspamd-Queue-Id: E5443247FE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 25 Sep 2025 11:25:16 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> +u32 snd_usb_quirk_flags_from_name(const char *name)
> +{
> +	char *upper;
> +	int i;
> +
> +	upper = kstrdup(name, GFP_KERNEL);
> +
> +	if (!upper)
> +		return 0;
> +
> +	string_upper(upper, upper);
> +
> +	if (!name || !*name)
> +		return 0;
> +
> +	for (i = 0; snd_usb_audio_quirk_flag_names[i]; i++) {
> +		if (strcmp(name, snd_usb_audio_quirk_flag_names[i]) == 0 ||
> +		    strcmp(upper, snd_usb_audio_quirk_flag_names[i]) == 0) {
> +			kfree(upper);
> +			return BIT_U32(i);
> +		}
> +	}
> +
> +	kfree(upper);
> +	return 0;
> +}

I suppose you can write simpler code with strcasecmp().


thanks,

Takashi

