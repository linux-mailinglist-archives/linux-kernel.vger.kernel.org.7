Return-Path: <linux-kernel+bounces-856911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CAABE569F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0BA540EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2C2E06C9;
	Thu, 16 Oct 2025 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMO/9uoz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE12DCC08
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647131; cv=none; b=gt8yf6cQ01pK78EtIWvFyhYxrMFGCoYZngAcKfZPfpJQDdpPUE3ZF9j65ILo/dmVs7EeLUqFBCphr6gt9lvIIhXgWMhBwSi64zKXJ9wEtljG5NWlRYnsHXzCwYCklkYY2MqFjsKFWigUwupYfwYwX0Z4T0bg9qkeKm/VjRfVOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647131; c=relaxed/simple;
	bh=XTIlb00y7jKvl1Otn5ZrCsdMlwiiEfx7RWVXZYlBVac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skrt4BV8lAY0OZLplW+cyn1fjPJOz9ERmWHXqbRrbiCs1QAwDTONGnNwQ0147qqFDce144JOM+UPYTPNe3oE2h1xCAT8NX9zd58Di1bSvRQIHEOMTBzaOfCqRYJwWXcYfhkZrwbJEI0GlmFIIe9FGivPid1OXgwF9+c0hunJ+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMO/9uoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A32C116D0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760647128;
	bh=XTIlb00y7jKvl1Otn5ZrCsdMlwiiEfx7RWVXZYlBVac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IMO/9uoz9402Rq/72H+fzGiweWdOTANK8n3P07wAJEwSUsdk1cojA6DdXdoUReOuM
	 9yRQuePM2+cOtswdJoYIhd/7qJV8nzqzQSJr2+dDcU5u4y1GrU+vcOIl/iZf87rDak
	 1COlMuvVJcUWEIg+dtRJ6YLOZPkcURXFwMbqrTAPjjlOi95k0KYUPg3eegkG/zv7BR
	 +nYcP+d7q9IMmogzk+uLypcyOnxtrMpX2A9mvGunrLvmyGD3Y02hiRRZ7aP6U22+13
	 OJxP5Q7aWOdRqJ+giiFiywbX8RpK9G0JyZn8Azgu8ZdjUv+A+sNGckCq0Jg7xWwDMu
	 RzhQzyAeNNRXA==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-43f5ec02724so354872b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:38:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXi72qhcAe6hmhWxyT2u5mUF44mzMv44dlBJJxCveoMhwzezpJwH60mbJCsI+3V5oMhYE8FxEWCUO+B4Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QfFXdHDxChm0Sko4eX7CNNIozasjhU7cMw1A2uGMUbMSXklE
	rNkeZt8lPHEV5Kc78chrv4+fj5oyY0DaTdZuxkoWAibUJSRFz3FVXRhlEVOnqJb5svi1iXTZg1x
	5xv8mk+y76DzXTYt6IiVhMSodnvrAXkI=
X-Google-Smtp-Source: AGHT+IHeni4wRtDvxXTKZAACGsTAPxwB1YyN0NYvoLAG+cyBLP79pAf7CDk+uKKMzHt4n9NJ/Pkc8WVtYd2NS5a16ZU=
X-Received: by 2002:a05:6808:6f8e:b0:43f:7dee:468b with SMTP id
 5614622812f47-443a2dcb6d3mr672131b6e.4.1760647127720; Thu, 16 Oct 2025
 13:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3925484.kQq0lBPeGt@rafael.j.wysocki> <cc21a74c-905f-4223-95a8-d747ef763081@baylibre.com>
 <875xce7m11.wl-tiwai@suse.de> <12765144.O9o76ZdvQC@rafael.j.wysocki> <68f14b5b6a92_2a2b10018@dwillia2-mobl4.notmuch>
In-Reply-To: <68f14b5b6a92_2a2b10018@dwillia2-mobl4.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 22:38:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZJFQeBhA7tM-sWuJDtisvrHGjPPdQHrC-eXXF1xJpbA@mail.gmail.com>
X-Gm-Features: AS18NWCN60rGQYTojeNqhxmPLJuY9IXf_MfoZ5rdwA1XGpcY1kgT-SGMUWeS1hQ
Message-ID: <CAJZ5v0iZJFQeBhA7tM-sWuJDtisvrHGjPPdQHrC-eXXF1xJpbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce PM_RUNTIME_ACQUIRE_OR_FAIL()
 macro
To: dan.j.williams@intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 9:45=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Rafael J. Wysocki wrote:
> [..]
> > > > [1]: https://lore.kernel.org/all/CAHk-=3Dwhn07tnDosPfn+UcAtWHBcLg=
=3DKqA16SHVv0GV4t8P1fHw@mail.gmail.com/
> > >
> > > Yeah, I myself also find it suboptimal, hence it wasn't really
> > > proposed...  It's a limit of macro, unfortunately.
> >
> > The macro from the $subject patch can be split along the lines of the a=
ppended
> > patch to avoid the "disgusting syntax" issue, although it then becomes =
less
> > attractive as far as I'm concerned.  It still allows the details unrela=
ted to
> > the rest of the code to be hidden though.
> >
> > ---
> >  drivers/acpi/acpi_tad.c |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/acpi/acpi_tad.c
> > +++ b/drivers/acpi/acpi_tad.c
> > @@ -31,6 +31,12 @@ MODULE_DESCRIPTION("ACPI Time and Alarm
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_AUTHOR("Rafael J. Wysocki");
> >
> > +#define PM_RUNTIME_ACQUIRE_ACTIVE(dev)       \
> > +     ACQUIRE(pm_runtime_active_try, pm_runtime_active_guard_var)(dev)
> > +
> > +#define PM_RUNTIME_ACQUIRE_ACTIVE_ERR        \
> > +     ACQUIRE_ERR(pm_runtime_active_try, &pm_runtime_active_guard_var)
> > +
> >  /* ACPI TAD capability flags (ACPI 6.2, Section 9.18.2) */
> >  #define ACPI_TAD_AC_WAKE     BIT(0)
> >  #define ACPI_TAD_DC_WAKE     BIT(1)
> > @@ -264,8 +270,8 @@ static int acpi_tad_wake_set(struct devi
> >       args[0].integer.value =3D timer_id;
> >       args[1].integer.value =3D value;
> >
> > -     ACQUIRE(pm_runtime_active_try, pm)(dev);
> > -     if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > +     PM_RUNTIME_ACQUIRE_ACTIVE(dev);
> > +     if (PM_RUNTIME_ACQUIRE_ACTIVE_ERR)
> >               return -ENXIO;
>
> This defeats one of the other motivations for ACQUIRE() vs
> scoped_cond_guard() in that it drops the error code from
> pm_runtime_active_try.

No, it doesn't.  PM_RUNTIME_ACQUIRE_ACTIVE_ERR is that error code.  Or
did I misunderstand what you said?

> Maybe it is the case that failure is always
> -ENXIO, but from a future code evolution standpoint do you want to
> commit to always translating _try errors to a local error code?

No, I don't.

> Btw, was acpi_tad_wake_set() buggy previously for ignoring
> pm_runtime_get_sync() errors, or is it a regression risk now for
> honoring errors?

You may call it buggy strictly speaking, but it just assumed that if
the runtime resume failed, the subsequent operation would just fail
either, so -EIO would be returned to the caller.

This change allows distinguishing resume errors from I/O errors.

