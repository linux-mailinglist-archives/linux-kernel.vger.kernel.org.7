Return-Path: <linux-kernel+bounces-837971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D1BAE284
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EF1188FB03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A826B0AE;
	Tue, 30 Sep 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b="xFbGRuG/"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94818A93F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252863; cv=none; b=tJOe9KdptJRWHfc9T2X/KVBKfRvacSvki3oqd0xAjvUjfu7LPsV2nGLRCiVUqlU3Cj9Wq/YpNXIy0GxNJNVdZU3d9j3c7BdLAMONURDqAmgYO4ulUoAdLeV5UOwfPdYMcrEw2P8KrI6dSS98eGiQs363++MrdsMlzbJttviKtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252863; c=relaxed/simple;
	bh=AJLtM91/33fmVR/qlQdypVuIczViZNMesjHgSFxWODs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SR4oNBgCVfVbpyOvwrTIx/z5GWwb6tB6KmHPMY4MUMhxgi5Basyn2F8CocnQ0pi5YGTN2d1yx2/Px3kJ1+z3kAqNHxvE7lj1d/NURlAvejJmuDRL8TJMR41cHyZqqDDHE5cQjjyaWP2hCr5dkyzQX581+4wD5dnbf1c1dxcvFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu; spf=pass smtp.mailfrom=iwell.eu; dkim=pass (2048-bit key) header.d=iwell-eu.20230601.gappssmtp.com header.i=@iwell-eu.20230601.gappssmtp.com header.b=xFbGRuG/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iwell.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwell.eu
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6366b7fd337so1433490a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwell-eu.20230601.gappssmtp.com; s=20230601; t=1759252859; x=1759857659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBeBiFZ8CYYNIOcno906wggBnrfnmw8kk5vZNSaIIco=;
        b=xFbGRuG/PMyyMgxQRSfN2ZQD3EySNO6QvfQIwPh8B/XPwGvFYQNUMzDjYMuXGrKIde
         54rUl/jY1ZoKPdonw9g+2qS1usCH8ofNbUn31f5wFEl/aOU66cr8zCB1MtFBcTjoPz2N
         Vw810d8ISL+d4NxzlUz0PmA2k5VVNFCEHZZsdqvskRNoWw9n+6i6nGM/UWqIlBBbJIKQ
         n5wdoppZmtPuSHZQv/xY2PrTJavn0kfEcAu2ik9K3Xzm3jnEsMlzwuPcutM2IRfyrTNe
         oE/tKbtxeKYYXVtyBh1P/MNHnh8833ojOsKPDO+sJeQD0PqDgz33W9byAMzIEALm9oJJ
         rqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252859; x=1759857659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBeBiFZ8CYYNIOcno906wggBnrfnmw8kk5vZNSaIIco=;
        b=AweMhgMK7JtyTdcCeKWfWqhP5ZQZKhbCAp+D8D72apSLSC3uUg/hgfkMunmoBAF+uM
         CDUq/IavPPW7x2fkYTgQpZnmPg16DOcbunjQXMIMbnTUYEJvjDc/r0pbLp5Dmv/qxpn3
         JPPnWi3YuoEJlh2JiAggjR5IhkZEWmSBXD943skWLLjaAyKMVhD4EmhG50SWwUPKlzLb
         CVEUptcsYoG6wOyUvUhZwme2VLAoMwQqzZYNSYhAfZRfvQ3JZPz+sBPn2bcQ11IAuuG0
         wsLB0eC/mSkYXn0+jCumt3OC6K0GQpMzIoDISgU0c3H+2zY99M/lGzATZAjlC4j8lKtC
         wwBA==
X-Forwarded-Encrypted: i=1; AJvYcCX7VCNAjSIxNPrK4DqvthDfSTVCV5r+JRqPQ55QAY8nkTKin+rHKIT2m4AMBzWvaU6aGKrWe+JFapK68mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvkFatDn0Z8YzDIc1gaDlaRKk/GosGW9HbSXzf+2kGzbFtKng
	KxivNdJcuDipgVumOvScJJc3z5vhbqsk832rIjCb41J1DZg0xD5TP1nb/vFqaswfkkoij+Qmja8
	d+J/lgGxVEicmhlQ+k2hBRLLrbhksyu2TfOz2xaRk3Q==
X-Gm-Gg: ASbGncvhdsGHpChka+8cI99CZL1aqLbJ0cOsqCJXOtXVf4N3W+DhBeKztjs6Xvk+C7T
	3KyRdh87RG9oOOQcNVfg01zOLaBmAkfJmDBxlubquEIZLSmgNoapd+xMG+9PXKMbR9qA7Lad/pi
	M2oIyf4s6lU4G7hWfxAEhEu+nNPuU1Ut7aS7VvPb+9JbFrqnlamnqxOjWBAx/mILc2gFW9/aNd9
	CZ0KaT/MumDjvqsNtgkeR+TnN/qK5j1
X-Google-Smtp-Source: AGHT+IF6gmWMMmnvd8SXAqteiQRvavbIiqTU4ziQkpjq2GxFYPnxTuZRkuqmxUhWfFskN7jiuo/ToSuXYLZtYEdbzhQ=
X-Received: by 2002:a05:6402:4305:b0:634:a584:6e44 with SMTP id
 4fb4d7f45d1cf-63678ca5df9mr759820a12.18.1759252859032; Tue, 30 Sep 2025
 10:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923221756.26770-1-marnix.rijnart@iwell.eu> <0ab2436f-5c0d-966f-7095-d281292c494c@linux.intel.com>
In-Reply-To: <0ab2436f-5c0d-966f-7095-d281292c494c@linux.intel.com>
From: Marnix Rijnart <marnix.rijnart@iwell.eu>
Date: Tue, 30 Sep 2025 19:20:48 +0200
X-Gm-Features: AS18NWBUxk6JDFUrYMRmquwKP7cxr7696-nl8HLRBqtqZNVEfYHLfT27GfYxE-I
Message-ID: <CAAn10+fRb8VXnDEsSuCj782rp43ZEeov2yXnB2pYxXGNc-2niQ@mail.gmail.com>
Subject: Re: [REGRESSION][PATCH] serial: 8250_pci: Fix broken RS485 for F81504/508/512
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is my first interaction with the kernel community, so I did my
best to read up on the expected practices but maybe I missed
something.

I didn't add a Fixes tag for commit 4afeced because it doesn't cause
the bug by itself, it's the interaction between it and an older commit
(456d523) that create the issue together. What's the right way to tag
this?

I didn't Cc stable because I understood this to be only required for
point release regressions within a stable series
(https://docs.kernel.org/admin-guide/reporting-regressions.html).
Release 6.8 introduced this regression. Should I still Cc them?

If these tags need to added, what's the best way to do so? Resubmit
the patch (as a v2)?

Thanks,
Marnix

Op di 30 sep 2025 om 13:32 schreef Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com>:
>
> On Wed, 24 Sep 2025, Marnix Rijnart wrote:
>
> > Commit 4afeced ("serial: core: fix sanitizing check for RTS settings")
> > introduced a regression making it impossible to unset
> > SER_RS485_RTS_ON_SEND from userspace if SER_RS485_RTS_AFTER_SEND is
> > unsupported. Because these devices need RTS to be low on TX (fecf27a)
> > they are effectively broken.
> >
> > The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND,
> > so fix this by announcing support for SER_RS485_RTS_AFTER_SEND,
> > similar to commit 068d35a.
> >
> > Signed-off-by: Marnix Rijnart <marnix.rijnart@iwell.eu>
>
> The Fixes tag is missing?
>
> (And Cc stable tag will be necessary as well).
>
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
> > index 152f914c599d..a9da222bd174 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -1645,7 +1645,7 @@ static int pci_fintek_rs485_config(struct uart_po=
rt *port, struct ktermios *term
> >  }
> >
> >  static const struct serial_rs485 pci_fintek_rs485_supported =3D {
> > -     .flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> > +     .flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_=
RTS_AFTER_SEND,
> >       /* F81504/508/512 does not support RTS delay before or after send=
 */
> >  };
> >
> >
>
> --
>  i.
>

