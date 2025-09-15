Return-Path: <linux-kernel+bounces-816760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A765AB57802
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD20188CB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AB02FC013;
	Mon, 15 Sep 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fJbY80Bm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZFCyZwxL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fJbY80Bm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZFCyZwxL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A845224B04
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935492; cv=none; b=fNdke9yK5kUGeC/IZSOEpIBkLNJJ5NV4dShfelInr99kCSomm+18hj7ky23CnPzZUfAGdzIvCDK73WdA6eEuuQ8C8aPBScGmj/NGmSPNrSLFSNEv64a6bGpFh4ecofU3bypwZ0cgv6QTc9xO1Ny6JG2jKJeJjU48ssoHLAiwEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935492; c=relaxed/simple;
	bh=CZTo1LJ65D18BH83yguOU90aKb4d6iBWVaaAYpEWc1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEvE6hosRHqUfKlWXppz+qNwSW5FOhW6eWgrrDY9Aw9MijR3OgzoenObQ62wiO1FyjsfB/X/Q1NjbVLLbyma0UGsAuHBA/31/Pof6+i0MZw/m0zM/+aTIEf/Nn8B09TpW0osoW+NxfVGp90UZ4QijoHcO5BtCwEj7/1oFjChUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fJbY80Bm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZFCyZwxL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fJbY80Bm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZFCyZwxL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8837E336AC;
	Mon, 15 Sep 2025 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757935488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HzNdP6VqDsin1Cb11iea0Brf5KWxOLVKBjMfukB+42E=;
	b=fJbY80BmPG30qRAzTQZoVyizlJs88CuYGZotTZBMDvyUXb/LCFPZ3pCFtJjANElb89iK6j
	O0HaQSUit3awoya3JUcEQz0XjiYaL1CsyBgbMxyFd36Naj0AWrzaDr2/k+waf4sCwGkDII
	BhWMxU04/+Zj4ZDyZxYL9t2+H13aob0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757935488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HzNdP6VqDsin1Cb11iea0Brf5KWxOLVKBjMfukB+42E=;
	b=ZFCyZwxL+uMLOMwNsDqIR9KGq9n8Gb/e8TUiZJYbB9jC3sSdIIcCTuZFsYNtdT0R1yX96x
	vKtPP1NAj4jI+ECw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757935488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HzNdP6VqDsin1Cb11iea0Brf5KWxOLVKBjMfukB+42E=;
	b=fJbY80BmPG30qRAzTQZoVyizlJs88CuYGZotTZBMDvyUXb/LCFPZ3pCFtJjANElb89iK6j
	O0HaQSUit3awoya3JUcEQz0XjiYaL1CsyBgbMxyFd36Naj0AWrzaDr2/k+waf4sCwGkDII
	BhWMxU04/+Zj4ZDyZxYL9t2+H13aob0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757935488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HzNdP6VqDsin1Cb11iea0Brf5KWxOLVKBjMfukB+42E=;
	b=ZFCyZwxL+uMLOMwNsDqIR9KGq9n8Gb/e8TUiZJYbB9jC3sSdIIcCTuZFsYNtdT0R1yX96x
	vKtPP1NAj4jI+ECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 481411372E;
	Mon, 15 Sep 2025 11:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3q0gEID3x2iXJAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 15 Sep 2025 11:24:48 +0000
Message-ID: <8c445737-bb23-4026-954b-61b234be9932@suse.de>
Date: Mon, 15 Sep 2025 13:24:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/solomon: Code improvements and DRM helper
 adoption
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
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
In-Reply-To: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,linux.intel.com,kernel.org,ffwll.ch];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Hi

Am 12.09.25 um 18:42 schrieb Iker Pedrosa:
> This patch series improves the Solomon SSD130x DRM driver by adopting
> existing DRM helpers, improving code clarity, and following kernel
> coding standards.
>
> * Patch #1 moves DRM GEM framebuffer CPU access calls to make critical
>    sections more visible and maintainable.
> * Patch #2 replaces WARN_ON with drm_WARN_ON_ONCE to prevent log spam.
> * Patch #3 adopts drm_crtc_helper_mode_valid_fixed() for mode
>    validation.
> * Patch #4 adopts drm_connector_helper_get_modes_fixed() for mode
>    management.
> * Patch #5 enforces one assignment per line per kernel coding style.
>
> These improvements reduce code duplication by leveraging existing DRM
> infrastructure and enhance code readability without changing
> functionality.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

For the series

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

It should also get Javier's reviews before getting merged.

Best regards
Thomas

> ---
> Iker Pedrosa (5):
>        drm/solomon: Move calls to drm_gem_fb_end_cpu*()
>        drm/solomon: Use drm_WARN_ON_ONCE instead of WARN_ON
>        drm/solomon: Simplify mode_valid() using DRM helper
>        drm/solomon: Simplify get_modes() using DRM helper
>        drm/solomon: Enforce one assignment per line
>
>   drivers/gpu/drm/solomon/ssd130x.c | 77 +++++++++++++++------------------------
>   1 file changed, 29 insertions(+), 48 deletions(-)
> ---
> base-commit: c571cb70e1ed43ee543c70151e61a001ab2eefa2
> change-id: 20250912-improve-ssd130x-b45b89ff4693
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



