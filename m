Return-Path: <linux-kernel+bounces-861720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DF1BF378A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADDAB4EDBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC322DCF5D;
	Mon, 20 Oct 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnCiNIgm"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058BC1A76BC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992749; cv=none; b=r1ekedQG1QqkOVy0wa3UHz1pt92voeyGqueCtk37T4AZZMdPYTjPpEH7qLLCvc/0ZbeaFFEJSDFpDvWoQTxBiYbs6Kak2uhi5HwO1lPnn8Vq4i+YAGfntuBqw1n4EaDDOsqc7MaPtboR6eKvGyC1qW28qT/d30wT4c/S32NDTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992749; c=relaxed/simple;
	bh=qBfD4dD8XFhkLWwXK5SqJnOINmi5CJvE/sMdh19cgbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qs+CBbXfBv4+jvYXes7xdVf51vSQCYGcisj66pmDjhGR9BCo+bfJiqbZHulBmvVZKoE/bO/6cyQ2R4+X4N1lq4w1FEG8Oyh3e6PoBQOizBdoWf8PKIearKbP2pMA19Ul1QBNQ2PJQ3rGTqxP5CPM7o/7xM+/6qf92QiJ51DmPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnCiNIgm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3c76f3703cso83391966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760992744; x=1761597544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I13zc6oy6n5wEThdTlFRQKlOHJB6pi47H7uQVP12yGs=;
        b=jnCiNIgm/k43HFxUkgACMlum37EIWxmhM6bHTM1uAiC230ryfVkz1f1ehtnETzGhIf
         5T1qiolRPcKIkF3Cg0H0pn7LfQABOi0Yn7pCg/JgFQbjC71IihLa0JYWA68aGsCvmLwh
         TSA20hG64DA5OiZunj5gI39sk77j0Z7+KvMkTxAz53Xet7xD3GRt+YL9EEkBrE4FNZ3e
         HPLqfQ0OUf21wXYLw3jbAiOo7n41vkR+aKKDZX+v7drFPNRIthWZLWHq82Q2jCFmLtnJ
         oR1kNilFqHgdiQockePpEyj1ozSANGqJchA2dRhrQ0OvFx2QWOH6zWUPF52+S6x3yeDU
         tw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760992744; x=1761597544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I13zc6oy6n5wEThdTlFRQKlOHJB6pi47H7uQVP12yGs=;
        b=V6T80hl1r53InKiCr4SRxEMT7+pDvZgRNZV/VJD51gcN2/pFPiMpBOWpvxBtnFcDvn
         RRJUnavgiQ5vmS4s8wx3WHO+mmsU80NCbIBcOaIdEEhZmFnBDAi83jgJRp8LHaMThagx
         oJP+IvgOU4Y7wIhmTc9y0+yjdX6vc+s5lK/lrFk+5MmH/SVZCz4FzeEksU6EM1rBguU3
         hgrirCrH3SVN6K7SxzQglAEIXUVwEnvSNyLKNvljJfroXtRowyltV+kf9IAuIcwoRiGU
         2qrm3eQRhLGoSTCxTM54Ya2QvrU7KGg4TAVlblYIxNIynFVHM3WnuVACtLYtWn0WoEa9
         EOSg==
X-Forwarded-Encrypted: i=1; AJvYcCWiK+1rQ4FLXIxfJDDE68uWS7AUjX42GLv9xkboQ1yow3AGGZw4oWRy4QM+M5zJzgolAOb+HYG8zKMBZQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlB7ydo1L7NUZPq4xq07MHKnFO+ge7NHJEGVXLPZJQDN5yXOt
	Kz/VdVR8Z9uCESgg9jksQCubbLHdLoXCwDtbNQx8mJDQZJ72iZOM50t6
X-Gm-Gg: ASbGnctE8jZjo0N0c0EZJQrTatUFyV/zK+2YMbgnrLQzAhtIEDtb10B2FiKcnXkM3a3
	93vXnCpJd1pD7L7JzB7/JESlR0MBSNZC86MpXEom33Z8C0gNyIi1ar/jI5TmsRxv3wBtQowMOHM
	vheiHJDBSqzcumMK0I28lTNRJ7/Lelj529/h5JbEF6iJBnn8B8vzA6EkeUcV2pbGmFdNuq8HqVg
	MMz1DqNo0LQ7xSEAPkfvzgzVAn7fH27DMhJUhj35FYy0wieUPEgqfO0liVNySrXvCDPfwPpelEP
	1620C+3oYRKjWyuSXX/Ed0M5jmXXGrNj2enPBaDkM3DO7SHV0HlM9QkL93cB9VLUA0XbcW6WUZG
	9kCe9a6UI52ZqBaNVKmsNSeZv71E5UvyOsPPNhFi4/pFSRy+5R7eis/wCj4G9HGGxxI8HJT86LO
	RADQqiQ5ffCSY9mi5RbYSNOIRwnDNh
X-Google-Smtp-Source: AGHT+IHzlmKFJ8QvxM6XXCi3yDGc0o5ave5OzIak2mYRhAtf9x4ZklR2v8SH+Ts3J9IOPDUqUfvRMA==
X-Received: by 2002:a17:907:9805:b0:b29:8743:81ef with SMTP id a640c23a62f3a-b6c744b500bmr72625166b.0.1760992744003;
        Mon, 20 Oct 2025 13:39:04 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb035d5fsm891116266b.44.2025.10.20.13.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:39:03 -0700 (PDT)
Message-ID: <e4f0290b-5d15-472f-acee-e1e1b0629ec0@gmail.com>
Date: Mon, 20 Oct 2025 22:38:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/solomon: Use kmalloc_array() instead of kmalloc()
To: Shuah Khan <skhan@linuxfoundation.org>, javierm@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251019145927.167544-1-mehdi.benhadjkhelifa@gmail.com>
 <2541f99c-1081-4253-ae58-97654694cd78@linuxfoundation.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <2541f99c-1081-4253-ae58-97654694cd78@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/25 9:08 PM, Shuah Khan wrote:
> On 10/19/25 08:58, Mehdi Ben Hadj Khelifa wrote:
>> Replace kmalloc() with kmalloc_array() in several places to correctly
>> handle array allocations and benefit from built-in overflow checking.
>> This prevents potential integer overflows[1] when computing allocation
>> sizes from width, height, pitch, or page values.
>>
>> [1]:https://docs.kernel.org/process/deprecated.html
> 
> Mu understanding is that this document lists deprecates APIs so people
> don't keep adding new ones.
> 
> I didn't get the impression that we are supposed to go delete them from
> the kernel and cause a churn.
> 
the document[1] specifically quotes the following:"
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
[1]:https://docs.kernel.org/process/deprecated.html> How are you testing 
these changes - do you have this hardware?
> 
>>
I have a raspberrypi zero 2 wh that i'm using in combination with the 
ssd1306 OLED panel via I2C to test it's rendering and it's working 
properly by using modetest and seeing no regressions or warnings in dmesg.

Best Regards,
Mehdi Ben Hadj Khelifa

>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>>   drivers/gpu/drm/solomon/ssd130x.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
> 
> thanks,
> -- Shuah


