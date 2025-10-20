Return-Path: <linux-kernel+bounces-861695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D47BF35F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5CC405C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBD2DC322;
	Mon, 20 Oct 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QWcFPZXD"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5C1EF39E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991726; cv=none; b=dmuwP2khj562dfBe92tVW2z8OwMUUaS1lgQZ4l6i/L/79zG7Ck8yyY3jQEVDt42uwiSAIHGqcKbUzV4nUJfNDAGZjixT6AAfZ2aripDwHwBk8sncDhkJwhnG0pOJRkIzV8mhzF763FoirwmV3m6D/iROc1GH1qE8BUz/5GQFZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991726; c=relaxed/simple;
	bh=57KurvKt64exJVef9Um1G7kmOg2hPNcAt7EPHN5ldjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xsx52pcnRzon7GZBuJOsMUZAGuh5tAsCICcFZzJ4hTLo5mpLVRBlCH7F0Eh1TXMo4+/zqJ6zuP4EV3WduX73mzT/az1xtHXm1s78sRoslsHyNCjXs1S2CPieB0ngLcbF6vhpp5Di+0oyVKzHRCY9w+t02+0BJOOfJngcd6vJk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QWcFPZXD; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso44225095ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760991722; x=1761596522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mg4rdzF03I9VKfQ6A0u6ZEt7ExfErvnSo3bCDGro3gQ=;
        b=QWcFPZXDlF8sEZ9cEuMU2DlxXsy80tueNIUk+OzD/PAQafu0UDJXZ4598MXok65Yx5
         X4KmI/7542ZiG29rYzWbmYDWmgtHfLJldPw5MEup66VhwKCsp4Ob2o9NzFaMEkXX5m2h
         kL8Qt7xqir3gUTG7yrNYaQHM0kKq6HOyQNxLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991722; x=1761596522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg4rdzF03I9VKfQ6A0u6ZEt7ExfErvnSo3bCDGro3gQ=;
        b=ll/ukW4KRocQXQDYrkaQbGAa1FIk6S07OzrO2hw7B+33MEc9NrOU9RzE5R0zp5z47S
         FO3+EvLcstGDQhjBkrRSJjGa3ahZ62cyo/m+bWIeSLhEID82tyhVBAWmNP52a1q1M9Hj
         SqAPELtDyv8MxTgYH1+YuPq+NefURR3Hzbok4w6zjA4CCT6aeP1vKsXMqSTF2SOT/+Ar
         5wktXPdMPIlBhO99TuKKDAxaoKIslMmtZoY7ttViPWWifACdSNYnKfyW4GmoToaJmRvN
         HhTtaY6A0XFN4SBcidTJ540rRYBlZ3WUm20NRS2EHFFYxzN8oSDU3XMNHtkSDkLv5bID
         nJiw==
X-Forwarded-Encrypted: i=1; AJvYcCVmxS/Qh0wxXgIWzv5Bn/+oVeJ/S9KYe+59+RJBwYb1szKxyT1EHPBv3YVD9g7bHP+e78nK5Vwf3BXjt30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPP6Qrp5GOQWovXaN50IiIRYznpMUBaJopHbfgSSUu0olPbjl
	X+OWVjO2RRghSQRIJNsJysDaKtgU2Bk+8u6bkXzH2JW/Osq/n0I4yuIW+UgkHDeSPe6ksOXGL+j
	D+IZa
X-Gm-Gg: ASbGncuSRQVqpag+d4N8Vl2wLO0WGQmAOJVlPhVbL4lUp4Ysj2yZuXHyWOFaXrViRkK
	82ihbJZyx/e6Zw+U6AUhI7qQ3oTpakxVrkaB4CrDy+qVF99uidqVGiIKjJwuB5QE3ojfHfvjJfd
	Q1YeQJfGTyBWHoFuKR9nM/VIK26dhdTEY6ahDRvE5l8kMJqiAuskRwseJAHnldGX9LP1+H3ZkMe
	lt66ZaZG1THcB9vd3+cJx8GbD3jOmpC71rrxabK1ebn+lqJfb776X1L8E8Gk/K7TXCf134oFk7S
	K0iw8iOtnsJU1dT2c/iJSsq8YSAZZ49rNgCMdbtMoQ3kFx6Oz8QjMt0TcbarvOMl8vumLDU7aLR
	O1PPIbRx4ZBgm2H6BJLoMqJCOK7Z+m+9n6BwuMGdike8oij53DIkoxog6JfjHYBYpXU8HSjBOCf
	agAiUoJ+hBbXzF
X-Google-Smtp-Source: AGHT+IEx/5ik37vP/1BDBpbyZ9iaSfWbLzs622j+5vpvMwxWidniwm4iTR3/qfu+5Q474PGa8wVHGQ==
X-Received: by 2002:a05:6e02:1d9d:b0:430:a538:25e7 with SMTP id e9e14a558f8ab-430c52cae26mr231351515ab.29.1760991722165;
        Mon, 20 Oct 2025 13:22:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a973ec13sm3238979173.38.2025.10.20.13.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:22:01 -0700 (PDT)
Message-ID: <dbe75986-348a-4835-ad18-b7545694dfba@linuxfoundation.org>
Date: Mon, 20 Oct 2025 14:22:00 -0600
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

