Return-Path: <linux-kernel+bounces-729670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38BB03A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1955418913CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F6E23D29C;
	Mon, 14 Jul 2025 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M/HTUKdw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DgkXCmSx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M/HTUKdw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DgkXCmSx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594723C51B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483366; cv=none; b=nbFNoQNt4RxxAqJYp9x+lpb5CbQ+yLfOOcVHFeNzn243/KOfN7HFHV9VtfIlG4ONh3SWfjowZ25Kc3ajFYwtojUhF7/bnj2CKNyW6j+izQ97fg+kh8RcJ+2+R3hR2Gf1byPAAICFIQG/99YSpkYC9BvKx7r+QJGmWifvrSKm6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483366; c=relaxed/simple;
	bh=2Z1minpMo+mB2N1vhwPRzsupvPs4cWiCrDuWYmpuxZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5ecm6gYJS5PGZefs4BKXZuLtEHUAarGFwAr9uirwnJRLB2YnE/+3r0NCWusUiUaA69hYw20x+lhcyV9iYli50XCnVFX/a8JR2w90bujqnLBJOJqdcBB2+YBwpJfq/sKKvvqWqr3HJ/oS2bxLs1zINHNKncQaLaf8ZJ8dgAKm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M/HTUKdw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DgkXCmSx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M/HTUKdw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DgkXCmSx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F00951F80B;
	Mon, 14 Jul 2025 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752483359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rgl+dgWGyWcfaNXJYYyIB+s9vydjAZwMOjZ8CA9qpCs=;
	b=M/HTUKdwSmqoSx3KkIsrH8Rgyy0LTRu9n+5GvDloh2gzWkzK25Tn0S4z9u0A8qUSwBfQ8R
	/ykGxmckHDNKS4Lczx/tQCj1fJbTYOZGJk8Df7toR3k6v4Op7ErcPfonTnKIou0mz5uSsN
	Vv3cAi3DMjFWfWX+oyObfJ26kXC/PBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752483359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rgl+dgWGyWcfaNXJYYyIB+s9vydjAZwMOjZ8CA9qpCs=;
	b=DgkXCmSxV2DTepkuBYkfv+yxMWFuFT9BiUM4+hGtaZUQBtw12RsT+o2aYilG2GEA4dBHTG
	oF9I2II9tXk3gHDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="M/HTUKdw";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DgkXCmSx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752483359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rgl+dgWGyWcfaNXJYYyIB+s9vydjAZwMOjZ8CA9qpCs=;
	b=M/HTUKdwSmqoSx3KkIsrH8Rgyy0LTRu9n+5GvDloh2gzWkzK25Tn0S4z9u0A8qUSwBfQ8R
	/ykGxmckHDNKS4Lczx/tQCj1fJbTYOZGJk8Df7toR3k6v4Op7ErcPfonTnKIou0mz5uSsN
	Vv3cAi3DMjFWfWX+oyObfJ26kXC/PBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752483359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rgl+dgWGyWcfaNXJYYyIB+s9vydjAZwMOjZ8CA9qpCs=;
	b=DgkXCmSxV2DTepkuBYkfv+yxMWFuFT9BiUM4+hGtaZUQBtw12RsT+o2aYilG2GEA4dBHTG
	oF9I2II9tXk3gHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 140AA138A1;
	Mon, 14 Jul 2025 08:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QBF/Ax7GdGg7NwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 14 Jul 2025 08:55:58 +0000
Message-ID: <a5cb70b2-f724-4d5e-910c-0b92dd759ebf@suse.de>
Date: Mon, 14 Jul 2025 10:55:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/sitronix/st7571-i2c: Make the reset GPIO to be
 optional
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: ipedrosa@redhat.com, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
References: <20250710102453.101078-1-javierm@redhat.com>
 <20250710102453.101078-3-javierm@redhat.com>
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
In-Reply-To: <20250710102453.101078-3-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: F00951F80B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Hi

Am 10.07.25 um 12:24 schrieb Javier Martinez Canillas:
> Some Sitronix LCD controllers (such as the ST7567) don't have a reset pin,
> so lets relax this in the driver and make the reset GPIO to be optional.
>
> The devm_gpiod_get_optional() helper is similar to devm_gpiod_get(), but
> returns NULL when there isn't a reset-gpios property defined in a DT node.
>
> The DT binding schema for "sitronix,st7571" that require a reset GPIO will
> enforce the "reset-gpios" to be present, due being a required DT property.
> But in the driver itself the property can be made optional if not defined.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>   drivers/gpu/drm/sitronix/st7571-i2c.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
> index eec846892962..73e8db25f895 100644
> --- a/drivers/gpu/drm/sitronix/st7571-i2c.c
> +++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
> @@ -802,15 +802,19 @@ static int st7571_parse_dt(struct st7571_device *st7571)
>   	st7571->nlines = dt.vactive.typ;
>   	st7571->ncols = dt.hactive.typ;
>   
> -	st7571->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	st7571->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(st7571->reset))
> -		return PTR_ERR(st7571->reset);
> +		return dev_err_probe(dev, PTR_ERR(st7571->reset),
> +				     "Failed to get reset gpio\n");

There's struct st7571_panel_data. It could store a flag signalling the 
expected behavior.

With more effort the panel_data could store a dedicated parse_dt pointer 
for each panel type. ASAICT the st7567 features a subset of the other 
type. So there might not be much code duplication.

Best regards
Thomas

>   
>   	return 0;
>   }
>   
>   static void st7571_reset(struct st7571_device *st7571)
>   {
> +	if (!st7571->reset)
> +		return;
> +
>   	gpiod_set_value_cansleep(st7571->reset, 1);
>   	fsleep(20);
>   	gpiod_set_value_cansleep(st7571->reset, 0);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


