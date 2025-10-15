Return-Path: <linux-kernel+bounces-855130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C82CBE053B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE58342837C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE63A3019B2;
	Wed, 15 Oct 2025 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuNCKEzm"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B627A135
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555568; cv=none; b=Pn+N9YAPhsP7LVLvmfpz2PB8f0viKQjiX/n/dzSynVFQ0TEAY6UwAZWuVtZwzGQtMt8v5sVyiAn83ULljlW7yffC6KmBtYYppNxXVD/wbz2ZU38c8K4b3svyL4k9+jC9Iz5n6S6s1n5C1Wfau3F8NTOADHo63wdo8U04pRmXs7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555568; c=relaxed/simple;
	bh=MvR+0JKXb5CBAEei5A2lB3ToTgOiUAvcquMmLPEYUy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=os2GT4qZy93Jz6kISjdJ++G4rVWEyj1mV0juU1K1RE+SA/hRkACk3qjkQl6wzcyE9oRp8OtR3HUWeeb1xmm7zXjYC3EgYwjXCZ6UrpSOG8ChZUqXOIPBjNuF2JAcKtsjgPOX5k+L4upbGarqlRg38F7R5iNvRTKtfbvtVkRs6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuNCKEzm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so42820655e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760555565; x=1761160365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhyinuDlZwKREDWmNx8hCk7tI9XdjStorfWj2UhFgTY=;
        b=CuNCKEzmNNFm8QiEk1EemTNCB6eJcJOl2G6kmRrvOOPZeNuHHc/nuUrKRbByMYG9s1
         srbVteVPPFS+W06BULQrxd2QQu9RmE1kf4nT0JG0sEJ1MrRh4wvGSBfiAEbqdJYe3ft+
         RjUR5zktBIwXWG3dCodcI/Kj57YsJBJt+/z+mcJmEFpBxaCLMVonjNdRtZCWZuZxp9/E
         3MKLDqoTibeQ6y02BvALO+5X/ko+kKbojFMjtp3/5mCRo645aBYCLyUQKvQX1qcX8Mku
         w2Pp2Nk73XqO5jFn7A7CDyRYeg75hJDZLKwDZQLv17wioIEH6takbzzcPl5I9jepR/1q
         d8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760555565; x=1761160365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhyinuDlZwKREDWmNx8hCk7tI9XdjStorfWj2UhFgTY=;
        b=IUW2nRXN8QY6m0Igm0KgCZIq6UZt5dGA8EH8c1Oupuk28t/yHk45zzNvV3P1Rt4Zf2
         OXAFUoQmQhro2tqfICISOniE60s1RNyxRg9G1ttO8aXKJD9I9XT7pEyEXcQgCf+o3isG
         X913Eihl+wBNBP+pd1VA58/JWm41BA5t4GgQUwlqEEXjiYHXsf31S3V7FbXw8ydbz6Xq
         aRBSQ88FoOGfmRFscR4IKq7Wv+MBZ2Tssy7IMXWr9veg2GYz8krdooQdHnwP1tSX8RlJ
         H58BjPbQWumRbF2eI+hoxRbTcy6GRnc2FJtrl32aAL6exTknWl26DEkcbi7oSaKSkNy+
         b2cA==
X-Forwarded-Encrypted: i=1; AJvYcCXt87Gp57AoQqaAtyX6aYUQrAcfAZeTKmef3JHocKxwcS3I9ihu0uI66xww7OuFXeVz2Z//vNMyLT1X3/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYV0et7Li8kkZO2FMxaMMhmM1KaYKMc4l0hvVGw17/iX1O4/n
	sLD/J9d083/GdRl43Np46oKhi9RuT7UmmXGd/A2Qfn2VW9RhSuJ30lh9Q3gTib0LNJ209xDXNaL
	cMpvXYxRTk/qvcOLP5dAsMqGGCcur/o8=
X-Gm-Gg: ASbGncs1Aekr1UVrZ2QRH24Er2u12WVEJehQ86bbiHWseejSx4aQSH2ybF/dFyekvkn
	PfcYJQIW0LFwOfZqFWgFe++4eSGZhtsS8192/F9AydzhzXRhXHZemAp7XQllcINJTpmoUqCo3mg
	NYDgZBIPi+RK82+VNr/vtYYgXgQbMqoJcQZ02h0nX10KLJ25HZuZhI8hwhfvV44GQnqornj9bIB
	5Gm+lYOlww/QLWAikfVOnWGFV5Wm6xZpMeUw9CMPCXUbc8ac1cU7DLTz1o7
X-Google-Smtp-Source: AGHT+IGptweOAxfQob9Jd4H5eNxPIDoVFH0g644LiyqMYerOmNSPqkAZdQtC7+4FweyrZZizKJf/AjDZCN535DWV0k8=
X-Received: by 2002:a05:6000:2c0c:b0:3f1:5bdd:190a with SMTP id
 ffacd0b85a97d-42666ac3a16mr18451032f8f.3.1760555564585; Wed, 15 Oct 2025
 12:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014153314.177300-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUBthNYYOg4WHjt+gJRL=g00wmiqCsx+La_3NCUrCJ9gg@mail.gmail.com>
In-Reply-To: <CAMuHMdUBthNYYOg4WHjt+gJRL=g00wmiqCsx+La_3NCUrCJ9gg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 15 Oct 2025 20:12:18 +0100
X-Gm-Features: AS18NWCeX_juiZImnilmkiUrbUqjiLLajME51FAEENFN1IPwAIZdGkxwJx_QjPc
Message-ID: <CA+V-a8vUKJDFCwQ3tMyhuMEaoR1DhpEhhHfwRnmMwNerdBM49w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzt2h-n2h-evk: Add VCC supply for EEPROM
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux I2C <linux-i2c@vger.kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Oct 15, 2025 at 4:36=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> CC at24, regulator
>
> On Tue, 14 Oct 2025 at 17:33, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > The R1EX24016 EEPROM on the RZ/T2H-N2H Evaluation Kit is powered from
> > the 3.3V rail. Add the regulator phandle for the VCC supply to reflect
> > this in the device tree and avoid the fallback to the dummy regulator:
> >
> >     at24 0-0050: supply vcc not found, using dummy regulator
> >
> > Fixes: 0176c9e82e10 ("arm64: dts: renesas: rzt2h-n2h-evk-common: Enable=
 EEPROM on I2C0")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
> > @@ -160,6 +160,7 @@ eeprom: eeprom@50 {
> >                 compatible =3D "renesas,r1ex24016", "atmel,24c16";
> >                 reg =3D <0x50>;
> >                 pagesize =3D <16>;
> > +               vcc-supply =3D <&reg_3p3v>;
> >         };
> >  };
>
> "vcc-supply" is not a required property, according to the DT bindings,
> and I believe the 3.3V supply can be considered always-on (but see
> below to encounter dragons).
> I was always under the impression that these "supply not found, using
> dummy regulator"-messages are just informational, and can be ignored,
> but they are at the KERN_WARNING level.
> So should we add real dummy supplies to DTS, or not?
>
Agreed, I get your point. Let's drop this patch.

Cheers,
Prabhakar

