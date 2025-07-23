Return-Path: <linux-kernel+bounces-742027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB194B0EC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CADB1AA7322
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D43727702F;
	Wed, 23 Jul 2025 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwOLU19V"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0EC2441B4;
	Wed, 23 Jul 2025 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256412; cv=none; b=YK0rdp8QaEYpOazBjrcTA5PUbzKlXo0aldXU02Sy0n16bJh+RUQLZC9suwOWTLdY+GXALa11VQkbxNWvgeK5qC57rxWXj70XMf2BotlWeH5wJEQSEGX65Amnc+O2BhgL+IdXbPkvBoK0JKoE/oD2D/1m/1FxXs7FiuPxkWceuuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256412; c=relaxed/simple;
	bh=YsVapOu3EE9tFDs0Jdu77Bx59dIcgo7GphpDAmjUC1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxw2FjtwVu4wrO82L7fvrl9esOLZVVDs9hlotH6InhzD981iZIJIIpjYYdNp1opBdBiZVpGkaTYwR+7Ic6yV78VZlLe+kJh1XeNPFZN1bnG1YGXE+ZFbpCqzhQR2T65GodS15KGd4MG2dGBAqK3z1+yWDzX+MdU37rk7y9DHzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwOLU19V; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddb4a7ac19so26239265ab.3;
        Wed, 23 Jul 2025 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753256410; x=1753861210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbcyqc764F2sEfaCBH+UYC7rWjF6m5+2vt4yx/ptU5M=;
        b=SwOLU19VZYsydOYDLnHpGicAWYpyMk+qxOd3hel4l6uqT//ajR0hAQNF6U8wdhlov1
         n8d2TSuQCBIcJdm/Ij6HxTt7QvYeNTREeu+l+nFz2K5ZcY7K+ViFJMUlHxvJxgby+Y7a
         80cWD6qZ/2A7pfQuLDZL+O2R05yjMFzr3TE22iaYE6GCt4oSR0cV1B5six7brfImr9Sv
         bd8E2jonmikuU7qgPLDLimjQmhXOB2sH4AvUIPFsniNHzosd13401dQ/9eScHqa0GbpZ
         56Xd1EMdr2JDpEQnnMrEriRIV1d88TEVaz8dwMHh8D+6lSdOAXPW80r5G9727DARAR37
         fFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753256410; x=1753861210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbcyqc764F2sEfaCBH+UYC7rWjF6m5+2vt4yx/ptU5M=;
        b=QOig9MZH1zI9OlYAXYWmHZv77kQyE9g8rHmSZB8eTgD3ip/r+OPdG198Qgr46CnWZv
         NeNBug3S/S5Y9iCyDhfMbCf1l/reKU48B/cAMmXQPm1nIfM0XMvSlkyQ7Ze1fbjoqzTB
         dKEF0TXjC3MkbEjTSiHr5JSpdOAMYZaG9Z8uvt+qsuv8pAWBpm7xn+JE0+hojT39NaeB
         zCvKf2F4mFRaV3TJERG0jBPecZNnFtQ8weQIg6gNmY6hKYg3UnqBxv0dxXO5nGk2qaw5
         cFSpTlDFq0/EpoNZrF0zpCQ2UilWVUth0ZUGNydjsXbeKeNuS2OtQLQn93XiqGdTc4km
         8g1w==
X-Forwarded-Encrypted: i=1; AJvYcCVSfWc/1M5y4yQgLCl3HtL1tdhIUI/2wGYgrAUfvcDHZ1qVPTIY+ksdgT4dfLRkorOtCBCHuKftc49G@vger.kernel.org, AJvYcCVdAfxnvEswyBmrzpL1vBGk56w/L6Gld/oksy01jzKLWlT5FhJoUXlLMEeYOYEmAckVrrMMWY58KK5QNupJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxirEE0QC+IbRZXzgkLTqxXT8t11ODBpLB/S9D4oo2tmleumEij
	xp3Bui+sHiZJhi+lFkyeb63DipAGW1INRwsofTrvdtqs6DREedFR52u9EilR+oStr9r58A0vm1V
	8Rx11+6KpSb6dWPVNik8JKozlsfNQOME=
X-Gm-Gg: ASbGnctuM+MUdP3Rwfli6zg0DdgtrcNCewCzVKjTHvfzKtzGn83VAytdB18wtcPe0Ml
	bCf8qqcZ05bTtkcLDO8MGmzl/DeluatkCSLwp/hhW1Fo+AEz8POD2l5pMyJSHiA6dMVbYgB15ar
	Db3H6wS63KWho/6wBiikimm5E5LWTNPSIY946dE7jpJd3WuJnb3eQkq02JUZLkENwFALLZ8hs/C
	l8HzrI=
X-Google-Smtp-Source: AGHT+IHOQzFpAKaWouHfVtjkvOSjGIpAMkfJ0fzLv3wWAksIErfPgEwi7A4hu+IQvIt5kc5elxr2GeZinpnDwDpuoiI=
X-Received: by 2002:a05:6e02:2483:b0:3e2:99f3:9c5f with SMTP id
 e9e14a558f8ab-3e32fc0705bmr33701305ab.9.1753256410269; Wed, 23 Jul 2025
 00:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718101150.3681002-1-shengjiu.wang@nxp.com>
 <20250718101150.3681002-4-shengjiu.wang@nxp.com> <a5621775-5032-4422-80bb-5f8f60351dbe@nxp.com>
In-Reply-To: <a5621775-5032-4422-80bb-5f8f60351dbe@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 23 Jul 2025 15:39:56 +0800
X-Gm-Features: Ac12FXzRGVFmJEyGYLyQXwRt2VBDjuGoJJq-BPWCprf56oset2phf0Q2wkTdTTc
Message-ID: <CAA+D8ANb7kZETxO_CQazoz6-DiNCOGivLhJVwhw9p78ynP1ntQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: display: imx: add binding for i.MX8MP
 HDMI PAI
To: Liu Ying <victor.liu@nxp.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 3:16=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote=
:
>
> Hi Shengjiu,
>
> On 07/18/2025, Shengjiu Wang wrote:
> > Add binding for the i.MX8MP HDMI parallel Audio interface block.
> > As this port is linked to imx8mp-hdmi-tx, add port@2 in
> > fsl,imx8mp-hdmi-tx.yaml document.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 13 ++++
> >  .../display/imx/fsl,imx8mp-hdmi-pai.yaml      | 61 +++++++++++++++++++
> >  2 files changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,i=
mx8mp-hdmi-pai.yaml
>
> Usually, to add a new driver, a DT binding patch comes first.

ok, will move it to first patch

>
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
> Can port@2 be optional?
> Note that video output can work with only port@0 and port@1.

yes, it can be optional

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
> > +
> > +properties:
>
> In i.MX8MP TRM, HTX_PAI block diagram mentions an APB interface.
> Does it mean a clock is needed?

The APB clock is bound with the power domain, so no need to add it here.

>
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
>
> Why do you need this line?

per my understanding, this line can be added or removed.

>
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
>
> Unused. Drop.

Ok.
>
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
>
> Drop this blank line.

Ok.

Best regards
Shengjiu Wang
>
> > +            pai_to_hdmi_tx: endpoint {
> > +                remote-endpoint =3D <&hdmi_tx_from_pai>;
> > +            };
> > +        };
> > +    };
>
> --
> Regards,
> Liu Ying

