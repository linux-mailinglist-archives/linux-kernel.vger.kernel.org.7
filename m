Return-Path: <linux-kernel+bounces-731694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A3B05860
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1300D16575E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4062DE712;
	Tue, 15 Jul 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgIuQ772"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A162DE6E7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577395; cv=none; b=nTOP1V+zGmPV4frVHSgnhGReME6NPql8agd/JsC5udR7pmIdjGI733PYWXjE0zZu3q8oaUJdrC9BVS/L7IFNVLNh0p16ZIJwHAWZAFaaQ6yeUR/Q6FjgKQr/x7j6OcvV2tpDSBw4/MIysReffanejsdhI2JTj7LCYRgf85+oyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577395; c=relaxed/simple;
	bh=dUS8eQbu1c5UaxNDR+gbiEvORXK1+GXu12FFyLzIm/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCHXErYFLZduAZGZTSzsQGNcL+lkki5DRx82M/dHsflpunHy5o0ZBHcREHubbILgrW/yjHwVgEb+mN+arrhZeX2Jfg0TQLwWzaEy8H6sIvZDGl9KGf6cxOp6RCX8y300uwte+fmtflVyjUXIvgP7oW4xYhJ+NvE+RjnOp0ISAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GgIuQ772; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45600581226so32788955e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752577391; x=1753182191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CQ3KsY7RuJMCeoFmZ+VPC2LvIrEx59LTT+bBZVmw8v0=;
        b=GgIuQ772O7XqHT7/kEP4jCyB4XbZ95KV87VBSuJYJJ8uleFmdyYIxuciotl9fpDT8P
         KbmLLK/oAS50UwDOMRd5/C9C+sFhhBZXspJcETy5k+kLonqOuHwHc93YsHMIeuV3fHBM
         +pgJgWDT4+cgktKVMdu/5uzjU/gwT2Z8nx5NZWP9XbtLgbywn40jdok4I09arE+TsW+I
         ZK1pBpgsfIF9xd56CVIyjq+XEPLRXoz4pfYEuNCPEKgvJIX9ZSnbLWtWU/BkHT1u0Thc
         PUb4XuUT7kh1OfbLN+VSltXYisUS43R2sY0Utzi41OmHGNilynbegLmm6PowSzggVzG9
         PCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577391; x=1753182191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ3KsY7RuJMCeoFmZ+VPC2LvIrEx59LTT+bBZVmw8v0=;
        b=to5z0UuVL9u6bIa21fN80iRXdWkNmgl6aH0eegzUNW6kqsREbIvLjiz9Si04U8bnRG
         wcffm4m6agXV2/ninQdzGprUpey3YbEVwE5WziO621E+hPJrJdthfxolRRJIscjwjbSr
         obOaK5srrnH+ZzPO0JKepizOb9og7jDUaoaZJNeY90z/C9NYYyKvc6+b4uhhexZUPH4v
         C8Xo0qD5Gq1n+eZujh36sxStfEVGfAjnRQo14gBoUaj8b/Qqv1yZNBwJW9qUgKW9D+b3
         L2RmHyhUPn5E/NDaW00ktM8C7Pe8tce4iS5Dz7TG4urIW5cuaP+qmxSP4kJr2jnjBGPy
         fDbw==
X-Forwarded-Encrypted: i=1; AJvYcCUoSFrBgGMvCMZF8HunLxO40VojsShUQ3osQQR1af4qlxp+YYoO5DJQT/Gpa5Eb/pHClLQm6LhRQ1GcLRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr9hH73SXCVJHCZPYMEEQgf+t27ppCFXDNhW7NKL6Oyn5+EXHl
	gzxkJ2JojHMN5ybLdBN4SaHGEq1ev1U5jIRd+kPWMysRH1zlOklXqkYpDfnNuW7udlM=
X-Gm-Gg: ASbGncupFwkVZ9KUH7jPNNvpMdltv431jqBMVlX2J5Gjc1uRzzEthcMUUpMBErdhBi/
	BcaCTMmqpv6Wt0/40vJefxNqMkQbJenbn55xDUvHb22kPTDdqvZKt+oS7u5YSg3n5UvPyYcwlv/
	ZAgH3msHQpCEnS7XrgaXnEee3cJ5u+alsdQTBSbBa+fuqD3ksYOwV00ZSCyemRZR3BMVC5qXZgm
	u2eK16pMkhOtqI2u8GK0kE1rirfKNu+C2i9QpW6kiexdcyOVYYwGMaUtuoQrCVP8dABqufsWEj3
	FIOqJ8l/M7X2838kUmmPkFpPlGmMlwVrBx4s12QGE9OoxJ+NurVjtL9GskSKr3jC7hqgfkusfTV
	LuMrugJdO9jkEodgfCgHWnDaboyrErU9zjQQQIVrPmr15Poq08gcpAKoQ6hhx
X-Google-Smtp-Source: AGHT+IFT6+e+1LHPoHL9zRhZjHAJcWyBIubOz9pyvb5+t2eyC4mO5maHD0gKqNkv9qAY4Y+9Ky5qRQ==
X-Received: by 2002:a5d:4291:0:b0:3a5:8d0b:600c with SMTP id ffacd0b85a97d-3b60a145bc0mr1397391f8f.3.1752577391366;
        Tue, 15 Jul 2025 04:03:11 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc9349sm14634243f8f.45.2025.07.15.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:03:10 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:03:08 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Will McVicker <willmcvicker@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Donghoon Yu <hoony.yu@samsung.com>,
	Hosung Kim <hosung0.kim@samsung.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Youngmin Nam <youngmin.nam@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add module support for Arm64 Exynos MCT driver
Message-ID: <aHY1bPeEMXycbKjR@mai.linaro.org>
References: <20250620181719.1399856-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620181719.1399856-1-willmcvicker@google.com>

On Fri, Jun 20, 2025 at 11:17:03AM -0700, Will McVicker wrote:
> This series adds support to build the Arm64 Exynos MCT driver as a module.
> This is only possible on Arm64 SoCs since they can use the Arm architected
> timer as the clocksource. Once the Exynos MCT module is loaded and the
> device probes, the MCT is used as the wakeup source for the arch_timer to
> ensure the device can wakeup from the "c2" idle state.
> 
> These patches are originally from the downstream Pixel 6 (gs101) kernel
> found at [1] and have been adapted for upstream. Not only has the Exynos MCT
> driver been shipping as a module in the field with Android, but I've also
> tested this series with the upstream kernel on my Pixel 6 Pro.
> 
> In addition, I verified that the Exynos MCT module cannot be unloaded on my
> Pixel 6. This is due to /sys/module/exynos_mct/refcnt > 0. So if you try,
> you'll get this:
> 
>   root@google-gs:~# rmmod exynos_mct
>   rmmod: ERROR: Module exynos_mct is in use
>   root@google-gs:~# cat /sys/module/exynos_mct/refcnt
>   9
> 
> Thanks,
> Will
> 
> Note1, instructions to build and flash a Pixel 6 device with the upstream
> kernel can be found at [2].
> 
> Note2, this series is based off of krzk/for-next commit a15edf91668b ("Merge
> branch 'next/dt64' into for-next") with [3] on top.
> 
> [1] https://android.googlesource.com/kernel/gs/+log/refs/heads/android-gs-raviole-5.10-android12-d1
> [2] https://git.codelinaro.org/linaro/googlelt/pixelscripts/-/blob/clo/main/README.md?ref_type=heads
> [3] https://lore.kernel.org/linux-arm-kernel/20250602151853.1942521-1-daniel.lezcano@linaro.org/
> 
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Donghoon Yu <hoony.yu@samsung.com>
> Cc: Hosung Kim <hosung0.kim@samsung.com>
> Cc: kernel-team@android.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Youngmin Nam <youngmin.nam@samsung.com>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: André Draszik <andre.draszik@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-samsung-soc@vger.kernel.org
> 
> ---
> Changes in v4:
> - Missed the "v3" string in the previous series for the actual patches
> - Re-generated patches with --base a15edf91668beefdb5171c53fa698c9b43dd1e0d
>   for kernel test robot.
> 
> Changes in v3:
> - Rebased on top of Daniel's timer modularization prep series [3] and
>   krzk/for-next commit a15edf91668b ("Merge branch 'next/dt64' into
>   for-next")
> - Added owner references to Exynos MCT clocksource and clockevent objects.
> - Dropped #ifdef MODULE conditional section in favor of just using
>   module_platform_driver() which will properly handle setting up the
>   of_device_id table based on if the driver is built-in or a module.
> - Update commit message for patch 2 based on John's feedback.
> - Dropped DT change from v2 as it was picked up by Krzysztof for CPU Idle.
> 
> Changes in v2:
> - Re-worked patch v1 5 based on Rob Herring's review to use the compatible
>   data for retrieving the mct_init function pointer.
> - Updated the Kconfig logic to disallow building the Exynos MCT driver as
>   a module for ARM32 configurations based on Krzysztof Kozlowski's findings.
> - Added comments and clarified commit messages in patches 1 and 2 based on
>   reviews from John Stultz and Youngmin Nam.
> - Fixed an issue found during testing that resulted in the device getting
>   stuck on boot. This is included in v2 as patch 5.
> - Collected *-by tags
> - Rebased to the latest linux-next/master.
> ---

Applied, thanks

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

