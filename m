Return-Path: <linux-kernel+bounces-763749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830FB219DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B0F424F03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97D02D59E5;
	Tue, 12 Aug 2025 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TsGzF7YV"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCE2D541E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959064; cv=none; b=fgLf/i5Pzr5Y+GR6wGNXHN38VwKj0UUid4CG0oRPWMvNFoAN4P2ihNwNx6qGNXSZuDBHjAu4fQPGRPM47oG9Au0p1bD1agkuflmYtx/zGGZeDKVjsmxtcG7vp2FR+1+NVQXrRPJmwRAtNyLa5OoKCkvZlsPDLhnG9dh1pmFi1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959064; c=relaxed/simple;
	bh=MM7amlMlymZ6itBYJO4K7FlQlWOV9Hf4f/LDG05WvS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d6MoMEuJ2CF0BEaYViWVsAnVZWftSy2JOGeTKYCCsvj1Qufgya/TrAHBd9gk21sVhvpFmNPjhIVIRMvvwwRhcJIpycat4Pi8fcJ81Pe/UkHX7SOg34Xj1zG1wQ7672FJJV9mIu84bKLGK+zazqDGSqvUTtTaCCNebZ93HrDzKdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TsGzF7YV; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61b43c84905so3488144eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754959060; x=1755563860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qij29Dwz/tFkYWESkoLoLc09dn5e79Z0zwgkLbVcarc=;
        b=TsGzF7YVAuW8sL9l39Kzqdd13bM6XCMe+SxKb3aR8bFAOA/POAkBqapXVbU6bkuVti
         acOqEwq7XOeUR9DACuUxEWFLjV/O685/SaJIc6+7FpIC5iQscn1Xx24NkyuKnwpxtKsm
         3udz/8mtDu+90ncA4EWKvvU8rJxFn1og79lfKiX4fKnVqdgBhJVCbvxgLl8EOiDE3mrR
         ximygKtVkhdAv3qcpIML56h5ltkiqnqXYaESSbvE7tKjl0FIcIrLnn4j+PsBnrXfxJ9x
         x0Cl6NQy+BfUVet/yofiqHG8DJMtradg1Ad0tsQGEOl2uHxei31+/Glc7839xMRe8/ZJ
         PWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754959060; x=1755563860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qij29Dwz/tFkYWESkoLoLc09dn5e79Z0zwgkLbVcarc=;
        b=Ob62vFrUFrpRrv6McOHcm6RiccOWx+ss/gPzX197SbdkgoMKPDSQJH80fDIhfNX6h8
         vEC3eN0jP66D/4dFx2AHKfoETnK4JcGclu+gxwqHPV2CXY54Po/Uhb+1E474NUIuav0S
         EU7xcIGIug0KqzjJScY0ki593wbHAQSq8g73LZFNtnz5eZbZv4yU29YnbLGSBEBC3F61
         d/X9TM2vgDaEznpj9WeC6/6rdB8yF4KtNTpPhkt6E/Pl4Dbg0P5NLwr4QBAIMvJkmN0z
         DHSUEHBUCLFkGkdY4HtzFoITbb1T4+5HI7BtaGhs+wpPGBc+CFJbLebuIOfO67IpZStD
         E3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY/HmsVGpMR2UFWHq70JAwY4ZKXsBq26LVe9MO+X+UCfXonXAErHTErlldBCPyWG2KKYjPg5Sj2uR50Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMH6nwZblAiLICzuSYYa8VWGQBob5IRpoGTrQOkQPTFkotNdTg
	3RbfrisE53vbcjTi9ZsKO/z8ldMVQUCYxio8A9i4lf+5f7BSXWXdzea1ZGOxWtEz8XI=
X-Gm-Gg: ASbGncslv+lLVpbdPcbzxAgiS/ZiU3CvnCPz44r0oHyNEEAA+J8X2lC6vKxpderdFY8
	8oDtt2LKlBii2xd72t9Fj7UJj+ACx5XaFC2mD7i7+hDOw87z3DY2Z1kJOvKlgyZ6cdZbo3MIefn
	pZaVrQtZDo2r55R3sBwHVUPRJ9p0vAHEQZUKfOqlvwIwK4vP+SpxdwPSff2FmY3Yn+9hl/DtVkc
	VMQ6ZqVtApgQC7nJnekIYV2dwif1jIhKsFQrpro9rgYoDTJWZoM3+W+CU4uGiEumntbgljOWM9m
	xr5QEo0k7llfBqj1V6ISsOEFzG8cxatL0ejmCCoDhzSLfzLuQF/8oPrhvpRoF2WoijHVCyOPBRr
	WXPGGoDQuF9A3B/JYzL2BeLG9b55exyrJk5yj3yAni680zLoN2VMqH2bLWi+FjMmnrUif+gqV80
	0=
X-Google-Smtp-Source: AGHT+IGakl/eXVN/0VvRKWuNy816VmFzFbnxikB++De4HoaGdaaXnZwngXs2yzJOw8EAkR7KH4BssA==
X-Received: by 2002:a05:6820:2209:b0:619:932b:3dc0 with SMTP id 006d021491bc7-61bb5b4aac2mr1230648eaf.3.1754959060262;
        Mon, 11 Aug 2025 17:37:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba? ([2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61b7cac4d37sm1229026eaf.30.2025.08.11.17.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 17:37:39 -0700 (PDT)
Message-ID: <64e64124-112d-4942-8ca4-290cabcfd9dd@baylibre.com>
Date: Mon, 11 Aug 2025 19:37:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iio: add power and energy measurement modifiers
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
 <20250808141020.4384-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250808141020.4384-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/25 9:10 AM, Antoniu Miclaus wrote:
> Add new IIO modifiers to support power and energy measurement devices:
> 
> Power modifiers:
> - IIO_MOD_ACTIVE: Real power consumed by the load
> - IIO_MOD_REACTIVE: Power that oscillates between source and load
> - IIO_MOD_APPARENT: Magnitude of complex power
> - IIO_MOD_FUND_REACTIVE: Reactive power at fundamental frequency
> - IIO_MOD_FACTOR: Power factor (ratio of active to apparent power)
> 
> Signal quality modifiers:
> - IIO_MOD_RMS: Root Mean Square value
> 
> These modifiers enable proper representation of power measurement
> devices like energy meters and power analyzers.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - remove accumulated energy modifiers
>  - rename power_factor to powerfactor for consistency
>  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
>  drivers/iio/industrialio-core.c         |  5 +++++
>  include/linux/iio/types.h               |  1 +
>  include/uapi/linux/iio/types.h          |  4 ++++
>  4 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2fb2cea4b192..28f51e4cc367 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -167,7 +167,12 @@ Description:
>  		is required is a consistent labeling.  Units after application
>  		of scale and offset are millivolts.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw

This looks out of place. There is no existing in_altvoltage_raw, so we need
to start a new section.

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_active_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_reactive_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_apparent_raw
>  KernelVersion:	4.5
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -176,6 +181,8 @@ Description:
>  		unique to allow association with event codes. Units after
>  		application of scale and offset are milliwatts.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_powerfactor

This one also needs a new section with Description: etc.

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
>  KernelVersion:	3.2
>  Contact:	linux-iio@vger.kernel.org
> @@ -1569,6 +1576,9 @@ Description:
>  
>  What:		/sys/.../iio:deviceX/in_energy_input
>  What:		/sys/.../iio:deviceX/in_energy_raw
> +What:		/sys/.../iio:deviceX/in_energyY_active_raw
> +What:		/sys/.../iio:deviceX/in_energyY_reactive_raw
> +What:		/sys/.../iio:deviceX/in_energyY_apparent_raw
>  KernelVersion:	4.0
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -1692,6 +1702,7 @@ Description:
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_rms_raw

Shouldn't this be in_altcurrentY_rms_raw? in_currentY_raw is DC current, not AC.
And we will likely need IIO_ALTCURRENT to go with it.

>  KernelVersion:	3.17
>  Contact:	linux-iio@vger.kernel.org
>  Description:

