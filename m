Return-Path: <linux-kernel+bounces-807318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6167EB4A2EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0122E4E7351
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3B305E1D;
	Tue,  9 Sep 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nIZnpKus";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e10OgCNv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="izE3p+ya";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eMPqUuvL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19B30595F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401465; cv=none; b=B6jGHOk8ZPE0RWRa+JIhqyltYxPj11BoyQUmqx6bkVtBCULfmEGldGSMtCIl+rRAHdhpjX7VtwxCm2ZwnVZli9xeYBqgQOAhTUV/S+Q/DGowVYcg6YSxpks7Bf4w7IMqihP4oHm2nYIaChvCvkKq1xu/mJ50bdaH5AwgSdOY78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401465; c=relaxed/simple;
	bh=Lv3hHfIb7eO7/WtdzFcyTU+mNFnDsr/Vlu9PGuY6sGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xuoc2r3ouj+I9jwpDLM0iGjPyB1dGHoghnYkpgBD6b7OTila7SbawYyqL7TJoRjYBcbhIdEn1hFGSo6ulh0GKxgofIpOtpHX7T6l1jTe5tgJCkTPm81nGOXXVjTA91L1+vSm8XbFL+Ddcg3hgCkcr+O8afISzjo1SdJxyZqDH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nIZnpKus; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e10OgCNv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=izE3p+ya; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eMPqUuvL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC90A8D11D;
	Tue,  9 Sep 2025 07:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757401455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xJU1CRjDMLlYJR8Uq4wXLpfH3haP0YK9ah0UGwx85vE=;
	b=nIZnpKus8KACf1KJXi2161RqvWRUvqoPRHdfbpPvq9vl6xy7+rvvRbTVbfdqligjQMiFvu
	GouiIAx9gWcdTazjEvcrJ2oulOpjrbeuaeZ9t5rgefjpFOPP9SrHYHuOuX2F2lsLP6Nurx
	Z+Rg91C+diSn477leWjosyt/CMCAXbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757401455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xJU1CRjDMLlYJR8Uq4wXLpfH3haP0YK9ah0UGwx85vE=;
	b=e10OgCNvPqFAhOYyEyyb6pdwRbFw8nFoXjXQw2Ta/xoAO5+6FHv3EIazkKRkQsRNbFNq99
	sWCkfL80ZQF8p9Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757401454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xJU1CRjDMLlYJR8Uq4wXLpfH3haP0YK9ah0UGwx85vE=;
	b=izE3p+yaqAo+iMcRv5WGiVaU/5TVMXXB2WI9Ey7QlEQyUZZWQHAvwuvnx3Hnanf8xWYF6b
	kPz0wMJ18FVimvNsEl+hExbxbC/g7I95MR6vUVHUMRS8KbWzAM9Gxildcs2Qx2JpENm2Pk
	Auq1S4ToZ/lou4zwfBpCQbaBoIO/z9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757401454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xJU1CRjDMLlYJR8Uq4wXLpfH3haP0YK9ah0UGwx85vE=;
	b=eMPqUuvLeuMjePHwTFR1Fs2AhEXq3WDKRE5nobFkNWFkYn8yB+sh7pqrLAn8a9x1yYG2Va
	soQeJfWJL1SHXeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79C101365E;
	Tue,  9 Sep 2025 07:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oxu/G27Rv2gIXAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 09 Sep 2025 07:04:14 +0000
Message-ID: <c514df7c-7359-42c6-aaff-c5a1be1e71ec@suse.de>
Date: Tue, 9 Sep 2025 09:04:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] fbcon: Move fbcon callbacks into struct fbcon_bitops
To: Sam Ravnborg <sam@ravnborg.org>
Cc: simona@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250818104655.235001-1-tzimmermann@suse.de>
 <20250818104655.235001-5-tzimmermann@suse.de>
 <20250905185358.GA361827@ravnborg.org>
 <c1674a81-3435-445c-b359-e2b094b7f8a5@suse.de>
 <20250908185109.GA643261@ravnborg.org>
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
In-Reply-To: <20250908185109.GA643261@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmx.de,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi

Am 08.09.25 um 20:51 schrieb Sam Ravnborg:
> Hi Thomas.
>
> On Mon, Sep 08, 2025 at 03:06:46PM +0200, Thomas Zimmermann wrote:
>> Hi Sam,
>>
>> thanks for doing the review.
>>
>> Am 05.09.25 um 20:53 schrieb Sam Ravnborg:
>>> Hi Thomas.
>>>
>>> On Mon, Aug 18, 2025 at 12:36:39PM +0200, Thomas Zimmermann wrote:
>>>> Depending on rotation settings, fbcon sets different callback
>>>> functions in struct fbcon from within fbcon_set_bitops(). Declare
>>>> the callback functions in the new type struct fbcon_bitops. Then
>>>> only replace the single bitops pointer in struct fbcon.
>>>>
>>>> Keeping callbacks in constant instances of struct fbcon_bitops
>>>> makes it harder to exploit the callbacks. Also makes the code slightly
>>>> easier to maintain.
>>>>
>>>> For tile-based consoles, there's a separate instance of the bitops
>>>> structure.
>>>>
>>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> ---
>>>>    drivers/video/fbdev/core/bitblit.c   | 17 ++++---
>>>>    drivers/video/fbdev/core/fbcon.c     | 67 +++++++++++++++-------------
>>>>    drivers/video/fbdev/core/fbcon.h     |  7 ++-
>>>>    drivers/video/fbdev/core/fbcon_ccw.c | 18 +++++---
>>>>    drivers/video/fbdev/core/fbcon_cw.c  | 18 +++++---
>>>>    drivers/video/fbdev/core/fbcon_ud.c  | 18 +++++---
>>>>    drivers/video/fbdev/core/tileblit.c  | 16 ++++---
>>>>    7 files changed, 94 insertions(+), 67 deletions(-)
>>>>
>>>> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
>>>> index a2202cae0691..267bd1635a41 100644
>>>> --- a/drivers/video/fbdev/core/bitblit.c
>>>> +++ b/drivers/video/fbdev/core/bitblit.c
>>>> @@ -384,15 +384,18 @@ static int bit_update_start(struct fb_info *info)
>>>>    	return err;
>>>>    }
>>>> +static const struct fbcon_bitops bit_fbcon_bitops = {
>>>> +	.bmove = bit_bmove,
>>>> +	.clear = bit_clear,
>>>> +	.putcs = bit_putcs,
>>>> +	.clear_margins = bit_clear_margins,
>>>> +	.cursor = bit_cursor,
>>>> +	.update_start = bit_update_start,
>>>> +};
>>>> +
>>>>    void fbcon_set_bitops(struct fbcon *confb)
>>>>    {
>>>> -	confb->bmove = bit_bmove;
>>>> -	confb->clear = bit_clear;
>>>> -	confb->putcs = bit_putcs;
>>>> -	confb->clear_margins = bit_clear_margins;
>>>> -	confb->cursor = bit_cursor;
>>>> -	confb->update_start = bit_update_start;
>>>> -	confb->rotate_font = NULL;
>>>> +	confb->bitops = &bit_fbcon_bitops;
>>>>    	if (confb->rotate)
>>>>    		fbcon_set_rotate(confb);
>>> fbcon_set_rotate() is only used to set the correct bitops.
>>>
>>> It would be simpler to just do
>>>
>>> 	if (confb->rotate)
>>> 		confb->bitops = fbcon_rotate_get_ops();
>>>
>>> And rename fbcon_set_rotate() to fbcon_rotate_get_ops() and return the
>>> pointer to the struct.
>>>
>>> The no need to pass the struct, and it is obvious that the bitops are
>>> overwritten.
>> I tried to keep the changes here to a minimum and avoided changing the
>> function interfaces too much.
>>
>> But did you read patch 5 already? I think the cleanup you're looking for is
>> there. fbcon_set_rotate() will be gone. And the update bit-op selection is
>> contained in fbcon_set_bitops(). I guess this could be renamed to
>> fbcon_update_bitops() to make it clear that it updates from internal state.
> Patch 5 looks good, and is again a nice cleanup.
> I like that the code is now more explicit in what it does and do not
> do overwrites.
>
> Returning a pointer or adding the assignment in a helper is not a big
> deal.
>
> With or without the suggested renaming both patch 4 + 5 are r-b.
>
> That said, I am not expert in this field, but at least you had another
> pair of eyes on the changes.

Thanks a lot. I'll update the series and keep it around for a bit, in 
case anyone else wants to comment.

Best regards
Thomas

> I look forward to see the next batches of refactoring you have planned.
>
> 	Sam

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



