Return-Path: <linux-kernel+bounces-813368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A28B5443B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B29C480B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E712D374B;
	Fri, 12 Sep 2025 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGfyYAos"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6DF2D0C73
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663659; cv=none; b=Hz4DUoIH4cb4Brow4/Z4yX1mldfW2z8rSmNDk5yVxqjTLFqM1oPqMdm9ZP+PCxq6afSPqrUD9x2rGJf4adc7zCb+1mswXs0nmdmBANb7qJ3F/S5SMwZwI5KZjQEAuj5WE5OpOEK4ZldWXatFmS1uCunVzpE8GSE8aC/AqUZkLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663659; c=relaxed/simple;
	bh=Grp0/nTBNIMSIhr2eHNF+OmOjlfnZ2Vkm28fXfqGvyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLMMkg+F3mDiUP6OXoK0vqNRWyZso3NI/Zo7qWnc8t5Xzq+4pS2I/5XgV5jdBZ6vXFukaA5nDjGeh2NDLTvSB5mVMbPsO6K6NhvoupY1FzmvdFBTqjbxRuwUYPyryA34fWrlRQB9fD6/WgmjU32UXAfnHpzxYOMPQeYuuw7JJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGfyYAos; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-ea0297e9cd4so1009309276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757663657; x=1758268457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjuRsqHdcU4j53GUFw1Pl7XbbCPvtJQh1ErB89K8XOs=;
        b=bGfyYAosidmRXUr6mqZ+JemixQn2TQpPiv7MqE5H/RjUZ9OUFkrP+kOCc1s+ewj4Rh
         6FYqbCnUbBoPxPui916uA+zEVxwIZC1Vwp2kkAqudkQWdrk+bfj3O5zQaNEnb7nh1Vki
         SPrJ2/y6otHLdljQD/V234GOOqoz3PIkYw7kqocJgcUlIdwDPEXVEFugXwCeqCejyyc0
         dn1lwDwkFAE0gcs04WZN18aJLi8lbmhqB23ViDDl7WqfV7GQITPIabtB8uO8CKq3iLHp
         u1JCqfuIjQrELre9/RtDpUFjYiXoiOMNl6+a9qwN3ZSu9iBxs/Kgw0RuzDXCTUiHpc3c
         5TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757663657; x=1758268457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjuRsqHdcU4j53GUFw1Pl7XbbCPvtJQh1ErB89K8XOs=;
        b=U0aR5Hmv6zRet432GhyiOynU0Mg9SZVWO5WjB3pRgVxUM0a+b5dkjzzRX50HW3/gWJ
         dicArAMzmlmLAsCd86lMnZ5ZcEb70nNSkaKj1ueONXjppVXe1Nymj1D44oRYZvv26tAa
         EXeMpo8htlvwdBbqtlou9dyqMZxVYUn7M08owpMorjtUovgNDQDiK1NqPFlyYjeoIx5Z
         IMpL7YHivjcBTLgYqvgA9vIq4V1CHNdPEiwnWQGsoCdtqKeNhU102x9PFpBMC2Q/gjbd
         I3Qyo/UPDU8JqFWkVy4B1IzI6lEUIDnzN5NuMRUWY6LXeTK7ITuBKHoFFyg7WhDk6apv
         fF/A==
X-Forwarded-Encrypted: i=1; AJvYcCUD82LHBOYuC4LTTCViXrUAP6ebzpXCZvg4LPnZzCPln3jnMX2Np2x4lkt2ojJZN1mIezTuTJsJL2edj1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQcwbg1l8OBywjU66RbaEowUnR2Kf61HazMDza04rwDaACMyl
	KVHN9N31moLJyDjep+rGzrJImtphY28+Wfy6T5V+ARPiYEkVLhRr5RTD84F32H6VJ40u9Tpj67/
	Ml/a2FmzuazvuN7FLWj/sXJ14E5yUCSY=
X-Gm-Gg: ASbGncua20wAZc3wgwPRyAsmyAkSHLcrHEPAoQCSPZLyNkhrF4Sm686cg11FQAAEqgC
	yBzKIMSdi7uX2qIYUsygj2FKqLTSDjlwphGHNh8o4bWi1xSPEwF20gMXj922QJno1/9k+eUjRaL
	7FWlmSH3iWQi5KT5FfcyhduIsM1PV/sZiTnfmcr9bZP53jv5cafgmdBGvMEsVMN3hANT5ajgu3s
	0JK30MoSJVXSj/WVg==
X-Google-Smtp-Source: AGHT+IE8+unssytBQ1SOk4XKYFDJkZtS2RYqGocxJxS92x7Kboc0Jmlrk5uoaHdUbNrabaNoKudlBW69K1l0SKFQeSI=
X-Received: by 2002:a25:b318:0:b0:e96:edb1:83e1 with SMTP id
 3f1490d57ef6-ea3d9a53003mr1176835276.30.1757663657050; Fri, 12 Sep 2025
 00:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-st7920-v2-0-409f4890fb5f@gmail.com> <20250909-st7920-v2-2-409f4890fb5f@gmail.com>
 <20250910-ant-of-angelic-vastness-b5caa5@kuoka>
In-Reply-To: <20250910-ant-of-angelic-vastness-b5caa5@kuoka>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 12 Sep 2025 09:54:06 +0200
X-Gm-Features: Ac12FXy9_6cG2MPPRC87qxo9hknhSzyQbNu-GNhShhmF__u_g4RQSIAwjbhmZUU
Message-ID: <CABdCQ=NKrXMqt+7Pj1oL2_6isi6w2q3bJLRrS8LFxLixNu+d9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: sitronix,st7920: Add DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9, 10 sept 2025 a las 13:35, Krzysztof Kozlowski
(<krzk@kernel.org>) escribi=C3=B3:
>
> On Tue, Sep 09, 2025 at 06:52:44PM +0200, Iker Pedrosa wrote:
> > Add binding for Sitronix ST7920 display.
> >
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >  .../bindings/display/sitronix,st7920.yaml          | 52 ++++++++++++++=
++++++++
> >  1 file changed, 52 insertions(+)
> >
>
> Please organize the patch documenting compatible (DT bindings) before the=
ir user.
> See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation=
/devicetree/bindings/submitting-patches.rst#L46
>
> ...
>
> > +  reg:
> > +    description: The chip-select number for the device on the SPI bus.
>
> Drop description, obvious/redundant.
>
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 600000
> > +
>
> I don't see how my comment about supply was addressed. You never
> responded, nothing explained in the changelog, nothing explained in the
> commit msg.

Sorry, I forgot to answer.

No supplies are needed. There's an optional contrast for the display,
but this isn't strictly needed.

>
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-max-frequency
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    // Example: ST7920 connected to an SPI bus
>
> Drop comment.
>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        display@0 {
> > +            compatible =3D "sitronix,st7920";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <600000>;
> > +            spi-cs-high;
> > +        };
> > +    };
> >
> > --
> > 2.51.0
> >

