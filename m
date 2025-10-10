Return-Path: <linux-kernel+bounces-847713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9DBCB7AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 753584E4C70
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D5922A817;
	Fri, 10 Oct 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHrkRafK"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438E72629
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760065828; cv=none; b=eLePEOKDST8RToTYfsLhGgGSt5Hx+CH2vrxJ51VSxB35CxvenYCT3iQzCzgQDpnaOIRLBgarOrj9sAlMmtt66rLNfZzHqfcZ9yDLquIF8FTkulotg/ZyF+8v2cazHTVStxWTi1Rdc/l10yopbK5RilFelxJrWAjm2Ig0YQITLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760065828; c=relaxed/simple;
	bh=Q4W1zmGsdtLHct4SCv4T3QhiBoy/vlC8/IU1ylKx3PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7sF80d++P5nSqOuDa8u+6qDVasLrBQcZ5mocZ6FjjrgHT4zxx9F0Ka89wlRuN6sTTAfUUb8jq+SyHhNRQ6a2S+3Qyr+NRew+ul5pHfK4wIVg4e+Jt12MtUzyavMwUzQVl10iIiNwpuJsJy7jE6nltPSeO5Wxd/gsTnjFcpAis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHrkRafK; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4df81016e59so16145811cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 20:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760065825; x=1760670625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfBVY1jC5OL4Yfzob3d0houbqInXLSFHJbfki1TjZA8=;
        b=gHrkRafKQObvVE0JwkvyfVnQ31rcz7mmxrUETtwdNFmx07FuhP2wPOkwySmTZqzHJQ
         m8YyqEDdtGQTODaptUNgBanAoLqFSAj/hO47LvovuaSLlHg8D/H1gOJydpidwlY0+Fk7
         i9grQ/hlJOtizaO/+wOT6Gi6p5XX8+Gz6kyemFBgppDAjLm8odpUvAANL2hU0uGM52c5
         mK6zcxvc6nKZl4w39VgwtVEdYMszxoPnhrtthoE3cvwA76MiqwqCbsGdTQg+l0WeysKn
         X82Qs3p79np3EPG677IK3OoL2A0GkF8mYnGW1q49ZMFtjG63Slrp6YdK7WDmvoJw5f39
         JsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760065825; x=1760670625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfBVY1jC5OL4Yfzob3d0houbqInXLSFHJbfki1TjZA8=;
        b=VnGWrkL9HdkEbOp/GBS57nUSyRczGDaWPzowwGNDo2GHe0MBIYWdCf/UCLjkn9s4RL
         A3BGblcHl/dAm5JXYafM9xGX5W6SomsUtZ4Jy+WFF9j9keterX05qoFQMAJ+LuP61ZZc
         J5XQyI4wM4IDQROU5P2rSAqZOujFQ2Brx1y5Dt0/JlMDjAxEAHk1vR5Km12f0MU5q5o+
         qOagr+48AdX9WQJzj2hQ1MtET/1tp7dUH9QpLTJiYa6flGNu5S9fpDpA7vwIAkJHi1ao
         f+E47IvYu/gI8wBFvqOsQsJOK+7x/vrkfM+KzRp3YMTBTer0GhN2yTraCkhyiPgCGANF
         TGtg==
X-Forwarded-Encrypted: i=1; AJvYcCVTCmynhSTicLm5eVP9tlZEFGP7+m1PQhjKVl8fMJYSwQGAIF3jVhJlxRyFV3CiYRXpfN9Qd9SykGdUrXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcQ4+vlL0yEWQSQqM5sqPwOVBaCaFCY/I6rFr/plC8EBDWTgP
	bNo1LStgBurb3r1OtMlnrrzuz9eDlJkohVJZJleVCLtgpcSlCMfUavGjXBhT88LULl2GYjCihv0
	B/y7DQlGRzbS+E3oDvXoQG3iDHZkqf9E=
X-Gm-Gg: ASbGncuYcy6hZ9NMvN3CBuP4VGC7DM2NF3Eghs0dvePsj9XrEqvlXQKj5vZCuqSccNz
	NyX6lhbL0o1alMd4BL0QZrGkwmUvxFKuRO0/+oUgGcyWh0zQ+mtQ21lILZUT5mMfNBvTmwknzF8
	9GDNZhj5ZYLwSuwLpMhMjm7Z40KpKnebya6DWPJSYDbQe1b+DqQ5y7RINOIWawFD/o+8GMMvSWw
	JcKBWxaKTjSl6744rTbl6LqpJ0=
X-Google-Smtp-Source: AGHT+IFluk1MSNac3TCPhPVi9qi50zuTrK2jUh6H0rLnaJa6VffG1JzsGBd2YJ7unkitxA1fB1mu0nrqMsKlTJNit7Y=
X-Received: by 2002:a05:622a:4291:b0:4b7:9171:7b10 with SMTP id
 d75a77b69052e-4e6ead65002mr133384621cf.64.1760065825344; Thu, 09 Oct 2025
 20:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009084416.45542-1-jjm2473@gmail.com> <20251009084416.45542-4-jjm2473@gmail.com>
 <aOe_0EufouURu7R2@shell.armlinux.org.uk>
In-Reply-To: <aOe_0EufouURu7R2@shell.armlinux.org.uk>
From: Liangbin Lian <jjm2473@gmail.com>
Date: Fri, 10 Oct 2025 11:10:14 +0800
X-Gm-Features: AS18NWDTnRTIksFcQ9CLnbgJn8_5OiC5-7_R77k4csy5P5t4wcfC3lX9jt0dZps
Message-ID: <CAP_9mL4PRcYr1o7Vand+wws34GxGBzaVvY2p29Lyrzc13kKvMQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	quentin.schulz@cherry.de, kever.yang@rock-chips.com, naoki@radxa.com, 
	honyuenkwun@gmail.com, inindev@gmail.com, ivan8215145640@gmail.com, 
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org, 
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org, 
	jbx6244@gmail.com, andrew@lunn.ch, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Russell King (Oracle) <linux@armlinux.org.uk> =E4=BA=8E2025=E5=B9=B410=E6=
=9C=889=E6=97=A5=E5=91=A8=E5=9B=9B 21:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 09, 2025 at 04:44:16PM +0800, Liangbin Lian wrote:
> > +&gmac0 {
> > +     phy-mode =3D "rgmii-id";
> > +     clock_in_out =3D "input";
> ...
> > +&gmac1 {
> > +     phy-mode =3D "rgmii-id";
> > +     clock_in_out =3D "input";
>
> I am fine with what is being proposed here, but I think this
> clock_in_out property needs fixing. The description for it is thus:
>
>   clock_in_out:
>     description:
>       For RGMII, it must be "input", means main clock(125MHz)
>       is not sourced from SoC's PLL, but input from PHY.
>       For RMII, "input" means PHY provides the reference clock(50MHz),
>       "output" means GMAC provides the reference clock.
>     $ref: /schemas/types.yaml#/definitions/string
>     enum: [input, output]
>     default: input
>
> The problems that I have here are:
>
> 1) the description states that the only possible value for this when in
>    RGMII mode is "input" which is reasonable, because it's due to the
>    RGMII specification. The driver code is perfectly able to determine
>    whether RGMII has been specified, and set bsp_priv->clock_input
>    itself, relieving DT of this need.
>
> 2) bsp_priv->clock_input is only used in gmac_clk_enable() when calling
>    the SoC specific set_clock_selection() method. Only RK3528, RK3576,
>    and RK3588 populate this method. Every other SoC supported by this
>    driver still requires the property:
>
>         ret =3D of_property_read_string(dev->of_node, "clock_in_out", &st=
rings);
>         if (ret) {
>                 dev_err(dev, "Can not read property: clock_in_out.\n");
>                 bsp_priv->clock_input =3D true;
>         } ...
>
>   If one doesn't provide it, one gets an error print, which is not nice
>   I note that the DT binding doesn't list this property as required, so
>   the code is at odds with the binding.
>
>   (I note that your Rockchip SoC is RK3568, which doesn't implement this
>   method.)
>
> So, taking both these points together, the code should not be printing
> an error if "clock_in_out" is missing when either:
>
> a) RGMII is being used (or maybe only when RMII is being used?)
> b) the set_clock_selection() method is not present for the SoC variant.
>
> With the driver fixed as indicated above, I then think clock_in_out in
> your descriptions becomes unnecessary, and should be removed.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

In fact, deleting {tx|rx}_delay also prints errors,
but it does not affect the function.
I agree that these prints on the driver should be fixed.

