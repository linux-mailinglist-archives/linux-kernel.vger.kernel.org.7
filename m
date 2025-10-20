Return-Path: <linux-kernel+bounces-861684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D6EBF3573
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94446350E74
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDB330506E;
	Mon, 20 Oct 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxr9d6B/"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957482E090E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991101; cv=none; b=sVXE1LvoITZDVNJZzyAXb8EFEnM6l1Lp8erZzxe70HM7FgjTuzgq4wP8e+dTVc8/5C6Mjnt5BT99JbwliUBPD9DMMUF7nuxXBuwT4LCQfArRfhUuOpLqscU89iQM3ZtbOE28mT5djgj1gshxDPb0uUYhjpkOSG7KH8HBNs0Myog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991101; c=relaxed/simple;
	bh=V6ULhW8H38NcYr33oKX3sVtwABaGZ1jZoxnobG/0Uto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lI4YqgIGPrNv1hZY+82LKJysZrzAzyXuns2BavANO5huii1f5NU4wDzQK2YNs9vPhkrvsf5+IamXSAvGLiZg7HQZMZYiwYBtZ6C0+5TLASsPnEFv959LtDFKsScerzfRn3xrJWb0bAOKcH6RGONhZ0MTdg/AEa5I6ZgCN/3qdi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxr9d6B/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3ce040db85so74277866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760991098; x=1761595898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pYR5fc+13GPBMaNnLf78tmb9Ja2klUsIxWce12udek=;
        b=Kxr9d6B/HpkAvO9hmycZwO3nxL4NQqHGnEFDtK0uN5FI3JYgoFTqhxe8TDMiKJeKsL
         GwyNoHVShDgwdvOVHTWbkPnH9NcdJ2A0D+3y0vn/tZAyT74ATtWQwdUQe0Rn04ZT4CJg
         lKR7+kJ9pxibIf0IMRCOdjS3Bs1wiaU0TCeXfFIKk9aMbrGMO3gW6Iov/WWYAOIbxAg1
         RMU+gnzmqbufwxAI8expfw6QcLDZ9H34kmxORw6V3O5ue2WizygpHLBoXf5db5uBrR1k
         8LfAiJbiuerhQJpOGfzl1kO4Xc/NM0KZfVPYS/pK9J8bGVZJolJ9r4Piz9jjTfr886GV
         5dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991098; x=1761595898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pYR5fc+13GPBMaNnLf78tmb9Ja2klUsIxWce12udek=;
        b=BbUKnxqtyAQqSg6IADiLuPgX5UclkAkNTU6H6nr8+8/omhB7ptcGziyMIcxJ9pPdkP
         wTxnn3+ByQKLfb9gj+Tb9WJGo2ZYbawWmiYCGO8jHhQbS4O4q0SXas9Rnai66/nF+C2n
         wkUoCXJ3Q3Fwu/+kz7HLArHXDHgjMVD7ik0pROugITsOy4Fk2CF/yHgh7LX0+ihw7yo2
         IK6d1Bpo1+S1BE8rDdWfV+4qcVYL+bT6sksLR4WUH2vJwBUxEAnEYtTubhb8xFGpbay5
         6yhF55uNe1h1BIx9eoTTfyYelbvWeVpg5gei5zln0o7jLhHlXMzWIV8nZN3xUyTaDHOH
         dPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4KX9XZFpH6u/iLUENQRGxdzdDU+XwfxnqMJy79vuMAT8X7rxkbSmw0ROE6cPKFEd5GMC7rIJKkivUqpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC0SBHHuOfo+iSlAPAtP42PoHefXwBpsswGq6YNyNBvydjXSy0
	2TXwT2z41xHGEAriq+uNZVqzplG497HSmJvShAO11BXt2oEj3Yhpf+hN
X-Gm-Gg: ASbGncuWi2xxiLc2uoqJOogWG5xFi6SNPtzEeLCR53/1ZC8WKhrzRAjCmaq00r89E4d
	A3QntzZ15oGYoFIq6ihB2V53nz8SUAGTSc/+lYpQs0Y0DH0UUKuIDjkH8FQm4PhYp6UUohE/Mvg
	ee5GrhcRK6qfqSE00Zaa/hFN9604tKdlbbl7UrLZE9JmTkshdngPbJac+bg0LZjMB7e+sl3cywq
	yBIvsPQtg6kbo/K4nQQ18QLBplYH4wiXxDfJTS+v+zkcKW1Go8WHeGC7KpleWXRsU6A9mz2oSG4
	DXm/FuivqVU1AcBjLiWLEgFzPfo5eNsIqO9BGFVBilTAd06OZ/l+Mw8wK8uYy9JB68CrPtuL2FV
	mKxX7lELX5wOVictHRc4R5d/+NHwXGkbYzqUjcZCw5t2o/H3s7wS18LXLIK46/xU1/0CVu3jI3z
	rzmC/g6y+J4EyZegAgIcYR6PeE8XU+
X-Google-Smtp-Source: AGHT+IGfP+vFkv8zioVQynwazhbvBh6MaoC6q2IrSLhmWZgtPgsGhhqQc2LuymVoNGeawx228yiFQQ==
X-Received: by 2002:a17:907:72cb:b0:b3e:c7d5:4cb9 with SMTP id a640c23a62f3a-b6c7758d3fdmr67446066b.5.1760991097698;
        Mon, 20 Oct 2025 13:11:37 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm873186966b.68.2025.10.20.13.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:11:37 -0700 (PDT)
Message-ID: <b0b1c2e9-c367-4e9c-b931-d3e1b0ba7f5b@gmail.com>
Date: Mon, 20 Oct 2025 22:11:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
To: Shuah Khan <skhan@linuxfoundation.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: lanzano.alex@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251019151247.171558-1-mehdi.benhadjkhelifa@gmail.com>
 <2025101910-dipper-suburb-1755@gregkh>
 <cb0f0a36-0593-4d4c-8450-d086b9c99d87@suse.de>
 <d072dfe7-e0e9-49f6-89ed-25d194035e3b@gmail.com>
 <02e617bec795d2ef371069f2d5fb954dfb31a450@intel.com>
 <ea12faad-1735-4a49-a70d-d4cac5629042@linuxfoundation.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <ea12faad-1735-4a49-a70d-d4cac5629042@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/25 9:06 PM, Shuah Khan wrote:
> On 10/20/25 03:50, Jani Nikula wrote:
>> On Sun, 19 Oct 2025, Mehdi Ben Hadj Khelifa 
>> <mehdi.benhadjkhelifa@gmail.com> wrote:
>>> On 10/19/25 3:47 PM, Thomas Zimmermann wrote:
>>>> Hi
>>>>
>>>> Am 19.10.25 um 16:34 schrieb Greg KH:
>>>>> On Sun, Oct 19, 2025 at 04:12:28PM +0100, Mehdi Ben Hadj Khelifa 
>>>>> wrote:
>>>>>> Replace kmalloc() with kmalloc_array() to correctly
>>>>>> handle array allocations and benefit from built-in overflow 
>>>>>> checking[1].
>>>>>>
>>>>>> [1]:https://docs.kernel.org/process/deprecated.html
>>>>>>
>>>>>> Signed-off-by: Mehdi Ben Hadj Khelifa 
>>>>>> <mehdi.benhadjkhelifa@gmail.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/tiny/repaper.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/
>>>>>> repaper.c
>>>>>> index 4824f863fdba..290132c24ff9 100644
>>>>>> --- a/drivers/gpu/drm/tiny/repaper.c
>>>>>> +++ b/drivers/gpu/drm/tiny/repaper.c
>>>>>> @@ -534,7 +534,7 @@ static int repaper_fb_dirty(struct
>>>>>> drm_framebuffer *fb, const struct iosys_map *
>>>>>>        DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>>>>>>              epd->factored_stage_time);
>>>>>> -    buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>>>>>> +    buf = kmalloc_array(fb->height / 8, fb->width, GFP_KERNEL);
>>
>> Also worth emphasizing that this is wildly wrong for any height that is
>> not a multiple of 8.
>>
>> And I thought I shot down a similar patch not long ago.
>>
>> Is there some tool that suggests doing this? Fix the tool instead
>> please.
>>
> 
> They are documented in https://docs.kernel.org/process/deprecated.html
> Mu understanding is that this document lists deprecates APIs so people
> don't keep adding new ones.
> 
> I didn't get the impression that we are supposed to go delete them from
> the kernel and cause a churn.
> 
I have sent an appropriate v2 specifically to suit the case that we have 
here. But the document[1] specifically quotes the following:"
Dynamic size calculations (especially multiplication) should not be 
performed in memory allocator (or similar) function arguments due to the 
risk of them overflowing. This could lead to values wrapping around and 
a smaller allocation being made than the caller was expecting. Using 
those allocations could lead to linear overflows of heap memory and 
other misbehaviors. (One exception to this is literal values where the 
compiler can warn if they might overflow. However, the preferred way in 
these cases is to refactor the code as suggested below to avoid the 
open-coded arithmetic.)"
Specifically mentionned the refactor of the code base in such cases 
which is why i'm doing the patches in the first place.Also i'm trying 
the best to send patches related to the issue where such issues of 
overflow are present or to be consistent with the same API used within 
the same subsystem.
[1]:https://docs.kernel.org/process/deprecated.html

Best Regards,
Mehdi Ben Hadj Khelifa> thanks,
> -- Shuah


