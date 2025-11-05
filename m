Return-Path: <linux-kernel+bounces-886273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF095C35223
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EA7188C063
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DE2304BCC;
	Wed,  5 Nov 2025 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JZKqxIzO"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC3304BB4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339183; cv=none; b=KazsivjhFQQfWt0xlaaHrSdmglZEZ84LVXHBGdVPc9Pmhu3emkPvvn/xg3kqe8zZLiMduWUzR4c0v39IiAomJMaNkYK6ZMuSZlkIkwtF33szY3UV+c1CWwJe+p7L9Q32WLmLeTLpXse8EOBDwRsl5E0IrTNSTbp+9XQBmT9N+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339183; c=relaxed/simple;
	bh=ovOsA3sRvmePc/BFuQ2bPYsX4LShs+ca4NSpAP3DwHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CL1Sh7yPmbMLmjbVBR8rkqStSht8Yx3MDdYd6dZuMEZ22uQk6VFCLyyZQbU5Vzdp2MBD4KuzbIGP3n+kLVQG4Jnejpiy7WamNIVf8QiXH9vieNF0ydGn/MtwCaFwJ1z1c+O2ZEfv0lmHMSWn0K+zTvBC1Y6Mt3oYAH/fSGKGaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JZKqxIzO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5943f39bf9dso566615e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762339179; x=1762943979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX8jUJC9z6+DnLPlPqHdV1rtZ2ABpTdkpp9c22/3Po4=;
        b=JZKqxIzONtQa9TKN8TM7yISuW9amBRWqSbc1aJQK2Nzjd44tnRZ177sjJjrJsYdieV
         zq1o+xrCYkw7egmNZm7xp1p+LPinVTLeFGj35x2RUEX3CpUddHJtauIZUgu84Oa+z58Y
         KMy74TrYcsZj1uVd4hRw7Y0sa/Dda6+67Mx9e8VDKI5LOiTocZ0DGaCtZ4Cg0KokPZAC
         AyQ7Yo8X48dMoPtcTl9HmAJnZqWnZ0G5wC0ZU5qaofvXC6TJG91+LuAyDj+RsNuJAFYM
         HM9bwXJ3SNxNCa3OFv7TV50XrpWd3n0Vb8tIxXGIr52XNBG8ws0VntRkLZGE55mqbLbU
         knhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762339179; x=1762943979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IX8jUJC9z6+DnLPlPqHdV1rtZ2ABpTdkpp9c22/3Po4=;
        b=dFXQEgsM03rJ/YpRJk+lZhau5dNgTS6Dm4y5yATOVhl12K38l8U8UyW/sknRnn6QLW
         2mG25bJOV/fah83OrNBnx8E3bTn4nACceugs+egKgwyMusJMob5RfYE6EpKrjTi1cWNV
         ASZ+VagaIW6nM+OkcwljmILFudyAompgsLU0jsrf/sMhDcW+LEjyLxTQSauPwf/f6Dsv
         bheHcR6wD6t/MC8G0bce6JRbnj6fH+zrx/DnifNmto1xDSCzuXS8O4tSaGPGGiTOk92R
         0IOC7hXz3i/KEvP21IK2Zg9UvU7+zzRSoefC9Dri3hmR4YjloCLKznUesQuWmBXooBWO
         0wVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5zMYrMjSwBHplNNFdgWAPYuP2/uKz4ZBR8ADZrHllFcbvG1BIvpu/sRkChH/7CChJzYuQ9lUZYq2ktJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAYwU+kZ+iGinws9Dga5P6qJ+xoxzUJDWvrlKXes2y3EsqX4S
	VgaECTCy+m8UG2PVUtw6B0XNYqfQr4cOie85oHv0TExH18ldG7ouEVcRY45aTW7M5t/0u4yL3/H
	iPlBCk49pcPk+B2uyGGqD/rz6Len+dy8jIdf0oGEhmw==
X-Gm-Gg: ASbGncvAWQliVnmhWpiEdaOb2Ug6hJLAjFU+Sf+rtTTziDNDrKev2cnqwEjN3UErYQ+
	HyJCOGh5nDwZfJg2ocWu/I/r+YNzEVLauRbX6RcFX9P9WJcN8gpa8pAAHEpif0sFHYDH/psYxtH
	h+hAJTraNtl0AubWTTjfKEPUPqTW0U9I85i4QAQQtzKaQaItjXthLCWbzLpJNHPT3rglNnsVBvM
	0nq47eaE1gyZTrO7NamcEx9aiiwJPxB3+gQG2E7Vtm7qXyPQFrkOEV9Mqh6qQWZQqxoUED4yMBG
	GtcDGqwIN3V/295uuAFEj538Y4w=
X-Google-Smtp-Source: AGHT+IEnM2FB6aq6sr2YKCUEFggZNiE683XZK3TL4wAhKXX+lHuIJsctWL3BrPjaqlUculKk7mjqYV+FxMpxgfSwZhA=
X-Received: by 2002:a05:6512:ac7:b0:594:3343:b53a with SMTP id
 2adb3069b0e04-594348f3d77mr1866019e87.14.1762339179484; Wed, 05 Nov 2025
 02:39:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929-gpio-aggregator-fix-set-config-callback-v1-1-39046e1da609@bootlin.com>
 <CAMRc=MfG8-c_+_R3meR_DgK3OMM3JEMSWu3SjfdMz-aW8c5wew@mail.gmail.com> <743d8bda-6c95-4d10-88a3-72a42973781b@bootlin.com>
In-Reply-To: <743d8bda-6c95-4d10-88a3-72a42973781b@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Nov 2025 11:39:27 +0100
X-Gm-Features: AWmQ_bndJvMSb4b8IHkDu1XgkilqXY5JSwxortTjqsQIDfoJGhDhukcP0haRtBw
Message-ID: <CAMRc=Mf8At1Aofx8fykriptQr7XBQWS8cToAqg+nkhNFZ4nf8Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: restore the set_config operation
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:59=E2=80=AFAM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> Hi Bartosz,
>
> On 9/29/25 2:45 PM, Bartosz Golaszewski wrote:
> > On Mon, Sep 29, 2025 at 12:03=E2=80=AFPM Thomas Richard
> > <thomas.richard@bootlin.com> wrote:
> >>
> >> Restore the set_config operation, as it was lost during the refactorin=
g of
> >> the gpio-aggregator driver while creating the gpio forwarder library.
> >>
> >> Fixes: b31c68fd851e7 ("gpio: aggregator: handle runtime registration o=
f gpio_desc in gpiochip_fwd")
> >> Reported-by: kernel test robot <oliver.sang@intel.com>
> >> Closes: https://lore.kernel.org/oe-lkp/202509281206.a7334ae8-lkp@intel=
.com
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> ---
> >>  drivers/gpio/gpio-aggregator.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggreg=
ator.c
> >> index 37600faf4a4b728ceb1937538b3f6b78ab3e90fa..416f265d09d070ee33e30b=
f6773e9d8fffc242bd 100644
> >> --- a/drivers/gpio/gpio-aggregator.c
> >> +++ b/drivers/gpio/gpio-aggregator.c
> >> @@ -723,6 +723,7 @@ struct gpiochip_fwd *devm_gpiochip_fwd_alloc(struc=
t device *dev,
> >>         chip->get_multiple =3D gpio_fwd_get_multiple_locked;
> >>         chip->set =3D gpio_fwd_set;
> >>         chip->set_multiple =3D gpio_fwd_set_multiple_locked;
> >> +       chip->set_config =3D gpio_fwd_set_config;
> >>         chip->to_irq =3D gpio_fwd_to_irq;
> >>         chip->base =3D -1;
> >>         chip->ngpio =3D ngpios;
> >>
> >> ---
> >
> > Thanks for fixing it. I saw the report but I had already prepared my
> > big PR for Linus. This will still make v6.18-rc1, I will send it later
> > into the merge window. Please address Geert's review.
>
> Gentle ping, just in case of you forgot it :)
> Geert sent his Reviewed-by tag.
>
> Best Regards,
> Thomas
>

It did indeed escape my attention, thanks for the heads-up. Now queued.

Bartosz

