Return-Path: <linux-kernel+bounces-860665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E025DBF0A83
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B513A622E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4765724A051;
	Mon, 20 Oct 2025 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZL8vjzwo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qG6kgw/C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yVkVGVcE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sxtp60tv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167F1FBEA2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957354; cv=none; b=CraDwODJ2BPmVd7fCwtmLA1dMI7kAnwD7Rn3+8SbFwy1S8JmLkqbgA2JhuCaQ7veRw0EQmS+trOjYMmbLNeGGa6p6cK7HhkVhBfBGaytvaA7RyJ9sS8vYBlwrlqEL3A4qDBHO/pZeGYGUlM8sGnorFfs8Vhh2BXv/dkw2XM2EqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957354; c=relaxed/simple;
	bh=I3/DGCoEYQewn0HWxxQ90UR7rwdxR0vMCz5fJOY3F3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYfoZ8Os5V8t2MfRuxSDk6I0vHZJIiYCgiDo7jGrX8eQNMGCxPRGe0oiDOdnvBDiZ7Fb9NCeX+mtRFWG2IbLhG2uXsX+IpdiruYE16VXvdvKtIo/oitmq/9eDM0IU1d2RoJV3k8nkX7nT7Zpm7/NRAcbR6pMlqT1SkmMqztUoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZL8vjzwo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qG6kgw/C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yVkVGVcE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sxtp60tv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78A8B21168;
	Mon, 20 Oct 2025 10:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760957346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L/1PNH6wOs+QKkt+SZGzRCm3ajzjR5Lfr6SqCxfTmXM=;
	b=ZL8vjzwoLnYnH34PE23uOZ3F3KME+KZqah3J6iLrOAuIGG55a1y8khNsokLPisKQFkB+Zt
	IfFjIAA51YwretPO3zXQ9pzqjpBpQBzUGYhJV7HdtTqtgVFwL9FvAaassisqgZgltkQdXh
	FaRqTnUnLqQgIlh3Y4q12lSnp/zOa5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760957346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L/1PNH6wOs+QKkt+SZGzRCm3ajzjR5Lfr6SqCxfTmXM=;
	b=qG6kgw/CY6HgazkCA5OvgraUaaiZ8GzmN1dAVcaS9c5yhq0IRWciCYu1uXelFRUyde7frd
	ZojSTnZ7cd6wfTAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760957342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L/1PNH6wOs+QKkt+SZGzRCm3ajzjR5Lfr6SqCxfTmXM=;
	b=yVkVGVcEVd7iFkUB1cHgrafjLLLjojOwjg/Skee+K1+9rLOaXYuolwlrpV9HaLRDziYRcq
	X16Wox/4ZiEeh5KUB5dCsJE2+nk8vIyh6dv6IsDBAGjI8WBqAl+MQwa5rOpU9YiuM8e1nu
	hqWiMvaBFP97+XG10aq55w/+z94zSaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760957342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L/1PNH6wOs+QKkt+SZGzRCm3ajzjR5Lfr6SqCxfTmXM=;
	b=sxtp60tvPcS0gxsQlJPO2QZD3N2ZFt3J9tNCVfpnbxgiffn3XaIkEn81I7Fu6JhneWxPqi
	OUMweWftSXID6aBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10DDD13A8E;
	Mon, 20 Oct 2025 10:49:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mjY2Ap4T9mhCUgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 20 Oct 2025 10:49:02 +0000
Message-ID: <3aa0ef90-22e1-4531-b059-57d924c44011@suse.de>
Date: Mon, 20 Oct 2025 12:49:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: lanzano.alex@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251019151247.171558-1-mehdi.benhadjkhelifa@gmail.com>
 <2025101910-dipper-suburb-1755@gregkh>
 <cb0f0a36-0593-4d4c-8450-d086b9c99d87@suse.de>
 <d072dfe7-e0e9-49f6-89ed-25d194035e3b@gmail.com>
 <02e617bec795d2ef371069f2d5fb954dfb31a450@intel.com>
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
In-Reply-To: <02e617bec795d2ef371069f2d5fb954dfb31a450@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,linuxfoundation.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,vger.kernel.org,linuxfoundation.org,lists.linuxfoundation.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi

Am 20.10.25 um 11:50 schrieb Jani Nikula:
> On Sun, 19 Oct 2025, Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:
>> On 10/19/25 3:47 PM, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 19.10.25 um 16:34 schrieb Greg KH:
>>>> On Sun, Oct 19, 2025 at 04:12:28PM +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>> Replace kmalloc() with kmalloc_array() to correctly
>>>>> handle array allocations and benefit from built-in overflow checking[1].
>>>>>
>>>>> [1]:https://docs.kernel.org/process/deprecated.html
>>>>>
>>>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>>>> ---
>>>>>    drivers/gpu/drm/tiny/repaper.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/
>>>>> repaper.c
>>>>> index 4824f863fdba..290132c24ff9 100644
>>>>> --- a/drivers/gpu/drm/tiny/repaper.c
>>>>> +++ b/drivers/gpu/drm/tiny/repaper.c
>>>>> @@ -534,7 +534,7 @@ static int repaper_fb_dirty(struct
>>>>> drm_framebuffer *fb, const struct iosys_map *
>>>>>        DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>>>>>              epd->factored_stage_time);
>>>>> -    buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>>>>> +    buf = kmalloc_array(fb->height / 8, fb->width, GFP_KERNEL);
> Also worth emphasizing that this is wildly wrong for any height that is
> not a multiple of 8.

Yes. I skipped over details as the format helpers would solve this 
problem if done correctly.

>
> And I thought I shot down a similar patch not long ago.

You did AFAIR.

>
> Is there some tool that suggests doing this? Fix the tool instead
> please.

There's this todo item that the patch refers to. Volunteers discover 
these and start working. But without mentoring, it's often not to 
anyone's benefit. I've noticed a similar pattern wrt the DRM todo list.

Best regards
Thomas

>
> BR,
> Jani.
>
>
>
>
>>>> This isn't an array, so this function change doesn't seem to make much
>>>> sense, right?  The size should have already been checked earlier in the
>>>> call change to be correct.
>> Yes,I was intending to say framebuffer but I was working on another
>> similar patch simultaneously so I reused same words by mistake. Thanks
>> for clarifying that.>
>>> Yes, we've recently received plenty of these pointless changes. The
>>> correct code would compute the number of bytes per pixel using
>>> drm_format_info_min_pitch() and multiply with fb->height. The latter
>>> could (maybe) use kmalloc_array(). It would still not be an array in the
>>> common sense.
>>>
>> Thanks for the review and suggestion.I will be sending a v2 patch with
>> the recommended code change.
>>
>> Best Regards,
>> Mehdi Ben Hadj Khelifa> Best regards
>>> Thomas
>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>> -- 
>>> -- 
>>> Thomas Zimmermann
>>> Graphics Driver Developer
>>> SUSE Software Solutions Germany GmbH
>>> Frankenstrasse 146, 90461 Nuernberg, Germany
>>> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
>>> HRB 36809 (AG Nuernberg)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



