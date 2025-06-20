Return-Path: <linux-kernel+bounces-695411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD6AE197D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42031BC57C5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1096289811;
	Fri, 20 Jun 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1puoBEJk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f6slLtQc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1puoBEJk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f6slLtQc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957628934A
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417340; cv=none; b=oKGrvzJ2xYLQj71pFlPTDHrJP7H7juVJFHp1cMMqbmKOtbuL+zP4/Ttec++GFvSEDEjYXCrvs5NCvICLBkpHPrZiemzaDJkiZBCvG/KLpgxlpzfJQWc6XMX6EeonLvwxWbzy668b+j7ivo0zxlLZdlr9vh0s1QvUaRIUL10zP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417340; c=relaxed/simple;
	bh=zmV4806JVOWPLzrvPqmid4gN6v5hPUhpLvhhA4/ahAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8cu4gtFimy1Wn0bCsNj/MVIE/CGWL3flQv/maqejs/iopM6dfKEEhOvhI0S/oVNtONbukFsFq/z3L5DBO0I/D5rmEIv+MHb5DIaFnIDfDb1z2ubbtjToeMW1uJAZtqrL1A89wJRGNYKjkGiyxff1+tN/N3Z2wiVSRPfRHxjK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1puoBEJk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f6slLtQc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1puoBEJk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f6slLtQc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 654F51F390;
	Fri, 20 Jun 2025 11:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750417335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xYtH4KzYfQFnIOsPl+GHBvUXtKQ554CwNSubfr1Rwb0=;
	b=1puoBEJkkSXgMCtJXlHMo/PjEeGCO12JMJ694GDv7hzLm1N7b+09p5aY9RJ1XULvNJZZNW
	g1E5wxk6kR3fh16tBhwRLoREHRtjkO/knxNcLvhwf2zn6V+SozNnFNJfp8JhjPoL8CLp8K
	A1HWSbgYzzGl3igTGgIVSVyefaa2hyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750417335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xYtH4KzYfQFnIOsPl+GHBvUXtKQ554CwNSubfr1Rwb0=;
	b=f6slLtQcggdux0UWBINW2cNKPZztBNXHjtTugn4fSPzYsLTlV2K4nR6eB2tz+O05OF89Ky
	/iG3UJ/fUqwFH3CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750417335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xYtH4KzYfQFnIOsPl+GHBvUXtKQ554CwNSubfr1Rwb0=;
	b=1puoBEJkkSXgMCtJXlHMo/PjEeGCO12JMJ694GDv7hzLm1N7b+09p5aY9RJ1XULvNJZZNW
	g1E5wxk6kR3fh16tBhwRLoREHRtjkO/knxNcLvhwf2zn6V+SozNnFNJfp8JhjPoL8CLp8K
	A1HWSbgYzzGl3igTGgIVSVyefaa2hyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750417335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xYtH4KzYfQFnIOsPl+GHBvUXtKQ554CwNSubfr1Rwb0=;
	b=f6slLtQcggdux0UWBINW2cNKPZztBNXHjtTugn4fSPzYsLTlV2K4nR6eB2tz+O05OF89Ky
	/iG3UJ/fUqwFH3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01719136BA;
	Fri, 20 Jun 2025 11:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eByUOrY/VWhPDwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 20 Jun 2025 11:02:14 +0000
Message-ID: <cf29862b-496b-4825-aa0f-493eb44838a5@suse.de>
Date: Fri, 20 Jun 2025 13:02:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fbdev/simplefb: Add support for interconnect paths
To: Luca Weiss <luca.weiss@fairphone.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620-simple-drm-fb-icc-v1-0-d92142e8f74f@fairphone.com>
 <20250620-simple-drm-fb-icc-v1-3-d92142e8f74f@fairphone.com>
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
In-Reply-To: <20250620-simple-drm-fb-icc-v1-3-d92142e8f74f@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[fairphone.com,redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,gmx.de];
	TAGGED_RCPT(0.00)[dt];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,fairphone.com:email]
X-Spam-Level: 

Hi

Am 20.06.25 um 12:31 schrieb Luca Weiss:
> Some devices might require keeping an interconnect path alive so that
> the framebuffer continues working. Add support for that by setting the
> bandwidth requirements appropriately for all provided interconnect
> paths.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/video/fbdev/simplefb.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
>
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index be95fcddce4c8ca794826b805cd7dad2985bd637..ca73e079fd13550ddc779e84db80f7f9b743d074 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -27,6 +27,7 @@
>   #include <linux/parser.h>
>   #include <linux/pm_domain.h>
>   #include <linux/regulator/consumer.h>
> +#include <linux/interconnect.h>

With alphabetical sorting:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas


>   
>   static const struct fb_fix_screeninfo simplefb_fix = {
>   	.id		= "simple",
> @@ -89,6 +90,10 @@ struct simplefb_par {
>   	u32 regulator_count;
>   	struct regulator **regulators;
>   #endif
> +#if defined CONFIG_OF && defined CONFIG_INTERCONNECT
> +	unsigned int icc_count;
> +	struct icc_path **icc_paths;
> +#endif
>   };
>   
>   static void simplefb_clocks_destroy(struct simplefb_par *par);
> @@ -525,6 +530,80 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
>   }
>   #endif
>   
> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> +/*
> + * Generic interconnect path handling code.
> + */
> +static void simplefb_detach_icc(void *res)
> +{
> +	struct simplefb_par *par = res;
> +	int i;
> +
> +	for (i = par->icc_count - 1; i >= 0; i--) {
> +		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
> +			icc_put(par->icc_paths[i]);
> +	}
> +}
> +
> +static int simplefb_attach_icc(struct simplefb_par *par,
> +			       struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret, count, i;
> +
> +	count = of_count_phandle_with_args(dev->of_node, "interconnects",
> +							 "#interconnect-cells");
> +	if (count < 0)
> +		return 0;
> +
> +	/* An interconnect path consists of two elements */
> +	if (count % 2) {
> +		dev_err(dev, "invalid interconnects value\n");
> +		return -EINVAL;
> +	}
> +	par->icc_count = count / 2;
> +
> +	par->icc_paths = devm_kcalloc(dev, par->icc_count,
> +				      sizeof(*par->icc_paths),
> +				      GFP_KERNEL);
> +	if (!par->icc_paths)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < par->icc_count; i++) {
> +		par->icc_paths[i] = of_icc_get_by_index(dev, i);
> +		if (IS_ERR_OR_NULL(par->icc_paths[i])) {
> +			ret = PTR_ERR(par->icc_paths[i]);
> +			if (ret == -EPROBE_DEFER)
> +				goto err;
> +			dev_err(dev, "failed to get interconnect path %u: %d\n", i, ret);
> +			continue;
> +		}
> +
> +		ret = icc_set_bw(par->icc_paths[i], 0, UINT_MAX);
> +		if (ret) {
> +			dev_err(dev, "failed to set interconnect bandwidth %u: %d\n", i, ret);
> +			continue;
> +		}
> +	}
> +
> +	return devm_add_action_or_reset(dev, simplefb_detach_icc, par);
> +
> +err:
> +	while (i) {
> +		--i;
> +		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
> +			icc_put(par->icc_paths[i]);
> +	}
> +	return ret;
> +}
> +#else
> +static int simplefb_attach_icc(struct simplefb_par *par,
> +			       struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +#endif
> +
>   static int simplefb_probe(struct platform_device *pdev)
>   {
>   	int ret;
> @@ -615,6 +694,10 @@ static int simplefb_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		goto error_regulators;
>   
> +	ret = simplefb_attach_icc(par, pdev);
> +	if (ret < 0)
> +		goto error_regulators;
> +
>   	simplefb_clocks_enable(par, pdev);
>   	simplefb_regulators_enable(par, pdev);
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


