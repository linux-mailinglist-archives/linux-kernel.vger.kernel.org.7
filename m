Return-Path: <linux-kernel+bounces-861758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4569DBF39B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0F188706C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B613333441;
	Mon, 20 Oct 2025 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Noyazmyp"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391A31280D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993798; cv=none; b=QhRsAXzvHIDATClSzV3h0fVMRGpK8SuBq48NaZpE6/MzlrXLI90hitRG273rAyevChWFq0Vn2wRGtOVZIaA+4CBS/2f90KxLeClsLSJPSZuI91o6JxPyc+FDs2KSZiAL7p+dnMy9AFEO8W3UojQcCXGTaHH8kNUUTJaKvXvKefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993798; c=relaxed/simple;
	bh=GYEPVtDsttvda142P5IMaxq4re3bE586j0GC1bxwJ54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DP7BrUWGMzr0fNzHsdC/BYv9pm2qL4T4Es4a1h28A+4FBHo1ASDoIaV6zq0NiHKm2G4Cd59jJF5Kj08EYWLl5xIhNtozAoq18pE6ybOkgjTb5hcRbtiUU3ZJ0dGbaTtiEqKpLMMHddRO3k5rs2aDfM6BJ9YW44Rtcl5cqUhL06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Noyazmyp; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-92aee734585so211299439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760993795; x=1761598595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ja+n9veh9qlHqb8hMHqgjmxsNKt1NGlPkWcYxqSmGs=;
        b=NoyazmypFGwt5owPDvu6W+gplISzSj7zyGXlFEG1/5Rzbx9DVHFx3C2X9RVvyumjyR
         msXyBRVqCPl5Px7kSnEPCoxmRQUEuSTTJpCX8mKGUQjfKg6Gs98Q0m/AiNcGC3Hu3+tF
         hrJ9n4+lFYHYwmcbyV+9tmt39JwkITKQCJlhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993795; x=1761598595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ja+n9veh9qlHqb8hMHqgjmxsNKt1NGlPkWcYxqSmGs=;
        b=m0pSxwtQdg/QzYoKdUA94d0hP5jbW4Id4aW0tArxek65KHKehs/TvJ0oczmfNBOjPd
         UuOAmV7BMOQtL7VQxTc6As38bO3Jkkk9L5VJnGHu7szUb+glwrMcKRVSqj/s+Z0RmDWT
         0XhavLTHLSdThvZyZp5pGh3gm8YSFOqF+CvVf2b0aUKVOUW5EVkZPZgiWE7PZTXMSCzv
         EFABCzEC1VBpdofEU9mTzHdA2Ar06oIYnN3xAbIKQyVon3uwkNXSj5eBtHHcP0AVX2+C
         fgvOdJggo9a1fx0s1HTv6/9ehlk8xgVCgr8ocLfGV/djsXFhFdI0gRygaecLBzDaS/8v
         nQeg==
X-Forwarded-Encrypted: i=1; AJvYcCXDOCV/wDHVFjP+8ao6M3HYtQqs4tUcp865m39bVLg6MRaj/IYrfW4VobLLvvlLjvA0aYduC7LIObWOdKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZi92b5jtGEZppDR2UO8UZFeBup2i4TnermSll/bu+X1RdqH+
	OTXvkDPBwJSXWcUeG69lNXsiGXa8/a959vVU/iyf4qxpBSGjnAOiUEC9DDyAnuro82639pB4kOG
	WhNSE
X-Gm-Gg: ASbGncsKH8cSPPZFTWhiVfvZi2Z4MpK85QVggMGGz4RBADziZUEbzJ92JRdRI8eS1lj
	N7Kz6pwrggmNbaYWjHUiAS/I6ILosTvCvWAKlrDQj76w4BUgl80S4GowYbKMPRw+fDd2YxK3QXQ
	Q01ynvb/wjzHf4xdDzcIpRB9KY5OHbjvu8ybwu7D9YEbmJdad4Dgz8xbhIOfzTn8WsUM7mbgvhQ
	/WA5oIDh/bfGehyOoqIKMt9kEH9wLtnLrX0i3duzS49kyaOMwytAKM9DKG/HCu6hAZ3bejaN+/1
	36aYSWtyVxKWmCo+/gT727xKgPxoQ7RH3d4leU1WLuAKljpvqcrN+MQlQlHe1XySblYY+ORdIRS
	LIrVzb8owG7F2kgDHcLEGgcZrh/uoNV1Ubx/bDwYqxHfURK1i7ep7n+U9U7AQnLVjJKK+YXIyI7
	JPBgDkDr8Oiudm
X-Google-Smtp-Source: AGHT+IEYQuMsRrQP0zzcYNlBWGppocUzz2r9I/kZPTACOG5ljM8owh9X4YfA9kncxZnuMAgjkIzHhg==
X-Received: by 2002:a92:c245:0:b0:429:4c65:e8f7 with SMTP id e9e14a558f8ab-430c52d775cmr191927495ab.24.1760993795511;
        Mon, 20 Oct 2025 13:56:35 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d070a461sm33957455ab.9.2025.10.20.13.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:56:35 -0700 (PDT)
Message-ID: <3f523293-8a8d-4136-b4bc-4ad0d4a50c59@linuxfoundation.org>
Date: Mon, 20 Oct 2025 14:56:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/solomon: Use kmalloc_array() instead of kmalloc()
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251019145927.167544-1-mehdi.benhadjkhelifa@gmail.com>
 <2541f99c-1081-4253-ae58-97654694cd78@linuxfoundation.org>
 <e4f0290b-5d15-472f-acee-e1e1b0629ec0@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <e4f0290b-5d15-472f-acee-e1e1b0629ec0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 15:38, Mehdi Ben Hadj Khelifa wrote:
> On 10/20/25 9:08 PM, Shuah Khan wrote:
>> On 10/19/25 08:58, Mehdi Ben Hadj Khelifa wrote:
>>> Replace kmalloc() with kmalloc_array() in several places to correctly
>>> handle array allocations and benefit from built-in overflow checking.
>>> This prevents potential integer overflows[1] when computing allocation
>>> sizes from width, height, pitch, or page values.
>>>
>>> [1]:https://docs.kernel.org/process/deprecated.html
>>
>> Mu understanding is that this document lists deprecates APIs so people
>> don't keep adding new ones.
>>
>> I didn't get the impression that we are supposed to go delete them from
>> the kernel and cause a churn.
>>
> the document[1] specifically quotes the following:"
> Dynamic size calculations (especially multiplication) should not be performed in memory allocator (or similar) function arguments due to the risk of them overflowing. This could lead to values wrapping around and a smaller allocation being made than the caller was expecting. Using those allocations could lead to linear overflows of heap memory and other misbehaviors. (One exception to this is literal values where the compiler can warn if they might overflow. However, the preferred way in these cases is to refactor the code as suggested below to avoid the open-coded arithmetic.)"
> Specifically mentionned the refactor of the code base in such cases which is why i'm doing the patches in the first place.Also i'm trying the best to send patches related to the issue where such issues of overflow are present or to be consistent with the same API used within the same subsystem.
> [1]:https://docs.kernel.org/process/deprecated.html> How are you testing these changes - do you have this hardware?
>>
>>>
> I have a raspberrypi zero 2 wh that i'm using in combination with the ssd1306 OLED panel via I2C to test it's rendering and it's working properly by using modetest and seeing no regressions or warnings in dmesg.
> 

Send v2 with all these details and why this change is needed
in the first place.

When and how does this potential problem trigger? Is this a
theoretical or does this happen in this code path and how?
Next time include all of these details people understand the
problem better.

thanks,
-- Shuah


