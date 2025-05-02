Return-Path: <linux-kernel+bounces-630345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D185AA78AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 19:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8617A3F86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F65255E30;
	Fri,  2 May 2025 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wwyYbNKk"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD919DF5B
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746207068; cv=none; b=GwPc2co6e3c5qzBmo3bqIkycL9NRs0w0BDiOF8hbjVzY52oWf3WMUksvnwdY5rAlDf6ipJgU0y84rAMOKOyE5kg7PqlWJc5steND9oiLlBWipDyGbcurjOxa7wCBhebB1cQLqP5rsB7SRJl0rSAwB1AI+t0eMm5+c5v3tpUKhUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746207068; c=relaxed/simple;
	bh=M+7B4daGccErNTyFVD7UF/LbMQuW1ksDcmHRoalpovQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ia75+bS72enrrFKl/qi/tmcc/rMikjBau2e1MMbzeVE4fKY/L5yXj/SHH/izw0rDxSXqUBR8PxUGFT1e82iBADa1Orj2tt9ozxrEJ6zHnlkY2ouWYUsxgKWQJeiDY2LX8lIFypZaC5td18nYaZ2uIEDN2lPwLUctZXlTuZNb2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wwyYbNKk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8fc176825so21555076d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746207064; x=1746811864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMCFjcDYKufJvMwFbFoS0kPacOFt/H1BGkqn/nrFgq0=;
        b=wwyYbNKk1EMrF3zPLpzPKtn/CSx+s/VoMRedmf1z2AkF7gse4ql+Gzu+WtjllAgfaS
         f0N4MnMCxkU8BI/h2Ukx54jjyTKwfeBZkJZbSUynQyaRinOMFiIw6xy7NDrM9a1hf3rF
         iRmZKF75teBngCGTC4LQ+CKHV6cvjsHj3AKQJYknG46zCYVwDtmaAkV1iRgLKdfZpIwI
         5iH/k0vyQc6RgKJi6meIYNqzVr6IYDhih7bpXoWjhDmAkA6GovK1QTGaOVxQq83nFCiN
         jRY+fI81X+mzS3Tonw7RKz3DbKu/lLpWX/vRapP3LGdcZxhXUuOD9CuA6PkLN2ZmwLT/
         4pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746207064; x=1746811864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMCFjcDYKufJvMwFbFoS0kPacOFt/H1BGkqn/nrFgq0=;
        b=ss8/dto7dnNp0QtyBdc5svctMbTuiWsZtX8HFUJ9w8MKEWueNKZEj/L/Q5j2d0tMD5
         3Eiuf8Z9X2ZQ7Zz1drsLyw2Mebd3ltDDfZZlJid+4vX1aWjq6zcLDy0BaHjyupslEXs1
         z/qgqsME/Ctt/+iuuaTmD94ZIO9KOqwHL4SxUnIXLpiouspKJl08g9OYrdEi0O2QJ2tx
         lvfaW4gzONnPuonTSlk01IcCEVsxo8NBQc18Na+WKqCppp7kG23IJzxrNrYBLu0BRxIn
         dlx4B2lbv5ncw/S2cQsSTS2P8RxdxA0Z/vicvjJZ/B2jPny1mG8CH1DvoGHYyYDIhjgL
         VsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJMy8aldTrHypL/hAyg6mxPXVW+uHmQKX4VpreIMuoyACmdTxklVOBEU3fWSzyvIR6gyUaCWmMda0mwpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDIzGVPnWFfc9oWGx9wix8MTzg83UCnxuU/5003ZcgSSHR/iW
	XF+NNy/69q4iU6yX0O+gPuHRSAF6IlHObmCuXxArhVOyi0kCuTdU1TpgbY2IqfpslD/fpUZZeB/
	tpZvuhYF+uG5QhkbD/7+D+d4hVIQUoO1cYoE=
X-Gm-Gg: ASbGncsDVlU7wsaXAyQEeEvz7iUBWdJCUKQN71SI4nTHqx/fdBCsrfq3+uMelaI3L7f
	PcYgf8o4ZGAITbjTxC5bfJjaJ4Bux3IRCIiBX5umChj0nGdiVfJP0RxnLGTdF8OgMC+0YKDDBev
	yficCzd0zm19zCA55wE4qJbMGeO5j5Y1NeF6JTcF5ge8Z6hsMXcE0cXlQ=
X-Google-Smtp-Source: AGHT+IFketDgIAyIg1nzLpZwpgdnRMDBObLxDNHG1f3j9ZJ7VtHRnYWzb9gAuuD1s4QoK/s07tDlq6e1k6CDT2Gw9WA=
X-Received: by 2002:ad4:5d63:0:b0:6e6:6c7f:1116 with SMTP id
 6a1803df08f44-6f51578445fmr53465476d6.24.1746207063804; Fri, 02 May 2025
 10:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501193556.23473-1-yabinc@google.com> <02c125c9-7a1f-4dfd-b058-02a38ed5b598@arm.com>
In-Reply-To: <02c125c9-7a1f-4dfd-b058-02a38ed5b598@arm.com>
From: Yabin Cui <yabinc@google.com>
Date: Fri, 2 May 2025 10:30:52 -0700
X-Gm-Features: ATxdqUFmx2hBUO3uk91d37roh8hs55lc6aLf5LBhD3FNcxdPEhGgyk4RnUvPDUU
Message-ID: <CALJ9ZPMYj=+ZsbPDWHe80R_i3GiMmKBviZ+WBRaj3jm96ZH+VQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf: Allocate non-contiguous AUX pages by default
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 3:51=E2=80=AFAM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> On 5/2/25 01:05, Yabin Cui wrote:
> > perf always allocates contiguous AUX pages based on aux_watermark.
> > However, this contiguous allocation doesn't benefit all PMUs. For
> > instance, ARM SPE and TRBE operate with virtual pages, and Coresight
> > ETR allocates a separate buffer. For these PMUs, allocating contiguous
> > AUX pages unnecessarily exacerbates memory fragmentation. This
> > fragmentation can prevent their use on long-running devices.
> >
> > This patch modifies the perf driver to be memory-friendly by default,
> > by allocating non-contiguous AUX pages. For PMUs requiring contiguous
> > pages (Intel BTS and some Intel PT), the existing
> > PERF_PMU_CAP_AUX_NO_SG capability can be used. For PMUs that don't
> > require but can benefit from contiguous pages (some Intel PT), a new
> > capability, PERF_PMU_CAP_AUX_PREFER_LARGE, is added to maintain their
> > existing behavior.
> >
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > ---
> > Changes since v2:
> > Let NO_SG imply PREFER_LARGE. So PMUs don't need to set both flags.
> > Then the only place needing PREFER_LARGE is intel/pt.c.
> >
> > Changes since v1:
> > In v1, default is preferring contiguous pages, and add a flag to
> > allocate non-contiguous pages. In v2, default is allocating
> > non-contiguous pages, and add a flag to prefer contiguous pages.
> >
> > v1 patchset:
> > perf,coresight: Reduce fragmentation with non-contiguous AUX pages for
> > cs_etm
> >
> >  arch/x86/events/intel/pt.c  |  2 ++
> >  include/linux/perf_event.h  |  1 +
> >  kernel/events/ring_buffer.c | 20 +++++++++++++-------
> >  3 files changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> > index fa37565f6418..25ead919fc48 100644
> > --- a/arch/x86/events/intel/pt.c
> > +++ b/arch/x86/events/intel/pt.c
> > @@ -1863,6 +1863,8 @@ static __init int pt_init(void)
> >
> >       if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
> >               pt_pmu.pmu.capabilities =3D PERF_PMU_CAP_AUX_NO_SG;
> > +     else
> > +             pt_pmu.pmu.capabilities =3D PERF_PMU_CAP_AUX_PREFER_LARGE=
;
> >
> >       pt_pmu.pmu.capabilities         |=3D PERF_PMU_CAP_EXCLUSIVE |
> >                                          PERF_PMU_CAP_ITRACE |
>
> Why this PMU has PERF_PMU_CAP_AUX_PREFER_LARGE fallback option but
> not the other PMU in arch/x86/events/intel/bts.c even though both
> had PERF_PMU_CAP_AUX_NO_SG ?

Because Intel BTS always use NO_SG, while in some cases Intel PT
doesn't use NO_SG.
>
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 0069ba6866a4..56d77348c511 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -301,6 +301,7 @@ struct perf_event_pmu_context;
> >  #define PERF_PMU_CAP_AUX_OUTPUT                      0x0080
> >  #define PERF_PMU_CAP_EXTENDED_HW_TYPE                0x0100
> >  #define PERF_PMU_CAP_AUX_PAUSE                       0x0200
> > +#define PERF_PMU_CAP_AUX_PREFER_LARGE                0x0400
> >
> >  /**
> >   * pmu::scope
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 5130b119d0ae..4d2f1c95673e 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -679,7 +679,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct per=
f_event *event,
> >  {
> >       bool overwrite =3D !(flags & RING_BUFFER_WRITABLE);
> >       int node =3D (event->cpu =3D=3D -1) ? -1 : cpu_to_node(event->cpu=
);
> > -     int ret =3D -ENOMEM, max_order;
> > +     int ret =3D -ENOMEM, max_order =3D 0;
>
> 0 order is now the default allocation granularity. This might benefit
> from a comment above explaining that max_order could change only with
> PERF_PMU_CAP_AUX_NO_SG or PERF_PMU_CAP_AUX_PREFER_LARGE PMU flags etc.
>
Will add the comment in the next respin.
> >
> >       if (!has_aux(event))
> >               return -EOPNOTSUPP;
> > @@ -689,8 +689,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct per=
f_event *event,
> >
> >       if (!overwrite) {
> >               /*
> > -              * Watermark defaults to half the buffer, and so does the
> > -              * max_order, to aid PMU drivers in double buffering.
> > +              * Watermark defaults to half the buffer, to aid PMU driv=
ers
> > +              * in double buffering.
> >                */
> >               if (!watermark)
> >                       watermark =3D min_t(unsigned long,
> > @@ -698,16 +698,22 @@ int rb_alloc_aux(struct perf_buffer *rb, struct p=
erf_event *event,
> >                                         (unsigned long)nr_pages << (PAG=
E_SHIFT - 1));
> >
> >               /*
> > -              * Use aux_watermark as the basis for chunking to
> > +              * For PMUs that need or prefer large contiguous buffers,
> > +              * use aux_watermark as the basis for chunking to
> >                * help PMU drivers honor the watermark.
> >                */
> > -             max_order =3D get_order(watermark);
> > +             if (event->pmu->capabilities & (PERF_PMU_CAP_AUX_NO_SG |
> > +                                             PERF_PMU_CAP_AUX_PREFER_L=
ARGE))
> > +                     max_order =3D get_order(watermark);
> >       } else {
> >               /*
> > -              * We need to start with the max_order that fits in nr_pa=
ges,
> > +              * For PMUs that need or prefer large contiguous buffers,
> > +              * we need to start with the max_order that fits in nr_pa=
ges,
> >                * not the other way around, hence ilog2() and not get_or=
der.
> >                */
> > -             max_order =3D ilog2(nr_pages);
> > +             if (event->pmu->capabilities & (PERF_PMU_CAP_AUX_NO_SG |
> > +                                             PERF_PMU_CAP_AUX_PREFER_L=
ARGE))
> > +                     max_order =3D ilog2(nr_pages);
> >               watermark =3D 0;
> >       }
> >
>
> Although not really sure, could event->pmu->capabilities check against th=
e ORed
> PMU flags PERF_PMU_CAP_AUX_NO_SG and PERF_PMU_CAP_AUX_PREFER_LARGE be con=
tained
> in a helper pmu_prefers_cont_alloc(struct *pmu ...) or something similar =
?

Sure, but I feel it's not very worthwhile. Maybe add a local variable
use_contiguous_pages? It can also work as another comment near
max_order.

