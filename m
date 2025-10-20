Return-Path: <linux-kernel+bounces-861704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD5BF3694
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B936318C3104
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FDA334C1F;
	Mon, 20 Oct 2025 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YnvKDnBI"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF700333736
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991777; cv=none; b=eoAP5ac6U0W2SVhAW2QFw1E7D5wej3cg0cycVtC5ZAW3dZ46HfEIYyhICgAVZ1qyGSyGHHuQCsDKLLtkFWyaJaDOGepSmtcjRc3GitbVQVo+AIig7KEFzrmjBqk01YPEGPyJ1iLeKhsM52yIdMrIL1grdC/ga/aa7C8KdIxD0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991777; c=relaxed/simple;
	bh=57KurvKt64exJVef9Um1G7kmOg2hPNcAt7EPHN5ldjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAXIWmOVJO1kHv6X3JQdC+RAGDLgEZaYDSjC0ZfzKwqYM7zzGiiHnoXM9Fki2LYpaTHNZPed7dy8h3Bfi0sGp2DN1fZW0c7+qqxiYk2Fyk9PZ5mDQhsJwdBtDqpUXrtP+XSkS4k9DYEywxDtTLe9mEZgcNyvsq978/+EOS5qYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YnvKDnBI; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93bccd4901aso414413139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760991774; x=1761596574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mg4rdzF03I9VKfQ6A0u6ZEt7ExfErvnSo3bCDGro3gQ=;
        b=YnvKDnBIbC8+L/eYKLRZq5KTo2UJYZGMyjmNVaW3LvrfBjoXHfZqz4YYChcMRm5G8k
         2ClR8VBljutQ408v5vkkZFbhN9fsDGOpwY5FogEcotYd9z+ebREOJcZH8JKsGgFSRq72
         N6hOaRPlIBcqpoj9ZdxWN0FsITsEKWNhICA5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991774; x=1761596574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg4rdzF03I9VKfQ6A0u6ZEt7ExfErvnSo3bCDGro3gQ=;
        b=hc2MQIVVZjpniSyvnvZwgWnkjnj6dTq/Uej+r1Kc/2xbxIFVyXYrmM1XoblalwSc38
         Jenn/1ha6ImC8AoozSb5n+DJjCNFJLF/g7n/bzQdjzKKPbT3cKVxFQWDVmvPLT0+Nye1
         +EHiHAlaeh4PdSvQBhg83nym8yPE0Qx7MY7LiAdgB2BJxyVVooqVBDuvKO+r36ucMdGu
         VkWnTVjBB4u4kB/hai5gTrvggdUXNLbAkZLJjWNXbaqE/zEJqdc4sho2Y5lqpl1xITLm
         +OZtPaqVRt0/aRbevR13ROX/niy7mcjYIrj00F7oRaZQaOMhiJhEs2WYztYcxyQPIYiQ
         Ev+w==
X-Forwarded-Encrypted: i=1; AJvYcCUPQwmKrmhJWXcf29SQH45kEmNwB9BnT/Hh33Hd9dt16CY5RbMqvPyLuo6YNVy0AGxShLFSZ4JtS0hSwrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8HSqFa1cZOpWpBr4RiXGFu5jZ30mOAiuf2yUJzDNuiy5LyJi
	+G7fFYbwsFyfXMXvZkGufQ6zXbkvDJYWXhJ6U+SgxfP2FHGBGi27nTrqRnDP0uziFWo=
X-Gm-Gg: ASbGnctMpX2wWqIGXJA08t5UVw48mO7r4f4mYFPHd8pkVTvbm68Wc0gh9JH8y6UMK7f
	wVUkkiCWw4sTpdOhdUp/t1Sq7DysXqB+GR38hm6GsLCXtqT4GSdyZQSR+l6IlTfNXKAZnOnpZb5
	z1D59d30T9qed/jf6UAu2Zj3pMNA3YMRrJwfyQBbDhhrLXf++LJRN2NRVQFMTUchYXSUYFBnXlj
	t49SMp+LwL3gAB/aM5s5DIdrJEwC7oULfibt1FJS94SPNxsEV87jWlBC37Viw+5KSJedbZciRk5
	kSZm2EW7DXGAUovSbl/LLwHTmTL9leVtpiNQ9kvIP7S0cEbmARw8x80nnjOaUzXV7bYsOoB9K9G
	jAaaDpsAY05X7AJCXgbA3D/XJ5qFlZDVOhaQ6oxD6ETowcTaypW8UMLF7rGl/e8aqPIPkD3RFG5
	RaWM72E2N+2UXkwqFDPYXAGQc=
X-Google-Smtp-Source: AGHT+IH3lraseKHKDfkvaNbqZdA/pDcJuk3ieKtNJ64spgnZ1oKvXWo8ZrnWbAQWu1y8fgRUWB7mKQ==
X-Received: by 2002:a05:6602:3f91:b0:887:6ce4:8e07 with SMTP id ca18e2360f4ac-93e763ccef2mr2303274739f.9.1760991773699;
        Mon, 20 Oct 2025 13:22:53 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e8661d228sm327198839f.1.2025.10.20.13.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:22:53 -0700 (PDT)
Message-ID: <21415b1d-17c0-42a0-961c-a4aee16d20d1@linuxfoundation.org>
Date: Mon, 20 Oct 2025 14:22:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: lanzano.alex@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251019151247.171558-1-mehdi.benhadjkhelifa@gmail.com>
 <2025101910-dipper-suburb-1755@gregkh>
 <cb0f0a36-0593-4d4c-8450-d086b9c99d87@suse.de>
 <d072dfe7-e0e9-49f6-89ed-25d194035e3b@gmail.com>
 <02e617bec795d2ef371069f2d5fb954dfb31a450@intel.com>
 <ea12faad-1735-4a49-a70d-d4cac5629042@linuxfoundation.org>
 <b0b1c2e9-c367-4e9c-b931-d3e1b0ba7f5b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b0b1c2e9-c367-4e9c-b931-d3e1b0ba7f5b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/25 15:11, Mehdi Ben Hadj Khelifa wrote:
> On 10/20/25 9:06 PM, Shuah Khan wrote:
>> On 10/20/25 03:50, Jani Nikula wrote:
>>> On Sun, 19 Oct 2025, Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:
>>>> On 10/19/25 3:47 PM, Thomas Zimmermann wrote:
>>>>> Hi
>>>>>
>>>>> Am 19.10.25 um 16:34 schrieb Greg KH:
>>>>>> On Sun, Oct 19, 2025 at 04:12:28PM +0100, Mehdi Ben Hadj Khelifa wrote:
>>>>>>> Replace kmalloc() with kmalloc_array() to correctly
>>>>>>> handle array allocations and benefit from built-in overflow checking[1].
>>>>>>>
>>>>>>> [1]:https://docs.kernel.org/process/deprecated.html
>>>>>>>
>>>>>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/tiny/repaper.c | 2 +-
>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/
>>>>>>> repaper.c
>>>>>>> index 4824f863fdba..290132c24ff9 100644
>>>>>>> --- a/drivers/gpu/drm/tiny/repaper.c
>>>>>>> +++ b/drivers/gpu/drm/tiny/repaper.c
>>>>>>> @@ -534,7 +534,7 @@ static int repaper_fb_dirty(struct
>>>>>>> drm_framebuffer *fb, const struct iosys_map *
>>>>>>>        DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>>>>>>>              epd->factored_stage_time);
>>>>>>> -    buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>>>>>>> +    buf = kmalloc_array(fb->height / 8, fb->width, GFP_KERNEL);
>>>
>>> Also worth emphasizing that this is wildly wrong for any height that is
>>> not a multiple of 8.
>>>
>>> And I thought I shot down a similar patch not long ago.
>>>
>>> Is there some tool that suggests doing this? Fix the tool instead
>>> please.
>>>
>>
>> They are documented in https://docs.kernel.org/process/deprecated.html
>> Mu understanding is that this document lists deprecates APIs so people
>> don't keep adding new ones.
>>
>> I didn't get the impression that we are supposed to go delete them from
>> the kernel and cause a churn.
>>
> I have sent an appropriate v2 specifically to suit the case that we have here. But the document[1] specifically quotes the following:"
> Dynamic size calculations (especially multiplication) should not be performed in memory allocator (or similar) function arguments due to the risk of them overflowing. This could lead to values wrapping around and a smaller allocation being made than the caller was expecting. Using those allocations could lead to linear overflows of heap memory and other misbehaviors. (One exception to this is literal values where the compiler can warn if they might overflow. However, the preferred way in these cases is to refactor the code as suggested below to avoid the open-coded arithmetic.)"
> Specifically mentionned the refactor of the code base in such cases which is why i'm doing the patches in the first place.Also i'm trying the best to send patches related to the issue where such issues of overflow are present or to be consistent with the same API used within the same subsystem.
> [1]:https://docs.kernel.org/process/deprecated.html
> 

How are you testing these changes? Next time give more details on the
where you found the problem - it is easy to miss the link unless you
state that it is coming from the deprecated document.

Even so you have to explain why the change is applicable to the code
you are changing. How are you testing these changes. I have seen more
patches from you in drm drivers and lib code.

thanks,
-- Shuah

