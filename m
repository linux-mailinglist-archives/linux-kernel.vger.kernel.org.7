Return-Path: <linux-kernel+bounces-827033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B65B8FFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA485188DE61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817E2FC001;
	Mon, 22 Sep 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUhJ99K2"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BE27B4FA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536518; cv=none; b=MJaZi4HeDTn8owVsZXhErVq/yBUeg9jKops/R0Myg2bSs7bhNC2ReUb0LzWBdOJhiAzaVWTdCbYwIwJSpmXpB1B5XxXHqtfdzRJ6xBFGs/18LUbuP/SscPwX2G1eykWgq+wf8GGNDzcuMMItw3PpECBTBwmzu7IkKXIMP/9Om3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536518; c=relaxed/simple;
	bh=6D3C4NKcjggk2Xj5Rl9Vb2TSMCHcURlQFKxeVhEQcuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLoPDDZTLCD26mC+ZiAIAD33Y+7+VfD2uffAGXPl9rkM9H4ziQ8gMskMiFcm5dBdE5UZfV8tSgndNLmERv7maIoQ4r0fDAHQZ1X66JwkUmU3srcau/SbJWyA5J24izPSVLak6XMHaYVeDY1SCYe4k9HyEaEXytd509OfYLNZHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUhJ99K2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b54a588ad96so3124680a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758536516; x=1759141316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgzrsKFjkdOHqZq8z9KJvQRmwrFpRxJTot1VKAx98R8=;
        b=gUhJ99K2IWUdDoDvDch/f5l5v/Re1hL9lVEyXOpcyUQI1CaFNRJAKyDXZWjinY4J36
         R6IG1409IzxniMGslrxWay4iljD1hCPPI/InnVNx8rkUx5wNAhy5W915HbNwfrCzBggC
         VbfKK066rZL3L3GT5PgenjRLb9/wai7ClurYaTkyjrUPxM9e53DbBThmh+qriZ3Pt3o1
         26+8bfqSF48X42FXsqdt08k5qkLwxOhHwEtPmeexdE0JvYWjdD9jg3tpfScI1bb9JVNo
         88LM7RaNcjkKABNMyD+Eq2/X/owfHL1I1ZJE+/O/ZcZUEPOGgw6b7eJRQniQCWMG97uJ
         0fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758536516; x=1759141316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgzrsKFjkdOHqZq8z9KJvQRmwrFpRxJTot1VKAx98R8=;
        b=lnze5OkhSO2tNkE27byU32Z8XwRQBEgK9dWskgZ/bvJyOdVz8/MWGX7xClOy2umCvF
         /A2bRePenyCr6LaLrTO9iI909ZLfHIN8eAWKXvuS7RvvT4C3bZts8Va8/tV8yGN2dPI4
         MilBuY8r7V/aVdYF7FRUcM+BCrNgRuYV2W9r12v3Mq35DzE5Rlb8QIGuJSM4R4g/llAt
         DiBB1RsnOoMbPmmKWWewKoSyeYWaeL+cMyMXGyOVyjqpVqAsoIE82wgvw0gMbcLjXfjL
         5RwiR/LRc6u35anv12sYFtIGYg4s1n2d7oP6Q3GKqTvh+UoV13v0aW5AoSH1Te1U5dD7
         wNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXilU2CINLdPtByMQUSCSuQQ/+NVaQ2XW+R7Ah0lqjhmhy/RUPFwZn2QTquzpmHgv0aL289674NfPx3Uac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVWkyZn/4K6VqkDkONioYhEJ1u1vu7eJJTMZ/VTfHYfFs0GSz
	0l5R4K0ObGNKQPiej0GvWycf8KE7jM/8qYkiFfBo0TPQjWBF5GwM37VKH/KfhQ==
X-Gm-Gg: ASbGncvnHsM7nTl6c0Z5gq59/ibQsDh43xluav7EfeLHFGGaCQm4dHSPTCHlPEK/xyc
	3ES8HdOSg8y1mnQsh8CIoUpoz0FUXyazrmIEz0nO5LNVlAPT3eEO2bJ7YunCCQ3B8+KYqPO6yf4
	XNl7zySbIlNesThrZVYOfkc8jU4Wp/3WTljmk6MUbT36KOyELeN1DheGfA9/a4RQIq9t14vnurD
	nJvX3gtfn4NsgKZnCop2xGfVI2TeGRGi4Zj17RnQ3Eoyo+TrqRHAmwLkpVz7dflQaqq/xn1tBt8
	3cmtI3fbR9ht4UNqp4r1NQksHB0kNqkYaXSZJ1q6odoP2EEnUsmHTlx4aDeBLU1ofHZ/pu38aA0
	vaCka99dVuzGZ5H/ZNpBaqEy6YRQk5+OE
X-Google-Smtp-Source: AGHT+IFKvuB8nQ7chq/pZQMYgIgXJUcMFLs1cyYqPT9bIL5ygOY6/yTLZdyMi8zHSlQUMW4v/IZp4A==
X-Received: by 2002:a17:90a:e509:b0:32e:dcc6:cd3f with SMTP id 98e67ed59e1d1-3305c6d8db1mr15617472a91.14.1758536515713;
        Mon, 22 Sep 2025 03:21:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e70c06ba1sm9402454b3a.67.2025.09.22.03.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:21:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 98E2B423FA7F; Mon, 22 Sep 2025 17:21:52 +0700 (WIB)
Date: Mon, 22 Sep 2025 17:21:52 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Bernie Thompson <bernie@plugable.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH 2/3] Documentation: fb: Retitle driver docs
Message-ID: <aNEjQEY5J5DBTF8P@archie.me>
References: <20250919003640.14867-1-bagasdotme@gmail.com>
 <20250919003640.14867-3-bagasdotme@gmail.com>
 <222d551c-fb01-4a8c-9b83-daef019b6795@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pyPpSPV0lzt8YzEF"
Content-Disposition: inline
In-Reply-To: <222d551c-fb01-4a8c-9b83-daef019b6795@infradead.org>


--pyPpSPV0lzt8YzEF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 09:08:57PM -0700, Randy Dunlap wrote:
> > diff --git a/Documentation/fb/aty128fb.rst b/Documentation/fb/aty128fb.=
rst
> > index 3f107718f933fc..0da8070a552165 100644
> > --- a/Documentation/fb/aty128fb.rst
> > +++ b/Documentation/fb/aty128fb.rst
> > @@ -1,8 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is aty128fb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -.. [This file is cloned from VesaFB/matroxfb]
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +aty128fb - ATI Rage128 framebuffer driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  This is a driver for a graphic framebuffer for ATI Rage128 based devic=
es
> >  on Intel and PPC boxes.
> > diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
> > index 6badff64756f49..3d4aab406dee0a 100644
> > --- a/Documentation/fb/efifb.rst
> > +++ b/Documentation/fb/efifb.rst
> > @@ -1,6 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is efifb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +efifb - Generic EFI platform driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  This is a generic EFI platform driver for systems with UEFI firmware. =
The
> >  system must be booted via the EFI stub for this to be usable. efifb su=
pports
> > diff --git a/Documentation/fb/gxfb.rst b/Documentation/fb/gxfb.rst
> > index 5738709bccbbf3..3fda485606bdc1 100644
> > --- a/Documentation/fb/gxfb.rst
> > +++ b/Documentation/fb/gxfb.rst
> > @@ -1,8 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is gxfb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -.. [This file is cloned from VesaFB/aty128fb]
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +gxfb - AMD Geode GX2 framebuffer driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  This is a graphics framebuffer driver for AMD Geode GX2 based processo=
rs.
> > =20
> > diff --git a/Documentation/fb/lxfb.rst b/Documentation/fb/lxfb.rst
> > index 863e6b98fbae55..0a176ab376e30e 100644
> > --- a/Documentation/fb/lxfb.rst
> > +++ b/Documentation/fb/lxfb.rst
> > @@ -1,9 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is lxfb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -.. [This file is cloned from VesaFB/aty128fb]
> > -
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +lxfb - AMD Geode LX framebuffer driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  This is a graphics framebuffer driver for AMD Geode LX based processor=
s.
> > =20
> > diff --git a/Documentation/fb/matroxfb.rst b/Documentation/fb/matroxfb.=
rst
> > index 6158c49c857148..34cafaa00bab19 100644
> > --- a/Documentation/fb/matroxfb.rst
> > +++ b/Documentation/fb/matroxfb.rst
> > @@ -1,9 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is matroxfb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -.. [This file is cloned from VesaFB. Thanks go to Gerd Knorr]
> > -
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +matroxfb driver for Matrox devices
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Add a '-' after matroxfb
>=20
> > =20
> >  This is a driver for a graphic framebuffer for Matrox devices on
> >  Alpha, Intel and PPC boxes.
> > diff --git a/Documentation/fb/pvr2fb.rst b/Documentation/fb/pvr2fb.rst
> > index fcf2c21c8fcfeb..315ce085a5855b 100644
> > --- a/Documentation/fb/pvr2fb.rst
> > +++ b/Documentation/fb/pvr2fb.rst
> > @@ -1,6 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is pvr2fb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +pvr2fb - PowerVR 2 graphics frame buffer driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  This is a driver for PowerVR 2 based graphics frame buffers, such as t=
he
> >  one found in the Dreamcast.
> > diff --git a/Documentation/fb/sa1100fb.rst b/Documentation/fb/sa1100fb.=
rst
> > index 67e2650e017d12..c5ca019b361a94 100644
> > --- a/Documentation/fb/sa1100fb.rst
> > +++ b/Documentation/fb/sa1100fb.rst
> > @@ -1,9 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is sa1100fb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -.. [This file is cloned from VesaFB/matroxfb]
> > -
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +sa1100fb - SA-1100 LCD graphic framebuffer driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > =20
> >  This is a driver for a graphic framebuffer for the SA-1100 LCD
> >  controller.
> > diff --git a/Documentation/fb/sisfb.rst b/Documentation/fb/sisfb.rst
> > index 8f4e502ea12ea7..9982f5ee05601b 100644
> > --- a/Documentation/fb/sisfb.rst
> > +++ b/Documentation/fb/sisfb.rst
> > @@ -1,6 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is sisfb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +sisfb - SiS framebuffer device driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  sisfb is a framebuffer device driver for SiS (Silicon Integrated Syste=
ms)
> >  graphics chips. Supported are:
> > diff --git a/Documentation/fb/sm712fb.rst b/Documentation/fb/sm712fb.rst
> > index 8e000f80b5bc6d..abbc6efae25f46 100644
> > --- a/Documentation/fb/sm712fb.rst
> > +++ b/Documentation/fb/sm712fb.rst
> > @@ -1,6 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is sm712fb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +sm712fb - Silicon Motion SM712 graphics framebuffer driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  This is a graphics framebuffer driver for Silicon Motion SM712 based p=
rocessors.
> > =20
> > diff --git a/Documentation/fb/tgafb.rst b/Documentation/fb/tgafb.rst
> > index 0c50d2134aa433..f0944da1ea5ef1 100644
> > --- a/Documentation/fb/tgafb.rst
> > +++ b/Documentation/fb/tgafb.rst
> > @@ -1,6 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is tgafb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +tgafb - TGA graphics framebuffer driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  This is a driver for DECChip 21030 based graphics framebuffers, a.k.a.=
 TGA
> >  cards, which are usually found in older Digital Alpha systems. The
> > diff --git a/Documentation/fb/udlfb.rst b/Documentation/fb/udlfb.rst
> > index 99cfbb7a192238..9e75ac6b07c36a 100644
> > --- a/Documentation/fb/udlfb.rst
> > +++ b/Documentation/fb/udlfb.rst
> > @@ -1,6 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is udlfb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +udlfb - DisplayLink USB 2.0 driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  This is a driver for DisplayLink USB 2.0 era graphics chips.
> > =20
> > diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
> > index f890a4f5623b45..5ffb35efd4538a 100644
> > --- a/Documentation/fb/vesafb.rst
> > +++ b/Documentation/fb/vesafb.rst
> > @@ -1,6 +1,6 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -What is vesafb?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Generic graphic framebuffer driver (vesafb)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> vesafb - Generic graphic framebuffer driver
>=20

I'll apply your suggestions in v2.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--pyPpSPV0lzt8YzEF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaNEjPAAKCRD2uYlJVVFO
o0xBAPsF+0ID1n8HvR0EkLu/NKqM0MGLm6ptctFnkIuLD3On3wD2KyiCl8y52YFV
tV983e3Znmh0verqBnsd7h+R1jzQAA==
=h3sz
-----END PGP SIGNATURE-----

--pyPpSPV0lzt8YzEF--

