Return-Path: <linux-kernel+bounces-816472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCAFB5742E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF61D189C63B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3132F1FC9;
	Mon, 15 Sep 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WfM8E3u9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6kMFldpx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WfM8E3u9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6kMFldpx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9E2EC087
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927504; cv=none; b=serp8SI8vXgAsE5vL6HLzNBiOaKDQyC1eMVHvWrN+8AgWdawteJLkrqfXwnhUX0K6KCRj6qKkuaOGCo2rJOpNTqbPVWEegwNZ36mSNDlTZzCNo8w+nwIYlXorAoKaoSm+7IvR05SCzAmtP5potHr2WR05BK81cBJf4xGD+1dgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927504; c=relaxed/simple;
	bh=PtUKxP22VKccM8JNMkpmiGisWzHyzl93jUWYUcR+0qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvBoNNV+HoW9Co+2S8EKAi/E0G7fCi53BpfOMQ88QPsOuWVUafJniyGXPkVl4bO13nsq8m56YTyNNEUvsg3pNU4ZnA+eBjEJ3g6YrAWDP2D8RwVcwU2j6AHGZyqA4PYmqE8Ted4L0aFEydS3kKsDKiS//41AZQwMyHQ+f+6P0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WfM8E3u9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6kMFldpx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WfM8E3u9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6kMFldpx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D87A0336FF;
	Mon, 15 Sep 2025 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757927499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mswFLX49hUvkD3CBKW4zwyJE1w1wVRYQV7+l8UyhGwM=;
	b=WfM8E3u9rQcYV/6PYhKw1Qxvu+2S3inBZBNXimAMoJhF9CrHq6EfS0PUkoLTTVGvkqNHOa
	NYBsrIaHcEBH2NQOr+ovPwwuRyhKPVuR/JvX5705h//bwjAYeoZ4bF4NrKR0zNb3HaNiSR
	cCEK9XGAM+9pCxXJh2APdXvoAaBKgC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757927499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mswFLX49hUvkD3CBKW4zwyJE1w1wVRYQV7+l8UyhGwM=;
	b=6kMFldpxWz2fxlK9Cx4mpO188WDlhF7hhzxjG7Tn9A66dB3jCqk/Zz0FUk2jnxSaUDloeg
	Rk8Nn+7geqThYHDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757927499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mswFLX49hUvkD3CBKW4zwyJE1w1wVRYQV7+l8UyhGwM=;
	b=WfM8E3u9rQcYV/6PYhKw1Qxvu+2S3inBZBNXimAMoJhF9CrHq6EfS0PUkoLTTVGvkqNHOa
	NYBsrIaHcEBH2NQOr+ovPwwuRyhKPVuR/JvX5705h//bwjAYeoZ4bF4NrKR0zNb3HaNiSR
	cCEK9XGAM+9pCxXJh2APdXvoAaBKgC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757927499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mswFLX49hUvkD3CBKW4zwyJE1w1wVRYQV7+l8UyhGwM=;
	b=6kMFldpxWz2fxlK9Cx4mpO188WDlhF7hhzxjG7Tn9A66dB3jCqk/Zz0FUk2jnxSaUDloeg
	Rk8Nn+7geqThYHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7875A1372E;
	Mon, 15 Sep 2025 09:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hD+iG0vYx2ildgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 15 Sep 2025 09:11:39 +0000
Message-ID: <5920ffe5-b6b1-484b-b320-332b9eb9db82@suse.de>
Date: Mon, 15 Sep 2025 11:11:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
 <03240fae-544f-4753-96c5-a116b4b5a318@suse.de>
 <20250915-active-placid-bustard-6e1faa@penduick>
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
In-Reply-To: <20250915-active-placid-bustard-6e1faa@penduick>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,gmail.com,ffwll.ch,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,iki.fi,ti.com,lists.freedesktop.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hi

Am 15.09.25 um 10:42 schrieb Maxime Ripard:
> Hi Tohmas,
>
> On Tue, Sep 02, 2025 at 03:44:54PM +0200, Thomas Zimmermann wrote:
>>> +/**
>>> + * drm_atomic_build_readout_state - Creates an initial state from the hardware
>>> + * @dev: DRM device to build the state for
>>> + *
>>> + * This function allocates a &struct drm_atomic_state, calls the
>>> + * atomic_readout_state callbacks, and fills the global state old states
>>> + * by what the callbacks returned.
>>> + *
>>> + * Returns:
>>> + *
>>> + * A partially initialized &struct drm_atomic_state on success, an error
>>> + * pointer otherwise.
>>> + */
>>> +static struct drm_atomic_state *
>>> +drm_atomic_build_readout_state(struct drm_device *dev)
>>> +{
>>> +	struct drm_connector_list_iter conn_iter;
>>> +	struct drm_atomic_state *state;
>>> +	struct drm_mode_config *config =
>>> +		&dev->mode_config;
>>> +	struct drm_connector *connector;
>>> +	struct drm_printer p =
>>> +		drm_info_printer(dev->dev);
>>> +	struct drm_encoder *encoder;
>>> +	struct drm_plane *plane;
>>> +	struct drm_crtc *crtc;
>>> +	int ret;
>>> +
>>> +	drm_dbg_kms(dev, "Starting to build atomic state from hardware state.\n");
>>> +
>>> +	state = drm_atomic_state_alloc(dev);
>>> +	if (WARN_ON(!state))
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	state->connectors = kcalloc(config->num_connector, sizeof(*state->connectors), GFP_KERNEL);
>>> +	if (WARN_ON(!state->connectors)) {
>>> +		ret = -ENOMEM;
>>> +		goto err_state_put;
>>> +	}
>>> +
>>> +	state->private_objs = kcalloc(count_private_obj(dev), sizeof(*state->private_objs), GFP_KERNEL);
>>> +	if (WARN_ON(!state->private_objs)) {
>>> +		ret = -ENOMEM;
>>> +		goto err_state_put;
>>> +	}
>>> +
>>> +	drm_for_each_crtc(crtc, dev) {
>>> +		const struct drm_crtc_funcs *crtc_funcs =
>>> +			crtc->funcs;
>>> +		struct drm_crtc_state *crtc_state;
>>> +
>>> +		drm_dbg_kms(dev, "Initializing CRTC %s state.\n", crtc->name);
>>> +
>>> +		if (crtc_funcs->atomic_readout_state) {
>>> +			crtc_state = crtc_funcs->atomic_readout_state(crtc);
>>> +		} else if (crtc_funcs->reset) {
>>> +			crtc_funcs->reset(crtc);
>>> +
>>> +			/*
>>> +			 * We don't want to set crtc->state field yet. Let's save and clear it up.
>>> +			 */
>>> +			crtc_state = crtc->state;
>>> +			crtc->state = NULL;
>> Chancing the crtc->state pointer behind the back of the reset callback seems
>> fragile. We never how if some other piece of the driver refers to it
>> (although illegally).
> I agree that it's clunky. I'm not sure who would use it at this point
> though: we're in the middle of the drm_mode_config_reset(), so the
> drivers' involvement is pretty minimal.
>
> I did wonder if changing reset to return the object instead of setting
> $OBJECT->state would be a better interface?

Probably not. The reset helper is supposed to initialize the object's 
software and hardware state. But in most drivers, we're currently mostly 
setting the minimal software state here and simply assume that hardware 
is off. Returning the state would water down semantics even further.

Having said that, I could imaging building an atomic_clean_state 
callback that replaces the reset callback. It would work alongside the 
new atomic_readout_state callback.  Current reset could be build upon 
that callback. The atomic_clean_state would intentionally only take care 
of the software state and leave hardware state undefined. This reflects 
the current realities of most DRM drivers.   From that clean state, DRM 
could do an atomic commit that also initializes the hardware.

>
>> For now, wouldn't it be better to require a read-out helper for all elements
>> of the driver's mode-setting pipeline?  The trivial implementation would
>> copy the existing reset function and keep crtc->state to NULL.
> I also considered that, but I'm not sure we can expect bridges to have
> readout hooks filled for every configuration in the wild.
>
> But maybe we can look during drm_mode_config_reset() at whether all the
> objects have their hook filled, and if not fall back on reset for
> everything.

That's what I meant, I think.

>
> It would make the implementation easier, but missing bridges
> implementations would trigger a mode change when it might actually work
> just fine since bridge state is pretty minimal.

If there's an element in the pipeline that's missing the readout helper, 
it might be safer to fallback to that modeset instead of ending up with 
inconsistent state.

Best regards
Thomas

>
> Idk.
>
>>> --- a/include/drm/drm_bridge.h
>>> +++ b/include/drm/drm_bridge.h
>>> @@ -490,10 +490,31 @@ struct drm_bridge_funcs {
>>>    	 * The @atomic_post_disable callback is optional.
>>>    	 */
>>>    	void (*atomic_post_disable)(struct drm_bridge *bridge,
>>>    				    struct drm_atomic_state *state);
>>> +	/**
>>> +	 * @atomic_readout_state:
>>> +	 *
>>> +	 * Initializes,this bridge atomic state.
>>> +	 *
>>> +	 * It's meant to be used by drivers that wants to implement fast
>> 'want'
>>
>>> +	 * / flicker-free boot and allows to initialize the atomic state
>> I think we should only call it flicker-free boot. Fast boot is misleading.
> I agree, but it's also how it's been called by the only implementation
> of it we have so far (i915), and the name of the module parameter that
> controls it.
>
> Maxime

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



