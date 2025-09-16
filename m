Return-Path: <linux-kernel+bounces-819296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837AEB59E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2D46092A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEAE2F7AA6;
	Tue, 16 Sep 2025 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dyIEiICP"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1F2F2605
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041281; cv=none; b=DAq+n6eMJ7Ogz935QNYg22KQ7d0VP8rMt5gGmpZGT1fYaZGFMwpbgtqBJw9cXAsId9gXl2oohsqPp0yVY6VdzSqvhcayu7a96cp+9Xn5A8694H/SlkvBcJh+x1P9lO9++Bx/50sQnlbGtxwzdkKoVk8l1MSXMuJFXlcrUkUWopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041281; c=relaxed/simple;
	bh=71RTH5dtO3mKhxi62YpmdZ3mPiuAXTAABtxH+Y5Q4WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXZuKapYyyIJ4NPv9FwTEVCLP0gEm5B8l3h7CW4w85SzsoUeRUFe8utlhoogdvMXk3EDPmDbpVbhW4F+x7hMD3XXgtneP61pH5dcu+2ThSyPTTGUBv5i4p0rYQkDQpushzMuCeKSYZbwgQDVHplxCYtCwzKj+iij5aJn0FDNzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dyIEiICP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603acc23so40198757b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758041278; x=1758646078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ETmZDpbYmqIU0hIW51Fx0lZCbZYUtcEVM1kLaNYVSU=;
        b=dyIEiICP6ZyCyzDD5nAbP+ENRdLWmV4wu4OKbQU2lusvsdGQtWZahEiYIKUsoOc+Kz
         mPaWA2SA5Kk/W1O6rdpi4ZI1o7ytKv+X8y62tdKwYqeXS86W+4rzYk24XjvMLcT1s6B3
         iuWf+7CQ+Z2l+9it4pp0qP1FvIhV8ExG1RDes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758041278; x=1758646078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ETmZDpbYmqIU0hIW51Fx0lZCbZYUtcEVM1kLaNYVSU=;
        b=U27J/OcdrFy2eifpLtb96hTOFAqLtJT3IbFjLpWCzXwv1Eb9wy4NLkGElkHWcAeSnm
         4NB0+Wuytxd9rDPZFF3lXmlHSsd9H9jrQRSOHIoPxoIw9q0vtLSCK0dQlBRef/9SIKsI
         z+MalRaF9+jvIMJrqgxnXcpa86LrTu4T/b/urxqz74FEkNZs4nft1xWRnaR6xualAa2E
         Q4bDlXEl6p8waoHiV1+rDYs98pXmFF+7npE//pleC7OC8IofA7p6j+BcpXFsXcXWAiD7
         xdVDAP2qybjCIZrpWz3kK/snIKJOGGKDxUmmEN+Z8QBjV+3C/uKBhoOfIWxlP6blV+mn
         WtVw==
X-Forwarded-Encrypted: i=1; AJvYcCWi+HC90QPtzfhdNjQIE2CPVoEA/7umWEFOlC3wCA3vx+um4plOPBseiu5Uw15XAQ9eN6wIUyV3oO2RuzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3IuN3rwyq6JMPmznZRE7v3rCj80hQuwWSdzfRJbC2Iv+SZclX
	u+TH9E9xRJMJ2Tuhi3bOTkArg4tVHyZVUxZhgxBAQpJcmOw6Qiwlkwf26/Ok9Lwf+YgJERuOzLx
	fRv3yOWLlZMFrW2KKuUKYWYLFU+QViEdqWN1/31ko
X-Gm-Gg: ASbGncu3D5sWKoLoQhnsUhdmNXYgjxnUuvcSyNGWXxy+xBJ+wWgDshfLpTl2oer0BWU
	HrmlUSwmMxgJVf/1kIbSoXZ2VhbTuNHvza03ENf7XySdnJg6AXHOJvcIXxjO/xzm5E2SpbccE1d
	DW1L758IFjIFV+tTxQfz573dmjwy6CiAv0N8+iBRPEQ5NwLdYeMrHtBWtV67z8LxW8MOL/7qLVB
	URHqrM=
X-Google-Smtp-Source: AGHT+IFZt1kfGdCyhiAecc8NbMlubsrrYf2Bl36ioKqJQz0ak2LxPjQCNPumVJf96dL1uLcuYz1CuE3rsG4iLt7nm2E=
X-Received: by 2002:a05:690c:314:b0:722:6c4d:a46c with SMTP id
 00721157ae682-730654cd3c3mr154591707b3.48.1758041278330; Tue, 16 Sep 2025
 09:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909123028.2127449-1-akuchynski@chromium.org> <aMliLCWFKy5Esl0-@kuha.fi.intel.com>
In-Reply-To: <aMliLCWFKy5Esl0-@kuha.fi.intel.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Tue, 16 Sep 2025 09:47:44 -0700
X-Gm-Features: AS18NWAU9Wq6pK_RLACFVUfRmWbdIPmVUr2iNMaa6noro-Cml5cKdRX1otFdb8w
Message-ID: <CANFp7mXvpNXr=01nQR54d+Z+vSiiwiDLB+3B+1eR6Ks7b37gtg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] USB Type-C alternate mode selection
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andrei Kuchynski <akuchynski@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:12=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Sep 09, 2025 at 12:30:23PM +0000, Andrei Kuchynski wrote:
> > This patch series introduces a flexible mechanism for USB Type-C mode
> > selection, enabling into USB4 mode, Thunderbolt alternate mode, or
> > DisplayPort alternate mode.
> >
> > New sysfs `mode_selection` attribute is exposed to provide user control
> > over mode selection. It triggers an alternate mode negotiation.
> > The mode selection logic attempts to enter prioritized modes sequential=
ly.
> > A mode is considered successfully negotiated only when its alternate mo=
de
> > driver explicitly reports a positive status. Alternate mode drivers are
> > required to report their mode entry status (either successful or failed=
).
> > If the driver does not report its status within a defined timeout perio=
d,
> > the system automatically proceeds to attempt entry into the next prefer=
red
> > mode.
>
> I'm still struggling to understand what is the benefit from this - why
> would you want the user space to explicitly start the entry process
> like this? Instead why would you not just take full control over the
> alt modes in user space by enabling the them one by one in what ever
> order you want?

I think after the many patch iterations we went through upstreaming,
we may have lost the point a little bit wrt/ the mode selection task.
We talked about this on the very first iteration of this patchset
here: https://lore.kernel.org/linux-usb/CANFp7mVWo4GhiYqfLcD_wFV34WMkmXncMT=
OnmMfnKH4vm2X8Hg@mail.gmail.com/

The motivation behind it was to allow the kernel driver to own mode
selection entirely and not need user space intervention. The current
alt-mode drivers attempt to own the mode entry process and this fails
when you have two or more altmode drivers loaded (i.e. displayport,
thunderbolt). The original goal of the mode selection task was to move
the mode entry decision away from the alt-mode driver and to the port
driver instead.

What's missing in the current patch series to show this is probably
actually calling mode_selection once all partner modes are added :)
Andrei should be adding that to this patch series in the next patch
version.

Adding the mode_selection sysfs trigger is for another reason: to
re-run mode selection after priorities have been changed in userspace
and there is no partner hotplug. We specifically have some security
policies around PCI tunnels that result in the following need:
* When we enable pci tunneling, we PREFER tbt over dp and would like
to select the preferred mode. When we disable it, we PREFER dp over
TBT and would like to select the preferred mode.
* When users are logged out, we always prefer DP over TBT.
* When the system is locked, we prefer DP over TBT for new connections
(but existing connections can be left as TBT). When we unlock, we want
to enter the most preferred mode (TBT > DP).

While this is do-able with the alt-mode active sysfs field, we would
basically be re-creating the priority selection done in the kernel in
user space again. Hence why we want to expose the mode selection
trigger as done here.

>
> I don't believe you can make this approach scale much if and when in
> the future the use cases change. Right now I don't feel comfortable
> with this at all.
>
> thanks,
>
> > This series was tested on an Android OS device with kernel 6.16.
> > This series depends on the 'USB Type-C alternate mode priorities' serie=
s:
> > https://lore.kernel.org/all/20250905142206.4105351-1-akuchynski@chromiu=
m.org/
> >
> > Andrei Kuchynski (5):
> >   usb: typec: Implement mode selection
> >   usb: typec: Expose mode_selection attribute via sysfs
> >   usb: typec: Report altmode entry status via callback
> >   usb: typec: ucsi: displayport: Propagate DP altmode entry result
> >   platform/chrome: cros_ec_typec: Propagate altmode entry result
> >
> >  Documentation/ABI/testing/sysfs-class-typec  |  11 +
> >  drivers/platform/chrome/cros_ec_typec.c      |   9 +
> >  drivers/platform/chrome/cros_typec_altmode.c |  32 +-
> >  drivers/platform/chrome/cros_typec_altmode.h |   6 +
> >  drivers/usb/typec/altmodes/displayport.c     |  19 +-
> >  drivers/usb/typec/altmodes/thunderbolt.c     |  10 +
> >  drivers/usb/typec/class.c                    |  37 ++
> >  drivers/usb/typec/class.h                    |   4 +
> >  drivers/usb/typec/mode_selection.c           | 345 +++++++++++++++++++
> >  drivers/usb/typec/mode_selection.h           |  25 ++
> >  drivers/usb/typec/ucsi/displayport.c         |  10 +-
> >  include/linux/usb/typec_altmode.h            |  11 +
> >  include/linux/usb/typec_dp.h                 |   2 +
> >  include/linux/usb/typec_tbt.h                |   3 +
> >  14 files changed, 516 insertions(+), 8 deletions(-)
> >
> > --
> > 2.51.0.384.g4c02a37b29-goog
>
> --
> heikki

