Return-Path: <linux-kernel+bounces-810891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9CCB5212B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB4B188CF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30692D7DEA;
	Wed, 10 Sep 2025 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QGxFpKUV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA72D661A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532909; cv=none; b=qO+Ayx0kDTY4pEqcEIht0YVHQogVsfj8GAFWyKWqgHFxaD7phGQew2nfcn0AnzbyG2SCwSaa+M0/gH4wK0CeW/y+8PLwU1J9doTVZDIW1eLZsntyykwOXuQO2tc4VtxGiwMQrmJbhNJcQZuG/YFXLDQm91JDM1l+4EjL9dOfGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532909; c=relaxed/simple;
	bh=CsZgHZkr4tn7L9FbK2mdWISDN6hWIqOwGACNjs21v8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RA6r1DbaV21tLGXD5rqoY3gXakdy9I+FwP9AlDcUqu5QYVwUmr+y6QtnDQleWrcmA+5UC5takQYm+aAfbFgczxzqM66uXulvJk3ib2aGCRWGhmM/AfUnW9lqlw0ZWFCzTdJ2P0b1aTFavPKUDH8rvrBrlyNKv5E+OjCY7fgPIaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QGxFpKUV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445805aa2eso71554025ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757532907; x=1758137707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaN2dDw0Si752HU39sC2oh3UCwyC8xRttQsbnNuAuQ0=;
        b=QGxFpKUVtXTLaLVdDTt+Hvu/saubc3dj7bkeZ3pCFdTr3C4IYOub65Sc66GbbItL+r
         ay/4IFRXKsiTJFt2RMEZFbDM42Zpf8sOR7mdOq0Ut3Yu3nLZtlS/WFQ/znRkCWSXxTod
         OCjD1A1UOJ+vdYy0eO3ImoamujrInjjv+sWhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532907; x=1758137707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaN2dDw0Si752HU39sC2oh3UCwyC8xRttQsbnNuAuQ0=;
        b=eW3+Jb/lpUTj/KkOqkl637c4LiGz3TbeVKRMIxXgwVVk5FjrVdOlbYNCxXiPstdfis
         1fAh0bM1nPLOP4nWcaXCS1VBlxHB4trtVAffRtNzaLL5Ow8BI/R1Z//Rwx6iNi9R0d9n
         jvnhux6YrC6NTH0Q+LX7HOYJmjULZ1RkYDwW3eFrpE8TosfqZGpKNELjl6ghEdGc2R07
         JrwNFY4k+72Dd2OA47omWdm4e+XatPKQjvRVOOrGfaMusiOeZv9Ilf9B9I2TnmPbAUcq
         qpks3LW/o0wIFrlr0N5ikfKvx0ONiRVBKW25AkA4qryynJGPiTxmqJrDHF4qOmeiSGiy
         yzPg==
X-Forwarded-Encrypted: i=1; AJvYcCU7tMLq5usp8dakY7FgR1DBLPkaCMx8j+fEZCtPsAFoSTLcpFIReZMh01q+lfSmt0j745WypWwPtWiE6Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXK3ly/zDiAmGPOV0QxwohgVHkqUFMBtCkg9VPXAa9lKus10LQ
	wc8Z6vxfl9ehRqF3sGswvmOGNC2A98+KCTi9Hg4i1kQ10UEgK3L5eLM57StBpCLEwyf48cW1UOq
	7aiDmKZWfqNMw0KJB4P3dNLrqJeHQgENb4rmJWMoQ
X-Gm-Gg: ASbGnctTEWD+KuZJIim3u3Ybein6owJlq5x3aUopbdqF5hoGhgwDdRLEwCufjQhqOvg
	+MIcKRU65UyjUQ6mMWaHOeyp51x968GGtImSKFsFPJ536OXvWM1ACrMu7tPrbBeD8uKD6tmqldL
	jQoB6H1vDC3vfuUK1dLpPBXw1lhIlax0whSbEJ9Vcjvb69CLiL5Sr9UeMkdYhCimIhw+nfLg7HJ
	JHdMRbR2KYg/gmgX7FnSKxhoIHswohGB9HnVjqyyvIdLw==
X-Google-Smtp-Source: AGHT+IHcU/z69xvrbw57LzdGyVMdV8NdA7YqwzpxDCURSyY8jW/b/eLvZUrXOdxkZd3mY3GdzlFaYXFYXK/MVdtoUuA=
X-Received: by 2002:a17:903:1cd:b0:24b:270e:56f0 with SMTP id
 d9443c01a7336-25173118c26mr237438225ad.29.1757532906699; Wed, 10 Sep 2025
 12:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905142206.4105351-1-akuchynski@chromium.org>
 <20250905142206.4105351-2-akuchynski@chromium.org> <2025091018-slather-dispose-015d@gregkh>
In-Reply-To: <2025091018-slather-dispose-015d@gregkh>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Wed, 10 Sep 2025 19:34:55 +0000
X-Gm-Features: Ac12FXwfN-e75qxmficq3kKl06l1JoLVbDE-L4oJXX6Yd_sZeBHeIpXc0h2q7D8
Message-ID: <CAMMMRMcqty7dC=UvwNZX90iVMnJATTPWYTf1fiee5_OoKfxSJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] usb: typec: Add mode_control field to port property
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:30=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 05, 2025 at 02:22:02PM +0000, Andrei Kuchynski wrote:
> > This new field in the port properties dictates whether the Platform Pol=
icy
> > Manager (PPM) allows the OS Policy Manager (OPM) to change the currentl=
y
> > active, negotiated alternate mode.
> >
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > ---
> >  drivers/usb/typec/class.c | 9 ++++++---
> >  drivers/usb/typec/class.h | 2 ++
> >  include/linux/usb/typec.h | 2 ++
> >  3 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 67a533e35150..9f86605ce125 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -457,11 +457,13 @@ static umode_t typec_altmode_attr_is_visible(stru=
ct kobject *kobj,
> >                                            struct attribute *attr, int =
n)
> >  {
> >       struct typec_altmode *adev =3D to_typec_altmode(kobj_to_dev(kobj)=
);
> > +     struct typec_port *port =3D typec_altmode2port(adev);
> >
> >       if (attr =3D=3D &dev_attr_active.attr)
> > -             if (!is_typec_port(adev->dev.parent) &&
> > -                 (!adev->ops || !adev->ops->activate))
> > -                     return 0444;
> > +             if (!is_typec_port(adev->dev.parent)) {
> > +                     if (!port->mode_control || !adev->ops || !adev->o=
ps->activate)
> > +                             return 0444;
> > +             }
> >
> >       return attr->mode;
> >  }
> > @@ -2681,6 +2683,7 @@ struct typec_port *typec_register_port(struct dev=
ice *parent,
> >       }
> >
> >       port->pd =3D cap->pd;
> > +     port->mode_control =3D !cap->no_mode_control;
> >
> >       ret =3D device_add(&port->dev);
> >       if (ret) {
> > diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> > index db2fe96c48ff..c53a04b9dc75 100644
> > --- a/drivers/usb/typec/class.h
> > +++ b/drivers/usb/typec/class.h
> > @@ -80,6 +80,8 @@ struct typec_port {
> >        */
> >       struct device                   *usb2_dev;
> >       struct device                   *usb3_dev;
> > +
> > +     bool                            mode_control;
>
> Shouldn't this go up higher in this structure, to avoid the hole you
> created, and to take advantage of the existing hole?  Perhaps after
> orientation?
>

I will replace the variable.

Thanks,
Andrei

