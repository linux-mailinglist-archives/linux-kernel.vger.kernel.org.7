Return-Path: <linux-kernel+bounces-820325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F34B80033
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE83283C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BE2D879A;
	Wed, 17 Sep 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tZAje8IZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ntpufKvP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tZAje8IZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ntpufKvP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A762D7DF2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100827; cv=none; b=YMXySXk/D7MmVrllH9NgyIKa7gB2f3U3Oas4rKGXMZEj6Wkx4ddp8hxMiUgNZgFcAgl4D2MyhFhH8xclWrL2D2frqfnXCMIQ8IVn1Q1QZJqvkk8jMLMxjVor3zjyhU8/dZD3KY3hd9ydhW5bzGU84HENx1Cj+Eu3Hg5fnhIS1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100827; c=relaxed/simple;
	bh=VqjvmLCiWPQHnESEs2Pt55XF628ZhcIy4aC8gAC7J3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFl3PFVk370ifxk80j8fUhQC/ynG7me5fjE2EL7+SR+PfSTuaCPLXFzfw7u3vISATDrnfYvwvau88tlJmzWeFeFvL4FO6w9QzvYJCpKPeNW4T89tpW1H2EjvyEHDQDebwPwNWeITgnYf8bM7R9NCwDBrmS0jx+o8XjYR6matz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tZAje8IZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ntpufKvP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tZAje8IZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ntpufKvP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 459E71F456;
	Wed, 17 Sep 2025 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758100823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5tk+r5R/k8njcQI73K4TtrfXFTXLCZoxOGoZ0oxk0u4=;
	b=tZAje8IZWc8Krfc4yHx/T6mHwHr4a3Pip1ewhAZR44ws4YmfiQjumnwhH7LiMKa3nfn2u0
	Ex9NN0wLgFMa0cE3OtYUl8VISdauIJMFlzdW5GSE5wjTp0FvwTu3n6ldR+z59kJamf9Tkp
	EaXTS6yKhZ77CrYJjMYUy3sIhlyQZ7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758100823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5tk+r5R/k8njcQI73K4TtrfXFTXLCZoxOGoZ0oxk0u4=;
	b=ntpufKvPTP2zwujZmCJjBCn8ByZ6R95iRNyunyELPDG+ULfPSUYhqOdVXQoeyW4+PBpMhI
	whXzDoonW7EVVuAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758100823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5tk+r5R/k8njcQI73K4TtrfXFTXLCZoxOGoZ0oxk0u4=;
	b=tZAje8IZWc8Krfc4yHx/T6mHwHr4a3Pip1ewhAZR44ws4YmfiQjumnwhH7LiMKa3nfn2u0
	Ex9NN0wLgFMa0cE3OtYUl8VISdauIJMFlzdW5GSE5wjTp0FvwTu3n6ldR+z59kJamf9Tkp
	EaXTS6yKhZ77CrYJjMYUy3sIhlyQZ7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758100823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5tk+r5R/k8njcQI73K4TtrfXFTXLCZoxOGoZ0oxk0u4=;
	b=ntpufKvPTP2zwujZmCJjBCn8ByZ6R95iRNyunyELPDG+ULfPSUYhqOdVXQoeyW4+PBpMhI
	whXzDoonW7EVVuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05BAC137C3;
	Wed, 17 Sep 2025 09:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 62wEAFd9ymglHQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Sep 2025 09:20:22 +0000
Message-ID: <0b6cb807-1a7e-427e-af42-dfc8f422f813@suse.de>
Date: Wed, 17 Sep 2025 11:20:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/solomon: Move calls to drm_gem_fb_end_cpu*()
To: Javier Martinez Canillas <javierm@redhat.com>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
 <20250912-improve-ssd130x-v1-1-bc9389ed299e@gmail.com>
 <874it1phx8.fsf@minerva.mail-host-address-is-not-set>
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
In-Reply-To: <874it1phx8.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

grr, I should have noticed that before giving the r-b

Am 17.09.25 um 11:06 schrieb Javier Martinez Canillas:
> Iker Pedrosa <ikerpedrosam@gmail.com> writes:
>
> Hello Iker,
>
> Thanks for your patch.
>
>> Calls to drm_gem_fb_end_cpu*() should be between the calls to
>> drm_dev*(), and not hidden inside some other function. This way the
>> critical section code is visible at a glance, keeping it short and
>> improving maintainability.
>>
>> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
>> ---
>>   drivers/gpu/drm/solomon/ssd130x.c | 33 +++++++++++++++------------------
>>   1 file changed, 15 insertions(+), 18 deletions(-)
>>
> [...]
>
>> @@ -1232,6 +1214,9 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
>>   	if (!drm_dev_enter(drm, &idx))
>>   		return;
>>   
>> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
>> +		return;
>> +
> In this error path you should call drm_dev_exit(). The convention in the
> kernel usually is to have a goto label for this, e.g.:
>
>         if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
>                goto out_drm_dev_exit;
>
>>   	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
>>   	drm_atomic_for_each_plane_damage(&iter, &damage) {
>>   		dst_clip = plane_state->dst;
>> @@ -1245,6 +1230,8 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
>>   				     &shadow_plane_state->fmtcnv_state);
>>   	}
>>   
>> +	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
>> +
> and then here before the call you could have the label.
>
> out_drm_dev_exit:
>
>>   	drm_dev_exit(idx);
> Same comments for the other places where you are adding the
> drm_gem_fb_end_cpu*() calls next to the drm_dev*() ones.
>
> After the mentioned changes:
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



