Return-Path: <linux-kernel+bounces-773037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0DB29AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90E47A41FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2027A448;
	Mon, 18 Aug 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X3a2ttWF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4TjsnFb0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X3a2ttWF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4TjsnFb0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02626279DA4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501593; cv=none; b=fKmlxc51NtDoPjoHgswMzL55qTxr3Ouie1XmRbkYsQlT1PSN6vKLlDkPLiwLm13EFzEsIzX4uHpP3HSTraPGhyYoXXP99OgwS8S+7gZ+Lf4HQCTutMQ9wT2kDYe4ISgPKEWq7D04JM7/KyDGI3TmHaTXV35+F+UiVxuV51LGuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501593; c=relaxed/simple;
	bh=t6AgPSQ28rWSgokcDKN6mlhg4ohK0Oo9SU0kuGqj+rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4ECiU8Ad8TgDlMAFQzNVU8mnIdUUWoS614iFHFMYLYtQChViHFVSxbBSQNh4N+YPfIcC6fp5UhHfHi1LN0x3CdkCGdV/YzmrtDFaNeYiThb20RUKb25naJEGeumKdmzyJA+eQmJbyZ+Khk9aNnseWP6PAgM7Ey9dJkaxUycJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X3a2ttWF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4TjsnFb0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X3a2ttWF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4TjsnFb0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1AF1C2124E;
	Mon, 18 Aug 2025 07:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755501590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fDObMno5796K3X+vCGAZ9Nq4/Zn9DnIJRXDn7rn8wvY=;
	b=X3a2ttWF3iUqhZhs6Sb35gcmGsQJi1mboSUF4LCyesMtaTzy01g/M0jgxe1p7CbAWqjogv
	edV8k91ebfFLY/hqoGfTv4nCgrwnOHEjk7JC219tkO066n/RPRDbMI4i3/+0li0XGjFnAF
	JEOCcGZriZO3grbBQkLsi+/PKXFsULY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755501590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fDObMno5796K3X+vCGAZ9Nq4/Zn9DnIJRXDn7rn8wvY=;
	b=4TjsnFb0Prr8LbsYljJyEdKNTSgCgF/SukgbXcLgIOI8bRZ1dgES1xAYwvOOch7gUUCAGG
	dpKQY3SWrSAiw8Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755501590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fDObMno5796K3X+vCGAZ9Nq4/Zn9DnIJRXDn7rn8wvY=;
	b=X3a2ttWF3iUqhZhs6Sb35gcmGsQJi1mboSUF4LCyesMtaTzy01g/M0jgxe1p7CbAWqjogv
	edV8k91ebfFLY/hqoGfTv4nCgrwnOHEjk7JC219tkO066n/RPRDbMI4i3/+0li0XGjFnAF
	JEOCcGZriZO3grbBQkLsi+/PKXFsULY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755501590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fDObMno5796K3X+vCGAZ9Nq4/Zn9DnIJRXDn7rn8wvY=;
	b=4TjsnFb0Prr8LbsYljJyEdKNTSgCgF/SukgbXcLgIOI8bRZ1dgES1xAYwvOOch7gUUCAGG
	dpKQY3SWrSAiw8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAB8013A55;
	Mon, 18 Aug 2025 07:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id od7PLxXUomhUEQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 18 Aug 2025 07:19:49 +0000
Message-ID: <2daa5756-fac5-41b1-a21a-54290112df7a@suse.de>
Date: Mon, 18 Aug 2025 09:19:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/efidrm: Match framebuffer device by id instead of
 driver name
To: Yao Zi <ziyao@disroot.org>, Javier Martinez Canillas
 <javierm@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250816153430.51235-1-ziyao@disroot.org>
 <20250816153430.51235-2-ziyao@disroot.org>
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
In-Reply-To: <20250816153430.51235-2-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,disroot.org:email];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[disroot.org,redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,disroot.org:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Hi

Am 16.08.25 um 17:34 schrieb Yao Zi:
> Currently the driver matches the platform framebuffer device registered
> by sysfb through driver name, "efi-framebuffer", this is a little
> confusing since this driver registers a DRM device, instead of a
> framebuffer.
>
> Moreover, we have a driver with the same name, enabled by CONFIG_FB_EFI,
> that acts as a consumer of efi-framebuffer as well. They cannot be both
> loaded into the kernel.
>
> Making these two drivers coexist is sometimes useful, e.g., a
> distribution may want to build fbcon into the kernel image for debugging
> purpose, but keep the whole DRM subsystem enabled as module. In such
> case efidrm could serve as a solution for running DRM-specific userspace
> programs on platforms with only UEFI framebuffer supplied.
>
> Let's rename the driver as "efi-display" to avoid possible confusion.
> A platform_device_id table is introduced to match "efi-framebuffer"
> devices.

NAK, please see the rsp vesa-framebuffer patch for the rational

https://lore.kernel.org/dri-devel/d74f16f0-9615-4816-a49c-efa35b9ab344@suse.de/

Best regards
Thomas

>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>   drivers/gpu/drm/sysfb/efidrm.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
> index 1883c4a8604c..7f76e8961788 100644
> --- a/drivers/gpu/drm/sysfb/efidrm.c
> +++ b/drivers/gpu/drm/sysfb/efidrm.c
> @@ -3,6 +3,7 @@
>   #include <linux/aperture.h>
>   #include <linux/efi.h>
>   #include <linux/limits.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/platform_device.h>
>   #include <linux/screen_info.h>
>   
> @@ -375,10 +376,17 @@ static void efidrm_remove(struct platform_device *pdev)
>   	drm_dev_unplug(dev);
>   }
>   
> +static const struct platform_device_id efidrm_platform_id[] = {
> +	{ "efi-framebuffer" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, efidrm_platform_id);
> +
>   static struct platform_driver efidrm_platform_driver = {
>   	.driver = {
> -		.name = "efi-framebuffer",
> +		.name = "efi-display",
>   	},
> +	.id_table = efidrm_platform_id,
>   	.probe = efidrm_probe,
>   	.remove = efidrm_remove,
>   };

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



