Return-Path: <linux-kernel+bounces-884840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED9DC31493
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5556E3AD852
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F38328616;
	Tue,  4 Nov 2025 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9hwvzaw"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB12E6CD5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263837; cv=none; b=MnnmWRvV92OdrvIs2+95zhjVVfBBx9VSaFj27mbbpyJkaN/hRZ+zhqp2g/PyZk1ODwMZaBlcliANjmzl2zSCMS3ftI9Wccm+yUfWPO0NBFJk7adY1W+aAQHshPxAzjXTgdYHbcm6T/8adKJoIyIbfb2vtQ/kBsJylIFVYtkJOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263837; c=relaxed/simple;
	bh=lFb4yPpZtK3Bwon0C6HzQEwc8sB9kXocdlaLUdamsf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st+nrtMjK8aJeCclfhdosNxRiOGfQJ9tU+HZ/wjyPlumfwclcox8W3lWbfY3cCCIW5bcKIO2aeVHj+33iU10xhdoxghU31cD0yeu+zJ8MrGCgMvwnnv7KgKuOFNqe8lL2qi/lppcWato+q1h1utpAZEE/9aT9dSoo2McmChxPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9hwvzaw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7864ab69f01so38268777b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762263835; x=1762868635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjiVDEb6cm0IQNwx2lZ93BPJc14dj5R/bK/BpZzo6VU=;
        b=I9hwvzawBO4KDl6ZO6louKM+uvS6N6d4rzjhWMmpIhuMK2ZDivLApkeJnEO0fbpFnf
         B40OIoh//ioyAtiLwpv78oEn0oR1LQNdPY44fn1LBwyKVijDAyuLK0ERe87143zx9ybH
         /l5oxsXUA3lib1ijp43oXr4sc5yHStcZjWmMwqXYtrhzLd3KfjZ01j4s9Hd/vE7dfqF/
         +Vn9wL/EoD2qybmetygq1gIAHhLehjMXh5+mzgpiBMSoozrByM+7kxC7a4JLFZ8lEE4S
         UDmXngdwOCALajwBdmid0wQnmdNBEkqaT1YdzX72eX4wpFOxTK6NHfSRw0dB0owxEEfk
         58Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263835; x=1762868635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjiVDEb6cm0IQNwx2lZ93BPJc14dj5R/bK/BpZzo6VU=;
        b=c7fnquxC9iu8SAlQ/xpGgDq3cXr1AgR999XaUNW0TjP8Wy6dgQVPWeTmkAPHUyqe9W
         4BSIN4Gwdgg3saTUVar2wCm5aK1IVj5zWHBMF6iEx8X1sh98HZvIfn1pSrb8KHBRW+k8
         TmrZa7paM/gLdFUVcZKfp4ty4dOYqsezKVFSfTqpNkwZVNDvtCBXVBerbpbxw8WYZe+K
         M++NPCF+OlnqLTRJZkLO79vBkKDZWP8+yPo6uIin+NDkOybRPpPWAMAFp7hmxzEOefPL
         nDfx0/WIEPuMoUFD1G5beJesWc0qIMzT3Cr0iwRwQaDe6D6Aisw2XiHigR//UePOCGXL
         dGWg==
X-Forwarded-Encrypted: i=1; AJvYcCXnQ00cBSq3jyPJSlk4jW1BTGkpTWyW59JPuOgpzafzmU14+DZWIgwhFtkcPOPPPfwTRoDkdlIfEUHe8J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7auTp0jarEAeJQRC7VgSHEDrI3aX3Qda0Rb9D+ZMQznu2zGWA
	nABpbCgK60YFk8hFDuCG07blih+dbZpfNgGjuW+Dz/Xjcptg6PRdjGwcbej3YGUqSdyhJQYHFHX
	L4dvwhv7EpGNkJjv3MBaeigkcswMICbnogPd/5Jq3XA==
X-Gm-Gg: ASbGncugwhdrREKdL5N7x1Zf2GXeKJdJxK3gBKG/ghW122xG2ilGWyMsmzx/ElQgV65
	ydk9CYFmuOC/x5IMQ2WCSImxKylvoHYA1f7A2pIPKvxXyllbexXi3kBrd99JaGMAtb6rkTlpiR7
	Q8lVyU52jOoZJkR0biN7Y33ZPzdKdLLlWF5xEJWEz7kYOPY5DZ17jRrrwIhlpRefQwsh42KmhQo
	48CT5MBHiiFS/kj+pWyXfxYtCGJKCOwgNC4F54e8PFDf7nDld481aMlvpZF+A==
X-Google-Smtp-Source: AGHT+IH+xJM5OuT+ynGz/BcB2JMNDwt+HfQJxGitdqIPsmVDhekVmNUAamUG4n8DzrZpGoHggRFap3lMfbO2RdQhyHw=
X-Received: by 2002:a05:690c:708f:b0:781:212f:b508 with SMTP id
 00721157ae682-786485533d5mr151925497b3.63.1762263834960; Tue, 04 Nov 2025
 05:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-4-ulf.hansson@linaro.org> <20251031192322.kpsy5biokvuywzdj@lcpd911>
In-Reply-To: <20251031192322.kpsy5biokvuywzdj@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 14:43:19 +0100
X-Gm-Features: AWmQ_bn-zdaH9ELfagCV1hR3Eqqv5E86xcqWdZ7QiiQHIMqA2xOLmg6yZU16JBQ
Message-ID: <CAPDyKFp8DuNE-j6Fpejgbg3+HK00RiuvbtG+Ypud4uzFBRO99g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sched: idle: Respect the CPU system-wakeup QoS
 limit for s2idle
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 20:23, Dhruva Gole <d-gole@ti.com> wrote:
>
> On Oct 16, 2025 at 17:19:23 +0200, Ulf Hansson wrote:
> > A CPU system-wakeup QoS limit may have been requested by user-space. To
> > avoid breaking this constraint when entering a low-power state during
> > s2idle, let's start to take into account the QoS limit.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Rework the code to take into account the failure/error path, when we
> >       don't find a s2idle specific state.
> >
> > ---
> >  drivers/cpuidle/cpuidle.c | 12 +++++++-----
> >  include/linux/cpuidle.h   |  6 ++++--
> >  kernel/sched/idle.c       | 12 +++++++-----
> >  3 files changed, 18 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 56132e843c99..c7876e9e024f 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -184,20 +184,22 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
> >   * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
> >   * @drv: cpuidle driver for the given CPU.
> >   * @dev: cpuidle device for the given CPU.
> > + * @latency_limit_ns: Idle state exit latency limit
> >   *
> >   * If there are states with the ->enter_s2idle callback, find the deepest of
> >   * them and enter it with frozen tick.
> >   */
> > -int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> > +int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > +                      u64 latency_limit_ns)
> >  {
> >       int index;
> >
> >       /*
> > -      * Find the deepest state with ->enter_s2idle present, which guarantees
> > -      * that interrupts won't be enabled when it exits and allows the tick to
> > -      * be frozen safely.
> > +      * Find the deepest state with ->enter_s2idle present that meets the
> > +      * specified latency limit, which guarantees that interrupts won't be
> > +      * enabled when it exits and allows the tick to be frozen safely.
> >        */
> > -     index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> > +     index = find_deepest_state(drv, dev, latency_limit_ns, 0, true);
> >       if (index > 0) {
> >               enter_s2idle_proper(drv, dev, index);
> >               local_irq_enable();
> > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > index a9ee4fe55dcf..4073690504a7 100644
> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -248,7 +248,8 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> >                                     struct cpuidle_device *dev,
> >                                     u64 latency_limit_ns);
> >  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > -                             struct cpuidle_device *dev);
> > +                             struct cpuidle_device *dev,
> > +                             u64 latency_limit_ns);
> >  extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
> >  #else
> >  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> > @@ -256,7 +257,8 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> >                                            u64 latency_limit_ns)
> >  {return -ENODEV; }
> >  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > -                                    struct cpuidle_device *dev)
> > +                                    struct cpuidle_device *dev,
> > +                                    u64 latency_limit_ns)
> >  {return -ENODEV; }
> >  static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
> >  {
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index c39b089d4f09..c1c3d0166610 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -131,12 +131,13 @@ void __cpuidle default_idle_call(void)
> >  }
> >
> >  static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
> > -                            struct cpuidle_device *dev)
> > +                            struct cpuidle_device *dev,
> > +                            u64 max_latency_ns)
> >  {
> >       if (current_clr_polling_and_test())
> >               return -EBUSY;
> >
> > -     return cpuidle_enter_s2idle(drv, dev);
> > +     return cpuidle_enter_s2idle(drv, dev, max_latency_ns);
> >  }
> >
> >  static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > @@ -205,12 +206,13 @@ static void cpuidle_idle_call(void)
> >               u64 max_latency_ns;
> >
> >               if (idle_should_enter_s2idle()) {
> > +                     max_latency_ns = cpu_wakeup_latency_qos_limit() *
> > +                                      NSEC_PER_USEC;
>
> This is only taking into account the new API for the
> cpu_wakeup_latency_qos_limit, however what if someone has set
> cpu_latency_qos_limit, doesn't that need to be honoured?
> Just trying to understand the differences in both qos here and why one
> is chosen over the other.

cpu_latency_qos_limit is for runtime only, during regular cpuidle idle
state selection.

The new cpu_wakeup_latency_qos_limit is taken into account above for
s2idle, specifically.

That said, Rafael suggests that the new cpu_wakeup_latency_qos_limit
should be respected for runtime cpuidle state selection too, so I am
working on updating the series to take that into account.

>
> >
> > -                     entered_state = call_cpuidle_s2idle(drv, dev);
> > +                     entered_state = call_cpuidle_s2idle(drv, dev,
> > +                                                         max_latency_ns);
> >                       if (entered_state > 0)
> >                               goto exit_idle;
> > -
> > -                     max_latency_ns = U64_MAX;
> >               } else {
> >                       max_latency_ns = dev->forced_idle_latency_limit_ns;
> >               }
> > --
> > 2.43.0
> >
>

Kind regards
Uffe

