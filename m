Return-Path: <linux-kernel+bounces-812130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922A3B53356
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444C43A9BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB4324B06;
	Thu, 11 Sep 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mDwHVcIS"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618C322DBF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596316; cv=none; b=NWyZkzDe2/9+1eOx1VY14oB0OMCg4aDySsAJZXqizo2tOxdYmcGe03btm5hqHssjrPulidZSyQLN2rVP8fWpLmQWOO0tJBNI4d927F5NdPJTGFtmtVXzUBpDOn9vzKDkU5Wv5fCUfBZ7cmmBYVzRrawPikuSoiLLdc07hrGkmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596316; c=relaxed/simple;
	bh=30pB732dvSpD7q9dayDM+pXUhrONIOSAV4FQZ3pY/bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiRjjf2vFaKxDXVRalCnp9dNY5y7upOpt/U4qx+Tz6gNesU+ZxDz6TvgunivrBy5Q9ZwYiUuDV4BX0qj0iJGjWVOsZPo03oKqz8babTJSn/J+VOXPgIpi9bteDBlG3lPwd8nZ7fr4cdB1HowYAbJ9kBtRmMghpV8FiFgrAyZ5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mDwHVcIS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77264a94031so499101b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757596314; x=1758201114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnSNIIsGL0QJkjBq8jSkEXlDvUKET4SzWDX+G39CnUc=;
        b=mDwHVcISy1YsoiV/4uiRD0LyKG7cNVTiByao5QD8ztyXxc6MKB3WJfyvA6r7qGFvjy
         iafL7nK7+rodTFAUHJM/v4I0uFMpbtYJG/QCRSU1QFgfAbnPyg/svhwtJ+Mr59RAvFM4
         c6Ae6UTBzNkA13BDiH1PgBmghEma/ZOmZiZ/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596314; x=1758201114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnSNIIsGL0QJkjBq8jSkEXlDvUKET4SzWDX+G39CnUc=;
        b=PtIwsOW6puWotq0C7jQJlIh7QOEB2YPaA8+cEAEtEO3N42XkcHcSYVcoaKcvIr5/Ia
         qsN8VOuNH7j0WzjQ2EYEKlywoG8lLOQHFAjDb+XmX2Le+hLSCcubIguD0z9ej4Fs0U6h
         NFuOI/2YZmwnqUk8sqVpwD4f1+bGFiN/s+vPY0UpQX/qY5uFZaGT6iDrtpXOqbIYHwyL
         6JRolJoVcdqKvrZe4SRorLOTMITroUpzhacAdwK+skKvYTUfuEO+l7r3a3McjriHmHLg
         zeA2ZtX0v3fdfKXx+hDznuXcWqr87RIxY2XWafjzN0BO+Nrcxov6TpwCHPZ/+zNHzu0v
         GHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5D962F/32eOG+m0SKSsoQDG/iy6ZbgaVp/nK+nIXXKWNfjX6EUk0bVhRzxJvnpwcUrlEpefbyVxqlzhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFA5wRrxdWXjEWKuEz4OYPgt23Uw5kB3mxFI+dH0q/eRocpTpr
	MjHH/UlpkqLUlxI54nLUvxpEAb+xEo1SebKo5u/I+vo+tToXZpw0B8ow58fEDyD5tZWDghWqHor
	E+hDggMsq7sLgWU4+WXcfbjKu7wS6cs3gD8DXVjCxmMmcRk0JjUf8lw==
X-Gm-Gg: ASbGnct/uZPjt5J7NPHlc0O6N2sUwgO5sn38lxRYeGYZvyVFEUGiRwq/D/IF4mUbJON
	4wOiKWAERAYvLgncjohM76DYJ3CLwu86AvfL8MiVcNYbNENOquVz7lUBmQjHjXBnHcKqgvUCPsK
	QOZJ7RoNjA8X2EIQkZQ4u2n9Oc81FZ2inqOuo/bP+hHQTKXV/Nq/SWxlTJXlBvDQpw96IHMo4lo
	oqm3wZa7swkNW55+pH5/rwA4nN6+U6G9PxvZvC3A/Oe6L2ggx7S5Dc=
X-Google-Smtp-Source: AGHT+IHR54Uv5sXhW+5shf/e3Iiyri5rkGm2hFV6EnjQ5+AlLih9aJbCpQzAuzZp0og02D4GvJMm+sWCl2kESSa5I8I=
X-Received: by 2002:a05:6a20:3d86:b0:246:2c:114 with SMTP id
 adf61e73a8af0-25344eb93afmr26429539637.47.1757596314440; Thu, 11 Sep 2025
 06:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-5-akuchynski@chromium.org> <2025091029-snarl-decimal-aea2@gregkh>
 <CAMMMRMdOiGQdmgQ7COa1Nf9Rh9BQLD79TJ77VW4ejadx_bNyeg@mail.gmail.com>
 <2025091117-herring-crazy-d13c@gregkh> <CAMMMRMck=YzbN6g8-4qUx=YX+=S4HgKqHaYoUuQ0CsJUYd9GOw@mail.gmail.com>
 <2025091106-absinthe-wired-46e1@gregkh>
In-Reply-To: <2025091106-absinthe-wired-46e1@gregkh>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 11 Sep 2025 15:11:42 +0200
X-Gm-Features: Ac12FXwDdn8PkIV1mAEGV9zdRk_SAvSLLC0n5M-9uhIiVaVM3a1PTUDPbf_ZL3A
Message-ID: <CAMMMRMdT9SV-o1+JitQ6iopd4kyn3KcWsfB7-_4FoXKeDMZbqQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] usb: typec: Implement alternate mode priority handling
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:41=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 11, 2025 at 10:46:52AM +0200, Andrei Kuchynski wrote:
> > On Thu, Sep 11, 2025 at 7:07=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 07:35:42PM +0000, Andrei Kuchynski wrote:
> > > > On Wed, Sep 10, 2025 at 1:31=E2=80=AFPM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Fri, Sep 05, 2025 at 02:22:05PM +0000, Andrei Kuchynski wrote:
> > > > > > This patch introduces APIs to manage the priority of USB Type-C=
 alternate
> > > > > > modes. These APIs allow for setting and retrieving a priority n=
umber for
> > > > > > each mode. If a new priority value conflicts with an existing m=
ode's
> > > > > > priority, the priorities of the conflicting mode and all subseq=
uent modes
> > > > > > are automatically incremented to ensure uniqueness.
> > > > > >
> > > > > > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > > > > > ---
> > > > > >  drivers/usb/typec/Makefile         |  2 +-
> > > > > >  drivers/usb/typec/mode_selection.c | 38 ++++++++++++++++++++++=
++++++++
> > > > > >  drivers/usb/typec/mode_selection.h |  6 +++++
> > > > > >  include/linux/usb/typec_altmode.h  |  1 +
> > > > > >  4 files changed, 46 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 drivers/usb/typec/mode_selection.c
> > > > > >  create mode 100644 drivers/usb/typec/mode_selection.h
> > > > > >
> > > > > > diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Mak=
efile
> > > > > > index 7a368fea61bc..8a6a1c663eb6 100644
> > > > > > --- a/drivers/usb/typec/Makefile
> > > > > > +++ b/drivers/usb/typec/Makefile
> > > > > > @@ -1,6 +1,6 @@
> > > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > >  obj-$(CONFIG_TYPEC)          +=3D typec.o
> > > > > > -typec-y                              :=3D class.o mux.o bus.o =
pd.o retimer.o
> > > > > > +typec-y                              :=3D class.o mux.o bus.o =
pd.o retimer.o mode_selection.o
> > > > > >  typec-$(CONFIG_ACPI)         +=3D port-mapper.o
> > > > > >  obj-$(CONFIG_TYPEC)          +=3D altmodes/
> > > > > >  obj-$(CONFIG_TYPEC_TCPM)     +=3D tcpm/
> > > > > > diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/t=
ypec/mode_selection.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..2179bf25f5d4
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/usb/typec/mode_selection.c
> > > > > > @@ -0,0 +1,38 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * Copyright 2025 Google LLC.
> > > > > > + */
> > > > > > +
> > > > > > +#include "mode_selection.h"
> > > > > > +#include "class.h"
> > > > > > +#include "bus.h"
> > > > > > +
> > > > > > +static int increment_duplicated_priority(struct device *dev, v=
oid *data)
> > > > > > +{
> > > > > > +     struct typec_altmode **alt_target =3D (struct typec_altmo=
de **)data;
> > > > > > +
> > > > > > +     if (is_typec_altmode(dev)) {
> > > > > > +             struct typec_altmode *alt =3D to_typec_altmode(de=
v);
> > > > > > +
> > > > > > +             if (alt !=3D *alt_target && alt->priority =3D=3D =
(*alt_target)->priority) {
> > > > > > +                     alt->priority++;
> > > > > > +                     *alt_target =3D alt;
> > > > > > +                     return 1;
> > > > > > +             }
> > > > > > +     }
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +void typec_mode_set_priority(struct typec_altmode *alt,
> > > > > > +             const unsigned int priority)
> > > > > > +{
> > > > > > +     struct typec_port *port =3D to_typec_port(alt->dev.parent=
);
> > > > > > +     int res =3D 1;
> > > > > > +
> > > > > > +     alt->priority =3D priority;
> > > > > > +
> > > > > > +     while (res)
> > > > > > +             res =3D device_for_each_child(&port->dev, &alt,
> > > > > > +                             increment_duplicated_priority);
> > > > > > +}
> > > > > > diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/t=
ypec/mode_selection.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..cbf5a37e6404
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/usb/typec/mode_selection.h
> > > > > > @@ -0,0 +1,6 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > +
> > > > > > +#include <linux/usb/typec_altmode.h>
> > > > > > +
> > > > > > +void typec_mode_set_priority(struct typec_altmode *alt,
> > > > > > +             const unsigned int priority);
> > > > > > diff --git a/include/linux/usb/typec_altmode.h b/include/linux/=
usb/typec_altmode.h
> > > > > > index b3c0866ea70f..571c6e00b54f 100644
> > > > > > --- a/include/linux/usb/typec_altmode.h
> > > > > > +++ b/include/linux/usb/typec_altmode.h
> > > > > > @@ -28,6 +28,7 @@ struct typec_altmode {
> > > > > >       int                             mode;
> > > > > >       u32                             vdo;
> > > > > >       unsigned int                    active:1;
> > > > > > +     unsigned int                    priority;
> > > > >
> > > > > What is the range of this?  And this value is only incremented, n=
ever
> > > > > decremented?
> > > > >
> > > >
> > > > The range extends from 0 to UINT_MAX. The value is only incremented=
.
> > > > The only exception is that If the user sets UINT_MAX for two altern=
ate
> > > > modes in turn, the priority of the first mode becomes 0. This does =
not
> > > > break the algorithm, and the user can check all priorities via
> > > > =E2=80=98priority=E2=80=99 attributes.
> > >
> > > Why not use u32 to define a sane range?  Or u8?  How many different
> > > priorities will actually be used in the real world?
> > >
> >
> > The priority can be u32 or u8, but not bool. I use unsigned int as the
> > precise bit count is not important here.
>
> But the range is, that needs to be documented.
>

The priority range will be documented in the ABI

> > Three different priorities are enough for DisplayPort, Thunderbolt,
> > USB4, at least for now. The algorithm is designed to accommodate any
> > number of modes, as it does not rely on predefined MAX_ALTMODE or
> > MAX_PRIORITY values.
>
> Great, then let's use u8 for now.
>

I will change the priority type from unsigned int to u8.

> > > And what happens when it wraps?
> > >
> >
> > If a user sets all priorities (either 2 or 3) to UINT_MAX, the
> > resulting mode sequence will not be as expected due to overflow.
>
> That sounds like a bug :(
>

I will add a check to the function and return -EOVERFLOW if the input
causes the priority values to wrap.

Greg, thank you for the review!

Andrei

