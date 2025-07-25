Return-Path: <linux-kernel+bounces-745502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16343B11AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C322E168F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1592D1925;
	Fri, 25 Jul 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SD/jjRqS"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C62D190C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435701; cv=none; b=TqAYODaHHeFW6B/D7TGENqr3yqYdxs0vSRcQmq1qxgEJD7zcexfMXo9IoisQsfCXEyjleKtHP/lS4yhgwbxF8tcOof3RF5rQ3UbCyybOUqgSHvicJXXGe9OPbvCAQu8fETszSjFqnTlnfB0R1SdtURkdf6u+Iy9PQPU4Y11SmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435701; c=relaxed/simple;
	bh=Z8tg1pzRmanQT9LGpennwEt2z11fOoPYQhIqsiV9w3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AdBcN5FcnLLJjtgg//44Zmi31dpRsxjg0lLlSjAtSxacFt10p3l2++aeeQCRHltRCDtFISlJ4aXQq8N4QYdyrA5Rkd5EbksCkL9strLdnVwdp8ci4ov5U31mt6gYN+wheKZgWFBkNoc3kp4P7cIsV+ToDRGVEY16qpXBlmwLolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SD/jjRqS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455b00339c8so13100555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753435698; x=1754040498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sPxG6yqZoSGKmuHcBvDbXuEQ79jKCTtksMME9UcXBk4=;
        b=SD/jjRqSjUImeIGRlCNOM0GwpniW9bdMOtptWhubDjr2hX3YY9ahRRg4/WK60x+fUY
         s+7E5Xl6UTUEWc8GSHExBEeSJZOA+kbl2hdaVQJCDzbJT3JCeW/v2b5CQOxR+UUz4n0+
         DYmOZufZSsexcSqHUX6dkRToViAsD5mQ1MJ1d8nkwTMHng6rG6pp5keYtlBdxxK9ymLF
         v85b/tk72yhwg0qIWoTeFu3RCx/mZ4Hjb8q4wRlyZnkHTX40KPA01onQm4Bq2YuAk7Nx
         m5TF0C/d8FgSbHN4OIQPvY48dDVUyCHznRGOpCIMc2wwP5XLYmk5zWtn3eIGDVuVW1eF
         UBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753435698; x=1754040498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPxG6yqZoSGKmuHcBvDbXuEQ79jKCTtksMME9UcXBk4=;
        b=PltAM6BqyCF0w/PgkcDDtAQyQ1KI++Y4lgJM9xu/Jwq/ECGEhQcvVCEIq+0y5WYYko
         kPs8i52oUGYCOGq+AKHC+4AtX2t9CWOpTDMprNW4wXRyqhaBeiWv9t1I7SGuSVORQHER
         MAI0bB2HrbCymATK1VllVnOyyrXZ6a6tdhCf5N/zzJlStUdyR5tVRFdV7GYpDvAhkILy
         LMydUEHm4CiMlPqWfVHXoV+lAHukiYjnbHnd1OXaenhb7JhB31h+zQjw881xeWF3sd73
         QCEHtAfdbwhP7oRn0fHAb8v0l4yk9jb3bnyGIAQZq/4zfb3V3jZa5mWcEBqClEdt5ijn
         NQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUTHz4DhHDed6PQrMPnHgwBvKlOQeitWfp3LiqIg5HgtUVYekOGxTKkpUDZyVcQmJc6zWZ4EPTaEhYhMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ForjBJ8MS5Ocw2a9smtCirBn1rAhGc7pJaejf039kfxOZF9k
	evtY5T5AKUA6GdnJGI3Osg6WpT0sl4uABx0siSFTzuMFBLEcG1aAKpjtnUVFdhNwLN0=
X-Gm-Gg: ASbGncs3tA3NC7g8pKzRBqmBpZsel2gdCOyMusR6SIfXrEAE9B08OCCBucpUehfWnOh
	o5v/Gb38v9vCF6R3FZcI+CKvkKUSBMFXYVA2RVq+mKne4La+wsJxyyqDNDUQKpYSkQFryf1BykJ
	0Nybyf+PdzOJlveVgndgX2iPql9EXR8mMt4U7O+StA3ZTtlVrO+TMuWJq2FrlH/I0PQBBxJMKhA
	eP7Ntz70ef9tDEbMRChDyVbXtLGYPKtwlO+8nx9D5tTXM68voLPySbtD7enUT/oULXbYK4bKjoo
	0fI2HH47VZYKkstmHNFe0I6TRh03KHVbf6LaeEy1IHMA5PxLOYq6/ARYfNIUQ7BzPDEvlRxyVSf
	7fuKe8ixqXqVuYks8G5hpweujqE1o7YX/Pvywgm2151OF9cnOkoI13pNktya6iw==
X-Google-Smtp-Source: AGHT+IEeWJ8pfIjF/cY4SpBJkCsGj7FjJWr60xEqhoo9idhozX/YBHCc5KuXapjBXZszZJJIzMrhzQ==
X-Received: by 2002:a05:600c:4f0d:b0:456:201a:99f with SMTP id 5b1f17b1804b1-45876442808mr10203155e9.18.1753435697965;
        Fri, 25 Jul 2025 02:28:17 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45870577987sm49752235e9.31.2025.07.25.02.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:28:17 -0700 (PDT)
Message-ID: <63a6d253-305d-4ffd-9954-7cd665bd332d@linaro.org>
Date: Fri, 25 Jul 2025 11:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: Revert commits causing
 section mismatches
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Will McVicker <willmcvicker@google.com>,
 Youngmin Nam <youngmin.nam@samsung.com>, Donghoon Yu <hoony.yu@samsung.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250725090349.87730-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250725090349.87730-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/07/2025 11:03, Krzysztof Kozlowski wrote:
> Commit 5d86e479193b ("clocksource/drivers/exynos_mct: Add module
> support") introduced section mismatch failures.
> Commit 7e477e9c4eb4 ("clocksource/drivers/exynos_mct: Fix section
> mismatch from the module conversion") replaced these to other section
> mismatch failures:
> 
>    WARNING: modpost: vmlinux: section mismatch in reference: mct_init_dt+0x164 (section: .text) -> register_current_timer_delay (section: .init.text)
>    WARNING: modpost: vmlinux: section mismatch in reference: mct_init_dt+0x20c (section: .text) -> register_current_timer_delay (section: .init.text)
>    ERROR: modpost: Section mismatches detected.
> 
> No progress on real fixing of these happened (intermediary fix was still
> not tested), so revert both commits till the work is prepared correctly.

Please don't claim the fix was not tested. I reproduced the section 
mismatch, tested it and figured out it was indeed fixing the issue. I 
just missed the error because it sounds very close to the first one 
reported initially and I did the confusion.

The driver is not supposed to be compiled as a module on ARM32.

The option tristate "Exynos multi core timer driver" if ARM64 is 
misleading. From this change, the defconfig on ARM can do 
CONFIG_EXYNOS_MCT=m which should not be allowed.

Before getting wild and revert everything, let's try to find a proper 
fix for that.

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

