Return-Path: <linux-kernel+bounces-862328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A46BF501F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EF73AAF63
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBF528000F;
	Tue, 21 Oct 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl8npwNa"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0722579E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032521; cv=none; b=odXRvL2rjGMGvN8urmM4XbUgEBKggwf8qhR0ganxs6aNU3O9XH3AmumRyxJE/txsSEgdNpcy7RHvq85vI2fckNhjmXixUrfLp1KJD4FUxMlv+LP/J9fT4eN7z51jC+orQbyHkHxXOj573hzCNUXdRG1vB9hnhUDdKN5fATBiDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032521; c=relaxed/simple;
	bh=/KXuhprsVUz19Yhga1t3t/oxVuly9wIxHjlRZ69Jq9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4rkTFvudj9eyjk4psNcxtMvjYrkgdVc9L07HmGpm7dpBnXVcngpn+w/Z5PyRlwz5fWTbWyurTaDtLnnCEVMC7CeAMn9DNSTtfOByuqm+0znreM/SK4Fiht6PkuN9rs6PWEFfXzl9h7q18+2BaUU2xc/nJA3h9pBSEubIaIKzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl8npwNa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3c76f3703cso90742066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761032518; x=1761637318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qq2A1Kd0gSkqieCWoXvyag5Ixf7jlTaGJ4OOCGbMDnM=;
        b=cl8npwNa4P61sPyhgUrULEtYURWt3fwKmIy/YEgXwXAxhTc1UDawQMrjTezivgtCsH
         Fpj0goVdnAPChaaTJcY49wiReRPTRCsghCzPcu06VTiwc7bxtz/9cECRRsLKSjYBOJv4
         PqbGgdD+a4kDQUD9VcYoxai0Y84/to7gbMSieaSsZK4u/QGRrqwV7eKO9PreJgFm8B6O
         1VBtE7SgPDkhWZIKDqDsIgheMaxdHiwdUfSRSa5EiGJ3r4OnU/GmU9Kcv6xbb8AU3/X+
         ZLzoOXbG/cl/fo65OloCQZuqhCTliRtICJotIXZiu6H9ZyN77vniNkXuZTjc2FGlEq0C
         jhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032518; x=1761637318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qq2A1Kd0gSkqieCWoXvyag5Ixf7jlTaGJ4OOCGbMDnM=;
        b=JsgldEZsYFWggzgsL9guj+/K5Ct2AbfGyHdOlCiw0Q+Mcu9eUw4oCWXETrMSt0jHYj
         /AcjruxGRjEA01JPARclRKPci8Le7jeZ53UNuXSvAksKEC/RsQN4x8vESXVoLfoWRa4O
         ZQEVwM1naV8Ky8ueKg54Wv8ODbDVGD4uUYOdGhny8ggvK6qbkhwx4uc6VfNrEcKVYGGs
         /z6BtBCoM1PT63ofqKiqZZHMA+1CoV0QDlBdYmk1B+rLEorBUrdsy3EUb3qGpmEMZObi
         nNZ4c5T1lqi8cbJ9BkcVxSKKkYMcLkLnPiFZoVIRQAaAekEk+eu3+66WwmowdB9lqdhg
         Fv8g==
X-Forwarded-Encrypted: i=1; AJvYcCXvkc7/lotCeJqyEelafI5x8h1SSha/w/5TlZRlbfR3MZywzZ35LVDUFMeWApigo4BDCZhtw9239aabJM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfUlUT0AZcvO1z5eb0EXfsyp1qghZN8yNkHdxuYaJx7FNKC/V
	L+QtYvSPqJhdCtm0wL9Ae6hZc6a4RdoyUuDONVjq062fvPAVYbfRoe4K
X-Gm-Gg: ASbGncu3AJ2rLZqlOnjPtNkxjImia1Hc5oJxW75xT95AlaKD6cvhPWQtN1ONUTFGqMH
	2uo3Bu2AeBmK7/i+Jx7tWnwaIf1aUsFUUfQVqaT7qelUGoCcMj18AF1a0/ctaeK43LMO46EFJhu
	naTMlbkEVxus1bPudZpn91LSA4u+OfuGCYc0aZX6r6KO2ZobG1qGLwIHrwfHEk/eGmf+9zS0Jgf
	UituSFlvsXc8FFPtfy/PExm6a2CyE3F1Mxlx6eYi6BN2LbIdWYL0wVIbjPLk18ye5srhZb2G7kc
	Z6uQK0F51wl869y7eOfF0xlNQbbBxBcuF4/3IYhjllt7dZR9KzYf+trzn/WLSELUitFYE8EfbEz
	KOX3z1p1hmy7yGFil8wXVF6QbTlItWtGEexGYZQBpcQENyrkBZ58Ox4dHQKYBlymuI+2fYv3dGy
	MXynDq5YFZ28Qx766wP/UAs/aSYJwc
X-Google-Smtp-Source: AGHT+IGodTzNkYb0f/6+s9/q8PjxsWVWjCrsIvbWBLyQaGYptSG386KqvkxQNtg9R8tF9hr8VXvYZA==
X-Received: by 2002:a17:907:3cd5:b0:b3b:44a8:c64b with SMTP id a640c23a62f3a-b6c77583751mr151353866b.1.1761032517726;
        Tue, 21 Oct 2025 00:41:57 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb52621csm1007794266b.59.2025.10.21.00.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:41:57 -0700 (PDT)
Message-ID: <6a917f07-18dd-4f8f-bfc5-b85d9051339d@gmail.com>
Date: Tue, 21 Oct 2025 09:41:49 +0100
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
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <1de3112b-6349-46d8-b90b-69d0849c7659@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/25 7:51 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 20.10.25 um 13:57 schrieb Mehdi Ben Hadj Khelifa:
>> Use drm_format_info_min_pitch() to calculate the framebuffer line pitch
>> instead of directly multiplying width and height. This aligns with DRM
>> helpers for determining per-line byte size and avoids manual assumptions
>> about bytes per pixel.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>>   drivers/gpu/drm/tiny/repaper.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/ 
>> repaper.c
>> index 4824f863fdba..aeff49bc6ba7 100644
>> --- a/drivers/gpu/drm/tiny/repaper.c
>> +++ b/drivers/gpu/drm/tiny/repaper.c
>> @@ -517,6 +517,8 @@ static int repaper_fb_dirty(struct drm_framebuffer 
>> *fb, const struct iosys_map *
>>       unsigned int dst_pitch = 0;
>>       struct iosys_map dst;
>>       struct drm_rect clip;
>> +    const struct drm_format_info *info = fb->format;
> 
> This is the wrong format. You're allocating the output buffer here, but 
> you're using the input format. IIUC the output format is DRM_FORMAT_R1. 
> The input is _XRGB8888.
> 
Ah. Thanks for clarification.I thought since it had the same output 
format. I will send a v3 shortly.> Best regards
> Thomas
> 
>> +    size_t pitch;
>>       int idx, ret = 0;
>>       u8 *buf = NULL;
>> @@ -534,7 +536,9 @@ static int repaper_fb_dirty(struct drm_framebuffer 
>> *fb, const struct iosys_map *
>>       DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>>             epd->factored_stage_time);
>> -    buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>> +    pitch = drm_format_info_min_pitch(info, 0, fb->width);
>> +
>> +    buf = kmalloc_array(fb->height, pitch, GFP_KERNEL);
>>       if (!buf) {
>>           ret = -ENOMEM;
>>           goto out_exit;
> 


