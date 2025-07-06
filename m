Return-Path: <linux-kernel+bounces-713999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E017BAF616C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 20:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237FA4A6EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 18:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B49D221F10;
	Wed,  2 Jul 2025 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSYOS6Xz"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774B217666
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481505; cv=none; b=HBb7caZf0fTUYmAGWRwKANaA/524dJL6Uetbxj/BAPUwDjAvnwGV9XNH8XwIg8nJjUDHRI+kSBYmGK2rD7B7UzgCefd6QWe0GYSZ2Cga3PdiTUEPsmhOEwaGVENqWTSCsUGXWmEAJnWbXHtYhW/ZQfM83R5gWiuUYQWDL4B5Ko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481505; c=relaxed/simple;
	bh=FCJONdkLdbC3jCEj6u9UdqpxaakcJuCg/zI6KWMM72w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xpre4FRXzZHiJaCe7KTAVcLi5M1Vt+CFQ6Q2FkSngH3r+WJz60q+xs6I5Tk2UFvSsFE/Uqr+eLZq+m/XNWIdU7lwRIo+Z0MfSuW1OcUIljoWd7gnx3yjNRLmNiHbRAL57KozkA+ZGSBaDD2zVJKP6oBlFPcatKSHhN56RUPZCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSYOS6Xz; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a5ac8fae12so76201cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751481503; x=1752086303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ULWWPox4qZzsIult38wzmv87aEca+ovc1/tOWVkmBuw=;
        b=jSYOS6XzV0xPxN6GjZJ+p2hHuRwvGHSy3d2ZXIfkXti9Haol3sBcvaS7bDwVYv2jYA
         qB7CbPxjK2d406AKoJfqEhjnHV0n/ibMVMmY+jd/MKNkXBOpt4/Rx72NNm2YCKW227mm
         dx89eIRxdCjoNeTvGnp7iyHfKdDpQgm1S+s8eRvTIpkEM7Tp6Ly/IYk+h0kqVpVhgWOn
         TFULUU68vR/5HooCZO0bLkUWgmdmK6aQQOF09+f+7tVoWeQ5QpReyt7ppG0AvXSROy04
         sqeOlWwpUtrDGxopP1yTmKhWZ19uIZ4IznRzfqtyP4HmYeJrDnNilwaGHKWA2X3LmbF3
         xUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481503; x=1752086303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULWWPox4qZzsIult38wzmv87aEca+ovc1/tOWVkmBuw=;
        b=SuIFOlq5gNE8bFlCZY+PPd5aIHmFg2haHSMWD1/5CPX2PIDLLiphZKZ31GdKMOHVSO
         nHQVldkkwrUN/LNRbCaETDT59xyEc2RV0agMX8LOm1FGFAzcyCpBXWqbxTbUdeSTLZzK
         kWQLLd2e8V2M1Jb0U3/II1geow7r7afLGcnPzsZ6DFQhpy0Rk8yAurFKHenERi9laEJm
         ljry6IIwTMZAAPV5pxEzQu+NHutfNEjXUAI8pXxBa3BSC31XkoAIU2Rr7nBpjPun2bt8
         amcDuc2qvLo+0XAl7NG9B4q3xPRuJRFIrTKO96osOdqb0I62ACFyucpy/A6iVnBzAwTa
         JaQg==
X-Forwarded-Encrypted: i=1; AJvYcCXxx/pWRnUyaXi7WlXuTmYHnBG6WxE4z3HZz/CkrZU4SFl/3ozzl0/zQ9qaNW6qjxCvKh+CjBrrmWpZWlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQyMtZK4Tr3dc6v7O9JLpMosjJLFBaG8yw7CYTEJd1v9ht4JX
	EzTbrY+SBCyMO9ADnQ87NHGTzAUfhiV1+MhH67MKaoQ3U7Oytv+FoEDPl4ghFR/LL2t2Pm4FGhc
	QHuGyQXGvOoWeBQ52GzqfzGT7YAWVyiEqQb5828vQ
X-Gm-Gg: ASbGncsLUCYbjI06XkEzbE2R4k4YzPpu1q3SD6YNXgSubOx6kFvYWh8s9Ao/9KX175c
	K4y/5cIEMnuPwksySGnuNlVwnZ6F+wTryADTDh/6Q7X6hu/jcNkGHgPb5TvR6UWCn4VcUPp59Bd
	7VcUMWitB+O/hXC0zfTRXVeIf8U5hl8zlBlwsXHG4boujXQ/hDquE4ZaS9snxzjOeQgBzMC8U=
X-Google-Smtp-Source: AGHT+IEEyrti8yJH4HCehYLYox3KLQbM+vM6l6RgHPmxXiAqzAoXtx6qO0ixLzChNC5livK7Thondb2rLcE8ZrQ9Kcw=
X-Received: by 2002:ac8:7d8c:0:b0:477:63b7:3523 with SMTP id
 d75a77b69052e-4a987e921famr338731cf.4.1751481502743; Wed, 02 Jul 2025
 11:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com> <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com> <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
 <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com> <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
In-Reply-To: <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 2 Jul 2025 11:38:11 -0700
X-Gm-Features: Ac12FXw9NLEKw0kD1SEh0VYR8oLCN-GZjdVDd5bL40tflLYDajSr_Xg5Q2gDMDI
Message-ID: <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Beata Michalska <beata.michalska@arm.com>
Cc: Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

Ionela, Beata, could you kindly review ?

On Fri, 27 Jun 2025 at 10:07, Prashant Malani <pmalani@google.com> wrote:
>
> Hi Jie,
>
> On Fri, 27 Jun 2025 at 00:55, Jie Zhan <zhanjie9@hisilicon.com> wrote:
> >
> >
> > Hi Prashant,
> >
> > Sorry for a late reply as I'm busy on other stuff and this doesn't seem to
> > be an easy issue to solve.
> >
>
> No worries, the ping was in general to all the people in the thread :)
>
> > For the latest kernel, [1] provides a new 'cpuinfo_avg_freq' sysfs file to
> > reflect the frequency base on AMUs, which is supposed to be more stable.
> > Though it usually shows 'Resource temporarily unavailable' on my platform
> > at the moment and looks a bit buggy.
> >
> > Most of the related discussions can be found in the reference links in [1].
> > [1] https://lore.kernel.org/linux-pm/20250131162439.3843071-1-beata.michalska@arm.com/
> >
> > As reported, the current frequency sampling method may show an large error
> > on 1) 100% load, 2) high memory access pressure, 3) idle cpus in your case.
> >
> > AFAICS, they may all come from the unstable latency accessing remote AMUs
> > for 4 times but delaying a fixed 2us sampling window.
>
> I tried applying [1] which consolidates the ref and del register reads
> into 1 IPI, but that did not make a difference. The values still
> fluctuate wildly.
>
> >
> > Increase the sampling windows seems to help but also increase the time
> > overhead, so that's not favoured by people.
> >
>
> This experiment did not appear to help in our case. It's a point in
> the direction that this method is inherently inaccurate during idle
> situations.
>
> > On 20/06/2025 13:07, Prashant Malani wrote:
> > > Hi Jie,
> > > On Thu, 19 Jun 2025 at 20:53, Jie Zhan <zhanjie9@hisilicon.com> wrote:
> > >> On 19/06/2025 08:09, Prashant Malani wrote:
> > >>> t0: ref=899127636, del=3012458473
> > >>> t1: ref=899129626, del=3012466509
> > >>> perf=40
> > >>
> > >> In this case, the target cpu is mostly idle but not fully idle during the
> > >> sampling window since the counter grows a little bit.
> > >> Perhaps some interrupts happen to run on the cpu shortly.
> >
> > Check back here again, I don't think it 'mostly idle'.
> > Diff of ref counters is around 2000, and I guess the ref counter freq is
> > 1GHz on your platform?  That's exactly 2us, so the target cpu is mostly
> > busy.

I think it is pertinent to note: the actual act of reading the CPPC counters
will (at least for ACPI_ADR_SPACE_FIXED_HARDWARE counters)
wake the CPU up, so even if a CPU *was* idle, the reading of the counters
calls cpc_read_ffh() [1] which does an IPI on the target CPU [2] thus waking
it up from WFI.

And that brings us back to the original assertion made in this patch:
the counter values are quite unreliable when the CPU is in this
idle (or rather I should correct that to, waking from WFI) state.

This work around probably hits more types of implementations, but
I can't see another way to limit it to only ARM FFH. Open to suggestions!

[1] https://elixir.bootlin.com/linux/v6.15.4/source/arch/arm64/kernel/topology.c#L482
[2] https://elixir.bootlin.com/linux/v6.15.4/source/arch/arm64/kernel/topology.c#L453

Best regards,

-Prashant


-- 
-Prashant

