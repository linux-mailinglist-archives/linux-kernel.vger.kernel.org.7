Return-Path: <linux-kernel+bounces-897859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6ABC53D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C633AFC96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6934A3D3;
	Wed, 12 Nov 2025 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDnJu9Af"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503234A3B4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969930; cv=none; b=PjIT6ibhC+KtJQlmFINrTvvBKQ08ivga+h4GROmRESn/cC+vXWaoZnSLM56kNGFKxIRi/aDn9zmyXx81+MWzNV+dC8H3qFXzjwROVJXTYz9OGlv+MFxKygRFLDumkwGjH6wwD5vnm4WHYVMoT3zXmz4qeVoYKLcRM/T2cliKPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969930; c=relaxed/simple;
	bh=IEvwMKkKXtZ0S5o2YnRCpT0QBAI9Zo4ZHkRNv970Q+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0Iq+yQ6Zh3rh4HWtq1Aw/uB9JJavMRl8E1fU89kit2u1wXdOxztT/t0Sc/53w6wIV7OgI43aPv4QilY9ddHq3APCC9vuPZ7b8KniCdqEspeCJDTni2c3vZMHt4TfT3qQgow7gDGv7WWLi3z+Twf0+xLlcgSCwAqQJnkNNnVekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDnJu9Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9FFC19422
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762969925;
	bh=IEvwMKkKXtZ0S5o2YnRCpT0QBAI9Zo4ZHkRNv970Q+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WDnJu9Af99ZYWJ59d75P9C8QPUm+ssH1qPUtYo24Gddqg1PvKGoBOBnOV5FlTPmMv
	 VY3hyGROQvdYtzMKuAhH10gHwFb5hkLMy1z+MRdVklAc906pYKi4RRblERcPi7aUby
	 /V9AByUXe2PAeJkqDtBrLn8NcN41SWN1Wp//1LnWtQGAM491cWp3VU6M5ZTXYnLJ7i
	 WAAwameP2MtBrxoTFkd4Hjm7dVaiUpP6dq8qlkVcRyon6rkm1I/smE7t4lKXRpXNLr
	 J5sbty6H8ldzaJj6NeODQG+GRCGLluDOH+hCVVH6D2SSFdcxezO3uN32rL54t1YYtQ
	 zr44zBnjtS62Q==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-656e585587bso304865eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:52:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6K4ReephPIFEhxXZW7iWh6SR0bLoJcMHm64Namwv4X18TOWjqZAMj2mx1iOr+TM+6zTQ9CEeOJsaYlp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZ+WD9fPw63dtf0H/H51QyFqX133807k3a7KuHFp4DMux4pDf
	OmKTOQ6eioRZ9/aEckjZjgyKEvCwgSBCGM8GJIyrPMby/wrZ4uFI797Rz+Q5xjCPCRw1xOBOVwG
	8EyWyE8pAenjhjfOF4vK/I3+MXWyMqNA=
X-Google-Smtp-Source: AGHT+IFR3hyHgNt26OFh3wUxHI3FcE3zfaO/9A+tZKXN7bAZKVmFPcjRr/ln/hl75qJgJjehtDvvoMd+IZEGWc3HOrw=
X-Received: by 2002:a05:6808:2207:b0:44f:eb07:5042 with SMTP id
 5614622812f47-450745a8dd0mr1455737b6e.44.1762969924233; Wed, 12 Nov 2025
 09:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <3396811.44csPzL39Z@rafael.j.wysocki>
 <a5de1eca-494e-4624-a86b-bf917e562a08@arm.com>
In-Reply-To: <a5de1eca-494e-4624-a86b-bf917e562a08@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 18:51:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jcGsFh1ATM-Aw1oxZy-zazm+GaMUC4gwEaCskn9V-amg@mail.gmail.com>
X-Gm-Features: AWmQ_bmgEEYg_K8uXr1lAtgFDVf8su_16ZHt58HqVct8RHZz6xjsFZ1f5ysnV7Q
Message-ID: <CAJZ5v0jcGsFh1ATM-Aw1oxZy-zazm+GaMUC4gwEaCskn9V-amg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] cpuidle: governors: teo: Decay metrics below
 DECAY_SHIFT threshold
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 6:29=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/12/25 16:25, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If a given governor metric falls below a certain value (8 for
> > DECAY_SHIFT equal to 3), it will not decay any more due to the
> > simplistic decay implementation.  This may in some cases lead to
> > subtle inconsistencies in the governor behavior, so change the
> > decay implementation to take it into account and set the metric
> > at hand to 0 in that case.
> >
> > Suggested-by: Christian Loehle <christian.loehle@arm.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |   20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -148,6 +148,16 @@ struct teo_cpu {
> >
> >  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> >
> > +static void teo_decay(unsigned int *metric)
> > +{
> > +     unsigned int delta =3D *metric >> DECAY_SHIFT;
> > +
> > +     if (delta)
> > +             *metric -=3D delta;
> > +     else
> > +             *metric =3D 0;
> > +}
> > +
> >  /**
> >   * teo_update - Update CPU metrics after wakeup.
> >   * @drv: cpuidle driver containing state data.
> > @@ -159,7 +169,7 @@ static void teo_update(struct cpuidle_dr
> >       int i, idx_timer =3D 0, idx_duration =3D 0;
> >       s64 target_residency_ns, measured_ns;
> >
> > -     cpu_data->short_idles -=3D cpu_data->short_idles >> DECAY_SHIFT;
> > +     teo_decay(&cpu_data->short_idles);
> >
> >       if (cpu_data->artificial_wakeup) {
> >               /*
> > @@ -195,8 +205,8 @@ static void teo_update(struct cpuidle_dr
> >       for (i =3D 0; i < drv->state_count; i++) {
> >               struct teo_bin *bin =3D &cpu_data->state_bins[i];
> >
> > -             bin->hits -=3D bin->hits >> DECAY_SHIFT;
> > -             bin->intercepts -=3D bin->intercepts >> DECAY_SHIFT;
> > +             teo_decay(&bin->hits);
> > +             teo_decay(&bin->intercepts);
> >
> >               target_residency_ns =3D drv->states[i].target_residency_n=
s;
> >
> > @@ -207,7 +217,7 @@ static void teo_update(struct cpuidle_dr
> >               }
> >       }
> >
> > -     cpu_data->tick_intercepts -=3D cpu_data->tick_intercepts >> DECAY=
_SHIFT;
> > +     teo_decay(&cpu_data->tick_intercepts);
> >       /*
> >        * If the measured idle duration falls into the same bin as the s=
leep
> >        * length, this is a "hit", so update the "hits" metric for that =
bin.
> > @@ -222,7 +232,7 @@ static void teo_update(struct cpuidle_dr
> >                       cpu_data->tick_intercepts +=3D PULSE;
> >       }
> >
> > -     cpu_data->total -=3D cpu_data->total >> DECAY_SHIFT;
> > +     teo_decay(&cpu_data->total);
> >       cpu_data->total +=3D PULSE;
>
> This will result in total no longer being a strict sum of the bins.

Ah, good point.

> Any reason not to do something like:

Well, it would be more straightforward to just compute "total" from
scratch instead of using total_decay (it would be the same amount of
computation minus the teo_decay() changes AFAICS).

I'll send an update of this patch.

