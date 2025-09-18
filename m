Return-Path: <linux-kernel+bounces-823232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2029B85DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1396762712C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B99313299;
	Thu, 18 Sep 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XE2F37dI"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1C1B87C0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210964; cv=none; b=Vem9y7XpyD96mPk6xQt0iNpHcTsym0SFxW50AJ62T9jlSmPGaRUvTcCc87zLejL4xAFn0lqmnzxpdzG11C+X7Yx2Rb1aWbBaEri8GyLtDUGdBCUTmVQ0gPngk4VKzJq8n3RYiPvuqhuiD/IqQoGJgwzFUirlIQ3ZXjABbieH8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210964; c=relaxed/simple;
	bh=UeZq0pHTduP+iZFoeFnOKXM6Oxja1vWxpxZAhP3BxT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttyDsFc7Typyotjvreg0ij9XUWGnhtOA6LGdODw1wrjHHxhojALSEktCRdSjCBKp/Qd0LsgKmxe84QRW0JALir+GcZC9rnr8UE9E74SpSNsVr038cNSG/AVZ9mKrbzuPlagM4jQuA9nTlahV8tZmFy2db5N23Atz/SL/hwNIJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XE2F37dI; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-62a35c99b9fso471469d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758210960; x=1758815760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdfK/q+Pwfof78/WFiIzEJbNGwk57mdR4QjuAR4qnWM=;
        b=XE2F37dIX2AnItBOkWF2X8l4MTBSpb916/0bPK1aVh0+24FL22SKy+YpsDrjiiZ+g1
         pmyhULYGE2jtjowr67HFz6ZeAaS4Bw+3sMQlaCZiuoG0QalJtctIuuPgg8oclytYzCpC
         n5e+mEjMvEEEpITHeQP926DV9raNPSm/5sx3RFwWYI0Qtgj8LvRqYo4tsIKs22t1zq9G
         GGp+ruIu6HVKWAphx5qkrVGi+xdrGbHjkjrfAO8FYi2RMUs6HGTvDFKZlLg40g4QokFy
         tmiGcSRpjzQ0pKYpRkJy4h2yFB9HUpJIipwECTuZ+2EcmLQuUwmddkoSy55twkJo5ZMS
         ZXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210960; x=1758815760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdfK/q+Pwfof78/WFiIzEJbNGwk57mdR4QjuAR4qnWM=;
        b=n7s+LsS5A+/1zP24ba2iTdyIbPsDsq2arlbRWW9o6+RxBGXOV+7P9fNJfeDxOvmS3S
         IQXuYW6kU4q5a5uya1h+y41J7WrYDJrU31mrjdfpT8UC8wHrzuY50JQQYaBxD7c/sBwv
         otA2Wj7+OaIB9ij7AUNRLo8PRBRc2GESXDlyC1N7YI5kjzqTz1TROlPhILLerqxsN/sg
         UxP9MatF2k7trh8D0SHLABDUFi0R1Es3/C/Cw/GQ5pNCWIFV5KE5GRDhbWU9l+xRiAM1
         6HQMxjRw3RP3Igdq8juSTogMp6Uedcm+XaE0a5TWSzzYj09/O9YdWJogpoHUtKM0U/oY
         +pLA==
X-Forwarded-Encrypted: i=1; AJvYcCWkqM3BzF1/9VrB7xp+d3dL77IB/oxgci7gDufB8VbctOiI6zbOrnMbGlfamVEejZYSmKPZlFOEvS05r08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwyrUOCMnbMnEHdBOwlUJQ4lm3PqPlSilgYm4PS1k39Ug/qEO
	m6lU9DsisXtxBKFZhzvm4VzuDP4N43x6anrcqyoZPsucBRP7Wfk2AiRFYgb5J7N5Gk8YgOwu2WV
	+eLwacuoW6IUjiu+Q2Gb/qGfriWL4z4dBYVMpCsHnxA==
X-Gm-Gg: ASbGncu8Cn7EqtLi5Alf0xrmXC1rqcljvivdorOpBtiyNOBWBkTonBb/MTRdcNbGfMH
	QV8VkUbG+HP5LKNgDzY+3edX/dqW0dwopYUMKSAdHfgAsNGGsq6kYU5HkZ4qV9tbTXvRYZLRGwL
	I2xnfnMIBS/i8JZ3LL8xD+iKl3WisEyXJagq+cVSN0qMhFKT1SzgqB40b4BT/SIgFs78Wau8/5t
	oJrKbVFYWwYia8l5ovlIOq3GYs=
X-Google-Smtp-Source: AGHT+IEECGH2G8e/CDH9F0qac/7FZa5yDye+HQmQVSLPgRHzbQeecfKUO0vMmnt8GIhKDbVRf8GMagQg2WceGWP5ZzQ=
X-Received: by 2002:a05:690e:1559:20b0:628:9b45:5e29 with SMTP id
 956f58d0204a3-6347f544d01mr24918d50.15.1758210958918; Thu, 18 Sep 2025
 08:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818074906.2907277-1-uwu@icenowy.me> <20250818074906.2907277-3-uwu@icenowy.me>
 <CAPDyKFombYNFvTsChewQ6cFY2woS+vSb1YUV0Bp_+DcigrFFXA@mail.gmail.com> <89ed15328b73b191fe152cf8559b92239b5596bd.camel@icenowy.me>
In-Reply-To: <89ed15328b73b191fe152cf8559b92239b5596bd.camel@icenowy.me>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Sep 2025 17:55:23 +0200
X-Gm-Features: AS18NWAOrRn2SPBMcr_jo91dsxsIlLlmmb44l-SPKPjXdyTcSw8dHOMtiv-1B0s
Message-ID: <CAPDyKFoQuLKwf69YK7ynj-HeWXsMzguYBtbOy8HE5X_jb1dUpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: thead: create auxiliary device for rebooting
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sept 2025 at 17:44, Icenowy Zheng <uwu@icenowy.me> wrote:
>
> =E5=9C=A8 2025-09-04=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 12:14 +0200=EF=
=BC=8CUlf Hansson=E5=86=99=E9=81=93=EF=BC=9A
> > On Mon, 18 Aug 2025 at 09:49, Icenowy Zheng <uwu@icenowy.me> wrote:
> > >
> > > The reboot / power off operations require communication with the
> > > AON
> > > firmware too.
> > >
> > > As the driver is already present, create an auxiliary device with
> > > name
> > > "reboot" to match that driver, and pass the AON channel by using
> > > platform_data.
> > >
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> > >  drivers/pmdomain/thead/th1520-pm-domains.c | 35
> > > ++++++++++++++++++++--
> > >  1 file changed, 33 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c
> > > b/drivers/pmdomain/thead/th1520-pm-domains.c
> > > index 9040b698e7f7f..8285f552897b0 100644
> > > --- a/drivers/pmdomain/thead/th1520-pm-domains.c
> > > +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> > > @@ -129,12 +129,39 @@ static void th1520_pd_init_all_off(struct
> > > generic_pm_domain **domains,
> > >         }
> > >  }
> > >
> > > -static void th1520_pd_pwrseq_unregister_adev(void *adev)
> > > +static void th1520_pd_unregister_adev(void *adev)
> > >  {
> > >         auxiliary_device_delete(adev);
> > >         auxiliary_device_uninit(adev);
> > >  }
> > >
> > > +static int th1520_pd_reboot_init(struct device *dev, struct
> > > th1520_aon_chan *aon_chan)
> > > +{
> > > +       struct auxiliary_device *adev;
> > > +       int ret;
> > > +
> > > +       adev =3D devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
> > > +       if (!adev)
> > > +               return -ENOMEM;
> > > +
> > > +       adev->name =3D "reboot";
> > > +       adev->dev.parent =3D dev;
> > > +       adev->dev.platform_data =3D aon_chan;
> > > +
> > > +       ret =3D auxiliary_device_init(adev);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D auxiliary_device_add(adev);
> > > +       if (ret) {
> > > +               auxiliary_device_uninit(adev);
> > > +               return ret;
> > > +       }
> > > +
> > > +       return devm_add_action_or_reset(dev,
> > > th1520_pd_unregister_adev,
> > > +                                       adev);
> >
> > We have devm_auxiliary_device_create() now, I suggest we use that
> > instead.
>
> Should I send a v2 to convert to use this?

Please do, then I am ready to pick up the series.

[...]

Kind regards
Uffe

