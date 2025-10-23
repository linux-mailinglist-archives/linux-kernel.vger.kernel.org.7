Return-Path: <linux-kernel+bounces-866929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FA1C01110
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A8B1A03896
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9C31329E;
	Thu, 23 Oct 2025 12:18:28 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04A313538
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221905; cv=none; b=GuYozJHnynRXVJQ3uPRB+SuTN9276h9S/gZbT+7Zb/59Goam4/RgjQmj+bJ7Y3Iik+MmmgpGkcozcRjaGToGZZAKTXNbzN3v4d2HCjEDm01WSJ1Uf/IZ4DRWYfCP/C8kRDyNgpDh5erT/CmSS6vp0pna26M0iGg5VdWkWa3HAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221905; c=relaxed/simple;
	bh=6UnI/G5uFXvZM3QYOrlOsy8lHW3iy4QXrl32Cyvdw+A=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfg68v+tDk2LAm6dn3RzQJqSG2sgwlqOJj51BmC9MQlb3LKGm4L71AUb2owleaguxbk5oF3aIcA/47dOLV+Fc/nu6EcDh5H29U8L9Yo7AE1glVxshoYZAKAwhe4omotpOA9XAwQ8CZEIlPxhzhryKbaXb8c15kFZTmnatzKTW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=esmil.dk; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=esmil.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63cf0df1abbso793553d50.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221898; x=1761826698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4fF/fwVg7UrUpgvaNoDLtEEeEL936gX4ttsHTSYttVM=;
        b=JufaDkB4VxO4Ti27vOjJCQHYzq9beWjA0PrWS72/H+zWMBNveQPnHSDo/awV/lkQnp
         To5SuqstQHNAwj19Zdq9c8SBPlKB3j2Pz434Cbfs4SwT/nYTXBi0eGWI0kh1EjJv6Npq
         X6oNyc9pU00qSJHiuLN1vtsC/3g0IRGSwpTMMTV4lg59Bk7UV4E4mW3fba5PAhep+vqH
         LMii68RQZmuDoAuEFPnJLTE2m7wWgmEoosbsHgOczD9lB1jvtjtk+tU77ELYbwgwI/eL
         A14cbSZQtHlLmUlWBzfMJ3DDD5CsLUCByIc2fnF8WWRPIEDPazoQ2KcX6VoBVh4L9kM1
         xSrw==
X-Forwarded-Encrypted: i=1; AJvYcCW+WOtbmo4bm3lajszCG8ANKvcQp/5YAwGr7yhjgtcQxW74yzl/0YoExE+Xm/DZ84w3fU2IFxt44Magn5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKLVKlR8vJ7dKH0qXxj+okBjaJ5Z1pvP7pN8KUzCOm/2ioKUm
	O5P9MQ8AYxkNRJLl4ofeFyqePui57lo+qolGk/P3jM8HZga3N3/I8st7zgBNVT/ZQgbIasof4p5
	mhkN/WvTb/4BLKkXLyV+d4C0TadcEPZAigw==
X-Gm-Gg: ASbGnctvwzBRBctw48xdfzCbTkvvMBK0j2WuLt9slAZmQ1iKUsfZBJQ7evAkcKNhoZU
	oSTa2N4EM/j7bIDRhpfb9/a8Gex7xnBJpOEYSImzcWG1G0U6NjDky1UYP/fstpJ9ghRniUVsuGN
	ibzMV1e04/gD73ok6jk5tT/1TZ53ydTq0CALtJDwRQb9pbiCdhWTBZMpbIvKp4yYfCGQworXVQz
	ah4GV2Wyhu/zsSSrdlQ6LdqGRdI6vsWM8EF3Cs1/r8rHcVIr815tqxurEHbNLZLIlSb2g==
X-Google-Smtp-Source: AGHT+IEC3QHhYBZSQQPhFBXYj6WYUOW1grD9uZTJNUw3bPCmSjtWE4zRxeVpvsKcNBIq63CnLwvpseCqNRb/wfa8wBw=
X-Received: by 2002:a05:690e:1502:b0:62f:c634:4b3f with SMTP id
 956f58d0204a3-63f377cd99amr1469290d50.7.1761221898433; Thu, 23 Oct 2025
 05:18:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Oct 2025 05:18:16 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Oct 2025 05:18:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mc9e4P9vCt79yR1Jt5_2wxUngqAR_m1AxG=nbz=Cr3BjQ@mail.gmail.com>
References: <20251021181631.25442-1-alitariq45892@gmail.com> <CAMRc=Mc9e4P9vCt79yR1Jt5_2wxUngqAR_m1AxG=nbz=Cr3BjQ@mail.gmail.com>
From: Emil Renner Berthing <kernel@esmil.dk>
User-Agent: alot/0.0.0
Date: Thu, 23 Oct 2025 05:18:16 -0700
X-Gm-Features: AS18NWC-riM2AFKbkUWAzUi3IEgdY1Ce6EbhwvllAw7hGVDS1TddtOVJTTQLTxk
Message-ID: <CANBLGcygpsp=R5gM7NeuVO-JG1yfQJ_0dhnFfL1ud=291cJZAQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: starfive: use dynamic GPIO base allocation
To: Ali Tariq <alitariq45892@gmail.com>, Hal Feng <hal.feng@starfivetech.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ali,

Quoting Bartosz Golaszewski (2025-10-22 09:23:37)
> On Tue, Oct 21, 2025 at 8:17=E2=80=AFPM Ali Tariq <alitariq45892@gmail.co=
m> wrote:
> >
> > The JH7110 pinctrl driver currently sets a static GPIO base number from
> > platform data:
> >
> >   sfp->gc.base =3D info->gc_base;
> >
> > Static base assignment is deprecated and results in the following warni=
ng:
> >
> >   gpio gpiochip0: Static allocation of GPIO base is deprecated,
> >   use dynamic allocation.
> >
> > Set `sfp->gc.base =3D -1` to let the GPIO core dynamically allocate
> > the base number. This removes the warning and aligns the driver
> > with current GPIO guidelines.
> >
> > Tested on VisionFive 2 (JH7110 SoC).
> >
> > Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
> > ---
> >  drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drive=
rs/pinctrl/starfive/pinctrl-starfive-jh7110.c
> > index 05e3af75b09f..eb5cf8c067d1 100644
> > --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> > +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> > @@ -938,7 +938,7 @@ int jh7110_pinctrl_probe(struct platform_device *pd=
ev)
> >         sfp->gc.set =3D jh7110_gpio_set;
> >         sfp->gc.set_config =3D jh7110_gpio_set_config;
> >         sfp->gc.add_pin_ranges =3D jh7110_gpio_add_pin_ranges;
> > -       sfp->gc.base =3D info->gc_base;
> > +       sfp->gc.base =3D -1;
> >         sfp->gc.ngpio =3D info->ngpios;
> >
> >         jh7110_irq_chip.name =3D sfp->gc.label;
> > --
> > 2.43.0
> >
> >
>
> That's a NACK until you also remove JH7110_AON_GC_BASE and
> JH7110_SYS_GC_BASE assignments after explaining why they are no longer
> needed.

Thanks for your patch, cleaning this up. As Bartosz said you'd want to clea=
n up
the now unused defines and the gc_base member of struct jh7110_pinctrl_soc_=
info
too though.

As for why this is no longer needed, I don't think it was ever needed. It j=
ust
slipped through review unfortunately. Hal should be able to explain why if
that's not the case.

/Emil

