Return-Path: <linux-kernel+bounces-886760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6370C36777
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B804505FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46913218B8;
	Wed,  5 Nov 2025 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKwA9SZ1"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EC258CD0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356981; cv=none; b=B6Nh/l21RpMxaxCvr90XhJL5qm/nbo9L5m3CK2OJmeibENs/zB6HRAaCU0O7N3PDaMPrXM1Y1ecZyytt6a6AnX/G8/l7C/NzE70fdsajQ69VyFVsexA+zpUtvTnKuwP0exAZ7ffe4qCjIzPfovZ/cifCFRduFhAtT5aGf63dRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356981; c=relaxed/simple;
	bh=h6IY44+n9svW+bU+6obg1JzZFLK66f2qfn9IWru+JoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECAaSRrTnjkeAis9WWEA/prz37ljgKqca0gsPtiW8YdE/SlJufUKVnih0JUajgHjTqYIB7Yj5b85JcVHVZeHLjwyJn9V7EaRTs0xCa2gXI8SpeuceEZRwwmXQBzcG8ydkOpqipKVKVYpZA8RaEWaSYALt1+RUzgH82x3ScTZmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cKwA9SZ1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so3577222f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762356977; x=1762961777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlm+t7ywPqSKVErvoumWaf2NiXRnADmmBeAkOgqc8tM=;
        b=cKwA9SZ17wKgofWuP+eHT8cciozVLGMh5l3Ay/r93mWAeqR3zIYFWFS1me6sJLYjVF
         x6lzRmvO6CJgYMY7AOCPeNvwOg8eG7+jaLdEx9fQDHMuhBTLI2UDUt4qiSBY2rKrBHqa
         sBp6XTkSVduu/At8L97nBXBwXudLu1NLE6CCzfm6nJEJxciTZqBrUH/A9jwvjwTwNXXc
         BoyaeB/DV6cA11oAvt4i7PlzADUR8MCqVJm+pnO+yoiNRUaFYQoi/W5iZvVyTh/BunAw
         diGHe744CH4u+a15oRtTMFbvWXGKbv+Qi28McBbl+vdSvWPLDvebRoFOgb/7iAva1/DW
         8xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356977; x=1762961777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlm+t7ywPqSKVErvoumWaf2NiXRnADmmBeAkOgqc8tM=;
        b=cGqX9y+G6ITokOZs+/xoGFj2YV1FHvNncT1RVvUqV7cBwPxukm76cNHw+onpuMSifz
         WGW7VtxmA5ssz8jV2apYJ3JvS7scW0SxRUY8XbXsXveV7OEJHPb+/9Ykw5b0mtf6WWgl
         cP5tGLF2MWa+T9SHI0cp5Xbj3mS0yybhZl1drarkr5+ErVsa2FghN/jesqHJ6HsYzft+
         DaAgu8H44Lje41C/CkiNj0Eh24v7M0lfqv8k6+/h4Q6dCDwXLnlQwk2vrz4fz9yZQb+6
         12hSRjqwkd0ZKe0CYO/bj72AabQuY0kg4bee77vRNWLiwkCvwVFDN2WH3R6bcJvJjzyo
         gmRg==
X-Forwarded-Encrypted: i=1; AJvYcCV62BrCVr+Ny/XJcXXrfa4BCb5WF8GAlUCwVDyz59xKlzQs9TmxNd1PnLAcwOV7An9L1iB9OAkid3EktRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWoWM9/006QM+VZufCHTm7bKx1AfFNGgd9FvHyT4cBexoamqh+
	lkE48fqK9TZNM81oe6b7qiaCNgi3FSUaKU4sWmWU5zHJ2iv+3SOmH/32Kd2GAEMi2cE=
X-Gm-Gg: ASbGnculksLus+jSVjhG5GyYMhW18ZV5Ck+ppq8ZDQ+HjTqR38U8eCPf/0n25vTC6gA
	60JlWjx4UbRa6+FCDtOZnooa1Oqbo9s04VrUGEtAdA57CAggXSEBMv04+bF5B1zFMU9MCMqsvEt
	LI27aeetL3quKk29yppY2dfElP7fQF/SlbXv65Tl58FjaxR4qr92JDje/fXktL2kz0BYnRFBZTp
	B6dPcq8/w+Fg5UQ6b7eQimgTZCGZfvmWFeKjcvLcNFW5YgXQwppLPpgNIqgxE10PjVUyEUwUQe2
	+cz4SVjGc7cDj/iaZgH6px7zYUj7QMhJ1voXWzZi/9BHWEB2/kPGTh9sgZmLRtfbTBja6B8NUpp
	a9YJnxD7UMpXxE4tdCKCi4JsaaEKYLK6/TwxmEIcuv6AVdnexaSGhxAEtLJqbzewJTSFLd2fChx
	ujqDt/pomR9+DJvbg1EI9stuCVMhsiI0x8hYgp
X-Google-Smtp-Source: AGHT+IGc9Sr28tzgsM4FYJTg13n93hwv53wS3yAGxhmgy8eKjduRfr7nJLFOgLBuJ91Z09L6XqZX5Q==
X-Received: by 2002:a05:6000:4212:b0:429:c7b5:ed9f with SMTP id ffacd0b85a97d-429e3333311mr3850220f8f.63.1762356977489;
        Wed, 05 Nov 2025 07:36:17 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm11645493f8f.34.2025.11.05.07.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:36:16 -0800 (PST)
Message-ID: <c07ae384-4042-43f4-b876-7207b72260f7@linaro.org>
Date: Wed, 5 Nov 2025 16:36:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource/drivers/sh_cmt: Always leave device
 running after probe
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Thomas Gleixner
 <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
References: <20251016182022.1837417-1-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251016182022.1837417-1-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/25 20:20, Niklas Söderlund wrote:
> The CMT device can be used as both a clocksource and a clockevent
> provider. The driver tries to be smart and power itself on and off, as
> well as enabling and disabling its clock when it's not in operation.
> This behavior is slightly altered if the CMT is used as an early
> platform device in which case the device is left powered on after probe,
> but the clock is still enabled and disabled at runtime.
> 
> This has worked for a long time, but recent improvements in PREEMPT_RT
> and PROVE_LOCKING have highlighted an issue. As the CMT registers itself
> as a clockevent provider, clockevents_register_device(), it needs to use
> raw spinlocks internally as this is the context of which the clockevent
> framework interacts with the CMT driver. However in the context of
> holding a raw spinlock the CMT driver can't really manage its power
> state or clock with calls to pm_runtime_*() and clk_*() as these calls
> end up in other platform drivers using regular spinlocks to control
> power and clocks.

So the fix is to remove PM management in the driver ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

