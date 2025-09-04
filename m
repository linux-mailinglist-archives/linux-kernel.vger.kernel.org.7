Return-Path: <linux-kernel+bounces-800650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A6B43A20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AC05A3F79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319C2FE053;
	Thu,  4 Sep 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlVtdfRz"
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782D2FE072;
	Thu,  4 Sep 2025 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985236; cv=none; b=HkpgLwiugnCaUaW71ra9oMpBYOVGTwC8jOtl8Izizg0bjPj6Iye7lP9DPfipOz98iwI0Azaooqe7Rm/UHA53nyZWpwL3ZYriwMJmir+0O/OZCk6MC88StIqpnEF1hGeHa+FO1EaE3sksb4jR9c1FnWhjL0fz7102P8AGqPhs5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985236; c=relaxed/simple;
	bh=0GFSLvp8nlz8nExv1JNcJXDGrQgXQuC7rx/KZJePKEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCpsteFw63rJ8Arpbf4m/2w7HyR+iLXs1roj7wf7el3nitefJ1hbFdUyP8HaeZcPESkBPOsXFCmmUyNf7LxBJz3VLWHBtcb1NScry9VQbdK0poSWbfmh5julOugYK5F+sne/k9Tt5pC7GWiykdv5N+q9x0dOZ+1Y34oj4ZCxeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlVtdfRz; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-3f664c47ad2so9919375ab.2;
        Thu, 04 Sep 2025 04:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756985234; x=1757590034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Omu2iDAjQIOjKg0DmAgEj8ICa8iVBrvJA7lXUZP/Pg=;
        b=hlVtdfRzWZyPoRPc6Hwsgbjl2+xF0CeHHgE5Okh9yo3TDz6h3dVecgvyTncIv+rRmo
         5Wu6DsPUnrVB4JXtiGhk2QvOm+e580M4w87EmZZj2sJI+YjVtVFCXqzbIuoNLjvQQnKF
         vl18DqUI0DLaijDJK/ktN3Y+RIgGCPxlVYGv5S9aVb3fdsnjGk/bdq3c+FAzwaNQjDhG
         qh9+OBbSdzi6l3wwm1xuTVlbQ325nUThFklPGo//5pyxFjY/jm6nZw7rGN5dswPI8+RL
         r+repm22nfg5/x84yK2o78njDtpma2G5wpRoJmkpwWlNj0X3YHUjrdT+FdE8ZKErg9KY
         H1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756985234; x=1757590034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Omu2iDAjQIOjKg0DmAgEj8ICa8iVBrvJA7lXUZP/Pg=;
        b=G6r9EEtEJOrA1VL9nSub830Hwg/WLhovhYPelQpzYF2sKnwNsPDtMKrsvz1yxt/NQW
         hd1l1Khpn4tePok6BSONFiuD0ybOp84WeAiM/4j22/9RbkzEKl/BE29DkA5nPOpqqROj
         adjc4YzYBm3aBfX/RDLiBMXcU1ZGQKl+qRQLx7LRNNHJojm07IFyxxYf5K+WPq7wSkZO
         jUXLT6qaw2ttj9KDnMpQphixp+0l52AVj3UeUFQ2T6I9o05e5RJNGsnXEDB9cQiURxwq
         vEVydsqkmoHK0Gcd4T0z918Ct3Hw1ZsA9VnloFuBgBIb86OFnHSHC6R7nrIW0ZjZvE/F
         FnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW091OWZLQfmmue+26zIt0Uei3CLrcdcIrOlNnKcrhFypgxQNutFWdxD5DJ6dvCA/uEiTSEwY9/lvZlFTTx@vger.kernel.org, AJvYcCX1GhnZ2RdkFCO6ozppg/Df3GeOyByuvSLQZ8905ySlRxmg5kgRQp/aH9t/Apouv5PXOlpzh1Ndebll@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LT/B7Sn1/Tusenu2T/kHXCtVqtvm3opBWMYLqftwXUa8uvpD
	2+K7sKz0SrcQdDsAsCozt8z9DaRi1ivXLOpeW0SdC6EXIuqXIBrt+pAjnVAUUL7Ze4Fa7jJ1INd
	MRVBVI5/UX1RNeKWwaw9YdnzCXeLO+RA=
X-Gm-Gg: ASbGnctrdjEGO0RbJ5l2C6lnq8p9i9Nr5pwQedl/4kx5zjQXISEp5nAfivbZDAnwpcS
	TexQUMssP9nA9EbGXqrDPjRMvDR2aUAVRd9Sqmr78edqwHKaCCdcR29kOr5yAo99Si6L+sJGN8E
	dQUWTRLjJK+Xe0z/sa1cDz5vAcYSPmwWD/6CMygk35CW7EbZX/GPI6WtFATtJpfu9RIPDYUgN3z
	k3pdXg=
X-Google-Smtp-Source: AGHT+IGwTHBUyBBmLkqWjAslRacNLUyP6rwDJEvQxuZzahg0BV3R26YS068p5u2POX62gnoxSFbFHAKFousXuOi5eqE=
X-Received: by 2002:a05:6e02:1a0e:b0:3f0:2c49:936d with SMTP id
 e9e14a558f8ab-3f400284d15mr144126505ab.12.1756985233526; Thu, 04 Sep 2025
 04:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175691717884.2393851.6340903042726389490.robh@kernel.org>
 <20250904022524.1748587-1-syyang@lontium.com> <042523f7-2b75-4a04-8e0b-d1019ab84987@kernel.org>
 <CAFQXuNZpLBP3=MGmRRpwJu43ZtkNhrTzh8kOwFgKy20rqFiG7Q@mail.gmail.com> <20250904-aromatic-loon-of-honeydew-f7861e@kuoka>
In-Reply-To: <20250904-aromatic-loon-of-honeydew-f7861e@kuoka>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Thu, 4 Sep 2025 19:27:02 +0800
X-Gm-Features: Ac12FXwy1IO1UhmsmetaaHLdUnL-i9ZgD2TthvXT1YzMwKP3in7ctBXaHrxoB9c
Message-ID: <CAFQXuNaR+Y+PZG5h0_ETSs+hsepj6uUb2-ogZSNPT_C0JwGWDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] This patch adds a new device tree binding documentation.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: syyang <syyang@lontium.com>, robh@kernel.org, Laurent.pinchart@ideasonboard.com, 
	andrzej.hajda@intel.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org, neil.armstrong@linaro.org, 
	rfoss@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=884=E6=
=97=A5=E5=91=A8=E5=9B=9B 16:26=E5=86=99=E9=81=93=EF=BC=9A

>
> On Thu, Sep 04, 2025 at 04:08:30PM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90 wro=
te:
> > > > +
> > > > +description: |
> > >
> > > Do not need '|' unless you need to preserve formatting.
> > >
> > Both lontium,lt9211.yaml and lontium,lt9611.yaml use "|", so please
> > confirm if they need to be removed.
>
> Add code which is needed, not code which you found somewhere. Why '|' is
> needed here?
>
 '|' It feels more comfortable to me to write the description text
after a line break.  '|'  When there's only one line of description
text, it can be omitted.

> >
> > > > +  The LT9611C are bridge devices which convert DSI to HDMI
> > >
> > > Why this cannot be added to lt9611 binding? Commit msg should clearly
> > > answer that.
> > >
> > The lt9611 and lt9611c are chips of different specifications, and
> > their related parameters are different.
> > The VDD-supply of lt9611c is 1.2V; the vdd-supply of lt9611uxc is also
> > 1.2V, while the vdd-supply of lt9611 is 1.8V.
> > Now lt9611 and lt9611uxc are connected together. I'm not sure if this
> > is a problem.
> > If this lt9611c can also be bound to lt9611, and if you think it's
> > okay, then I have no problem.
>
> It is not a problem.
>

Do you think it can be merged with lt9611 and lt9611uxc?


> >
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - lontium,lt9611c
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  "#sound-dai-cells":
> > >
> > > Missing dai-common ref.
> > >
> > I don't understand .   I referred to:
> > Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> >
>
>
> You call this device a DAI, so your binding should reference dai-common
> schema, like every other one. You can check simple codecs for examples.
>
i will fix , thks

> > > > +    const: 0
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  reset-gpios:
> > > > +    maxItems: 1
> > > > +    description: GPIO connected to active high RESET pin.
> > > > +
> > > > +  vdd-supply:
> > > > +    description: Regulator for 1.2V MIPI phy power.
> > > > +
> > > > +  vcc-supply:
> > > > +    description: Regulator for 3.3V IO power.
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description:
> > > > +          Primary MIPI port-1 for MIPI input
> > > > +
> > > > +      port@1:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description:
> > > > +          Additional MIPI port-2 for MIPI input, used in combinati=
on
> > > > +          with primary MIPI port-1 to drive higher resolution disp=
lays
> > > > +
> > > > +      port@2:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description:
> > > > +          HDMI port for HDMI output
> > > > +
> > > > +    required:
> > > > +      - port@0
> > > > +      - port@2
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - vdd-supply
> > > > +  - vcc-supply
> > > > +  - ports
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > +
> > > > +    i2c10 {
> > > > +      #address-cells =3D <1>;
> > > > +      #size-cells =3D <0>;
> > > > +
> > > > +      hdmi-bridge@41 {
> > > > +        compatible =3D "lontium,lt9611c";
> > > > +        reg =3D <0x41>;
> > > > +        #sound-dai-cells =3D <0>;
> > > > +        interrupts-extended =3D <&pio 128 GPIO_ACTIVE_HIGH>;
> > > > +        reset-gpios =3D <&pio 127 GPIO_ACTIVE_HIGH>;
> > > > +        vdd-supply =3D <&lt9611_1v2>;
> > > > +        vcc-supply =3D <&lt9611_3v3>;
> > > > +        status =3D "okay";
> > >
> > > Nope, drop.
> > >
> > remove  status =3D "okay"  ?
>
> Yes. Instead of asking me, you can try to think about possibilities.
> Ask yourself yourself - why do you need it here? What changes if you
> have it? What changes if you drop it? Why reviewer asks for it - maybe
> there is something behind. That way you will learn more about this.
>
> I suggest to go through the slides of my OSSE25 talk about DT for
> beginners.
>
thanks,

> Best regards,
> Krzysztof
>

