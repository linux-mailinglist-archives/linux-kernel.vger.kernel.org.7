Return-Path: <linux-kernel+bounces-834634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273BCBA524A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0A61B219E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774832857CB;
	Fri, 26 Sep 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FfUr+C9G"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1526F292
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920266; cv=none; b=HFmJyDvgOcZzN83Pb5M3ktCDAThuGbGfFckL1gpaelxivNVj2Qwr7YKqp5kHKl4PWvTP9SYjVcTq95CmaAX2l0+2I/b5GzNq4lDpbd7JEVPGzADMwzp3636lb+fqk1UUcDTao9uiCe76cwkN94D0rH7PYfv6P9TTvz7j0VAqoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920266; c=relaxed/simple;
	bh=CE1reL0wncd9PierxwrDmW4jfOrkqzteseelrqjomUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC2u8QE+mLjHx3CU+vSj1iXrAL/3vwcjLPMINzSsBRt6x3tmIMzBI5Y/yFJEDOtFSu5+1scVXa8HSvJMdF36rbcWgmZ5FymjpdOgI4eHocHqPCpNvsuEX4FGRp1sZn3n6CMRWH/pkDlp08XC1M3WqlWHee2r687YOWrozQ6mHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FfUr+C9G; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f2e621ef8so3528076b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758920264; x=1759525064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH2Sfk58/GaFMno98E5ZZZ0Jezt1oWfRMccsDmLi3+U=;
        b=FfUr+C9GEzv201QOoV1GLhvr7e1kmG6rj8qoEHiyy2fmYmgHao4kCDXCQd1jOu3tSY
         oNBIlEVbh4Pxny4SBmiOonFY21m6hyJ0ylYKTLaMH0h0h3yr1oG0po64ILoA8690YMFX
         m7XaTy/q1z8CWa+rBL/Qce1tclEtyFU/DF7R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758920264; x=1759525064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH2Sfk58/GaFMno98E5ZZZ0Jezt1oWfRMccsDmLi3+U=;
        b=OuxMtMasM4mjagthYvct0nBYyEvEI0BwzqFyyzZ2CEC7HSTHK12vIf81VD+jH5DpaN
         eWDt+J3ypkMtQseqaPMvwv1xwe7SnWfsyUD7IL708OAii3T6EvIGNSxi+zDqASFYN7lg
         h7LGyRPZ+iVPXyOl4PawWEhv6gjyDUGKz2EmSIWXzplO2ofNJAky/i2tzN9ManBNMsEr
         PuNwDuoXfug0lQOXrTm3a7T6lqgGHx4axAspyPen5NQkFJjFX96z4x9gjNm7lE5uRm04
         tjQljo2IDTTcO7j8GdJoQYZI1HChbKTFJuI/b+qR2pNI8t0NJ3mLL76bLVK5s2nbR+y8
         9+wA==
X-Forwarded-Encrypted: i=1; AJvYcCX6TNRuxw7gKGx4WvzI3cFQdBnL0rM6mcZzgbumhp0puIs0zcgkQyllpVVFRL2/kyaRQO00LN4IkGvoVO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65JhYwhTytr4LuN6cK9LfqdErTvcXnv6UsuHYX2SuDqNOW0Jq
	6FulZeRrxaR4d1+xJdHchbXaJNA9t2zO03hxVJfzGa4KNNreZIeGJseCl9TKmRUocv02qecXNeX
	vHmg=
X-Gm-Gg: ASbGnct4IA9YQtf3E1BSvw4tA3jH7Ox6ZTbkOWFq8wlTy+xsq/xczLQwSdlVL52ac7m
	my1jYW2Bp9/wIahxQr/0YPw7GjPHrx/7q9yosn5jN+X1QFcyRxmqBEOOfjCti8yCpkvZdAkabPY
	84ztRUBe62+vGQ1RpH/AY9qawCWeGr1oY3z+2oGunwkQ5nmqVL3fslERXtnTopiwWi1dPTbI32W
	q/cr5Ys0RHy8AFfEneOa/ssranmgRKL9ESbePAjgxm2YM7PA5S7X6wnCcTk/XBlmmR/9uKtNpxG
	SBFDgx8f2oxhF4ZWgpojP1mjqF82hDngEI1QJPvbxt9xKKx0nwUx/Aft/IGwQpkr38Sb9qQEU+S
	A3Mhy4sRA3O0GiO34h/ImFciqLkI2DEE5bDkX15eQAi0y4DwtbSkCEX3Y2OS8GlJoGA==
X-Google-Smtp-Source: AGHT+IFTowZunFrxeiu3Iib95OmTD1ikPQXlZEeaUMcfzUP6fManCC1r4ikqB88H+sTFzPbm7QI/2A==
X-Received: by 2002:a05:6a20:7343:b0:2c9:ff13:bc86 with SMTP id adf61e73a8af0-2e7c7cb219emr10574996637.21.1758920264531;
        Fri, 26 Sep 2025 13:57:44 -0700 (PDT)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b59671ce93fsm96721a12.3.2025.09.26.13.57.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 13:57:44 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b556284db11so2576355a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:57:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDf0Y7RIXnBOrlAZH3P0vg78x784pYPiELJfED3rYa0CSo2zywb6LIndvdw+2oaHxBTXI5/fRCjPwN4NM=@vger.kernel.org
X-Received: by 2002:a17:902:c402:b0:25c:d4b6:f119 with SMTP id
 d9443c01a7336-27ed49df307mr105837165ad.12.1758920263386; Fri, 26 Sep 2025
 13:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
In-Reply-To: <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Sep 2025 13:57:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
X-Gm-Features: AS18NWDVMqIM3NdX-t4tF69rrS3UxfWVNc7ZvIbAVZlF3PJHNdBYWzKZ9mUJzVc
Message-ID: <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	johannes@sipsolutions.net, lihuafei1@huawei.com, mark.rutland@arm.com, 
	masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 26, 2025 at 2:37=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Doug,
>
> On Fri, Sep 26, 2025 at 4:00=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Thu, Sep 25, 2025 at 1:48=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/cpu_pm.h>
> > >  #include <linux/export.h>
> > >  #include <linux/kernel.h>
> > > +#include <linux/nmi.h>
> > >  #include <linux/perf/arm_pmu.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/sched/clock.h>
> > > @@ -696,10 +697,12 @@ static int armpmu_get_cpu_irq(struct arm_pmu *p=
mu, int cpu)
> > >         return per_cpu(hw_events->irq, cpu);
> > >  }
> > >
> > > -bool arm_pmu_irq_is_nmi(void)
> > > +#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
> > > +bool arch_perf_nmi_is_available(void)
> > >  {
> > >         return has_nmi;
> > >  }
> > > +#endif
> >
> > Should the previous comment move here, AKA:
> >
> > /*
> >  * hardlockup_detector_perf_init() will success even if Pseudo-NMI turn=
s off,
>
> Okay, we also need to change it to =E2=80=9Cwatchdog_hardlockup_probe()=
=E2=80=9D
>
> >  * however, the pmu interrupts will act like a normal interrupt instead=
 of
> >  * NMI and the hardlockup detector would be broken.
> > */
> >
> >
> > > +static int __init init_watchdog_freq_notifier(void)
> > > +{
> > > +       return cpufreq_register_notifier(&watchdog_freq_notifier,
> > > +                                        CPUFREQ_POLICY_NOTIFIER);
> >
> > I think you need to do something to prevent this from happening on any
> > platforms that override hw_nmi_get_sample_period(), right? These
> > cpufreq notifiers will be useless in that case...
>
> I understand this is not a problem. watchdog_perf uses
> PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited by the
> CPU's main frequency. After we make such a change, a larger value may
> be used as the period, so the NMI period will become longer, but this
> value will not change after the system starts.

I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:

u64 hw_nmi_get_sample_period(int watchdog_thresh)
{
  return (u64)(cpu_khz) * 1000 * watchdog_thresh;
}

On PowerPC it's:

u64 hw_nmi_get_sample_period(int watchdog_thresh)
{
  return ppc_proc_freq * watchdog_thresh;
}

Neither of those are necessarily based on the results the cpufreq
reports. ...so therefore I don't think you should be taking the
cpufreq reported numbers and assuming they're OK on x86 and powerpc.

-Doug

