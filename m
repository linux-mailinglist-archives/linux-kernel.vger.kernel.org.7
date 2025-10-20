Return-Path: <linux-kernel+bounces-861774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B5BF3A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197DC1884FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469842DAFC0;
	Mon, 20 Oct 2025 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erk4cPXU"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3D2D948F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994406; cv=none; b=ps5JHQgPTA2IzGs2dafXovzMAnbymOMzv7DWzMh5wAdcwv1MFiRilZaKgIC0qWj5aUrsNFKvUlCgaq6VCB7Bb4fZ4Mo4d02xRoM/oXjUPWOTrbAY1BO2YVvQJTC6r6nbiihDL297S6SIJ3g1S4b0iJOXtLGP1hzhYnDVLbJB+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994406; c=relaxed/simple;
	bh=jKHNAcHa8OjYTcahk/Cvw5CM9egvf6escUcxMCMyzmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5s+iNeruW45gwG0AKL/OjgoOzduhSmHf7kwMglZH+pJZ+thFtadhqO8uaUXV1EHytISKvlJT9KpoH4gUA1KzReQ6gmCVI7PNLxv+fbyeA98RJc6CI1aEQgqugjkQiSuowYTD6+2+yMrETD8WZs2BIcOI/426C85rfToDDuVnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erk4cPXU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3c82276592so94463466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760994403; x=1761599203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhY4ES2p36Sez9d7ccqmI9W2N8u8/97h46vN/q1eK6M=;
        b=erk4cPXUb5UUrHmkT1K0zQh/p/9q55oOSbV4F3Rf8zkld/DEBYADCGlPLI1kaArZ+c
         RmGmTkze04jNgT4gIrfONw+CVvj0mGnxznWYHuJWCG2DfDiYnN3rqGtzRUIN7df6X1Mo
         i1xdOQbr+RcDiVq/W6pBQyKjx3mJKklS6xeef+vH0gMnjMrcJjfAUBgS/m1mQMuNcMWd
         m5E0428JllcSJYZxFjydwNtV+lr0maou/Kp94bikxvGCoIYQaXPx1VPr9QSlqbWxcVx6
         ScqqM3qTUuPrjR5zVzZK0cB0E5jGwwR6AzrSrRHnc3vq9pW0x7WEqLPNtbEvJOhBV1k/
         kpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994403; x=1761599203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhY4ES2p36Sez9d7ccqmI9W2N8u8/97h46vN/q1eK6M=;
        b=wREbVOwDtI0xR0sYi7/j9fkI67uo/u73Fz0PjsL+z8iq8yuZlTgzxXhmHrYuqz3/uH
         ZcQteepvoHsyeo+lfFg1PH3n56LPa8gbfwMnblO2wCN1tG6bjQJ0eazkzbt1SQR0QgJi
         UGMqA+wKBc9e7o0tompgwgb+540XWlO7KNN9onitrLEqoP6WpA6/pSck3bbrgagWUO5b
         PfQOs12XY+KpIT3wRC1fm90Dp0gzFzjP/otiPr/L7i8NAwUEKJN5mRG9MXY8y+j8x1im
         6k0rzStruyK9yY2b7aOGnMQHUYad59q/MR7Rs51LflFVW1W9syWweVc9zinKOIyIbW/a
         uoQg==
X-Forwarded-Encrypted: i=1; AJvYcCXQEudqbmEZj2W10hGph4Z5myKNBDc5aPQPrBLzF5ExzO2apkmH0nkwQUro/Msh8WZ1of2S4wR5Dt+XPdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdtw91FkEQqtS41o2GxTQsg5eLjlSxo3/KS+VEiZv/JEBMrRuN
	HeSGbGRztLv8HpqjYJZLBN/U9Tx9eUjn2rm2lER8WnSN5elsgePOc2Aq
X-Gm-Gg: ASbGncsGv8ilAztLQUnpUqdPEBGxzjgAk6yuXWmPJKiRdAvyy6iuwKN7P98DrAXFsX6
	wv3cXXOCLr319NxjGHPcoU930E5Z1cztQ6v6T6Ph78YBJPEigHa/Vr8BBCZcZoP3lKtafH2/JcM
	bvzuDXUBxYo/VUVtxahTQUD1T3E72BhVIR92igeyhLgHNGWclInglvfkyc4qAUbKjAR5Daf8244
	A7tOG6Yo5bLrbArerJQAhZLyn05a/fJWsJPCsdxBJqXZIPCulGjQgupV+hIZBHJKA5yfW3rzKj+
	miMsT75qtQQYYZQRH8CL0I2mWb6AZY+X5jztD+ZE8vQmDWTGyeX5rW61jDHQGUx9EVXLHkXDB97
	yBDj5C7v5nRU65W8BQ5qgg7UDPbbfuNmLqi2plzslArvVIisJwaf30oxIv/ofRH6TwAAjBUbSxZ
	oeU2hyQHHcfRjEphjBEBw2DIo60sg+
X-Google-Smtp-Source: AGHT+IHZVqYKS2iFYtOE/tSHz7RN3sZh1WOSb+4OP97fjXIur8QI9sPPBXL8/BZMXg3DfJFX6AmixQ==
X-Received: by 2002:a17:907:94c9:b0:b04:53be:7652 with SMTP id a640c23a62f3a-b6475706f75mr883556366b.8.1760994403086;
        Mon, 20 Oct 2025 14:06:43 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526175sm894178166b.56.2025.10.20.14.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 14:06:42 -0700 (PDT)
Message-ID: <8dc12a18-58ee-4df6-a9f3-12d8c05a0954@gmail.com>
Date: Mon, 20 Oct 2025 23:06:34 +0100
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
 <e4f0290b-5d15-472f-acee-e1e1b0629ec0@gmail.com>
 <3f523293-8a8d-4136-b4bc-4ad0d4a50c59@linuxfoundation.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <3f523293-8a8d-4136-b4bc-4ad0d4a50c59@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 9:56 PM, Shuah Khan wrote:
> On 10/20/25 15:38, Mehdi Ben Hadj Khelifa wrote:
>> On 10/20/25 9:08 PM, Shuah Khan wrote:
>>> On 10/19/25 08:58, Mehdi Ben Hadj Khelifa wrote:
>>>> Replace kmalloc() with kmalloc_array() in several places to correctly
>>>> handle array allocations and benefit from built-in overflow checking.
>>>> This prevents potential integer overflows[1] when computing allocation
>>>> sizes from width, height, pitch, or page values.
>>>>
>>>> [1]:https://docs.kernel.org/process/deprecated.html
>>>
>>> Mu understanding is that this document lists deprecates APIs so people
>>> don't keep adding new ones.
>>>
>>> I didn't get the impression that we are supposed to go delete them from
>>> the kernel and cause a churn.
>>>
>> the document[1] specifically quotes the following:"
>> Dynamic size calculations (especially multiplication) should not be 
>> performed in memory allocator (or similar) function arguments due to 
>> the risk of them overflowing. This could lead to values wrapping 
>> around and a smaller allocation being made than the caller was 
>> expecting. Using those allocations could lead to linear overflows of 
>> heap memory and other misbehaviors. (One exception to this is literal 
>> values where the compiler can warn if they might overflow. However, 
>> the preferred way in these cases is to refactor the code as suggested 
>> below to avoid the open-coded arithmetic.)"
>> Specifically mentionned the refactor of the code base in such cases 
>> which is why i'm doing the patches in the first place.Also i'm trying 
>> the best to send patches related to the issue where such issues of 
>> overflow are present or to be consistent with the same API used within 
>> the same subsystem.
>> [1]:https://docs.kernel.org/process/deprecated.html> How are you 
>> testing these changes - do you have this hardware?
>>>
>>>>
>> I have a raspberrypi zero 2 wh that i'm using in combination with the 
>> ssd1306 OLED panel via I2C to test it's rendering and it's working 
>> properly by using modetest and seeing no regressions or warnings in 
>> dmesg.
>>
> 
> Send v2 with all these details and why this change is needed
> in the first place.
> 
Okay, I will do that as soon as possible.> When and how does this 
potential problem trigger? Is this a
> theoretical or does this happen in this code path and how?
> Next time include all of these details people understand the
> problem better.
> 
We'll do in the next iteration.Thanks

BR,
Mehdi> thanks,
> -- Shuah
> 


