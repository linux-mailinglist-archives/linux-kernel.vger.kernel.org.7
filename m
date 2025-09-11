Return-Path: <linux-kernel+bounces-811863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA5B52EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88C91C84E05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD7C3101B6;
	Thu, 11 Sep 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ilt+Asw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3F347D0;
	Thu, 11 Sep 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587278; cv=none; b=Da7h+2B8SsM7g68cfpx9iXpJaKpDI5gvYxum6OipkshpLGsSuqY0fArw2jGFPuZtUKEEsxxJeznqxVP7d/krTTpQoLXEF7kACtLnDrYvedNdt/vC+kDEbKGFKUenSSOi+ODuSaMFmfOm/d9mDVU7/5LyZQ5QQ5mdWRtadJo3fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587278; c=relaxed/simple;
	bh=bwZFuRK+Ee6O6yC+tgc/4fMUaRu02+9RtrCMwHyVXig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkJUO4+HSe8/QppUT7zEZNkQuqgvWYq+YzRWXzXEjm/6BPUeJA+zquQkfaaNS7wz1Egemlo4zC3bn9hmti671Qjl/g69eyHkjvwn1tuIlmVQx48OUe6/g4cut+qHiO9Xd6gtFhN/WRXwXQCMcrkySBiELSzRgZ3+PmYLWraeam0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ilt+Asw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3430DC4CEF0;
	Thu, 11 Sep 2025 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757587277;
	bh=bwZFuRK+Ee6O6yC+tgc/4fMUaRu02+9RtrCMwHyVXig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilt+Asw21gs3C8lyX6FR2JqS7xsNTANlACpsqq/4ClF+JsOdXeX336v5PsFKHUfsz
	 pAIY/rYWEcZEdf1KyCZMP2UZ15IH0ZFhfaR/r6px0inyIjhEqvPC4uuPfTZkLR7Hew
	 yyzrlsLcPsvA32bI4HadZsJLv7RqrD84TzREOB8A=
Date: Thu, 11 Sep 2025 12:41:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] usb: typec: Implement alternate mode priority
 handling
Message-ID: <2025091106-absinthe-wired-46e1@gregkh>
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-5-akuchynski@chromium.org>
 <2025091029-snarl-decimal-aea2@gregkh>
 <CAMMMRMdOiGQdmgQ7COa1Nf9Rh9BQLD79TJ77VW4ejadx_bNyeg@mail.gmail.com>
 <2025091117-herring-crazy-d13c@gregkh>
 <CAMMMRMck=YzbN6g8-4qUx=YX+=S4HgKqHaYoUuQ0CsJUYd9GOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMMMRMck=YzbN6g8-4qUx=YX+=S4HgKqHaYoUuQ0CsJUYd9GOw@mail.gmail.com>

On Thu, Sep 11, 2025 at 10:46:52AM +0200, Andrei Kuchynski wrote:
> On Thu, Sep 11, 2025 at 7:07 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 10, 2025 at 07:35:42PM +0000, Andrei Kuchynski wrote:
> > > On Wed, Sep 10, 2025 at 1:31 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Sep 05, 2025 at 02:22:05PM +0000, Andrei Kuchynski wrote:
> > > > > This patch introduces APIs to manage the priority of USB Type-C alternate
> > > > > modes. These APIs allow for setting and retrieving a priority number for
> > > > > each mode. If a new priority value conflicts with an existing mode's
> > > > > priority, the priorities of the conflicting mode and all subsequent modes
> > > > > are automatically incremented to ensure uniqueness.
> > > > >
> > > > > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > > > > ---
> > > > >  drivers/usb/typec/Makefile         |  2 +-
> > > > >  drivers/usb/typec/mode_selection.c | 38 ++++++++++++++++++++++++++++++
> > > > >  drivers/usb/typec/mode_selection.h |  6 +++++
> > > > >  include/linux/usb/typec_altmode.h  |  1 +
> > > > >  4 files changed, 46 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 drivers/usb/typec/mode_selection.c
> > > > >  create mode 100644 drivers/usb/typec/mode_selection.h
> > > > >
> > > > > diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> > > > > index 7a368fea61bc..8a6a1c663eb6 100644
> > > > > --- a/drivers/usb/typec/Makefile
> > > > > +++ b/drivers/usb/typec/Makefile
> > > > > @@ -1,6 +1,6 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > >  obj-$(CONFIG_TYPEC)          += typec.o
> > > > > -typec-y                              := class.o mux.o bus.o pd.o retimer.o
> > > > > +typec-y                              := class.o mux.o bus.o pd.o retimer.o mode_selection.o
> > > > >  typec-$(CONFIG_ACPI)         += port-mapper.o
> > > > >  obj-$(CONFIG_TYPEC)          += altmodes/
> > > > >  obj-$(CONFIG_TYPEC_TCPM)     += tcpm/
> > > > > diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
> > > > > new file mode 100644
> > > > > index 000000000000..2179bf25f5d4
> > > > > --- /dev/null
> > > > > +++ b/drivers/usb/typec/mode_selection.c
> > > > > @@ -0,0 +1,38 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Copyright 2025 Google LLC.
> > > > > + */
> > > > > +
> > > > > +#include "mode_selection.h"
> > > > > +#include "class.h"
> > > > > +#include "bus.h"
> > > > > +
> > > > > +static int increment_duplicated_priority(struct device *dev, void *data)
> > > > > +{
> > > > > +     struct typec_altmode **alt_target = (struct typec_altmode **)data;
> > > > > +
> > > > > +     if (is_typec_altmode(dev)) {
> > > > > +             struct typec_altmode *alt = to_typec_altmode(dev);
> > > > > +
> > > > > +             if (alt != *alt_target && alt->priority == (*alt_target)->priority) {
> > > > > +                     alt->priority++;
> > > > > +                     *alt_target = alt;
> > > > > +                     return 1;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +void typec_mode_set_priority(struct typec_altmode *alt,
> > > > > +             const unsigned int priority)
> > > > > +{
> > > > > +     struct typec_port *port = to_typec_port(alt->dev.parent);
> > > > > +     int res = 1;
> > > > > +
> > > > > +     alt->priority = priority;
> > > > > +
> > > > > +     while (res)
> > > > > +             res = device_for_each_child(&port->dev, &alt,
> > > > > +                             increment_duplicated_priority);
> > > > > +}
> > > > > diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mode_selection.h
> > > > > new file mode 100644
> > > > > index 000000000000..cbf5a37e6404
> > > > > --- /dev/null
> > > > > +++ b/drivers/usb/typec/mode_selection.h
> > > > > @@ -0,0 +1,6 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +
> > > > > +#include <linux/usb/typec_altmode.h>
> > > > > +
> > > > > +void typec_mode_set_priority(struct typec_altmode *alt,
> > > > > +             const unsigned int priority);
> > > > > diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> > > > > index b3c0866ea70f..571c6e00b54f 100644
> > > > > --- a/include/linux/usb/typec_altmode.h
> > > > > +++ b/include/linux/usb/typec_altmode.h
> > > > > @@ -28,6 +28,7 @@ struct typec_altmode {
> > > > >       int                             mode;
> > > > >       u32                             vdo;
> > > > >       unsigned int                    active:1;
> > > > > +     unsigned int                    priority;
> > > >
> > > > What is the range of this?  And this value is only incremented, never
> > > > decremented?
> > > >
> > >
> > > The range extends from 0 to UINT_MAX. The value is only incremented.
> > > The only exception is that If the user sets UINT_MAX for two alternate
> > > modes in turn, the priority of the first mode becomes 0. This does not
> > > break the algorithm, and the user can check all priorities via
> > > ‘priority’ attributes.
> >
> > Why not use u32 to define a sane range?  Or u8?  How many different
> > priorities will actually be used in the real world?
> >
> 
> The priority can be u32 or u8, but not bool. I use unsigned int as the
> precise bit count is not important here.

But the range is, that needs to be documented.

> Three different priorities are enough for DisplayPort, Thunderbolt,
> USB4, at least for now. The algorithm is designed to accommodate any
> number of modes, as it does not rely on predefined MAX_ALTMODE or
> MAX_PRIORITY values.

Great, then let's use u8 for now.

> > And what happens when it wraps?
> >
> 
> If a user sets all priorities (either 2 or 3) to UINT_MAX, the
> resulting mode sequence will not be as expected due to overflow.

That sounds like a bug :(

thanks,

greg k-h

