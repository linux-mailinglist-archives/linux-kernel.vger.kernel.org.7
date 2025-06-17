Return-Path: <linux-kernel+bounces-690555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1489ADD4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A921A169DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD12EA166;
	Tue, 17 Jun 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="GHJxQwWa"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CD2DFF05
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176042; cv=none; b=efyks85O0yn1asXCg/1Jdf6dLrtY1xcPq13yVvWCrZOX/Hhdu9z26a7ls+K0VJUjqhs7toKYROzwlW5LCEQq02jFRWV15mjT5JSnU7WbrRIALFjtHNLJ8/qUfDOxtSGzrfYU5xQuPtuZFkyth8avRXDisdW+o4HUskIkf16v/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176042; c=relaxed/simple;
	bh=W7JBzyGEiWyG3iUqFnqbYQxPWXtvewFS5AESFU3ByKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmeQVO9SsAaWTytZj8wm8xHSb9bY0RyO+5N0pyd65t5A6rlGiDMSAiN4Toubmw/ktEfzSsXdkUKgu5xJoLGsw8PBYX7aEKwrbBVPP92bf2T5NOhu1dCtzub0wa4KCTHa0LONtNROHvafiPjazlnoD1sqaumyEwEvByJIsiILaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=GHJxQwWa; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553cf020383so625369e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1750176038; x=1750780838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5/cGEPVbEhGxogRtbymQogrM8PjeXwlGoZ+poOqYtw=;
        b=GHJxQwWaHO7ao9PkfJS/Y1JJoepAaUnCJ4H6H7dMQfz1l0e5mxD4iGz3+l9bP016FQ
         PRk784YkkmUYNPVkYHuRfD+jMvFbKwMHjDo5hZiEmXfqnXUgGzMaRRvGlPURgyc0RM3Z
         ry53Bug6Rxp2CkOLtCt9rtdWRIF1X7jJfOj5ujarf5aKo/K5X+Fbes30a6nNrTvXPLHw
         iZ0O9P3Q6a48QPiuhPh9QJbYnt9q9Et2+Z1kWCsxr4p/Lm2rQWXxQ0oBuRZBWyULAHvX
         nRW07HYBB8T5sdV75Sq0M1YJnhmXMSH3DWG9186VAywuBGOnXbkC4kcEfiR+lv2KHNel
         Gs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176038; x=1750780838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5/cGEPVbEhGxogRtbymQogrM8PjeXwlGoZ+poOqYtw=;
        b=vDqOv5iRKi4TvsC5x84CuV6+fjBkstkuZHRQijxFCVwsB4acF5HoKeY496y1/NPW+E
         t7J1zq8Q1jDObgrYkJVoxXC6XRBq49H1NpIaYfgYRZdlzbXXHnx6gChpcccash40XUuM
         +lTbPIzhSY2qHzz5ccNqqbjA5ApjrfWDI2tY+8/oJQ4eCh0Lut6Ig+cxThTaoF3KSWZa
         WwFE+VneDZEgY8JG9eD5ZULjvL23wUP1WiwRz02hBAavvbQ63h7N95pK/H/x8CuLYVT3
         7cqdxzL+kmJN0sGSaViv8W579FoxF1pazG0nidEwV1z+cbG30Jxt7xl6Vhp369AxLXrH
         Losw==
X-Forwarded-Encrypted: i=1; AJvYcCWg+hEArHWyA6+RQ99yKILK3+tONCvI1+PXsNdF8ZaDAb/mns0Pz0xORiYCFhLKAp4+XydvvuXBi+yRhkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwepAbLMSW6gf0WkxI6cZmatf8x3FGDIxx/fjxKdxZFa/B9oytu
	HoGwZch3k2C4jzrtfJwYxhd+cOvnemUGHyHYuTd1vfhCjwnV6KFeO5RySqmWAOpYV6wxRCTbumu
	Dz4MmwIvG5Kus+1XWSrumvFTdi2lAKB9yovxrIM82
X-Gm-Gg: ASbGncsksUxRnatOpMT7fQa5B+v8KkA3IYljCQPHcLVTLmscFKbAZZq85WOdhQeYthj
	x+nGrmpmOK76p5ztkJOu9t4XVq6eFGQax4KaRp7JNy8LfgrJZPF4BnkVpGIXpAX3czZyWmmbwhz
	puTjZVEttXNsUqw5rjMcBAXOCrEbJ0ffFqGiBMzRm0NA==
X-Google-Smtp-Source: AGHT+IFU6tCYFX6rLeU4r4jG0o0LNAOKh0+H2zldYWfLL3X1Bkf7DM2a/8Myo0nP66Ti4vOwJ0PRhThhpF6KiIE+j4Y=
X-Received: by 2002:a05:6512:118e:b0:553:65bc:4232 with SMTP id
 2adb3069b0e04-553b6f0adb5mr3806046e87.31.1750176038169; Tue, 17 Jun 2025
 09:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-linux-stable-tps6594-pwrbutton-v1-0-0cc5c6e0415c@criticallink.com>
 <20250520-linux-stable-tps6594-pwrbutton-v1-3-0cc5c6e0415c@criticallink.com> <20250613141105.GG897353@google.com>
In-Reply-To: <20250613141105.GG897353@google.com>
From: Job Sava <jsava@criticallink.com>
Date: Tue, 17 Jun 2025 12:00:27 -0400
X-Gm-Features: Ac12FXwfPKT9YJfCDfUDOTDxW57qAjgmoI3NzvLaV0dDRdDqEIP6JAr4MAEbwyU
Message-ID: <CAKMwjwT-74=QRqH_ML9PMe6Bfq8WCJgxoYBjFFegH8EvGMamQA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mfd: tps6594: Adds support for powering off the PMIC
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Julien Panis <jpanis@baylibre.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	jcormier@criticallink.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:11=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 20 May 2025, Job Sava wrote:
>
> > When the FSM_I2C_TRIGGER register's bit 0 is set it triggers TRIGGER_I2=
C_0
> > and the PMIC is transitioned to the STANDBY state
> > (table 6-18: SLVSGG7 =E2=80=93 DECEMBER 2023).
> >
> > An ON request is required to transition from STANDBY to ACTIVE.
> >
> > Signed-off-by: Job Sava <jsava@criticallink.com>
> > ---
> >  drivers/mfd/tps6594-core.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
> > index 1b0b3d1bf6c4..f4c434c0d87a 100644
> > --- a/drivers/mfd/tps6594-core.c
> > +++ b/drivers/mfd/tps6594-core.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/reboot.h>
> >
> >  #include <linux/mfd/core.h>
> >  #include <linux/mfd/tps6594.h>
> > @@ -615,6 +616,19 @@ static int tps6594_enable_crc(struct tps6594 *tps)
> >       return ret;
> >  }
> >
> > +static int tps6594_soft_shutdown(struct tps6594 *tps)
>
> Why do you have a whole separate function that itself is only called
> once and only conducts a single one call to one other function?

I copied this code from the tps65219 pmic driver, which setup the
functions in this way. I will merge the two functions.

>
> > +{
> > +     return regmap_update_bits(tps->regmap, TPS6594_REG_FSM_I2C_TRIGGE=
RS,
> > +                             TPS6594_BIT_TRIGGER_I2C(0),
> > +                             TPS6594_BIT_TRIGGER_I2C(0));
> > +}
> > +
> > +static int tps6594_power_off_handler(struct sys_off_data *data)
> > +{
> > +     tps6594_soft_shutdown(data->cb_data);
> > +     return NOTIFY_DONE;
> > +}
> > +
> >  int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
> >  {
> >       struct device *dev =3D tps->dev;
> > @@ -623,6 +637,7 @@ int tps6594_device_init(struct tps6594 *tps, bool e=
nable_crc)
> >       const struct mfd_cell *cells;
> >       int n_cells;
> >       bool pwr_button;
> > +     bool system_power_controller;
> >
> >       if (enable_crc) {
> >               ret =3D tps6594_enable_crc(tps);
> > @@ -681,6 +696,15 @@ int tps6594_device_init(struct tps6594 *tps, bool =
enable_crc)
> >                       return dev_err_probe(dev, ret, "Failed to add RTC=
 child device\n");
> >       }
> >
> > +     system_power_controller =3D of_property_read_bool(dev->of_node, "=
system-power-controller");
> > +     if (system_power_controller) {
> > +             ret =3D devm_register_power_off_handler(tps->dev,
> > +                                                             tps6594_p=
ower_off_handler,
> > +                                                             tps);
>
> This alignment is odd.

Will have this fixed for the next patch.

>
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret, "Failed to registe=
r power-off handler\n");
> > +     }
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(tps6594_device_init);
> >
> > --
> > 2.43.0
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

Thank you
-Job

