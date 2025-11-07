Return-Path: <linux-kernel+bounces-890773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31564C40E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD59D188E449
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFCE3314CE;
	Fri,  7 Nov 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="wtRUIK3E"
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE3328B73
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533192; cv=none; b=lcF+9yGhWZrz3JVN4fZ5mTUUrk6vwk2CvkxGLcEEZJbZfAqBECcfa1H25KNWa/JnBgNvmber4fU9G4tOVm1wJyF9JeDaRj1m37HShraGUqckIsvnKymIBkZhN2qn/0b7vpeou/2tnQG5RWqPXj/SzlnlYs4tmTSR43opOI+7x00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533192; c=relaxed/simple;
	bh=AWo05EnOi9/03+u8bn3n24GhXxRQ4Bgj2L49SL9N0ZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+ODdc+d8hQ8fMUPandawBN4CUVrRjhIB2Hx+L7/+UM5ZmlwxSMeXc5KyIZNe66vovXNrFXnoVsHdiaFlokijRp5knETRkvew+DBF0XeYPgyw/qBHECueavpvUfaTijMIBsWUcT79iP0fWmZVNUTCj61rOWhkeAHZcd792RONPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=wtRUIK3E; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8801e4da400so9931136d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1762533190; x=1763137990; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AWo05EnOi9/03+u8bn3n24GhXxRQ4Bgj2L49SL9N0ZI=;
        b=wtRUIK3ECnykdwiZ+BsiN2T5s4GKbBsQ0UsjGHoaIqf9C3pVfabgn56c2m4tSwj+0v
         /6mxKdUHA9riy/D8Rcgd1bmarXbmYfgbdcQvTSCLJazTQ9x6tLbQdLabLgjMu0mj+tSS
         AaPjhBoF0tvCAmt/cPE+JHvcbCoPz+xfCO0R8sw1kdOJ1/kgwI8ZjUWj3avy+RMBO9jm
         6f63UzxrNiCrGRGHHzKd32A2UkehecqNnO2VstdHyjWU7f6rWKst9RuIfffuK7hNKFOW
         n8rKeMkxXi3YYmp2yzqauzIn7PCRGg6hV0gtYq1tZp0rNDwqLIRxUBkNI4CrbdelkV17
         pxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762533190; x=1763137990;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AWo05EnOi9/03+u8bn3n24GhXxRQ4Bgj2L49SL9N0ZI=;
        b=cbpH/oaWSj1v3tqckTwLGtjkDZ4Um9bHxRNXj4IbTsaYF29CAEHY3ZhKPBSlfjk3tB
         ABfX9C4Q7VVCjKjvbs6JYj9xIz00HteaXO0oVM6SqUuEOwctjugcq2kBy3Th8GH0UsNz
         GU3weDcKCN8KSpdPHq/5FucoNtNAritAnOLjZ/+fNXzQBppgrPlWF3K/+pc5V3U4IWzv
         rLXa9MW7AOl+1VCSOPugpa+ySOdx8DifjOfh0ZdlxcYx92WksNon5jcGZVfBZCD3q7Gd
         0UZaFST5pHI9akP1WNa+2vYFCi7Qk4JxjCFtvQsRWvdMee82kwnW2hiFjrD6555naXEt
         heDg==
X-Forwarded-Encrypted: i=1; AJvYcCU0BAPaLkBtohrzugvllsfGQbyq+H3HK3hBEQI4ynYZhwJnumSic9Eg+qwWlsulgnYeV9ua7FiZKkXfh9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mWnr9upEXc2xz48AiCPlmAE4FhUeAARB2S0piM/vjpbwbuRN
	U6D4LVsRQcj1ZZnAZJcMDFKyMfpdFlQ3tldONKRX4n1yNZycJRfikVieKZ+gB6FOQUc=
X-Gm-Gg: ASbGncs8TPg/+DxK1kTzo5qXgMN6RfjM3BB25l8rPCkQAC/i0ApB5UvNESOsn1hUb4P
	icnNaFY5qLIOt54ZCcaQ7WLbjHtM3M5aIWv+zcaoB403wjQoKjQ90EoSqiiRNDaRnBSGi8lRZ3/
	m0ChpwYPIpub7jkBMiVcSw0qSSWT8+qRKNq6bfFPYpDFi5RC4qpz8AP2Tuq5KlFpcUKFP4ixeM4
	FIV+8si5Uil7U/tvYD2cfSQQ9/rZKzoIb5Ts83QIQtTOb3CH1TFojzIe1ykdCMlzMnhlpyJ7PK0
	bYCE2GM6GxJEnPwxclU5BnFMoe3xyLh6xWjxZcjaK1TWit7RRR662TkO7iHYWifQYqMF3+61Ry3
	tl+lSINICozr5PiruwJyVPWsBrSMWOwKEl38SfhyM2a462lHXZ4i0hAqxoVKvilLOVln08UJfj7
	vOQcCXVQ==
X-Google-Smtp-Source: AGHT+IFsPMhSdrmOZ6ahN3sPxnvKd643mstGo618XCLtPRJlduqW3IJUvEqzr1ydUpduU0yqXdCstw==
X-Received: by 2002:a05:6214:482:b0:87c:2024:4d5c with SMTP id 6a1803df08f44-881767a96ccmr45493816d6.35.1762533189704;
        Fri, 07 Nov 2025 08:33:09 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ef24::c41? ([2606:6d00:11:ef24::c41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828f4192sm43277236d6.14.2025.11.07.08.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:33:08 -0800 (PST)
Message-ID: <4cbd47f8211e3e1a038857f848ad4197d95bd31c.camel@ndufresne.ca>
Subject: Re: [PATCH v4 3/5] dt-bindings: media: Add the Raspberry Pi HEVC
 decoder
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, John Cox
 <john.cox@raspberrypi.com>,  Dom Cobley <dom@raspberrypi.com>, review list
 <kernel-list@raspberrypi.com>, Ezequiel Garcia	
 <ezequiel@vanguardiasur.com.ar>
Cc: John Cox <jc@kynesim.co.uk>, Stefan Wahren <wahrenst@gmx.net>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Nov 2025 11:33:07 -0500
In-Reply-To: <20250701-media-rpi-hevc-dec-v4-3-057cfa541177@raspberrypi.com>
References: <20250701-media-rpi-hevc-dec-v4-0-057cfa541177@raspberrypi.com>
	 <20250701-media-rpi-hevc-dec-v4-3-057cfa541177@raspberrypi.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-3X+v+qqpBxti/ZHprAy2"
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-3X+v+qqpBxti/ZHprAy2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 01 juillet 2025 =C3=A0 17:01 +0100, Dave Stevenson a =C3=A9crit=C2=
=A0:
> Adds a binding for the HEVC decoder IP owned by Raspberry Pi.
>=20
> Instantiations of the decoder IP can currently be found in
> the Broadcom BCM2711 and BCM2712 SoCs.
>=20
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>=20
> ---
>=20
> Updated based on the thread in v3 [1] with Krzystof to drop to only SoC
> specific compatible strings.
>=20
> This still feels wrong to me as this is NOT Broadcom IP - it is solely
> owned by Raspberry Pi.
>=20
> It is the same situation as for the Raspberry Pi ISP Backend where
> it was proposed to have
> =C2=A0 compatible =3D "brcm,pispbe-bcm2712", "raspberrypi,pispbe";
> in [2]. That proposal was viewed as acceptable by both Rob[3] and Conor[4=
],
> and the binding given a Reviewed-by by Rob[5].
>=20
> Yes it is found as a block inside an SoC, but the same could be said
> for a Synopsys I2C controller ("snps,designware-i2c"), Cadence ethernet
> MAC ("cdns,macb"), ARM CPU (eg "arm,cortex-a53"), or any number of other
> examples. They are all 3rd party IP blocks found in SoCs, have an SoC spe=
cific
> compatible defined, but acknowledge the IP owner and use a common fallbac=
k
> compatible where possible.
>=20
> Please could we have confirmation that this really is what is required
> by device tree?

Its been approved like this, are you confortable with that now ? If I'm rea=
ding
this correctly, its common practice to add and use a SoC specific compatibl=
e
just in case some variation exists. Its quite unlikely in this case of cour=
se.

cheers,
Nicolas

>=20
> Thanks
> =C2=A0 Dave
>=20
> [1] https://lore.kernel.org/linux-media/20250423-media-rpi-hevc-dec-v3-3-=
8fd3fad1d6fb@raspberrypi.com/
> [2] https://lore.kernel.org/linux-media/20240213104405.GB5012@pendragon.i=
deasonboard.com/
> [3] https://lore.kernel.org/linux-media/20240215140058.GA4147262-robh@ker=
nel.org/
> [4] https://lore.kernel.org/linux-media/20240213-landlady-backstab-6e7da8=
24c99a@spud/
> [5] https://lore.kernel.org/linux-media/170932821578.3062059.181501592562=
47255021.robh@kernel.org/
> ---
> =C2=A0.../bindings/media/raspberrypi,hevc-dec.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 72 ++++++++++++++++++++++
> =C2=A01 file changed, 72 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/raspberrypi,hevc-dec=
.yaml b/Documentation/devicetree/bindings/media/raspberrypi,hevc-dec.yaml
> new file mode 100644
> index 000000000000..fe3361bddd1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/raspberrypi,hevc-dec.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/raspberrypi,hevc-dec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi HEVC Decoder
> +
> +maintainers:
> +=C2=A0 - John Cox <john.cox@raspberrypi.com>
> +=C2=A0 - Dom Cobley <dom@raspberrypi.com>
> +=C2=A0 - Dave Stevenson <dave.stevenson@raspberrypi.com>
> +
> +description:
> +=C2=A0 The Raspberry Pi HEVC decoder is a hardware video decode accelera=
tor IP block
> +=C2=A0 developed and owned by Raspberry Pi.
> +
> +=C2=A0 Currently it can be found in the Broadcom BCM2711 and BCM2712 pro=
cessors used
> +=C2=A0 on Raspberry Pi 4 and 5 boards respectively.
> +
> +properties:
> +=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0 oneOf:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: brcm,bcm2711-hevc-dec
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - brcm,bcm2712-hevc-dec
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: brcm,bcm=
2711-hevc-dec
> +
> +=C2=A0 reg:
> +=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: The HEVC main register reg=
ion
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: The Interrupt control regi=
ster region
> +
> +=C2=A0 reg-names:
> +=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: hevc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: intc
> +
> +=C2=A0 interrupts:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 clocks:
> +=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: The HEVC block clock
> +
> +required:
> +=C2=A0 - compatible
> +=C2=A0 - reg
> +=C2=A0 - reg-names
> +=C2=A0 - interrupts
> +=C2=A0 - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +=C2=A0 - |
> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +=C2=A0=C2=A0=C2=A0 video-codec@7eb10000 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "brcm,bcm2711-=
hevc-dec";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x7eb00000 0x10000>,=
 /* HEVC */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <0x7eb10000 0x1000>;=C2=A0 /* INTC */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg-names =3D "hevc",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "intc";
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <GIC_SPI 98 IR=
Q_TYPE_LEVEL_HIGH>;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clk 0>;
> +=C2=A0=C2=A0=C2=A0 };
> +
> +...

--=-3X+v+qqpBxti/ZHprAy2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaQ4fQwAKCRDZQZRRKWBy
9JiWAP9aJDUC+DwYY4YEakcAJEpmjHTtr46zD7hn3ACBBR4/agD/V2BqBy+VHQKe
BnFBOdM8RMAcrD/5z9Gr8HaJXTJpvgI=
=djZq
-----END PGP SIGNATURE-----

--=-3X+v+qqpBxti/ZHprAy2--

