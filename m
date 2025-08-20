Return-Path: <linux-kernel+bounces-777929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF9FB2DF54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07A85E3A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CFE26E6E3;
	Wed, 20 Aug 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSAtgG48"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2D26F45A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699863; cv=none; b=EKK5ja+GY7DYArTCxt13Zb+izhFTZBf8aXX/EeXFdJsEhNpIYzpJEngFaQnuEz+LOlCvlObV6s7Ruvf5Ge+qbxGnL/CZoSLgPFkKDpdCtUP0Y8FBYWOE8ReDW4xFfgp8P0NSX4ZceVXm7fQYwiOCg8ODM7hV6+prHCkSlZFeRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699863; c=relaxed/simple;
	bh=sFi3nf9189XWLnFEh/REiiOkLpKIbqzYdFnw+OHRV5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfScBYaf/1rC4G0aATi6oVn4RiAracEaNBx+OaiP4SlOvmC2C/pH3uicUuEiadMJ47CIrXZgHaGQT4DbREc4sw9qptpKqx8oZThujAODz7UKuMtXFX5XvjlQsENVUscIS9NinLDTOJbZzZYCFbNj45oGGGSIxDpWA6hp4CZQEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSAtgG48; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3bb30c72433so2282917f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755699859; x=1756304659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6J3bLH3lxnU1wq9lp33HkB5R033P8bBP3qGJYX3dOFU=;
        b=xSAtgG48PKBy95ArEEWEcxVz4ZURUxS7CUoYlLh1gSHkslwCFuYyWTK+MW6WLGeO9I
         YaCOjhORGwWWYqNK/PA9v24IVQr2T/vNaeRf66G3eiDZoGjNGzi6MxNeVHWKL78BAMjn
         3fMbuqR302CJg4kVX5bX7LxQE9DYbbqTeJeLYnIMdoj8MT2T0/8672Y+jxL3JLHyS5ZW
         G6MtBlqs2dR5yFyZemlH/MMopDXZWAylKgf9ukfIHoS1O9FJbv7WLV8ZiAYlii86qTIX
         SKh9xuavjf12jmU3+XOgpQt0TIFu8JigmTS+B4JcwEqWntFpidDUrG70iOuvC2v0KZ3H
         tP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755699859; x=1756304659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J3bLH3lxnU1wq9lp33HkB5R033P8bBP3qGJYX3dOFU=;
        b=oA0rBmpIDeU0VIFnTurrOiYST7wdQwmib2Ceo79U7q1nhGNymLgvmUVo9wCvXFeQdf
         P7p1MF1/0PixeTuBMQlCJGOMLFHT0XhRwwknp1JxJfVO0JLSpcuKs3AqjUFkr+MQy005
         wM63Tc+2rZLKRZ9RbopRLlXnC5dTNLejAYWYYQlfPRUUvmQq2STp9EnJ74YCXF5yEbJI
         +arEzxoYCUuRjOXIUv+sFpZUYxYhia3pyLp76zM6ihYemhDCz9ULZhOBfkEZSAYhQKdb
         pKXbnaqQnTYuuCkKZtkhFHlLDnk4q6uxoyhkUYqlyHzbs9DRAOahCbC628weU0hdmU4j
         eRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFpgndjapscFCMN4t2NZtwgFwtUuDIxfduUsl1LCZ3TiMcVSYqZ8eCQqmDVYryGu5EYXjw543HUZq01ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgs7m2Qckf1gELh1yrwb503N6bE6lL+lUVVWey4WQD17BxjaB
	7XaO3Uys92ywaflCkOAiYyDR6GZsj29Jd6EEmETWZ26d8XOA+nl7cJWIQ7GOGF02OKc=
X-Gm-Gg: ASbGnctk8/Ug929MUml/aZ3fnCPwmplxKWeiYO5eQrnSLadq5vEnf3iYMx+yg4v2g1/
	o8f5CQqz1qb4J5MJRABKlQw9LOwsX7PEW5vYvCeqLr9LAtsInC+Ro6SYIonOucD7B5kT9Py6hkG
	jMEX52DAUMjrD70xrkjUUHnVGx7hbTGj/q0u/bIAGLv3/SUuk/bA+RpM6VgO/maTBm814QuoTJi
	tNoj/j4zzn4r5cxjxOov5BEWSugUKw7mLys+Z4g7i74gRq5rOvloXk2HFqk4s84byyVjX/yq1FZ
	90r6qjONc2x8TD4JMzXEGaMOOOStUGMGh4l56mzlD/MHR43JWRv0cx/VKTaNGdqOYJs4eORwEoL
	DN/tAxqyj0dXpHcGsUP0EK1bXe5I=
X-Google-Smtp-Source: AGHT+IFnea2n21+kS1N+9kldwzmLDXovzHwkQ2dtRizVAVyYeiR3u+rellXeEys1h8pnuViATD2x5w==
X-Received: by 2002:a05:6000:4007:b0:3b7:94c3:2786 with SMTP id ffacd0b85a97d-3c32e2294d9mr2203490f8f.34.1755699858694;
        Wed, 20 Aug 2025 07:24:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c3a8980ed5sm2231742f8f.16.2025.08.20.07.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:24:18 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:24:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Juno-r2 WARNING kernel time clockevents.c cev_delta2ns
 clockevents_config.part
Message-ID: <aKXajiHqhhkFeV4a@stanley.mountain>
References: <CA+G9fYsYVuEpL5KnYdq4ciRmpnUMQqkNQHmy7y5XvUm48kjxyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsYVuEpL5KnYdq4ciRmpnUMQqkNQHmy7y5XvUm48kjxyA@mail.gmail.com>

Hi Sudeep,

Could we revert commit 1fa3ed04ac55 ("arm64: dts: arm: Drop the
clock-frequency property from timer nodes")?  We're still getting this
warning on our Juno systems (with admittedly ancient firmware).

regards,
dan carpenter

On Tue, Jun 10, 2025 at 12:48:18PM +0530, Naresh Kamboju wrote:
> Regression while booting Juno-r2 with the Linux next-20250606
> the following kernel warnings found.
> 
> This boot warning was reproduced with juno-r2.dtb and juno-r2-scmi.dtb.
> 
> Regressions found on Juno-r2
> - boot warning
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
> 
> First seen on the next-20250606
> Good: next-20250512
> Bad:  next-20250606
> 
> The suspected patch that found between tags is,
> 
> # git show next-20250512..next-20250513 --
> arch/arm64/boot/dts/arm/juno-base.dtsi
> commit 1fa3ed04ac55134063e3cd465b41aeb26715e52a
> Author: Sudeep Holla <sudeep.holla@arm.com>
> Date:   Mon May 12 11:11:32 2025 +0100
> 
>     arm64: dts: arm: Drop the clock-frequency property from timer nodes
> 
>     Drop the clock-frequency property from the timer nodes, since it must be
>     configured by the boot/secure firmware.
> 
>     Cc: Liviu Dudau <liviu.dudau@arm.com>
>     Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Message-Id: <20250512101132.1743920-1-sudeep.holla@arm.com>
>     Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi
> b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 055764d0b9e5..9ccb80821bdb 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -10,7 +10,6 @@ / {
>         memtimer: timer@2a810000 {
>                 compatible = "arm,armv7-timer-mem";
>                 reg = <0x0 0x2a810000 0x0 0x10000>;
> -               clock-frequency = <50000000>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges = <0 0x0 0x2a820000 0x20000>;
> 
> 
> Boot regression: Juno-r2 WARNING kernel time clockevents.c
> cev_delta2ns clockevents_config.part
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Boot warning
> [    0.000000] timer_sp804: timer clock not found: -517
> [    0.000000] timer_sp804: arm,sp804 clock not found: -2
> [    0.000000] Failed to initialize
> '/bus@8000000/motherboard-bus@8000000/iofpga-bus@300000000/timer@110000':
> -22
> [    0.000000] timer_sp804: timer clock not found: -517
> [    0.000000] timer_sp804: arm,sp804 clock not found: -2
> [    0.000000] Failed to initialize
> '/bus@8000000/motherboard-bus@8000000/iofpga-bus@300000000/timer@120000':
> -22
> [    0.000000] arch_timer: frequency not available
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:38
> cev_delta2ns (kernel/time/clockevents.c:38 (discriminator 1))
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.15.0-next-20250605 #1 PREEMPT
> [    0.000000] Hardware name: ARM Juno development board (r2) (DT)
> [    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.000000] pc : cev_delta2ns (kernel/time/clockevents.c:38
> (discriminator 1))
> [    0.000000] lr : clockevents_config.part.0 (kernel/time/clockevents.c:499)
> [    0.000000] sp : ffff800082923cd0
> [    0.000000] x29: ffff800082923cd0 x28: 0000000000000400 x27: ffff800081650000
> [    0.000000] x26: ffff80008292fcc0 x25: ffff800082425888 x24: ffff8000829343c0
> [    0.000000] x23: ffff800083210000 x22: 000000000000000b x21: ffff8000823cf178
> [    0.000000] x20: ffff800082433880 x19: ffff00080021e240 x18: 0000000000000000
> [    0.000000] x17: ffff00080021a400 x16: ffff00080021a200 x15: 0000000000000100
> [    0.000000] x14: fffffdffe0008a00 x13: ffff800080000000 x12: 0000000000000000
> [    0.000000] x11: 0000000000000068 x10: 0000000000000100 x9 : ffff8000801b50f8
> [    0.000000] x8 : 000000001dcd6500 x7 : 000000003b9aca00 x6 : 0000000000000020
> [    0.000000] x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000000f00000000
> [    0.000000] x2 : 0000000000000000 x1 : ffff00080021e240 x0 : 000000000000000f
> [    0.000000] Call trace:
> [    0.000000] cev_delta2ns (kernel/time/clockevents.c:38 (discriminator 1)) (P)
> [    0.000000] clockevents_config_and_register (kernel/time/clockevents.c:519)
> [    0.000000] arch_timer_mem_frame_register
> (drivers/clocksource/arm_arch_timer.c:1319
> drivers/clocksource/arm_arch_timer.c:1580)
> [    0.000000] arch_timer_mem_of_init
> (drivers/clocksource/arm_arch_timer.c:1653)
> [    0.000000] timer_probe (drivers/clocksource/timer-probe.c:31)
> [    0.000000] time_init (arch/arm64/kernel/time.c:62)
> [    0.000000] start_kernel (init/main.c:1014)
> [    0.000000] __primary_switched (arch/arm64/kernel/head.S:247)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] arch_timer: cp15 and mmio timer(s) running at 50.00MHz
> (phys/phys).
> 
> ## Source
> * Kernel version: 6.15.0-next-20250513 to 6.15.0-next-20250606
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: 4f27f06ec12190c7c62c722e99ab6243dea81a94
> * Toolchain: gcc-13
> 
> ## Boot details
> * Boot lava log: https://lkft.validation.linaro.org/scheduler/job/8309469#L622
> * Boot log: https://qa-reports.linaro.org/api/testruns/28679128/log_file/
> * Boot warning:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250605/log-parser-boot/exception-warning-cpu-pid-at-kerneltimeclockevents-cev_delta2ns/
> * Build link:  https://storage.tuxsuite.com/public/linaro/lkft/builds/2y4wgEvmeoVH3Vr528M4YN2OBXY/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2y4wgEvmeoVH3Vr528M4YN2OBXY/config
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

