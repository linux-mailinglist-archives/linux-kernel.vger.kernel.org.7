Return-Path: <linux-kernel+bounces-810892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE0B5212E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E90585716
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F2271A7C;
	Wed, 10 Sep 2025 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aorlRc6Y"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7452D594F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532956; cv=none; b=G9tW2xouM4TeUYAKEFpen/ug7F6EK/4tCXqLAn2z5x2MxyOK4YnVQ3GaQrRkAHr5zIZwwQJ+3OApVFWcUWKfP+jXzB0qjTf8IUaSYXS6OkIq8R26S45tRZLu0N87Q312bNStRCIFSwiGBaNTogw61A/pb7b7pBSzsYSHYNIEbqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532956; c=relaxed/simple;
	bh=PtN1wZSHACRT6avekYs3yn3rwtGd9wSgDovmjolOpF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8q+MvBhq8S1ub92qYpV2GVcyglplz3M3TiVh4uAEalnaQQIo3Ug1SB7D59DInfDwGTrdQmYAsGft9JTrSSO5m8RI6LQOO4PpOWL4gX6roB64b8AqnhduepnbF9sWODPFd/V7+6VsxDajGIZcF63kWe0dnCwkcyCDM1P/kIX4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aorlRc6Y; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7728815e639so4069769b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757532953; x=1758137753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDKunTxf/S5CBlU8+drFx4GQVl38jBRjcy2CRI8kVQU=;
        b=aorlRc6YCNM9XKG8R6pkHQv2OIzwRenWscG69qs3lyLvK/K/YwRYB/aRm+67hqHnhq
         8TVaNwo4gWsy5xJb+k3D6IC7vkpC//UBcFo63Ok8k/I0hpVC+4BMtvejUHkiN73Gg61r
         zv/XVpJagmQfuXqL8cIg2flNNHF/o/H3CAqUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532953; x=1758137753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDKunTxf/S5CBlU8+drFx4GQVl38jBRjcy2CRI8kVQU=;
        b=Rso66Wqe+GX3QfIPuOmTIRyV2Ibf7vz+IUmyUniSn6cZHKgNTHNskXSBv4bJ7Q5W1Q
         B0QvlaXBSItW4EQdHFdsZ9436BigxH33ujleeE7uv1bLPHD9w6Kb7y2Q+INFq8jh4l9A
         eDwJdbE4NiW6M1qLShSWjRx4bzxMQrZo/FGpCQHbrSO2kLzvyu3qVKNfGmv+Ea0eDMbT
         NxDkfC9JapHoBOI94W3j7yP3ykFFJhJg65IE7uNZX3CAnhY4M+xfyunxKv/9DbkxnJBc
         l/3Ax28W7ao86CEbhHkrVZUAidG41QixIGUAx0csQuEkvYxqCIuUHVn1JjsEg+YjE4wF
         5ejA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Enegs9VTvFo8ciaEjV7jLMwu6n7XYlcPdmkMJsK+3IJnxUz9sgYfuOl7ALLeu4DR6iPjvzyU675Y1LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBA4qS/0FKLGQrAMSz9+iMO6JnIpQmYFSARoAhbtfdjEZ6kKt
	cS7/GH6QZOwUhJGEu8fXsWHThPiVWSG/iO6A/QzTvy9osm3z0MTyZREEYcIVXRu3ZMAeTivH/8T
	7xz37gJZc8maMKJUx3W9geF3O5e4Kbj3BxbMaK3pt
X-Gm-Gg: ASbGncsdhDH0o0sfGNIZoicTiQ5+dYb817HTrx5qTlMl1zoHwt/bwkTwlCy08TVIwA0
	FFuhg90jXnkRQKbkgaNZec+zB7uGQHjsIti/Phfa7oXLhVhBHuVI3XXAzb+QR33nu1S4eD2kDKn
	Jiokb82/Dw9o/PBMD14enCyXGBetkxn7FzxTEeRWFcVOxXoxPGVxTEwoMziX7PB0C6ZIyBNINbo
	OFAxlJXjDi1CbhGBPWyGYjI97C0Z4WJQFY=
X-Google-Smtp-Source: AGHT+IEecFj4d2N8l54ipxV9A0HELOpzA3uq6yMz+0dnkVdznSIvHQpERqoi0pQkGgHfRcYwyH9WUSZ+n1fNKe/lvIs=
X-Received: by 2002:a05:6a21:33a1:b0:24a:6bef:bdd5 with SMTP id
 adf61e73a8af0-25344130fbfmr23540158637.41.1757532953527; Wed, 10 Sep 2025
 12:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-5-akuchynski@chromium.org> <2025091029-snarl-decimal-aea2@gregkh>
In-Reply-To: <2025091029-snarl-decimal-aea2@gregkh>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Wed, 10 Sep 2025 19:35:42 +0000
X-Gm-Features: Ac12FXxPN_dgj5aIjIjw1flHyJdM6r_Y2JbGmXYfsM4L8NDijYd8kjCgCMLV2jo
Message-ID: <CAMMMRMdOiGQdmgQ7COa1Nf9Rh9BQLD79TJ77VW4ejadx_bNyeg@mail.gmail.com>
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

On Wed, Sep 10, 2025 at 1:31=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 05, 2025 at 02:22:05PM +0000, Andrei Kuchynski wrote:
> > This patch introduces APIs to manage the priority of USB Type-C alterna=
te
> > modes. These APIs allow for setting and retrieving a priority number fo=
r
> > each mode. If a new priority value conflicts with an existing mode's
> > priority, the priorities of the conflicting mode and all subsequent mod=
es
> > are automatically incremented to ensure uniqueness.
> >
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > ---
> >  drivers/usb/typec/Makefile         |  2 +-
> >  drivers/usb/typec/mode_selection.c | 38 ++++++++++++++++++++++++++++++
> >  drivers/usb/typec/mode_selection.h |  6 +++++
> >  include/linux/usb/typec_altmode.h  |  1 +
> >  4 files changed, 46 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/usb/typec/mode_selection.c
> >  create mode 100644 drivers/usb/typec/mode_selection.h
> >
> > diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> > index 7a368fea61bc..8a6a1c663eb6 100644
> > --- a/drivers/usb/typec/Makefile
> > +++ b/drivers/usb/typec/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_TYPEC)          +=3D typec.o
> > -typec-y                              :=3D class.o mux.o bus.o pd.o ret=
imer.o
> > +typec-y                              :=3D class.o mux.o bus.o pd.o ret=
imer.o mode_selection.o
> >  typec-$(CONFIG_ACPI)         +=3D port-mapper.o
> >  obj-$(CONFIG_TYPEC)          +=3D altmodes/
> >  obj-$(CONFIG_TYPEC_TCPM)     +=3D tcpm/
> > diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mod=
e_selection.c
> > new file mode 100644
> > index 000000000000..2179bf25f5d4
> > --- /dev/null
> > +++ b/drivers/usb/typec/mode_selection.c
> > @@ -0,0 +1,38 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2025 Google LLC.
> > + */
> > +
> > +#include "mode_selection.h"
> > +#include "class.h"
> > +#include "bus.h"
> > +
> > +static int increment_duplicated_priority(struct device *dev, void *dat=
a)
> > +{
> > +     struct typec_altmode **alt_target =3D (struct typec_altmode **)da=
ta;
> > +
> > +     if (is_typec_altmode(dev)) {
> > +             struct typec_altmode *alt =3D to_typec_altmode(dev);
> > +
> > +             if (alt !=3D *alt_target && alt->priority =3D=3D (*alt_ta=
rget)->priority) {
> > +                     alt->priority++;
> > +                     *alt_target =3D alt;
> > +                     return 1;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +void typec_mode_set_priority(struct typec_altmode *alt,
> > +             const unsigned int priority)
> > +{
> > +     struct typec_port *port =3D to_typec_port(alt->dev.parent);
> > +     int res =3D 1;
> > +
> > +     alt->priority =3D priority;
> > +
> > +     while (res)
> > +             res =3D device_for_each_child(&port->dev, &alt,
> > +                             increment_duplicated_priority);
> > +}
> > diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mod=
e_selection.h
> > new file mode 100644
> > index 000000000000..cbf5a37e6404
> > --- /dev/null
> > +++ b/drivers/usb/typec/mode_selection.h
> > @@ -0,0 +1,6 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#include <linux/usb/typec_altmode.h>
> > +
> > +void typec_mode_set_priority(struct typec_altmode *alt,
> > +             const unsigned int priority);
> > diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/type=
c_altmode.h
> > index b3c0866ea70f..571c6e00b54f 100644
> > --- a/include/linux/usb/typec_altmode.h
> > +++ b/include/linux/usb/typec_altmode.h
> > @@ -28,6 +28,7 @@ struct typec_altmode {
> >       int                             mode;
> >       u32                             vdo;
> >       unsigned int                    active:1;
> > +     unsigned int                    priority;
>
> What is the range of this?  And this value is only incremented, never
> decremented?
>

The range extends from 0 to UINT_MAX. The value is only incremented.
The only exception is that If the user sets UINT_MAX for two alternate
modes in turn, the priority of the first mode becomes 0. This does not
break the algorithm, and the user can check all priorities via
=E2=80=98priority=E2=80=99 attributes.
I am unsure if a check for this specific case is necessary, as it
would require examining priorities across all modes, not just a simple
'if' statement.
There are a few ideas in this algorithm:
- all priorities must always be valid and unique
- no unnecessary restrictions for the user
- as simple as possible

Thanks,
Andrei

