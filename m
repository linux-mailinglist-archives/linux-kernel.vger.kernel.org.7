Return-Path: <linux-kernel+bounces-595439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE1A81E31
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 09:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549E61BA2087
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C939425A2C5;
	Wed,  9 Apr 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fhc/SBTA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3YyJfi44";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fhc/SBTA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3YyJfi44"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9761D8A0A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183353; cv=none; b=a8d8IIQlUUvvipUFxUK7/NsM1mo4tkXhpts3Ji9/BfPPs4co0s53uSYPI91EBVlALyRKKU+6bm3mGEitLwkUQRYEzwYKVIC54p8QiK9O2TptPtLGl6Hr0SiwP7zq+n6xid8ACkzuXEmMvaXtKlOfkULzyqHTk94lApbct3/nH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183353; c=relaxed/simple;
	bh=n2MzSAksEybSMeTN6Fzwk4lqo3EVvNjxLy9rFjZZkv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL59PwqzVCvH3auRtbR1ajf+d+0X+6qn6CTQWhxbYOoZ/KMzSNYjsY/2BmyIcMpTdMAmY+nslT9PV4JtQ2knHsvlX8rREFtHVBEjXI/CF64yDgD1Pnf1954U9ILCRw2lVmvjlaoyPSHoX7/jDDcqNqP0jb8jsliEwIrDq/7VMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fhc/SBTA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3YyJfi44; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fhc/SBTA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3YyJfi44; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63D8721167;
	Wed,  9 Apr 2025 07:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744183349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcFfC+j/ELiAvlOYoPhl8xcX9btjAI+yv8lWV45AblU=;
	b=Fhc/SBTAOmvmA+jOooTvSYaSQe8luBio0bLEWz5he84bi0yBV0GCRjyppDc1LgVtU7pi3t
	pWgB7CkDjxd/Gk0Ai13tLEMfMzalAFUdIvfIH7hzVMMdjyeN2gJD7w/lESwB1dYRHURCUz
	ChdLnsImKLka3pxKBXuPFBGV+o3uPn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744183349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcFfC+j/ELiAvlOYoPhl8xcX9btjAI+yv8lWV45AblU=;
	b=3YyJfi44tE85ab9c7EbGVJATgnAHXKow/46XbISMD5nwzTuyrCzH4iXYaZBJWyHBkUTVoQ
	LdduhNLM3Hb793DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Fhc/SBTA";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3YyJfi44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744183349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcFfC+j/ELiAvlOYoPhl8xcX9btjAI+yv8lWV45AblU=;
	b=Fhc/SBTAOmvmA+jOooTvSYaSQe8luBio0bLEWz5he84bi0yBV0GCRjyppDc1LgVtU7pi3t
	pWgB7CkDjxd/Gk0Ai13tLEMfMzalAFUdIvfIH7hzVMMdjyeN2gJD7w/lESwB1dYRHURCUz
	ChdLnsImKLka3pxKBXuPFBGV+o3uPn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744183349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcFfC+j/ELiAvlOYoPhl8xcX9btjAI+yv8lWV45AblU=;
	b=3YyJfi44tE85ab9c7EbGVJATgnAHXKow/46XbISMD5nwzTuyrCzH4iXYaZBJWyHBkUTVoQ
	LdduhNLM3Hb793DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CF9C13691;
	Wed,  9 Apr 2025 07:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 78ymATUg9mc9SQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Apr 2025 07:22:29 +0000
Message-ID: <46145e45-d230-4318-a3c8-42a1739c908d@suse.de>
Date: Wed, 9 Apr 2025 09:22:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/st7571-i2c: add support for Sitronix ST7571
 LCD controller
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmrmann@suse.de>
References: <20250408-st7571-v3-0-200693efec57@gmail.com>
 <20250408-st7571-v3-2-200693efec57@gmail.com>
 <87cydn9bkx.fsf@minerva.mail-host-address-is-not-set>
 <Z_Uin2dvmbantQU4@gmail.com> <05fa4ac7-db09-401d-8680-0d71112d2239@suse.de>
 <Z_U5eGy3vLgHZmz1@gmail.com>
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
In-Reply-To: <Z_U5eGy3vLgHZmz1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 63D8721167
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,lists.freedesktop.org,vger.kernel.org,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,bootlin.com:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi

Am 08.04.25 um 16:58 schrieb Marcus Folkesson:
> Hi,
>
> On Tue, Apr 08, 2025 at 03:57:22PM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 08.04.25 um 15:20 schrieb Marcus Folkesson:
>> [...]
>>>>> +static int st7571_set_pixel_format(struct st7571_device *st7571,
>>>>> +				   u32 pixel_format)
>>>>> +{
>>>>> +	switch (pixel_format) {
>>>>> +	case DRM_FORMAT_C1:
>>>>> +		return st7571_set_color_mode(st7571, ST7571_COLOR_MODE_BLACKWHITE);
>>>>> +	case DRM_FORMAT_C2:
>>>>> +		return st7571_set_color_mode(st7571, ST7571_COLOR_MODE_GRAY);
>>>>> +	default:
>>>>> +		return -EINVAL;
>>>>> +	}
>>>> These should be DRM_FORMAT_R1 and DRM_FORMAT_R2 and not C{1,2}. The former
>>>> is for displays have a single color (i.e: grey) while the latter is when a
>>>> pixel can have different color, whose values are defined by a CLUT table.
>>>>
>>> I see.
>>> Does fbdev only works with CLUT formats? I get this error when I switch
>>> to DRM_FORMAT_R{1,2}:
>>>
>>> [drm] Initialized st7571 1.0.0 for 0-003f on minor 0
>>> st7571 0-003f: [drm] format C1   little-endian (0x20203143) not supported
>>> st7571 0-003f: [drm] No compatible format found
>>> st7571 0-003f: [drm] *ERROR* fbdev: Failed to setup emulation (ret=-22)
>> For testing purposes, you can add the _R formats to the switch case at
>>
>> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/gpu/drm/drm_fb_helper.c#L1246
>>
>> and see how it goes.
> Still no penguin (same error as above).
>
> The problem is that drm_mode_legacy_fb_format(), which is called from
> drm_fbdev_shmem_driver_fbdev_probe -> drm_driver_legacy_fb_format -> drm_mode_legacy_fb_format

In addition to the other change, you could change the _C formats to _R 
formats in that helper for testing.

Best regards
Thomas

>
> Sets the pixel format DRM_FORMAT_C{1,2} when bpp is 1 or 2.
> So I don't think it is possible to use the _R formats with fbdev.
> But I'm not sure?
>
>> Best regards
>> Thomas
> Best regards,
> Marcus Folkesson

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


