Return-Path: <linux-kernel+bounces-846012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D32BC6B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 00:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810CB3A8B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 22:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7792253A1;
	Wed,  8 Oct 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT+v8yS2"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1E1DFD9A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960822; cv=none; b=ln89NJMMHed/nUPYdsiT2Y56nnPN3rhccbr3Nj3gP9w1dbHS594fecS5nyY/zQFJORNOP/U5H4+wtVJCvNMyXZq7IAjDMDgzfhCjTvnp9K7NymdwFk8fZo0fH77KJk2QCmBOn4YgKMCI+kphmInKCQ+sYIn9CQzxtRZqme2Orpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960822; c=relaxed/simple;
	bh=XwTyoD8w+8xJaGt47DUvTvBngOMWXA8UInRrhnDiQAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jS0Ak2LjGt1CBcAdYqTB/jIEI4WpDfIuKiTEgJlC/lzaZQnYv2k3c06bKjKIyAlbJg+JDtJj58miPZ5q2fW0CAa8Te2Xlmo6+Z9mSw7N82NrXMkxboToqJIvjdGgBosS4OT29+NtW7zir6lutwtY8wxORYfihZ/L0sZto7s+M9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT+v8yS2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-421b93ee372so195023f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759960819; x=1760565619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GU1Xl1K6+Pk8hlhPh8Orqtx3Ns4/PlbjU1PHpUk8BI=;
        b=XT+v8yS2eeJzDdnKuGt0sPU5U1e6V+1uUY/l8fgbHqKS/vddOW3RGHDKoGa+M+vu9e
         RGd9dJbk0vVpA1q91/ABBm5oS40BFXFF3s412iI3AcUdrYfTYMXRS0xN4pwOPZ9j8IEQ
         0x4EMclCQxHY94fhpgpI3u5QcWtfQxrC7h7ZmlKN3AOrTObN82xRMURmCYejHlZ5DEvC
         WgpQnFrcA6x+xIeGjtANi3KkOnXU9thHbvDcSGx8QW/R8kXgB8r+8+eSMX1FYKyurVMe
         PNc1v8zwSX4Vwsh7gyVaAWXUl+uzYvD2wi4o+4gh0Rzu3p/CBnI0wd40//b1nYl2Uc8u
         FMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759960819; x=1760565619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GU1Xl1K6+Pk8hlhPh8Orqtx3Ns4/PlbjU1PHpUk8BI=;
        b=q6g4Kd/CjTvfMe5aqfcApnaRdZwUuL3a3HGOpCh0j8ZHUznf0w94IKFzLrJJ+U+vl+
         AAzvm+dNGBrSbczBzJtGb3+DwTLIBSg0rieHN5bxFEJciSvEnqEDJA5MpdxJvsklOSiA
         sIMTQebRj7X63lDg6j34ml4ky0xoRnAMWuL1y/9vV7soYWdauuMSzNZEmjUqpoH7mlhw
         UZXJPmqw6daLIJmOg6CsywfBiDDlBv3OvLyEVb2bcoOzZdoILxw06mg2VJ9Ru0YzeByj
         vyo6C2bAa2FYg52pC8lsurZTik1XW3TjkOd/Pi/skw+bTRCXDmVw6fui+y0a3tCsQ8TX
         ZtJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfFJfSdYWHa+Vq++KwtMe5h5RyYhAxW3X2lQnAFJ1PTKMQqWq4EqihfvC6O8O+30TdHgnys5lcfmYJWpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhDzM2y4lXg85Kk5q1S5JxBtkJjjeKDznGByHV+o6gBbmjztb
	o/1bk3dRnMRAuaVe/tMh1wHQhzvFY1TqVIq7HcMuzs4gyC3DbnBubDkQ
X-Gm-Gg: ASbGncs87fzCmIIppjf/LdPxmjlG3jf5AOoK5xOSYd39FsfAjAdfZXGEtuJYoZXvlUB
	t8ya3kkjBmPmK/cT7gtoEAq47WUYSuTZISGzadFY4xrwjsIefZLG8EbWxxs9aMhfguKJzt6Wg6H
	lfS4/OXAaF2g5IWbuQzWdBMKbIRhBx9jI6xwIPyw7UCDTBfF1TfBXMLH+jJSTr4Zleri/ZuFKU6
	OC1Jvuwwl/ZJkftXHcQhQfYIbbhqAf1nqtJHWxFHFO3RyACfgnfBXoyZW0ofCAxxBN/wdc7vglj
	+mDdRq0pQDUpQh4hr5xn2T16+Y8UH65e5lnJ4fqPZqlr0UjvNnWfjJeLVH8nxK9VbEhQZt6SPzV
	TYyDNJKoSWY7UMlJGH1K5zO7rX9iSNhBiX46a8PXwN4u2xt7Bq0VqJto=
X-Google-Smtp-Source: AGHT+IGM/GqujYDl21bAoN2Inkzb/Y4dx34wMexePnZgIwLqQp6UnyIsYIhpOwJWA7nmUp+t5SFi0g==
X-Received: by 2002:a05:6000:2388:b0:425:8255:fedf with SMTP id ffacd0b85a97d-4266726c31fmr3138290f8f.23.1759960818430;
        Wed, 08 Oct 2025 15:00:18 -0700 (PDT)
Received: from [192.168.1.12] ([41.37.1.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9762sm32013820f8f.38.2025.10.08.15.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 15:00:18 -0700 (PDT)
Message-ID: <ca29530d-f890-47b5-b254-20c4ef301f7d@gmail.com>
Date: Thu, 9 Oct 2025 01:00:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/amd/display: Initialize return value in
 dm_cache_state()
To: Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Yilin Chen <Yilin.Chen@amd.com>,
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251007224549.87548-1-eslam.medhat1993@gmail.com>
 <6f24d0cb-ce14-4e56-990b-00ad579bc282@amd.com>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <6f24d0cb-ce14-4e56-990b-00ad579bc282@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/8/25 05:15, Mario Limonciello wrote:
>
>
> On 10/7/2025 5:45 PM, Eslam Khafagy wrote:
>> Initialize the return variable "r" to 0 in dm_cache_state() to fix
>> a potential use of uninitialized variable warning.
>>
>> The return value for this function might not be a PTR_ERR, in casse if
>> condition fails. In that case we ensure predictable reutrn.
>
> Can you walk me through your thought process?  I looked at all 
> possible returns for drm_atomic_helper_suspend() and they all return 
> ERR_PTR() or a state.
>
> So I don't see how the IS_ERR() clause could have a problem.
Hello ,

Thank you for the response. Initially i was working on warnings via 
coverity scan.
Initially my thinking was just by following the sequence of 
dm_cache_state you can see that there was a potential issue if
drm_atomic_helper_suspend returned a non valid pointer that is not PTR_ERR.

But having a second look after your response, indeed it shouldn't be the 
case. so please feel free to drop this patch.

>>
>> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 8e1622bf7a42..6b4f3eb9ce48 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -3115,7 +3115,7 @@ static void hpd_rx_irq_work_suspend(struct 
>> amdgpu_display_manager *dm)
>>     static int dm_cache_state(struct amdgpu_device *adev)
>>   {
>> -    int r;
>> +    int r = 0;
>>         adev->dm.cached_state = 
>> drm_atomic_helper_suspend(adev_to_drm(adev));
>>       if (IS_ERR(adev->dm.cached_state)) {
>

