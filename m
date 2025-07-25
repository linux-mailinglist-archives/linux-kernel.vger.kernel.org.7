Return-Path: <linux-kernel+bounces-745451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D3B11A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8667561988
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115A51EDA1A;
	Fri, 25 Jul 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoM8Ezxy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68780219E0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433133; cv=none; b=fHchAhfBtc5BeLXlWn1I/aN0kXY3GmE7P6oCNmMdvMpbB4LmVbPHVpdssBGUf+3zTGSSBIndxO7Y01DLH5yWs+zER34xspTaC/uzRjBJSWM/OA8yToyYOce+WXSLbi86trkrrr8vCAXB/9q8Zf5KQ1hy6z2T30DsQxoLDw4FELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433133; c=relaxed/simple;
	bh=xGANVMF2dWuVCsWN8+I6Kz4YfD3ch1oyz/LsQCjJ8+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJYaJ+85QUIHLmrKL/AhOxWRc1zQw/9lEINI9yGECIhslJf+kyLpy69DVX0lnQsClXX0psyCi9rcqUXD0H15xm8jTKdDeOE1Myu7xGsfVBqSQjg2U1qIHoNDqqfgaWVKUhvRNNuio/VsQu6MvTtF0iS9fZY1lzaybkh/OJe1qTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OoM8Ezxy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4563a57f947so14230095e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753433129; x=1754037929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiOi7M9IeQ+/7DA3YnW9XKEAkbfV4pJGPhG8hDHADkI=;
        b=OoM8Ezxy+taigEmPyTV9ULpwL/HlfJUxrU9mbJwC2tRObHYki6kDHQS+RCYQ/MIuDm
         BWGg1CTviQHJeHlvhLsPObpmZ8Nxc1KbjrKtrBGx+2/Zkw9ZGbPLWxrX3gKSXmA1E8bU
         vAeh87XSPsECnmTYZEFgTT0OmWue7bm07LfYjK1xcPwjxc/X/XlHZUpoB11XjjgNdDos
         WYSz9xg6m4i7GORKQCCJW6DiqIoxMTVuK4lvfVbNf4Om0vTsX+Om/o69h3lhvxTLkIHh
         t3ncTomIGl+7NeVneO6U9FMoGGEeFfHyJfA59uP/evMdnOtTawieHL+bflNSvFpwFfTK
         UIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753433129; x=1754037929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiOi7M9IeQ+/7DA3YnW9XKEAkbfV4pJGPhG8hDHADkI=;
        b=qC4B8UfueKBN3pgny42AI38sUwCvQXdoYOGdkmjBAoTI1u7Mw0hrvPQhQ4y78v9ycK
         48S9c8XNlMcEO3rtSisqCv54qqhiRAsovVZnkqLJtm50g482MK89pHFIIqALSQxYAIYg
         gfxlNWPqeS3CZZJIQagx/gJAMyimNzkuUqhlv2EhjlQ1vEagJQ5lUm06X1vbyiRrWHNj
         VG7lJGHSQwBByjtE5+H95lY8n6gWSnlXGBb+ykfQdAedZATXAd7vgGEBrgUy0iViUBv6
         2nTiTjqvkZkF3RcHYvmQjUAiLfGRJp7A2FP3U1nNt6OyZuW0aCffIpSXwju0Pe9Ddp5a
         DRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaCfUN42rYwhrRB0gMPsbNK1xfmLhZI5zdubnB3upOoaJvPTbjAWJIPRsYGBAf3DyRPOYo4aUrAHVNiJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQL9yqZ3XRU0wOzxzgppe2qrjJTRfh4hXiF6u5wonZsVTUY1t
	xw3J0A8AuonOML7/Sz42bueMN5mg7vZKSryktbWI0E840RoXUbjcpbJmOvwbfzoy0Pg=
X-Gm-Gg: ASbGncvvMh6RJfJII1UcJmRVAx1B55xUSHl1Ri/oK4OmvN3pWRz5klenJQ4r+opSJ6e
	y0Hz4fFizxqB8QWksxv/rtFOeHbNncx5j3ExDwyOuuB9tfs5QrbHtvO4fR429eHrqtL/5mU6BKJ
	WNdTSGCTFzDIYhE/ldboX37FElayoVdBCgtcKl42/W4fXnj7BQbrnVF+4/AbP0rlbxrzpBjx32d
	1jmUtsiSLVQPa+gmsjWFKCpwU0zpLOp8qL+PTWSkp+PKj+QkhMhxTRTO6C4wDEOn/054C1f71nX
	Jj/6XJrenIJFN6zHv5KvMQz2t8OMtECa/GRbxKsNGJv2fvHjznccS51YCbHyCQPbCicrKYEuMv9
	XS/hw1rRHqlaC6mNysKUkD6WVPwM=
X-Google-Smtp-Source: AGHT+IGr0PvB3BndUJjSS9kG3O/gNXghvVYeFYDKeqpUNDpaISXj6KCONZSa8uNvTsi4A58GUNun/w==
X-Received: by 2002:a05:6000:4021:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3b77137beefmr3824470f8f.26.1753433129557;
        Fri, 25 Jul 2025 01:45:29 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b773768440sm2731164f8f.24.2025.07.25.01.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 01:45:29 -0700 (PDT)
Message-ID: <4c1161d3-fc7d-4b3c-8197-7b632e85280f@linaro.org>
Date: Fri, 25 Jul 2025 09:45:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] coresight: Fix and improve clock usage
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/07/2025 4:22 pm, Leo Yan wrote:
> This series fixes and improves clock usage in the Arm CoreSight drivers.
> 
> Based on the DT binding documents, the trace clock (atclk) is defined in
> some CoreSight modules, but support is absent. In most cases, the issue
> is hidden because the atclk clock is shared by multiple CoreSight
> modules and the clock is enabled anyway by other drivers. The first
> three patches address this issue.
> 
> The programming clock (pclk) management in CoreSight drivers does not
> use the devm_XXX() variant APIs, the drivers needs to manually disable
> and release clocks for errors and for normal module exit.  However, the
> drivers miss to disable clocks during module exit. The atclk may also
> not be disabled in CoreSight drivers during module exit. By using devm
> APIs, patches 04 and 05 fix clock disabling issues.
> 
> Another issue is pclk might be enabled twice in init phase - once by
> AMBA bus driver, and again by CoreSight drivers. This is fixed in
> patch 06.
> 
> Patches 07 to 10 refactor the clock related code. Patch 07 consolidates
> the clock initialization into a central place. Patch 08 polishes driver
> data allocation. Patch 09 makes the clock enabling sequence consistent.
> Patch 09 removes redundant condition checks and adds error handling in
> runtime PM.
> 
> This series has been verified on Arm64 Juno platform, for both DT and
> ACPI modes.
> 

Tested on N1SDP with ACPI:

Tested-by: James Clark <james.clark@linaro.org>

> ---
> Changes in v5:
> - Skip clock management for ACPI devices (Suzuki).
> - Link to v4: https://lore.kernel.org/r/20250627-arm_cs_fix_clock_v4-v4-0-0ce0009c38f8@arm.com
> 
> Changes in v4:
> - Separated patch 07 into two patches, one is for clock consolidation
>    and another is for polishing driver data allocation (Anshuman).
> 
> Changes in v3:
> - Updated subjects for patches 04 and 05 (Anshuman).
> - Refined condition checking "if (dev_is_amba(dev))" in patch 07
>    (Anshuman).
> 
> ---
> Leo Yan (10):
>        coresight: tmc: Support atclk
>        coresight: catu: Support atclk
>        coresight: etm4x: Support atclk
>        coresight: Appropriately disable programming clocks
>        coresight: Appropriately disable trace bus clocks
>        coresight: Avoid enable programming clock duplicately
>        coresight: Consolidate clock enabling
>        coresight: Refactor driver data allocation
>        coresight: Make clock sequence consistent
>        coresight: Refactor runtime PM
> 
>   drivers/hwtracing/coresight/coresight-catu.c       | 53 ++++++++---------
>   drivers/hwtracing/coresight/coresight-catu.h       |  1 +
>   drivers/hwtracing/coresight/coresight-core.c       | 48 ++++++++++++++++
>   drivers/hwtracing/coresight/coresight-cpu-debug.c  | 41 +++++---------
>   drivers/hwtracing/coresight/coresight-ctcu-core.c  | 24 +++-----
>   drivers/hwtracing/coresight/coresight-etb10.c      | 18 ++----
>   drivers/hwtracing/coresight/coresight-etm3x-core.c | 17 ++----
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 32 ++++++-----
>   drivers/hwtracing/coresight/coresight-etm4x.h      |  4 +-
>   drivers/hwtracing/coresight/coresight-funnel.c     | 66 ++++++++--------------
>   drivers/hwtracing/coresight/coresight-replicator.c | 63 ++++++++-------------
>   drivers/hwtracing/coresight/coresight-stm.c        | 34 +++++------
>   drivers/hwtracing/coresight/coresight-tmc-core.c   | 48 ++++++++--------
>   drivers/hwtracing/coresight/coresight-tmc.h        |  2 +
>   drivers/hwtracing/coresight/coresight-tpiu.c       | 36 +++++-------
>   include/linux/coresight.h                          | 31 +---------
>   16 files changed, 228 insertions(+), 290 deletions(-)
> ---
> base-commit: a80198ba650f50d266d7fc4a6c5262df9970f9f2
> change-id: 20250627-arm_cs_fix_clock_v4-e24b1e1f8920
> 
> Best regards,


