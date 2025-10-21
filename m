Return-Path: <linux-kernel+bounces-862452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE580BF5536
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1227A4E83A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C631E0ED;
	Tue, 21 Oct 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfrcVnK7"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F831DDB7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036264; cv=none; b=kqd3dOnvjaI3xHCi0Ye4fbCvBdpRG2uIQ0dx4o4RHD95zPO4XC/6CnXNfpoIwMgD1tLjbkDLGsCDQF/3C0R9knaS1gTI5csu4KOmGm8IvqeGYiXWnfJ+h0pxnNv7E4PSC9M2cpV/nva9N7C0tto8Om9qI1wOyZNmKPjfuujQWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036264; c=relaxed/simple;
	bh=J/k1wLVOkD3GUGrnVtkGjnikZd3EasoKzlYkt6QQfHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paBzLoco3qLb/usVDXcJ/bKOUgNBmvgUqZPuErYFM5Shq9Pwy9xG5tRr47xjBTLx6llxA7Ac4h0eDsP3FzMyPrUCnrEHtDdxBrYRtGCFqk6hScpa9YWbwtdGgxmyxV9HKUf6iT7KeDFs6mS8dsSwsE88iMZavizmB/rTA7esfUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfrcVnK7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3c82276592so102151366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761036261; x=1761641061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYiwgwtNxK6/rIcMjyR2at6k/Vxbv6cWYDWAIm9NAlQ=;
        b=ZfrcVnK7nAz7tdx18TbUv4/+FpTv+HShL0du/wGqPg1wCSt0ao/SvKP4/6rrJWST8G
         QRWihL5Vvo2VphVYtaB8phFWjCfOfGXayghrH6XhPHraBb0ne1SUGRaqjuienAGO5aES
         V0v9t7Wgo/DCJMEmyNrvlZFMlmvhN1RAbj2MhRf0yL310xy17yLLShPqtqsb1aLf6mp8
         doZDnKl2mdpBesrb5eIC242HSN3Xza4WqVWIxaPIud6mtNF9Mv2WwbTE7gxkZus4iKoL
         2FZPHxWeaHx230SvXYvdeKaXHQJfPRiYevXJA5Bv3JDmx4qGCXO0RrvcwQXMYHr71HiO
         yv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036261; x=1761641061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYiwgwtNxK6/rIcMjyR2at6k/Vxbv6cWYDWAIm9NAlQ=;
        b=RvOzjBVquKJoN0JHQkntAeGyxT9M+6zYnsWvcrBMkM9R26DfdLlGZXZbX3xFbFAGv4
         9t53LRyScu91s5CVpctaAQaNlpuzTJI6PdiBlb7XzR65N8DrUUhU+3bzfdTWUim9cxFS
         eGiTbx6i/X5mlJw2FN02RSjWNWkkrjxAO5QBM/I3RMW4grj75Np5V283yLTSyDoTGi8d
         i9KMBIT76aBgbYgvbLnThzJ6PTFrozCMWk4G2U7ci9SbiCqfM7EdmydzjvR2LzsVItxz
         u2KoHgWxEDJR9bf16/72e8SqPjk5yTEnPmWZK/NzvXnt11VgXi45kVpMg18J90jG9Frc
         lYNw==
X-Forwarded-Encrypted: i=1; AJvYcCVWhvWYXoQT6hWFpqZuVXWZPlwkGuxxCIO6iPQUtZqSmOpRDLEICoBqayAg/5c3szZFjm1Zczv2U2l+Waw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4/Gx63pXxrIQW1iM2NXT15iZypHS1FOhZwlWZ92zKiG/NXin
	N/91yhep8VqBZ7XxozWGd2qibUL9AlcRq4c9kpjETs46q2ULApptoaj9
X-Gm-Gg: ASbGncvK0KJDF4xyucuLHdAkho2aqU25uuex9oC6RXMpDt1gP+j9TivzTNEO2YsmqFV
	DlGAK5P7OqLdjpoGNC04W/ykNBmmUcO+kszLGA0SKyaZD052eatcZxM/aW21bdbNRVYv0t8Kf4n
	8ftEYdqnYzEked4LgZE56sAwgFNVTi/YiUDEBfmSdUnw9zVPl2Q371Y02HCH+9oPbSAr4ideHfB
	cwQN0QqOv37c0vIe5InnjIEfP/XcGR0wOXe3bTu9pPiO0MOoxPazIcsYVyRVICRl0ZYC8xa7cov
	6tt3WQiHc1+cVmwNRLcQySt+mkDUMn7ORyiTsnBOZf9jCTQzN4Wmu2rkuO/xiE5Jx2p6GEnoKLP
	S6BMW9UyIAT4YV5OfXVMGNIPXp/DCQOEOaMWhTiicMySAV1g9aYQGjlqsSP+A/T1ANjf8TOkI4W
	qioJ3qwmEfRt9GP4xApKEMFZkDd9K6
X-Google-Smtp-Source: AGHT+IHgFcbQCcTMOQ9kPtrRGAEFN37W9IGTKfgQiKIn3e3zPC+cubu+IIUXeREIVPhgLeQPlMhorw==
X-Received: by 2002:a17:907:9708:b0:b04:2d89:5d3a with SMTP id a640c23a62f3a-b6475505d94mr1071125466b.7.1761036261251;
        Tue, 21 Oct 2025 01:44:21 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da2bbcsm1000822466b.5.2025.10.21.01.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:44:21 -0700 (PDT)
Message-ID: <d7e06f84-c555-4eb7-b781-b8444eedd625@gmail.com>
Date: Tue, 21 Oct 2025 10:44:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: Refactor framebuffer's size calculation
To: Thomas Zimmermann <tzimmermann@suse.de>, lanzano.alex@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251020115803.192572-1-mehdi.benhadjkhelifa@gmail.com>
 <1de3112b-6349-46d8-b90b-69d0849c7659@suse.de>
 <6a917f07-18dd-4f8f-bfc5-b85d9051339d@gmail.com>
 <4b01c775-f87a-4c3c-88f1-f5c52261d9b2@suse.de>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <4b01c775-f87a-4c3c-88f1-f5c52261d9b2@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/25 9:32 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.10.25 um 10:41 schrieb Mehdi Ben Hadj Khelifa:
>> On 10/21/25 7:51 AM, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 20.10.25 um 13:57 schrieb Mehdi Ben Hadj Khelifa:
>>>> Use drm_format_info_min_pitch() to calculate the framebuffer line pitch
>>>> instead of directly multiplying width and height. This aligns with DRM
>>>> helpers for determining per-line byte size and avoids manual 
>>>> assumptions
>>>> about bytes per pixel.
>>>>
>>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/tiny/repaper.c | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/ 
>>>> repaper.c
>>>> index 4824f863fdba..aeff49bc6ba7 100644
>>>> --- a/drivers/gpu/drm/tiny/repaper.c
>>>> +++ b/drivers/gpu/drm/tiny/repaper.c
>>>> @@ -517,6 +517,8 @@ static int repaper_fb_dirty(struct 
>>>> drm_framebuffer *fb, const struct iosys_map *
>>>>       unsigned int dst_pitch = 0;
>>>>       struct iosys_map dst;
>>>>       struct drm_rect clip;
>>>> +    const struct drm_format_info *info = fb->format;
>>>
>>> This is the wrong format. You're allocating the output buffer here, 
>>> but you're using the input format. IIUC the output format is 
>>> DRM_FORMAT_R1. The input is _XRGB8888.
>>>
>> Ah. Thanks for clarification.I thought since it had the same output 
>> format. I will send a v3 shortly.> Best regards
> 
> Maybe just don't do it. This is just churn with no clear goal.
> 
Okay,I will abort working on it.Though my goal was to remove the manual 
assumption that height is multiple of 8 and to align with other 
'correct' API used in other drm drivers as you suggested[1].

[1]:https://lore.kernel.org/all/cb0f0a36-0593-4d4c-8450-d086b9c99d87@suse.de/

Best Regards,
Mehdi Ben Hadj Khelifa> Best regards
> Thomas
> 
>>> Thomas
>>>
>>>> +    size_t pitch;
>>>>       int idx, ret = 0;
>>>>       u8 *buf = NULL;
>>>> @@ -534,7 +536,9 @@ static int repaper_fb_dirty(struct 
>>>> drm_framebuffer *fb, const struct iosys_map *
>>>>       DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>>>>             epd->factored_stage_time);
>>>> -    buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>>>> +    pitch = drm_format_info_min_pitch(info, 0, fb->width);
>>>> +
>>>> +    buf = kmalloc_array(fb->height, pitch, GFP_KERNEL);
>>>>       if (!buf) {
>>>>           ret = -ENOMEM;
>>>>           goto out_exit;
>>>
>>
> 


