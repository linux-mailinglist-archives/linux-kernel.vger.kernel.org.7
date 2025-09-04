Return-Path: <linux-kernel+bounces-800233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A992FB434F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2273B3A8F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9452BE7B2;
	Thu,  4 Sep 2025 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8S9FCth"
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A972356B9;
	Thu,  4 Sep 2025 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973324; cv=none; b=ozttFZBh5qhXsY9Ctcd0iGTddGzC4hiSQA/CiHp+k7DHMhfu0kvPO3mmX6GMjY2a0Iif6ksBEkV3lhpw+drB2sCAroGceTR/wHqJNeig5T9nsI29It/cTknof1k022HEdsUWeYBFQVpfz7C0wtKn8dXJ9VnShIQUFaJM0Hv+kns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973324; c=relaxed/simple;
	bh=OlTvssMUFz983H3zSO38lv8FOHkypyBxslaN5VL0YFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY5AlSHbMq2q+oSvFJPkeaAG07GU/IBF47su+mTDIRuczYjeU03hrzlV4lpzWjNpvcRwDKeS6hGM8pceLCTy3cSL2hL87nZ8XY9A/tcC5dzg+CN0Xpx07EgSoUhCtJ5MyqfZui1ix5wEQ+lCGUtlWdk720ZL/dWPOj5IM6DfDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8S9FCth; arc=none smtp.client-ip=209.85.166.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f193.google.com with SMTP id e9e14a558f8ab-3f660084016so5351515ab.3;
        Thu, 04 Sep 2025 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756973321; x=1757578121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ly8rPu5Elk6gRUA9oOM6QiFvKyPaQYLkOhERLwvnX0k=;
        b=a8S9FCthdIl3bN7X+T3zTom7aYLqFnjg4knXbEXgBvUzuIRIZjGzmfXmcCnFtZfXcd
         SicnNpmAdhKTZtaNkRWng79NeNwsqFkpT+L4BynYbfIMVvI3amLr4C0xWCAf1KoE0kSk
         ovB7X2X6Igx7c2B3vJQQufDVGM8DYIsgs94lgF1ThZyLHc1XcvKMMa/yP7RfdmVHKITv
         3XkuoZEkH+tjlWOqZ7fXKTgM818z8y//1CRZfBIFHUeZVi3XkrjgfLOyt3d55h6Hu+Yk
         U4OYC8OcTwq9iS8tlSmfut5C0ytXbjmCLyhzbFK1hxezRRei0pimyG3YjF02O/1nfwEx
         UfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756973321; x=1757578121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ly8rPu5Elk6gRUA9oOM6QiFvKyPaQYLkOhERLwvnX0k=;
        b=gI1D//JfcnHpbZD+mBe83SF/ZSKN4vGM7CFSh4AnBa6gqmp1/rca3Io5wI86SNeVMc
         fYAsjmeBtr41zzgtrKSi2LHAYqxbPZgziY2frtOKYXIplZVTJNSzaiODO/fgu+o4qU+v
         RFdyxmW0Vgrj2NZLph5X6NU3uLvppmlCg4YieO82x1QOKoluBnAHzlhPWm4UGyuvPGrz
         ssV/wfYp3oh37Mwyz0dHHC+EzvE1aUWZyKQOduoU4Xk7Olnc0vFMmiytY1UaOhUyDcSk
         YJfNIO0e4tVyWONfMBlOUCQkSZR2BRoQTuRlEMzIahU9r+LhgM9S+lgDl105PtW+k6F1
         Nsyw==
X-Forwarded-Encrypted: i=1; AJvYcCUukKthK66NS4oewSeP+qLUpssTCH6BbxvYUCuBxDGOFNVhHf/8OVFdGIXLTu67BN7Rn35B1HgjMc1p@vger.kernel.org, AJvYcCWG76I+z4o0c9KdaPhx8eaSnr3yLBDmtKUk0FhWK1aoH0tNKGThsmho8dytWR216S0jtoMDDA4mbYvIoVeL@vger.kernel.org
X-Gm-Message-State: AOJu0YyY72EfrlKTbJt0YPbK5yKMtHRtE2tDnM04BBtpUFdUXq1M09a9
	m9V4xvO62qcWPNGGEJuzeP9bzeCkB9RXyac+M4easMtxBGstSW0HsW+8JdSSkJGvh4qy4hjQa4I
	O+H46g5pDWApnX6Nohm8CYnFBV1uwGqA=
X-Gm-Gg: ASbGncvQU4zt/WL4byq3PSbYutbIanQp9lRDQTYdJFTh3GnzAvlO2kT5oFQBkHZQqDq
	PpOZp12H92Mv6JmnQrJces4F5DJwDZs7Yl8nV7TORwP2Op1RI0T+3dY2CLZLCbN7THuCuL2nNbN
	A+mw0+5HIVlVwbRWJv1DMEYG3qa7q+n4QMoJM0xY97/DCb+b+wWyS6B3ndSC3YIeL2AwumPm+ra
	hS9N43IVrlOKP1nDQ==
X-Google-Smtp-Source: AGHT+IGAucgTcZTwn46rpjl+cm6v0lSFEYGolR5lXmPUPEUGOC5/FpPQR9OBCkDWVEpJRTBXRcCbdn9ppWx5Lkla1OY=
X-Received: by 2002:a05:6e02:4702:b0:3f6:58b8:9c82 with SMTP id
 e9e14a558f8ab-3f658b89ca0mr52360525ab.12.1756973321505; Thu, 04 Sep 2025
 01:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175691717884.2393851.6340903042726389490.robh@kernel.org>
 <20250904022524.1748587-1-syyang@lontium.com> <042523f7-2b75-4a04-8e0b-d1019ab84987@kernel.org>
In-Reply-To: <042523f7-2b75-4a04-8e0b-d1019ab84987@kernel.org>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Thu, 4 Sep 2025 16:08:30 +0800
X-Gm-Features: Ac12FXz_3Eda9GTnhCSIJ4uulYhw3s_gHBX5hgVGmYOzYtsyhg9ZR_eHPeUXbgE
Message-ID: <CAFQXuNZpLBP3=MGmRRpwJu43ZtkNhrTzh8kOwFgKy20rqFiG7Q@mail.gmail.com>
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
=97=A5=E5=91=A8=E5=9B=9B 13:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On 04/09/2025 04:25, syyang wrote:
> > Fix device tree binding validation errors reported by Rob Herring.
> >
> > v2:
>
> That's not the place where you put changelog.
>
I'm currently learning what to do. Thank you

> > - Fixed $id field to match actual filename (lontium,lt9611c.yaml)
> > - build pass
> >
> > Thanks to Rob Herring for the review and feedback.
>
> Please carefully read submitting patches.
>
I'm currently learning what to do. Thank you

> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets. See also:
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/s=
ubmitting-patches.rst#L830
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
>
I'm currently learning what to do. Thank you.

> >
> > Signed-off-by: syyang <syyang@lontium.com>
> > ---
> >  .../display/bridge/lontium,lt9611c.yaml       | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/lo=
ntium,lt9611c.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,l=
t9611c.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt96=
11c.yaml
> > new file mode 100644
> > index 000000000000..712644da4f1d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.=
yaml
> > @@ -0,0 +1,121 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/lontium,lt9611c.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Lontium LT9611C 2 Port MIPI to HDMI Bridge
> > +
> > +maintainers:
> > +  - Rob Herring <robh@kernel.org>
>
> No, how so?
>
I will change it to the email address I use when working at the
company.  (syyang@lontium.com)

> > +
> > +description: |
>
> Do not need '|' unless you need to preserve formatting.
>
Both lontium,lt9211.yaml and lontium,lt9611.yaml use "|", so please
confirm if they need to be removed.

> > +  The LT9611C are bridge devices which convert DSI to HDMI
>
> Why this cannot be added to lt9611 binding? Commit msg should clearly
> answer that.
>
The lt9611 and lt9611c are chips of different specifications, and
their related parameters are different.
The VDD-supply of lt9611c is 1.2V; the vdd-supply of lt9611uxc is also
1.2V, while the vdd-supply of lt9611 is 1.8V.
Now lt9611 and lt9611uxc are connected together. I'm not sure if this
is a problem.
If this lt9611c can also be bound to lt9611, and if you think it's
okay, then I have no problem.

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lontium,lt9611c
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#sound-dai-cells":
>
> Missing dai-common ref.
>
I don't understand .   I referred to:
Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml

> > +    const: 0
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: GPIO connected to active high RESET pin.
> > +
> > +  vdd-supply:
> > +    description: Regulator for 1.2V MIPI phy power.
> > +
> > +  vcc-supply:
> > +    description: Regulator for 3.3V IO power.
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Primary MIPI port-1 for MIPI input
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Additional MIPI port-2 for MIPI input, used in combination
> > +          with primary MIPI port-1 to drive higher resolution displays
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          HDMI port for HDMI output
> > +
> > +    required:
> > +      - port@0
> > +      - port@2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - vdd-supply
> > +  - vcc-supply
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c10 {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      hdmi-bridge@41 {
> > +        compatible =3D "lontium,lt9611c";
> > +        reg =3D <0x41>;
> > +        #sound-dai-cells =3D <0>;
> > +        interrupts-extended =3D <&pio 128 GPIO_ACTIVE_HIGH>;
> > +        reset-gpios =3D <&pio 127 GPIO_ACTIVE_HIGH>;
> > +        vdd-supply =3D <&lt9611_1v2>;
> > +        vcc-supply =3D <&lt9611_3v3>;
> > +        status =3D "okay";
>
> Nope, drop.
>
remove  status =3D "okay"  ?
>
>
> Best regards,
> Krzysztof

