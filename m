Return-Path: <linux-kernel+bounces-843189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16061BBE98B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE78189136E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E22D94B3;
	Mon,  6 Oct 2025 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpoG0qEY"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5771F8728
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767030; cv=none; b=ovnEpObs91fwa4p7cOF801/TTY5MoAXXYeFWiwJ+WJ6nMNniXtx1I5wdhWzaq/7XlJpLCa6H/PFEXJ1CRtTBOrv7HzJ2xTkCnVIerG/lU5zv4ZP474CjVJRI73HW4eGbcGT/2/6jFTfoJ2/PqftducB25K+BfgVyD/QlDvu2Bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767030; c=relaxed/simple;
	bh=ePa97dm3NcqZXftvfOWv2RSckfY9XMYCyQtd6xGsmCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xt0QMq95MQ0hSzZ2nJZkN7TdHJTFPy5H5teexOcYTJi7s92Ua/sr+OjbMUJO2wjxvCD+2m224SOi1cokyzCHxeIwNtHOTABdbE70qiGUEJaiittoweWuwgj4pd9pjZ+vIO7rUduUwkwvWNt7RJsTLkAEvpKAs1mUXcYV9K/L+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpoG0qEY; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5a265e0ec25so4024842137.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759767027; x=1760371827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sns+z5Mv33hVtLxV8rlbvAVv+VeJiohyhxaGcNY7H14=;
        b=WpoG0qEYC991WYLRwgiEEyK/jdfjXCDLT4S+UfrTHB1FDeszM3FdKsXREyxY8RbZxy
         FpSWEU18pe5Uxsg4H0vVuseJOWWomWEe41Z5BA0YUAxMQzgW6y8PyCpdscjI7DXdhFiy
         Fsz7gPU8/m++OTIx+b/LtLKW40qq0NwAGO8+hiuHDZUNnLhSPR00W1PwKKqq59f7OXKt
         zAUsiro0ScwF9/i3qfEZCRBx03DMXCTpKFGyBQsBIIUwZluvHqhKnYAXLuCkUUtet3oE
         YbKDCFKIGqH6pfveWIVs/iuDrcaEOrFQPP5E9dihNRg1ASAMTm1H0NRxafJ7/84a0NAm
         OqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767027; x=1760371827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sns+z5Mv33hVtLxV8rlbvAVv+VeJiohyhxaGcNY7H14=;
        b=A7QDHQemaR3oHP4XXuWppbdebyFiZQrKXlPO6QPfoxUeD4QK+fnL5GWe91WLATu+QM
         RrAdrVaPvHM0W7VcY3900vWTwQ/2xcvfGKGlSeXDAazrsZCAQjGGMNag+0k6Rl5lTpRq
         a41WkifdrHNuKacB2cycvQElmG1CbLxqFi+lGe2eFf+mlDISL8UWYcFvyjpm0z1h5Nw5
         3B4L+n4Qo0OqUlepDfOBDx+EtyXDCrHKWWEV0gNmQCiWN7BtObWV1KBh8BbGjoaSXQ8p
         2Gcgp2twvwHxW5GjOfEOGOatr/Q1FbLqEvVCpciNx8kr59q2IJHxropjlC8hkCjqF3k6
         BgMw==
X-Forwarded-Encrypted: i=1; AJvYcCWrhNQcmIxz491KXCHtR9sfxAHt5GVSctZF5f0gDuyrOc6M0w6Tabja86hsY+aVR1OGV0v748dHdxaGI1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3QwAmLFDvCaquhKxvHHDLOejVwguLQIIW4d2/WztQduQ4jEgo
	X1Ru84RiMyDNNQegzjBea6Z+6LOFhoRUImTkD12XWcwhE+xZDLRl8riNsXn4pkCESdIsonOFitI
	ZIaQAqWWmvM3WUKk8ual7reiTKHzgFcw=
X-Gm-Gg: ASbGnctqXYL3AAOvxMyX6hIq5lCFvrmzvXhNPl6u5tfxk0+MyM7HV+PxbwDfB0T89+1
	Gd5YoOi3hi1R+SDuhl/iXwG+CMjQWrn86bYsVVW+HQ/xDB+BDkpK7HZkR9+nFEGc+sFB6rpj1WG
	YGV314rErcUxKmJ1PyaFP3A3ttKbFY2i/6FQWYkac/igGs5DxefGxC0YwlULnlDE8JU36s7PNHP
	rUG06Snr25v5y02wCvPbSkm9TiImTyWuxyUvGTdSQ==
X-Google-Smtp-Source: AGHT+IGx2FWJKb95FW2SfxczsReiCSn/kQDzAgvpgQVCOUkA5uaUj6QL1gZm/DDn/MBdaheqD1T6ycaBXstgwm/g/6M=
X-Received: by 2002:a05:6102:1613:b0:533:ff66:696d with SMTP id
 ada2fe7eead31-5d41d0fd7efmr5390644137.23.1759767027433; Mon, 06 Oct 2025
 09:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005173812.1169436-1-rampxxxx@gmail.com> <ewca4jzmahwdl47rbojxtynbizu2vuompjxrprsz7aelovnvao@kzpxjjbjj6px>
In-Reply-To: <ewca4jzmahwdl47rbojxtynbizu2vuompjxrprsz7aelovnvao@kzpxjjbjj6px>
From: Javier Garcia <rampxxxx@gmail.com>
Date: Mon, 6 Oct 2025 18:10:16 +0200
X-Gm-Features: AS18NWB4fZelcAzqnM_-bbbpZoWXlfxaoLs_XEpCmyOIHmZJDiAtcegNgh2-OWk
Message-ID: <CABPJ0vjtr2e=PMPF7AAi-Q=CrwgdHoO6HDb+G8PWF8T6b2_6Vw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, 6 Oct 2025 at 10:07, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Sun, Oct 05, 2025 at 07:38:12PM +0200, Javier Garcia wrote:
> > This patch wraps the relevant code blocks with #ifdef CONFIG_FB_DEVICE,
> > allowing the driver to be built and used even if CONFIG_FB_DEVICE is no=
t selected.
> >
> > The sysfs only give access to show some controller and cursor registers=
 so
> > it's not needed to allow driver works correctly.
> >
> > Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
>
> I don't understand this patch. CONFIG_FB_DEVICE is about legacy /dev/fb*
> stuff, and this patch make the creation of a sysfs file dependent on
> that.

This is part of the TODO
https://www.kernel.org/doc/html/latest/gpu/todo.html#remove-driver-dependen=
cies-on-fb-device

I think the idea is to make the driver independent of CONFIG_FB_DEVICE .

>
> > diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video=
/fbdev/mb862xx/mb862xxfbdrv.c
> > index ade88e7bc760..a691a5fefb25 100644
> > --- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> > +++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> > @@ -530,6 +530,7 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fb=
i)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_FB_DEVICE
> >  /*
> >   * show some display controller and cursor registers
> >   */
> > @@ -569,6 +570,7 @@ static ssize_t dispregs_show(struct device *dev,
> >  }
> >
> >  static DEVICE_ATTR_RO(dispregs);
> > +#endif
> >
> >  static irqreturn_t mb862xx_intr(int irq, void *dev_id)
> >  {
> > @@ -759,9 +761,11 @@ static int of_platform_mb862xx_probe(struct platfo=
rm_device *ofdev)
> >
> >       dev_set_drvdata(dev, info);
> >
> > +#ifdef CONFIG_FB_DEVICE
> >       if (device_create_file(dev, &dev_attr_dispregs))
> >               dev_err(dev, "Can't create sysfs regdump file\n");
> >       return 0;
> > +#endif
>
> That looks wrong. Without CONFIG_FB_DEVICE set the success return is
> removed and all resources are freed essentially making the
> CONFIG_FB_MB862XX_LIME part of the driver unusable.

Thanks, I'll fix that.

And add your suggestion instead of the `ifdef`.

>
> >  rel_cmap:
> >       fb_dealloc_cmap(&info->cmap);
> > @@ -801,7 +805,9 @@ static void of_platform_mb862xx_remove(struct platf=
orm_device *ofdev)
> >       free_irq(par->irq, (void *)par);
> >       irq_dispose_mapping(par->irq);
> >
> > +#ifdef CONFIG_FB_DEVICE
> >       device_remove_file(&ofdev->dev, &dev_attr_dispregs);
> > +#endif
> >
> >       unregister_framebuffer(fbi);
> >       fb_dealloc_cmap(&fbi->cmap);
> > @@ -1101,8 +1107,10 @@ static int mb862xx_pci_probe(struct pci_dev *pde=
v,
> >
> >       pci_set_drvdata(pdev, info);
> >
> > +#ifdef CONFIG_FB_DEVICE
> >       if (device_create_file(dev, &dev_attr_dispregs))
> >               dev_err(dev, "Can't create sysfs regdump file\n");
> > +#endif
> >
> >       if (par->type =3D=3D BT_CARMINE)
> >               outreg(ctrl, GC_CTRL_INT_MASK, GC_CARMINE_INT_EN);
> > @@ -1151,7 +1159,9 @@ static void mb862xx_pci_remove(struct pci_dev *pd=
ev)
> >
> >       mb862xx_i2c_exit(par);
> >
> > +#ifdef CONFIG_FB_DEVICE
> >       device_remove_file(&pdev->dev, &dev_attr_dispregs);
> > +#endif
> >
> >       unregister_framebuffer(fbi);
> >       fb_dealloc_cmap(&fbi->cmap);
>
> The amount of ifdefs could be greatly reduced using the following patch:
>
> diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/f=
bdev/mb862xx/mb862xxfbdrv.c
> index a691a5fefb25..3f79dfc27a53 100644
> --- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> @@ -530,7 +530,6 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
>         return 0;
>  }
>
> -#ifdef CONFIG_FB_DEVICE
>  /*
>   * show some display controller and cursor registers
>   */
> @@ -570,7 +569,6 @@ static ssize_t dispregs_show(struct device *dev,
>  }
>
>  static DEVICE_ATTR_RO(dispregs);
> -#endif
>
>  static irqreturn_t mb862xx_intr(int irq, void *dev_id)
>  {
> @@ -761,11 +759,9 @@ static int of_platform_mb862xx_probe(struct platform=
_device *ofdev)
>
>         dev_set_drvdata(dev, info);
>
> -#ifdef CONFIG_FB_DEVICE
> -       if (device_create_file(dev, &dev_attr_dispregs))
> +       if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_=
attr_dispregs))
>                 dev_err(dev, "Can't create sysfs regdump file\n");
>         return 0;
> -#endif
>
>  rel_cmap:
>         fb_dealloc_cmap(&info->cmap);
> @@ -805,9 +801,8 @@ static void of_platform_mb862xx_remove(struct platfor=
m_device *ofdev)
>         free_irq(par->irq, (void *)par);
>         irq_dispose_mapping(par->irq);
>
> -#ifdef CONFIG_FB_DEVICE
> -       device_remove_file(&ofdev->dev, &dev_attr_dispregs);
> -#endif
> +       if (IS_ENABLED(CONFIG_FB_DEVICE))
> +               device_remove_file(&ofdev->dev, &dev_attr_dispregs);
>
>         unregister_framebuffer(fbi);
>         fb_dealloc_cmap(&fbi->cmap);
> @@ -1107,10 +1102,8 @@ static int mb862xx_pci_probe(struct pci_dev *pdev,
>
>         pci_set_drvdata(pdev, info);
>
> -#ifdef CONFIG_FB_DEVICE
> -       if (device_create_file(dev, &dev_attr_dispregs))
> +       if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_=
attr_dispregs))
>                 dev_err(dev, "Can't create sysfs regdump file\n");
> -#endif
>
>         if (par->type =3D=3D BT_CARMINE)
>                 outreg(ctrl, GC_CTRL_INT_MASK, GC_CARMINE_INT_EN);
> @@ -1159,9 +1152,8 @@ static void mb862xx_pci_remove(struct pci_dev *pdev=
)
>
>         mb862xx_i2c_exit(par);
>
> -#ifdef CONFIG_FB_DEVICE
> -       device_remove_file(&pdev->dev, &dev_attr_dispregs);
> -#endif
> +       if (IS_ENABLED(CONFIG_FB_DEVICE))
> +               device_remove_file(&pdev->dev, &dev_attr_dispregs);
>
>         unregister_framebuffer(fbi);
>         fb_dealloc_cmap(&fbi->cmap);
>
> (It would still be questionable however to make the device file creation
> dependent on FB_DEVICE.)

https://www.kernel.org/doc/html/latest/gpu/todo.html#remove-driver-dependen=
cies-on-fb-device

>
> Best regards
> Uwe

