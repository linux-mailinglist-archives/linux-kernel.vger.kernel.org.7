Return-Path: <linux-kernel+bounces-842091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A355FBB8EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF85189F454
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A96D21A453;
	Sat,  4 Oct 2025 14:33:23 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052C21257E
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588402; cv=none; b=a9w7CZp4OXbet6goXBx0Inlo/WQJHTRzQ5Fv+Z4ezDUyCNMSXE+oTG7u/oovNZex8NuSNIYlWgqLsdnZAW6R4/pToksBZdOxovYVq3dxGgADM44U9SR+2VIurcAUYkZtl/YkrtdORwflICG6427dJuM+WaXYvwcBsFx+5WTDfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588402; c=relaxed/simple;
	bh=0J55Y2HmqgcnbS+RXB3tiJFIIySx+Rr5EZpIa0gAB24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmvbKAEbvPVtbcAagXJrL0avW++2IqOh0jWfSxnubyMDfQclmEaf/D9xv8I7sOE5Nblzitk1R8PMTpqSmOQEvMHsgo7yg9awVQs9uZBPap/Jv20EWdaedapE9axMwfqQWw0Y1fZjDFQmCuUeuLAuGv9rcwbC94DrprQopfMVd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8e30a19da78so1963336241.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 07:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588399; x=1760193199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xthzmHjkhKJUrri8Wf1E3AifPP/ZxbkaJDpboT1dzM4=;
        b=ejqQVc9Dilg3kI9QtaodVajn3zJZ6pXIHu89GcPL7ZGTD0vYEpUkSqpGu3gw5yuxQG
         pSlwbJtUqtuiYoJqR6pRGuPbmz1+YBY5CjOhB37yZpyQjH84fRiAjIjBeyyXja6qJaQt
         gxvwyOA1rAzgtRDROL66J57zlM432Ft6LczZlGSBdmTBfFWRYSOerScRKylHsN6c4ZJG
         wgo9QFbbfKYg2SWYJdTyi2E3/WtbAMHO0OfF/rNpkDmBgq9Z9vK1JhrurFHHA8ecJZ/i
         6PfMwBIyKgliO4Hf+OfZU4CbJpngZ1sWiE1HgYY3dZaB3Ov2Qf3+uUbmNOdVvbHkEAIH
         943w==
X-Forwarded-Encrypted: i=1; AJvYcCVmPjRuGa5eW4eKOdyZgRw4HE/AHzyPg0rrUYYHc4gNMMemdc/XAPSGyxWjD228Sdws3f23yCUprxlDccI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0XNovdGo2mGrawtOj87fcaHlWSsFrmx/C5VI1ERuwvGoiSy5o
	5LL2vCO4WI5kBl1W0DC46mYgcjXzI6GHYNdm6RHiE5hJlVDvklaEwnsJTaoFQCO7
X-Gm-Gg: ASbGncskzOaRTFtSPQHZul3WUUGAFh3wHthvE3PCs3zDvVL+jAZliBLDtFFUz2hZ8kM
	Wj/pOO8GsHJVWRYW8yJTNeMYYu8OCsvbXcFoII8vLz7nP3vLvxh+XNKkG5yDhcei1HNFh/H18oE
	f0aMklEhccLGFHj6Xk1UZcfD8hhBHLDrAlfGpN9o7DY5fuE5+HB2r7LWBPqhhtLSULV1OphdQQR
	pt7kpxk15hAKemdvIr7eRuiAgHfHLE1Z+zet1Ia25amknoEq2zDcG8FjbcFsKXP8GRXUQX+OS+e
	Robq8lQVpqNSzmqrXdur+d/ZE4F2+uS+bzgtlAvvwPytMzyI+gR2mEGEowvinNdX0DiEMKzDCHI
	2LzSJQtvj1x3R3lgpKZJpaQIH4LK//MZT60R8bOBYURtOMfKuIgxUKszZPh/KkBtew+DTfxaAww
	xb0IOKOaEpoTmF94TbEOY=
X-Google-Smtp-Source: AGHT+IHYMefI53gjjNbGRcj+Rm/2L5FtMUSuZ6hibGJI9vsNUiVh3gNpzYDiNlrlwxWsrUCRC5tG8g==
X-Received: by 2002:a05:6122:3c50:b0:543:8c04:43f4 with SMTP id 71dfb90a1353d-5524ea6ea23mr2817158e0c.14.1759588398639;
        Sat, 04 Oct 2025 07:33:18 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf63c6asm1865054e0c.19.2025.10.04.07.33.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 07:33:17 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso3560544137.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 07:33:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5vgbY0X6yDJajBV0DDSq48J7kmR/pRWAYVLRYOlOB3HePObxArC4eQVJPHqxAwmv+Mda4bq4bjssMwtQ=@vger.kernel.org
X-Received: by 2002:a05:6102:291f:b0:5a2:668d:f20b with SMTP id
 ada2fe7eead31-5d41d0dd17bmr3054407137.16.1759588396956; Sat, 04 Oct 2025
 07:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251001122326.4024391-4-cosmin-gabriel.tanislav.xa@renesas.com> <20251004143901.505ec386@jic23-huawei>
In-Reply-To: <20251004143901.505ec386@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 4 Oct 2025 16:33:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+V60pZSRmu6SjeBNyi_0+Un5pXjWDLDDBt6UbYfTmeQ@mail.gmail.com>
X-Gm-Features: AS18NWBkap4dmgI1LydXdtTPg0XGaFgAjq5oqq5cMsJWqAup1M73smsgPeqmT7I
Message-ID: <CAMuHMdV+V60pZSRmu6SjeBNyi_0+Un5pXjWDLDDBt6UbYfTmeQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] iio: adc: add RZ/T2H / RZ/N2H ADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Oct 2025 at 15:39, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  1 Oct 2025 15:23:10 +0300
> Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
>
> > Add support for the A/D 12-Bit successive approximation converters foun=
d
> > in the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
> >
> > RZ/T2H has two ADCs with 4 channels and one with 6.
> > RZ/N2H has two ADCs with 4 channels and one with 15.
> >
> > Conversions can be performed in single or continuous mode. Result of th=
e
> > conversion is stored in a 16-bit data register corresponding to each
> > channel.
> >
> > The conversions can be started by a software trigger, a synchronous
> > trigger (from MTU or from ELC) or an asynchronous external trigger (fro=
m
> > ADTRGn# pin).
> >
> > Only single mode with software trigger is supported for now.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Hi Cosmin
>
> A few really minor comments.
>
> I might have ignored these or tweaked whilst applying but looks
> like you'll probably be doing a v4 anyway so I thought I'd mention them.
>
> Thanks,
>
> Jonathan
>
>
> > diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> > new file mode 100644
> > index 000000000000..51d1852d814d
> > --- /dev/null
> > +++ b/drivers/iio/adc/rzt2h_adc.c
> > @@ -0,0 +1,309 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/adc-helpers.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> > +
> > +#define RZT2H_NAME                   "rzt2h-adc"
>
> I'm not a huge fan of defines like this as there is no inherent reason th=
e two
> places it is used should take the same value. If you feel it's really jus=
tified
> then I don't mind too much though.

I am not a fan either, as using a define in the initialization of
platform_driver.driver.name means I have to do another grep to
find the actual name.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

