Return-Path: <linux-kernel+bounces-762633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD8B20928
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B593B7229
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40923E23C;
	Mon, 11 Aug 2025 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WudLc4hV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uVbpOwBz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WudLc4hV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uVbpOwBz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274633D8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916487; cv=none; b=dCw+6EGRKLRboh9AYiVZF1LFfuW4L6lw1ZxB34+IAUVIbiwSsZS2iPqhEcAfNf+A9A01RaeOvDCD0N28MI0P6LxgLs3WlxhjqrhTOf+gkECevWEs3NE60X684zkA+mvuenGNQGvhBTZuk/1g6fN9tiWVYpkp051h7t0jyJANlXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916487; c=relaxed/simple;
	bh=9H/oZXQ/Gi2agQ1XQe5hIzENt9mDcqNzoFZht7dLvrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwPAiniWzYymtimZfPYkvzwnldkQOtLvDdLOXiH0QX20D8MWJobViiTAYgD/A57Id7wDVfciOWLaAMsY1sAk+h98KAqd/l+DI4maUMKeRvjWyFdUbFnEDA2Z66IPJ6Uw9nM1AZtshQOqHnU1dWxdeagn8WBRfrF26kklwdmLc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WudLc4hV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uVbpOwBz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WudLc4hV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uVbpOwBz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AAFEE1F394;
	Mon, 11 Aug 2025 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754916483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LPsaSA5l9tBi5cmuT8dGQNBkJkOGkKM0UuwzBdNIq1M=;
	b=WudLc4hVvW4yHnfe9uJuzHKVm/Q3J0hvDDk3XO0vJoK/Uz5YZQ9+3Xt5qXlKEy43QVkxrC
	evFk3gtTrxqiK+3SfwocJgkrsAUhOCVBfrC5GSIB0EluG/1r40YC4VN5ZuKxLBji2jhVsF
	ACqSZ/csXflW/nJqSiKAz6Lw7eWFM24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754916483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LPsaSA5l9tBi5cmuT8dGQNBkJkOGkKM0UuwzBdNIq1M=;
	b=uVbpOwBzNQtnbrFA2KUQMXeZFawcOqKOpYd+MPIRRmhqSJUJnTd3BgxSoRnODpwNEvVvOu
	O6C57LQmR5lJgyAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754916483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LPsaSA5l9tBi5cmuT8dGQNBkJkOGkKM0UuwzBdNIq1M=;
	b=WudLc4hVvW4yHnfe9uJuzHKVm/Q3J0hvDDk3XO0vJoK/Uz5YZQ9+3Xt5qXlKEy43QVkxrC
	evFk3gtTrxqiK+3SfwocJgkrsAUhOCVBfrC5GSIB0EluG/1r40YC4VN5ZuKxLBji2jhVsF
	ACqSZ/csXflW/nJqSiKAz6Lw7eWFM24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754916483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LPsaSA5l9tBi5cmuT8dGQNBkJkOGkKM0UuwzBdNIq1M=;
	b=uVbpOwBzNQtnbrFA2KUQMXeZFawcOqKOpYd+MPIRRmhqSJUJnTd3BgxSoRnODpwNEvVvOu
	O6C57LQmR5lJgyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73AF413479;
	Mon, 11 Aug 2025 12:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5VPaGoPmmWigNwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 11 Aug 2025 12:48:03 +0000
Message-ID: <d20ea5f0-737e-48a7-8311-fba8474bfd7a@suse.de>
Date: Mon, 11 Aug 2025 14:48:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] gpu: drm: fix compilation errors in drm_vram_helper
To: chuguangqing <chuguangqing@inspur.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250729060728.82402-1-chuguangqing@inspur.com>
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
In-Reply-To: <20250729060728.82402-1-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[inspur.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Hi

Am 29.07.25 um 08:07 schrieb chuguangqing:
> We encountered the following errors while compiling drm_vram_helper.ko
>
> ERROR: modpost: "drm_gem_ttm_print_info" [drivers/gpu/drm/drm_vram_helper.ko] undefined!
> ERROR: modpost: "drm_gem_ttm_mmap" [drivers/gpu/drm/drm_vram_helper.ko] undefined!
>
> The functions drm_gem_ttm_mmap and drm_gem_ttm_print_info are defined in drm_gem_ttm_helper.c. This patch adds drm_gem_ttm_helper.o to DRM_VRAM_HELPER to resolve the undefined symbol errors.

You need to select DRM_TTM_HELPER for your driver.

Best regards
Thomas

>
> Signed-off-by: chuguangqing <chuguangqing@inspur.com>
> ---
>   drivers/gpu/drm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 4dafbdc8f86a..abbe32ddf6d0 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -125,7 +125,7 @@ drm_suballoc_helper-y := drm_suballoc.o
>   obj-$(CONFIG_DRM_SUBALLOC_HELPER) += drm_suballoc_helper.o
>   
>   drm_vram_helper-y := drm_gem_vram_helper.o
> -obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o
> +obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o drm_gem_ttm_helper.o
>   
>   drm_ttm_helper-y := drm_gem_ttm_helper.o
>   drm_ttm_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_ttm.o

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



