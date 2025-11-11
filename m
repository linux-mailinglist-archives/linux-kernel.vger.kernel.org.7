Return-Path: <linux-kernel+bounces-895510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9484AC4E216
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A428A4EC6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143C33AD89;
	Tue, 11 Nov 2025 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="ih6ybhPX"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852433122A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868005; cv=none; b=H9Hh176eVUcfDy1BI27ZiJ8tmBhy7i3ztFK8hTGzUsEIRY/g1H9/mFb1dRVlaAduZ6Eax2jIN8VOcADKr3vtcSKaSuVkxnHbGa6oWLVQkXReMYIvRxud43I+8RKxzL4GnTgpQwJsGTYDb39SwF99UTyn7COGDoBSa2gordx4cUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868005; c=relaxed/simple;
	bh=m/IDcbUYaTlqaJOcWar+0Jl6b6b2/gJXupbjxTarers=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axGY+6hJ2k+qpMC4aPyosrxcv72FzrdesYJCNp8r62CPPu0GUuvA96P/7QmQYzjzhzkE8QAoU67xa2GXfoESBgH/Z28IYOiHQF9KIuxtAhiUU4swmFHWgUGaq5hJm1J5U8pQZCproQOo+g9gBqSfGB+oM5Rym11FlKTY6I8/NeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=ih6ybhPX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-378d6fa5aebso36762331fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762868001; x=1763472801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lY3yD/lWkhxBE38j+dUGeqe89ypJFm7YKL/U6lIARs=;
        b=ih6ybhPXbqtT8us51h/YwWyVZ9wcl99rW3342DSYuZA6MsfWJX/+RTijmuAGgNOgr7
         ZCLbtKuYI2jn8B38r3aHofSHCteMAzdlkJVisOuiy7yxJXiPI+HXxjcMbwG4RwMcclqm
         bn1Wn7GNBYw9cX0I/OfJDZsoayVCsHR0qwVKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868001; x=1763472801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lY3yD/lWkhxBE38j+dUGeqe89ypJFm7YKL/U6lIARs=;
        b=ZDQU3vTnTe+Q7CBPCqy9KwVPIflkS9D0a2LIqHVoisSmymHq6SD3al3oRfLvHU1YsM
         9s2hDhAEVk39xsCmGkwx0n5ZMwfY4CT3dH79sl53tVeHpkK5doZh8AKAtX6RxqU5wKl7
         Hn/b4txf7M0l13qLtH9jHQahsUbLy/rjTz/uQG0OR3cb/IVJGk2URLrfte3Mqx2MF7jt
         S3IQnkjX897AMoaLclCqrArQgHLvshfvALTCNJ6ptMmo9q9hxMU9zjGSx7n2Ehqec8NV
         l6s3VOfgW7h2ZKRtlY4sM5E5Cnxj7iDXRx+TdxrQ21oUsMVDpPPP7M8UWgo9odEt4Szi
         3oYw==
X-Forwarded-Encrypted: i=1; AJvYcCVVmnXLkwVKNRsPJzVPytLzeLYY8MZI/hqkQfN+ILAtFlmHbSXOaULTQbyyDiwCH3leozxUyzJSOwiFmU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQHhgdgfcGat9UAnjVlXx7mvJ/Il0DIJ48vfd9m1RzVYSn9k6
	tXKaSg7wdgYH9pN71oR5k5RkW69dOBHOzJKjvxl8zKVZoEAS0QhsJWx/OOehj6FE9430/rQR5R9
	pNssSTj4gcl57Vhb1bGn7F17zYz0BG7mLsC/eMu4Eaw==
X-Gm-Gg: ASbGncuxm4UoaIYPJ5pHQHJFoQWo42Z9zbL+vhjMkbUa/qS4EWPSKnIXj3J/H/ukyIy
	sOKVxvqoiTksVyqaG94qdjWWSKzvZkpinaWmpLNMI+a3b8p+TEDQmKsrFURDX3U0MPBOh6qC5Md
	lsnajNEcS0XYAJ7jSjm1DCLhSkkelM9XOSoYtUtCglqVBqHhkjj7tnQPY7qk821+qYnLSwRVM5h
	8HJLaXYSupznNbKyi1QOkpAzTLoMrIitEGrTSu1wJx1eaQTdc3Kij6cog2ztg==
X-Google-Smtp-Source: AGHT+IEa2+alpsV7yZo2MQ2zemGQSgaZflRIFnqWJ5eOZ/bg4aVTD1e/Z7u7RDia8HjsH2yeWCn923dhPxhZxjFLNYs=
X-Received: by 2002:a05:6512:61a1:b0:594:51ac:138 with SMTP id
 2adb3069b0e04-5945f165199mr3017960e87.2.1762868001402; Tue, 11 Nov 2025
 05:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106153119.266840-1-r.mereu@arduino.cc> <20251106153119.266840-3-r.mereu@arduino.cc>
 <84f0ed2f-bf51-4dd5-93f1-f26e077a2549@kernel.org>
In-Reply-To: <84f0ed2f-bf51-4dd5-93f1-f26e077a2549@kernel.org>
From: Riccardo Mereu Linux Kernel <r.mereu.kernel@arduino.cc>
Date: Tue, 11 Nov 2025 14:33:09 +0100
X-Gm-Features: AWmQ_bl9u7adnSSXNZGOLBBGiNfZ8y3mPpTDmoF7L_YWRx9FeA-avTcHCLCKRGM
Message-ID: <CAKA1JhYTC5p_7Zj9b7g1YKZhjH0=tnnJkdW1rWv39L-SF-SDoA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drivers: spi: spidev: add compatible for arduino spi
 mcu interface
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org, 
	linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net, 
	naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com, 
	chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com, 
	farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, Riccardo Mereu <r.mereu@arduino.cc>, 
	Martino Facchin <m.facchin@arduino.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:13=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> > ---
> >  drivers/spi/spidev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> > index 5300c942a2a4..f0dd516c2083 100644
> > --- a/drivers/spi/spidev.c
> > +++ b/drivers/spi/spidev.c
> > @@ -704,6 +704,7 @@ static const struct class spidev_class =3D {
> >   */
> >  static const struct spi_device_id spidev_spi_ids[] =3D {
> >       { .name =3D /* abb */ "spi-sensor" },
> > +     { .name =3D /* arduino */ "mcu" },
> >       { .name =3D /* cisco */ "spi-petra" },
> >       { .name =3D /* dh */ "dhcom-board" },
> >       { .name =3D /* elgin */ "jg10309-01" },
> > @@ -737,6 +738,7 @@ static int spidev_of_check(struct device *dev)
> >
> >  static const struct of_device_id spidev_dt_ids[] =3D {
> >       { .compatible =3D "abb,spi-sensor", .data =3D &spidev_of_check },
> > +     { .compatible =3D "arduino,mcu", .data =3D &spidev_of_check },
>
> That's way too generic, IMO. First, I am not aware of Arduino boards
> mounted on top of regular development boards, so basically you are not
> describing actual hardware setup but what could be potentially plugged
> into box with Linux... and then it is like saying "you can plug
> anything" because MCU covers everything, like calling it "Raspberry
> Pi-clone".

This is used to describe one of the interfaces between the
microcontroller and the microprocessor on the Arduino UnoQ board.
Since this could be used in other layouts in the future, we thought to
keep it generic enough to reuse it.
If this isn't possible, do you have any suggestions?

>
> Best regards,
> Krzysztof

