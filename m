Return-Path: <linux-kernel+bounces-846374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D0ABC7BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26F82351FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC505298CA4;
	Thu,  9 Oct 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZPEhhh1Y"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD82512DE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995864; cv=none; b=nxO+7DqlXA8AKbg3TzgUI+m8NNs9dLP1HT2Y7leadL0QlkptwEewg+JZAWBn68AeU8nRcDC8Eg/tNdVSOe75ZxNsLRbNld8MXJmCtxZbCAcLkjM172slpsknYiBto56U3cVnlpTqI1yX1RuSK+dtNJzKBPSHQiYKkSNswQtxipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995864; c=relaxed/simple;
	bh=iCQQf2uoJXeyZbpOaPp2ooQjyhOwe9helnVbfiNK5qM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4rJjXZ/5T3bIe5lE9LSuQ76SP8VTaoRVZSJEITPaNKnkTcyxs6acXkA58bdu8jog6nyQpbal8f4dhZeiIyqhWOgMBfP0Lo6I6zbzrl4nXx9JXw+g3t0XmrWINabWLRf8nHf4P4tVEgT7bBsHO83/tKUiSCKron6/fk5cfwDxc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZPEhhh1Y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so3172485e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759995859; x=1760600659; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCQQf2uoJXeyZbpOaPp2ooQjyhOwe9helnVbfiNK5qM=;
        b=ZPEhhh1YlYSM0n+Bt1eQALDrvH5+He1hEKYCiPiEgmSI5MlpO2SQ5bM542bhRFseSH
         CtrJa/MvNrSWWSqbPG7IKN+dyyzi07rzN0TNRGh8H+Gp9kY//t11t4081vFRE1fDL+GB
         u+rhMx9CvSK0rTVDgO1YR2Wze5dID2yrT0PhSWeZzUqA//kAeV1wy2JqY6uF/Z7o2siD
         h6ZILhC3hJ1CxOFkl1hvJiI9Zec8QJjUkokb5hJhhoYcAcNbpnlUrglIiEa8wSZiBlWS
         o5jqUbuS8YnrGp5Ot64LJoHdn6L8cyPoiEAOzzDac5ZBkgEZvxRlkuXt0EJ0lYC8nbm7
         xd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995859; x=1760600659;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iCQQf2uoJXeyZbpOaPp2ooQjyhOwe9helnVbfiNK5qM=;
        b=aVByXw9NLW6zP4z7KtNL1aOiEYcx4axL73bLqVAva++Y7v6f3Pjmw6KNuRbqtrfOcF
         8k6tZsJEF1JNDc+SYier/aehslw74PVT/kC5tRhG304T9Uy7EssA3g1kSzoGbKAscPjJ
         xW3tlPA9YMWuAf11Iu4liMUsxfeayQredi/StT1mka4qtfbvKnnDjCSMVDN0chy1ptqD
         qXQcFcA6Ii47AUwQ0YsYM0jMgSzwHCa0/J4cViYJyMK2dE85okVp/+KDh/uX1ReXSoDx
         F1i5wgkE8+UB7fsDZwSRuoNW1FlkTtXI/xoA3sC4clTVtCqcSwYVRziCM/Y/VPUeuD7L
         OeNw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Q56hi4SMtkcGWOYiiKJTE0ANdADHtWfjcpY8qZ7UTwHd/vKaJrvrV5KgapEnjjAC1p9uFc3sTzxcxPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlFwrhd7UJ2TfcnUicl7PE47Dtx36GYGGHT4kYLZt81G0LwjbK
	q4t53oDsA5AaIpQqJ8hDGwtsCTPdqcfLPVGt4lUHVqSfa87IzKMaky4/A8KcvsdhFDI=
X-Gm-Gg: ASbGnct3S9jbT0dcBzxvsH07guVuC853Ht2tFkALFXUgis+mnYN0hiynq1c2wbDY2ZV
	fJT6Teg3aoW4BR1auOPa70+jQl2N926j07+g7+hfXgo8DCLQXEelU0/3XfcReFhH6ebemiQdXWK
	VqTH4d4aV//GfdPgRGMmF7uYG+2vB4tysAHgDecyh4nWTPoDMvzGYxucMVC0mI0LGwhCkQem1Mz
	pub5uMIrUOjFJCAQdG8re0xvyWph+mP6mznFSbupOVOe3LuN0YczWUlaCW3a38U1GT+mIvauxmz
	fJwgeAGmx17c8Y4IGCsVPbPI2P4BA83GEjYRLfqPkd+wQ2zuDokmxTx3LZ4wUoT6j9A6Fi4qhf+
	bM3de1NXyBSKZzB/H1Vo+1FZ4llT5PtITUJTnq+mWBg==
X-Google-Smtp-Source: AGHT+IFa3cZOVZtADvYdkDcmbhu1ikrOjFJn1uxG6wiO7vtbWkKr1hQX/8fH4Mn3m7l1iei0BuiNeg==
X-Received: by 2002:a05:600c:1986:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-46fa9aa1cb9mr43404525e9.13.1759995858939;
        Thu, 09 Oct 2025 00:44:18 -0700 (PDT)
Received: from [10.203.83.190] ([151.35.169.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d62890sm69037225e9.14.2025.10.09.00.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:44:18 -0700 (PDT)
Message-ID: <02a02848044c32e78cfc806a3b95c1cb0d93d7fc.camel@baylibre.com>
Subject: Re: [PATCH] gpio: pca953x: enable latch only on edge-triggered
 inputs
From: Francesco Lavra <flavra@baylibre.com>
To: Martyn Welch <martyn.welch@collabora.com>, Linus Walleij
 <linus.walleij@linaro.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Maria Garcia <mariagarcia7293@gmail.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Potin Lai <potin.lai.pt@gmail.com>, Mark Tomlinson
 <mark.tomlinson@alliedtelesis.co.nz>, Fabio Estevam <festevam@denx.de>, Ian
 Ray <ian.ray@gehealthcare.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 09 Oct 2025 09:44:07 +0200
In-Reply-To: <c75a89f8-9eb7-4300-979e-e11159dc6888@collabora.com>
References: <20251008104309.794273-1-flavra@baylibre.com>
	 <CACRpkdYDMRZMb+bDUgK5yiKU1Toy=S_ebo2_4WRasHxCqv+4xw@mail.gmail.com>
	 <c75a89f8-9eb7-4300-979e-e11159dc6888@collabora.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-87eCoRChGe7NyYF48ceM"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-87eCoRChGe7NyYF48ceM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-09 at 08:17 +0100, Martyn Welch wrote:
> On 09/10/2025 07:03, Linus Walleij wrote:
> > Hi Francesco,
> >=20
> > thanks for your patch!
> >=20
> > On Wed, Oct 8, 2025 at 12:43=E2=80=AFPM Francesco Lavra <flavra@baylibr=
e.com>
> > wrote:
> >=20
> >=20
> > > The latched input feature of the pca953x GPIO controller is useful
> > > when an input is configured to trigger interrupts on rising or
> > > falling edges, because it allows retrieving which edge type caused
> > > a given interrupt even if the pin state changes again before the
> > > interrupt handler has a chance to run. But for level-triggered
> > > interrupts, reading the latched input state can cause an active
> > > interrupt condition to be missed, e.g. if an active-low signal (for
> > > which an IRQ_TYPE_LEVEL_LOW interrupt has been configured) triggers
> > > an interrupt when switching to the inactive state, but then becomes
> > > active again before the interrupt handler has a chance to run: in
> > > this case, if the interrupt handler reads the latched input state,
> > > it will wrongly assume that the interrupt is not pending.
> > > Fix the above issue by enabling the latch only on edge-triggered
> > > inputs, instead of all interrupt-enabled inputs.
> > >=20
> > > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > > ---
> > > =C2=A0 drivers/gpio/gpio-pca953x.c | 7 +++++--
> > > =C2=A0 1 file changed, 5 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-
> > > pca953x.c
> > > index e80a96f39788..e87ef2c3ff82 100644
> > > --- a/drivers/gpio/gpio-pca953x.c
> > > +++ b/drivers/gpio/gpio-pca953x.c
> > > @@ -761,10 +761,13 @@ static void pca953x_irq_bus_sync_unlock(struct
> > > irq_data *d)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int level;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (chip->driver_dat=
a & PCA_PCAL) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DECLARE_BITMAP(latched_inputs, MAX_LINE);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(mutex)(&chip->i2c_lock);
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* Enable latch on interrupt-enabled inputs */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pca953x_write_regs(chip, PCAL953X_IN_LATCH, chip-
> > > >irq_mask);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* Enable latch on edge-triggered interrupt-enabled
> > > inputs */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bitmap_or(latched_inputs, chip->irq_trig_fall, chip-
> > > >irq_trig_raise, gc->ngpio);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bitmap_and(latched_inputs, latched_inputs, chip-
> > > >irq_mask, gc->ngpio);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pca953x_write_regs(chip, PCAL953X_IN_LATCH,
> > > latched_inputs);
> >=20
> > This driver is used by a *lot* of systems and people.
> >=20
> > It is maybe the most used GPIO driver in the kernel.
> >=20
> > So I added a lot of affected developers to the To: line of
> > the mail so we can get a wider review and testing.
> >=20
>=20
> I don't have access to the relevant hardware to test this anymore and=20
> it's been a while since I thought much about edge vs. level triggered=20
> interrupts. But if the state of the interrupt is unilaterally returning=
=20
> to an inactive state, it sounds like that should be configured as an=20
> edge triggered interrupt, not a level triggered one...

I will try to better describe the problematic scenario:
- a device has an IRQ line that becomes active when the device needs to be
serviced, and becomes inactive when the device has been serviced (e.g. by
reading a status register); this is the classic use case for level-
triggered interrupts
- the IRQ line of this device is connected to a pca953x input, and this
input is configured as a level-triggered interrupt
- the device IRQ line becomes active, this triggers an interrupt in the
pca953x, the pca953x interrupt handler is invoked, it reads the input
state, then calls the nested interrupt handler
- the nested interrupt handler services the device, which causes the IRQ
line to become inactive: this triggers a second interrupt in the pca953x
- before the pca953x interrupt handler is invoked for the second time, the
device IRQ line becomes active again
- the pca953x interrupt handler is invoked, it reads the input state, which
shows the line as inactive (because that is the state that triggered the
second interrupt), and as a result the nested interrupt handler is not
invoked, and the device will stay forever with the interrupt line asserted

With my proposed change, in the last step above the pca953x interrupt
handler will read the current input state instead of the state that caused
the second interrupt, and thus will correctly invoke the nested interrupt
handler for the second time.

--=-87eCoRChGe7NyYF48ceM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmjnZ8cACgkQ7fE7c86U
Nl8q+Av9Fz36mu0mVyCvX6iTdMZgYCVCSKJWYlXhVgH/spICVB7pTVKX/9SUAc22
gNsR0ONj5o+3G2Mk42oTO7z7SNQutS5s4gXCRofq1y1pSnnRv2NXIQSrsTsJ7ZPn
S8obTCuy4rY990MutgZZyQOO+pPv/N+Po2Tlrv4/XOKZnkRLi+6wzbIulc3zoZMi
aMNdFZG7QXVqB5vVhycwSwH1qu864wIKa9mhKbD7uU3aECooNvkjYXep9qaVSO69
2m6TNwpUoqUvD9xgiJQ5OILdaQwff+mPaN26Mrh7KP/zUqLvqkJFlQ+r92z9IWt9
kgmiVVHu3Vq50W7ZL5hWChcD3LCKjPzqTgFxdiZnPJfJSFio7dHqkPooqfWvzVGn
1WauoPjhWdqAci0swx6W/EiRlHGgELtFtH49DP/uhwUSffNl00jVqHQffc9WGAKv
su9MGNQVh5zYAglmNRqEBD9i2dsVD4QQBeGXG6poOH5fw/E3xOi4+w+xF30lVYA3
YZj/HT1G
=yN0R
-----END PGP SIGNATURE-----

--=-87eCoRChGe7NyYF48ceM--

