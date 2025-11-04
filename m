Return-Path: <linux-kernel+bounces-884548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD485C30675
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512AE189705D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7442D3728;
	Tue,  4 Nov 2025 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g8RrpGjx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KK/oC2S3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g8RrpGjx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KK/oC2S3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E92D23BD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250507; cv=none; b=YYZS/PZYXosHWPRMqCOAea+eKk6VHSLpzgzu1yhR3AWJAQXH3rWOSowA3iNWIDUQvvRjxVy1aseT7DjM1uhd/73LBod9QLtOER6325Q5mqdJfCgn8H8iJycCF3dwVl2Sx9fE30KFRwCc4ZatRMbeVGUT/Q0yqh7oIesiEE5qTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250507; c=relaxed/simple;
	bh=Vp8s1sFUhZEtTmOe3NnIXBtWE7EhfmGKuCuGH0ddg5U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRyG+DTSqJGsJWAixlob4X7NpIau7VCciRJOa3Dkr5z9r+hzR/9qt+DXrst1xW2vJUOHg6CXYQGLQq8f2NOmYXpWq8mDTDIszAjNmnyMi8sLFICzk2J7h0943lw8FRIS3xQSYjcxY5jVyeTRsfXxDQFJm8D6eZ2v9NRcJMjuU1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g8RrpGjx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KK/oC2S3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g8RrpGjx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KK/oC2S3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BED391F385;
	Tue,  4 Nov 2025 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762250503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvML9ahiMNR24WsBOuMm7W2eYvpxZcIULBQYbrFHl1I=;
	b=g8RrpGjxsyYPqGI5s8P0WTepWACzYbr7YdwbUHI1rwwNXJQAAFvzLpfUpzju5lHIDBYRbg
	CvzLnJ12Mn1LzQCEoKQlzrHvicwZ/+6iEV6wLYWRScOPu751zLiAscFFgMXG4QmYG2PLn/
	dW7p+mdjKAb5DjnKhdFsEEwsaksZBx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762250503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvML9ahiMNR24WsBOuMm7W2eYvpxZcIULBQYbrFHl1I=;
	b=KK/oC2S3am5LZLEqgIsNa02QrA7XYCsH3DEo2CMl9ueIAKo6+FeHPc2nrPBDUPSPmnp/uN
	PH24WTdTW6yybXDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762250503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvML9ahiMNR24WsBOuMm7W2eYvpxZcIULBQYbrFHl1I=;
	b=g8RrpGjxsyYPqGI5s8P0WTepWACzYbr7YdwbUHI1rwwNXJQAAFvzLpfUpzju5lHIDBYRbg
	CvzLnJ12Mn1LzQCEoKQlzrHvicwZ/+6iEV6wLYWRScOPu751zLiAscFFgMXG4QmYG2PLn/
	dW7p+mdjKAb5DjnKhdFsEEwsaksZBx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762250503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvML9ahiMNR24WsBOuMm7W2eYvpxZcIULBQYbrFHl1I=;
	b=KK/oC2S3am5LZLEqgIsNa02QrA7XYCsH3DEo2CMl9ueIAKo6+FeHPc2nrPBDUPSPmnp/uN
	PH24WTdTW6yybXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E55B136D1;
	Tue,  4 Nov 2025 10:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xD2mHQfPCWmtOwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Nov 2025 10:01:43 +0000
Date: Tue, 04 Nov 2025 11:01:43 +0100
Message-ID: <874irai0ag.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: moonafterrain@outlook.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH v2] ALSA: wavefront: use scnprintf for longname construction
In-Reply-To: <SYBPR01MB7881987D79C62D8122B655FEAFC6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881987D79C62D8122B655FEAFC6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Sun, 02 Nov 2025 16:32:39 +0100,
moonafterrain@outlook.com wrote:
> 
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> Replace sprintf() calls with scnprintf() and a new scnprintf_append()
> helper function when constructing card->longname. This improves code
> readability and provides bounds checking for the 80-byte buffer.
> 
> While the current parameter ranges don't cause overflow in practice,
> using safer string functions follows kernel best practices and makes
> the code more maintainable.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> Changes in v2:
> - Replace sprintf() calls with scnprintf() and a new scnprintf_append()
> - Link to v1: https://lore.kernel.org/all/ME2PR01MB3156CEC4F31F253C9B540FB7AFFDA@ME2PR01MB3156.ausprd01.prod.outlook.com/

Well, my suggestion was that we can apply such conversions once if a
*generic* helper becomes available; that is, propose
scnprintf_append() to be put in include/linux/string.h or whatever (I
guess better in *.c instead of inline), and once if it's accepted, we
can convert the relevant places (there are many, not only
wavefront.c).

BTW:

> +__printf(3, 4) static int scnprintf_append(char *buf, size_t size, const char *fmt, ...)
> +{
> +	va_list args;
> +	size_t len = strlen(buf);
> +
> +	if (len >= size)
> +		return len;
> +	va_start(args, fmt);
> +	len = vscnprintf(buf + len, size - len, fmt, args);
> +	va_end(args);
> +	return len;

The above should be
	len += vscnprintf(buf + len, size - len, fmt, args);
so that it returns the full size of the string.
If it were in user-space, I'd check a negative error code, but the
Linux kernel implementation doesn't return a negative error code, so
far.
I see it's a copy from a code snipped I suggested which already
contained the error :)

Also, it might be safer to use strnlen() instead of strlen() for
avoiding a potential out-of-bound access.


thanks,

Takashi

