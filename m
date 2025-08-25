Return-Path: <linux-kernel+bounces-784683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC84CB33F93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94C43A66E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EA3274FE3;
	Mon, 25 Aug 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lma77gxy"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60B1A08B8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125219; cv=none; b=a3+sULappREhU5GkhXwPSqkZgjBzzFsxOGZgzkEuMSr4DVWh6MOs/lmaDZS6qkkHhii/t9xaoe2JShb9f6/6KTTrnzoECNuC3KJIyHM9x0J2ujnibNwcod6qg7UupTix584ya1smWa5qpB9JLxj5VDmNU+3IeqA6xqPxIvjLFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125219; c=relaxed/simple;
	bh=Ty74hZnXxWKvhet9JdbuwC8Mits1/1r65GA1qNGnYFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDzUUi0EEdr7piXO0TlzLJ4ZCV/0vrAkey8bmSfx90DI+uK8X2Bk6YeYQpFYUcWhjhGmKg4bdJRf2KzYkJgkm2MyGQMXYxofXXFrw8bYE0s7qaSTYORrvhuZfcYi4KiqeQW4DIlR4e2hyWUyFCUhtkhtflfBl9lIU12EyCQ2hIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lma77gxy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so33293735e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756125216; x=1756730016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TgyYW+EFxanlM3ZuOCikuS7pxBlxHl7zqHrCzYeY36I=;
        b=Lma77gxyhHRtjNh0X14rzN5kkklXGuXPf2ldI/JPx7dv1rtqa0iOF5YFdMq6Ai0ZlI
         UX90Wj5LONh6Jzb5UwQ2W9f/lggNW5gHWe5Oo69ldGV7l76jbZnCa15kId0HeKdTFZ/1
         DQO1n8SAQwTgTQWg1AvhQE2rV7IqGgbc1bes+5tHmZKXSLfGL4FxO6Zgm8udTfaYv8JD
         u4GLeomD0wYMxh2qg5Bwdh//SbTjG/2D+9SUbDsOvKdwj49rwleIS1h7fsvIlEM4M+Dq
         5RtIIqioBdtuYODTY9s/NwcYzom14IQY73p5iMs3TSeBWDLJozVvhcO5CuYbfL5SXSw8
         rUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756125216; x=1756730016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgyYW+EFxanlM3ZuOCikuS7pxBlxHl7zqHrCzYeY36I=;
        b=LEAmQOmKVrpKduJLejYhqby8lVQ0ieHV7ik/OM0oNgHY6uX7H479stam3J2+yaxPPW
         KRFDY9lx7pktbUc5Blq2egGaq7y4+slk/6PPMrLjFKUKtEMuYDTT+Z0lgNSpMl7ujpIv
         0pEizlrf5D3D74XJJTAMoubh/mm5hc0/VdRVlEg6+kzfqmvj9hcsXTe5zqvKNjEdPu0K
         kAFoZ1hcASV2WCmm4w/XfoEuw2VZcWcYa+9o+LJM0uFRsLYTdKefuQIMT71ABG0VE0j9
         oC6CbSKtoLJ0TqcM9SReGs/7aSSIgt2nsfDxwALUuiv0E9tbNj9fQNf2Jzr2k9OSMd/6
         V2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCW7zDTi9UaBsW87yefzlC4poNdGa9HOJ8BEPklCsIduEkBfQf6h6+P0YGHF/1uzgQVqhXKl15bJE86MZ8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Py9jdj1Et8+CfOMsD2d+0sdxKCRi8Db9Bewl8SePWVRLVLng
	mgfdTgGr/yi0vfe6zBYB9FuIDU+bWzJ3h2RsxmogvsXxd43KFERoYSXEf/97rtwfRHU=
X-Gm-Gg: ASbGncvSaaXh/64AXOFKBCLd3UFU7avuMD9Wvu13Iin0ZmsA48cPthHTKCwZ05jr5f3
	zWRRIhVYqM7hNWmBpe6OwBL+2oQsXuTMumnaWIsQ9TASNg1xWT514RodQOvCczTPlgP23Fx4dgi
	EwGS2uB69M2ujHMNzo7eW8kbIWH6WoqJL0DKs8rdc5Ly7SS/Jd6OlwLY2NuQewC2Xd6glA9tJcR
	cW5Gidc6dxr5aaFxo5qUDwdCff8f3WGgrR5feD1hBZXRKAmefKfTgW2mKXCcpMinx7R0QxER2FT
	5PFCycbsA5Y66WYD2k3KvlBSaVmOY4eR4K26xsevqIHhTCbeQkNqk+mnpZbKp+V4/40oOqBdTB6
	GeWZ+iK9kt8QtwIJlu6V8zaagR0NY6hWDauhly4ODwQ==
X-Google-Smtp-Source: AGHT+IG8r5+sVjMa01w8IZgVwuhCEDiGDvftj5dR2IQIaEIX1i8970n/oog07azqK0eoXxNWJVJyPQ==
X-Received: by 2002:a05:600c:1c97:b0:45b:629b:dc1e with SMTP id 5b1f17b1804b1-45b639a0d26mr10121405e9.1.1756125215756;
        Mon, 25 Aug 2025 05:33:35 -0700 (PDT)
Received: from [192.168.0.251] ([82.76.204.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753adf7sm107972935e9.7.2025.08.25.05.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:33:35 -0700 (PDT)
Message-ID: <b84dbc22-62d6-4a63-9b53-80e939c36e38@linaro.org>
Date: Mon, 25 Aug 2025 13:33:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: exynos-acpm: fix PMIC returned errno
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com,
 Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
References: <20250821-acpm-pmix-fix-errno-v1-1-771a5969324c@linaro.org>
 <c744f5da-ed3a-4559-80b1-9cef5254224b@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <c744f5da-ed3a-4559-80b1-9cef5254224b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/25 5:50 PM, Krzysztof Kozlowski wrote:
> On 21/08/2025 15:28, Tudor Ambarus wrote:
>> ACPM PMIC command handlers returned a u8 value when they should
>> have returned either zero or negative error codes.
>> Translate the APM PMIC errno to linux errno.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/linux-input/aElHlTApXj-W_o1r@stanley.mountain/
>> Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/firmware/samsung/exynos-acpm-pmic.c | 36 +++++++++++++++++++++++++----
>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
>> index 39b33a356ebd240506b6390163229a70a2d1fe68..a355ee194027c09431f275f0fd296f45652af536 100644
>> --- a/drivers/firmware/samsung/exynos-acpm-pmic.c
>> +++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
>> @@ -5,6 +5,7 @@
>>   * Copyright 2024 Linaro Ltd.
>>   */
>>  #include <linux/bitfield.h>
>> +#include <linux/errno.h>
>>  #include <linux/firmware/samsung/exynos-acpm-protocol.h>
>>  #include <linux/ktime.h>
>>  #include <linux/types.h>
>> @@ -33,6 +34,26 @@ enum exynos_acpm_pmic_func {
>>  	ACPM_PMIC_BULK_WRITE,
>>  };
>>  
>> +enum acpm_pmic_error_codes {
> 
> This enum is not used. Size is not needed and you can just use
> designated initializers in the array.
> 
>> +	ACPM_PMIC_SUCCESS = 0,
>> +	ACPM_PMIC_ERR_READ = 1,
>> +	ACPM_PMIC_ERR_WRITE = 2,
>> +	ACPM_PMIC_ERR_MAX
>> +};
>> +
>> +static int acpm_pmic_linux_errmap[ACPM_PMIC_ERR_MAX] = {
> 
> const
> 
>> +	0, /* ACPM_PMIC_SUCCESS */
>> +	-EACCES, /* Read register can't be accessed or issues to access it. */
>> +	-EACCES, /* Write register can't be accessed or issues to access it. */
>> +};
>> +
>> +static inline int acpm_pmic_to_linux_errno(int errno)
> 
> Drop inline
> 
> s/int errno/int err/
> (or code?)
> 
> errno is just too similar to Linux errno.
> 

I agree with all the comments, will address them. Thanks for the review!
ta

