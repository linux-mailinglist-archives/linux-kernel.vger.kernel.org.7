Return-Path: <linux-kernel+bounces-859769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E9BEE834
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E85B74EA9F2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574FE2EB876;
	Sun, 19 Oct 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnPXyELs"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074635966
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886235; cv=none; b=uA1//fCfDBpt4rRWEsCTSaQgl8Y0g5X8ZupwxUJT97zAET1HJjuJLufZGdK8fBZiM1rm5IgoGxjcRZnFF0cfxvW9CntA9nJJuIZvTmac2QqLuagD9GCbKMQCpdaY9hiHJprXZ/MjuYXbG4GJsOykMiU2QIfgFlcTMfqPRaEpbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886235; c=relaxed/simple;
	bh=vBM/xIZ40/SjaB/zXEdhYY+kJhrkNTuMgWw0XXXBvfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAULKoTyTTnF2hDw2X3deIrBVi/jfPtuuYhdgXBKReYeD7aAFxwDsTkY+KwN0KZbT5WDkSlAXd6uZRvpjnzLrb5CBX/UIaO7FkNfw0U8+dswD8gBpcw/H4YI2E/rrLK498M6n+ZecGcxKEl6yPDYhvjuoTV+v0s0Ir4Ts6buqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnPXyELs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3c76f3703cso57271366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760886231; x=1761491031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9udsA3BE7foY00QqPjtJbwYeXlQDHSIpbrDLCZLLAM=;
        b=BnPXyELsFu8uWP68XGAcEIT9aSvJkdHhTg3rxbSqqz5Ovakc46M5S02Xgnu0p22oCa
         L6daE1KVVFUxRtwhXh6qnRWfayZhUYC6JWw5S554Z0Uj907ldQeGrp0YZRSpJOuebzyW
         mKjgkVQLAQyyf9AQhSc+Rs46jwZaK0AC32KLYjLzw+WXaBbsyqluBArP/JD/FlQSzq3Z
         kLlnAX7RY/y9G4VBzJBb3VLHXvLWAmVLfWJNhIaRVNGLEvNP9p1ugzMHH1Qll+/SUJcn
         nWeWI2ZiG5Ceu3ZHuApAlNe1zc8scvbxF53W5ZKuMSxnLqq9h5P2UbV0xuZ7+XPBu5KS
         3gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760886231; x=1761491031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9udsA3BE7foY00QqPjtJbwYeXlQDHSIpbrDLCZLLAM=;
        b=rFXch4b7OeaiHTaZpvw9BKraNCJaEfRGYDbWb3G4/1d5t/Tx0UY7vpa8RppTVl16Y1
         ZPusSzJwYps//Bc5q1SEJilsJSMnVSe1o1lHpYtp+yxnQHzz2g+CpVM1aBNyz0x1wFZL
         e010YwEj5ZkjWP7W05UCdvrnJnpQUU/Lh+XPfbQAgagCylXzHgIpyM2oqbHZTaqHgUzX
         Le0MzgTFYXzzd8owfHDA8m1SPtYGAEDdF8JP6ODhWWANHUAjMvcpOj3pkVgPIBlbdmYx
         RU2HTo+GonYzFYH8hxtBNA5lpsGgsWABx0+D5G5S6B9vFlDig18MOcHh3eAWEkixKSBY
         +B5A==
X-Forwarded-Encrypted: i=1; AJvYcCUUn0VtbXWlDDG+ivlnJQUIg0MjwPWqQOn6EJge+PDo0FSupdL81ves8ykJy+1OwUvkvr5bk7ecgq8nj+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwniwstqvFOFBM4/eUdNmjXRjRFQyNXjUueUiPDlaZSg6tvBUv5
	i1hGgu6z/9FQa+GzlLkEurBsNRpDv7U4UIEMdmx3uXAAqFSy5nILPhP7
X-Gm-Gg: ASbGncuVoPxkXLr4YtpT+VxX/MtIMW0wAOIEB07pBUVoEgRI6mQKomz2r/GdpmaBlvD
	HYQmBNoeQ5pGfNuMJWn8D3ht217DIkGbAOA8hZiZ8JnbBaTZlM86S1dS8IWTu5QwwimJIryD0+r
	4sFwMt0fNuLQCR6s1RCrwEQAKsa1x28PRC2f97Y31tm+mc5rl1ebSq7Ugrk0d57KaiAMxEGxmYn
	xy+LZ+KoL1b2U2l9SpBUYkkYHdXDVVSoQ2Vz2DlbAx8v0PFZWzppmZA7F8J01zGXx+s3ZE0D9D/
	b3OB+5MlZQF3uLqIsDktXlJKlJ6t6kcB9xTi7Z8onIGtXiEeCqZGXcp9LZKN8+36CariirMZl3T
	IvMzveRFt2HPGr701G1BOZkhUDdrg6E/2AJ2jeiUJVxEn2Hi7gfGP8FyDQfG1Fy1tqt1fZzRl8X
	gWfLGrAh/X9HlM+HRR+KtR
X-Google-Smtp-Source: AGHT+IH6TluHuNvwOnAVvgBjwGA0zfWFt6b5AZGTbaDmowoHujtKj2lEr/TiFV0djG0kgxyb8b/vig==
X-Received: by 2002:a05:6402:2751:b0:634:4e0:8377 with SMTP id 4fb4d7f45d1cf-63c1f634390mr5314959a12.2.1760886230847;
        Sun, 19 Oct 2025 08:03:50 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a92961sm4345576a12.8.2025.10.19.08.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 08:03:50 -0700 (PDT)
Message-ID: <d072dfe7-e0e9-49f6-89ed-25d194035e3b@gmail.com>
Date: Sun, 19 Oct 2025 17:03:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: lanzano.alex@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251019151247.171558-1-mehdi.benhadjkhelifa@gmail.com>
 <2025101910-dipper-suburb-1755@gregkh>
 <cb0f0a36-0593-4d4c-8450-d086b9c99d87@suse.de>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <cb0f0a36-0593-4d4c-8450-d086b9c99d87@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/19/25 3:47 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 19.10.25 um 16:34 schrieb Greg KH:
>> On Sun, Oct 19, 2025 at 04:12:28PM +0100, Mehdi Ben Hadj Khelifa wrote:
>>> Replace kmalloc() with kmalloc_array() to correctly
>>> handle array allocations and benefit from built-in overflow checking[1].
>>>
>>> [1]:https://docs.kernel.org/process/deprecated.html
>>>
>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>> ---
>>>   drivers/gpu/drm/tiny/repaper.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/ 
>>> repaper.c
>>> index 4824f863fdba..290132c24ff9 100644
>>> --- a/drivers/gpu/drm/tiny/repaper.c
>>> +++ b/drivers/gpu/drm/tiny/repaper.c
>>> @@ -534,7 +534,7 @@ static int repaper_fb_dirty(struct 
>>> drm_framebuffer *fb, const struct iosys_map *
>>>       DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>>>             epd->factored_stage_time);
>>> -    buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>>> +    buf = kmalloc_array(fb->height / 8, fb->width, GFP_KERNEL);
>> This isn't an array, so this function change doesn't seem to make much
>> sense, right?  The size should have already been checked earlier in the
>> call change to be correct.
Yes,I was intending to say framebuffer but I was working on another 
similar patch simultaneously so I reused same words by mistake. Thanks 
for clarifying that.>
> Yes, we've recently received plenty of these pointless changes. The 
> correct code would compute the number of bytes per pixel using 
> drm_format_info_min_pitch() and multiply with fb->height. The latter 
> could (maybe) use kmalloc_array(). It would still not be an array in the 
> common sense.
> 
Thanks for the review and suggestion.I will be sending a v2 patch with 
the recommended code change.

Best Regards,
Mehdi Ben Hadj Khelifa> Best regards
> Thomas
> 
>>
>> thanks,
>>
>> greg k-h
> 
> -- 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)


