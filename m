Return-Path: <linux-kernel+bounces-886539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDCBC35E02
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 350FE4EDECB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F85320391;
	Wed,  5 Nov 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mx64VC6r"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52551219A79
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349949; cv=none; b=jaayBd7Ik3LI52xCS/VdhqFJoplhxRDi5pxkytMB4SI/Q/KHWgwNubPwVH01FgQ/fUGxwJSAlX9A+30OaQT6t1nyFHkmefpzU0Ov00amEgPXMxA2X9pDGx/+6ImyVAIduMRA+59oQhi4AGXEQLH7gdlOBXw9b3cEfhD9pRTxYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349949; c=relaxed/simple;
	bh=BGqp7fuaN5rkahToSmVacRA+It78AyVXFuEWPNijJ3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fb3gpvyQ6TjxPoJu3R2mRQ1NRDwQJUUUUlTi9Vn83f8nRiFwSfFyGPP0Cm3yTJMTniYW0iBeSqTvPEEsyukaGwSVJ1+O4sNSS+l9Lc0WuRSG2BMRhAu4IsoNLEwlbA+yOmqWtlZJz+fi4/Z8PE1phzbfK+PFL52crjmzJQVfjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mx64VC6r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775638d819so9728915e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762349946; x=1762954746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5c0s6jzH6DNdjZwxjg0HQcfL4kHz/qPSecYRBzUTjsY=;
        b=Mx64VC6rSIH/h3wnXaZiAbmIPVwm4RKdZo8qCerWQHD67IT1GRBHSTil31KbboW1d4
         uv2DUd5chbFjKrK8B76o8lxJvZEoCVlyUCKttb0x4PSDyYbnHLOJqIov7xcVdo4jZSjq
         YIXzkMxxBxkABP8GKsHLMvR8xEv6ebOj2MVKEdo82avv2zkEgDCZPV5Z6nLGyBraJR7M
         w1VC7l5b4uAorALEM6eOvQjVPaDyH+gXrBGe58HkVpDtsn9k0qrMoHWi2Xd8YSaBE2rs
         eBqBtEKVw+ZST6M26LeUJAZODv0BgmKeCNvNrBQES8re3C3ukSH+s5FJeP616X4T1zUs
         Vqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349946; x=1762954746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5c0s6jzH6DNdjZwxjg0HQcfL4kHz/qPSecYRBzUTjsY=;
        b=PNwqdzQVHbisbfr0O7uMbv7DIh2qpmwhp6i+W/RbfTKZXHSG2rwXtrNmAfvfsWZuYa
         592cL3R8p0DTncyEynaGdvW2qEYhO2MIWWlgHbCBPESbv26AYKoh3wOIHP2i/vWJaTUC
         6ZVA0uiNKISu8SSex+WhicHK1tWmWpSDAnpzHDbqR68D0eeaVLqQ7dLwz/JKAM7sLqZK
         LvTMQ8ZGVr06Gj6xa0d15vyBKzS8zbvhrg80TWP2H73p8pQMt9hdgCyHrlxGk1fHs8LI
         5JgeEOWveNWEuBPhv/qc7iE8wqkuadXqk3Rst+AQq3IwIDuosT+NGxV2sH9d9v8wfzcC
         pWxw==
X-Gm-Message-State: AOJu0Yzof8G+ggRvgg1i9EQG23hfML6KGzG8LGwQuAnGFSHKO0VpdFTm
	GxdenlZKLodOqOTEGMyvy+PCYpJlto0zy9xvlwHeZK2Dw1i2SaYKZMRI/y+uOW978YY=
X-Gm-Gg: ASbGnctS0CL/9x5MmomlNOmKCE1WNRhMms9KkHv7sMcxjHFTYFs5oljzhzwCyV14y7f
	GLCNrYpxB121le1saVIh3FmfF4L9Td455IfG8l8hOj/HXTXk7rlfYPPtQxnDkSKexbJMtXYt+qF
	F7P9LWHkyV1UjhKkclQeG3jx/u+DVgGXmlKOaGE8lZ871AykFGbblKNEq74xC5G0hjyaw3tIPKg
	RyU+Sf9sKU9otODZGGcQWmT0fOmclwpbibKaZWBltdYt88SG5dzjaGZ0uPdWb7pr/jzGGeM3lnl
	lslB/JJuyuZ6TeWjLkwLnApcWAD/IttZRqlxFv50AJX84YfLnc7wa7Lyy2jVecYlsEf8R9vW3Q1
	hgLGG1QoMA8LW0ptHeb7i5tPBVVyNoPW0+DNlVn8aztsum2wzmmuN4aE6oT6/NaQoMkpwIFWUD2
	ZipobHgBg7+H5yFWdjdG16Eug5SLalDcBFT0UB
X-Google-Smtp-Source: AGHT+IGHjGXKTBvXjYsdAgd2DGs4MwDedfxKcBaZTJ3xRVtrpo6hlAIkPobI49tSQYYjEcJ/uAFNvw==
X-Received: by 2002:a05:600c:8b88:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-4775cdf54d6mr33861275e9.21.1762349945601;
        Wed, 05 Nov 2025 05:39:05 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc1a850fsm10883887f8f.20.2025.11.05.05.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 05:39:05 -0800 (PST)
Message-ID: <fa9884d8-fa2b-4f8b-8fb0-97f4a276c9c4@linaro.org>
Date: Wed, 5 Nov 2025 14:39:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: ralink: Fix resource leaks in init error
 path
To: Haotian Zhang <vulab@iscas.ac.cn>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
References: <20251030090710.1603-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251030090710.1603-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/25 10:07, Haotian Zhang wrote:
> The ralink_systick_init() function does not release all acquired resources
> on its error paths. If irq_of_parse_and_map() or a subsequent call fails,
> the previously created I/O memory mapping and IRQ mapping are leaked.
> 
> Add goto-based error handling labels to ensure that all allocated
> resources are correctly freed.
> 
> Fixes: 1f2acc5a8a0a ("MIPS: ralink: Add support for systick timer found on newer ralink SoC")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

