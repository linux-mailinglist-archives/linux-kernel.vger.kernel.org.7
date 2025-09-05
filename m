Return-Path: <linux-kernel+bounces-802793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0423FB4570E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D86C4E4E42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D434DCD8;
	Fri,  5 Sep 2025 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mq5XqgUL"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1534DCCC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073558; cv=none; b=uDCIcDihufkUBve8+2ULrK2w27Nq7RTqTCX6HVfv1A2uiX9WJmhWfXUfqB4JNPByBZqXSRmWRXMEgDilGOHD/9r3qdYcfA2kUNqnbeUJjRxrLmxD5HEyPPJTBqEQ8x9gSbzO9T2aEAQbgSl3MxFeTGyYe1UV4Fvv96IutDP+8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073558; c=relaxed/simple;
	bh=eWu1w45THUrcqTubbaxwPPUPaMOnGOxHWGZC6vrwq6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qcmg0/9NMHNiU/YKrlXPfk+Mq4FmL/qKGALHHIWq7xTY3yhCLTkW3WNDBMIbf/vITKmRaNTfgIpt2YmalZRc2fb7IF1JyPM7srKO1RtCpND0WIg9hxtbEgGQ9YnvI2lOVZJka2OgoSm7T4cQc+7QiB5pyLW6brUmAj3cfu2nVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mq5XqgUL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so1650549a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757073554; x=1757678354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhISDapWI+OKjnURRW7M0Vh6J8Ihioz0/IeDCwCINSI=;
        b=mq5XqgULFQGsisKttfVZcdFKJ+PTIGwNikxsv3aYR+tn61xPZWW9daxbYhpSNqwBvw
         O6IQZGetCCCbsm/YTZpL2f967jeXPkJr+TpqIE95yKQMoj6boUivKUQBKVvciGd36mDR
         HqVP3dCKHnOs8YZ1eaGTnm65HhIrzkqjlCFoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073554; x=1757678354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhISDapWI+OKjnURRW7M0Vh6J8Ihioz0/IeDCwCINSI=;
        b=gEdBdWgZUYJdwGbnlSvRC2vEddBV2ryDDpOESXZS8YjXH4H3PzgQEYwveo4JbyDcuQ
         IqmJ6CtEunkDu8Kv+zjmFUVLJoxydZWu4b4ybtvLZWk/ZTC0ApKcjWAM3lQ8Tc+vJf28
         4M6D3I/rh6kkde6Ng4GKLiXuXnJrZVsMXQRWdJgtkXM2tM/I+ZGfiE2NOPKZwYmThnMS
         CIr364Fl68lLsKC4zWz3uuElmveT6A6rWssSIGPK6+2eQXBhVjnCcAILdrKkScL6BkEf
         imt44Gabn9FEASo69eurvx+R2kygDdz6x+eHQKe8zMnPnTzbckbtLe+hLAIv6H4ELG5U
         lAtA==
X-Forwarded-Encrypted: i=1; AJvYcCVGYo3ktNm9HPzB5kC8VR6IBlVWiQ+pifEtwK2nqA4fYIIT5tMilnz60U6Vhy4mLJvuhmgA7VjowTkgrF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ffld4aKzgy+1mi+wBUkfwAY4A43hErRLWIS4HuLdraZ6c6Sp
	zDm7iEc4ILUz7MljakqD/mm/8jMoNgfSQpNwxPaqtkPx3j6EDnbU9h9yXjr8qG5GVknrkRLIf+d
	XXIJeCgmQE4gdaXa1iMbBBLmcseJ6wyocZBtko6dw
X-Gm-Gg: ASbGncuKC4te0JngqA+wrQiuNAiy/pJqNZzQfzF6Ox9F74+SL80JVxiNBTjUpMU115q
	y5cwUT3o5xx0q4OAeMdSiWiKlaT5Ao3kFLUdC1GorzUYrk73QL5cPs0rWJn4Cv1gD6TVYDiPNu4
	PCRyrn+anIkTVvOzYrbczwcVseTB2WnWZbRc2Zqvq2pdHtigBJCnUZBPFRQk7frKYp4lc4EHrAj
	nTk6HjHjdM6pIJ/0+mCh+DUiBNnE2o/zg==
X-Google-Smtp-Source: AGHT+IFNtnOhcXO5r4wnyrBsxPjARdpyn400H+T0JTuNzh/jY8gXOZS7qb54ju5ejnnjPlgi5xp/6ms+Lj0fR6CAnH8=
X-Received: by 2002:a17:90b:268a:b0:32b:b514:3935 with SMTP id
 98e67ed59e1d1-32bb5143ecfmr4921834a91.16.1757073554292; Fri, 05 Sep 2025
 04:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825145750.58820-1-akuchynski@chromium.org>
 <20250825145750.58820-5-akuchynski@chromium.org> <aLq6oNcA_yoMZyrf@kuha.fi.intel.com>
In-Reply-To: <aLq6oNcA_yoMZyrf@kuha.fi.intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Fri, 5 Sep 2025 13:59:02 +0200
X-Gm-Features: Ac12FXzKIlpnIFvZ07xg53BwKH3RD7_AIIZJnlGh0sZcQrFiqTbCi9PW-RPEnOE
Message-ID: <CAMMMRMcOUdo1eSoHv9+M9zR=8WPjKZ9Q0Af3OTQrH78==kqWgQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] usb: typec: Implement alternate mode priority handling
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:25=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 02:57:49PM +0000, Andrei Kuchynski wrote:
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
>
> Couldn't you just always return 0?
>

Priority values for each mode are consistently unique, eliminating the need
for further processing if a duplicate is found.

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
>
> Then this could be:
>
>         device_for_each_child(&port->dev, &alt, increment_duplicated_prio=
rity);
>
> right?
>

Unfortunately, the child's list is not in prioritized order. When a
duplicated value is found, the cycle should start for the whole list again.
I definitely need a loop here.

Thanks,
Andrei

