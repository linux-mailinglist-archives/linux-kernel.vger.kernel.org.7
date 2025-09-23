Return-Path: <linux-kernel+bounces-828593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078DAB94F45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACA1484450
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771DD31A042;
	Tue, 23 Sep 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpVfZOZ3"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263DF1DE2A0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615608; cv=none; b=AxIntgJ3UojxidDNiBOQ85TJknJdFxAgPfBbddnvowySwVkygVQjQwp1p5NrnwiCYNGVA2gHrN7LJZMo0sy6++uA29QS/Q2EHk642hFcXHJkQ/vzDnVG+3qy0w7kK9lXCr6H1VQi8073ARYgFwh8+EhLFfDMVvdTskR6rjYJWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615608; c=relaxed/simple;
	bh=lvdaf1jdpAn/0b3aS8IdKfsdb5q+QYRXB5ufrgSNwJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QlEUypaamhptnPACOIG19hQTGUf+baXrqbzE/vo3XlHmNVPkeSQ++7WAw+0bwzgc0KPKOdS3wILHSsANMW/LeNMT06Il3Bm0gUk1IpMrGP5vaamz1xMlrKBSOjbDd3vHWnqXdb5IQO7jgqdAyv9nzussJv1ydMOSoqWb0gCp/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpVfZOZ3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3fffd2bbcbdso104537f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758615605; x=1759220405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IzyzWewMNK9Zl9E9xETHmxZ1NeS51VeZso1zp+2bU2I=;
        b=BpVfZOZ3erXJtAtCIwf5mHqB9p2j0a43eKI0hcm8QJ4tN+PqPCWrEF2HsSsRkma6La
         eMHZag8E7KNdMrOLKM0RKgLMwNz6f4jjyzk9F2h20BOkwUt5qBCtQcsaxl171Dcv+65M
         ++qgNrXZrjGn+T7lN045BJ/j40arBT0B/OkoGcrwBR2PKk4/6Y+7bzhdyS2aFRRgqa9R
         kURxUlu9Ht+tVsULOoohBudYYfVD6rvwkvpHlQtqrZ8sELNJJ/wFh6gKrmcHCvzAU3iU
         Gnj91jp8ycEoPDoXx3B1UNQz4jfadaGif2l7eap7vMjQaiObmbow79e1AxN/9FtMjUA6
         QtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615605; x=1759220405;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzyzWewMNK9Zl9E9xETHmxZ1NeS51VeZso1zp+2bU2I=;
        b=ShOQRdDGWmG7JTsHFAPKUo+G7Xalw0njqRFTmhQheF6EOB22CrVpbWoXJJXFGM3ZVl
         kRPUo2cUbjD8d2ZRCZLpuM6ksZ0j8D5kos5KBwf7GQZxOHv8AFVFBXucicOKcH5emM6Q
         +bkj+jZWM29gJLA749V/xEt1muEEkjWlZlN+9hjJMPqb33uzB+eJv8fY3AbEWRXSEs9d
         Rwu6T+po4b+sGwnpIb1/cMeMRbqqMZtrg27kpwHCsJlxtOsV00d6RZY2h7XPLXQtOZjM
         7C6ETGiyBgqcue7ObKvo5AQJKfdrM2o96jusUkucSqFNFKJVQnZ5iN2MTRI98BuBumpj
         OsIw==
X-Forwarded-Encrypted: i=1; AJvYcCXWxMhmrfNF0JiunU4DqlZraJDe8w1jYfNI/dpPchH5/n6XTmVb3tWn6hHbdi+5Gnk5nGvP54FKpuh7jh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZexmhTzYvLi6veCnTsf9P8Ay3M0nZraWOqni5QzJzSBxw/13
	yZE2GKIgGfnyx4j7FKN0fUVMx2lU6uPd5wZtD1uZF9herZmxwqDvX/PB
X-Gm-Gg: ASbGncv/nbwJtkB4kyFYrKsoxlxrwqCMJd//q9Gy2BrzmRgF8W0SmLSK2pdwBRMpnFV
	R8KG+VWkTcxL3TnK7WAuIKRf/n8vy99NSzFWWEyWTBbo36KJ5Bxj4ep3GjG4v8fREUP4+X4wR6g
	oL9yx89YqAyMz9QvtKxOB2ps03NFjfr0Bxi8qLzz4w3v2zEX66gbzN7mvUhLP9RYNQJQ0HbIk+p
	QmPJdzcKpAGtPfmVu1ImRIcUA0RhnhIecDECZ+Z9NBzPr44ZHekVRl08ZurtBb0ibEmDbd2PyVk
	lPyd+5gsc5wg6ZFXVulGrPX2rfhne+32DlqU8Jy/ffe5p03vCchiBwU6zpgX3UqBR4pUMpyqxRs
	4IfxU4g19yBtfrCn5jUOpl2such2F4Txmd5Z1h+fsLowrDA==
X-Google-Smtp-Source: AGHT+IEMgeYQXIZ6KZjIiu5Q+SFOyifqT76gOV1N5xNcfsbVxIXA4Ao4Gbib8xuNk1pacZpZMn/dMw==
X-Received: by 2002:a05:6000:268a:b0:3ea:75d0:cf0a with SMTP id ffacd0b85a97d-405ce97fe14mr543601f8f.11.1758615605145;
        Tue, 23 Sep 2025 01:20:05 -0700 (PDT)
Received: from [192.168.100.110] ([102.170.50.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm23321598f8f.3.2025.09.23.01.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:20:04 -0700 (PDT)
Message-ID: <989ace7c-92a3-438e-a0a6-3cbeb46adba6@gmail.com>
Date: Tue, 23 Sep 2025 09:20:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gud: Use kmalloc_array() instead of kmalloc()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, mingo@kernel.org, tglx@linutronix.de, jfalempe@redhat.com,
 Shuah Khan <skhan@linuxfoundation.org>, david.hunter.linux@gmail.com,
 rubenru09@aol.com
References: <20250922174416.226203-1-mehdi.benhadjkhelifa@gmail.com>
 <063fbed8-915e-47e5-99fd-ffae22cfb6fa@suse.de>
 <fda2b300-dd91-4357-8cd0-a82347907164@suse.de>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <fda2b300-dd91-4357-8cd0-a82347907164@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/25 8:06 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 23.09.25 um 08:34 schrieb Thomas Zimmermann:
>> cc Ruben
>>
>> Am 22.09.25 um 19:43 schrieb Mehdi Ben Hadj Khelifa:
>>> Replace kmalloc with kmalloc array in drm/gud/gud_pipe.c since the
>>> calculation inside kmalloc is dynamic "width * height" and added
>>> u_char as the size of each element.
>>>
>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>> ---
>>>   drivers/gpu/drm/gud/gud_pipe.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/ 
>>> gud_pipe.c
>>> index 8d548d08f127..eeea0cb4c7aa 100644
>>> --- a/drivers/gpu/drm/gud/gud_pipe.c
>>> +++ b/drivers/gpu/drm/gud/gud_pipe.c
>>> @@ -70,7 +70,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const 
>>> struct drm_format_info *format
>>>       height = drm_rect_height(rect);
>>>       len = drm_format_info_min_pitch(format, 0, width) * height;
>>>   -    buf = kmalloc(width * height, GFP_KERNEL);
>>> +    buf = kmalloc_array(width * height, sizeof(u_char), GFP_KERNEL);
> 
> u_char is more or less guaranteed to be 8 bit. So what's the point?

i thought it would be more "clean" to have a data type that is of 1 byte 
size to use as a reference for the size of each element here.


> There's a potential overflow in width * height. If anything, you want to 
> call kmalloc_array(height, width).

This was more apparent to me after i have sent the patch and was waiting
for a reply first. Since my initial though was that width or height 
alone couldn't be treated as a reference to "n of elements" or "size of 
each element" but your suggestion is more logical since leaving the 
calculation width * height in the kmalloc_array would defeat the purpose 
of switching from kmalloc to kmalloc_array since dynamic calculation is 
still present and overflow is still possible.

I will send a v2 patch shortly changing to your suggestion.

> Best regards
> Thomas
> 

Best Regards,
Mehdi Ben Hadj Khelifa

