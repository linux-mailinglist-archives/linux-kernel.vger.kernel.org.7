Return-Path: <linux-kernel+bounces-813230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36DB54243
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213F83B2E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E42777F1;
	Fri, 12 Sep 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yOn4bTL8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u2zUVx2h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yOn4bTL8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u2zUVx2h"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C5270EA5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757656525; cv=none; b=c+gj0Vgo7S2sVB8n9m9Xys5cCPmYoLf/V0nsultmBelgO5DNNk8hU7//dbLEdipwOs1NGROUObvGQr3a11ZVPcREVRrqYnkGs1Q9t/K93BiytfjqGb7RkSSpELhtLz9ovNlHakg9gg8hZgXCxMJWh2bI6xt1cFo1L8CiwgkgswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757656525; c=relaxed/simple;
	bh=lgUEGovzCjKtlADCHoKjq1sOkO6WmfBcSCyuX7IWvsE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVIvgsi4nsXxxmLGnxIOdQGsW6FExR5AjhPTkQnBoKQQ80cuR00sEpMD8ktq3ZiaIDxWxCy6NreQKbME8J+rGycZ0CTeIGSNvZXJwrech6kKpuUeSIG1jzqrGdSeciOs1jLAYOnDYXdYIqWCVTHnQMsWRhDe+NI+AGnxouB3eMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yOn4bTL8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u2zUVx2h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yOn4bTL8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u2zUVx2h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6B7F5BE38;
	Fri, 12 Sep 2025 05:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757656520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xQEp3B25Gx2dkBzqDFJpJ6L/oyw2iAMxDoyI8L6eok=;
	b=yOn4bTL8JcA9wBlmvO/SmwRFTxUq82yFBx+dfm6uJiUiTkwzZLADyt+CcwxH6QgtF30x1V
	qXe6Fihi6X1ubicgPlGPd8l9/n+QUM3KxF2/otBOKQN7Y0r3zB3rpuEWUN9sHusx2KNhfJ
	BUwgz3ekMdR1L2JgKbhHCN/ceXIyHzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757656520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xQEp3B25Gx2dkBzqDFJpJ6L/oyw2iAMxDoyI8L6eok=;
	b=u2zUVx2hD7kB0HMlkgtor8CkvGkatKWoigZaUlnKgprjZ3y9upehqYVrQN93nO6ZwLQTpP
	letyluOB2yvt0QAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757656520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xQEp3B25Gx2dkBzqDFJpJ6L/oyw2iAMxDoyI8L6eok=;
	b=yOn4bTL8JcA9wBlmvO/SmwRFTxUq82yFBx+dfm6uJiUiTkwzZLADyt+CcwxH6QgtF30x1V
	qXe6Fihi6X1ubicgPlGPd8l9/n+QUM3KxF2/otBOKQN7Y0r3zB3rpuEWUN9sHusx2KNhfJ
	BUwgz3ekMdR1L2JgKbhHCN/ceXIyHzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757656520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xQEp3B25Gx2dkBzqDFJpJ6L/oyw2iAMxDoyI8L6eok=;
	b=u2zUVx2hD7kB0HMlkgtor8CkvGkatKWoigZaUlnKgprjZ3y9upehqYVrQN93nO6ZwLQTpP
	letyluOB2yvt0QAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86A77136DB;
	Fri, 12 Sep 2025 05:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2CaiH8i1w2i+ewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Sep 2025 05:55:20 +0000
Date: Fri, 12 Sep 2025 07:55:20 +0200
Message-ID: <87cy7wrz93.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Uwe =?ISO-8859-1?Q?Klein?=
 =?ISO-8859-1?Q?e-K=F6nig?= <u.kleine-koenig@baylibre.com>,	Takashi Iwai
 <tiwai@suse.de>,	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: Remove redundant size arguments from strscpy()
In-Reply-To: <20250911214334.1482982-2-thorsten.blum@linux.dev>
References: <20250911214334.1482982-2-thorsten.blum@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Thu, 11 Sep 2025 23:43:22 +0200,
Thorsten Blum wrote:
> 
> The size parameter of strscpy() is optional if the destination buffer
> has a fixed length and strscpy() can automatically determine its size
> using sizeof(). This makes many explicit size arguments redundant.
> 
> Remove them to shorten and simplify the code.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks, applied now.


Takashi

