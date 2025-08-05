Return-Path: <linux-kernel+bounces-756455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE6B1B49A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8403A7DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE38C273D82;
	Tue,  5 Aug 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNs5N9o5"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA62737F8;
	Tue,  5 Aug 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399600; cv=none; b=NDX1pm/O2pZIIrnGwd9iIts7KmT4YN1TX3KA4D/2C3p/8bTbjX7QOyoSkrhfff5+yMsvNDtTE1L78eQ5+UQPSXepqMFRYm50ebFxfLaIwm0gIkUykMugYSsG0HmgC5KmehCLwHMDrGjIo0McDnt45EV0Zk8Efbe6rJD7rLRRhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399600; c=relaxed/simple;
	bh=VifM+ab/hBa3nt+oOPkFxJiS8el4ucprFd694IPaVlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8DYCtNHQ2X5pu/xeedVguR/7O2POhBEPg1sguB5kRwT9/nuOf2siwfxsRsRnRnj2h/TGKe5+S1IKtiizwdQRQeIS24o+naCViPEAj2dQW896lAZiqcuJJpoI1tlt0Mfmfg8DO0GLq3TIZ8hhGmHvM4e17XhS5QLaKCE52wILNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNs5N9o5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7426c44e014so4976573b3a.3;
        Tue, 05 Aug 2025 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399598; x=1755004398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gV1AuynyFCHeghTZWDCMvw8UAR68QjHUdkCbqwe4POA=;
        b=lNs5N9o5RweJ6+k/uccelwyoDgCdJAa0l+/Wi+bCHcgCQ4Pt+2NquRdvhxTMH+lKJo
         ZW5DXiOUn4rUuJUAlej2oWe2d+mjeIEf3zaKt9ry58R/vXXCoAx37BPVbOs0GeZDm1mS
         QUdN/ZDxYheZH87/2Autx8/j2ni7ZhMp8Akja8xXjPvJeIjWRbvniJh1qiXYqkwbFr73
         5YmlOHkeMYB1NlzJvJwPXs7Xur3QXAALFg0PdpYqLN2QCsmCyxqeJY4RM94egM2ab65G
         cPFL4M7x4SvuOavAqmhJXN4Dl4i49XOojO4vbOtmhBsX7Mp+Cf9CWcP29S5dzEI2KlGf
         seJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399598; x=1755004398;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gV1AuynyFCHeghTZWDCMvw8UAR68QjHUdkCbqwe4POA=;
        b=iyCkSespn4WgcdAf5EkFx4cDm/CMF5IaZXzIofBbeKb/FHn8FovbBoEdri0UJHIxS8
         m9H7808RY3/qp/UjAFJuPSjBbm8OagK7ma4mVFmllFdNCMB2xlz6R3tz9I2BjO/zMZnX
         3SGTr50SqvYMfEES5kVgVYqFNhmJ/QRkR3suhr0OhAqc/0uJsR6leOPIrknBqilPFoYh
         uRHlG4aDRA0pOxN2KTqx8dVXr/uFjwBiaGcA3iQ+gJ4Cukxtv6lPQ2QzxsHCxLo4iPTF
         J09b9ZsCF9ISt/ZdPVrzErOkCQF3eVI9qLLYaFDCi9Uqd3v4KwRpreeMS+dD/R2PVgAM
         U53g==
X-Forwarded-Encrypted: i=1; AJvYcCW1AXhz9fml36mX3eGOSdi7K3ZgHRI9EAYHtbuxIoJyWG8Owyhv1DL+o+v3YcBq5nbmBxwDVcNR9XNoSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1LrzCCBSwhFN++/sLusy+Os3h/VsfFFqlBjzr3G9AiIZDwL1
	bfOgcPnch2q71o5TzIOcF4LurB+OLb03ofT/E+cxuktpceX5foL/nI/mCs3H0g==
X-Gm-Gg: ASbGnctl5WmRwfZNSNg+WJ6J3Y+DZH9goXJAZXp4ZrCKfWaDdduUVhp1VmavnL7RsU0
	RU7Q+HLkij42a3RxNDgogQWUGPxhGrHdnX85njOh5ZNdMoB0k9+Tv1zNj2YvDK0IqM7dYTUNmDy
	DBkarfJkfQeTXKSflANFLs254CSG9uyy/EsBd2afNqjglM6zdGENuzebA7Jx97Bii+Dp9MOTftD
	p/ltoXoKOpKNYsJuS0VEYzWWXKnpSjLUcy/v0HfBnvQp9Xm9Gj3Su4iG4fcW/PfnGrkHWsGo/5U
	eVaLzoDCUQrMJIe6co1Pzlv1XplXtzmTPrvW7+i9IZ/JHrkfgG8w/0HFvcwDm6oIf9cinSLRKhd
	MnR4pU70dziVxkrLVHZ/mfJiDUVXdWGOUt1MffH8yZChw3T/URvbx+m1xL9yawx0h9WqdM8afsQ
	OLsy6Efw==
X-Google-Smtp-Source: AGHT+IGHl2aSTawmjvSDGrfYh/fGkq10xNrV0wlEWWLRoQOJ6GT7lJaaIhruCOhiTCO/UG/v49Kapw==
X-Received: by 2002:a05:6a00:198d:b0:76b:dd2e:5b89 with SMTP id d2e1a72fcca58-76bec33dffemr17125421b3a.6.1754399597659;
        Tue, 05 Aug 2025 06:13:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8b5basm12864426b3a.41.2025.08.05.06.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:13:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <af4f80c4-3d31-4e03-8996-2caf2f311b7a@roeck-us.net>
Date: Tue, 5 Aug 2025 06:13:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: scmi: Remove redundant devm_kfree call
To: "a.shimko" <artyom.shimko@gmail.com>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
 cristian.marussi@arm.com, jdelvare@suse.com, guenter.roeck@linux.com
References: <20250805125003.12573-1-artyom.shimko@gmail.com>
 <20250805125003.12573-3-artyom.shimko@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250805125003.12573-3-artyom.shimko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/25 05:43, a.shimko wrote:
> From: Artem Shimko <artyom.shimko@gmail.com>
> 
> Fix potential resource management issue by:
> - Removing unnecessary devm_kfree() call in error path
> - Relying on devres automatic cleanup
> - Preserving all error handling logic
> 
> Rationale:
> - Memory was allocated with devm_kzalloc()
> - devm_ thermal registration manages its own resources
> - Double-free could occur during probe failure

The reason for calling devm_kfree() is to avoid holding the memory
unnecessarily until the driver deregisters. There is no double free since
the code calls devm_kfree(), not kfree().

The reasoning is wrong, and the patch does not add value.

Guenter

> 
> Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
> ---
>   drivers/hwmon/scmi-hwmon.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index a3b5b5c0ec25..d03174922e65 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -211,8 +211,6 @@ static int scmi_thermal_sensor_register(struct device *dev,
>   	tzd = devm_thermal_of_zone_register(dev, th_sensor->info->id, th_sensor,
>   					    &scmi_hwmon_thermal_ops);
>   	if (IS_ERR(tzd)) {
> -		devm_kfree(dev, th_sensor);
> -
>   		if (PTR_ERR(tzd) != -ENODEV)
>   			return PTR_ERR(tzd);
>   


