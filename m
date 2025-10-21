Return-Path: <linux-kernel+bounces-862329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4E9BF5028
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35883B578A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087A27FB34;
	Tue, 21 Oct 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJJKgl7Y"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941622579E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032578; cv=none; b=G2yGoDQv/MfnkUklTQf6i6957O1Irbgm/hvswK4oUOOjYuktj9QsZtJmAgQfcEKXr7F5dVnweEQn4FKuYYv6P+DP8CHpD0elVEyemdDVFJ59FVEDHUW6ITxBl/OCP7tboq6aJWxWYRTVncLbzC5WzaF1Dxq9dvSmzrxEkI6wxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032578; c=relaxed/simple;
	bh=Co0g2oq9Dvgm/vKLbYkp5UqWrktn3iu3zgG/qt6obY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MI7Re3SscLHoHocoAru8DXVy71WVX88Da0Za+qJ3gHwdVQOmyGFSeNW2BuQGE9jQVNB2Z2udp8/4wLVXDb9oVX6ZZsuqukFMAtBeUvTdXPda/LoIXWxn6tZFRdKHqIMWCQzJrluEh88rDLtVp3tsE9LVdylYHLFXJTDBnGztjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJJKgl7Y; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3c76f3703cso90757166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761032575; x=1761637375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GStPgF6qWg8eBpq7k/CjdOQ6h0CGmfUgYnZon0KO2vw=;
        b=aJJKgl7YRbJilB1sJpEVo2IfqWt99dV9M+gTUVx5ttp9B7t6d5PqoCgilBJN+YOwvv
         OugBs42jNeYaTgu3QFoh8IMJSmhhSuEuPYRxiTMKPaidtEaspCKwo+xgFTMOeHqWR4dV
         ig2eYHZCe5+5rDIjBMrpsy6Uu0ZY8wK8rK6NUXz0hHIS7QnxMljDP3cMDVj0oILivBvM
         L9J+lvh6U7KfuM/pZZYzHHOblD8sNhK23LH98GzRxbKvZk+8xEoknvsUIuHGsDK2yCEd
         s/WmQes7KshacsoqgZkCkXGRXe+14yeCXshnCskZRpmapLsdhAViEBeugi/pSK+eiHTz
         3Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032575; x=1761637375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GStPgF6qWg8eBpq7k/CjdOQ6h0CGmfUgYnZon0KO2vw=;
        b=xMCuNoBqhGh712qmjjq/F6wjsSQxpcwLuHBHwPBtCHWBCSrju35LUQuVApJgCGKbF/
         f/yq+D6Wbt/oQ5+k9ZvSRd93u+jO25WvsnMQUogBv6upXMOXal59SEIwH6o+S7UVqFGO
         T4NDoQSNVgtrtHwxT4y7gGpk9dg/OV2NpX/5CS52WZGCWMMaEfDR3Vra1pVJxp0LA/Dj
         LlB8SSb3U/KPOxZc4VOm3lCPpP/jDyEXjTWnFwJOon7h0ECE8JoyxREG1Ku6E/V6SuPL
         FVDepz/jFni6QdnFFSbWS0wJ1Xj92raNYYUWMb7c5oybufQ4S2NBfmE50S/U38pZSgmL
         4n7A==
X-Forwarded-Encrypted: i=1; AJvYcCUyF0BzSZ5xgJNUrIMqLmNyAbc+Nu9M0PVtw7kHZ/35YqvjdxkC/6GFFBQyjmqVpnFRSAc90O4C9jJ9lRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEIsz4V1+J/D6SrQIH8VI/2RCV7WvhkidHttrRcTBiv5A0b3J
	Anq0I/9Aqrcmswhfim7S6fY+a3etK0tmVNeaW4NaMiNE7njwXm6ZMkaO
X-Gm-Gg: ASbGncui6WuSUrbPl+vWD6JqrSKz8PK/BtYb2BSeFb6I9ienw2jBOI/0MGo+enGztsJ
	QbwYTxaLibjzYZwR9jA0PBqVc+mjpjWVn7rMR05vaLaS4tXJ5zEvUm+hYzk8jKF9i6yjBDcbJpq
	OWc6Gx5MqJd6ngmF3f0DOut/7kvT6wCeELB2wzpwPaag6ZiapVgbQgHnEJov+SOsWHaFba82l4Z
	VjFDowZMN5rzFs8rmu/a5Zc+tZHGL650mhPTBfUoVD9M3//+7p1m4TJ0R775XfcF/DWfoBkwwqw
	dXTa6GBdqF08XXEKF8ZTCkeJ9uSeUepZzigcwcRuBfYfllcqcFsGXxMkaGP6SdSlPeQJ07ReipZ
	/bisteosaa7TySPuVaOcMiseKeh3liluVSNB2MAMW88lGJ2zruKY4Yi7s0uuElNxNSXWjUleJoA
	CHUU6eV1Pj70Nhvyx+FH7RNKppGZ7t
X-Google-Smtp-Source: AGHT+IGTAHitbAGYUoiDBb3JjyGZ6zbzSc2aytK1cYPhymZfc5cQ/shi+4Gz6sE1cziBWlkHoCqTpg==
X-Received: by 2002:a17:907:6ea3:b0:b65:c8b8:144f with SMTP id a640c23a62f3a-b6c793063bbmr164905566b.6.1761032574440;
        Tue, 21 Oct 2025 00:42:54 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da25c9sm1018929566b.11.2025.10.21.00.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:42:54 -0700 (PDT)
Message-ID: <dfb3d547-9842-443b-80a2-94bf715bb46e@gmail.com>
Date: Tue, 21 Oct 2025 09:42:46 +0100
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
 <a37d83c7-dc2d-4e1d-a8d4-5628e0ac52a2@suse.de>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <a37d83c7-dc2d-4e1d-a8d4-5628e0ac52a2@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/25 7:57 AM, Thomas Zimmermann wrote:
> 
> 
> Am 21.10.25 um 08:51 schrieb Thomas Zimmermann:
>> Hi
>>
>> Am 20.10.25 um 13:57 schrieb Mehdi Ben Hadj Khelifa:
>>> Use drm_format_info_min_pitch() to calculate the framebuffer line pitch
>>> instead of directly multiplying width and height. This aligns with DRM
>>> helpers for determining per-line byte size and avoids manual assumptions
>>> about bytes per pixel.
>>>
>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>> ---
>>>   drivers/gpu/drm/tiny/repaper.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/ 
>>> repaper.c
>>> index 4824f863fdba..aeff49bc6ba7 100644
>>> --- a/drivers/gpu/drm/tiny/repaper.c
>>> +++ b/drivers/gpu/drm/tiny/repaper.c
>>> @@ -517,6 +517,8 @@ static int repaper_fb_dirty(struct 
>>> drm_framebuffer *fb, const struct iosys_map *
>>>       unsigned int dst_pitch = 0;
>>>       struct iosys_map dst;
>>>       struct drm_rect clip;
>>> +    const struct drm_format_info *info = fb->format;
>>
>> This is the wrong format. You're allocating the output buffer here, 
>> but you're using the input format. IIUC the output format is 
>> DRM_FORMAT_R1. The input is _XRGB8888.
>>
>> Best regards
>> Thomas
>>
>>> +    size_t pitch;
>>>       int idx, ret = 0;
>>>       u8 *buf = NULL;
>>>   @@ -534,7 +536,9 @@ static int repaper_fb_dirty(struct 
>>> drm_framebuffer *fb, const struct iosys_map *
>>>       DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>>>             epd->factored_stage_time);
>>>   -    buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>>> +    pitch = drm_format_info_min_pitch(info, 0, fb->width);
>>> +
>>> +    buf = kmalloc_array(fb->height, pitch, GFP_KERNEL);
> 
> And TBH I'm not sure if we should really convert this call. It's not an 
> array in the sense of that API.
> 
> Good candidates look like 'kmalloc(count * sizeof(<some type or 
> variable>))'
> 
I will leave kmalloc in v3. Do you want me to send deep testing 
information on this patch?
BR,
Mehdi>>>       if (!buf) {
>>>           ret = -ENOMEM;
>>>           goto out_exit;
>>
> 


