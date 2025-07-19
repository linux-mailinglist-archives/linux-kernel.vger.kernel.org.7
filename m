Return-Path: <linux-kernel+bounces-737821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10195B0B0F2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BEF17EB08
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD82882C4;
	Sat, 19 Jul 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yTjA6xB5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4AS9h1TL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yTjA6xB5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4AS9h1TL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B24801
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752943462; cv=none; b=F5sPKC7imKJzqPgRncmZPWvkAZf0p0DSwLyfjg59/EHhYG49pDwF4osH9kMm2X71D5x4UILitXm1HLa8kdnOcyzuKn8VwxXGU+b/bKCI2U+aC67rTKj2NNbMACmdSICgk1GFQQPPL+/AtvFiAto/0Kj0+xCsc8OiCX+pC9l3fKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752943462; c=relaxed/simple;
	bh=y8laK2J1SsTApwZ8DZZ55o55lcxOeK+EIcKdQzNg9gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS/KSzs4LC+1cTxUJ0y75bnenom6+6UjchXF5fbmUYxHBSFtnO/m7dr9dHSTC3zTNWdv9OZ+zBjVEJ9xZlbbWyJLy3Lp3YrgoiWMe6d0k/DMxbn47FfPQa+r23kXuSYxZsAQux3corYaDLl62IdcrCuPmM5ddv1OB6A+XVaRq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yTjA6xB5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4AS9h1TL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yTjA6xB5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4AS9h1TL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F3251F387;
	Sat, 19 Jul 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752943458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ncFZ7rDn+KjZ1PH29KWJthXk6RHdsQePendrEX2mZ2E=;
	b=yTjA6xB57JUCK2Ybu73Jhcykji+QfTuIEGQX16wXrZojcgL348lnisyE2poUXvgllZE7Gt
	Q/cJ1O6Gw+O+AqslCQd30d5OncPfVdvm+2zjZ1pYBw2Ej/WeO7KliS8xdTRKe5d4DRTlsX
	989V+VJx+zbVbcbFx2KmdO2aySx3mUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752943458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ncFZ7rDn+KjZ1PH29KWJthXk6RHdsQePendrEX2mZ2E=;
	b=4AS9h1TLHwCn+BnPzhhrRYZHTa4h7OIyTfsvjHp/7raxbcu6RT/tC7x7OERNL7PhzV+sSx
	vY/oSySeBcYmxYCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752943458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ncFZ7rDn+KjZ1PH29KWJthXk6RHdsQePendrEX2mZ2E=;
	b=yTjA6xB57JUCK2Ybu73Jhcykji+QfTuIEGQX16wXrZojcgL348lnisyE2poUXvgllZE7Gt
	Q/cJ1O6Gw+O+AqslCQd30d5OncPfVdvm+2zjZ1pYBw2Ej/WeO7KliS8xdTRKe5d4DRTlsX
	989V+VJx+zbVbcbFx2KmdO2aySx3mUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752943458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ncFZ7rDn+KjZ1PH29KWJthXk6RHdsQePendrEX2mZ2E=;
	b=4AS9h1TLHwCn+BnPzhhrRYZHTa4h7OIyTfsvjHp/7raxbcu6RT/tC7x7OERNL7PhzV+sSx
	vY/oSySeBcYmxYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 283D21392A;
	Sat, 19 Jul 2025 16:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qOQhCGLLe2hEKwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Sat, 19 Jul 2025 16:44:18 +0000
Message-ID: <ffbc01f2-5571-4fba-ae73-86f959922bcb@suse.de>
Date: Sat, 19 Jul 2025 18:44:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DRM GUD driver debug logging
To: Ruben Wauters <rubenru09@aol.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <2a6afe3532235c7b76758163e2439e55c93df241.camel.ref@aol.com>
 <2a6afe3532235c7b76758163e2439e55c93df241.camel@aol.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <2a6afe3532235c7b76758163e2439e55c93df241.camel@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[aol.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[aol.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi

Am 17.07.25 um 17:02 schrieb Ruben Wauters:
> Hello
>
> I was taking a look at the code for the gud driver. I am aware this
> driver was recently orphaned and I wish to get up to speed on it, and
> maybe with enough learning and work I can take over maintainance of it
> in the future.

That's fantastic!

There's https://github.com/notro/gud?tab=readme-ov-file and 
https://github.com/notro/gud/wiki for more information about the gud 
protocol and driver.

>
> I noticed that in the function gud_disconnect in gud_driv.c on like 623
> there is the following code
>
> 	drm_dbg(drm, "%s:\n", __func__);
>
> checkpatch.pl marks this as unnecessary ftrace like logging, and
> suggests to use ftrace instead. Since (as far as I can tell) this
> effectively just prints the function name, would it not be better to
> just use ftrace for debugging and remove this call all together?

I'm not a great fan of these types of debugging code. We already have 
this in the DRM core/helpers. Whatever drivers print for debugging 
should be more helpful than just the function name. So IMHO this can be 
removed.

>
> While it isn't actively *harming* the code as such, it does seem a bit
> unnecessary.
>
> I'd like to know the DRM maintainers opinions. I know this particular
> driver does not have a maintainer dedicated to it, so I'd like to know
> the opinion of those that maintain the subsystem, and anyone else that
> has any opinion.

If you want to do meaningful work on the driver, you could replace 
struct drm_simple_display_pipe with the real DRM helpers.  The struct is 
an artifact from older driver designs, but is now obsolete. Drivers are 
supposed to be converted to DRM atomic helpers. For an experienced dev, 
it's a copy-past job. For a newcomer, it's a nice introduction to the 
DRM code. If you want to take a look, you can study commit 4963049ea1ae 
("drm/hyperv: Replace simple-KMS with regular atomic helpers"), which 
recently did this conversion for the hyperv driver.

Best regards
Thomas

>
> Thank you
>
> Ruben Wauters

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


