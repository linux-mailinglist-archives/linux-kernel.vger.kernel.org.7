Return-Path: <linux-kernel+bounces-842028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497DBB8CE9
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 13:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFF674E5208
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353E626CE05;
	Sat,  4 Oct 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZtQZYCt"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C892580DE
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759578117; cv=none; b=KrWXsqp6BzCjSLfUKNhGSJ/fiyzoDa5JAYz8iVZsjCIZy51FtUUp37vI/YQvMvtoSw2/fRYpQQEZLATlrr2GI6LRXaJiC+gA01Z1DW0JaJeJggUbDtxOrHHQS0Vjn4HOr377ozu25elUtDbRIIbaFUtIPXdsNVOzu3DUGAVlHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759578117; c=relaxed/simple;
	bh=fIv6+iNPwuIXIA9bqyP1R0SZQuMQXSRAy6Am2xHkuh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWBX9HysI1VBYPuy2AlHXkYuzxznvgQzc2i0Py0mDXCP1+W2OmRMRSQ/mIg8xv6LvKKQyWRaSJjXZxFQcrqqmb04OcRoMMEhfgxppX8EBDQMhnI1jerzB8/qTs67BepFnztJ4abxldkhrU1l1qyfEyXfdKumDI42rBVrP9idGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZtQZYCt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109c6b9fcso33307361cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759578114; x=1760182914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpR+xC9UI9aVYPaJ+/mAuENyABy3uI8m/ggwA2QkJpA=;
        b=LZtQZYCtEoqbcvWgc7ljR3eQc4vZ2wavCYcrXFPYCiDg7mjtcTcow+Qo5Is7PA3qqN
         bFl42w9O6fT/sS1g+aRRjvUf7MRmes5ZXIsvaLvvZhwBpUgHuTY2rohv9lBrwVOYjcas
         ztG8PoJXz7QurVtet/1Z+SYKvwCqboeEDC93J5JoyW602V9bIZm6fHc1kQjCfpB0Lu2J
         Aq9pl3NLCJT37k2QWM3zTNRXY5IoAaqbPVgb1+vt9FXRN+YHVDS7P/PD6Il6i5SGtJut
         /EzEyikba+ZI3WMFtDO0ZYucEbBpFZecrfg+COd4cDmX51LcQqiWxDdvyxKSgVe97fxw
         kLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759578114; x=1760182914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpR+xC9UI9aVYPaJ+/mAuENyABy3uI8m/ggwA2QkJpA=;
        b=QRP/E69ONNxwch7uIHrkB7+yxNO78G1z1zchVpBFx+CJmSmenLjVbAyphQbtaWl/la
         0dotC0Xxy9E+QrG7tBG7Bu5m6XEmKZaq2ygSCSVQGP4g16emg1xflMDID9ijN6f3RWqp
         XW1+eP3N1XAarY8Ui6bykcqzuVaCpaqq2kgnSpyDVz7VsIzzyFrztxkSdo6Nkxlmwv6v
         9ktCuA3ieZG6hG1d6OzpTJxxEZPGeiMBOGCgCuuRZ8zU3ylv8cm0QIuqFW9hkrHa+gBW
         E17axxYvUHdTfpX99ppcFGroV32fwsIY4d4oycuyF4yMxbTgy+ldW9Ux9/kozj/uJNRI
         /K7A==
X-Forwarded-Encrypted: i=1; AJvYcCWrkImP5ZWqMbY+tHjdCRQ8HAGPQ3DCs11QInj9DdGJyRii2TSTtexRUzGU0EnggKROWztUMtBCyQGa60A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3IYrnMYHjBNJOgrIiZyvFT4til2HHvy5xpqvNGiNapQ+z03Ok
	SdoCL+OLczVX9+7zo4FoAgo6IUWkp4u2RqN+pYbsmSGqZ32O6MKO8EBK7jOXpp0Szbv/hVlXJ/V
	w4YjUXqdgqCZEfmO1R8qIoGfa649uksp7Zmf+D4idcg==
X-Gm-Gg: ASbGnctJKqQXm02ochLJJ9kZ7WrjS/BS1Ijl7/pAoM0S7rw/WyR46F/KX6NLpmMV1a+
	uYTEqkPeGlPsZpiTx7AA9yKj14cbgYiKQLEAtlpxg8rOt4kMg7Xel8K+jBOUlOQWOsRDtD4jEOp
	H4740HOZBtl7VUuxuyi9jAdzfcLsVFUOJO3ssralI/UuE42ezwevblqSwkdo8SzI/UPcgnJfaZg
	SlQweSwwwHMXpVcafJvn67TMxkpOXWH0w==
X-Google-Smtp-Source: AGHT+IEiCgoQUtulfjfbUZqNJXGTIrrJgjtpSpNPgwEgXUAG2pMT/f/hMciGbXI2869MDPsj8X8CukNldkZDB51bknk=
X-Received: by 2002:ac8:5e4e:0:b0:4e3:16bd:3e16 with SMTP id
 d75a77b69052e-4e576b06dc6mr76789121cf.56.1759578114196; Sat, 04 Oct 2025
 04:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124052611.3705-1-eagle.alexander923@gmail.com>
 <CABjd4YwA8P9LVuDviO6xydkHpuuOY7XT0pk1oa+FDqOo=uZN4A@mail.gmail.com>
 <a76f315f023a3f8f5435e0681119b4eb@manjaro.org> <CABjd4Ywh_AkbXHonx-8vL-hNY5LMLJge5e4oqxvUG+qe6OF-Og@mail.gmail.com>
 <61b494b209d7360d0f36adbf6d5443a4@manjaro.org> <CABjd4Yx0p0B=e00MjCpDDq8Z=0FtM0s9EN86WdvRimt-_+kh2w@mail.gmail.com>
 <CABjd4Yy14bpjzvFyc8et-=pmds5uwzfxNqcs7L=+XRXBogZEsQ@mail.gmail.com>
 <20251003133304.GA21023@pendragon.ideasonboard.com> <CABjd4YxbyUWghd1ya8UayFkAE-VWQSd5-J2QD0sV7WmS8AXkCg@mail.gmail.com>
 <CABjd4YwtwUYFX4bX5vy=AFi=Dn1r6nxWtMvmeKBSjkvriNJtsQ@mail.gmail.com> <20251003232856.GC1492@pendragon.ideasonboard.com>
In-Reply-To: <20251003232856.GC1492@pendragon.ideasonboard.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Sat, 4 Oct 2025 15:41:41 +0400
X-Gm-Features: AS18NWD5l826BtvjlGeJjlKkvc2YdZS_POG-dgOrknV-XIqi7CLGxEQUrunvhfM
Message-ID: <CABjd4Yx9rt2W=MhCSyO5vaxndD1jvGHNWsz7J=HnvnJcgOvQHw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding
 for rk3588
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Alexander Shiyan <eagle.alexander923@gmail.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	devicetree@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 3:29=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Alexey,
>
> On Fri, Oct 03, 2025 at 06:55:26PM +0400, Alexey Charkov wrote:
> > On Fri, Oct 3, 2025 at 6:13=E2=80=AFPM Alexey Charkov wrote:
> > > On Fri, Oct 3, 2025 at 5:33=E2=80=AFPM Laurent Pinchart wrote:
> > > > On Fri, Jan 24, 2025 at 11:44:34PM +0400, Alexey Charkov wrote:
> > > > > On Fri, Jan 24, 2025 at 9:23=E2=80=AFPM Alexey Charkov <alchark@g=
mail.com> wrote:
> > > > > > On Fri, Jan 24, 2025 at 2:37=E2=80=AFPM Dragan Simic <dsimic@ma=
njaro.org> wrote:
> > > > > > > On 2025-01-24 11:25, Alexey Charkov wrote:
> > > > > > > > On Fri, Jan 24, 2025 at 2:06=E2=80=AFPM Dragan Simic <dsimi=
c@manjaro.org>
> > > > > > > > wrote:
> > > > > > > >> On 2025-01-24 09:33, Alexey Charkov wrote:
> > > > > > > >> > On Fri, Jan 24, 2025 at 9:26=E2=80=AFAM Alexander Shiyan
> > > > > > > >> > <eagle.alexander923@gmail.com> wrote:
> > > > > > > >> >>
> > > > > > > >> >> There is no pinctrl "gpio" and "otpout" (probably desig=
ned as
> > > > > > > >> >> "output")
> > > > > > > >> >> handling in the tsadc driver.
> > > > > > > >> >> Let's use proper binding "default" and "sleep".
> > > > > > > >> >
> > > > > > > >> > This looks reasonable, however I've tried it on my Radxa=
 Rock 5C and
> > > > > > > >> > the driver still doesn't claim GPIO0 RK_PA1 even with th=
is change. As
> > > > > > > >> > a result, a simulated thermal runaway condition (I've ch=
anged the
> > > > > > > >> > tshut temperature to 65000 and tshut mode to 1) doesn't =
trigger a PMIC
> > > > > > > >> > reset, even though a direct `gpioset 0 1=3D0` does.
> > > > > > > >> >
> > > > > > > >> > Are any additional changes needed to the driver itself?
> > > > > > > >>
> > > > > > > >> I've been digging through this patch the whole TSADC/OTP t=
hing in the
> > > > > > > >> last couple of hours, and AFAIK some parts of the upstream=
 driver are
> > > > > > > >> still missing, in comparison with the downstream driver.
> > > > > > > >>
> > > > > > > >> I've got some small suggestions for the patch itself, but =
the issue
> > > > > > > >> you observed is obviously of higher priority, and I've sin=
gled it out
> > > > > > > >> as well while digging through the code.
> > > > > > > >>
> > > > > > > >> Could you, please, try the patch below quickly, to see is =
it going to
> > > > > > > >> fix the issue you observed?  I've got some "IRL stuff" to =
take care of
> > > > > > > >> today, so I can't test it myself, and it would be great to=
 know is it
> > > > > > > >> the right path to the proper fix.
> > > > > > > >>
> > > > > > > >> diff --git i/drivers/thermal/rockchip_thermal.c
> > > > > > > >> w/drivers/thermal/rockchip_thermal.c
> > > > > > > >> index f551df48eef9..62f0e14a8d98 100644
> > > > > > > >> --- i/drivers/thermal/rockchip_thermal.c
> > > > > > > >> +++ w/drivers/thermal/rockchip_thermal.c
> > > > > > > >> @@ -1568,6 +1568,11 @@ static int rockchip_thermal_probe(s=
truct
> > > > > > > >> platform_device *pdev)
> > > > > > > >>          thermal->chip->initialize(thermal->grf, thermal->=
regs,
> > > > > > > >>                                    thermal->tshut_polarity=
);
> > > > > > > >>
> > > > > > > >> +       if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
> > > > > > > >> +               pinctrl_select_default_state(dev);
> > > > > > > >> +       else
> > > > > > > >> +               pinctrl_select_sleep_state(dev);
> > > > > > > >
> > > > > > > > I believe no 'else' block is needed here, because if tshut_=
mode is not
> > > > > > > > TSHUT_MODE_GPIO then the TSADC doesn't use this pin at all,=
 so there's
> > > > > > > > no reason for the driver to mess with its pinctrl state. I'=
d rather
> > > > > > > > put a mirroring block to put the pin back to its 'sleep' st=
ate in the
> > > > > > > > removal function for the TSHUT_MODE_GPIO case.
> > > > > > >
> > > > > > > You're right, but the "else block" is what the downstream dri=
ver does,
> > > > > >
> > > > > > Does it though? It only handles the TSHUT_MODE_GPIO case as far=
 as I
> > > > > > can tell (or TSHUT_MODE_OTP in downstream driver lingo) [1]
> > > > > >
> > > > > > [1] https://github.com/radxa/kernel/blob/edb3eeeaa4643ecac6f418=
5d6d391c574735fca1/drivers/thermal/rockchip_thermal.c#L2564
> > > > > >
> > > > > > > so I think it's better to simply stay on the safe side and fo=
llow that
> > > > > > > logic in the upstream driver.  Is it really needed?  Perhaps =
not, but
> > > > > > > it also shouldn't hurt.
> > > > > > >
> > > > > > > > Will try and revert.
> > > > > > >
> > > > > > > Awesome, thanks!
> > > > > > >
> > > > > > > > P.S. Just looked at the downstream driver, and it actually =
calls
> > > > > > > > TSHUT_MODE_GPIO TSHUT_MODE_OTP instead, so it seems that "o=
tpout" was
> > > > > > > > not a typo in the first place. So maybe the right approach =
here is not
> > > > > > > > to change the device tree but rather fix the "gpio" / "otpo=
ut" pinctrl
> > > > > > > > state handling in the driver.
> > > > > > >
> > > > > > > Indeed, "otpout" wasn't a typo, and I've already addressed th=
at in my
> > > > > > > comments to Alexander's patch.  Will send that response a bit=
 later.
> > > > > > >
> > > > > > > I think it's actually better to accept the approach in Alexan=
der's
> > > > > > > patch, because the whole thing applies to other Rockchip SoCs=
 as well,
> > > > > > > not just to the RK3588(S).
> > > > > >
> > > > > > Anyway, I've just tried it after including the changes below, a=
nd
> > > > > > while /sys/kernel/debug/pinctrl/pinctrl-handles shows the expec=
ted
> > > > > > pinctrls under tsadc, the driver still doesn't seem to be trigg=
ering a
> > > > > > PMIC reset. Weird. Any thoughts welcome.
> > > > >
> > > > > I found the culprit. "otpout" (or "default" if we follow Alexande=
r's
> > > > > suggested approach) pinctrl state should refer to the &tsadc_shut=
_org
> > > > > config instead of &tsadc_shut - then the PMIC reset works.
> > > >
> > > > I've recently brought up an RK3588S-based Orange Pi CM5 Base board,=
 made
> > > > of a compute module (CM5, see [1]) and a carrier board (Base, see [=
2]).
> > > > The carrier board has a reset button which pulls the PMIC_RESET_L s=
ignal
> > > > of the CM5 to GND (see page 3 of the schematics in [3]).
> > > >
> > > > With &tsadc_shut_org the reset button has absolutely no effect. Wit=
h
> > > > &tsadc_shut it resets the board as expected.
> > >
> > > Interesting. The TSADC shouldn't affect the physical button operation
> > > at all, if it's really wired to the PMIC as the signal name implies.
> > > There isn't even any default pull value associated with the TSHUT pin
> > > config.
> >
> > On a second thought, I've got another hypothesis. Your baseboard only
> > pulls the reset line through  a 100 Ohm resistor when the button is
> > pressed. So if the TSHUT pin is in its default push-pull mode and
> > stays high when no thermal runaway reset is requested, the reset
> > button won't pull the line fully to zero, as the TSHUT line pulls it
> > high at the same time.
>
> That's the most likely cause, I agree.
>
> > If you switch it from &tsadc_shut_org to &tsadc_shut, then it stops
> > working properly as the thermal protection reset, and GPIO0_A1 remains
> > high-impendance, thus allowing the reset button to function even
> > though its pull is too weak.
>
> By the way, what is the difference between tsadc_shut_org and tsadc_shut
> ? I haven't seen it being clearly documented in the TRM.

No idea frankly. Looks like a half-finished design change to me, which
left the non-"org" version unconnected internally.

> > So maybe change the pin configuration of &tsadc_shut_org in
> > rk3588-base-pinctrl.dtsi to open drain and retry?
>
> That's a good idea, but... how ? The pinctrl-rockchip driver doesn't
> seem to support generic open-drain configuration.

I thought I saw open-drain configurations here, but after reviewing
the TRM, bindings and the driver it turns out I must have been
daydreaming :( Sorry.

Looks like the best we can try is a lower drive strength while keeping
the push-pull mode, but I'm afraid this 100 Ohm pulldown is too weak,
because the lowest TSHUT drive strength Rockchip offers is 100 Ohm,
while the PMIC would only count anything below 30% reference voltage
as logical low. Maybe adding a pulldown to the pin config can help,
but most likely this board will require switching the pin to GPIO
input for high-z, and switching the TSHUT mode to CRU.

So how about something like this first:

&tsadc_shut_org {
        rockchip,pins =3D <0 RK_PA1 1 &pcfg_pull_down_drv_level_0>;
};

Best regards,
Alexey

