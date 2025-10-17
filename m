Return-Path: <linux-kernel+bounces-858451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E5BEAF33
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD3C947C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164B2BE04C;
	Fri, 17 Oct 2025 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcrtRK6w"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D829A9C9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718548; cv=none; b=kr6OuR4vTPdY/PQnNHTXTSTdE7mjHGaOypBxPd0QnoFlD/MBHJTcDWimvjD4xAa2RRtE49LYX5kEasCTYZ9/s+OK3iIQuvSSlFvyvOtc8q3qSXUx3f16uVjKxv743XpvHc3UnRyWKkIJlkYq9XCRzg4jXWM3gi29jKtM/dGS6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718548; c=relaxed/simple;
	bh=yEacwEfMwbmHYq38jVAByL/81V0BvkN0d9vmDB2lRfc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nB4lhec1A/COKJc6BH6XIHE3VvDhzoeTWHVzX6Y7aMC/2XBnzu87+SMYDNfy0UOVyOmSgjOB0wcc6/+YFWgJb7uufzYEsLAaq9YTSwZ9BnbWcWGh+bxmg+osTtnL5xauwrKYFXbIrQCmRzBKJpeZukkq8Jv/j0hg3wvsZUqywNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcrtRK6w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso15998405e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760718542; x=1761323342; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e+3TGUDzD/qAyFWP9lnrWAHSPYDqqbyBteI4cDb1byY=;
        b=IcrtRK6wU8V3tHklKg8BVdjCQddjC0gmpo0XJoIx4Y+pbNYh4gat2lgjsxeE0yvq2H
         Ul2htKaNWBYwemv1Eygp3q/DxcDsE4T+v0fBOSDMDL4/wAHGZla5rTR7WeFu7ZpABg+j
         6C9bu/uvlCo5rhxFHjoqAuZNI7TtolVgajz7wQNANKBJQv0uPKXTClcguy6SjY/N9PJi
         cqDVpw9q46Ftd4SiOKFnySM6VnZQ4gspv9PScfZScGMysB4VPCkSYHML5UvH4KKxOK2A
         WXhemg1pu+iscJIu0ozi5uEB8FliQcse+Gqqi5ey0nv4WThli0UJxYFJHWVQBdp73/wo
         PooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718542; x=1761323342;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+3TGUDzD/qAyFWP9lnrWAHSPYDqqbyBteI4cDb1byY=;
        b=M5bbJB6IBc48w2+5W3QATvLxZUQSfCUkY9o1Uv86lmeemLX36hMalCApteaXWVzCMo
         7N5EIY+TpAalNfVQx++bJZ3BWt3FGFokXKoorjXK2dzVVEuApgi6l1//ODQ6nJQy13fh
         bL8fk+Tw+EzPFaysZaR7ad78idMJ6aLRmqsqK3KQJPs7ktfP7hreSvx6u6d/ExBIpEZn
         6rLQ4ahjM+lw+E6GiW5H09cseak8iz9DPaRF1BnMIx8shrump8e51LLsl2ofgNj2UcaJ
         +j3MtdkfL0St2UbaXRj7Vs4F/VELefcEdo9U0sJw9sAFGb6w/4dNHu31DG8nTI/+m5hf
         k+mg==
X-Forwarded-Encrypted: i=1; AJvYcCXDvj7JTHEtvKRd028OQHWU0yPzJYX2Gvylmgi/Zyj13NAuPIBS/0cHa9jLFhcuc5xlPjcjHnZGxC+U08Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBfy29HHlRk6gpE9tbn6TMPnXEyVWm5QauxzkNhbRj4y1C5R3
	tYi3vkyb7upizNw4Kv0mJwWLjKFrJLcAo9WccQGyHgZcCFw9cW7hm/k8
X-Gm-Gg: ASbGncvFWW8bqWyDIsaBG0be2BYL0wRAD6Xfv/45yueEdVAOwDR3GFxZDJ0gRydy65u
	NejgZs/jzYn1FrMdqBLB4ryXDLDKqH9YJJkJFigjz6caa8bHHsYl3xjnh4qhJ/CdZQadYYrBiNb
	xVKkuKWBskgrP3rkAxP/Xhuno+qSPChyXB63lAbeiKFAYIMXns6Nii+qxjXIFl8s01k31s2Xgqj
	BAFB77SdtcXq4KpUPVk/mtz7tMaoqhk3gyijWtYcKykcWhOxHrhLQ+evNi+P3s7NDZVbTLSzsKR
	NhHKSyTQGH1knBLoumyAUHBid5H9bBuLIH3X+J3bsKzxNAUmt9x08suV//L4+2sCZw6xLPYwXdx
	fi2GEW9PKHUivL1t9orpeIgwTvnSqdGqKccodXxga/+z22EEUa2DjZWfpZ2nb6BnSUz2/VZiZXe
	Ez0hhrxABF
X-Google-Smtp-Source: AGHT+IG5OKG+QrsjrH3z6FdMIuRoh2OBw5hKsfK6m8d77lQkl/Z16nX3GNAwzHu4tF5ikt9sqtVHiA==
X-Received: by 2002:a05:6000:2584:b0:3e7:63dc:1ff6 with SMTP id ffacd0b85a97d-42704d7eb9emr2630461f8f.8.1760718542320;
        Fri, 17 Oct 2025 09:29:02 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm89738f8f.19.2025.10.17.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:29:01 -0700 (PDT)
Message-ID: <f73f73e6b2aae53fa6bdae7c9d2970ba1caed7e5.camel@gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown	
 <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Date: Fri, 17 Oct 2025 17:29:34 +0100
In-Reply-To: <20251017174322.07997789@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
		<20251015142816.1274605-3-herve.codina@bootlin.com>
		<1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
		<20251015211420.031c61fa@bootlin.com>
		<de57f5274b2fe0aac3621dc10cb6d4d0d98d3063.camel@gmail.com>
		<20251016160202.3d4d0a5e@bootlin.com>
		<d7576a0bb9a8d5326d77ae434131540b4359bd2a.camel@gmail.com>
		<20251017085904.07e40e37@bootlin.com>
		<10e119ee5a76f1c47d7eb6a15989c8ffc00ffc5f.camel@gmail.com>
	 <20251017174322.07997789@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 17:43 +0200, Herve Codina wrote:
> I Nuno,
>=20
> On Fri, 17 Oct 2025 09:26:26 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Fri, 2025-10-17 at 08:59 +0200, Herve Codina wrote:
> > > Hi Nuno,
> > >=20
> > > On Thu, 16 Oct 2025 16:26:28 +0100
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > >=20
> > > ...
> > >=20
> > > ...=C2=A0=20
> > > > > > > > > +
> > > > > > > > > +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc,
> > > > > > > > > &rzn1_adc-
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > adc_core[0],=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > +					=C2=A0=C2=A0 "adc1-avdd",
> > > > > > > > > "adc1-
> > > > > > > > > vref");
> > > > > > > > > +	if (ret)
> > > > > > > > > +		return ret;
> > > > > > > > > +
> > > > > > > > > +	ret =3D rzn1_adc_core_get_regulators(rzn1_adc,
> > > > > > > > > &rzn1_adc-
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > adc_core[1],=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > +					=C2=A0=C2=A0 "adc2-avdd",
> > > > > > > > > "adc2-
> > > > > > > > > vref");
> > > > > > > > > +	if (ret)
> > > > > > > > > +		return ret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > > > > > >=20
> > > > > > > > Hmm, is avdd really an optional regulator? I mean can the A=
DC
> > > > > > > > power
> > > > > > > > up
> > > > > > > > at
> > > > > > > > all
> > > > > > > > without a supply in AVDD? Even vref seems to be mandatory a=
s we
> > > > > > > > can't
> > > > > > > > properly
> > > > > > > > scale the sample without it.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > > > > >=20
> > > > > > > Where do you see that avdd is an optional regulator?=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > You are using devm_regulator_get_optional(). That's for optiona=
l
> > > > > > regulators.
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > Indeed I use devm_regulator_get_optional().
> > > > >=20
> > > > > We have two similar function to get regulators:
> > > > > - devm_regulator_get() and
> > > > > - devm_regulator_get_optional().
> > > > >=20
> > > > > devm_regulator_get() returns a dummy regulator if the regulator i=
s not
> > > > > described in the device-tree. The calling code has no way to know=
n if
> > > > > the regulator was present or not.=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Yeah because it's mandatory and the part cannot work without power =
:).
> > > > So we
> > > > should not be allowed to operate without a regulator.
> > > > =C2=A0=20
> > > > >=20
> > > > > On the other hand, devm_regulator_get_optional() returns -ENODEV =
when
> > > > > the
> > > > > regulator is not described.
> > > > >=20
> > > > > That's pretty confusing but it is the reality.
> > > > >=20
> > > > > I use devm_regulator_get_optional() but check for -ENODEV to see =
if
> > > > > the
> > > > > regulator is provided or not.
> > > > >=20
> > > > > In order to use the ADC core (is_used flag), I need both the AVDD=
 and
> > > > > the
> > > > > VREF regulator available.=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > And that is why I don't get why are we allowed to proceed if there'=
s no
> > > > regulators? That seems wrong to me.=C2=A0
> > > >=20
> > > > So I think the regulators should be mandatory in the bindings and a
> > > > dummy
> > > > regulator should also not be allowed in this case because that shou=
ld
> > > > get
> > > > you=C2=A0
> > > > -EINVAL when calling regulator_get_voltage().
> > > > =C2=A0=20
> > >=20
> > > I have 4 regulators: avdd1, vref1, avvd2, vref2.
> > >=20
> > > The ADC controller can work with 2 internal ADC core (adc_core[0] and
> > > adc_core[1])
> > > in the driver. Those internal core are not directly accessed by the
> > > driver.
> > > Only
> > > the ADC controller is accesses.
> > >=20
> > > Those cores have an AVDD and a VREF power supply.
> > >=20
> > > We can use either adc_core[0] only, adc_core[1] only or both adc core=
s.
> > >=20
> > > Depending on regulator described, the driver uses one or two adc core=
s.
> > >=20
> > > This choice is done by:
> > > --- 8< ---
> > > static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
> > > 					 struct iio_dev *indio_dev)
> > > {
> > > 	int adc_used;
> > >=20
> > > 	adc_used =3D rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
> > > 	adc_used |=3D rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
> > >=20
> > > 	switch (adc_used) {
> > > 	case 0x01:
> > > 		indio_dev->channels =3D rzn1_adc1_channels;
> > > 		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc1_channels);
> > > 		return 0;
> > > 	case 0x02:
> > > 		indio_dev->channels =3D rzn1_adc2_channels;
> > > 		indio_dev->num_channels =3D ARRAY_SIZE(rzn1_adc2_channels);
> > > 		return 0;
> > > 	case 0x03:
> > > 		indio_dev->channels =3D rzn1_adc1_adc2_channels;
> > > 		indio_dev->num_channels =3D
> > > ARRAY_SIZE(rzn1_adc1_adc2_channels);
> > > 		return 0;
> > > 	default:
> > > 		break;
> > > 	}
> > > --- 8< ---
> > >=20
> > > In rzn1_adc_core_get_regulators(), looking at one core I do the
> > > following:
> > > =C2=A0- Try to get AVDD (using get_optional)
> > > =C2=A0- Try to get VREF (using get_optional)
> > > =C2=A0- Core is used only if both regulators are present.
> > >=20
> > > For one core to be used, both regulators have to be present.
> > >=20
> > > Regulators are mandatory but adc core usage is optional.
> > >=20
> > > This optional usage depends on related regulator presence.
> > > =C2=A0=20
> >=20
> > Ok, then we could flip the logic and have boolean properties for the ad=
c
> > core
> > usage and depending on that, requesting the regulators. To me, the inte=
nt
> > would
> > be more clear (at the expense of more FW properties).
>=20
> This introduces a new property and duplicates the information:
> - flag to tell if adc core is used
> - regulators described only if used
>=20
> And so, the possible flag set to "adc core used" but regulators not
> described. This is error prone.
>=20
>=20
> I have chosen to rely only on regulators description to avoid the
> information redundancy.
> =C2=A0 - regulators described -> adc core used
> =C2=A0 - regulators not described -> adc core not used

I'll leave it up to you but while I know it introduces new properties, you =
could
still do it in a way that minimizes errors:

 - In the bindings, if the property is set, then the regulators are a
__required__;
 - In the driver, if the boolean is true, then use devm_regulator_get()

- Nuno S=C3=A1


