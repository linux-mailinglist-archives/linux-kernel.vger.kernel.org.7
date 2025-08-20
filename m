Return-Path: <linux-kernel+bounces-778213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8FB2E2A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B7E17A92A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309532A3D5;
	Wed, 20 Aug 2025 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lYNof3uN"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F113B58D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708488; cv=none; b=baJJM67WoZUTt8EU47MyvbmT92Utp/McSEgKxqZLUsZmmtg7qFzJa+thj2NJdaPDSSqHYeMnp8jZ35hi7hzjUpNJ5I9ZjoXaXjdTMp0hbneeU+oNwQ4tJ8dp8KZZRfiUeppTsuX/51MdDIcGakyuMi8SeAsjTsrmyx7w544cFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708488; c=relaxed/simple;
	bh=RgH/5L6/kG4jZk5e39i6FIrRTIvgj6lgywSuZOJjQc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MPTxPDb4bm3IW8laI/DtO+k5iuVDYC5U5GIptPX0r0PDZHLaI8iKCxlHU8q0mKkEhGlXqcXqu9agvE+VAAHKng/CXTX5geEa1kGM5cKVo7C5AhPaa2u5nOGJ+78Pi1nrfGbHhDM0jI/VObABJ6PPcI4Vp0K1QOB1Nt96Q2qDBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lYNof3uN; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57KGlgCv3240046;
	Wed, 20 Aug 2025 11:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755708462;
	bh=1kvOQXhZjl3Riu3Bp8W5at5u0uo3ZABQvzRMmv52jOg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lYNof3uNzL6Q59bWj6aZOuMleWm9WqbNqSmV8L5pMTlj86O3vIbFuUIMZX0kE93li
	 x5y/DRvN6hY9zYIQAkbNddOG7vYOFACGjzO8O7zznij3js3p7zRbHNou553XLkaP69
	 QpeaacRHHVRqFKQTuMAbDWxFRk8psQ3TtLwnYqFs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57KGlfQq2186756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 11:47:41 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 11:47:41 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.55; Wed, 20 Aug
 2025 11:47:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 11:47:41 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57KGlfsw526664;
	Wed, 20 Aug 2025 11:47:41 -0500
Message-ID: <9315875c-3358-4f56-b99e-a530baa8ca0e@ti.com>
Date: Wed, 20 Aug 2025 11:47:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/arm_global_timer: Add auto-detection
 for initial prescaler values
To: Markus Schneider-Pargmann <msp@baylibre.com>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Patrice
 Chotard" <patrice.chotard@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20250808-topic-am43-arm-global-timer-v6-16-v1-1-82067d327580@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250808-topic-am43-arm-global-timer-v6-16-v1-1-82067d327580@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Markus,

On 8/8/25 5:35 AM, Markus Schneider-Pargmann wrote:
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
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Tested-by: Judith Mendez <jm@ti.com>


Thanks for you patch, it also cleared the noise on my end
on am437x board.

~ Judith





