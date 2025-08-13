Return-Path: <linux-kernel+bounces-766693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86EAB24A15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FC6883666
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3545A2E610E;
	Wed, 13 Aug 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyD1dqBL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E61C1AAA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090047; cv=none; b=AMRALHJQQ7Er1Oea5sA7CA7ZO+9xGYH8n9KOEhUn1aLRmpXpEzWJpN22pyml8DWUfsQI4ikydXFgqc39p5O8fZP6hxoQDrNnBq9Jq9136Lh/Hw+zotVVY1pszvKvkL8AfDYKe2wkZ95fiQN6xuZbtsGPskG4J0DqmI28Su5mQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090047; c=relaxed/simple;
	bh=Eacqepwje0vml54GTJE6PC8bZ+Y6sjD1UPdztT0uh8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlBPjywymdrU6eOoDQTR9TtsfvWJL8uBuqpMPYW5kVuf9UWDB/CE6FeZJB76xHaeFnRERoZkCu1SSgNaBmNaXwmZQnj+JstHHZMndTuPEeA1WVVvF0kwqOCWSfLrzTSOlV10iEj40VNP+rL7goRnGRF57dZhWGliNqX3Nwm1PsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PyD1dqBL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78a034f17so5027800f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755090043; x=1755694843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeR748Kqcp8Ecn+7OwBivcVoxs7eFxEnihqMB/P4pQo=;
        b=PyD1dqBL1ISMEX5Obq1wtEvKtjoI4qB2GC0NQzFTa9jM1+equLntZaK4Z9lHAJFAru
         uMoDU8B8PrS/tP+7gnR/lhUXVSbmWUcA/t24SjFGCNOsWzwMNudrFFAdAK1ojwk2e6Fj
         cR4bUrfQ062JgC12Wz+iLbUKBFocyBZj7k622jItMYu+bIUZezefOnEmPo3suzDhQg1C
         65NNYW0JZKpuRUVDurSOqbNfAChF9GbXk5QSYi/kWK3EUHT2LReBQ7z2OM8NLAJcCZv1
         pBRTp32XbCaPUPB5EYeddoJOfqw4OF+tElNtzHq2kl/xcDHajO2fJU5BL/J6Kjja+jYu
         ZSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090043; x=1755694843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeR748Kqcp8Ecn+7OwBivcVoxs7eFxEnihqMB/P4pQo=;
        b=TKfoFZX0S96yCce+wxAPjxJkSApj7SxjYKWMAVZbbx8m6iQUG0955PguChyvYI2CcO
         aUMla+ieCbjhozSY3ixQDYSmGtjDz2koLpkJPdPRMZJoScQNDtbh0l+XDX07N5FdUOwW
         Vx/jRaMfvNlcVs8X/CsVS3PE/PDgCoDqXVh5vpL1VxNGvkSD7er5Of2yo6HSvMFnvKeG
         Y/DlSWGj19fWEf71n+D32uri9lo5X5wDPslIqHKUj/8y8PeQQRr2QuD+BIQonVsSKT8j
         u2t568uRp9M7vl9kwywPGOsVhEgEPHzcvK4sKTS4jpMuEGRrgiEr5oqZ9LexVI/CQgOG
         ULoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq8yEy/LqjIcDvpZjZHnH+Phe+ihK3O+B5aTXBLP5BQ8Fk+pwhnoYGKFuj4RGh4gxjUBWTR87aoaASkSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFYUekqOesQ9KQTD81K7xVr59j9jprHyANMh3VD/DoC//nHG7
	OUeAB6Af2c5ATZCPFCFrpaZKn3Z+fnBbnavHhpqVJsJ8zIRrHkiyXPBVl/AVjHb/gOw=
X-Gm-Gg: ASbGncvPRQlYk2LPSO+4Y0cxqUmRLrTpnVf7rSCLr1TxH/2b6VdYJ5aO+uzyhp/nkuX
	l7TApBtwyI6zg9GUEVdFFU2hSY8/ESegiKZlilktiKaGtGoO6FwVXqZA7iGl927UI9J8Jok5tZ4
	VlNElMs9htJvYD/kIqmBuMdTlDX5b2earbu5fyZsvrqlRbMs6ph1s3Ug9DoCSd7CIKwR5DF6Uxk
	KHWCi7V5akdIH+Y8tCZ+FU77cL2TGatelczrSPtb5PzzQAnuqMXy7Y5urRvQyQDJXx9kbvTDSxK
	jRKZReOCuGPpWBzpZGV4UKUT3M3T5kEa9CcdS9X5nFAfRrT/YgL+V1eUwo0GPfOP/rcrWv0APaz
	ino1SFmakIPY6oCtiQtvO4lAxVYKZYdQsGF4OZxGVbFuMD4QChuM54uS1t7sPBA==
X-Google-Smtp-Source: AGHT+IGVgvf1Uge8sHIDUuFP1oPvQwNSsudB+wr24LhPfVIfTvW2P80/tIqYbrFHm8v3paEcs2k0Bw==
X-Received: by 2002:a5d:5f95:0:b0:3b7:8dd7:55ad with SMTP id ffacd0b85a97d-3b917f14804mr2270522f8f.39.1755090042622;
        Wed, 13 Aug 2025 06:00:42 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3abed3sm47465915f8f.10.2025.08.13.06.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 06:00:42 -0700 (PDT)
Message-ID: <5a4e8480-a291-409d-acc3-f053d4e99981@linaro.org>
Date: Wed, 13 Aug 2025 15:00:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Setting the scene to convert the timers into
 modules
To: tglx@linutronix.de
Cc: Jim Cromie <jim.cromie@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, Nam Cao <namcao@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, John Stulz <jstultz@google.com>,
 Will McVicker <willmcvicker@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Saravan Kanna <saravanak@google.com>
References: <20250602151853.1942521-1-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250602151853.1942521-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Thomas,

was this series dropped ?

I'm not able to find it in v6.17-rc1 but it is in the master branch of 
the tip tree (v6.16-rc7)


On 02/06/2025 17:18, Daniel Lezcano wrote:
> The timer drivers are all compiled-in. The initial pre-requisite is to
> have them available as soon as possible in the boot process. While
> this statement made sense a long time ago, the platforms have today
> multiple timers for different purposes along with architected timers
> which are initialized very early. For example, a timer can be used as
> a backup timer when the local timers are belonging to a power domain
> which is shutted down, or used a watchdog timer when the counter are
> shared, or also as a pulse width modulation counter. Another use case
> is the platform user may want to switch to a timer different from the
> architected timers because they have interesting characteristics in
> the context of a dedicated platform (eg. automotive).
> 
> In some existing drivers, there is already the code to load and unload
> a timer driver even if the Kconfig does not allow that. It means, the
> need is there but partially upstream.
> 
> There were multiple attempts to configure the timer drivers into
> modules but it faced the fact that we were unsure if it is correctly
> supported by the time framework.
> 
> After investigating deeper in the core code it appears we have
> everything set for the modularization of the timer drivers.
> 
>   - When a clocksource is registered with a better rating, the current
>     clocksource is swapped with the new one. The userspace allows to
>     change the current clocksource via sysfs
> 
>   - A clocksource can be unregistered
> 
>   - When a clockevent is registered with a better rating, it becomes
>     the active one
> 
>   - A clockevent can not be unregistered
> 
> A timer driver can be loaded later because of all the supported
> above. However unloading is unsupported because a clockevent can not
> be unregistered and that will lead to a crash.
> 
> But if the timer driver has the module owner set, the core framework
> will handle the refcount correctly and will prevent to unload the
> module if a clockevent is registered. All the refcounting is working
> in different use cases.
> 
>   - A clocksource is the current clocksource, the refcount is held
> 
>   - A current clocksource is switched to another one, the refcount is
>     released
> 
>   - A broadcast timer is registered, the refcount is held
> 
>   - A local timer is registered, the refcount is held
> 
> Consequently, it is possible to unload a module which is only used as
> a clocksource. As soon as a clockevent is registered, the refcount is
> held and can not be released thus preventing the module to be
> unloaded.
> 
> That mechanism ensure it is safe to convert the different timer
> drivers into modules.
> 
> This series adds the module owner in the different driver which are
> initialized with the module_platform_driver() function and export the
> symbols for the sched_clock_register() function.
> 
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Nam Cao <namcao@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> Cc: linux-tegra@vger.kernel.org
> Cc: John Stulz <jstultz@google.com>
> Cc: Will McVicker <willmcvicker@google.com>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Saravan Kanna <saravanak@google.com>
> 
> 
> Daniel Lezcano (7):
>    clocksource/drivers/scx200: Add module owner
>    clocksource/drivers/stm32-lp: Add module owner
>    clocksource/drivers/sun5i: Add module owner
>    clocksource/drivers/tegra186: Add module owner
>    clocksource/drivers/stm: Add module owner
>    clocksource/drivers/cs5535: Add module owner
>    time: Export symbol for sched_clock register function
> 
>   drivers/clocksource/scx200_hrt.c     | 1 +
>   drivers/clocksource/timer-cs5535.c   | 1 +
>   drivers/clocksource/timer-nxp-stm.c  | 2 ++
>   drivers/clocksource/timer-stm32-lp.c | 1 +
>   drivers/clocksource/timer-sun5i.c    | 2 ++
>   drivers/clocksource/timer-tegra186.c | 3 +++
>   kernel/time/sched_clock.c            | 4 ++--
>   7 files changed, 12 insertions(+), 2 deletions(-)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

