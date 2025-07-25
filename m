Return-Path: <linux-kernel+bounces-746391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48522B12619
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65E04E7DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6125DB13;
	Fri, 25 Jul 2025 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X8EY3ae8"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01A20487E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753478260; cv=none; b=p/vpCR64uov4CQEzbKVHFBdN0DFdOqoTpKy4HzhjPkFe1nfQ4dBk8ala382YqmS/As+ZIbKpGEwA/Ou4WgK6SqWjdqYxG2niDFobnpvM4r5a1C9AVLybinFLK64ihsYu9GrwPwvjPjCjRFWw42niisJb99lXLrYcRMPyhlCjNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753478260; c=relaxed/simple;
	bh=uXxw+R+ilKGWicH2CC2/+5/2TTT9NhJPrj/PQUPiaXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwfaaHLrckmeTrI6h7jn+ZGAhg0lrz2iGUWjFmHkCmgg5AoDtE3KYCcolxvAx4GQ4uZoYk8hYKKDRBEy0ghx3lfDEPF83tI82+qHRl13yhSMAf1BenWivgZWuLZF1pvhJPK6S4H6FI5EXqD0oI9TNazwwAga/Z4BvxxJN2SUwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X8EY3ae8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1936751a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753478255; x=1754083055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT9DhCI4omelHQCSbq0zx+balg3BlkNvSkZNZzTd3hw=;
        b=X8EY3ae84UfASu6y/3Ca5/w/p2kfxE6f/Y6YN9bLzIx3ttFednXSmIlnS6Php10cB1
         pFr/Q1xaNUCyF6qruIPsJ01DLn1qGptUTP5jdoL94I2sFBjBPdIIxbvHfyNicP7c4bEm
         2YGmiFRiMnJiw+IYV2ova4KTLOEvGCd74jwNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753478255; x=1754083055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT9DhCI4omelHQCSbq0zx+balg3BlkNvSkZNZzTd3hw=;
        b=LRBZyzKsqL5XuNZhgAAnoYG83V7cK8WG8cb9hZ7JoYg/7Idao9kLRY00EVPPAHSXo5
         BP+jDo27Uutfs0TqM6wBX3r+jnhpINtn5N4UzOcXG/1jgFw5sH3WiPSSs9PKmfsXzQiQ
         CkhW+4eeEC2zyfX4ELHTQHUwRc1HtJomQTRDtbJewRBtQ1MMsuGngpJzrF0w2FIehddk
         m06O6uSr46BiMhqHYOoB1mt3hkXuMjLyQ//ZDrH4DMizNhJjjNR8lQU8WIBENslvicHL
         fS5zmryxFpGEQDmkM6i53YZzBilPCR8lC2UYQ8Pa1LIyi4CqLOkanyax51NaMEcvNxoU
         6z4g==
X-Forwarded-Encrypted: i=1; AJvYcCU1kFZvDStYCNkimKADjtqw3KCWOTFJn1/mKWK0eQJ41mLs4vriIV40SY39d8Rz5EqUVvu2hBNhay4xJfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIuyLYN58eBLbfgrvV0PrAhN88yohO1qqcdUWYochRPd4jm4L
	7AU2voZAl1uJi18elrS3/C//tysSCVs4bGxK5P0j+5rmwl4wnIsjKctvGY8jXJZulHrgDpsTNL7
	AcMU=
X-Gm-Gg: ASbGnctIN16fktRM+GSQ6PFMVifIyhCkdfgScauj2jP511ygtyYvE1HneXdWcq1Ga5L
	WgwY7ZMm/W329DqPcb2kJH3wc3ZxHoEY9XmeREw4GGvAKT/3JkXvXm00otnqa8tcWmJb7nwX3at
	O79QsY/WpmkpUGS3TaZ79iELaQ7PnwL97LGVAEVIr8PSqr8VJbbg14ammg1kjjXlhEVx5F4eeXs
	cLe9MMJgnNFWdPTa8GONSX3+/S+36m8uZgy0ScKpu01yd8YObTD1a0XsWYvbF0TG+i9cQzYSDwK
	dN/borxrXBzERvJdLSMtcuh147/RI36dRk0sLMStHKLj2nHUhqSHrU5lNgo+qb1vIVdz+LL8bDP
	E5ke1D2uyOfo8J4oC/47xtVHQ2vJsJVaSkDGDsWtjV4uOKBw1/qCv3jtANP6K4Flgpw==
X-Google-Smtp-Source: AGHT+IHkZ0192DyJLxLoprlnJ4WYTPd3DiskAbGzYvlsfC/nJYLKTL5nNRYuxqszIFOoRtMZs2Wxpw==
X-Received: by 2002:a05:6a20:7f93:b0:239:23ef:41bc with SMTP id adf61e73a8af0-23d70216ff1mr5193883637.41.1753478255256;
        Fri, 25 Jul 2025 14:17:35 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408cf7460sm442757b3a.54.2025.07.25.14.17.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 14:17:33 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1955301a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:17:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwdzo1OQVs3JXmKtiturJYKH2vN4MugJtP31nEQ/v4fuAdUke2FRSb0p1/RBBiHsprVPs7HqeYzrO7K/w=@vger.kernel.org
X-Received: by 2002:a17:90b:350b:b0:312:29e:9ed5 with SMTP id
 98e67ed59e1d1-31e77a124ecmr4350962a91.23.1753478246765; Fri, 25 Jul 2025
 14:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724202338.648499-1-me@brighamcampbell.com> <20250724202338.648499-3-me@brighamcampbell.com>
In-Reply-To: <20250724202338.648499-3-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Jul 2025 14:17:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UGNN68Fu4kJQQ8jO+fYP4qVJYmL0quxa_=Y5GEtS-jMQ@mail.gmail.com>
X-Gm-Features: Ac12FXxs1ZuIHE7bbVyrgXeO1Q1pzMxPpg9wpyIoG3cbGGcu5JyXqQ0FaT82pVk
Message-ID: <CAD=FV=UGNN68Fu4kJQQ8jO+fYP4qVJYmL0quxa_=Y5GEtS-jMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: novatek-nt35560: Fix bug and clean up
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 24, 2025 at 1:23=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Fix bug in nt35560_set_brightness() which causes the function to
> erroneously report an error. mipi_dsi_dcs_write() returns either a
> negative value when an error occurred or a positive number of bytes
> written when no error occurred. The buggy code reports and error under
> either condition.

My personal preference would be to code up the fix itself (without the
multi transition) as patch #1. That will make everyone's lives easier
with stable backports. You'll touch the same code twice in your
series, but it will keep it cleaner...


> Update driver to use the "multi" variants of MIPI functions which
> facilitate improved error handling and cleaner driver code.
>
> Fixes: 7835ed6a9e86 ("drm/panel-sony-acx424akp: Modernize backlight handl=
ing")
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>
> The usage of the u8 array, mipi_buf_out, in nt35560_set_brightness() may
> be a little curious. It's useful here because pwm_ratio and pwm_div
> aren't constant, therefore we must store them in a buffer at runtime.
>
> Using mipi_dsi_dcs_write_{seq,buffer}_multi() in place of
> mipi_dsi_dcs_write() gives the added benefit that kmalloc() isn't used
> to write mipi commands.

Ah, this makes sense. We've seen this before, but I keep forgetting
about it. Thanks for mentioning it. I wonder if it makes sense to have
variants of mipi_dsi_generic_write_seq_multi() and
mipi_dsi_dcs_write_seq_multi() that take non-const data. The only
difference would be that the array they declare on the stack would be
a "const" array instead of a "static const" array...


> The jdi-lpm102a188a driver's unprepare() function will ignore errors
> reported by mipi_dsi_dcs_{set_display_off,enter_sleep_mode}. This
> driver, however, will fail to unprepare the panel if either function
> returns an error. The behavior of the jdi-lpm102a188a panel makes more
> sense to me, but I strongly prefer not to change the behavior of this
> driver without personally having access to hardware to test.

Makes sense to me.


> @@ -176,62 +173,28 @@ static int nt35560_set_brightness(struct backlight_=
device *bl)
>
>         /* Set up PWM dutycycle ONE byte (differs from the standard) */
>         dev_dbg(nt->dev, "calculated duty cycle %02x\n", pwm_ratio);
> -       ret =3D mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
> -                                &pwm_ratio, 1);
> -       if (ret < 0) {
> -               dev_err(nt->dev, "failed to set display PWM ratio (%d)\n"=
, ret);
> -               return ret;
> -       }
>
> -       /*
> -        * Sequence to write PWMDIV:
> -        *      address         data
> -        *      0xF3            0xAA   CMD2 Unlock
> -        *      0x00            0x01   Enter CMD2 page 0
> -        *      0X7D            0x01   No reload MTP of CMD2 P1
> -        *      0x22            PWMDIV
> -        *      0x7F            0xAA   CMD2 page 1 lock
> -        */

The above comment was useful. Can you keep it?


> @@ -278,16 +232,18 @@ static int nt35560_read_id(struct nt35560 *nt)
>         case DISPLAY_SONY_ACX424AKP_ID2:
>         case DISPLAY_SONY_ACX424AKP_ID3:
>         case DISPLAY_SONY_ACX424AKP_ID4:
> -               dev_info(nt->dev, "MTP vendor: %02x, version: %02x, panel=
: %02x\n",
> +               dev_info(&dev,
> +                        "MTP vendor: %02x, version: %02x, panel: %02x\n"=
,
>                          vendor, version, panel);
>                 break;
>         default:
> -               dev_info(nt->dev, "unknown vendor: %02x, version: %02x, p=
anel: %02x\n",
> +               dev_info(&dev,
> +                        "unknown vendor: %02x, version: %02x, panel: %02=
x\n",
>                          vendor, version, panel);
>                 break;
>         }
>
> -       return 0;
> +       return;
>  }

nit: no need for explicit return here, right?


> @@ -322,92 +278,56 @@ static void nt35560_power_off(struct nt35560 *nt)
>  static int nt35560_prepare(struct drm_panel *panel)
>  {
>         struct nt35560 *nt =3D panel_to_nt35560(panel);
> -       struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(nt->dev);
> -       const u8 mddi =3D 3;
> +       struct mipi_dsi_multi_context dsi_ctx =3D {
> +               .dsi =3D to_mipi_dsi_device(nt->dev)
> +       };
>         int ret;
>
>         ret =3D nt35560_power_on(nt);
>         if (ret)
>                 return ret;
>
> -       ret =3D nt35560_read_id(nt);
> -       if (ret) {
> -               dev_err(nt->dev, "failed to read panel ID (%d)\n", ret);
> -               goto err_power_off;
> -       }
> +       nt35560_read_id(&dsi_ctx);
>
> -       /* Enabe tearing mode: send TE (tearing effect) at VBLANK */
> -       ret =3D mipi_dsi_dcs_set_tear_on(dsi,
> +       /* Enable tearing mode: send TE (tearing effect) at VBLANK */
> +       mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx,
>                                        MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> -       if (ret) {
> -               dev_err(nt->dev, "failed to enable vblank TE (%d)\n", ret=
);
> -               goto err_power_off;
> -       }
>
>         /*
>          * Set MDDI
>          *
>          * This presumably deactivates the Qualcomm MDDI interface and
>          * selects DSI, similar code is found in other drivers such as th=
e
> -        * Sharp LS043T1LE01 which makes us suspect that this panel may b=
e
> -        * using a Novatek NT35565 or similar display driver chip that sh=
ares
> -        * this command. Due to the lack of documentation we cannot know =
for
> -        * sure.
> +        * Sharp LS043T1LE01

Ah, this is the obsolete comment that you removed and talked about
"after the cut". You could probably include that info in the commit
message itself since someone looking at the commit later would
otherwise not know why this info was removed.

Also, nit: you should end your sentence with a period. :-)


Overall this looks like a nicely done cleanup. Thanks! ...just a few
small nits...


-Doug

