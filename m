Return-Path: <linux-kernel+bounces-878212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63DEC20095
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D86C463DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56BC2FB;
	Thu, 30 Oct 2025 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KP12CxvW"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BEAD5A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827571; cv=none; b=ithYRNDw7WnitkdXQXxh+nRJyj3shBKjqgEAGq2E21ICXi0DVGAWq+Ql6nigeFd+knN08fTu3Edi+a4C7a2GRyZJXXlr6UOJTd1zDcYkL2yf68K/rXani5q4yH3r7K/KYWBkzRzpcMN0janec+/XPAeHbnf0ydVM+3iT5BSEoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827571; c=relaxed/simple;
	bh=5uFh3plcA63WWwE8Rgd8BSWqIydPPVvm7ghEfQG37hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrt6qn29H8eLVTgSQgDvv2gULdIdKI/TdkPgiefyzPMx4UB/MiN0+vepoZzXf0qo8PuWpyrc6X/y3S4j6jcC/p++WqHIcCmWvjQtB5YGh7+ZRklo2CWXGNGYOAnFRuOv7EiRV9U+M1H5YrP6kBk4rTo93OraBzkAcnptUOQv054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KP12CxvW; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-783fa3af3bdso12908257b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761827569; x=1762432369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFq/TRCdCKks5FxRPsMVAHG1xUcLxQtFXtn1mAIRjKU=;
        b=KP12CxvWB5Ox7B+kI1PtveGtnSHuFa0140MzsKHOzf8v0ZvjpxWBx4pmoaIosm7roY
         WoBFd8su39ZUbrTJuRJTEbofRB677bGv5KmlCwyymTThrSBxbPASuA3eeiX05fpYazu2
         RKdYABSKA/lewZXlw192hfn9n34o87wdZFOnOqF2XHxQVDnFyII9qFLXpVEdzAJMVoA8
         c+pItifKapi7D14QTMT/lngzIXp6X+ygZe4mEDXLe+4FP3jQ0R61darm8G1CQBuV2O7I
         KlMEaFFLwXWS6cqLRa9N48kGitx6RM7qItAT86Ng39cGLMtry0pnThAWDgqt2HUwnGUa
         9LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827569; x=1762432369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFq/TRCdCKks5FxRPsMVAHG1xUcLxQtFXtn1mAIRjKU=;
        b=nATBmIHzElSEGbdEueJ6tS9mttEkoSrXSDyRX6pRcj4WAPL+Lyqn25gSzqLVnmPefw
         CldZAqobau4xVqIzMmmII0CZ04F1AMY9YaLRTQniaKCa1i+h9vrmSBsqPRZ3VNuwMzT+
         ZQmWyLxdyn5YSrw35Y0q+IUgxPJtsMBdjrXEO+Jm0InuZHHFCba3NKKRqx/Uw9NiVpB/
         np6VZUvC9rPy0HeUK5chl3fxPYvbpiAraf6wmvpeO+q4EaINQ4HVQ0UxQrddaqxXrjUt
         92c4PmLqT1lhkcYD/LDAJ7HBWwBbL9Qcflpzz8YQHdgJ47Bq0mC6b544MUGyIoDR+G0E
         tDFg==
X-Forwarded-Encrypted: i=1; AJvYcCXlEQTgCLewwcZR/xBzPlmFNlOJ8WCbeQyMfI8YxH5XZtZ9u7MO7h11dO1cjNklf+LeRhXBUtIfdCDXxbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWAwbP90HVVbpWHNoeY14RVp5Pxye8ZZl8W8svdfC6R7pyLfG
	D1Ef2846uXKGrlcPuGdiT0Olqm3tARzkWvSIBs1UFaPJsQIpBU1GQ/VhMdBl6r7yGfCupIC+pCO
	Z27c+6kkjYUtSAB9WVvFo80R2QC1eL50yjUmvraQ+5A==
X-Gm-Gg: ASbGncsj/xid2LdCQ0mfkpYCRr/r3Rsr9Luiy6FUXInw4e1vy9T4yQj9WB5uXs3fTk+
	oIG016KCVvDmt1NB2PoVAAmi73EFnTBtnwys9wQH7PlYxtbqW4bv6pC4siPCQk0ThCSGXwthNk0
	LeH7FUer3ECmePRdxRUMWRiX3gJJFJy3uDJlNjZcOCYjE63fRbnKYThBjtJI3eYQdfS4URyCv6T
	KPRvdG2jhNWPqTXXI79pHA7/8HED1AdbNBKibLzb/6R/F/tzjIYK7s0PuBfkQ==
X-Google-Smtp-Source: AGHT+IGipO+I2seDTk/l/U6a3TYUm/dJfVO/MALsQ33bjRkdY68Wqj5U+OL4febm6PhGK715PrdgZGcHUZRLSiPCJmE=
X-Received: by 2002:a05:690c:338b:b0:77e:47b:e847 with SMTP id
 00721157ae682-78628fa8e2emr62662197b3.46.1761827568989; Thu, 30 Oct 2025
 05:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org> <CAJZ5v0hPUYoLFs=jZ10a1cX6TE1bmRF7CkBH1Ebejao9Hdfhnw@mail.gmail.com>
 <CAPDyKFrrhw5vMYLEWJ5LRphVzwPwjiU-n=tdbgOtOmFSXGd0GQ@mail.gmail.com> <CAJZ5v0g5p-8WrmNQ6-tvTEy50gVjfEMsmXxTK8bmLqafe30jKw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g5p-8WrmNQ6-tvTEy50gVjfEMsmXxTK8bmLqafe30jKw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 13:32:13 +0100
X-Gm-Features: AWmQ_bl_qGRm7dJwQHdZBBFxNH0sxFuH3rclcytMluLaIPUXly734ZrKPicvB5s
Message-ID: <CAPDyKFo+U=oJVxXCDBN_WZLBpkwPgv_=qw96hauAttFnAQuPtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit
 during s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 at 13:23, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 1:00=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 30 Oct 2025 at 11:45, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > A CPU system-wakeup QoS limit may have been requested by user-space=
. To
> > > > avoid breaking this constraint when entering a low-power state duri=
ng
> > > > s2idle through genpd, let's extend the corresponding genpd governor=
 for
> > > > CPUs. More precisely, during s2idle let the genpd governor select a
> > > > suitable low-power state, by taking into account the QoS limit.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > >         - Limite the change to the genpd governor for CPUs.
> > > >
> > > > ---
> > > >  drivers/pmdomain/core.c     | 10 ++++++++--
> > > >  drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++++
> > > >  include/linux/pm_domain.h   |  1 +
> > > >  3 files changed, 36 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > > index 61c2277c9ce3..4fd546ef0448 100644
> > > > --- a/drivers/pmdomain/core.c
> > > > +++ b/drivers/pmdomain/core.c
> > > > @@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(struct gene=
ric_pm_domain *genpd, bool use_lock,
> > > >                         return;
> > > >         }
> > > >
> > > > -       /* Choose the deepest state when suspending */
> > > > -       genpd->state_idx =3D genpd->state_count - 1;
> > > > +       if (genpd->gov && genpd->gov->system_power_down_ok) {
> > > > +               if (!genpd->gov->system_power_down_ok(&genpd->domai=
n))
> > > > +                       return;
> > > > +       } else {
> > > > +               /* Default to the deepest state. */
> > > > +               genpd->state_idx =3D genpd->state_count - 1;
> > > > +       }
> > > > +
> > > >         if (_genpd_power_off(genpd, false)) {
> > > >                 genpd->states[genpd->state_idx].rejected++;
> > > >                 return;
> > > > diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governo=
r.c
> > > > index 39359811a930..bd1b9d66d4a5 100644
> > > > --- a/drivers/pmdomain/governor.c
> > > > +++ b/drivers/pmdomain/governor.c
> > > > @@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct dev_pm_do=
main *pd)
> > > >         return false;
> > > >  }
> > > >
> > > > +static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
> > > > +{
> > > > +       s64 constraint_ns =3D cpu_wakeup_latency_qos_limit() * NSEC=
_PER_USEC;
> > >
> > > I'm not sure why genpd needs to take cpu_wakeup_latency_qos_limit()
> > > into account directly.
> > >
> > > It should be told by cpuidle which state has been selected on the CPU
> > > side and it should not go any deeper than that anyway.
> >
> > For PSCI OS-initiated mode, cpuidle doesn't know about the states that
> > may be shared among a group of CPUs.
> >
> > Instead, those states are controlled through the PM domain topology by
> > genpd and its governor, hence this is needed too.
>
> All right, but I'd like to understand how all of that works.
>
> So cpuidle selects a state to enter for the given CPU and then genpd
> is invoked.  It has to take the exit latency of that state into
> account, so it doesn't go too deep.  How does it do that?

Depending on the state selected, in cpuidle-psci.c we may end up
calling __psci_enter_domain_idle_state() (only for the deepest
CPU-state).

For s2idle this means we call dev_pm_genpd_suspend|resume(), to manage
the reference counting of the PM domains via genpd. This then may lead
to that genpd_sync_power_off() tries to select a state by calling the
new governor function above.

Did that make sense?

Kind regards
Uffe

