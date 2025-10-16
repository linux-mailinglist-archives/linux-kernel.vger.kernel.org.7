Return-Path: <linux-kernel+bounces-856300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34161BE3C99
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11D8587827
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA96233CE8D;
	Thu, 16 Oct 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC3i29v1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F333A000
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622383; cv=none; b=hOrfnyay2s2deuAwAWMdvqSJ3GdZ2Ry7GrpsCbFnVwmfzi50nms8kI/y2D8IRq1c2F2djXzZq84afGJXqim5gRxzFFtzHxt0z7f98yyjo1zvXq+aO02wXkyRl0Dlec2XGHbVzy8BFKj5ELiRlc96qLlQGJtwr7UF7Jfl2IYP7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622383; c=relaxed/simple;
	bh=tMxcPuGwuLUpPoCOHZ6LWoXb/WVXi4h323tKWEKMzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRslEB835Z9jMsVxdwZ6Js4oTGgPMJ62f0aKI7fffGiaIl9GHlIqckEgkJIudK9Lp12qFHxwtlW1pAfywm9wss1ONL7f56kOx7n4rqETzDZdyvFswRDHKXlKuKP9tCwLZhsAAXb8iNVg4lckz3AemnIF/8VF+q1KTvMuCNwiTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC3i29v1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82124C113D0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622381;
	bh=tMxcPuGwuLUpPoCOHZ6LWoXb/WVXi4h323tKWEKMzn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZC3i29v1RfmWeQX1uVXYwoOI1dKKcSlrkEqNGvUo9Buq2tOyGeJJm2B4ULzW0jMTr
	 l0VUSlaKv1gzv5vw0Rild9VFmOeQ/Z7RBuruVcjqDM8mCWWc0h+FsP9e98t6UE3R54
	 LtSbC8LVUxcbAJ9C2JfWwWS0fpnq+eB+r5bgAufC2T+4bYjV4QFZiDpHx4T8YmSqIq
	 zBtXZjz+ZOnL1jfIa55HHJaD2I/fjHstp+j8kRj8js8f8Pm5znGgD1yA4oTRi26E03
	 LIRhdKTrkmgM7Q+MKEaIJoPDtmCXbIc+xbW9qbN9XPwkYhJ4Oe+tqodKbDttBchSRP
	 QJMvc4DLx4Q9w==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-43f5ec02724so199683b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:46:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSsXw7fUakxSzyhnZ2FLYHf6ad3MAnnd/Fv7lEXHVzWAbeCRNoE2nsy2Kzk4lPErmhS9cORD057VwWWCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw87qvICoJlm92qJfg2l76KN650nbd1pwvOTK4YNrvWXJL1ueqZ
	sYr0AWDEX7+qPK7JT9+uFVXxmYtlMW2S+7iFhbEz+dVrp1ZayNrBImhAW59+bM2mG2unujpSWtG
	n62/G44qlje8FEY0f2O4/EBbULKcnGIA=
X-Google-Smtp-Source: AGHT+IGNpDvdbfMF/ojpo404yFHPwlo8zyB49tme8au/V56k35i9OcW7iRSzjPWO2Z+u16JztAmb7N7GhuPDdN/OHfA=
X-Received: by 2002:a05:6808:d4d:b0:438:1c76:d4f with SMTP id
 5614622812f47-443a2dcb39cmr11374b6e.1.1760622380661; Thu, 16 Oct 2025
 06:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3925484.kQq0lBPeGt@rafael.j.wysocki> <3324926.5fSG56mABF@rafael.j.wysocki>
 <20251016133854.00003669@huawei.com>
In-Reply-To: <20251016133854.00003669@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 15:46:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iOgbkJbdRzgrBUaaYL+S_8BZD7XuXdK5vs2gMG3ug1KA@mail.gmail.com>
X-Gm-Features: AS18NWDdA7ceaQNIn3tLRiO6POzixzerQYrFJNt6R37gxd8BNcn9DO5TUk4qpTY
Message-ID: <CAJZ5v0iOgbkJbdRzgrBUaaYL+S_8BZD7XuXdK5vs2gMG3ug1KA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce PM_RUNTIME_ACQUIRE_OR_FAIL()
 macro
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, David Lechner <dlechner@baylibre.com>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:39=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 15 Oct 2025 16:02:02 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There appears to be an emerging pattern in which guard
> > pm_runtime_active_try is used for resuming the given device and
> > incrementing its runtime PM usage counter if the resume has been
> > successful, that is followed by an ACQUIRE_ERR() check on the guard
> > variable and if that triggers, a specific error code is returned, for
> > example:
> >
> >       ACQUIRE(pm_runtime_active_try, pm)(dev);
> >       if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> >               return -ENXIO
> >
> > Introduce a macro called PM_RUNTIME_ACQUIRE_OR_FAIL() representing the
> > above sequence of statements that can be used to avoid code duplication
> > wherever that sequence would be used.
> >
> > Use this macro right away in the PCI sysfs code where the above pattern
> > is already present.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Admittedly, the new macro is slightly on the edge, but it really helps
> > reduce code duplication, so here it goes.
>
> Fully agree with the 'on the edge'.
>
> This looks somewhat like the some of the earlier attempts to come up with
> a general solution before ACQUIRE().  Linus was fairly clear on his opini=
on of
> a proposal that looked a bit similar to this
> cond_guard(mutex_intr, return -EINTR, &mutex);
>
> https://lore.kernel.org/all/CAHk-=3Dwin7bwWhPJ=3DiuW4h-sDTqbX6v9_LJnMaO3K=
xVfPSs81bQ@mail.gmail.com/
>
> +CC a few people who might have better memories of where things went than=
 I do.
>
> The solution you have here has the benefit of clarity that all it can do =
is
> return the error code.

Well, I could call the macro PM_RUNTIME_ACQUIRE_OR_RETURN_ERROR(), but
FAIL is just shorter. :-)

Seriously though, the odd syntax bothers me, but it has come from
looking at the multiple pieces of code that otherwise would have
repeated exactly the same code pattern including the guard name in two
places and the pm variable that has no role beyond guarding.

> > ---
> >  drivers/pci/pci-sysfs.c    |    4 +---
> >  include/linux/pm_runtime.h |    5 +++++
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1517,9 +1517,7 @@ static ssize_t reset_method_store(struct
> >               return count;
> >       }
> >
> > -     ACQUIRE(pm_runtime_active_try, pm)(dev);
> > -     if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > -             return -ENXIO;
> > +     PM_RUNTIME_ACQUIRE_OR_FAIL(dev, -ENXIO);
> >
> >       if (sysfs_streq(buf, "default")) {
> >               pci_init_reset_methods(pdev);
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -637,6 +637,11 @@ DEFINE_GUARD_COND(pm_runtime_active_auto
> >  DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
> >                 pm_runtime_resume_and_get(_T))
> >
> > +#define PM_RUNTIME_ACQUIRE_OR_FAIL(dev, error)               \
> > +     ACQUIRE(pm_runtime_active_try, __pm)(dev);      \
> > +     if (ACQUIRE_ERR(pm_runtime_active_try, &__pm))  \
> > +             return error
> > +
> >  /**
> >   * pm_runtime_put_sync - Drop device usage counter and run "idle check=
" if 0.
> >   * @dev: Target device.
> >
> >
> >
>

