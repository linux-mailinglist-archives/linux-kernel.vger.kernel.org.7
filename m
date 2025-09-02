Return-Path: <linux-kernel+bounces-796582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71104B402D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93C93AB37F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE922DAFA1;
	Tue,  2 Sep 2025 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="THgycutG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rk5fc7Nx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="THgycutG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rk5fc7Nx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215B3054ED
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819365; cv=none; b=TQqdYySCVRMMPMVcMhBz/QallK2d2rid0oMTP+Bd0vsY38FEOB3IVz0NY8v0Ua+u80z7Re7Ycxqn0+S2EbZacCrnRoMdJe99jFpbGmqITcjy0Y2ngv46DHUXaBjMYARUPsgBdc2dv3AElR55DV0UtFUl+pWWSUaPP/6kiDwMXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819365; c=relaxed/simple;
	bh=TMevIV6gQUGARz2SaWzGieoRQp0c7UWobPfK94/VHIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMrrXmWvqW9kKpA0ahipaKyHAV+tbRfEnSQifFEJeY6v4dTy100+pUDtMRm4npNFK2FcCuqcTSPDmGvr6MIhfmTVChuOAFDA2CUqY8gDwLdY6dlMTfAnkVuDrXUNrBk/OKnJeWg70egnQtI7OgxbpRd7yLLsKmWWSxw6NKSVTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=THgycutG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rk5fc7Nx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=THgycutG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rk5fc7Nx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D033D211A2;
	Tue,  2 Sep 2025 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756819361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0HFmgxdh9UywBudMtT0xj7qaL3uD8klJAz80JBdkKvY=;
	b=THgycutGaZGE01hUGQL3kiq89Zh1zwNsPxPCGSjuqiH5ZMCJHcz9eC9HuHM8Vwb66E62RR
	4yljh9ezmRUteOoGGX0DE9DdExDoMuuT2S+msVWWwy7MnX4wCmWZtv5EKsnWzQqHVkZjhH
	hfkizvL5Ax+L94+fY04j7BFLxuDDSC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756819361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0HFmgxdh9UywBudMtT0xj7qaL3uD8klJAz80JBdkKvY=;
	b=rk5fc7Nx9S9THAfhHbmVR0x3U5E16ANNPkpW/Pfm027b9/dD8QXm8NDs2njezl3DmjD25i
	i7dEjCFY2TFz5cCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756819361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0HFmgxdh9UywBudMtT0xj7qaL3uD8klJAz80JBdkKvY=;
	b=THgycutGaZGE01hUGQL3kiq89Zh1zwNsPxPCGSjuqiH5ZMCJHcz9eC9HuHM8Vwb66E62RR
	4yljh9ezmRUteOoGGX0DE9DdExDoMuuT2S+msVWWwy7MnX4wCmWZtv5EKsnWzQqHVkZjhH
	hfkizvL5Ax+L94+fY04j7BFLxuDDSC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756819361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0HFmgxdh9UywBudMtT0xj7qaL3uD8klJAz80JBdkKvY=;
	b=rk5fc7Nx9S9THAfhHbmVR0x3U5E16ANNPkpW/Pfm027b9/dD8QXm8NDs2njezl3DmjD25i
	i7dEjCFY2TFz5cCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CDBA13882;
	Tue,  2 Sep 2025 13:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sn3AGKHvtmhVWgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 02 Sep 2025 13:22:41 +0000
Message-ID: <056b0335-f104-4b67-9882-6beaecd21c76@suse.de>
Date: Tue, 2 Sep 2025 15:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] drm/bridge: Implement atomic_print_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-6-14ad5315da3f@kernel.org>
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
In-Reply-To: <20250902-drm-state-readout-v1-6-14ad5315da3f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch,intel.com,linaro.org,ideasonboard.com,kwiboo.se,iki.fi];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hi

Am 02.09.25 um 10:32 schrieb Maxime Ripard:
> Bridges have some fields in their state worth printing, but we don't
> provide an atomic_print_state implementation to show those fields.
>
> Let's do so.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index dd439d55177a867acb7ab73c02182bada44d93c9..e803dfd8fd5aae9c16931445213df04d8715b9f6 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -370,13 +370,31 @@ drm_bridge_atomic_destroy_priv_state(struct drm_private_obj *obj,
>   	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
>   
>   	bridge->funcs->atomic_destroy_state(bridge, state);
>   }
>   
> +static void
> +drm_bridge_atomic_print_priv_state(struct drm_printer *p,
> +				   const struct drm_private_state *s)
> +{
> +	const struct drm_bridge_state *state =
> +		container_of_const(s, struct drm_bridge_state, base);

Maybe adopt drm_priv_to_bridge_state() to accept const pointers?

https://elixir.bootlin.com/linux/v6.16.4/source/include/drm/drm_atomic.h#L1236



> +	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
> +
> +	drm_printf(p, "bridge: %s", drm_get_connector_type_name(bridge->type));
> +	drm_printf(p, "\tinput bus configuration:");
> +	drm_printf(p, "\t\tcode: %04x", state->input_bus_cfg.format);
> +	drm_printf(p, "\t\tflags: %08x", state->input_bus_cfg.flags);
> +	drm_printf(p, "\toutput bus configuration:");
> +	drm_printf(p, "\t\tcode: %04x", state->output_bus_cfg.format);
> +	drm_printf(p, "\t\tflags: %08x", state->output_bus_cfg.flags);
> +}
> +
>   static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
>   	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
>   	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
> +	.atomic_print_state = drm_bridge_atomic_print_priv_state,
>   };
>   
>   static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
>   {
>   	return bridge->funcs->atomic_reset != NULL;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



