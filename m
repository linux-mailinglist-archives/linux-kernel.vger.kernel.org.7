Return-Path: <linux-kernel+bounces-736835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034EB0A3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57743A54D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47BB2BD00C;
	Fri, 18 Jul 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AW4t1ESf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JoWzKV9X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AW4t1ESf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JoWzKV9X"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC52571B8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840026; cv=none; b=W/DyFQNJJDNkmxqbyiMOzHQVVslo8Iao20+qXoA4IBkHRB3G0yrxev/GhxEjvznTY+3iYCzZij/1RH9jkkCGWM/XhnDpZLHuPi7Rz60ywY1avjTLlp9Lz8+Wvrr5d4QXeM6jT9SLfXB4YPsjUK6TdNQAaE4vBXXMi62PKehSfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840026; c=relaxed/simple;
	bh=fcbSAGJNj3PFIaaHCuUH76YEPhoKCKl3LQhsJdnp6iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bA+d3PhQw1EZ1+c+0SeoMtMx7xAaSjGiPgRRBLVa3QvtNquosmh3Z4l4tfpT7eMGzVPQP7zTk808Vw1WgTjS8V03pCuqjpgqK17oSnWGIpEcgRnLdZd6T0gfZGgXm15sSl6yXar7iDvWZGaMJLGiKXYEHcfA+RVihefBoz4G5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AW4t1ESf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JoWzKV9X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AW4t1ESf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JoWzKV9X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24AC8211BA;
	Fri, 18 Jul 2025 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752840016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/oJfLE2RimQsDx7Kxa2gwaUv8iRBLCnqa5J0JlzZEpw=;
	b=AW4t1ESfHA7AKc2lbTC+3fgONl+JK3a3YqejRR8LAzfSn2/usiLzOMbdWfJEObJHE0vcBh
	+bFsjOD1tk+Q7fp1/dYN/mm5JEsEdip/uUwZj4baAHqHswnRpk8aOiDZcU32e3d3RPvcOX
	vejzuFhQkOkZ4OAlUMOzKTMKTF7hjTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752840016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/oJfLE2RimQsDx7Kxa2gwaUv8iRBLCnqa5J0JlzZEpw=;
	b=JoWzKV9XahOb3PtuJkt+NcqpySz0mBXvlR1Sp9EMHrqQRpxI2HXb23pfyvhTzzS0Ye8vex
	i2qG3J7wZ54dezCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AW4t1ESf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JoWzKV9X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752840016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/oJfLE2RimQsDx7Kxa2gwaUv8iRBLCnqa5J0JlzZEpw=;
	b=AW4t1ESfHA7AKc2lbTC+3fgONl+JK3a3YqejRR8LAzfSn2/usiLzOMbdWfJEObJHE0vcBh
	+bFsjOD1tk+Q7fp1/dYN/mm5JEsEdip/uUwZj4baAHqHswnRpk8aOiDZcU32e3d3RPvcOX
	vejzuFhQkOkZ4OAlUMOzKTMKTF7hjTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752840016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/oJfLE2RimQsDx7Kxa2gwaUv8iRBLCnqa5J0JlzZEpw=;
	b=JoWzKV9XahOb3PtuJkt+NcqpySz0mBXvlR1Sp9EMHrqQRpxI2HXb23pfyvhTzzS0Ye8vex
	i2qG3J7wZ54dezCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7B7F13A52;
	Fri, 18 Jul 2025 12:00:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jcozM083emj7CQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 18 Jul 2025 12:00:15 +0000
Message-ID: <fbb77c0f-2bc1-45b4-9475-d2b17c9bcf8b@suse.de>
Date: Fri, 18 Jul 2025 14:00:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sitronix/st7571-i2c: Make st7571_panel_data to be
 static variables
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
References: <20250718072541.686759-1-javierm@redhat.com>
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
In-Reply-To: <20250718072541.686759-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 24AC8211BA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.01

Hi Javier

Am 18.07.25 um 09:25 schrieb Javier Martinez Canillas:
> The kernel test robot reported that sparse gives the following warnings:
>
> make C=2 M=drivers/gpu/drm/sitronix/
>    CC [M]  st7571-i2c.o
>    CHECK   st7571-i2c.c
> st7571-i2c.c:1027:26: warning: symbol 'st7567_config' was not declared. Should it be static?
> st7571-i2c.c:1039:26: warning: symbol 'st7571_config' was not declared. Should it be static?
>    MODPOST Module.symvers
>    LD [M]  st7571-i2c.ko
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507180503.nfyD9uRv-lkp@intel.com
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>   drivers/gpu/drm/sitronix/st7571-i2c.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
> index 453eb7e045e5..7fe5b69e6f2f 100644
> --- a/drivers/gpu/drm/sitronix/st7571-i2c.c
> +++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
> @@ -1024,7 +1024,7 @@ static void st7571_remove(struct i2c_client *client)
>   	drm_dev_unplug(&st7571->dev);
>   }
>   
> -struct st7571_panel_data st7567_config = {
> +static struct st7571_panel_data st7567_config = {

Make it 'static const' please. Here and below.

Best regards
Thomas

>   	.init = st7567_lcd_init,
>   	.parse_dt = st7567_parse_dt,
>   	.constraints = {
> @@ -1036,7 +1036,7 @@ struct st7571_panel_data st7567_config = {
>   	},
>   };
>   
> -struct st7571_panel_data st7571_config = {
> +static struct st7571_panel_data st7571_config = {
>   	.init = st7571_lcd_init,
>   	.parse_dt = st7571_parse_dt,
>   	.constraints = {

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


