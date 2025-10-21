Return-Path: <linux-kernel+bounces-862250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087B8BF4C65
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EE6423E56
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A380226CE22;
	Tue, 21 Oct 2025 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xoLmHKcG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rsbpWUhd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WGOqMGDl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1dHA9Pnr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175431DF72C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029839; cv=none; b=dMganh0YO75gnVsYhmrNGGEcmm52ys+ekrCVtD+BMmRbZzHmlx5mC8J3pMKTlLAHgGXRc13FgyAqcJ3c4XexSjIXcKsnHTWxAEB+l4i+zzEOTFdymNFxbW+6XRH9Sj3hkDw3aLKTEy9HyAxNwijogfuv9Vc3DgLmaTF+syNAc2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029839; c=relaxed/simple;
	bh=vv20FJu/JYEZaujFRQmxqurvmNbBbIO05gpeVc0DX2w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q38mX8ww9+q/KSMFiE5mjfPvl1xezLAxBPJBXCzt5qttMlrvZQmW0kqXn79uLOiu+4iKHWleMCy2oJ1350xGhwTkN4GpdhrTf5sxf4qN+ZmRMj4L/UzJHYvCugfDGwHuk+kQp8zONU5tZ/yL2sN6Z0KDQfrezVr/tOwpCBo5faw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xoLmHKcG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rsbpWUhd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WGOqMGDl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1dHA9Pnr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 126C7211B1;
	Tue, 21 Oct 2025 06:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761029832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h2ohmhw3aDQHSsxEPkebimynP0KXRcebZRc+tDHq3dc=;
	b=xoLmHKcGN6C3H3mDMh0y1lL37YxgMo0eFlAu65aOXM/dQyY9abTX7hqaGcgmzKp4kQZOVl
	IbpnRZJ/vcVFD09Y2OuaAHZb7Fvlh5+csa6gSjaKAcH7sQbZ11SIaLqwlF1nYVuumftF0+
	dbVG8rYvKmv2Qy+iqmp3Q1kT+Tzfo4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761029832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h2ohmhw3aDQHSsxEPkebimynP0KXRcebZRc+tDHq3dc=;
	b=rsbpWUhdPDsa3Uaw4n9aoUV3aL8GDxKssrbCRmnyT5mqdgO/gn4YBnznwXSLNDgM4D1cu9
	lImXPM5MUrmYdlBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761029828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h2ohmhw3aDQHSsxEPkebimynP0KXRcebZRc+tDHq3dc=;
	b=WGOqMGDltL1lCL76oDa5rt99/rrNt0yHYo7iaZPXXaxkLIp0MLBM95wQqhhaQvusu7okTw
	xu9r7ifRkkNOt72it3a5Im4GJV6vgfbqpegNA7ioz9RdN2TYnUj55QB/Q8Ngut4Ja9L6Kv
	D8yP8GxZASoX/6N9g/aeOjJWgQC3BQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761029828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h2ohmhw3aDQHSsxEPkebimynP0KXRcebZRc+tDHq3dc=;
	b=1dHA9PnrvwjcmUSCv3G8KsTPQrm8dyVC7geh8GrA7N4vY4SxtXoarE3nJGsZsIh63uNt0q
	reoV6PikzFQpmJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8A41139D8;
	Tue, 21 Oct 2025 06:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eGiBJ8Mu92iPNAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 21 Oct 2025 06:57:07 +0000
Message-ID: <a37d83c7-dc2d-4e1d-a8d4-5628e0ac52a2@suse.de>
Date: Tue, 21 Oct 2025 08:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: Refactor framebuffer's size calculation
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 lanzano.alex@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251020115803.192572-1-mehdi.benhadjkhelifa@gmail.com>
 <1de3112b-6349-46d8-b90b-69d0849c7659@suse.de>
Content-Language: en-US
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
In-Reply-To: <1de3112b-6349-46d8-b90b-69d0849c7659@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linuxfoundation.org,gmail.com,kernel.org,lists.linuxfoundation.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 



Am 21.10.25 um 08:51 schrieb Thomas Zimmermann:
> Hi
>
> Am 20.10.25 um 13:57 schrieb Mehdi Ben Hadj Khelifa:
>> Use drm_format_info_min_pitch() to calculate the framebuffer line pitch
>> instead of directly multiplying width and height. This aligns with DRM
>> helpers for determining per-line byte size and avoids manual assumptions
>> about bytes per pixel.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>>   drivers/gpu/drm/tiny/repaper.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/repaper.c 
>> b/drivers/gpu/drm/tiny/repaper.c
>> index 4824f863fdba..aeff49bc6ba7 100644
>> --- a/drivers/gpu/drm/tiny/repaper.c
>> +++ b/drivers/gpu/drm/tiny/repaper.c
>> @@ -517,6 +517,8 @@ static int repaper_fb_dirty(struct 
>> drm_framebuffer *fb, const struct iosys_map *
>>       unsigned int dst_pitch = 0;
>>       struct iosys_map dst;
>>       struct drm_rect clip;
>> +    const struct drm_format_info *info = fb->format;
>
> This is the wrong format. You're allocating the output buffer here, 
> but you're using the input format. IIUC the output format is 
> DRM_FORMAT_R1. The input is _XRGB8888.
>
> Best regards
> Thomas
>
>> +    size_t pitch;
>>       int idx, ret = 0;
>>       u8 *buf = NULL;
>>   @@ -534,7 +536,9 @@ static int repaper_fb_dirty(struct 
>> drm_framebuffer *fb, const struct iosys_map *
>>       DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>>             epd->factored_stage_time);
>>   -    buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>> +    pitch = drm_format_info_min_pitch(info, 0, fb->width);
>> +
>> +    buf = kmalloc_array(fb->height, pitch, GFP_KERNEL);

And TBH I'm not sure if we should really convert this call. It's not an 
array in the sense of that API.

Good candidates look like 'kmalloc(count * sizeof(<some type or variable>))'

>>       if (!buf) {
>>           ret = -ENOMEM;
>>           goto out_exit;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



