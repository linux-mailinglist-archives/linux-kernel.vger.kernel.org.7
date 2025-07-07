Return-Path: <linux-kernel+bounces-720167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62716AFB811
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26511898E10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB969221264;
	Mon,  7 Jul 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mknh5w67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C81D5145;
	Mon,  7 Jul 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903840; cv=none; b=SzbX9He15/a+xOk5pkVHWiqxLRei2fYq605qIa8ncW0iFnMppN8dVT64qZ+Sy5jIDSFcmSIjwwmP21zGqtibIzLaOqjWdiK/vFOLLfYqw+adqyiw97DKpdyEBsCVKf82S4XmYTOYTWwIxsHVwhOO5RfXGPDsfkAi7zyJNq/k2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903840; c=relaxed/simple;
	bh=cOPqcxIf5X1X2HD8wmgQa984+uwttfeDa/9MRlym0cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7rLN7J6xTHJdpSwfwRtBeFEL509s7eGXNGJyy65Fo5vId++Pr3PHVU/54dtzXIZ+mhZDooW6S9zrhZnSph6mewcQglUPJRtmn5fAVeaGy+Q8Sb3CFWLZZ78mZcRRqHt6ImqQmjQhAbkFrNQJXlyQF0N3t04yTpRg1U93WLDJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mknh5w67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2091C4CEF4;
	Mon,  7 Jul 2025 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751903839;
	bh=cOPqcxIf5X1X2HD8wmgQa984+uwttfeDa/9MRlym0cc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mknh5w67+oZcvYnxfTf5SObhpeuygcV7+wQz5THrA095mP+3YluTKI25/pX/5q7md
	 xuS3Dtw4Itai3fUbwgqBdG58BnqHNU+JrduGTPp4lf5eDfCaBb71WZbJJx6x4EzQPq
	 fbGVoqBexCC8dpSY+SNzDZGxYBOt1j4s1HA4iPykrdk+V6wW4npZqMi5vSaMuL2r0r
	 rDByPDjxeZ9xDGVOyexH93aEtOFtbal35NL0LYFZvnR/chJYTL4xdPCTldNi7Y9R3G
	 w2aGrnLdc/+FYZZzESNhltUKMTtiFQhGVn7Uak8e1zEIzblSNciqmosLm4sADWhFIF
	 tjgy7FxVeXzaA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae36e88a5daso686256266b.1;
        Mon, 07 Jul 2025 08:57:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULJKOeMxwDV2boJGDHKEjDSe9O1aVV8gFCLbHcELkcEv4s2l64s2Hq7q4SsMo9kiiBjRwvl7xdVCj0JS6H@vger.kernel.org, AJvYcCVO2KEwHAlX1eyZoUUSWY9KMfq3LDoY31yxidVG7YodFbHkSIMiNACaLLoJcIrMuwppOGQBmCaQAQA=@vger.kernel.org, AJvYcCXDIqZS6FzCOqr1d3/Bo18EpOVeDynHidBpftjsokBD4mXmrAPZdUCH+Adkv4YUBTpzX4nb3pbGZ0gTbVlkfT2hVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzden3scLFiFwiuSRnwnP8HKxh4MlgpkUkaXfAznc1vuxwD1Xkh
	51rGrJrLuW+8tpcWesnGrcR6/0P2EbPsNJH8+QU7vsQ2jAlv2/1wLompOPDRzCwMdAMXc4CxSmE
	bi8Bk4V+s4T0j7mNTVnn3gUUPuqx8gQ==
X-Google-Smtp-Source: AGHT+IGROcI/rOerYv7nZXlhWEmc4bo4VMMhzIieXt0ir3fuJoe5yHNFs/XUqQmhE3pqqxvZ92DyoWse/8P+jtjd2j0=
X-Received: by 2002:a17:906:6a08:b0:ae3:c6a3:f833 with SMTP id
 a640c23a62f3a-ae3fbcb576amr1339358466b.23.1751903838354; Mon, 07 Jul 2025
 08:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-arm-brbe-v19-v23-0-e7775563036e@kernel.org>
 <20250611-arm-brbe-v19-v23-4-e7775563036e@kernel.org> <aGgM4Pk5dU1LXd2I@J2N7QTR9R3>
In-Reply-To: <aGgM4Pk5dU1LXd2I@J2N7QTR9R3>
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 Jul 2025 10:57:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKPjQE99d27pBHffo=K6stT1QaaeVyeqSeRKa9m8OSmxw@mail.gmail.com>
X-Gm-Features: Ac12FXxiERhwrk8TwYBiCk2nTj5uV-39ekDgmaoI7v4X8_oFWq7oDAhMnIvdJ90
Message-ID: <CAL_JsqKPjQE99d27pBHffo=K6stT1QaaeVyeqSeRKa9m8OSmxw@mail.gmail.com>
Subject: Re: [PATCH v23 4/4] perf: arm_pmuv3: Add support for the Branch
 Record Buffer Extension (BRBE)
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, James Clark <james.clark@linaro.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Leo Yan <leo.yan@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 12:18=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> Hi Rob,
>
> Thanks for this; I think this is in good shape now. There's a couple of
> thing I think we should fixup, described below and diff provided at the
> end of this mail. That aside I reckon we should apply this shortly.
>
> Will, are you happy to apply that diff when picking this up?
>
> On Wed, Jun 11, 2025 at 01:01:14PM -0500, Rob Herring (Arm) wrote:
> > +/*
> > + * BRBE is assumed to be disabled/paused on entry
> > + */
> > +void brbe_enable(const struct arm_pmu *arm_pmu)
> > +{
> > +     struct pmu_hw_events *cpuc =3D this_cpu_ptr(arm_pmu->hw_events);
> > +     u64 brbfcr =3D 0, brbcr =3D 0;
> > +
> > +     /*
> > +      * Merge the permitted branch filters of all events.
> > +      */
> > +     for (int i =3D 0; i < ARMPMU_MAX_HWEVENTS; i++) {
> > +             struct perf_event *event =3D cpuc->events[i];
> > +
> > +             if (event && has_branch_stack(event)) {
> > +                     brbfcr |=3D event->hw.branch_reg.config;
> > +                     brbcr |=3D event->hw.extra_reg.config;
> > +             }
> > +     }
>
> I see that in v20 you moved the brbe_invaliate() form here into
> brbe_read_filtered_entries(), when entries are read upon an event
> overflowing. The changelog says:
>
> | Rework BRBE invalidation to avoid invalidating in interrupt handler
> | when no handled events capture the branch stack (i.e. when there are
> | multiple users).
>
> I don't think that's quite right. Since BRBCR_ELx.FZP causes a freeze
> BRBFCR_EL1.PAUSE to be set when *any* event overflows, not discarding
> across an overflow or other transient disable/enable can introduce a
> discontinuity in the branch records.

My thought was the discontinuity is samples from the PMU interrupt
which we don't want to sample anyways, so better to keep samples from
prior to the unrelated interrupt.

> The rationale for doing the invalidation here was to avoid the
> possiblity of any such discontinuity, and to do so simply, at the cost
> of discarding records in some cases where we could theoretically keep
> them around.

That's fine by me as well. It probably doesn't really matter much in
practice as you would have to get 2 PMU interrupts fairly close
together to lose samples (from before the first interrupt).

>
> I would prefer the invalidate to be performed within brbe_enable()
> (before the actual enable/unpause), and for armv8pmu_restart() to be
> folded back into armv8pmu_start().
>
> I've provided a diff/fixup at the end of this reply.

Thanks.

Rob

