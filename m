Return-Path: <linux-kernel+bounces-781895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8CFB3185F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9E61C81828
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B924B2FC02B;
	Fri, 22 Aug 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STDm5/53"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934002FAC04
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867140; cv=none; b=fMnmyGTYJIbcEcgrnnrLUc6i1hyy92763mFXNl+sLsOR+LpKTfdG/1Mv9N5a6bXX+L8PW6sVAdbWALPxVp8fP7nEEUW+sFxmjGHIHVOgHnJ4WTmlrLWi+OR6PHVV/dDl72ozw33QIUznNnDbOzmYkehSr6r0Y417d6Vz1c9H2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867140; c=relaxed/simple;
	bh=Qvkm8ZvcKVj/gdX6BAq0K2JgptBY3L/xiu5D9dt3b90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPG+mwZUUx0+wmDCpzixmpRW9BQSZhJtEP5hxNQUCqLqaWj85kSm093dqConbPW95Hx6ztykzS8WrnSO5x+GInXE4zftUqfCsswyKC6EeSO8oPOd8xjf2EJ3vD6/E7R14xAnOhEhNK+0v7OxBIwHBtV+yu7KuN9/3ZnWt9QZ96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=STDm5/53; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7702fc617e9so711278b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755867138; x=1756471938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPWZ0k713TIq/QYfMNdmSvfN5q6KC+M5vfGH3Fh2z5k=;
        b=STDm5/53EXT1VljXn6BGfCspYCVEX2AZpq506mI8kXtBAAxGhHiYkO345XzmHjhH+b
         bx0hJN12V3NAFUXu4uNF+xu4WnaOvZ9MFvn6sK26XKIdguvCvZFB3a8Wsp/FY7oZg6rC
         KcgnTenKiLi78N1FGLwD7BlWlDbrEpNiMD5Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867138; x=1756471938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPWZ0k713TIq/QYfMNdmSvfN5q6KC+M5vfGH3Fh2z5k=;
        b=q67hBFfhVbBrrgZhHAJ3mHCxPXQM8NggyuNPoSpDpneskx2e6ie5w0F/KVFfKNZaHK
         GdN573EAJL2hJPneFJmxSxkMQ4VaZoS3ufhwjw2hkgWoNc2wfbxXxVjLG9AIBKF+uzJW
         z4EjHHIrKyLRQvCHDgYmW4CTCymS4e2riU92/SP148u1tjg2qEfOHdXwhywXMhdShLvB
         MN3WhBa393JmDH98E72Zh/PmzY9+lah3h+XPjXA/pThuUckyuzipG4Ha89Bt42ftVePK
         n2OcYpqzYx6FqbjCPNVzfcTDgjqaOd62IsSkT9D4Cmi/XnhGtmGFZXdkrHLwoqe3JOWH
         AyBA==
X-Forwarded-Encrypted: i=1; AJvYcCVp2NfPMklcvCvTDpJekJvA13lauckR6gEMlyCbNwipkQRz2r1ulVQVriu+PKLoKFbk8q//uAgOR88bWHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsqnia0y7HmhL8lXbnp/7e8Im7sDE4871+a4ti+TP29X2YZiI7
	K8BQhtFJkEsTUByty8PJk19QFG1oPeXC8lVs1ICOxdE+uEFD/wSYp1bmCAp+9RI1p4VoKlPcv6S
	wFkOVT8NuNYkFCffKgjJMRd3tB7opOxM8dZ7bQ5j2
X-Gm-Gg: ASbGncsNFxV+LZzCncE9Hv+FsMq6Y9u0zlFp6bYVgDy03eqVd9cQddgNlGtQ9hajMAy
	vVbwobsAGOZll8vOUxIKLk41EY9wyEpm/Md0KXjjhl1OmLJQQUfeb0Weut4Zs9cZ49u1+MmtOlG
	ruB5Bl50Y9HOCUx/S0JtiJi6j5fHKqSHSoH7NEYGzHjmSjadY7nrGNrfPrl835FFNRG1K0/Sc8b
	wqLkopZfJ1NsD8E7i8xz7d0R/5t9UBNtH3vd3xce62D
X-Google-Smtp-Source: AGHT+IGRt7T15g4J9TtJHeozRsfP6YTUMgnhVNdFI3+HALeg7CoNfApLp63yXeFIxoeJ6WrrgpylLU3LPWYlGugAkhs=
X-Received: by 2002:a05:6a20:430b:b0:23d:54bd:92e6 with SMTP id
 adf61e73a8af0-24340d02428mr4351745637.29.1755867137998; Fri, 22 Aug 2025
 05:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814184455.723170-1-akuchynski@chromium.org>
 <20250814184455.723170-5-akuchynski@chromium.org> <aKbwby7OYdUpLvhA@kuha.fi.intel.com>
 <aKb_rwVqqzipHHqf@kuha.fi.intel.com>
In-Reply-To: <aKb_rwVqqzipHHqf@kuha.fi.intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Fri, 22 Aug 2025 14:52:05 +0200
X-Gm-Features: Ac12FXx3ANTUMIa8Fow-ciMNUPql3vLmAiHYubi-qOYKb8F15LFr1nZlCVhH7cs
Message-ID: <CAMMMRMc6YYpQMo0hDqvjVwg28tTazJxxxgQ5j9iUq-ZWeYg6qA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] usb: typec: Implement alternate mode priority handling
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 1:15=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi again,
>
> On Thu, Aug 21, 2025 at 01:09:57PM +0300, Heikki Krogerus wrote:
> > > diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/m=
ode_selection.c
> > > new file mode 100644
> > > index 000000000000..8a54639b86bf
> > > --- /dev/null
> > > +++ b/drivers/usb/typec/mode_selection.c
> > > @@ -0,0 +1,127 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright 2025 Google LLC.
> > > + */
> > > +
> > > +#include <linux/usb/typec_altmode.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/list.h>
> > > +#include "mode_selection.h"
> > > +#include "class.h"
> > > +
> > > +static const char * const mode_names[TYPEC_ALTMODE_MAX] =3D {
> > > +   [TYPEC_ALTMODE_DP] =3D "DisplayPort",
> > > +   [TYPEC_ALTMODE_TBT] =3D "Thunderbolt3",
> > > +   [TYPEC_ALTMODE_USB4] =3D "USB4",
> > > +};
> >
> > You only need string for USB4. The altmode names come from the drivers.
>
> Sorry, that won't work with port altmode. But you can still do the
> lookup with just the sid.
>

Hi Heikki,

I can get names from altmode partner. Names are only needed to
provide results of entering the mode. No partner - no results.

>
> I think this needs to be simplified. You don't need this elaborate
> implementation in the beginning.
>
> I'm going to do some suggestions. I don't know if all of them work,
> but hopefully you get the idea how I would like to see the initial
> support to be implemented.
>

I checked your suggestions. It looks like all of them should
work. Thank you!

- priority is a member to struct typec_altmode
- use svid instead of enum typec_mode_type
- no list or other variables in struct typec_port.
- struct mode_selection_state will be introduced in other series

>
> The default priorities is an array of svids. And I really think that
> the highest priority should be 1 not 0.
>

I think your idea of setting priorities based on the order of
port altmod registrations is better. We don't really need default
priorities in this case.

>
> No driver so you would need to use the mode_names, but instead of
> doing that, just don't limit this at all.
>
> If there is no name for the mode, use the svid.
>
> thanks,
>
> --
> heikki

What if we later create typec_USB4 driver, similar to the
existing typec_displayport and typec_thunderbolt?
This approach could unify how various modes are handled,
eliminating exceptions for USB4 or any other mode.

The port altmode would contain priority and support "enter" and
"exit" operations, while partner altmode would handle "activate"
and name field. I've explored this approach with cros_ec_typec
driver, and it appears to be a promising way to manage USB4 as
alternate mode.

Thanks,

Andrei

