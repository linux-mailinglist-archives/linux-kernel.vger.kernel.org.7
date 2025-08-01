Return-Path: <linux-kernel+bounces-753320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76CCB1817E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116CE5877E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938D23C51B;
	Fri,  1 Aug 2025 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6kkchbN"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99A2222CB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050311; cv=none; b=kdFq3ARfOqcmW8AHbOdYTRrYsaJC7BTbG4yqigQH1EabITK8+3IkyUvI7SpyopSgSm+Z3RM+CqJYU4yfJsZuq928F3Ti/QPbH0SLDWnCoayJ8bMRXRrd7xJnff807HhP67ZxigH2VAB3L8vYcnbLJmk3dBTcOOzJFkbm8R02yq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050311; c=relaxed/simple;
	bh=o+RvfAEKe0RomM6tA+1Yt7h1qdgjQPP7umZQVLXtH78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcsD9PvksI71WZrHwVHxyn4+lno34nbQOQJz6wTKPtmgAmFVnbrXhEAIRU2z1q4k8RGclBDLmg167tQu93T6dh3E8+zu3yqHf3iKffymd465vPcR02n4Rw40tHDJJeGla+eTtkDjHUWSkpbeJb0TQ2VASkKkHZ06xspyGrZIhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6kkchbN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4560d176f97so8817685e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754050308; x=1754655108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T12VqVTqT9QY5bVVlcekdmYIYdB9sxvGnJLlTnRGMWs=;
        b=F6kkchbN0D8/cLStLRWidIjQ6D1cNids4xCD+OwPP+WVsZlNQ6xyef9hjThLSFSLmw
         2d6NObPYw04qqKm8FKtGGHiE0B9VhJ2vXD48ilzv2NQnrDdWT2kDl4WEUhIws14eBx3B
         XZ552B6g9YEAq9BFKT4BWryOk6fEJ9LzF/hl5aw0i/zf1hc17hPa9yM/Xnddi2kN8KBC
         /5q+Cq8lf8e+lYIz+sb91MBFISD4EtdzBHh8nSbQKebolvE1WjGEPStWPWE97wUpBowk
         HT5d9NErOKHb1SxW8aKBDAwhPZI5VhC2cFncCL+2NcapZCW/4AAraC8MEo90li54t6Rv
         G0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754050308; x=1754655108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T12VqVTqT9QY5bVVlcekdmYIYdB9sxvGnJLlTnRGMWs=;
        b=gxtezOH47I8fV5Qy/I6wwmY+UkZU8IxQOeayhW/Uut4LwHDFxcGsN0Vy3eTjQQCLxz
         40sBZRCcx3dk2UNUo47+DkquZFFHmE9nenXyEgc8z5qR1Ky9XchPguPd24iI8G9EIkXz
         H3qewZANwi9kNj+tcinefjg1aq1GpEQ+D9X1UTyJhDRUm5PgGVIfzUGBI5YqG4kZYL0G
         143sTVs4pdwpcztCqRbbC3WbpCRrlnxQR07J504vueVi9aR/21JB5xXLVU2AJMt3zx3Q
         8kOJG3HeKVu1GLsNFN/psqZ0dDIjtHTSZuxHU4sglUjWfoH6HboD8Tl1gNxKrWeYvOAo
         qtDA==
X-Forwarded-Encrypted: i=1; AJvYcCUyrbHX+ZAXGPB754W527HAgyuo/w4BY6S3viMqEjPBfzazcF0AATejy+CPkwSFUJppG86QHed0IeSfxrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwfjlM1Ssc57PTZYo07lt/k5tKs3C8l8wR/ESOAjLb/lTgcM+
	FOcojasnp8HhM/V35ojSmKMQrYp9egakHjRiyzCgG5kDQ6VIqywg9O4m
X-Gm-Gg: ASbGncsao4OO4XKJz0Tf0M5oOsWezZ6u1HTVK7/8IWyUyB7cS7xv9ae87EtVzwj/XIk
	+JCHf6Agq6oTny+qMsohCizqcIlOUYvNKEce+eBJQ6m60H3J8MTtQNJbabW4CJCV+5CvfbO0LbS
	pqXzXuA8ixD77DynC/6nUXhUkhywSZKXyFpjQWUyYBLY0oeSXFAWcCEWjHCTtaS4r7pXyoLqGyf
	eUIaY9wB6ovb1sewFYTxPyKcma0vFBDNHbIO69iNPvaR01tJw5xDOPAvHXD73jg6do3h9xf9gD+
	B3daULpmIH9Zdh9T+gUVXI0PC0b3OymYzBbCoWBZPXtmFjYxjdM/+mp88sNAd+hxktEvOstdx9o
	kELq4fhfa6Clpd8rn8ljy2ntsDxFIgjT4V8WN4udfCLj31aFeFbNdH+LWY+4o
X-Google-Smtp-Source: AGHT+IFvST29zGsk85DMEnhGey+/+aFmHxqKGQr+Apz5n2YWFAlf/V3qjSSG5bEiZMA7xIBl8huCNw==
X-Received: by 2002:a05:600c:3ba1:b0:456:1fd9:c8f0 with SMTP id 5b1f17b1804b1-45892b947c9mr122493875e9.2.1754050307932;
        Fri, 01 Aug 2025 05:11:47 -0700 (PDT)
Received: from [192.168.1.129] ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a22365c0sm62954395e9.3.2025.08.01.05.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 05:11:47 -0700 (PDT)
Message-ID: <8bc1a3c6-b7e0-4256-93ef-57b7b6a41d94@gmail.com>
Date: Fri, 1 Aug 2025 15:11:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: defconfig: enable i.MX AIPSTZ driver
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Shawn Guo <shawnguo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
 <20250707234628.164151-3-laurentiumihalcea111@gmail.com>
 <3894475.kQq0lBPeGt@steina-w>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <3894475.kQq0lBPeGt@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/2025 8:42 AM, Alexander Stein wrote:
> Hi,
>
> Am Dienstag, 8. Juli 2025, 01:46:28 CEST schrieb Laurentiu Mihalcea:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Enable the config (CONFIG_IMX_AIPSTZ) for the i.MX AIPSTZ driver, which
>> is required for platforms using the AIPSTZ bridge (e.g. i.MX8MP).
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 739b19302865..4d7a60444bf5 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -262,6 +262,7 @@ CONFIG_GOOGLE_FIRMWARE=y
>>  CONFIG_GOOGLE_CBMEM=m
>>  CONFIG_GOOGLE_COREBOOT_TABLE=m
>>  CONFIG_EFI_CAPSULE_LOADER=y
>> +CONFIG_IMX_AIPSTZ=y
> Why not =m?

well, the thought process here was that since the audio block control driver (i.e.: clk-imx8mp-audiomix.c)
is compiled as built-in (CONFIG_CLK_IMX8MP=y) we'd want to have the bridge as built-in too so as to not
defer the probe of the clock provider and its consumers (in case there's any compiled as built-in).

however, the bridge driver could have just as well been compiled as a module so any of the two approaches
is fine with me.

>
> Best regards
> Alexander
>
>>  CONFIG_IMX_SCU=y
>>  CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
>>  CONFIG_QCOM_QSEECOM=y
>>
>


