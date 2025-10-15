Return-Path: <linux-kernel+bounces-855006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1167BBDFE90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B5F3A3CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE942FDC30;
	Wed, 15 Oct 2025 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fj2vMLZC"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDC2F60CB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550032; cv=none; b=G0UuEyr7Zwk3MudrsSYdAdfpuCeicBfn9oLQryJOpms4jFtbjikwx9lo/Z4rM0xpx+VzcY2FraEoTy6FC/G9BkH9gb8nXRxw4o4E3NusG+e+jnbUBsFOLny9ui72XynIH8HPbouTmOCrvVMZv4A6BhMaICmlQotcA6yz4vdp+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550032; c=relaxed/simple;
	bh=S1FtdcUcmIeQ998wpbQfLf/uCQbI5Kp2wTYdVUeqhYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWkiiQVvb9OfdgYpAZpVQJ7FVgZ0vtfHOJZdHANHIrsM2dZbO9hpR/bcBOeju8mik9/LC0ZOGgd5qzvBhlZpltHQA+pXhAiVIg4GYJat3jEHbIBJjV3QgiJcy9NfNiBIivfrgeMP9Ovuvuf54BLnrKsaiuL/Kvor/y+FO4OTn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fj2vMLZC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so1003668a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760550031; x=1761154831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkp4QiQO+ZGOJJIskGqlgSdH1DbycxG+pl4uWz6LL4o=;
        b=Fj2vMLZCnTOp+ubOpX09XI3jLcZ90M5IVrMZVpZkEyUltJy/M/XYqI9uK4b0koX94U
         6qXBvyWXH/79qgI3wRcJeADYvR+beO+R2NULk8xTWbjlurBRrUnGfBgdxKwEYnXQOgXk
         R5SapVE7kWDiL2HFrpFkfNumIY96e95PZBt+iI4HlqjKVwTK7/gzuTtkTloAbL8qOMfu
         KsQUotmLq+hDI0B8RpTonoNDPlTTjoVH5MrYX3oMsasHQwPCODhugld5ZAuYORYAJtxk
         QdTWnpgygHP5MEz9RPAOTuZQsNW1GxwuSISGZU8xGn9J+/L5RYVctcvd07Cxag/0608O
         K9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550031; x=1761154831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkp4QiQO+ZGOJJIskGqlgSdH1DbycxG+pl4uWz6LL4o=;
        b=Hj8FIz6PHGPj9LPi+iYpOzukNqkonCfJDkgRSzsMcM//Ol1EMiqKZ3eseyoolvYy06
         E46miLH177fjn3M5dKB9erAElFRCVIXqb5HE0qdZ47F0twWPCHBAkTp3h2bmj5ki1E5m
         1wus0T5G4HxcP9Rjd0jCaF0a238PMTGXvUJsxhNQtUgVNrZ6J2kBGefFXNiYXbRJ9AOs
         Nkb8UyaelmlsUOqpzIPAVzRGiR8CJC0B8+3Lz9NBE16mxinpuwoqXNevB9Rd5iOgKJgy
         akU3eHSTOj74ElgSJjLrzF07FAEBtvM7vlOWIYGmovU1SPE5mFEEDYChC1xQpSzg09Nd
         J3wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzmaITwEepTFGvvRsYJwkbMz1XVs6yf4Fs8FLd7XmEUBO2HnbhOtFg9ZA/0iOtKGvunDEabObPVWZ8DTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlkmPC/4WOokJRTEfIp3sGdqpbrvKe6Jzx2qe3OtCrWaGKLdf
	6zcqSrqNQSX1756i8XXwd9K8z4uVwIDuI0cl8+lID3BDphAe9czfgr2a9CHWCiE5qTmMuHWg6lk
	/KZlFUg+nbg1Rhx143dNjl++MOeNjeObmn7cfGHPh
X-Gm-Gg: ASbGncsMsTvOYWD2m04B+3ZD+AbS/wHfajHPA3f7l00IeS1vOQqVMQqqfpLANJSdauC
	/1cXK45RTrPAFnnZ/r09C3nbp9l+u0MP+oe4pJGAZIIV4o0oqX39j0LBP97mq1b5vO2RnU7qUbM
	8ouNGSxit5b1U6KfoV/HF0cadiZ1OT6qGs8cqm/bEJ4WCoxENaxeoA7Caha72DtUL+Y3rx1b3OL
	ywXZep4NExI1VwDsyFmKu4S7uL5ymqTie/68gHgJhy4iP4ewR+QPyXJ+cKfClS+YA==
X-Google-Smtp-Source: AGHT+IGtM8hvN4lqZlO0WHIvTbL3D48lIHd91NHDkSwH6JM5GHtQa8Pa5RXv0ZasuodiKcuODGfruyjdLC0lq/iK870=
X-Received: by 2002:a17:902:e94e:b0:279:daa1:6780 with SMTP id
 d9443c01a7336-2902741cf99mr376217665ad.52.1760550030102; Wed, 15 Oct 2025
 10:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010201607.1190967-1-royluo@google.com> <20251010201607.1190967-3-royluo@google.com>
 <20251015002744.sntua4kqidgusafo@synopsys.com>
In-Reply-To: <20251015002744.sntua4kqidgusafo@synopsys.com>
From: Roy Luo <royluo@google.com>
Date: Wed, 15 Oct 2025 10:39:53 -0700
X-Gm-Features: AS18NWDkbrVxIDG8dAIZI0TtKFaXgEljVUvTQC724DiczltW9oPtD4sVlkXhIBk
Message-ID: <CA+zupgxbGjU_01JSFR_-2humZAyxwcVT5JR6h6mTVUT=3fFQ6Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] usb: dwc3: Add Google Tensor SoC DWC3 glue driver
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, Badhri Jagan Sridharan <badhri@google.com>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:28=E2=80=AFPM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> Hi,
>
> On Fri, Oct 10, 2025, Roy Luo wrote:
> > +#endif /* CONFIG_PM */
> > +
> > +static const struct dev_pm_ops dwc3_google_dev_pm_ops =3D {
> > +     SET_SYSTEM_SLEEP_PM_OPS(dwc3_google_pm_suspend, dwc3_google_pm_re=
sume)
> > +     SET_RUNTIME_PM_OPS(dwc3_google_runtime_suspend, dwc3_google_runti=
me_resume,
> > +                        dwc3_google_runtime_idle)
>
> Can we use the new pm_ptr() and *_PM_OPS macros to get rid of the ifdef
> CONFIG_PM guards?

Yes, will replace it with pm_ptr in the next patch.
P.S. The kernel test robot is also complaining about it. [1]

[1] https://lore.kernel.org/linux-usb/202510111335.oyOAs9MB-lkp@intel.com/

>
> > +     .complete =3D dwc3_google_complete,
> > +     .prepare =3D dwc3_google_prepare,
> > +};
> > +
> > +static const struct of_device_id dwc3_google_of_match[] =3D {
> > +     { .compatible =3D "google,gs5-dwc3" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, dwc3_google_of_match);
> > +
> > +static struct platform_driver dwc3_google_driver =3D {
> > +     .probe          =3D dwc3_google_probe,
> > +     .remove         =3D dwc3_google_remove,
> > +     .driver         =3D {
> > +             .name   =3D "google-dwc3",
> > +             .pm     =3D &dwc3_google_dev_pm_ops,
> > +             .of_match_table =3D dwc3_google_of_match,
> > +     },
> > +};
> > +
> > +module_platform_driver(dwc3_google_driver);
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("DesignWare DWC3 Google Glue Driver");
> > --
> > 2.51.0.740.g6adb054d12-goog
> >
>
> Give me some time, and I'll review the rest of this patch.

Thanks Thinh! and a heads up, I'm splitting this patset into
two separate series as Krzysztof suggested; one for the
controller and one for the phy, so the series title might
change in the next version.

Regards,
Roy Luo

>
> Thanks,
> Thinh

