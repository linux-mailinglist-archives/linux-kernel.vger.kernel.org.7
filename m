Return-Path: <linux-kernel+bounces-846271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 644DEBC7714
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3844F2253
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA6D261B98;
	Thu,  9 Oct 2025 05:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpCU7CrJ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC154279
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988138; cv=none; b=rLIbEI6iOr3WLvEirA9w0zoG07I7isbLCRx3sVVTiDmiZwwNklaMUHknb9XbLVtYdHnknrPGqflNTZbY9zxaE4nvDcgyMcOyatieWs1J6PnRd1x0RlcyjSCwDQwtwVEaP+8inxBS1LHCcw9MhWIzJU9/byciz0CxZf4vU5FlOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988138; c=relaxed/simple;
	bh=BTgTHwCRBA2rpvydRjKgExKMcfvUeqSUe1HHihN2Z4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5YsteC4Ibmt0Uz3ZzndqmnGDyyIB14QLAY/InlrfaH/4UhB/rjZqF82sPRcCBeZdw0J0s45gPruPuS6PYh5tZAMCEhSncX1cFZt73qn1sMPAdk1sKKwZP4eB1UZgujTInGPdwGbhxFc77enAsPTWLzHBNpvogqinkqz+68yJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpCU7CrJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-421851bcb25so251066f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759988134; x=1760592934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wojdy8oISaReFb3V/aujCr+dYfQppmzTEbdq6Sq+uyc=;
        b=cpCU7CrJ7ZCcqy9vu7RSEA/EpVmHnNGwO6NIeZCA8ztS+5lbdoH4JA7bFKb+0oApst
         ZCtXvd5fJSDdLB6SEfhvxzC/NbKNyEfUNCJoJ2Iz4C/xmF9fvTfZcZvZ5kkFdZ7Y240k
         5TNrE4EmjSTu+C4FuqTnM1vOeb/bzLjORBXK1gaAlYg438cYaxwcNGRCoTo3hl+YWeEn
         zssYQh7Lf3mfbVwx9ydOrWwqtN+waicwF1cPc5R25akkudcHxIutk1d9uBVyeAzV/Ktc
         2H9sYaeK05mRMg00zrqm86840MjZRMarvk5q8XSyrHfsLN8ZxODio1RGzPGEbvCCfyOz
         u8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759988134; x=1760592934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wojdy8oISaReFb3V/aujCr+dYfQppmzTEbdq6Sq+uyc=;
        b=dE/B8SV+ZLcvSH3RZ4TAsSrzVj8RCb2XkAdOqTY8ELqVkp1XGXk2JP7DQJF3a/n1OG
         TR5rKvQMPVDPRJ/0aV1Tty8OX/+aCx9Xyi7Dm63UOY5fpthk3J0ZGhWry4FR43CU2Dcy
         etWwZPERf1Ao8TWFeF2+eXflBWbqXY4reNWPFClkRAjLwyPaBURvrY1SC89TB41rb2Fa
         3RlPCo8ziPPUz3arMHV3Tzra/ZEoyThHrjVC7pD1Rbemwpa0KL3ZoAxcQBlJbDQmrFbz
         BXQ9NcUzMfgy5kyAtz4SFTpo+U1ojqxDCCL0ZSwLh8vDUWqzEHhd+d8EVKiBu2sDYAYC
         Vgrw==
X-Forwarded-Encrypted: i=1; AJvYcCUPhKQKrnhh6wAsijumK7SnhVoJmKO1npkU3r1QDf5ag+ewMtxfQujFAMiw4WJzzwNESAem6rz/kYGJ2rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybxrPmk/GHO0ClUqG6LRy80WiWmM0A7CgPrRW7AUe/tCawmCa6
	k1iILMHC2dzvBYDci1O1UEdrJaQ0LwtoyGqdgPQWtecwv89ej2dyyQhUUGjxliOKPIRL3zQDvQT
	IAkYaXWF/00hqT3/AUKt4h2MV3s6SSVM=
X-Gm-Gg: ASbGncuS1LoNbo0rXXQobcpe3iGEuvOx8oqvA8liB8w3Jup7q7WuuU2vg0PEXCtkWf7
	d6B9CTq7FiBHBtHgUfiF84CXqr0gXPAp6O4KMtyvQXkUJ2fEkE1yfkIGrbspTlOmqcypkZJLSPW
	GNXXqLt552dQi+ED2WxRdy5dY0SZVRRdisz8y5bnTBaRsrdGQExO/OK3xmJNt76Oir2iNv2roXg
	vZO6azxzPQgKXi+bde/TCHV35PMQ38DBq1LDdK80FQ=
X-Google-Smtp-Source: AGHT+IGSKa0WWY8sQb7NirdhuUY9zlBVWAF8olfr4D2aOoKgmjKIIKXTBxs4oAP40QHdR3v89s2ItSY5dd09ZKpNd5w=
X-Received: by 2002:a05:6000:186c:b0:3ed:e1d8:bd68 with SMTP id
 ffacd0b85a97d-42666ac6107mr3102943f8f.7.1759988134193; Wed, 08 Oct 2025
 22:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008073046.23231-1-clamor95@gmail.com> <20251008073046.23231-23-clamor95@gmail.com>
 <20251008-canopener-marsupial-a92355b656ef@spud> <20251008-broaden-antennae-02de66094ad3@spud>
In-Reply-To: <20251008-broaden-antennae-02de66094ad3@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 9 Oct 2025 08:35:22 +0300
X-Gm-Features: AS18NWAoEWc39K5OD4GIBOR3Awt1LVDq6NQUxGEQwh6PoTXJKtyEajbgSJmBgBo
Message-ID: <CAPVz0n1NYL+t-KC1FwHYXuQ0C483ay3g8zP4SmBKVC2rh=x4Bg@mail.gmail.com>
Subject: Re: [PATCH v4 22/24] dt-bindings: display: tegra: document Tegra20
 and Tegra30 CSI
To: Conor Dooley <conor@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Dmitry Osipenko <digetx@gmail.com>, Charan Pedumuru <charan.pedumuru@gmail.com>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Aaron Kling <webgeek1234@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 9 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 00:22=
 Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Oct 08, 2025 at 10:21:06PM +0100, Conor Dooley wrote:
> > On Wed, Oct 08, 2025 at 10:30:44AM +0300, Svyatoslav Ryhel wrote:
> > > Document CSI HW block found in Tegra20 and Tegra30 SoC.
> > >
> > > The #nvidia,mipi-calibrate-cells is not an introduction of property, =
such
> > > property already exists in nvidia,tegra114-mipi.yaml and is used in
> > > multiple device trees. In case of Tegra30 and Tegra20 CSI block combi=
nes
> > > mipi calibration function and CSI function, in Tegra114+ mipi calibra=
tion
> > > got a dedicated hardware block which is already supported. This prope=
rty
> > > here is used to align with mipi-calibration logic used by Tegra114+.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../display/tegra/nvidia,tegra20-csi.yaml     | 135 ++++++++++++++++=
++
> > >  1 file changed, 135 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/tegra/n=
vidia,tegra20-csi.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,t=
egra20-csi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,te=
gra20-csi.yaml
> > > new file mode 100644
> > > index 000000000000..817b3097846b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-=
csi.yaml
> > > @@ -0,0 +1,135 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra20-csi.=
yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NVIDIA Tegra20 CSI controller
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - nvidia,tegra20-csi
> > > +      - nvidia,tegra30-csi
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks: true
> > > +  clock-names: true
> > > +
> > > +  avdd-dsi-csi-supply:
> > > +    description: DSI/CSI power supply. Must supply 1.2 V.
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  "#nvidia,mipi-calibrate-cells":
> > > +    description:
> > > +      The number of cells in a MIPI calibration specifier. Should be=
 1.
> > > +      The single cell specifies an id of the pad that need to be
> > > +      calibrated for a given device. Valid pad ids for receiver woul=
d be
> > > +      0 for CSI-A; 1 for CSI-B; 2 for DSI-A and 3 for DSI-B.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    const: 1
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 0
> > > +
> > > +patternProperties:
> > > +  "^channel@[0-1]$":
> > > +    type: object
> > > +    description: channel 0 represents CSI-A and 1 represents CSI-B
> > > +    additionalProperties: false
> > > +
> > > +    properties:
> > > +      reg:
> > > +        maximum: 1
> > > +
> > > +      nvidia,mipi-calibrate:
> > > +        description: Should contain a phandle and a specifier specif=
ying
> > > +          which pad is used by this CSI channel and needs to be cali=
brated.
> > > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +
> > > +      "#address-cells":
> > > +        const: 1
> > > +
> > > +      "#size-cells":
> > > +        const: 0
> > > +
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        unevaluatedProperties: false
> > > +        description: port receiving the video stream from the sensor
> > > +
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: /schemas/media/video-interfaces.yaml#
> > > +            unevaluatedProperties: false
> > > +
> > > +            required:
> > > +              - data-lanes
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: port sending the video stream to the VI
> > > +
> > > +    required:
> > > +      - reg
> > > +      - "#address-cells"
> > > +      - "#size-cells"
> > > +      - port@0
> > > +      - port@1
> > > +
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - nvidia,tegra20-csi
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          items:
> > > +            - description: module clock
> > > +
> > > +        clock-names: false
> > > +
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - nvidia,tegra30-csi
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          items:
> > > +            - description: module clock
> > > +            - description: PAD A clock
> > > +            - description: PAD B clock
> > > +
> > > +        clock-names:
> > > +          items:
> > > +            - const: csi
> > > +            - const: csia-pad
> > > +            - const: csib-pad
> >
> > This clocks section seems like it could get simpler. Since the clock
> > descriptions are shared, and tegra20 has no clock-names, you could just
> > move the detail of the properties out to where you have the ": true"
> > stuff (we prefer that properties are defined outside of if/then/else
> > blocks) and just restrict them here. For tegra20 that'd be
> >
> > if:
> >   properties:
> >     compatible:
> >       contains:
> >         enum:
> >           - nvidia,tegra20-csi
> > then:
> >   properties:
> >     clocks:
> >       maxItems: 1
> >
> >     clock-names: false
> >
> > (although it could easily be maxItems: 1 ?)
> > and for tegra30
> >
> > if:
> >   properties:
> >     compatible:
> >       contains:
> >         enum:
> >           - nvidia,tegra30-csi
> > then:
> >   properties:
> >     clocks:
> >       minItems: 3
> >
> >     clock-names:
> >       maxItems: 3
> >
> > Of course you'd then have to add minItems: 1 and maxItems: 3 to the
> > extracted definitions.

What do you mean by your last statement? Add minItems: 1 and maxItems:
3 like this?

This does to common properties
  clocks:
    minItems: 1
    maxItems: 3
    items:
      - description: module clock
      - description: PAD A clock
      - description: PAD B clock

  clock-names:
    minItems: 1
    maxItems: 3
    items:
      - const: csi
      - const: csia-pad
      - const: csib-pad

This goes to conditional
 if:
   properties:
     compatible:
       contains:
         enum:
           - nvidia,tegra20-csi
 then:
   properties:
     clocks:
       maxItems: 1

     clock-names: false

 if:
   properties:
     compatible:
       contains:
         enum:
           - nvidia,tegra30-csi
 then:
   properties:
     clocks:
       minItems: 3

     clock-names:
       maxItems: 3

>
> Oh, also: if you want clock-names to ever actually be usable, you have
> to require it. Otherwise a driver must be written to handle it not being
> there.
>

Yes, driver takes this into account and handles it.

> > > +additionalProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - power-domains
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +
> > > +# see nvidia,tegra20-vi.yaml for an example
> > > --
> > > 2.48.1
> > >
>
>

