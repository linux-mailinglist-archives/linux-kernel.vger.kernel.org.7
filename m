Return-Path: <linux-kernel+bounces-811356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F43B52804
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C596B46765C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC1F23DEB6;
	Thu, 11 Sep 2025 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gx4CKW4v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D9168BD;
	Thu, 11 Sep 2025 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567270; cv=none; b=FzL8+XzN3NBx73T5rNEIwKeZAE9HsBY0UAkOjuWJqCRfRdZBLbBvXwF4k7eXkrIG7KHwiOXDz0ZyE5rDai6vgWCxnZ/cU8n87pMgAt3hskwDcnYKu2nDGhnKhoRKB9GiODTGOmzX+/jwHSQNUYcdn1FH0ZYYQ/xdX5xt99ogOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567270; c=relaxed/simple;
	bh=KH2wkFXlVei/WW7nagdlfBjNyhLSrk/crkoND0qCP+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssfS8eWMPDjZoCA1a1ZnafDw8dN5u1TGLiahCYSX5Wperb/G6HlQjeLbTJZ2jD3AydNFzgwee75B//RyrpZp78+3buLnUTxdFPuBUo8ZY5aykOZaBz9CFxguxQY2eJYhgVi2xFmTQ2QkP9BX1uzw7/EklRjTi60Y8JsaZLOSxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gx4CKW4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAD5C4CEF1;
	Thu, 11 Sep 2025 05:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757567270;
	bh=KH2wkFXlVei/WW7nagdlfBjNyhLSrk/crkoND0qCP+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gx4CKW4v7LDVwHiGe+yrfg/EKMy6SQOWzI9wVFTzfs8d85X8JOGqWJmH7Ci+sn30B
	 ZFqInQWLEWQIJg4PiOS0fZk9LV4XHiCIAZQOkWZg3ZhrI3sB8XIOpz44/yHtQoNPxp
	 gzOLg4hUPfVoHik3apNxpKzRAAKbW+F79n/+VFo4=
Date: Thu, 11 Sep 2025 07:07:46 +0200
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
Message-ID: <2025091117-herring-crazy-d13c@gregkh>
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-5-akuchynski@chromium.org>
 <2025091029-snarl-decimal-aea2@gregkh>
 <CAMMMRMdOiGQdmgQ7COa1Nf9Rh9BQLD79TJ77VW4ejadx_bNyeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMMMRMdOiGQdmgQ7COa1Nf9Rh9BQLD79TJ77VW4ejadx_bNyeg@mail.gmail.com>

On Wed, Sep 10, 2025 at 07:35:42PM +0000, Andrei Kuchynski wrote:
> On Wed, Sep 10, 2025 at 1:31 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Sep 05, 2025 at 02:22:05PM +0000, Andrei Kuchynski wrote:
> > > This patch introduces APIs to manage the priority of USB Type-C alternate
> > > modes. These APIs allow for setting and retrieving a priority number for
> > > each mode. If a new priority value conflicts with an existing mode's
> > > priority, the priorities of the conflicting mode and all subsequent modes
> > > are automatically incremented to ensure uniqueness.
> > >
> > > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > > ---
> > >  drivers/usb/typec/Makefile         |  2 +-
> > >  drivers/usb/typec/mode_selection.c | 38 ++++++++++++++++++++++++++++++
> > >  drivers/usb/typec/mode_selection.h |  6 +++++
> > >  include/linux/usb/typec_altmode.h  |  1 +
> > >  4 files changed, 46 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/usb/typec/mode_selection.c
> > >  create mode 100644 drivers/usb/typec/mode_selection.h
> > >
> > > diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> > > index 7a368fea61bc..8a6a1c663eb6 100644
> > > --- a/drivers/usb/typec/Makefile
> > > +++ b/drivers/usb/typec/Makefile
> > > @@ -1,6 +1,6 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_TYPEC)          += typec.o
> > > -typec-y                              := class.o mux.o bus.o pd.o retimer.o
> > > +typec-y                              := class.o mux.o bus.o pd.o retimer.o mode_selection.o
> > >  typec-$(CONFIG_ACPI)         += port-mapper.o
> > >  obj-$(CONFIG_TYPEC)          += altmodes/
> > >  obj-$(CONFIG_TYPEC_TCPM)     += tcpm/
> > > diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
> > > new file mode 100644
> > > index 000000000000..2179bf25f5d4
> > > --- /dev/null
> > > +++ b/drivers/usb/typec/mode_selection.c
> > > @@ -0,0 +1,38 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright 2025 Google LLC.
> > > + */
> > > +
> > > +#include "mode_selection.h"
> > > +#include "class.h"
> > > +#include "bus.h"
> > > +
> > > +static int increment_duplicated_priority(struct device *dev, void *data)
> > > +{
> > > +     struct typec_altmode **alt_target = (struct typec_altmode **)data;
> > > +
> > > +     if (is_typec_altmode(dev)) {
> > > +             struct typec_altmode *alt = to_typec_altmode(dev);
> > > +
> > > +             if (alt != *alt_target && alt->priority == (*alt_target)->priority) {
> > > +                     alt->priority++;
> > > +                     *alt_target = alt;
> > > +                     return 1;
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +void typec_mode_set_priority(struct typec_altmode *alt,
> > > +             const unsigned int priority)
> > > +{
> > > +     struct typec_port *port = to_typec_port(alt->dev.parent);
> > > +     int res = 1;
> > > +
> > > +     alt->priority = priority;
> > > +
> > > +     while (res)
> > > +             res = device_for_each_child(&port->dev, &alt,
> > > +                             increment_duplicated_priority);
> > > +}
> > > diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mode_selection.h
> > > new file mode 100644
> > > index 000000000000..cbf5a37e6404
> > > --- /dev/null
> > > +++ b/drivers/usb/typec/mode_selection.h
> > > @@ -0,0 +1,6 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#include <linux/usb/typec_altmode.h>
> > > +
> > > +void typec_mode_set_priority(struct typec_altmode *alt,
> > > +             const unsigned int priority);
> > > diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> > > index b3c0866ea70f..571c6e00b54f 100644
> > > --- a/include/linux/usb/typec_altmode.h
> > > +++ b/include/linux/usb/typec_altmode.h
> > > @@ -28,6 +28,7 @@ struct typec_altmode {
> > >       int                             mode;
> > >       u32                             vdo;
> > >       unsigned int                    active:1;
> > > +     unsigned int                    priority;
> >
> > What is the range of this?  And this value is only incremented, never
> > decremented?
> >
> 
> The range extends from 0 to UINT_MAX. The value is only incremented.
> The only exception is that If the user sets UINT_MAX for two alternate
> modes in turn, the priority of the first mode becomes 0. This does not
> break the algorithm, and the user can check all priorities via
> ‘priority’ attributes.

Why not use u32 to define a sane range?  Or u8?  How many different
priorities will actually be used in the real world?

And what happens when it wraps?

> I am unsure if a check for this specific case is necessary, as it
> would require examining priorities across all modes, not just a simple
> 'if' statement.
> There are a few ideas in this algorithm:
> - all priorities must always be valid and unique

Is that true?  Where is that validated?

> - no unnecessary restrictions for the user

What does the user actually want to do here?

> - as simple as possible

But not too simple :)

thanks,

greg k-h

