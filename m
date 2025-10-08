Return-Path: <linux-kernel+bounces-845349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C1DBC489F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 780AC4EF90A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060442F6180;
	Wed,  8 Oct 2025 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX4a40xh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695A2F6164
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922627; cv=none; b=k6gXnob5SYtuCaCQzrfXXjwyqo0LHmsL9jheA/TzG8bMpf332o5KoNq6/rn2CvlsUGc0V0jo5u95lBNYZO2VW9foVIBgDihQCx/WNmO51jViW8jVQu8W9iJmknMSTAmSDiH3GiGoY95yfK4H6b5euPtbyUzjohFED+sMIA6iZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922627; c=relaxed/simple;
	bh=KEhEuKwCPJ3dLWcFCbexBiSGqiFxn45TrcIsnxqvYiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlqfofhQnOY9s8SJRi3el6A7VTVNc/jKLDtpMNvAy6WjyIYAySyKfZIEjTZ1nsDmAGPbAo4Aj8MhyHZ7L5KU1SPq9+54WLudeOyMUJYoVTg6ew8I5wwmC/VU6a4R/2BRU6TRDMznySMaPGU1JhxI1+Oh2Ai7AVXiKbCqx4oDZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX4a40xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2EDC113D0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759922626;
	bh=KEhEuKwCPJ3dLWcFCbexBiSGqiFxn45TrcIsnxqvYiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NX4a40xhNABgkz8Z6R4NxHZTvgo+0Pl0SBI1/3/MBCIgLwjbC3DX22waCZbvr+zoc
	 MKOuZHZ7vuBgQnXYr0pacrBsO1k4QySTbJXUsr429nqF+LX511+AaEi4vkWrQtihLH
	 XNWzvGZZ5o/M1npyU9eOHq3mNw2YD5Pq6m/XEVOD1lpnBMOS6HoIvaxpBI3X7bx5n+
	 0B5M5GZ1x3f/MjP2m1zbFiU5HNLSQZOvOIDtlebMtMjuw7FML6RK1WoeErIGEPBv8D
	 WLbmp3rMqDWaI3wmnhynko12/BTqMSyTbAnGtFmzG1WXWXn3Y2O/7rMb3aOIMx7K97
	 Z25KQjg+6DtmQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-43f494764a2so3763970b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:23:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3L3ys/HGkVZQLF4ny1N3qt7S0IR7JmL8oAO9MtqxnOYCyQGtaln8wnkmheOGzZBxIf9NP3Q6VwgcpwDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCyM1ZaMriTIH3niEMMEWOj1LRYVR5/3UbRJFljkwY1dVQDL7y
	fqjEFiUGi86e0oyQ5vUkXJagbkY52qOaoftw9uL3f89k0K58AHAAWUlqkU5Slwwnz5eeuT6doyi
	UgHVRZSaSaL7LS0gEEQWaXiJmICfiuGU=
X-Google-Smtp-Source: AGHT+IFfHZ8HGqxj7f466AKKrLHNXLEqnoShIi3UA9a8omxTcg0b+75+V45dqCAudPzoBHdRpOZxL0eWLd6272/GIuA=
X-Received: by 2002:a05:6808:2201:b0:43f:ac2d:dd3a with SMTP id
 5614622812f47-4417b38ffd3mr1450551b6e.26.1759922626108; Wed, 08 Oct 2025
 04:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007063551.3147937-1-senozhatsky@chromium.org> <20251008101408.dj46r66gcfo26sgl@lcpd911>
In-Reply-To: <20251008101408.dj46r66gcfo26sgl@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Oct 2025 13:23:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
X-Gm-Features: AS18NWDaaxCc6gY2WMGLj5YvkDBRtJ44YZ9x_aKJx5HSqrLThkqUCL3iGoGDloo
Message-ID: <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
To: Dhruva Gole <d-gole@ti.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 12:14=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Oct 07, 2025 at 15:35:40 +0900, Sergey Senozhatsky wrote:
> > Add dpm_watchdog_all_cpu_backtrace module parameter which
> > controls all CPU backtrace dump before DPM panics the system.
> > This is expected to help understanding what might have caused
> > device timeout.
>
> This will indeed be really helpful for debugging some nasty bugs!
>
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/base/power/main.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index e83503bdc1fd..7a8807ec9a5d 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/cpufreq.h>
> >  #include <linux/devfreq.h>
> >  #include <linux/timer.h>
> > +#include <linux/nmi.h>
> >
> >  #include "../base.h"
> >  #include "power.h"
> > @@ -515,6 +516,11 @@ struct dpm_watchdog {
> >  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
> >       struct dpm_watchdog wd
> >
> > +static bool __read_mostly dpm_watchdog_all_cpu_backtrace;
> > +module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> > +MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> > +              "Backtrace all CPUs on DPM watchdog timeout");
> > +
>
> Have you considered runtime configurability instead of a module param?

This one can be updated at run time AFAICS.

