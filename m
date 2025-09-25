Return-Path: <linux-kernel+bounces-832903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A1EBA0B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9896F4A0614
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A13081A9;
	Thu, 25 Sep 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFA442zc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22604C81
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819468; cv=none; b=o5afE045D/XJ44p9iNQtkI6h75HZGTQv57DB7NBK3GXPiHuQDzgZWWTnPPLpreKi9U7oOpWHJ+ajnQFQQZsFwjfK1Ur4DR47SSjyKb50cjcBmiHhOim20w6CFbx1fXqTwwlPVhUEltaFbqzXs2SFzttfubaCLhi17OZEZomONrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819468; c=relaxed/simple;
	bh=lr5Z6NLA9dLOR8qt7qLbQlNjXD+YxSwYH9bx7AKeXl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPrV8aWwK2bedSuLhJkrkSmQ20lzfTui1yxXMoSw0fzFfhrK4l1Z1IeZVWpo1P8yq7kIdAx9fOQTdQC7+capWwPWjRliTOzDBFP9CxSZ/MfdhgTeInOnL2rGntHJN6X2HW1vKgS0NYN9FORiQIZTCEp7DUA9ocQ1t5LdLmx9amQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFA442zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F656C4CEF7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758819468;
	bh=lr5Z6NLA9dLOR8qt7qLbQlNjXD+YxSwYH9bx7AKeXl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SFA442zcygNNjQa8s7tnnAIwXnxSXQ4MKTic75JNr+grewUsxb9HwuDR/KD96s2FL
	 Bch2XZLAVLtZXMNsgaAZh6OPdd7hnn0dJt4bqaH0yZL+X18lmTiJsDCe0LkoEyuagX
	 kfwuGOciIbtpfgE5CxnbcuB9YP6WG7vqHIArXGmgW64PJHvlJYFwavhmiMCGpjnpGb
	 b465EfAwgplZPlSpG8HuXNY6QrwgMLa6v/Hm9OWKZCSeeRkX3fGMpouUwbHBsLbcMf
	 E2MBUHOn75hHi/gfbb5sXVzmknLIljBz3auITaFBlAQ1d3s2bLz0x4cSxwSUcBHBIl
	 WdmVBB0s4tkuQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30cce892b7dso797116fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:57:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrEfG+QMNWZbStyKoVQeeshODXAFBEHyE9zldkwPpE6qIIx5kG/YpVZL44oV/OqCsuYsAh6F2cg0g0jGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02yAL/PmnxewFPO4Qci1zsqT5zNMhT/2QaSgKRL8GEqvxPLig
	AjbdfiKFS1nnCL9XdKEwvzVrf63Z7d9C2F7hJpK5A7lkrmCO7C+sPtIOPmQlWQX7H+oVI1+TAU6
	P8YVzEeg8n/Uijr44kvsXYXIL1cwX45s=
X-Google-Smtp-Source: AGHT+IG/Hwlhw7Kmhk29io5+M/aUHFxNEkmbZeByTyv7iAynfGzITiV0lwRxzw/7pcwV5slgMGiUlh69fvtpELsM3HM=
X-Received: by 2002:a05:6870:2192:b0:308:51fe:ea07 with SMTP id
 586e51a60fabf-35ebf3edb68mr1711647fac.1.1758819467946; Thu, 25 Sep 2025
 09:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8605612.T7Z3S40VBb@rafael.j.wysocki> <3925838.kQq0lBPeGt@rafael.j.wysocki>
 <99b90797-50ef-46e9-87a8-5a02b24d4aa6@amd.com>
In-Reply-To: <99b90797-50ef-46e9-87a8-5a02b24d4aa6@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 18:57:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gxqNoX1CAAAuVtmYM5Hm-5nOGwLXo9hF=z3zPdVVNrCg@mail.gmail.com>
X-Gm-Features: AS18NWAkOFz_tnd-IJqjB1Mqxi937XcHy3ls7bwUg-QEfi-13Op95DLTv0L4V7o
Message-ID: <CAJZ5v0gxqNoX1CAAAuVtmYM5Hm-5nOGwLXo9hF=z3zPdVVNrCg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ACPI: CPPC: Replace CPUFREQ_ETERNAL with
 CPPC-specific symbol
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>, 
	LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Prashanth Prakash <pprakash@codeaurora.org>, Pierre Gondois <pierre.gondois@arm.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:35=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 9/25/2025 10:46 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of using CPUFREQ_ETERNAL for signaling error conditions in
> > cppc_get_transition_latency(), introduce CPPC_NO_DATA specifically
> > for this purpose and update all of the callers of this function to
> > use it.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/cppc_acpi.c       |    6 +++---
> >   drivers/cpufreq/amd-pstate.c   |    4 ++--
> >   drivers/cpufreq/cppc_cpufreq.c |    2 +-
> >   include/acpi/cppc_acpi.h       |    4 +++-
> >   include/linux/cpufreq.h        |    3 ---
> >   5 files changed, 9 insertions(+), 10 deletions(-)
> >
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1897,16 +1897,16 @@ unsigned int cppc_get_transition_latency
> >
> >       cpc_desc =3D per_cpu(cpc_desc_ptr, cpu_num);
> >       if (!cpc_desc)
> > -             return CPUFREQ_ETERNAL;
> > +             return CPPC_NO_DATA;
> >
> >       desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
> >       if (CPC_IN_SYSTEM_MEMORY(desired_reg) || CPC_IN_SYSTEM_IO(desired=
_reg))
> >               return 0;
> >       else if (!CPC_IN_PCC(desired_reg))
> > -             return CPUFREQ_ETERNAL;
> > +             return CPPC_NO_DATA;
> >
> >       if (pcc_ss_id < 0)
> > -             return CPUFREQ_ETERNAL;
> > +             return CPPC_NO_DATA;
> >
> >       pcc_ss_data =3D pcc_data[pcc_ss_id];
> >       if (pcc_ss_data->pcc_mpar)
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -875,7 +875,7 @@ static u32 amd_pstate_get_transition_del
> >       u32 transition_delay_ns;
> >
> >       transition_delay_ns =3D cppc_get_transition_latency(cpu);
> > -     if (transition_delay_ns =3D=3D CPUFREQ_ETERNAL) {
> > +     if (transition_delay_ns =3D=3D CPPC_NO_DATA) {
> >               if (cpu_feature_enabled(X86_FEATURE_AMD_FAST_CPPC))
> >                       return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
> >               else
> > @@ -894,7 +894,7 @@ static u32 amd_pstate_get_transition_lat
> >       u32 transition_latency;
> >
> >       transition_latency =3D cppc_get_transition_latency(cpu);
> > -     if (transition_latency  =3D=3D CPUFREQ_ETERNAL)
> > +     if (transition_latency  =3D=3D CPPC_NO_DATA)
> >               return AMD_PSTATE_TRANSITION_LATENCY;
> >
> >       return transition_latency;
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -312,7 +312,7 @@ static unsigned int get_transition_laten
> >   {
> >       unsigned int transition_latency_ns =3D cppc_get_transition_latenc=
y(cpu);
> >
> > -     if (transition_latency_ns =3D=3D CPUFREQ_ETERNAL)
> > +     if (transition_latency_ns =3D=3D CPPC_NO_DATA)
> >               return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_U=
SEC;
> >
> >       return transition_latency_ns / NSEC_PER_USEC;
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -41,6 +41,8 @@
> >
> >   #define CPPC_ENERGY_PERF_MAX        (0xFF)
> >
> > +#define CPPC_NO_DATA (unsigned int)(-1)
> > +
>
> Would it be cleaner to just change all the functions that can return
> CPPC_NO_DATA to int instead of unsigned int and instead use -ENODATA?

Yes, that'll work too.

I'll send an update of this patch shortly.

> >   /* Each register has the folowing format. */
> >   struct cpc_reg {
> >       u8 descriptor;
> > @@ -218,7 +220,7 @@ static inline bool cppc_allow_fast_switc
> >   }
> >   static inline unsigned int cppc_get_transition_latency(int cpu)
> >   {
> > -     return CPUFREQ_ETERNAL;
> > +     return CPPC_NO_DATA;
> >   }
> >   static inline bool cpc_ffh_supported(void)
> >   {

