Return-Path: <linux-kernel+bounces-816854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE395B5797A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33E5480A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D136130498D;
	Mon, 15 Sep 2025 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg5psPh4"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D63043D4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937219; cv=none; b=Ete+zy/++i+HNmFtj6Aa8jd0+v/lNrohwBOYuEcq+vHFDyt1F9LAMyAOJpsvR58Suv+KPVqC6PxeiER9GxhYdymxrxpLlZZv/21KiZfSnU/QIdMNu6/2xrNoF2dYkGt4wNRbRl8mkGBULxBGwEBUpx9s5RoRPdOnLPFvcP31AUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937219; c=relaxed/simple;
	bh=0ILSGIiItmyMCE7xHI853y8dy3amB33rFGrcT6q6w44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ip/e8vsfx4TNJklrZKkTyRdixisUPwQMrypkxjimSR+AVcrymyf1EkXORnvVmSQepX9kHQspPepflu2upe7QFlqDAqgo/aVcPMq09wLNsphkD8bEunrK5djhzsQCsINOqx2jCe/YaXZUbEjTKaksX9BaZrmu1OPbYi4BPD+LsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg5psPh4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2895136f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757937216; x=1758542016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9rsfkbv0EL7aToRl/37b12mldmjeHZasuzSc06g/5c=;
        b=Yg5psPh4WYZ92pfMU1Q8RGDtkgtbVzBijRhhArXWxcjCQh7G2fsyAIeW+QpA1vE1Io
         nCv/WF4UgrliahfuxHIJLVjISmUpoAJYkxt0siwxT0iq6BmS7ZU+MgulJvzepOA5yXuv
         yzUMbfAXMl4dbqDCITwYp920tI8Lj1lAoIuUGNAJacC2seqrYv8qHW2ANiApNh77wJNc
         VI37DsVmgptMc5/oXJTjIhioAO1KxAg+69q9c2L1Qr6UKEFLaUogMB+C9lTQYejLLnsF
         8EwaHXq7nuy5DlVrNXOuqgAzrPoJmNRg0IV5lY7l0IWhqOKrxywuJrRNuc5G6SQUUT0f
         mJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757937216; x=1758542016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9rsfkbv0EL7aToRl/37b12mldmjeHZasuzSc06g/5c=;
        b=vyrBYKa4PJbZpMCEBvth8qUTXhGBEFYd9ots1jysKmhZv+ga43Jj0cHQGcXzDojD4V
         VvLLZNXAvuCQ7kBSsWnuklzCWHbM+xkSpgbcG7KoAUD+cLuUBdEmFFoqT4spOJWi9MbZ
         QhAvjE4S6KQh9Mg+qK0G0kwFTiE8RfF1gg077tcm6FlYe1QtfZslGgB0m/iIrMEoHHI2
         nE6Xc3eK8YRW5gdydPvAyiF6xrzQ9JVU2SMhYHBIn4HMxdNuAkieTTQAvHcSYPfU/QE8
         TKBe17rqDFjAJAayXNpaL8XdtXW3dYr7J8VTBjk9rRDomxXylVRFUSiN5Fgr614YJtzy
         R47w==
X-Forwarded-Encrypted: i=1; AJvYcCWo8FAWhBL+1xpip6jqdkFxd+0PjK5Q0pHwYlTZe2LPPDLuXu/9U5yWsPv/T13BpQhbKBt2dE8p33SfLSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Xf1T2dEp7AwFX56t+jErpSzNdiSzHmZEDBbrhR1hOJbXPnRX
	FeyXSkVNm4Htnj8QmPfRNmYrG3GOuRJ4lURJU2425Aidb0ByJoIoHbF4oerEXlocWVfj1LpNK+c
	yhOKgC2kM12+SMNvf3kj9Xb6fkEcCcCg=
X-Gm-Gg: ASbGncuj379hLN6MJZEWfOdo50qSNjRCiXNJaAi289c8hOjJJDgJp8zSa4cYXNbWOZh
	PCKkr7fuWaW6AIRXws0fK+wPB1/CSC0OJUfn43fSQgb/i2cVHy3xwCEMqRDz3PfK19467GSHSiB
	uDCmb37SUAw4F180f7Ego/CB0abNuH7/NEIW5K1oG3Ib/fbws/0RCBx8A8yKl3uwQ4jIwaTgUje
	fjq8TUKgE+aHCbzAVw=
X-Google-Smtp-Source: AGHT+IGfEQTtfZM/ItJCozrT631R5nXA0YD+rGtclPjyGWg2BWC+ZOF/elBODu9mAt1IorwWM6bWM2cMtMtquc7HPHI=
X-Received: by 2002:a05:6000:1884:b0:3ea:558d:8e33 with SMTP id
 ffacd0b85a97d-3ea558d92femr3441083f8f.11.1757937215754; Mon, 15 Sep 2025
 04:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915060141.12540-1-clamor95@gmail.com> <aMf6DLr8pTCP8tKn@shikoro>
In-Reply-To: <aMf6DLr8pTCP8tKn@shikoro>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 15 Sep 2025 14:53:23 +0300
X-Gm-Features: AS18NWBLkeKaqjltS4302C4IX18eul5NJVuVOImh89VIisTr8ceAaA7N6g0u10Y
Message-ID: <CAPVz0n3m9VOV5unVHhU67XQnk4jckA+zyJdCHXu2fFxCSht4JQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] i2c: muxes: Add GPIO-detected hotplug I2C
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Luca Ceresoli <luca@lucaceresoli.net>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 15 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 14:35 Wolf=
ram Sang
<wsa+renesas@sang-engineering.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Sep 15, 2025 at 09:01:36AM +0300, Svyatoslav Ryhel wrote:
> > Implement driver for hot-plugged I2C busses, where some devices on
> > a bus are hot-pluggable and their presence is indicated by GPIO line.
> > This feature is used by the ASUS Transformers family, by the  Microsoft
> > Surface RT/2 and maybe more.
> >
> > ASUS Transformers expose i2c line via proprietary 40 pin plug and wire
> > that line through optional dock accessory. Devices in the dock are
> > connected to this i2c line and docks presence is detected by a dedicted
> > GPIO.
> >
> > Micha=C5=82 Miros=C5=82aw (1):
> >   i2c: muxes: Add GPIO-detected hotplug I2C
> >
> > Svyatoslav Ryhel (1):
> >   dt-bindings: i2c: Document GPIO detected hot-plugged I2C bus
> >
> >  .../bindings/i2c/i2c-hotplug-gpio.yaml        |  65 +++++
> >  drivers/i2c/muxes/Kconfig                     |  11 +
> >  drivers/i2c/muxes/Makefile                    |   1 +
> >  drivers/i2c/muxes/i2c-hotplug-gpio.c          | 263 ++++++++++++++++++
> >  4 files changed, 340 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hotplug-g=
pio.yaml
> >  create mode 100644 drivers/i2c/muxes/i2c-hotplug-gpio.c
>
> Adding Herve and Luca to CC because they want to achieve the same with
> their I2C bus extensions, no?
>

I have no idea what you are talking about, this an original series I
have sent 2 years ago but now I decided that would be nice to have it
in mainline Linux.  Here is a link to patchset from 19th Jun 2023
https://lkml.org/lkml/2023/6/19/781

