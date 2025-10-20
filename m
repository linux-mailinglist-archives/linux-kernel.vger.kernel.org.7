Return-Path: <linux-kernel+bounces-861677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E9BF3528
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1856E4EF5DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050C2DAFC1;
	Mon, 20 Oct 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TdkWiIl7"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73212DC780
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990778; cv=none; b=hubBXfNysIeF/4xJRYG6+0M0yGJHnDlOumP8u4lbw9rJLNyar6dyuP12xmxf61Vma/gJPHahvyHiI2HEuILaU/cnLZRqGEsBmtkGQehbVxQggxs6zD30HoUX3TOr67ugy1Mg2ZOsObVNKfP9k0YrneSvcxGPB07AaD5T0Bju/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990778; c=relaxed/simple;
	bh=M14WERNoISUKDIASjp/njJi/I2QySI4GEZLp1C64AYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpGfdk7EyD0U1gbGUBVkSTt6ZVxWkQXXocuVg+2WOrSbrynYhsReLVaN48/n2iacqwc19dqXtBaamcVIROc8K+5b5rEITMSBbyXpqkH0a9ZhVVK2HeWV69THPtsaRsMsnVsVI9y+E4uMmYYqCaBsvtBrTPgr2xdTNq077414zL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TdkWiIl7; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430bf3b7608so42727285ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760990774; x=1761595574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQkO3IuJguHVhXAT8cFCDHDyIOMJuLnuozCyzaC9Aqs=;
        b=TdkWiIl7sLSe18DWGmAwfDu4OfQnWZ3UKP0wc3vlpEBQ4uX7dVgbJOscEEm9elGVy4
         C79OmjobogY/N+7GV3vMjtXuFlODUFhXaUlw7kq1ufc2zDWVWIeTfbAPSyIUg0yrx323
         Hn5VclJs05al2CBP3+gPJXmaz9Ky0l0w0Ifpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760990774; x=1761595574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQkO3IuJguHVhXAT8cFCDHDyIOMJuLnuozCyzaC9Aqs=;
        b=ceJU1usZQ/PNMTiHU7XK8KfSIwphB+9qgoJ+NlwMGc1VVREgS+VVYuDWfyhmfPYQQJ
         pQkJru0YJyTus7AhRbqkE3DLtB+/3XQ15+IXrLBvoP5fqSatfzjNBQrTwIyMSkLEM37L
         XCHBxzMnZTaEf+awEkQj//lXILA3I6y/B9a9ncQqRdbHypsfWfPRvt0AT68XK6TI4EIF
         KBFh9Qy1kcktRq6qRvwaEJ8z83lwtVTUDPQ0nj18CurtrBVjcivEi7mjRJA6P37wPl5m
         7xnksjTAuBvZoa+44xp2k+w64xfrQ4nypRI2ddFKt3dOP6XIJH2HIiZ9GTtusgCdeVm5
         U2qw==
X-Forwarded-Encrypted: i=1; AJvYcCVkffSXl+lJeNCu/S9peAB2R8n9B2z0M1dJmLqfwZ0U4tRy2hyVpuDqm9nYxJSEZRmUYjpzyi9tVFkthN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEXz2hkyPbdd3yxPRzlhWeuGaPp4F0jVdAwq9iZQgXaZqmDV0v
	Edly2VAaTyT8ArmdbzIIsf2G5cqozy6qNE77u/300+E2KfpWXWQgrbHvwi69zfUJM0M=
X-Gm-Gg: ASbGncviD6eQiql5fceRwgYK87uWhsfO0or3BFtW1b7zs2JM5Z7zEnSzXSMrXFsBTz/
	Y5iLE9oTQJfPUc3wUMAlcl4FGLqErrNBauXKANl5yID1WuG5aIFp9P+YoX9jsQpQQJ/ceft3QWc
	+YRK2u1Ff/Bc0rY33xPOWNqVMH78Jq8GJacLgz1BwKZLO0I37aBFHo147lUEVFIRttdzVwXFF87
	nkfwUk0bYg3kUN4eM8AZy9TtOoU957dl1fhUJtPFJqHuz7kiMBb9e8vdsi6WlBpfEdL0Osq2F8u
	IR/ndUpK2d0T6nY3IiWry9VPVWg9m4eOo32GcPS+/5entGyS4obSBfePbPx7nt+Wev6E/LORchg
	2nbfbr0kS3mx3Xz7Vb49Oa+iTOTvWEZPtQ1vxcvC3BQAxTL0eRForQX2Kl5NcSLoXdG+13ppn1s
	kPqmjPmB9PuFh7hzTqH74a4Y8=
X-Google-Smtp-Source: AGHT+IEtvgICWGX8/WbpnP2nVW91/2+QpAoQcberNM3IS3yjxMJRNE6F6lyTYjc+DI/ShO5QUQj4jA==
X-Received: by 2002:a05:6e02:4506:20b0:430:c8ad:81d3 with SMTP id e9e14a558f8ab-430c8ad8410mr170043265ab.30.1760990773634;
        Mon, 20 Oct 2025 13:06:13 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d06f9ff0sm33307335ab.3.2025.10.20.13.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:06:12 -0700 (PDT)
Message-ID: <ea12faad-1735-4a49-a70d-d4cac5629042@linuxfoundation.org>
Date: Mon, 20 Oct 2025 14:06:12 -0600
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <02e617bec795d2ef371069f2d5fb954dfb31a450@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/25 03:50, Jani Nikula wrote:
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
> 
> Also worth emphasizing that this is wildly wrong for any height that is
> not a multiple of 8.
> 
> And I thought I shot down a similar patch not long ago.
> 
> Is there some tool that suggests doing this? Fix the tool instead
> please.
> 

They are documented in https://docs.kernel.org/process/deprecated.html
Mu understanding is that this document lists deprecates APIs so people
don't keep adding new ones.

I didn't get the impression that we are supposed to go delete them from
the kernel and cause a churn.

thanks,
-- Shuah

