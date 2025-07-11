Return-Path: <linux-kernel+bounces-727629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D845B01D44
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5652D16DC06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0488E2D322D;
	Fri, 11 Jul 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjnmRR8t"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86929AAFC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240118; cv=none; b=qhVAXrSxalbXSujCquDfe7nq7mM6z9+La7782WszDKfu8U3MVbghddck5O+/FBShd8VYQw4YFL7VfMSBzaxwzVamomn+I5zysKisl6uDbHacDac+sGKhRlIbpq1oRLQZODQQA5p5xXs6Ey9sh9cGnvHIuNGKGIloa8aLIpdvkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240118; c=relaxed/simple;
	bh=8jLN3VZCDWiz300MGRDmfjBkchE7cBbAjFIEj2bshrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWk9VgPxITV/CBF1pQrleftqMyhKEEJip4lvWg1/34v/RKcCsrhRPMWUsEvDWjQPUi7PZVxqZ7xSd6Bdm66jgptOc6mJsQSO9Ubg+fsVgWe4hQhUAtfxRyg290Ah3iIocrs67ltI2xIdtNlRrrX6h0sZP0qmtWNLdwQpwyuDHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gjnmRR8t; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso3992152a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752240114; x=1752844914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSqbWCx5pmMJhs42gMdWbuhtuhEPLEOyZUmlt10BWP0=;
        b=gjnmRR8tJHmoSIIdteeVixY1RzopS8+WN0DLdzTUi5dT1wO69iEfs2Ssk72qvVo1Jq
         Bmxb96Wan5dn03Q5Ab1RJmDXiCwEzTrH7Va9cGEvZaaiMgcududPBDNP+S5oUAyC7d9z
         eKTUMYKTbVD+6dA0OvDiBzX+9hm+Pz0JFAaqoocudrHLorT1OlEKOV0XKxC0xFQj+9Ge
         6G3Cli8P6I3K3gatWQMj4UU2q4O3WyMPf+woGrUzAS6ngTz100Ws2JvHXjxyXzl1zn9Z
         w8g9fpG/RD7DPUGNf/y0fF0dOa9C6gPhZunxEvrhWuCZW/L8DjPcwKenGt0QNjP7Y4+Q
         rzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240114; x=1752844914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSqbWCx5pmMJhs42gMdWbuhtuhEPLEOyZUmlt10BWP0=;
        b=FAwGCVS0SG8AfyejQTqqzD09ivaKftcI9tSXXTuGHT/IrV1nOBOkrqbwKJw38qaZew
         OZ/i0w/Y/kc3PVEznnMvfvb88d5tPwVBMUqvW5uQ4/WfvlM2+eRqwakUc/tQM5xqpPsa
         4byo+IgVJfmxvLt5ck2YGPSvB6dEHNOfNHCGZ6URliGuVTjLq8thek4Za8aTqE0LuKSj
         wZpE8UKOQaEcMeUjplV5VejO8zRzlVxHDvPSmTBCsO/jt6S0vCqJiXuNCCkN/GfI1L1J
         6Zw6+N1mEbt0pH8dU86AyfivIKUO4u7UzlWXBLIgXva0swOVp237aFY9NIIJjMPrzlST
         /0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnuldkz6lqoxLHYAzZ1pAiE2fOvS/u3p/fGKSG/LE0Z0PMb4dWRNDAmazFUBannEy7hLc/AcP5s5n1Tvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYjyxpxLEAV8VByYF73v8iNCjoJgLm6C6xKM9Vlx63fW0TVj/
	kw6cgW+J3JZH9e/VKEN7Q37NaOb+0yPZOxU2xna+en9R6uhEYPprrL6fZgbzYoSGj8o=
X-Gm-Gg: ASbGncs2f5W5MkC76y7ZsW2uagfzL25EARAiL6n+OoB++5Lhvna34TIVrNjF7KulcDs
	Tgy8GrMLpKi5Y/vfEvifKzUDpvMavdmlSUHFp+rH1izxgYVg05ulAx3Lc29MogCpZzA/nkD+U81
	9XNlaVLJk0t6aZ5nzQNnQt0sgzjzCFUFmdsrL3PuKhGNjyTCHboadXK/58EjTPlIEnZD23b6HnO
	r2SSSIwOnmhrLLddUBNoVo22oAz+qoi0LiBkAjOBOY8F28axDhQIvS9sBGwcs8H2IHwWV7XSyCp
	EBqzSu1c/tNFyPmggp/L+OmBIsLq+nSVAOi6fVGcyems3JKrV/Br+66BOdHdo22IyE0LQQRHg/y
	xxePTSbqiIpHxvmiblYIt0PLzNCeSL/QW
X-Google-Smtp-Source: AGHT+IESlM3QZpNn5nGs57f0DHmGN/JSKJJfdYT4k8FVbPsu+vncRpIcT3st+meVCcFx31rG3EVMcA==
X-Received: by 2002:a05:6402:26d5:b0:606:c48c:fb8e with SMTP id 4fb4d7f45d1cf-611e7655f5fmr2860534a12.11.1752240113639;
        Fri, 11 Jul 2025 06:21:53 -0700 (PDT)
Received: from [192.168.0.251] ([188.27.143.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976f41asm2174574a12.63.2025.07.11.06.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:21:53 -0700 (PDT)
Message-ID: <b3de1e2b-973f-4b4a-83f3-6015808b3772@linaro.org>
Date: Fri, 11 Jul 2025 14:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM: add kernel parameter to disable asynchronous
 suspend/resume
To: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com,
 rdunlap@infradead.org
References: <20250709-pm-async-off-v3-1-cb69a6fc8d04@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250709-pm-async-off-v3-1-cb69a6fc8d04@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/25 1:31 PM, Tudor Ambarus wrote:
> On some platforms, device dependencies are not properly represented by
> device links, which can cause issues when asynchronous power management
> is enabled. While it is possible to disable this via sysfs, doing so
> at runtime can race with the first system suspend event.
> 
> This patch introduces a kernel command-line parameter, "pm_async", which
> can be set to "off" to globally disable asynchronous suspend and resume
> operations from early boot. It effectively provides a way to set the
> initial value of the existing pm_async sysfs knob at boot time. This
> offers a robust method to fall back to synchronous (sequential) operation,
> which can stabilize platforms with problematic dependencies and also
> serve as a useful debugging tool.
> 
> The default behavior remains unchanged (asynchronous enabled). To disable
> it, boot the kernel with the "pm_async=off" parameter.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> Dealing with the pixel6 downstream drivers to cope with the changes from
> https://lore.kernel.org/linux-pm/10629535.nUPlyArG6x@rjwysocki.net/.
> 
> Similar to what people already reported it seems pixel6 lacks proper
> device links dependencies downstream causing i2c and spi client drivers
> to fail to suspend. Add kernel param to disable async suspend/resume.
> ---
> Changes in v3:
> - update documentation with "pm_async=" and "Format: off" (Randy)
> - reword documentation to make it clear "on" isn't a selectable option
>   for pm_async because it's the default behavior.
> - Link to v2: https://lore.kernel.org/r/20250708-pm-async-off-v2-1-7fada54f01c0@linaro.org
> 
> Changes in v2:
> - update the documentation and the commit message to describe that the
>   "pm_async" kernel parameter provides a way to change the initial value
>   of the existing /sys/power/pm_async sysfs knob.
> - Link to v1: https://lore.kernel.org/r/20250708-pm-async-off-v1-1-1b200cc03d9c@linaro.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
>  kernel/power/main.c                             |  9 +++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..06beacf208de3242a3b4bb2413ab6cd3e0083f15 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5000,6 +5000,18 @@
>  			that number, otherwise (e.g., 'pmu_override=on'), MMCR1
>  			remains 0.
>  
> +	pm_async=	[PM]
> +			Format: off
> +			This parameter sets the initial value of the
> +			/sys/power/pm_async sysfs knob at boot time.
> +			If set to "off", disables asynchronous suspend and
> +			resume of devices during system-wide power transitions.
> +			This can be useful on platforms where device
> +			dependencies are not well-defined, or for debugging
> +			power management issues. Asynchronous operations are
> +			enabled by default.
> +
> +

I just noticed an extra new line here, that checkpatch didn't catch.
Please let me know if I have to resubmit, or it can be amended
when/if applied.

Cheers,
ta

