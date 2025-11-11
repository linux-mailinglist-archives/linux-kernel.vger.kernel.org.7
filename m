Return-Path: <linux-kernel+bounces-894783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C3C4C183
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30A03BE385
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2A7221282;
	Tue, 11 Nov 2025 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RA3qUKG9"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20834D38B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845335; cv=none; b=snGHA9EwW0ZIVa2XQ1DElW4aV8MMsaikwK6FWpfhbYVf9OIvFE9jVoSiv7L98Ne6sXNZKYgwBAb45ESa1RQD8UZeQlmh+QB/wld/6Gui+UriQb2I6X1ZmSjn7GSsrwZSQFxX/lymUfy9oKIMEWcXtldD0ut9Wc1S3Od+9SaZoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845335; c=relaxed/simple;
	bh=wrbtYmF5M2Btq/6WUxsAnzshgHMYJjYmmWYOAPlWha4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeC9gbmqBSyFD+MKOHWEUZ6DO1K0vRTuliCN6f7ogSS8wKRFR/ASvCMHW7O4dab8+WxhwQa5sg+ISJ91PhyWZlTKvoNPFQpSL9eD9cL7iFbu3TXYjcJLzll+S6nZqW9Vy77LxHI3Chc4373n/uygSk6WbMR9jP1pQkyObyfTJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RA3qUKG9; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e80c483a13so820530fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762845333; x=1763450133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGMbS3VEvjhgNpVe1MttoJ7jTkjbM/PBhlD1Dx+012U=;
        b=RA3qUKG9Vay/L9MubkIcoIwyDTpVy40Pn61bYxtFPm9We+inudZzdPs3UmKv8yYVN3
         F02mlJuse6HRumMBv/t1u+ofTvXZtvJ38F7ff6Uk4fJsRTSIDgEMuN0bzvk6BuEjD8KP
         Lc2ynXip/Q9MWdzhkrlzPBjbOuTEJ5iOcBzMOycrpQ3I3OmkjHquILuUNbvFvGrWAJdm
         /a2/6Jx4Snz/EV9tEELhAVUhS1pTjrxpSwEottI5rw97t9f3sVomdrfEntgGDaEFNcFL
         YaaKPcOm87yUVLf18vkABK/42FF0csCMUd2E2vIqg/OBDQt4gGH671AUrWEZdI8BeC+r
         3obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762845333; x=1763450133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGMbS3VEvjhgNpVe1MttoJ7jTkjbM/PBhlD1Dx+012U=;
        b=ZHl/5TUGUAYmdDHEB/mHJOi80go5PYniwZVnPOBU0npPPFpggRxXbHzNajfMkAuzXj
         ACjB+PARcDLwa0xBR5W5Z98L3I3pRxsOFj3gf2Bo2cnCSc9QVkLimCAoKKPO3SbGZ1Ny
         lKOX9417MMkirwKIxMLw5E5S5nLSByQ7krwZp83TQhOOJRcmM8HUbH/Xjcfxy41oceWW
         alcVW/3Izs2nEvPjvVFiqNVQGKmC7lBtzisTtLTiDfREDVloknVJ1eD+6eBygQqO9Mv9
         GO/G+OTNdqNJ9w/FygQDRsQZvhswc4CBSJb0ij+ecXdNIVIEWVKVkPcggZaXw3FDGy49
         SH8g==
X-Forwarded-Encrypted: i=1; AJvYcCUwfhFlPxnYd/bCubVW0i8duPCfWewyimlZdNgBDbRV6oPVxgguigo1IDe/kdcrdkvy4cLbFjS9uk1h9Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5F9RtZj1GV7dYljCDySHLGq8e0Mm8BRmRsUStNlUx8CoKk2W
	rV94m4SHOt+13zR+oYlOMQmNim8yiIhkejkQbljOp8+r8XlyqcKHZ8/jVG7vw+7X0/iTpP32bj2
	kXDm4KpRyUPfIk3kiqXTfAztOkgyDUoSfIUkl4/7LWA==
X-Gm-Gg: ASbGncs3VQ4avIg6nhR9nfPDBHgFjVvxWiQFkBtA8QP/uVrX9I/Mf9Blvmc7w76/H7H
	66tWMewSEAuUYAgqt+LZK8InuxoYkqYCICoOxWTIoagyr39OSoZNtn3CVE0YQFlVJyjFd/kPcKV
	aTDvA5IQnThz1ktyI30/eLcyGYT90Gss+FhdY6x3R0JSw0vK/LoER9mwiZBPJFnIlYIL2LSD/GL
	8fPAGTCMHZC6fVLFYIQqTWBUrEuKvfAUwbP0tq12Lm/PMKSOTA3AOZdspcfLcDxLM5stzMgFQ==
X-Google-Smtp-Source: AGHT+IHWbJ4Yp3gQoh0gR8ti6hW2JnDfbC3dn3VOEzDDEL8ykj+19tubGTkAQQf4eOHdb+UN2vP0PrZVV2xFeQuhHI4=
X-Received: by 2002:a05:6808:15a6:b0:44d:badf:f41a with SMTP id
 5614622812f47-4502a2df5d2mr5427044b6e.32.1762845333082; Mon, 10 Nov 2025
 23:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014031425.93284-1-cuiyunhui@bytedance.com>
 <20251014031425.93284-2-cuiyunhui@bytedance.com> <aQixsIQXTjYyhRVj@willie-the-truck>
 <CAEEQ3wk5Ru4-=4Ecnc6kQAAbR57806xxYTz0o1z4KfgZE6Cg6w@mail.gmail.com> <aQ3v15yrm9JaWgrm@willie-the-truck>
In-Reply-To: <aQ3v15yrm9JaWgrm@willie-the-truck>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 11 Nov 2025 15:15:21 +0800
X-Gm-Features: AWmQ_bnoZJigBSCLU3lJje6heEEH-Frt6iL4puU2iLrcXPWUx0zHPoaDlQHxw1Y
Message-ID: <CAEEQ3wnC-xGZ_m4+vJ42KzU4DdQb1CGfZh_=Nz5wkFuXKS7Y3w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: Will Deacon <will@kernel.org>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
	dianders@chromium.org, johannes@sipsolutions.net, lihuafei1@huawei.com, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Fri, Nov 7, 2025 at 9:11=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Nov 07, 2025 at 10:42:25AM +0800, yunhui cui wrote:
> > On Mon, Nov 3, 2025 at 9:44=E2=80=AFPM Will Deacon <will@kernel.org> wr=
ote:
> > >
> > > On Tue, Oct 14, 2025 at 11:14:24AM +0800, Yunhui Cui wrote:
> > > > @@ -306,3 +307,85 @@ void __init hardlockup_config_perf_event(const=
 char *str)
> > > >       wd_hw_attr.type =3D PERF_TYPE_RAW;
> > > >       wd_hw_attr.config =3D config;
> > > >  }
> > > > +
> > > > +#ifdef CONFIG_WATCHDOG_PERF_ADJUST_PERIOD
> > > > +/*
> > > > + * Safe maximum CPU frequency in case a particular platform doesn'=
t implement
> > > > + * cpufreq driver. Although, architecture doesn't put any restrict=
ions on
> > > > + * maximum frequency but 5 GHz seems to be safe maximum given the =
available
> > > > + * CPUs in the market which are clocked much less than 5 GHz. On t=
he other
> > > > + * hand, we can't make it much higher as it would lead to a large =
hard-lockup
> > > > + * detection timeout on parts which are running slower (eg. 1GHz o=
n
> > > > + * Developerbox) and doesn't possess a cpufreq driver.
> > > > + */
> > > > +#define SAFE_MAX_CPU_FREQ    5000000000UL // 5 GHz
> > > > +__weak u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > > > +{
> > > > +     unsigned int cpu =3D smp_processor_id();
> > > > +     unsigned long max_cpu_freq;
> > > > +
> > > > +     max_cpu_freq =3D cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > > > +     if (!max_cpu_freq)
> > > > +             max_cpu_freq =3D SAFE_MAX_CPU_FREQ;
> > > > +
> > > > +     return (u64)max_cpu_freq * watchdog_thresh;
> > > > +}
> > >
> > > Why does this function become __weak? Neither arm64 nor riscv overrid=
e
> > > it afaict.
> >
> > Would you say there=E2=80=99s any particular issue here? If some archit=
ectures
> > might need to override the hw_nmi_get_sample_period() function later
> > on, wouldn=E2=80=99t __weak be a more reasonable choice?
>
> __weak is pretty brittle (it can depend on link order if you have multipl=
e
> targets) and I suspect it prevents inlining when LTO isn't enabled. It's
> cleaner and more robust for architectures to provide their hooks by
> #defining the symbol, as is done commonly in other parts of the kernel.
>
> But in this particular case, it's completely unnecessary because there
> isn't an architectural override and so this function should simply be
> static.

Since the function is declared as u64 hw_nmi_get_sample_period(int
watchdog_thresh) in nmi.h, it cannot be static.
I will remove the __weak modifier in the next version.

>
> Will

Thanks,
Yunhui

