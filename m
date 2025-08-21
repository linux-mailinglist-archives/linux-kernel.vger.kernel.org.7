Return-Path: <linux-kernel+bounces-780018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05756B2FC78
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783B06254CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE32857E0;
	Thu, 21 Aug 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C9ocq1lr"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5A24DCF6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786011; cv=none; b=AjfAkwi/30kli9k6LzFmBuTZuJvbPbazlJ3pWufeh5w2lycB+Ueli+di1O4dS04XJtykHQwz3mmR5gWskSofhakk0LCdF7uoPVwlvH99zuACbM/7BidzAew0y2d1bKXfnteX36mS7dWcne0XuwEhD4rKDkyjC5VSCl5VBK+IHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786011; c=relaxed/simple;
	bh=1TGQbSNXcYAwYgKdfFoYVGYgfusyVauvVnseKMDM9gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ft8GQ2ADsGPSbqx0uuaGGUQ5VpBR+wXgCbGSr1D9F/2Fh58R1wfVpNONmJ3rz5AQUMKphVOW9p8Ky6ygeMS2UI/B1E2pxS6ke18tP6sWDpKB7Pw9PNTUaQY6bMmVZg+ZEYEtGP++bV66ocTfTfbT25DGm+OvCKNnu5NfwpL3taA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C9ocq1lr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4717543ed9so654030a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755786009; x=1756390809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdSdCc6sEwtZ8z33Ieo6BIkuzQuw7IgeQtd7fNjTH7I=;
        b=C9ocq1lr87zJ4K9bWMxwG0NF5hEtMim6gZW5IX34z1Sl3bnx+7dzTDLeo5B/nHWsof
         W6RcsMdKstDkGkj6SgUjRg+GdyKRCnNfePDCcPB6smeS2zSQJVXKCycLynbkT/mBidtM
         uJT6eFKWIV1iwuMd1Hb3r1m2mo/udkw0jwe2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786009; x=1756390809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdSdCc6sEwtZ8z33Ieo6BIkuzQuw7IgeQtd7fNjTH7I=;
        b=KFOVzhDX/OjnLypl4OWEQ7TJlY8baSIc7jhlqDVAsuj/IsevT6sX3V5XOfoDOqiHpd
         wSgkVaTtNDpmdhFHrfruJN7rJPLcAd6gCRNDr/VdW3Gqvx0SJhR+VlxxXNuGUc6ZiTAh
         JQWYaPDe7oq2ie9v97+3QJrfzU7Kn8EZ+aYvRh4f5grZ5aAF4lHUkg0/mCUSDUMX+EIn
         q2e48HawgArIOvFUQ1KCqd3Q5FbiQ+MQApCKzgOmBNxjiNAvQr9s8mXX5c8mWAbZmH92
         UCYJxanKGt42srwCmxqP/6sNfkcUW/BDT0TrHekCSzbFRSBpx2DXglmdiKDnUzuDFYsT
         Medw==
X-Forwarded-Encrypted: i=1; AJvYcCVbS2CPNHHFqJ/DFB7QiCakuHQHsin6EfV6eQ6HtrP0R9Pg6wP22MYxorz+prz22lftkZgZsKPh+QOxRf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIl/y0sULKj1iTBo7lzjK7EzlvI3lg0mKKBGSPgGMxVL7TcWWk
	6nXonhqb8sUqJEfEke8Xt9f7ir9p+/HZ3Pw4AI6lzm8tLA8SQGRO/qHWQHI2DaXpJREgy2tDNeB
	NSFX3DvbZVaCYxSyIhZACN4JCTMWIkfdsG+BL8cKL
X-Gm-Gg: ASbGncu5i3KSGxIkSxqjqozWEHg+Jkuig5y2WokB5kNIG9WE4UXpoynMXRDEfWi5X+J
	yP+ctOJkQzDCzFUToWF5vwyQesGK8ak5JQbecOGno7CJ/QEOM46S6KU+EVegViWEtilszGBva0B
	MMUCHGhOh7DKTunn2xU6qTFCojYG34LmK4YvZe0tTwiGJ9/FYM9efHmeu3CGxC71G71sJ5EzEd4
	35KOYN0IarJp1OoJnGrrw4cpqNWe5kuhGITxVV15SR8bdUNRlC2fw==
X-Google-Smtp-Source: AGHT+IEM3XPbTHByoiCZun4dj8efSaZNwLp3Hlum29XsE5UAtKvi/jloqwgDc44XSZWztVSVyI1iCjK2uhPpPIo+vP8=
X-Received: by 2002:a17:90b:3bc5:b0:321:4182:2b9e with SMTP id
 98e67ed59e1d1-324ed09612emr4228539a91.12.1755786008932; Thu, 21 Aug 2025
 07:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814184455.723170-1-akuchynski@chromium.org>
 <20250814184455.723170-2-akuchynski@chromium.org> <aKWpI0RhPR2mFlql@kuha.fi.intel.com>
In-Reply-To: <aKWpI0RhPR2mFlql@kuha.fi.intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 21 Aug 2025 16:19:56 +0200
X-Gm-Features: Ac12FXxNBZ21VY5QqnSzQ4sZ97eKb-66iED2WdLpg2CP9xg85i8cPERoB_qk5SE
Message-ID: <CAMMMRMeqAToQ=iAjLrT64q3g+e_K_3Mqp4uh3LNnULMTJeY-iw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] usb: typec: Add alt_mode_override field to port property
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 12:53=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Aug 14, 2025 at 06:44:51PM +0000, Andrei Kuchynski wrote:
> > This new field in the port properties dictates whether the Platform Pol=
icy
> > Manager (PPM) allows the OS Policy Manager (OPM) to change the currentl=
y
> > active, negotiated alternate mode.
> >
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > ---
> >  drivers/usb/typec/class.c | 14 +++++++++++---
> >  drivers/usb/typec/class.h |  2 ++
> >  include/linux/usb/typec.h |  1 +
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 67a533e35150..a72325ff099a 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -459,9 +459,16 @@ static umode_t typec_altmode_attr_is_visible(struc=
t kobject *kobj,
> >       struct typec_altmode *adev =3D to_typec_altmode(kobj_to_dev(kobj)=
);
> >
> >       if (attr =3D=3D &dev_attr_active.attr)
> > -             if (!is_typec_port(adev->dev.parent) &&
> > -                 (!adev->ops || !adev->ops->activate))
> > -                     return 0444;
> > +             if (!is_typec_port(adev->dev.parent)) {
> > +                     struct typec_partner *partner =3D
> > +                             to_typec_partner(adev->dev.parent);
>
> That looks a bit unnecessary. Also, can't the altmode be a plug alt mode?
>
> > +                     struct typec_port *port =3D
> > +                             to_typec_port(partner->dev.parent);
> > +
> > +                     if (!port->alt_mode_override || !adev->ops ||
> > +                             !adev->ops->activate)
> > +                             return 0444;
> > +             }
>
> How about:
>
>         struct typec_altmode *adev =3D to_typec_altmode(kobj_to_dev(kobj)=
);
>         struct typec_port *port =3D typec_altmode2port(adev);
>
>         if (attr =3D=3D &dev_attr_active.attr) {
>                if (!is_typec_port(adev->dev.parent)) {
>                         if (!port->alt_mode_override || !adev->ops || !ad=
ev->ops->activate)
>                                 return 0444;
>                 }
>         }
>

I completely missed typec_altmode2port function.
Thank you!

> >       return attr->mode;
> >  }
> > @@ -2681,6 +2688,7 @@ struct typec_port *typec_register_port(struct dev=
ice *parent,
> >       }
> >
> >       port->pd =3D cap->pd;
> > +     port->alt_mode_override =3D cap->alt_mode_override;
>
> This needs to be enabled by default:
>
>         port->alt_mode_override =3D !cap->no_mode_control;
>

Agreed.  I'll make it enabled by default.

> >       ret =3D device_add(&port->dev);
> >       if (ret) {
> > diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> > index db2fe96c48ff..f05d9201c233 100644
> > --- a/drivers/usb/typec/class.h
> > +++ b/drivers/usb/typec/class.h
> > @@ -80,6 +80,8 @@ struct typec_port {
> >        */
> >       struct device                   *usb2_dev;
> >       struct device                   *usb3_dev;
> > +
> > +     bool                            alt_mode_override;
>
> s/alt_mode_override/mode_control/ ?
>

Agreed. mode_control is a clearer name.

Thank you for your review!


Andrei

