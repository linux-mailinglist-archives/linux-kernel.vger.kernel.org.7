Return-Path: <linux-kernel+bounces-882392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12153C2A593
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 640924EEED2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4FE2BDC25;
	Mon,  3 Nov 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2qcvIs4"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E42292B54
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155147; cv=none; b=sAblg1j4VxO/dtjviD6/dwCm8ikGkFznpXeCRJyuCaEzbdWrYZMKa3EvVuT91x69nXVEQx5q25o+m6iGBf2/NuhWyz71Rts9G3YioNevE3uO+Z3y5F3bnio3qbFv0XSSTsJOmLrvUgDLWjFaSvSnWqErYMyjo7Csfhko3rzzQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155147; c=relaxed/simple;
	bh=ZNSmTPEj7xoV6MOmkmCB9NrRHBYVMykCy4asOAJDTQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imect9j0Ncn0YHZKKkWfclGBc8JqYV+Dq3uqyz2UJf4ec5e7zL40PliCCZ7miuGnM9vlK40wQDXYrfKvL0uwKqjVlpdpBKB0338ExuHrP/2qu5N/N1jMbWf8TnYIFl8fZvCMTJZln9OpIm7dWDBospT9aYf2RUPxyn9K/BGjYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2qcvIs4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37902f130e1so41946731fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762155144; x=1762759944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaaUEDVSi1zym8/RCHGJWc+jChnQELjhyUR46GKHyw4=;
        b=H2qcvIs4aNJz+xc1qsMhgVFD2O+MRMWxhmZ6DvpWdAvOATbLRj1QB8i9EOGKJ9DuaG
         eHhVUPW3YLhCXRwcqmBLODUJvUg58bQXpBAXdwk6xfVLsbb4xJHWm/6N8POqimEH9ion
         f/8zak4cYZITWNuY/4ZHQvG5cldJLb+dIAk91nqbMy87Kj3DNXfbN6LvTElS02Z5wi/B
         utkwhyN9eh+RxnKpjmWztL2zYczAjaUuEXtPQNpeY/GpXnN2XY0LDOv8Px+/J86C1vlb
         vPdLgcqfm4InDYVS7b2uvpXKgc6iKhYZ7mhrPJAeJ6kKlQ69o6W4nNRZ7DfaBNzBMjI5
         xt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762155144; x=1762759944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaaUEDVSi1zym8/RCHGJWc+jChnQELjhyUR46GKHyw4=;
        b=rqawcJ4nZoUezvsGak01hbM4sHEeGmNrvmhiQCMHq0vBHCOoCWlohSWubjlTWsp6+p
         tzT/IJw8gpfPtwRlus9YwI/tz61+37Xza243832OaisZ9N3zJbGs47MPN0fUK2zjgkgV
         objWiLTyWd1D2Yoy4QB2wPJrLZk9WbPdsIVbXSAfPcVcU6wUyFLnCBjSGlpIIaW35m+X
         PjDL3dgGCcNmxh9q7SuTI5dSd9+2R4EUPFiT+4b+LZPsymQjdHL+s16iF7KjjlC0Qeoy
         QyQioUQmDEyKWQsB42YNx36+34vOr89NBmGPOYJ/TDV5pAgAzkkhvYwq6QhdkPOCkdqA
         DWRg==
X-Forwarded-Encrypted: i=1; AJvYcCUHeSZPLJTHsHUmt1QZz3M9ml0aV7Z2GthuvRhbZac+vB8xPCvzvXd5jrOT44LDSlkBJ9Z1obKIAvIOyIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxpeqeh9lbHjIiekFgpdQbT8cLWfX2icGXSIL7sFdA4YDkURBZ
	vLg2oGtXeoghbC2xSNTNRr+WTjuk3Y3FrvYfKhdNDLePIyruWcdrSk4Pp+N3VFPMLpH8ohqWC04
	/pfcFxHZjIGAs04Ih8CoBsiASX325oDo=
X-Gm-Gg: ASbGncsKetuXXN5Hn6EO5b6XfFaGj3AoXPD7ufO2rS6TI7FHaG9v8WZw2eb/9J3/v4t
	8x8BeHY43EevQpCEhIab3DWnIuB6tPU5jwXWOwolb45b0bVRI5v4DYIDbBH+R7wsMphZDg9Rn0q
	uBWTpo4rooVPwiTHbva1iqTB25BVoyug7ZvdBTuTMfOnsq2ygN/+UgIvvoqaCyIOY0IpXoQuiBf
	+GbakcWZIRwUx5+WFEwPmuFdwJ4GAk38vlQYAvxpNfOax4n9j1TIibI4bwEOdocIYTSzQ==
X-Google-Smtp-Source: AGHT+IG4k1+p/ZVOhwkHMtbxP47toCZzPfmoTR7VNJnn8PaEuHNkJSbLEbbfSA/3JaBOQkl8L2AQgGcDYyL6IRs5bS4=
X-Received: by 2002:a2e:a90a:0:b0:373:a465:292c with SMTP id
 38308e7fff4ca-37a18dc179dmr33747461fa.21.1762155143653; Sun, 02 Nov 2025
 23:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024173830.49211-1-xakep.amatop@gmail.com> <1499f50e-aa4f-454a-b8b5-c9a21bef7f72@collabora.com>
In-Reply-To: <1499f50e-aa4f-454a-b8b5-c9a21bef7f72@collabora.com>
From: Mykola Kvach <xakep.amatop@gmail.com>
Date: Mon, 3 Nov 2025 09:32:12 +0200
X-Gm-Features: AWmQ_bklMXYT4Ul_3Xqst3SNaatN_W8582juobBsGuz0hO38xKkJv60xkRmG9BY
Message-ID: <CAGeoDV-+HjpW9CMy5ypsMFDYgYKrV-5zMDGie0=_JyTCo7NF2Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V regulator voltage
To: Michael Riesch <michael.riesch@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Cenk Uluisik <cenk.uluisik@googlemail.com>, Johan Jonker <jbx6244@gmail.com>, 
	Jimmy Hon <honyuenkwun@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Muhammed Efe Cetin <efectn@6tel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Thank you for the fast response and the review.

On Mon, Oct 27, 2025 at 2:39=E2=80=AFPM Michael Riesch
<michael.riesch@collabora.com> wrote:
>
> Hi Mykola,
>
> Thanks for your patch.
>
> Cc: Muhammed who is the author of commit b6bc755d806e
>
> On 10/24/25 19:38, Mykola Kvach wrote:
> > The vcc3v3_pcie20 fixed regulator powers the PCIe device-side 3.3V
> > rail for pcie2x1l2 via vpcie3v3-supply. The DTS mistakenly set its
> > regulator-min/max-microvolt to 1800000. Correct both to 3300000
> > to match the rail name, the PCIe/M.2 power requirement, and the
> > actual hardware wiring on Orange Pi 5.
> >
>
> I guess a "Fixes" tag is in order here:
>
> Fixes: b6bc755d806e ("arm64: dts: rockchip: Add Orange Pi 5")

Thank you for pointing that out. I will add the Fixes tag in v2.

>
> And make sure to Cc: <stable@vger.kernel.org>

Will do.

>
> > Signed-off-by: Mykola Kvach <xakep.amatop@gmail.com>
>
> The change itself makes sense to me.
>
> Reviewed-by: Michael Riesch <michael.riesch@collabora.com>

Thanks! I will carry your Reviewed-by in v2 (diff unchanged).


Best regards,
Mykola

>
> Best regards,
> Michael
>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch=
/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> > index ad6d04793b0a..83b9b6645a1e 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> > @@ -14,8 +14,8 @@ vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
> >               gpios =3D <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> >               regulator-name =3D "vcc3v3_pcie20";
> >               regulator-boot-on;
> > -             regulator-min-microvolt =3D <1800000>;
> > -             regulator-max-microvolt =3D <1800000>;
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> >               startup-delay-us =3D <50000>;
> >               vin-supply =3D <&vcc5v0_sys>;
> >       };
>

