Return-Path: <linux-kernel+bounces-755253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7450B1A3A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE921889C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202C45029;
	Mon,  4 Aug 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwIsjIN3"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29526B2A5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314908; cv=none; b=L47zrpCUt3uRHM7YdWqTJGWAgZI4Jo2e35RKveoPhwiDgvPhreYL1HDFGgCxfHmeahZ0Gh37hDM6kwzHazYGLXu5/eysMAoVgkggZqvQr/aqspZAEj2iCDogMydHdfyjJOuyyn4RQAAfHFiKnA4+xrzJxx8xcyTIaJv17LwLmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314908; c=relaxed/simple;
	bh=l0w9LTq3nxpNLofNSQvPns8jfPBpB3DXhsHLD/Wnnm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3GdOdPyPqZrWKuqJrLTOs/udw1sIypz2Sjisg6FBUMCMN1RvzfojrmoJO8kqq3rpZ4FVlBYUn7OEXmfPypOZXlkd04GR2BHXuwxTdhG7gB9RTmnWB3wGBfCVeWwUr0Gxd8fSOVM3Hpj8PUZ3Kt3E0a3v1JhmAh12oPMy4Rjlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwIsjIN3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af96fba3b37so139434266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754314904; x=1754919704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wG3bWWNoyezaNlH593nDv63NxvsrvfP1is3XEB/K068=;
        b=mwIsjIN3m64t6C6Tyi0imYWHdAl2/h5oXuHvCm8vr7qVvJa4S82pVDNHnVxjVAapkx
         oU19zzs5QIBvc4eJ/mUJem7FBd0Nm7Y2cCjCfLNOeajLh7gmdTE0VWANYmOBjQ0gVFzZ
         /LfirwwvzP++NcpcH40ziL61pjUcnaIK6ndT2jp3buqwLDFmmw8P3nA4MZLQaepeaZM1
         EzMCJHM3B6x1DjgbisDZkV7NdZ2cEE0x/KyqSCyd23AIBzT1pWgWx+fJaSwFUtc/ipKq
         +9PX3kq0BKaenq/9E4Kz8if1D1Vx0xkMEPhWY9o4Jc4gUKpzAtPr9K4lYdHyeZx5ljEA
         dNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754314904; x=1754919704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wG3bWWNoyezaNlH593nDv63NxvsrvfP1is3XEB/K068=;
        b=uSzvNWeBHw23A0aKrFIHcrfMfYeTBSpVZ35SpaDDPnesIaDO5Jve8Y8hQMELtMzzI7
         QSL/1mltIDI1A7yMjqTime8hJSI/RVjNy+IRfAsnQQqg6M+uN7xZFtqPqRhix4CVv0ye
         kwENRvrNQxDqE6JhcnEEWrviTcfrUdDebx85F8Vs2dEFQxnLi0szPuBbOzBsQl3GfQaB
         U7/GT7+smLItgRvQUbo8YbvfL6RwtGj1oCkh+UwsqCi5G05VQy/e5IcsRFbRd3Ev8R2r
         u7HSCHfKavqDZcDWalriS9GSgvNLoYWrKDb6q9PI71iWCzuZbnratu7XWTd3hNpShPmO
         31Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXscvU9mWb5Yx7aeQ8u1rwLSGAvG3Ixq1oyJWxfo9BWFSSMkgLd542MuigSSShm+iZ76EGBxa44+sYOBe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgvF9AYciNMYObP5/e993XN3oLh2DTlvdYeMl+2epsa+s+3J3
	RKEqosKHysbEk7Bs7nrr1zBZU8gjt6at15xNQ9zw/14ngVo3yO8XjkG0CS45qQ85tJKx9WZSqcw
	d42k8Zj9XkNIeCsXBy14mfWGg6gXLomt+HPH50dWNJg==
X-Gm-Gg: ASbGncvM7VlyIZeNaM0jCyGM7O9lwWUvMh5Oobl33RPaG84nvWUetVmBeA5EClU9Waf
	MEjFKh5wtTPMpXu25pFFWn22tsm0Frcib4JlgdObafSSvaH99RVhW7I3YE7UoTIWEBvf/c4Twa7
	IQU/bfUgt0ytYsjADxt28NsP1H9pOBEW1MRi+90WEjS7rQrvPCLhmbNrB063aelOqMmK8SSAiMW
	lv09I20lXZq+yM+HzpfQpjmer9eLwCv4ANWqPNS7/GX0AQ=
X-Google-Smtp-Source: AGHT+IESrWFAHDwo5kNZ03foClcZhqP5hAG108r3+ygBQ/PsbdMyWesXe6fbU/MbdWUE23A6rUIYxKQcgrRSH7Fu2N4=
X-Received: by 2002:a17:907:3f99:b0:af9:24e7:1c85 with SMTP id
 a640c23a62f3a-af9402225cfmr1221198066b.55.1754314903825; Mon, 04 Aug 2025
 06:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626093018.106265-1-dietmar.eggemann@arm.com>
 <e89b250a-7e9b-45fa-9e81-fc071487078b@arm.com> <CAKfTPtAwy1ZFQ=-t7SbbDuHj6ZJPtB3pJS6fZxt=1robLwvXjg@mail.gmail.com>
 <16b728e6-6fb9-48eb-8160-73c4ace229d2@arm.com>
In-Reply-To: <16b728e6-6fb9-48eb-8160-73c4ace229d2@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 4 Aug 2025 15:41:31 +0200
X-Gm-Features: Ac12FXwWOW3XzATspCSMiAAw8_TBtHWvCLIrlnZ929Z97HfBLJqceHXRFnl2CvM
Message-ID: <CAKfTPtDXRKt8zOe7XTG8L037myS4DBr+4FXfLEeF2Ai42=s+8g@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq,base/arch_topology: Calculate cpu_capacity
 according to boost
To: Christian Loehle <christian.loehle@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	Beata Michalska <beata.michalska@arm.com>, zhenglifeng1@huawei.com, 
	Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 15:18, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 8/4/25 14:01, Vincent Guittot wrote:
> > On Mon, 14 Jul 2025 at 14:17, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> +cc Vincent Guittot <vincent.guittot@linaro.org>
> >> +cc Ionela Voinescu <ionela.voinescu@arm.com>
> >>
> >> On 26/06/2025 11:30, Dietmar Eggemann wrote:
> >>> I noticed on my Arm64 big.Little platform (Juno-r0, scmi-cpufreq) that
> >>> the cpu_scale values (/sys/devices/system/cpu/cpu*/cpu_capacity) of the
> >>> little CPU changed in v6.14 from 446 to 505. I bisected and found that
> >>> commit dd016f379ebc ("cpufreq: Introduce a more generic way to set
> >>> default per-policy boost flag") (1) introduced this change.
> >>> Juno's scmi FW marks the 2 topmost OPPs of each CPUfreq policy (policy0:
> >>> 775000 850000, policy1: 950000 1100000) as boost OPPs.
> >>>
> >>> The reason is that the 'policy->boost_enabled = true' is now done after
> >>> 'cpufreq_table_validate_and_sort() -> cpufreq_frequency_table_cpuinfo()'
> >>> in cpufreq_online() so that 'policy->cpuinfo.max_freq' is set to the
> >>> 'highest non-boost' instead of the 'highest boost' frequency.
> >>>
> >>> This is before the CPUFREQ_CREATE_POLICY notifier is fired in
> >>> cpufreq_online() to which the cpu_capacity setup code in
> >>> [drivers/base/arch_topology.c] has registered.
> >>>
> >>> Its notifier_call init_cpu_capacity_callback() uses
> >>> 'policy->cpuinfo.max_freq' to set the per-cpu
> >>> capacity_freq_ref so that the cpu_capacity can be calculated as:
> >>>
> >>> cpu_capacity = raw_cpu_capacity (2) * capacity_freq_ref /
> >>>                                     'max system-wide cpu frequency'
> >>>
> >>> (2) Juno's little CPU has 'capacity-dmips-mhz = <578>'.
> >>>
> >>> So before (1) for a little CPU:
> >>>
> >>> cpu_capacity = 578 * 850000 / 1100000 = 446
> >>>
> >>> and after:
> >>>
> >>> cpu_capacity = 578 * 700000 / 800000 = 505
> >>>
> >>> This issue can also be seen on Arm64 boards with cpufreq-dt drivers
> >>> using the 'turbo-mode' dt property for boosted OPPs.
> >>>
> >>> What's actually needed IMHO is to calculate cpu_capacity according to
> >>> the boost value. I.e.:
> >>>
> >>> (a) The infrastructure to adjust cpu_capacity in arch_topology.c has to
> >>>     be kept alive after boot.
> >
> > If we adjust the cpu_capacity at runtime this will create oscillation
> > in PELT values. We should stay with one single capacity all time :
> > - either include boost value but when boost is disable we will never
> > reach the max capacity of the cpu which could imply that the cpu will
> > never be overloaded (from scheduler pov)
>
> overutilized I'm assuming, that's the issue I was worried about here.

no I was referring to group_is_overloaded which use /Sum of CPU's capacity
That' also true for EAS and overutilized

> Strictly speaking the platform doesn't guarantee that the capacity can
> be reached and sustained indefinitely. Whether the frequency is marked
> as boost or not.

Regarding thermal mitigation and user max freq, we take that into account

>
> > - either not include boost_value but allow to go above cpu max compute
> > capacity which is something we already discussed for x86 and the turbo
> > freq in the past.
> >
>
> But that currently breaks schedutil, i.e. boost frequencies will never
> be used with schedutil. There's also some other locations where capacities

We should allow capacity to go above 1024 to reflect HW reality with
turbo and here enabling/diabling boost

> >1024 just break some assumptions (e.g. the kernel/sched/ext.c cpuperf
> interface defines SCX_CPUPERF_ONE).
>
>
> So we have either:
> a) Potential wrong capacity estimation of CPUs when boost is disabled
> (but capacity calculation assumed enabled).
> b) Boost frequencies completely unused by schedutil.
> c) Oscillating PELT values due to boost enable/disable.
>
> Isn't c) (what Dietmar proposed here) by far the smallest evil of these
> three?

No, this breaks PELT invariance

> I've also found a) very hard to actually trigger, although it's obviously
> a problem that depends on the platform.

