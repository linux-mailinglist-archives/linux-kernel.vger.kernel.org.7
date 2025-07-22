Return-Path: <linux-kernel+bounces-740897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49CB0DAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F073560542
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ABF2EA171;
	Tue, 22 Jul 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="lFSTZNe7"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B42E11BA;
	Tue, 22 Jul 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190901; cv=none; b=l+ZYL/oaABFflwmBHr8mOyZb5e7Bx4HCpO3hF9Lp+Pa/GoKFnXQG0gBiKQeeM19hAVdkMI6VN27OLhZFgiZWoU+Fewe13QBqGn8rW8FgdnczyJ4gP6CV70jWX3sWblYFNYp+bdRtwOyVgASLHUs30mshyMvS64m3TEw2kABcmZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190901; c=relaxed/simple;
	bh=ih6W084s0+qNpeeKlj+/IX2juni66kZK1UPaHdiDB8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4bIynUgcROpjeDEdEbMlVBVD0gLH+kONkBo8ltaLNx86DYY0PIIDgJezbdXws5zTyNsQh5PIx73S+GuAFzl+59uJT07N/HPUHUafP8FLszhNo372f4ulI0X0bt5jfO8j2vklnfhFmgeMtQYxtAiw2UrrcCHAMtBEdIExid2GK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=lFSTZNe7; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id A3396BE3FB;
	Tue, 22 Jul 2025 16:28:07 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 358E5BE3BE;
	Tue, 22 Jul 2025 16:28:06 +0300 (EEST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id C1EE11FD50D;
	Tue, 22 Jul 2025 16:28:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1753190885;
	bh=/wLMAPlnrdxZdacm1RYW8res/EQP52wJ1y7o/GCWAlg=;
	h=Received:From:Subject:To;
	b=lFSTZNe7AQPWxp78HygWg2Zg+p/4WMj2iNtSX4pfpYabSWs3smn/dOzuMjTmU0Or+
	 kjuddqMRsIY/I1cWPmi6RlGZT/wAf6zDI+5NA/3c8zV+CPpQ0C4jCRVMolnpM7OzjB
	 3IaVBN38/0i0P6UQ0CeK9IuJqLcbWA1Yaz7u3iSKWYE7m2P4iixagJhBMuW/6ADqxu
	 l8Lgn+lR0dePMF0FHPR/xMAllKuvWuEO3ejam+gdeovHyXo0tZ3+9nqkmJRDoXAofF
	 bmXA4jICDIObh8BwH4VzmXwUJVuci4Dyu95oQR9Z7drlt1DO+8YMNqhbPl9NS/Ibib
	 HdhyGyn+USxdw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-32b7cf56cacso51405181fa.1;
        Tue, 22 Jul 2025 06:28:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXyZowKgH3p4GQc+wbQ8tcjQI5MHNSnMSX1Ij4NeAMaR8UhvDYUEy8SFcVurRbJwNDF9cFPv/COU7IGf10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcP8Cy7qLPDs+AgkZgZjBopAMpcWD6G5uDoquVZtM25suSpR6
	8Vh7kPPQRlipApixmFMAm6lj0M4F1dAIEbwmCTeFmnwnUAo/t9mGXGlWmwqkpqBq9JultgMxhZc
	NkIlpJ9bfSDReyT/CSH1/BdR2AG751Yw=
X-Google-Smtp-Source: 
 AGHT+IFiW6yJ1+5zJBmeLLHTkCBQQxIBXxImMX8vGF0PUHqVxXdsAFdOYfl24Mvk2wS+mQRpPCpMEgyimDei4lkeZrg=
X-Received: by 2002:a05:651c:1505:b0:32a:6312:bfc6 with SMTP id
 38308e7fff4ca-3308e58cb51mr82492481fa.35.1753190885323; Tue, 22 Jul 2025
 06:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718163305.159232-1-lkml@antheas.dev>
 <710baf02-fc18-6752-b8bd-bbf1354227e8@linux.intel.com>
In-Reply-To: <710baf02-fc18-6752-b8bd-bbf1354227e8@linux.intel.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 22 Jul 2025 15:27:53 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFvWuXM_oSzY9S+2CdW+dHiusuYra6kJeA+Vo00NZFb4g@mail.gmail.com>
X-Gm-Features: Ac12FXzPLXSU0G-YWITT4Wv5JVvws76F8drbvzJkJj_rVguY7w3qSuti0otwOys
Message-ID: 
 <CAGwozwFvWuXM_oSzY9S+2CdW+dHiusuYra6kJeA+Vo00NZFb4g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] platform/x86: oxpec: Fix turbo register for G1 AMD
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>, Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <175319088594.299230.17518193628529675272@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.0.9 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 22 Jul 2025 at 15:22, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 18 Jul 2025, Antheas Kapenekakis wrote:
>
> > Turns out that the AMD variant of the G1 uses different turbo registers
> > than the Intel variant. Differentiate them and apply the correct ones
> > to the AMD variant.
> >
> > Fixes: b369395c895b ("platform/x86: oxpec: Add support for the OneXPlay=
er G1")
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/platform/x86/oxpec.c | 37 +++++++++++++++++++++++-------------
> >  1 file changed, 24 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.=
c
> > index 06759036945d..9839e8cb82ce 100644
> > --- a/drivers/platform/x86/oxpec.c
> > +++ b/drivers/platform/x86/oxpec.c
> > @@ -58,7 +58,8 @@ enum oxp_board {
> >       oxp_mini_amd_a07,
> >       oxp_mini_amd_pro,
> >       oxp_x1,
> > -     oxp_g1,
> > +     oxp_g1_i,
> > +     oxp_g1_a,
> >  };
> >
> >  static enum oxp_board board;
> > @@ -247,14 +248,14 @@ static const struct dmi_system_id dmi_table[] =3D=
 {
> >                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> >                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER G1 A"=
),
> >               },
> > -             .driver_data =3D (void *)oxp_g1,
> > +             .driver_data =3D (void *)oxp_g1_a,
> >       },
> >       {
> >               .matches =3D {
> >                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> >                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER G1 i"=
),
> >               },
> > -             .driver_data =3D (void *)oxp_g1,
> > +             .driver_data =3D (void *)oxp_g1_i,
> >       },
> >       {
> >               .matches =3D {
>
>
> > -     case oxp_g1:
> > +     case oxp_g1_i:
> >               return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
> > @@ -757,6 +765,7 @@ static int oxp_pwm_fan_speed(long *val)
> > +     case oxp_g1_a:
> >               return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
>
> > -     case oxp_g1:
> > +     case oxp_g1_i:
> >               /* scale to range [0-184] */
> >               val =3D (val * 184) / 255;
> >               return write_to_ec(OXP_SENSOR_PWM_REG, val);
> > @@ -796,6 +805,7 @@ static int oxp_pwm_input_write(long val)
> > +     case oxp_g1_a:
> >               return write_to_ec(OXP_SENSOR_PWM_REG, val);
> > @@ -816,7 +826,7 @@ static int oxp_pwm_input_read(long *val)
> > -     case oxp_g1:
> > +     case oxp_g1_i:
> >               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> > @@ -842,6 +852,7 @@ static int oxp_pwm_input_read(long *val)
> > +     case oxp_g1_a:
> >       default:
> >               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
>
> Do these FAN and PWM registers fall under what is described in the
> changelog as "turbo registers"? Or did you extend the scope of this patch
> and forgot to update the changelog?

Yes. Perhaps its not the best wording and it should have said EC registers.

Antheas

>
> --
>  i.
>
>


