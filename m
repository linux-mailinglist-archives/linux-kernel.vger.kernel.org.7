Return-Path: <linux-kernel+bounces-738644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CD8B0BB63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BBC18977AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4541FDE3D;
	Mon, 21 Jul 2025 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyfRTwyq"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1B1990D8;
	Mon, 21 Jul 2025 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068434; cv=none; b=Ep7ZFfgF3TLo5FdlJqz/BvQYdUve+lSO94v4c+3gB7ro6Oer+Ln0CijLWyNdVkLR3cb+sOAyYZETGTyY83lhVrQ80qMpGdoIe9cYljw8C1LNyzJxaYXmqSq8LImjhkmoAR9feTpWbgVSDr+D4kLta3Ghlkdjf7WLi/B69WRwfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068434; c=relaxed/simple;
	bh=OgN9dZKAVvXJmFroQccrEWHmRE9qiT/R0uEuicJgwfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn5qnjnD3ayxk7Jv6QAVAhq8rpsSHDMZ/ZZ27OIJt3zT4i0kpJkbpE0zkmKgW4TnZNbNn/XgcLeEgwcsMGibwVj0Oho51j0cboK6eH90/2gIVFlg4G0l+Qqx3olA3mvHoZVvQxNbcFFw0wY1lkTWvgAFy0sv1I/TSCz1rApigKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyfRTwyq; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-879c49e8ac3so286277139f.1;
        Sun, 20 Jul 2025 20:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753068432; x=1753673232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GJULZkEl8j6az+Nmf6Q9IdIMazJkldN2OlkYV3zqRI=;
        b=XyfRTwyq+IDlDFIZhqqdumaYQaMeo2cAovVyYsrwCKbtzYSiGqVN94ZzjqeoSTxO/7
         lOoEukrEWE1Ye9fMW6QFnZfpONWfRkM0ng5JGVDMd4Di6WQEEfizeAtMUvxapP35t6iN
         gXDQkrCEOHkMaBQipLviMpwUbsaY3Z4BC9UQPcJaMsQ1rDQh4FNImK+XVUtmxXPhT2bw
         9rNIrRchEblzFy3/vnHLneh9weKw0HujiYCLKmazNpLbJUJksOoU+DsAiGH+/eQeZpCN
         egKsW4OwSTKc1P8SQYUAiGP+TbDcdIQOUww6T6/h7EpOPjhzzJO57uxTiBRJlAV9LQLz
         aDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753068432; x=1753673232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GJULZkEl8j6az+Nmf6Q9IdIMazJkldN2OlkYV3zqRI=;
        b=maTqDBeyHkaUCuJhE9S2JBikXi9mYIdhR4EfnZ/NcGOqx25AbpE7ah20xHR96qR25C
         bVzysRR/0vSxZ3ok70dmDw5DTjRcCJVMKbwk43EObs/sNCCRK7/MQVgjIM2xnb9ZX52P
         szNkUgq1IMKdgZG/ls68vEmFL3WUqXrIx+g52YvifK6ULdt1MCmgLGViyzaae4yN7Po7
         CHRRuWKIf3rjNg0F+WsmpgdFFYNfbTFI5YWEyN6JUj9IiBPogqdixiH0+wMiXpY+jC4D
         E3n/8wY/JrN/Yfea1MdEEBG4g6FqKFmFd9PANXjgxJQwSCyjvHIlfAOd2DU5zY478iHG
         L8ww==
X-Forwarded-Encrypted: i=1; AJvYcCWkeNFFGXtmgDd5HnvtcA2Wu2YEGZq37DEN38el1YYucPrF3Wf8oiO47nunZ6/UGixsjlr/FzYNNMK6@vger.kernel.org, AJvYcCXLw9dmnPH5K+fBeySU6djA0eHzUsa1s6tedg2Q5vGNv7snAXUv3o9/20bOCVlrUXQ7jxGalWdWUn+cy3Yt@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFyBba6f+GQcz9sQW2p+O/+vZ18/nJnNdVXaJ4ZlmOLuWXujI
	4cgdu59aG4k/JYG2KTO1m7MIi6q2l46PV88H5qwsj8bYP/MQckzHYJe1W3hGl5E+PpPydoEQLxa
	FMQGYNSpb8+wEXlCVUBBV9kySABeJxzk=
X-Gm-Gg: ASbGncsTTWvQzeGCup0MudySMdyrrDnNebvJ0cuJ7uIJabxHpVhIt1UTfRFENBk7NzM
	ieh8039Hgp5XGVwpm9qUlx8CDu29uJ0yzREvvYw9neWNzX8LOaO1HaoOU6L6TfkiUJEoC+rRRGG
	pK6lz9xmCFLJKNzbXAWix6TQQjiO8NmNsLp4p7IYpiRRaB8y7/Bfsbj3+14A2eTht0+FvLYP1Tq
	WWLwD2Gv/acgrD5sA==
X-Google-Smtp-Source: AGHT+IG8vUHFP70UXed9iRLKIptriKCIABWtAWB4NI0eKfx64HKik6dvxbUYvCeLTR40uVNuIWcVYOwlyUyYpDWTz70=
X-Received: by 2002:a05:6e02:2587:b0:3e2:9f78:3783 with SMTP id
 e9e14a558f8ab-3e29f783956mr91962715ab.21.1753068432378; Sun, 20 Jul 2025
 20:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718101150.3681002-1-shengjiu.wang@nxp.com>
 <20250718101150.3681002-4-shengjiu.wang@nxp.com> <aHp1be6omEO8qB8o@lizhi-Precision-Tower-5810>
In-Reply-To: <aHp1be6omEO8qB8o@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 21 Jul 2025 11:26:56 +0800
X-Gm-Features: Ac12FXxLXoN3PdgILVQcoB0Vod44PqH8KIxOUI90ky-y_nERjNH_OhhfrJs7NGk
Message-ID: <CAA+D8AMz4MAn7M40ipTefXapQ0-KZnUT3H6iVzBscO4UmrK6cw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: display: imx: add binding for i.MX8MP
 HDMI PAI
To: Frank Li <Frank.li@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, 
	l.stach@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 12:25=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Jul 18, 2025 at 06:11:49PM +0800, Shengjiu Wang wrote:
>
> Subject needn't said binding again.
>
> dt-bindings: display: imx: add HDMI PAI for i.MX8MP
>
> > Add binding for the i.MX8MP HDMI parallel Audio interface block.
>
> Need empty line between two paragraph

Ok.
>
> > As this port is linked to imx8mp-hdmi-tx, add port@2 in
> > fsl,imx8mp-hdmi-tx.yaml document.
>
> In fsl,imx8mp-hdmi-tx.yaml, add port@2 that linked to imx8mp-hdmi-tx (
> look like pai_to_hdmi_tx?)

yes, linked to pai_to_hdmi_tx.
>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 13 ++++
> >  .../display/imx/fsl,imx8mp-hdmi-pai.yaml      | 61 +++++++++++++++++++
> >  2 files changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,i=
mx8mp-hdmi-pai.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,imx8m=
p-hdmi-tx.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,imx8m=
p-hdmi-tx.yaml
> > index 05442d437755..cf810b277557 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-=
tx.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-=
tx.yaml
> > @@ -49,9 +49,14 @@ properties:
> >          $ref: /schemas/graph.yaml#/properties/port
> >          description: HDMI output port
> >
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Parallel audio input port
> > +
> >      required:
> >        - port@0
> >        - port@1
> > +      - port@2
>
> Are you sure it is required?  It may cause may dtb check warning.

yes, it is required.
>
> >
> >  required:
> >    - compatible
> > @@ -98,5 +103,13 @@ examples:
> >                      remote-endpoint =3D <&hdmi0_con>;
> >                  };
> >              };
> > +
> > +            port@2 {
> > +                reg =3D <2>;
> > +
> > +                endpoint {
> > +                    remote-endpoint =3D <&pai_to_hdmi_tx>;
> > +                };
> > +            };
> >          };
> >      };
> > diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-h=
dmi-pai.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdm=
i-pai.yaml
> > new file mode 100644
> > index 000000000000..d2d723935032
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pai=
.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/imx/fsl,imx8mp-hdmi-pai.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale i.MX8MP HDMI Parallel Audio Interface
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +description:
> > +  The HDMI TX Parallel Audio Interface (HTX_PAI) is a digital module t=
hat acts as the
> > +  bridge between the Audio Subsystem to the HDMI TX Controller.
>
> remove "a digital module that acts as the"

Ok, will update it in the next version.

best regards
Shengjiu Wang

>
> Frank
>
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx8mp-hdmi-pai
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +    description: Output to the HDMI TX controller.
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - power-domains
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/power/imx8mp-power.h>
> > +
> > +    hdmi@32fc4800 {
> > +        compatible =3D "fsl,imx8mp-hdmi-pai";
> > +        reg =3D <0x32fc4800 0x800>;
> > +        interrupt-parent =3D <&irqsteer_hdmi>;
> > +        interrupts =3D <14>;
> > +        power-domains =3D <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PAI>;
> > +
> > +        port {
> > +
> > +            pai_to_hdmi_tx: endpoint {
> > +                remote-endpoint =3D <&hdmi_tx_from_pai>;
> > +            };
> > +        };
> > +    };
> > --
> > 2.34.1
> >

