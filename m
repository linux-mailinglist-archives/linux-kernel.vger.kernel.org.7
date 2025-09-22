Return-Path: <linux-kernel+bounces-826695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93130B8F22B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6439B4E1B96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4129A263C8F;
	Mon, 22 Sep 2025 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f0jHHcJB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kWDOcKQY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f0jHHcJB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kWDOcKQY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90417332C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522296; cv=none; b=IFqge62x+aGfLKCKAcTsca5U2VivqDLq7FPtbOTVoEXHfBp1CEDHSMqC0KmWOk/wcEQRanx4ZBF9FJ0xdJxFir1g26GbG34C4dg0hJnBvq5WhYubnHpyN6aJrQ8Hg63q3JENfZAfM1dXV4rxyf7/ldOuItTv9yPN5i2nsm4bAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522296; c=relaxed/simple;
	bh=UJQ5gHtEHJNQq8yXEE4Ap709uHR+V/15HVKyq2XGe7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1FVqaNbJ97HVAM7KWToZhLoAP+m0bTmnjDXXvWjkyvPex8IoyGLl4iBZzwcuI88GxBR12X2diN53t+3lChpsu3B8BVzFFt2YoKdyM9wZYr/o7iX2kxheGS/+/LejDXBMseT8I6mp06Fqt9+LxEKKyCBjVlMfmpcmCAA5jN11vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f0jHHcJB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kWDOcKQY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f0jHHcJB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kWDOcKQY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0C5B2208F;
	Mon, 22 Sep 2025 06:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758522292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3b6oPreLHVuP1TLZTBXluyZeWHzbyJKf4sc68/j9yto=;
	b=f0jHHcJBTk7pq0I8vnEHTF67b2U7zyK8idrzbE7MyW3yHJouliFWcVWz7v869q/xqfdEZk
	1q4Wm4kfCt7TCzzetJM+/sJf3LpfsC5g1QZ0+vQD6czBT0mubYl3FMmzsUDjg9F6nbmAu3
	wFstqMDmYQoCWmG5tBfxqVYVi22Sqhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758522292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3b6oPreLHVuP1TLZTBXluyZeWHzbyJKf4sc68/j9yto=;
	b=kWDOcKQYK+H6kIr9dpH3LsHHiQf1DFYVs0+HttSuZQRFtCJRtrnyk6Xu4zwAh+Jjm6Iciq
	4wBYUdK0uimxQLAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758522292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3b6oPreLHVuP1TLZTBXluyZeWHzbyJKf4sc68/j9yto=;
	b=f0jHHcJBTk7pq0I8vnEHTF67b2U7zyK8idrzbE7MyW3yHJouliFWcVWz7v869q/xqfdEZk
	1q4Wm4kfCt7TCzzetJM+/sJf3LpfsC5g1QZ0+vQD6czBT0mubYl3FMmzsUDjg9F6nbmAu3
	wFstqMDmYQoCWmG5tBfxqVYVi22Sqhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758522292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3b6oPreLHVuP1TLZTBXluyZeWHzbyJKf4sc68/j9yto=;
	b=kWDOcKQYK+H6kIr9dpH3LsHHiQf1DFYVs0+HttSuZQRFtCJRtrnyk6Xu4zwAh+Jjm6Iciq
	4wBYUdK0uimxQLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E6B51388C;
	Mon, 22 Sep 2025 06:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SU3EGbTr0GhgagAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 22 Sep 2025 06:24:52 +0000
Message-ID: <dfc5f39f-7743-400c-a602-55a569da7411@suse.de>
Date: Mon, 22 Sep 2025 08:24:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: fix integer overflow in fbcon_do_set_font
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 simona@ffwll.ch, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250912170023.3931881-1-samasth.norway.ananda@oracle.com>
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
In-Reply-To: <20250912170023.3931881-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[oracle.com,ffwll.ch,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30



Am 12.09.25 um 19:00 schrieb Samasth Norway Ananda:
> Fix integer overflow vulnerabilities in fbcon_do_set_font() where font
> size calculations could overflow when handling user-controlled font
> parameters.
>
> The vulnerabilities occur when:
> 1. CALC_FONTSZ(h, pitch, charcount) performs h * pith * charcount
>     multiplication with user-controlled values that can overflow.
> 2. FONT_EXTRA_WORDS * sizeof(int) + size addition can also overflow
> 3. This results in smaller allocations than expected, leading to buffer
>     overflows during font data copying.
>
> Add explicit overflow checking using check_mul_overflow() and
> check_add_overflow() kernel helpers to safety validate all size
> calculations before allocation.
>
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks a lot for the patch.

> ---
>   drivers/video/fbdev/core/fbcon.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 55f5731e94c3..a507d05f8fea 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2531,9 +2531,16 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
>   	if (fbcon_invalid_charcount(info, charcount))
>   		return -EINVAL;
>   
> -	size = CALC_FONTSZ(h, pitch, charcount);
> +	/* Check for integer overflow in font size calculation */
> +	if (check_mul_overflow(h, pitch, &size) ||
> +	    check_mul_overflow(size, charcount, &size))
> +		return -EINVAL;
> +
> +	/* Check for overflow in allocation size calculation */
> +	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &size))
> +		return -EINVAL;
>   
> -	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
> +	new_data = kmalloc(size, GFP_USER);
>   
>   	if (!new_data)
>   		return -ENOMEM;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



