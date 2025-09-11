Return-Path: <linux-kernel+bounces-812007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C813B531A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7121BC5FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283543081DA;
	Thu, 11 Sep 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsfyaGGi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF51CBEAA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592050; cv=none; b=WV+Q8yfBA8Ezqn3ZrHiKwVggcYI1rBTuKbGmyvVlpi8jCoccvyL5s99fRHm3WIhHRydlzGxZJ91e9zzBRVWexdDn9Fvue4xX+2/AeHCjld2Dew0ctE1P0YTQRzvsV+x2X1xzcDUgV8NeT8Is0KtICE5y9wHWbODIpwKdIO2cgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592050; c=relaxed/simple;
	bh=2JF6XLRHZRFoieBdddwc7jZI9AUF0rrlmTaUIM1zgeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ap5CCST/dL09O0z+0E3EJYvicK/DXwC4vRZdMDclgXWJ9mfKgZBMb+p+BLzDriMkd2qptNL5Nox15/1O89HO199BDf5vuItCA1G3vJAHC5jockm0vdmOTrkm2YBwyTySi8l23SYrJL4ppHCo7CMqqw+qCMx9pl/GBZGPywoBLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsfyaGGi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757592047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVX5ov/wR4sB0hiUdS2uKerj6PX/BzbKi/PaeD7eU6A=;
	b=BsfyaGGiOBw8Bb4sua00QsmzyR2Gt/F4sHo2sQbDh86Nz83Z0E9IoNyKwTRwzcm4eQcsOp
	bL5vL2IVlZ0BTHIMqApzVYDyd5M+luNCtJTzRN23u/y8Hfchq2v/cMDoF5Ey/3j97QiTig
	U4MLlSFYEHf2rhh1G5yrK3KXY7LCRd0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-Ucnu2JMoN1KmdxF4hRmOaA-1; Thu, 11 Sep 2025 08:00:46 -0400
X-MC-Unique: Ucnu2JMoN1KmdxF4hRmOaA-1
X-Mimecast-MFC-AGG-ID: Ucnu2JMoN1KmdxF4hRmOaA_1757592045
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3dbc72f8d32so298992f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757592045; x=1758196845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVX5ov/wR4sB0hiUdS2uKerj6PX/BzbKi/PaeD7eU6A=;
        b=IIqMpWIpz3CQpgwDxtNoIQbnRKUMK/RqyYWDSnB0DtKzcOSMoViAB76ng0WFJy4D7d
         bZ+E2JoK9rqDfe9ainCZ3qX9f9OCb1JzZDH1fGRDoyvq6geganD32VcktaM2Xyu7uwHX
         MwTatLkoamWhcyP+CdlqP480LUuSR7D9UcjLNNf+HftGJHjbgHZP+M2s58i2UQyq9uV/
         76csYsEByGK46vOo5r1j6CeUehzBVgnSK/LyjYy8nczA3sBJ2VFiu+PAZi+wtp19fBqA
         +9XfVjF+BieFoFUL65DKH1Dp/jf/gQnZSI13bGg9iswdAze4GNTjCpkycuXfdTiY5dxK
         CCAg==
X-Forwarded-Encrypted: i=1; AJvYcCU0vMFSpt/90S15D8XZfDqhI0RRXXuVjqXZjHTe7NBLSMwUl5CVEeO5oMKqMX/COT5XRIAHEpQrSg1+zT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAWivX2pRvKkGCt1FDfk1OjWO26PvZkcrWuNgZ2CyZFDk+KHwc
	+wudpWYB+NGBITyaEy4YGzu4CXL6Fi390mbqaHpPrehGOMk6o+5omckENDEYeV5wBm5e7hoN9IB
	8FqrXmldTcOcirw8UStqsfW0rV4jMc2xTE6cnIhuyVAMeVQ+JoL1ljSaJz0heGZj6hw==
X-Gm-Gg: ASbGncty8fQDciGEwO+hqPSgLI/NtmkyyDbzI3M3dlC1hr7x6TLCmlRXic+30AJr4Tl
	BS4rPYlPbMCLSpcTzRs/9v3BJdCcJ8ngqiOz64+e5UkWAiv5q+auXkdSsAS8yviMETBzve3xcp+
	KmJnpgbRMgpCZ2Z/Umo9MJItwUf0CjhGIWBVcZXwiQA4w0SIPjJxfgS7k7YKFVk4Xy8f5rldggb
	zQ+D1yf+ETykzbFC7Jf9P/3aHxtVmRxXSz0WSDSZZGv6jTzBrCNdcTGvF+aWaKu3RYlw6a2NPsg
	ElV1UUJCoN3FcVgAcvyyDi+kp4qlt4R+9D2OXLgpUEQfMgYvlBZKlUDBp0PL8nop6tzweqJTOGn
	vAus=
X-Received: by 2002:a05:6000:430a:b0:3e7:471c:1ddd with SMTP id ffacd0b85a97d-3e7471c223dmr11405048f8f.49.1757592045046;
        Thu, 11 Sep 2025 05:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLVVQC0eY4HoVHqOpKiv2pGBzG6+iBKCOe0cz5ZOeflvxyX3p0Ju+5/hKQlM/A0+PEmEILjA==
X-Received: by 2002:a05:6000:430a:b0:3e7:471c:1ddd with SMTP id ffacd0b85a97d-3e7471c223dmr11404998f8f.49.1757592044328;
        Thu, 11 Sep 2025 05:00:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607770c2sm2215708f8f.8.2025.09.11.05.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 05:00:43 -0700 (PDT)
Message-ID: <5af10ddf-26a4-4022-9bf3-ade739fe0f78@redhat.com>
Date: Thu, 11 Sep 2025 14:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/panic: Add a drm_panic/draw_test in debugfs
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250908090341.762049-1-jfalempe@redhat.com>
 <20250908090341.762049-4-jfalempe@redhat.com>
 <20250910-astute-vole-of-kindness-c6f6ce@houat>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250910-astute-vole-of-kindness-c6f6ce@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2025 12:49, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Sep 08, 2025 at 11:00:31AM +0200, Jocelyn Falempe wrote:
>> This adds a new drm_panic/draw_test file in debugfs.
>> This file allows to test the panic screen rendering at different
>> resolution and pixel format.
>> It's useful only for kernel developers that want to create or
>> customize a panic screen.
>>
>> If you want to check the result at 1024x768 using XRGB8888:
>>
>> cd /sys/kernel/debug/drm_panic/
>> exec 3<> draw_test
>> echo 1024x768:XR24 >&3
>> cat <&3 > ~/panic_screen.raw
>> exec 3<&-
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> I see what you meant in your previous version, and I misunderstood what
> you were saying, sorry.
> 
>> v2:
>>   * Use debugfs instead of sending the framebuffer through the kunit logs. (Thomas Zimmermann).
>>
>>   drivers/gpu/drm/Kconfig     |   2 +
>>   drivers/gpu/drm/drm_panic.c | 117 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 119 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index f7ea8e895c0c..0d3146070d9c 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -83,6 +83,8 @@ config DRM_PANIC_DEBUG
>>   	  Add dri/[device]/drm_panic_plane_x in the kernel debugfs, to force the
>>   	  panic handler to write the panic message to this plane scanout buffer.
>>   	  This is unsafe and should not be enabled on a production build.
>> +	  Also adds a drm_panic/draw_test file in debugfs, to easily test the
>> +	  panic screen rendering.
>>   	  If in doubt, say "N".
>>   
>>   config DRM_PANIC_SCREEN
>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>> index d89812ff1935..0c01d6067eab 100644
>> --- a/drivers/gpu/drm/drm_panic.c
>> +++ b/drivers/gpu/drm/drm_panic.c
>> @@ -873,6 +873,7 @@ static void drm_panic(struct kmsg_dumper *dumper, struct kmsg_dump_detail *detai
>>    */
>>   #ifdef CONFIG_DRM_PANIC_DEBUG
>>   #include <linux/debugfs.h>
>> +#include <linux/vmalloc.h>
>>   
>>   static ssize_t debugfs_trigger_write(struct file *file, const char __user *user_buf,
>>   				     size_t count, loff_t *ppos)
>> @@ -901,8 +902,122 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
>>   	debugfs_create_file(fname, 0200, plane->dev->debugfs_root,
>>   			    plane, &dbg_drm_panic_ops);
>>   }
>> +
>> +/*
>> + * Draw test interface
>> + * This can be used to check the panic screen at any resolution/pixel format.
>> + * The framebuffer memory is freed when the file is closed, so use this sh
>> + * script to write the parameters and read the result without closing the file.
>> + * cd /sys/kernel/debug/drm_panic/
>> + * exec 3<> draw_test
>> + * echo 1024x768:XR24 >&3
>> + * cat <&3 > ~/panic_screen.raw
>> + * exec 3<&-
>> + */
> 
> This should be documented properly, and I'm also kind of wondering how
> that would fit in the larger testing ecosystem.
> 
> Ie, how can someone that just starts contributing to Linux, or is
> setting up a CI platform, can have that test running.
> 
> kunit is great for that, kselftests to some extent too, but I'm not sure
> an ad-hoc interface is.

It's a bit harder to setup, but also allows to do some useful things.
I've written a small GUI application which displays the contents of the 
debugfs drm_panic/draw_test file in a window.
The displayed content is automatically refreshed whenever the window is 
resized, making it easy to inspect the DRM panic output at any screen 
resolution.
https://gitlab.com/kdj0c/panicviewer

> 
> Unless we create IGT tests for it too maybe?

Yes, I should also take a look at what IGT can do.

> 
> Maxime


-- 

Jocelyn


