Return-Path: <linux-kernel+bounces-812730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486FCB53BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518641C23DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FCB256C83;
	Thu, 11 Sep 2025 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzr2+QVj"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89401188CB1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616977; cv=none; b=lVsZhLjGm68AtluTQOLVdkTUefVeKLTM4XXOWzMD7UNmvCFIU8ZL4EgFVNEYzs/mEoME5nKImyvtdAsHd3SmbxOz81wQH2AlFM21fU0kdRf6venfAM/OSPfX36TWDgYvXOJIsH397uQO1YaeQhCT5PcmY/VjlhQoBM6FVcy/8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616977; c=relaxed/simple;
	bh=G9PVOicImObvMdXVVb+6plfEYjjJkzKtfTB6xhY7oiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ezugph3W/+Ae8rvc/t6LhU5KADhH21m0O9a0tj2EGFxVFOUtXQLszm64LweLRsU7uUqQr+RZqLEycq95robNvXW3c0MaN72mgweNngp2EAiTQ+hT01Otn27wvGyt+iGpkR1gAvG470lt3lWIk7eekZl/X1JYqv00fDw0K1psma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mzr2+QVj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e751508f21so831203f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757616974; x=1758221774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rekHjTbST2J3gdgDOG8ibNuPO2c1lzAXyA1v5TU/iWo=;
        b=mzr2+QVj6hfChvNZtEBi7N5IVkR8wG7RNXuLgNFMC1IuIAL8olZtuyX110M3WscCYR
         XshgRYC6teY+fUJVGfbApIzhhVw2A8kyQXoJikTwdYIhmhuCYZ8MnCB5f+EjpFdCHdar
         1rSNYn9dEiMQ8nOxDIr1UC3fwQIRRJIQJVklQHgqT2XnJHvXls1AjqC1Ykzd9A4bIC/c
         G5pv1G3Wt14KqtCmIf5pCV3hGXhL5oY0/ow4I34/qeitfkOEjDkO2a9gZdAxBbF3uBcI
         MJFHSIpBNjanXcyu6Dflur/p2VQCxT7MUuo7QsAYygrq4lBNHu798a4d+Ueo90JtTROf
         BWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616974; x=1758221774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rekHjTbST2J3gdgDOG8ibNuPO2c1lzAXyA1v5TU/iWo=;
        b=hUPZ7qnsSyKvUP56/uuIAvJyzW4keRf3NHQfAPlxWTzR6Tjyvhl0IG8ISO44LXtI8C
         3+MdFU+bj+LNVvH5akflkuPUGWktwBqwMWfV2mneyFsT315zEmntUVWyBqAa4H0Ny1u0
         raLEJPh0OytBb5FmMXCvt9LZkGwNyaamRwSR/s+RzfTgTAQZqetlXEd4hfE8VcgWbOny
         wGv4uYEhhXacafFsDdVJ9a+M0ehcbSKjk1f8rRv8v5MXGvuBRQnUmVFWDsJsQOcRyeML
         mYrxX/Rbypi0nyjWMYkSzdYnTWMkr2OdCWMM6yOVKUfvJ7s8uxvebx/c2O3eybsx91gA
         1Chg==
X-Forwarded-Encrypted: i=1; AJvYcCW38fyvVWJpIWflRBl0h/yAVVhqLjO60ID0QHGbbKYHQ5QHQUwAg4hGat8SESjq5HAk8pSA7NL5MXbUNks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYqucW0Rn8pbXB7lKWHsxxy5Bb7BYcQ/04Wcn1xrg0w4vRJ53a
	VvXqXJOQFTX0arByxbfMj38bJWt8nY4bIG1rtcMkDZMUbwRHa1d2sWENpM/yppmHlzk=
X-Gm-Gg: ASbGncuLOBlP/oelgH4GpN4pQV+XmigjAV+syOmioU1tooHAfVs0S0gfmG7COEJJsHD
	lEtpfAMifjKEaegjZLQFBmTFboD4JLP56fMmUqfNqtyrepNKmqR+ziY/tRIHZpJeDOAiu16m8/4
	zliej1llfZQG3Z6RPviFhxR3KiFKWS3uxIJbHb+c35n7NKPbClBktvxrmhOtEz8FLkrOBo0m2zN
	nRIU3evyzj+dORJypm71YUq86JV2LFM+4Rbcypmb8tAGLwk2Dnq3O7H56P/CrjrzAB2pMV0Ccxc
	wbMGHqrnvN7pHW4fY8YN+L4NQ/8NBxoWwWuG/aMvvbsODN+L55tsQATI/jCYg0UI5UaNIOrqIbi
	TD03BboUD1apnposaFsPAbqefc6m6mwYui0z/gqu1H/wIVxw2Vfh1GxsuGVexteiGvo3iF11gp/
	JCcOhBALsf5XgY
X-Google-Smtp-Source: AGHT+IEuCngj6El+msipl1V3catUDI1SMJQ5OlW0Wjxj8ggiY+iRRQHMDi9h8+t5G0p3xbR8aE2/SQ==
X-Received: by 2002:a05:6000:2509:b0:3d9:70cc:6dd0 with SMTP id ffacd0b85a97d-3e765a05342mr397079f8f.33.1757616973832;
        Thu, 11 Sep 2025 11:56:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d521:838e:7c69:f457? ([2a05:6e02:1041:c10:d521:838e:7c69:f457])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e016b5c5dsm37360275e9.14.2025.09.11.11.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 11:56:13 -0700 (PDT)
Message-ID: <da8aa4c5-4aa0-42f6-acb6-55d37cc29774@linaro.org>
Date: Thu, 11 Sep 2025 20:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] thermal: tegra: add SOCTHERM support for Tegra114
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250828055104.8073-1-clamor95@gmail.com>
 <tdknls7jieu4ple3qhmdqntllmctks2auxhxzynwjjmgl3hnx2@nubqlzpgohwf>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <tdknls7jieu4ple3qhmdqntllmctks2auxhxzynwjjmgl3hnx2@nubqlzpgohwf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/09/2025 18:27, Thierry Reding wrote:
> On Thu, Aug 28, 2025 at 08:50:58AM +0300, Svyatoslav Ryhel wrote:
>> SOCTHERM is thermal sensor and thermal throttling controller found in Tegra
>> SoC starting from Tegra114. Existing Tegra124 setup is mostly compatible
>> with Tegra114 and needs only a few slight adjustmets of fuse calibration
>> process.
>>
>> ---
>> Changes in v2:
>> - no changes, resend.
>>
>> Changes in v3:
>> - expanded desciption of "thermal: tegra: soctherm-fuse: parametrize
>>    configuration further" commit
>> - changes title of "thermal: tegra: soctherm-fuse: parametrize
>>    configuration further" to "thermal: tegra: soctherm-fuse: prepare
>>    calibration for Tegra114 support"
>> - Tegra11x > Tegra114 and Tegra12x > Tegra124
>> - ft and cp shift bits dropped
>> - clarified tegra114 precision
>> - lower_precision > use_lower_precision
>> - nominal calibration ft and cp hardcoded into SoC specific structures
>> - added tegra114-soctherm header into dt-bindings
>>
>> Changes in v4:
>> - fixed Tegra124/132/210 cp mask
>> - dropped TEGRA114_SOCTHERM_SENSOR_NUM from header
>> - TEGRA_SOCTHERM_THROT_LEVEL_ made SoC specific
>> - adjusted soctherm node and inclusions in tegra114.dtsi
>> - dropped use_lower_presision and nominal_calib_cp options
>>
>> Changes in v5:
>> - fixed CPU and GPU hotspot offset values
>> - added static_assert()s to assert the TEGRA114_* and TEGRA124_*
>>    counterparts are equal
>> ---
>>
>> Svyatoslav Ryhel (6):
>>    soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
>>    dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management
>>      System
>>    thermal: tegra: soctherm-fuse: prepare calibration for Tegra114
>>      support
>>    dt-bindings: thermal: add Tegra114 soctherm header
>>    thermal: tegra: add Tegra114 specific SOCTHERM driver
>>    ARM: tegra: Add SOCTHERM support on Tegra114
> 
> Hi Daniel,
> 
> there's a build-time dependency on patch 4 in both patches 5 and 6. Do
> you want to pick up patches 2-5 from this series and I pick up patch 1
> and hold off on applying patch 6 until after the merge window? We could
> also do a shared branch, but it may not be worth the extra hassle.

I can take the patches 2-5. Regarding a shared branch or wait for the 
next version, I would prefer the latter

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

