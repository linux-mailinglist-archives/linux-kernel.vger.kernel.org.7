Return-Path: <linux-kernel+bounces-824742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7D2B8A0F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050903B0598
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC9242D70;
	Fri, 19 Sep 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abMwWbgy"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19C314B6F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293127; cv=none; b=a0Xc74gFMhr87EaHlaYACUfRElGGLyb9ZXWNdoXJdR1q09vOytuuh8ANGjVVKtElRv/iHdfR0ANTo9Ex5CZopet5hTtXeJW3QYs5/Go7/fyVfpZttoVJ9je360bvZg04tWwJ4rhsMOg3hqlSjtGCxkwcL9aCmCW2SRohHy94aw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293127; c=relaxed/simple;
	bh=NLFFD0lnEa8eGx4soPKV8lM6nEBYsJIEn4aMXEIQHww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOnp7FZ+PrVeNCUELCK6QIsNtOXI9N1wh1Hr17Q/PsbwC3HmU9aw7nQfppIOv9fA5wxBnpNEsdbCuAMo235VIIdcDntP5ssWSayN8WmvH8WlU67Nw0WTxN6W0OG/ucWLnBAqNYBEf3ZyMtScghunLyWkZnrFXsZwgQ7u+IzqDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abMwWbgy; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so1522488276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758293125; x=1758897925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WjyTwxOlL5TBVN6HVHH54w6s0HUnwkgruRLNDXu+EU=;
        b=abMwWbgy1hwj8hk9n6xrIm3xAkFH+3qF+nnYXEu+LAejSdxrAA+S2ztZOtdxdnUjtn
         fu99h5h4iDKXFd2wkxSkHOGvGKzPD2/MsLLhNeKy0etB5AcguBifQDghyBGRFUj2ojn3
         yJKC0Nb2MH/vtb3Z2gK3/dG7jqn5ixjrVogPktVLZmt9JqyoTQR3c3pkaz35/fSpHqSD
         edQZsBENbvGfJpHpnN2asxNJ52DMsyUX1pSTVRYJYMQ3sZeP6IX7DKI4IdQoKL7dLWjX
         h4rTXO8uXJgU/JcvcG9jtm8o+s63CQwSrPXkGZY4IvlBld+sdyLtQrWxEqC26iJkJLAm
         KiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293125; x=1758897925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WjyTwxOlL5TBVN6HVHH54w6s0HUnwkgruRLNDXu+EU=;
        b=KrgDo4nyC+bGCcrszVGIjhrnqmY+EoBTV3iMiXYyuVNsEwx/XISOiE2d4YR6OSwew6
         OATdoCv8/nUtwpvoQgaD4yuqF3ac24M3Y1FYwfPwi4ScleEosrvTqrL31jR6FgHKB8aD
         XzYBuswx70l7HcJYAEUMT/BkrvL5DAvjy14RdkkB7PZVQD2QEhVcjkkA/UyEU16dqpi6
         rsgkxHyHjXbOy6S+/zkkGWev+Fk5NVRhmDHiGVG/7vuIrXTat5Ox3kd+DD8uJehJ8LUQ
         fFVzS+9OevgmR3gSYI8/midFO/AVJ8G7KoRFbLiiv0xMo7HqsAyLK7iFRT4wIFt6spVf
         75vw==
X-Forwarded-Encrypted: i=1; AJvYcCVRxryfWHAr73oRT9uUX45tI8ebmV0+v8qIeKn5TmMaC4UFGvoKDS43aDE4ogrYVPTBG5Bw+XDCCu0Hjqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbi8p5FH2nuRolTmbP3T9RHDIyfckUcFnUTttbUivC4RsEOnqm
	q70K2CItbWnxSdAXlQsGfwVGx+Y0QYsV6qFtyjvD/dd07JxVvO5yxy44/K1wrnBy2hnFwWi6sK0
	irNSmwCxRT/KlcdlxGNIErdM0XEnzUiI=
X-Gm-Gg: ASbGncvEXS63LolQrkfzIZ2QMD3ALPoao/jrAy3eMuPGDDxydlOkMJ8V1PpfNwq7Oxt
	CF01c+cExBa9ntpAm1kzTbND2EP9JSXjrcAFbyEkCUBKdBZxWwbi6DKFs0LkNv27q3diwIwGmRu
	YmJRCgtWfsMJK4ZjrQkxlBtbItF68fPhs3p6tZlCjwqKmUR3R+POmPr41slqPYKu2m1dNrR0+dy
	geKAp9H
X-Google-Smtp-Source: AGHT+IGJw1+yEfFNFqRcYjWUnG/h8+qC9oVnvpeOX94lxBtVsN40UmgyUvz0yHEx0P3xwOLztHIl2uP+N3Us1ggwwRI=
X-Received: by 2002:a05:6902:1b87:b0:ea3:e63f:7b42 with SMTP id
 3f1490d57ef6-ea8a79e880cmr3533510276.33.1758293124321; Fri, 19 Sep 2025
 07:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912064253.26346-1-clamor95@gmail.com> <20250912064253.26346-2-clamor95@gmail.com>
 <bdd942ef-1ede-4f9f-ab90-ea7ac8995b92@linaro.org>
In-Reply-To: <bdd942ef-1ede-4f9f-ab90-ea7ac8995b92@linaro.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Sep 2025 17:45:11 +0300
X-Gm-Features: AS18NWCaPEoqBynvU0_LqnkYzZ1JgNAvdrHR_FyFiEbwwYX_CdM3v2DxCZzUGeU
Message-ID: <CAPVz0n1Ac=opNj=qAM5Rp0fpDo-6khCdmhoCwkztGLosKV31tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: document Sharp
 LQ079L1SX01 panel
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 19 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:36 Neil=
 Armstrong <neil.armstrong@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> On 12/09/2025 08:42, Svyatoslav Ryhel wrote:
> > Document Sharp LQ079L1SX01 panel found in Xiaomi Mi Pad.
>
> The patch doesn't apply on drm-misc-next, please rebase.
>

Sure, but I have synced with drm-misc-next right now and it applied cleanly=
.

I am on top of 048deed5faf0 (drm/drm-misc-next) drm/panel: Add support
for KD116N3730A12

Top commit is correct on my side?

> Neil
>
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   .../display/panel/sharp,lq079l1sx01.yaml      | 99 ++++++++++++++++++=
+
> >   1 file changed, 99 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/display/panel/sh=
arp,lq079l1sx01.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq07=
9l1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq079l=
1sx01.yaml
> > new file mode 100644
> > index 000000000000..08a35ebbbb3c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01=
.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/sharp,lq079l1sx01.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sharp Microelectronics 7.9" WQXGA TFT LCD panel
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description: >
> > +  This panel requires a dual-channel DSI host to operate and it suppor=
ts
> > +  only left-right split mode, where each channel drives the left or ri=
ght
> > +  half of the screen and only video mode.
> > +
> > +  Each of the DSI channels controls a separate DSI peripheral.
> > +  The peripheral driven by the first link (DSI-LINK1), left one, is
> > +  considered the primary peripheral and controls the device.
> > +
> > +allOf:
> > +  - $ref: panel-common-dual.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sharp,lq079l1sx01
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  avdd-supply:
> > +    description: regulator that supplies the analog voltage
> > +
> > +  vddio-supply:
> > +    description: regulator that supplies the I/O voltage
> > +
> > +  vsp-supply:
> > +    description: positive boost supply regulator
> > +
> > +  vsn-supply:
> > +    description: negative boost supply regulator
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  backlight: true
> > +  ports: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - avdd-supply
> > +  - vddio-supply
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    dsi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        panel@0 {
> > +            compatible =3D "sharp,lq079l1sx01";
> > +            reg =3D <0>;
> > +
> > +            reset-gpios =3D <&gpio 59 GPIO_ACTIVE_LOW>;
> > +
> > +            avdd-supply =3D <&avdd_lcd>;
> > +            vddio-supply =3D <&vdd_lcd_io>;
> > +            vsp-supply =3D <&vsp_5v5_lcd>;
> > +            vsn-supply =3D <&vsn_5v5_lcd>;
> > +
> > +            backlight =3D <&backlight>;
> > +
> > +            ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                port@0 {
> > +                    reg =3D <0>;
> > +                    panel_in0: endpoint {
> > +                        remote-endpoint =3D <&dsi0_out>;
> > +                    };
> > +                };
> > +
> > +                port@1 {
> > +                    reg =3D <1>;
> > +                    panel_in1: endpoint {
> > +                        remote-endpoint =3D <&dsi1_out>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > +...
>

