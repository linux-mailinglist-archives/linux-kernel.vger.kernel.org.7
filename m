Return-Path: <linux-kernel+bounces-629682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E1AAA7013
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 12:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE86464E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 10:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89930244685;
	Fri,  2 May 2025 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIoKqBSK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBE2417D4
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746183119; cv=none; b=eoAXdPCNLr0eNR440jz3ZTvsrHcCLMQSXpkw+aw/CeX/cLEZV/pwZVBoxH2NRegdD92E7fPRHRA0rJmJGv9CnK7PV8PkvXb4JKlm4j15dA5hIbSoIq1iUG5VmWF/aRj6WFmr4OMy2EC9eGcZlX3vJdAwzG2RAJ7s27jMu8phw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746183119; c=relaxed/simple;
	bh=0uPHl+JKsAOJ9sDRh8lKshqI4ciquTUm5Xwj42FnyZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Emuuae/RLP4JqxNwSBLFP0N/AL1SLDDm0SIbIv4+GP/NpMJqYI4D5aWM47vPQ5Eyxhbf0Vu3s9QMpbVu7KCrlYTj6XNZHHbyCaSqjbdmZnxust71bR1m4kT2krNX+CIqGWYzmCfDqHKf7pZ4FpoUKy65uJxwmEBr/6v/huW1o5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIoKqBSK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso11387035e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746183116; x=1746787916; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aRdXs5rbhlDN2keohW+Yxv/pOyDwK0v6kHn5yhxOBCQ=;
        b=LIoKqBSKLVHEr2RA4zwNREMNg80Id2AI8IyX5vjoGk3TeOPLT3eqUqcGKJTEM8StgS
         D4TNGAvhLDPS+5aEprtXIQvAr1Y6MwzgCLLV1PAFEv1NnMmIBSGWu5MENq1CaBGMFbZa
         DY+zujf+6HXIO3v1wy0lkSgDyDBZ/bqMqFejpXGvoyTOEtR8S6eNCfmGA6XRoWmvfQKB
         jdKlHF1x3C6O4L1elYsgtYF50MCntuoruwBD6074uOpNb+qyUEMzPwwexrJ5Ir5Vgonb
         xP4GCtMp0mnBYJVJ3KlJ0g2LsM9l91lzZB3OCov7XRDfJfgw2reonEocyF6PUlu9Wa5l
         blaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746183116; x=1746787916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRdXs5rbhlDN2keohW+Yxv/pOyDwK0v6kHn5yhxOBCQ=;
        b=JXzatfMQfwANQ7F05crLbgtXYs3QrQ55TN6bizsqXxeVHFbWGsuNyYqI1slOsJ+Y7i
         f60Fp39GMHUFcDFncEFjYWlY4dFaDWY6kab8o2nhnegY64DPels9nFIACGmwn9j4TTzQ
         U5FKVqN6drf4AXvDqU0WaEEd+x9rcYUrxCriOQqJvoQ5BdsPvps1Q6QNmR/sPKsRgMHI
         MopNOosbpgtoY9V6KBhqrzamM3TtSEhAAz9v7JQZHtOUecSdWjNyRPHUvf4dgpQ4u/P+
         0w5AouJt52/Acuy9f7ZoY7WJmYeR12VSW2myDiFKmzBjjqN3oY3ZmrGQfKr5StQoivbJ
         O37w==
X-Forwarded-Encrypted: i=1; AJvYcCXe68hTztXUWLtX7LJqyt9oVIoy951GMun3Dg+E+rWtE64/cT+jMDs1bSh3GSuFKfF8fqmvOmCeuEbKM8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZAVbKL3MXmuC7Cc0cZyTdEaCYvCUlIHbs0mcKQPIPO39iNF8
	wkW8iAQqKOhupXjwxgYNsuDDsL9oyX1VQwcGm2OkbLz2sxTdCZJewM4lp8hwnmk=
X-Gm-Gg: ASbGncufmGlB7BICPFHyTlx2gWT77E2Lcx5+6COJHoPjC2jvprcITyugq4irvvozKSr
	yGQMfDMV6z0n07SQbg2Mqf1fG372OfTklu8N/SXJB3Z6h8OjEuFWKzGYouUaNgOwICe/j45DHeE
	rBik+q+ZfFCz54Z4Zrb9WQiiOxhSB+63jiDfELY8hqDnFfGBxIMJZzmPNM4qqNY8+2l66owtOJX
	tY53HN4RahOna/aDy+Jmw5VKeqYBIETzmNiA66UQJgukOcTOa7KmMDNwFyzwLVCHep3OHoxBzLX
	zUXoS4CS5MAoQXxKDxAcEcPUrxF7wPcUXXB1ooxL+trUolGCpyEGs56p28yZKbirT6gE/VYIyvy
	T1Lg=
X-Google-Smtp-Source: AGHT+IFRnGNbLPkos0AOjKBTxhwusA6Jdyu+EXTCwoVRh0zl7lML0HixTtNT14lxd6CpT8T/JzkcOA==
X-Received: by 2002:a05:600c:8218:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-441bbec1835mr18848105e9.8.1746183115889;
        Fri, 02 May 2025 03:51:55 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ad76a2sm87172035e9.6.2025.05.02.03.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 03:51:55 -0700 (PDT)
Date: Fri, 2 May 2025 12:51:53 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Robert Lin <robelin@nvidia.com>, thierry.reding@gmail.com,
	tglx@linutronix.de, pohsuns@nvidia.com,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	sumitg@nvidia.com
Subject: Re: [PATCH v7 1/3] clocksource/drivers/timer-tegra186: add
 WDIOC_GETTIMELEFT support
Message-ID: <aBSjyZJ0__ctBa-4@mai.linaro.org>
References: <20250502043727.396896-1-robelin@nvidia.com>
 <20250502043727.396896-2-robelin@nvidia.com>
 <aBSOJTlQUUnFIEVr@mai.linaro.org>
 <af0e0ab4-89d5-4f77-86c7-90d2bc3e13dd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af0e0ab4-89d5-4f77-86c7-90d2bc3e13dd@nvidia.com>

On Fri, May 02, 2025 at 11:16:17AM +0100, Jon Hunter wrote:
> 
> 
> On 02/05/2025 10:19, Daniel Lezcano wrote:
> > On Fri, May 02, 2025 at 12:37:25PM +0800, Robert Lin wrote:
> > > From: Pohsun Su <pohsuns@nvidia.com>
> > > 
> > > This change adds support for WDIOC_GETTIMELEFT so userspace
> > > programs can get the number of seconds before system reset by
> > > the watchdog timer via ioctl.
> > > 
> > > Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
> > > Signed-off-by: Robert Lin <robelin@nvidia.com>
> > > ---
> > >   drivers/clocksource/timer-tegra186.c | 64 +++++++++++++++++++++++++++-
> > >   1 file changed, 63 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
> > > index ea742889ee06..8d5698770cbd 100644
> > > --- a/drivers/clocksource/timer-tegra186.c
> > > +++ b/drivers/clocksource/timer-tegra186.c
> > > @@ -1,8 +1,9 @@
> > >   // SPDX-License-Identifier: GPL-2.0-only
> > >   /*
> > > - * Copyright (c) 2019-2020 NVIDIA Corporation. All rights reserved.
> > > + * Copyright (c) 2019-2025 NVIDIA Corporation. All rights reserved.
> > >    */
> > > +#include <linux/bitfield.h>
> > >   #include <linux/clocksource.h>
> > >   #include <linux/module.h>
> > >   #include <linux/interrupt.h>
> > > @@ -30,6 +31,7 @@
> > >   #define TMRSR 0x004
> > >   #define  TMRSR_INTR_CLR BIT(30)
> > > +#define  TMRSR_PCV GENMASK(28, 0)
> > >   #define TMRCSSR 0x008
> > >   #define  TMRCSSR_SRC_USEC (0 << 0)
> > > @@ -46,6 +48,9 @@
> > >   #define  WDTCR_TIMER_SOURCE_MASK 0xf
> > >   #define  WDTCR_TIMER_SOURCE(x) ((x) & 0xf)
> > > +#define WDTSR 0x004
> > > +#define  WDTSR_CURRENT_EXPIRATION_COUNT GENMASK(14, 12)
> > > +
> > >   #define WDTCMDR 0x008
> > >   #define  WDTCMDR_DISABLE_COUNTER BIT(1)
> > >   #define  WDTCMDR_START_COUNTER BIT(0)
> > > @@ -235,12 +240,69 @@ static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
> > >   	return 0;
> > >   }
> > > +static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device *wdd)
> > > +{
> > > +	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
> > > +	u32 expiration, val;
> > > +	u64 timeleft;
> > > +
> > > +	if (!watchdog_active(&wdt->base)) {
> > > +		/* return zero if the watchdog timer is not activated. */
> > > +		return 0;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Reset occurs on the fifth expiration of the
> > > +	 * watchdog timer and so when the watchdog timer is configured,
> > > +	 * the actual value programmed into the counter is 1/5 of the
> > > +	 * timeout value. Once the counter reaches 0, expiration count
> > > +	 * will be increased by 1 and the down counter restarts.
> > > +	 * Hence to get the time left before system reset we must
> > > +	 * combine 2 parts:
> > > +	 * 1. value of the current down counter
> > > +	 * 2. (number of counter expirations remaining) * (timeout/5)
> > > +	 */
> > > +
> > > +	/* Get the current number of counter expirations. Should be a
> > > +	 * value between 0 and 4
> > > +	 */
> > > +	val = readl_relaxed(wdt->regs + WDTSR);
> > > +	expiration = FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, val);
> > > +	if (WARN_ON(expiration > 4))
> > > +		return 0;
> > 
> > Each call will generate a big warning in the message. May be simpler
> > to add a pr_err() with an explicit message.
> 
> I prefer the WARN. This should never happen. If we do change this, then
> dev_WARN() might be more appropriate, but I think that this is fine too.

The function tegra186_wdt_get_timeleft() is triggered from userspace
via an ioctl or sysfs. The documentation process/coding-style.rst says:

"""
Do not WARN lightly
*******************

WARN*() is intended for unexpected, this-should-never-happen situations.
WARN*() macros are not to be used for anything that is expected to happen
during normal operation. These are not pre- or post-condition asserts, for
example. Again: WARN*() must not be used for a condition that is expected
to trigger easily, for example, by user space actions. pr_warn_once() is a
possible alternative, if you need to notify the user of a problem.
"""

I understand it is important to check the return value in order to
have a consistent result when computing the remaining time but that
should not trigger a warning each time.

[ ... ]

> > > +	/*
> > > +	 * Convert the current counter value to seconds,
> > > +	 * rounding up to the nearest second. Cast u64 to
> > > +	 * u32 under the assumption that no overflow happens
> > > +	 * when coverting to seconds.
> > > +	 */
> > > +	timeleft = (timeleft + USEC_PER_SEC / 2) / USEC_PER_SEC;
> > 
> > Did you check there is a macro fitting the need in math.h ?
> 
> I had a quick look, but looking again, I see we can use
> DIV_ROUND_CLOSEST_ULL() here.

What about 'roundup()' ?

> > > +	if (WARN_ON(timeleft > U32_MAX))
> > 
> > s/WARN_ON/pr_err/
> 
> Why? Again this is not expected. I think that this is fine.

[ ... ]

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

