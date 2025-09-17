Return-Path: <linux-kernel+bounces-821231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98486B80D10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40753B40B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641A2F8BC8;
	Wed, 17 Sep 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQKQuJ6R"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C11F7586
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124847; cv=none; b=Y+Do7IYxazSZB5Y6LzHSVbQJCv2X54yxmB7Oe6vaYCwYpF7Z+DsQiQnwpyp8FdnOABKMxFAiX16PgZkLCRPIlSL8E+2B1A/2jCYPdTAChfvGxGXMi4IH2WV89xLOlxg5496/X54gtaXKBB7QI4zEKlyjcgB2bbPHBU4r0n+c70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124847; c=relaxed/simple;
	bh=cD8Exi9brNnwxk4CGKeXJrxi7EGyVg5EqzWVR/Kg8Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TK9NwVmJpFh9sDP8i3WecRJH8y/FbDpHW4L7UQP6W5hMEdKSaBlloL0yZoNUSQ6nDhFkzfAMNtP/kWORcBXZzN1f2cdhrhsv+EduRrxUmBBNDEUn0gVXZ5rcwBlt9clJj3CmUv8mvm3tcEP/H9wQWV1SaLsBqqsDAHr3P2vwwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQKQuJ6R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dde353b47so41652305e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758124843; x=1758729643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HY9GNBVfaU78Zi15MsrUTaDwBhrAZLVfvMeIDTUq1Hw=;
        b=FQKQuJ6RoaFh0NBw04BAER1eDn8/B/d3aXvHiIcrMP567EAVqeL5h/p5uTY40cn3p+
         QsRJJxqQBVBF+Ho+/ukpgNOY4KZhI3nL8nljrEahkHPjKUQhc9RAWpA4jxvvOp1o+cII
         yvqpeLgvNm24aElS63KhSTtxKY024eJ1tU39Bt+pGVwr8eZ/z8NNVQHmGz1/0kTbLqrJ
         k1lBK7ZgmTWaXxDbqtsvvFImkAJZ7Ewj4lM3q8kC+P45f29cPdM3XL8xOh8+S1ulYZd8
         4omqP5EiJL9GkzSr3FnYSyNpqe3kks/srzL9nE/ObcUmu8VG+9KVU6euEmbYe8FNZb8j
         vqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758124843; x=1758729643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HY9GNBVfaU78Zi15MsrUTaDwBhrAZLVfvMeIDTUq1Hw=;
        b=JVq8h7zsimB7l+dQZUpng2RcOT/itXyP0VZ3vJUmmGc3emE+/wSgnQFzWm5wkY5sqQ
         HV11CuKu4I0gOguMGnwL0Xkz3v2RElRJXLYJT/8SCnN4TFwveBfdUBoVkzOwH5xxsWBr
         8l06/ZABjvirjL/I51agYIy/DBA08v8VX+jj1OThMSkR9ZmsqwA5ByVnF/x1hyL2ANat
         W8aiYt0WshWXAuLfGrlBBbUnv/oiE4fGQShWD6bo8qX4KeZ3SQjoYFjBgACWGBgVZjCl
         lLjMPlbevyrBYKXWTPmCWbxdjn2kVcvEHhOC5xp77cS4KENYuzVf+tmTt5IpFYWfnryO
         gWBQ==
X-Gm-Message-State: AOJu0YySPZ2+kyIrf3LpPAb6xmE1X0+kiMDeHwkKS5RBgC5XREKKyQIG
	dAfisLZmjh13KOjIN7tRavMUG+IvKZ4X1vrM5IamFEc/LJTqymwLVjXyp74D6//m1Lk=
X-Gm-Gg: ASbGncvIVkm7VWLe+5cwo+qP/OKtWtTXgm83c+zr1zKHGgnsI/95t3yUCxKukNr/kpr
	uVbO3Q0QGcceAoikolgBTTHnq7SsBtbEHDIeuzGboSlrtDN3Cff0DvfI0vUoBR2aZB6YPenP11h
	haKNj8RLgH+tkDccI1SXo2uxRdqSmpsA7hUWlMZyqqJLExE+112ydMcX7zbRjFJzx6tI6651CpK
	XK04opiRGywvSqSCiSyBp2RfYvDsFE2X0iLvO+rUCTNbVabj33SateayEpZaYVdU+7DNUCilkKH
	feOHpyXO7K1IibFHpSEzK6h9c/uJEDNf1xhMrdlIgkR7bIuUBqblk0W4Gs/9UR2Fx9+fxRqFVja
	SLoAEHP7EGxDNXylImQr4L6poEfFicic2AzLYKb4ic1qEMzdGh/Cx7OIlIOi1DM27lz0W2X0BlJ
	hBeg==
X-Google-Smtp-Source: AGHT+IFdvnx2MCfjT67PESjHLOuQ2Cc22/VqlqrpQACnltzQ34seZGMzHbnTe1RzS+dbz1n7h2UeKQ==
X-Received: by 2002:a05:600c:5248:b0:45b:6365:794e with SMTP id 5b1f17b1804b1-462068428ddmr30254755e9.24.1758124843389;
        Wed, 17 Sep 2025 09:00:43 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4613186e5c7sm48091625e9.0.2025.09.17.09.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:00:42 -0700 (PDT)
Message-ID: <db9c2cc8-d73b-4614-be9b-741510428070@linaro.org>
Date: Wed, 17 Sep 2025 18:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource/drivers/arm_global_timer: Add
 auto-detection for initial prescaler values
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Mendez, Judith" <jm@ti.com>, Kevin Hilman <khilman@baylibre.com>
References: <20250819-topic-am43-arm-global-timer-v6-16-v2-1-6d082e2a5161@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250819-topic-am43-arm-global-timer-v6-16-v2-1-6d082e2a5161@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2025 09:52, Markus Schneider-Pargmann wrote:
> am43xx has a clock tree where the global timer clock is an indirect child
> of the CPU clock used for frequency scaling:
> 
>    dpll_mpu_ck -- CPU/cpufreq
>          |
>          v
>    dpll_mpu_m2_ck -- divider
>          |
>          v
>    mpu_periphclk -- fixed divider by 2 used for global timer
> 
> When CPU frequency changes, the global timer's clock notifier rejects
> the change because the hardcoded prescaler (1 or 2) cannot accommodate
> the frequency range across all CPU OPPs (300, 600, 720, 800, 1000 MHz).
> 
> Add platform-specific prescaler auto-detection to solve this issue:
> 
> - am43xx: prescaler = 50 (calculated as initial_freq/GCD of all OPP
>    freqs) This allows the timer to work across all CPU frequencies after
>    the fixed divider by 2. Tested on am4372-idk-evm.
> 
> - zynq-7000: prescaler = 2 (preserves previous Kconfig default)
> 
> - Other platforms: prescaler = 1 (previous default)
> 
> The Kconfig option now defaults to 0 (auto-detection) but can still
> override the auto-detected value when set to a non-zero value,
> preserving existing customization workflows.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> Changes in v2:
> - Rebased to v6.17-rc1
> - Link to v1: https://lore.kernel.org/r/20250808-topic-am43-arm-global-timer-v6-16-v1-1-82067d327580@baylibre.com
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

