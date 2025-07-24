Return-Path: <linux-kernel+bounces-744051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D92B10776
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4AF4E4A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9708925F980;
	Thu, 24 Jul 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDr6LT7X"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018A25F7A4;
	Thu, 24 Jul 2025 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351824; cv=none; b=fKNwJcyyeQ0xzv0ZzNJ2Ep5Q6KTLJrkUyRrMsRPbCal7SAvLTeSoZchoJgqPO7HpcW5rQ/oRW3Spa11jrrjQn1HJ3twgILS2hxZilJOxCRoJNblndQETHrI4cOVLxv/plvlKX+3X8ijeAocz8zIPZGyTTgSFYpUNcjhLg1EL6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351824; c=relaxed/simple;
	bh=c7QMAmpVaB48eq1HG5t3StXl8CnTj69VjPU/BHyPuSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nc0bS9S2qlMnF3d++4aEj3sUMl89RA2yOULUqwckJNrNSwy/guLuBkkxC/96v+vBVWb8uAelHNGed/ksuDO4/R7ibLkQsqpI7qPZT2nHmEhAv19E/iycWXQ9R8TV7vLWtKxd06xrVluYVvaExMuC3urU568X0aSQIVwbecBeZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDr6LT7X; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso6671715ab.0;
        Thu, 24 Jul 2025 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753351822; x=1753956622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+meAXBdOYjti/xHVnSu9+/vlo6BxGcgq1eAbTOjxvs=;
        b=gDr6LT7Xzv9hLLY/xA+SbN59y97bbeqphDs981wuJGdMlGhxlnzv/4wT6TAwkiPCvK
         1ppjSb607Cjqc41yDXdFxtbZayIkvRRErJv7Zkg8SHpy3u9N7O7btopDWgrIgIrWiVzx
         xnqMsJdHt2QDqBEY6I1DpcYIcORLtvLRJYuHSRyJjvI90/2ytwEBztyiubwa3yFpyZQ3
         H96/a/Z66qG2GoTvioCkjchd5eYjAa7PwiUqA1Ybnk7A8ajxSLvpuv7MN+twMup5+1z2
         2w/j0b5ltF/4h4KGV2e2whkI469FbOtzBA6pVOLfEbSLpD6bo5XAn9S4NEk2proNfs3B
         C62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753351822; x=1753956622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+meAXBdOYjti/xHVnSu9+/vlo6BxGcgq1eAbTOjxvs=;
        b=qKxySJnZVk9ClXTRsH74T60eqJkpPApwbHncV9JIfvY63v9+JbdvLGJby1g4reaeCx
         f3zaqsWHTtRbUiMUmndvwo6OrduixI48GOLb2BHaBoyYyAzIeM/NnAcJHGoOGMGxcfLL
         yiPmoGXvLkSNCFrD0kZxklMzqdGZUXFwxw87TY/fd/1TUNnyVHdS80ZTxfFO6yttkepg
         jesyyvVocJGcWMFIg/MrJelUMfMQeDkxyzZisnQVnpqnZi0miMbqEmjmTTEiv1DIlKLi
         gYyEXT3UmvbMhDcMvt1Ucr0I1Z4HSqeNoN/MEXJ9px4E7TU7mL6xHaupnXXpXVm2p5AS
         ikSA==
X-Forwarded-Encrypted: i=1; AJvYcCV+e+su+k0YD8LM6nY9CVtyDIOpwxcbkEfFZvCFzgA51aP36Ce0JlDKEJHaSoY4dPmJZ+nt3dLaNPY7Tgk=@vger.kernel.org, AJvYcCVj1NpCXDI3FpEGv9fKdP4zzkurgdGbyrnVX7pzqGRLyleQQz5lXqJuazbGyPv0hTmlI2JJguj2Iopn9bCi@vger.kernel.org, AJvYcCWp+KaDO2cxXwLQnwxNa72HLDeZ/HH447Cnpa4TruBRmq3QdcBDp0q9B3OpKzWtCZnwjWOEQEScHZFf@vger.kernel.org
X-Gm-Message-State: AOJu0YxLynVV5j5tvOzbXsnzFg82FJRZZT5Lnpi6DvGb5TtTjS5sNCOX
	Vs5wv9BMAoaiccAgw++vwIwx/cVl+kpa51LXlDtOFfgHlo5ewttJawlJyDKMZZSHTeWnD8DsltR
	pjesG7F60lSMRl1/lFSXYCWQiDheDVwkrkrB5
X-Gm-Gg: ASbGnctwzpEc5rtArnNG+aYcJOYu8sKFIIn1Ll2cbX1l5DtnqayFSJziTciFHNrlt8h
	xcC/0fgzTXIY6Wl3LhnLXCfVJHH2AJ1SHLAYe6ksT/v4cBIIOjCDuGHYuOesCieL5wyZkmBkWD1
	D/bLx2c1KYHjbNmitakKY05lg43EzZrXIQz+OQtyoPhxAkwsImv3t2TAZtN1DZ0WH/bHO8vyquO
	qWU7H0=
X-Google-Smtp-Source: AGHT+IF7M0baFlK3062K6BXEoa8kOdw9KDdHsQbjFyV5neQ+2sKDdzPXmbuSGlkwEtGraleUJvxc24KLjX8I3/Jqb8w=
X-Received: by 2002:a92:cd8d:0:b0:3dd:d321:79ab with SMTP id
 e9e14a558f8ab-3e335535dc5mr117038895ab.18.1753351822074; Thu, 24 Jul 2025
 03:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724072248.1517569-1-shengjiu.wang@nxp.com>
 <20250724072248.1517569-2-shengjiu.wang@nxp.com> <20250724-straight-lorikeet-of-novelty-9124f8@kuoka>
In-Reply-To: <20250724-straight-lorikeet-of-novelty-9124f8@kuoka>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 24 Jul 2025 18:10:10 +0800
X-Gm-Features: Ac12FXwoUiu0ZopeKo51pKtd4fVW0e5JyUbFY0Gq7Yw0jp0bxpzJja68FGRxr2Q
Message-ID: <CAA+D8ANV74k1=_m7HfCO2n7nCU7mH=QMrd0CS5eMqGqDHn9HEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: display: imx: add HDMI PAI for i.MX8MP
To: Krzysztof Kozlowski <krzk@kernel.org>
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
	l.stach@pengutronix.de, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:52=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Thu, Jul 24, 2025 at 03:22:43PM +0800, Shengjiu Wang wrote:
> > Add binding for the i.MX8MP HDMI parallel Audio interface block.
> >
> > In fsl,imx8mp-hdmi-tx.yaml, add port@2 that linked to pai_to_hdmi_tx.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 12 ++++
> >  .../display/imx/fsl,imx8mp-hdmi-pai.yaml      | 69 +++++++++++++++++++
> >  2 files changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,i=
mx8mp-hdmi-pai.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,imx8m=
p-hdmi-tx.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,imx8m=
p-hdmi-tx.yaml
> > index 05442d437755..6211ab8bbb0e 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-=
tx.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-=
tx.yaml
> > @@ -49,6 +49,10 @@ properties:
> >          $ref: /schemas/graph.yaml#/properties/port
> >          description: HDMI output port
> >
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Parallel audio input port
>
> Which data path this represents? Feels like you are duplicating ASoC
> dai-links/cells...

Here it means from HDMI PAI to HDMI TX controller. not the ASoC dai link.

On i.MX8MP, for HDMI audio, it is separated into several hardware modules:
1. Aud2HTX
   driver:  sound/soc/fsl/fsl_aud2htx.c
2. HDMI PAI
   driver:  this patch set
3. HDMI TX controller audio part
    driver: drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c

Aud2HTX is in the Audio subsystem,  HDMI PAI and HDMI TX are in the
HDMI subsystem. The full data path is
Aud2htx -> HDMI PAI -> HDMI TX controller.

>
>
> > +
> >      required:
> >        - port@0
> >        - port@1
> > @@ -98,5 +102,13 @@ examples:
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
> > index 000000000000..4f99682a308d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pai=
.yaml
> > @@ -0,0 +1,69 @@
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
> > +  The HDMI TX Parallel Audio Interface (HTX_PAI) is a bridge between t=
he
> > +  Audio Subsystem to the HDMI TX Controller.
>
> What is Audio Subsystem? Like Linux Audio or some name matching actual
> hardware?

Audio subsystem is the name for hardware.

>
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
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: apb
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +    description: Output to the HDMI TX controller.
>
> And how do you plug it into sound card? Where are any DAI links?

The hardware data path is Aud2htx -> HDMI PAI -> HDMI TX controller.

From a software point of view. the path is
Aud2htx -> hdmi_codec  (ALSA sound card)
hdmi_codec -> dw-hdmi-gp-audio -> hdmi_pai

hdmi_codec is registered by dw-hdmi-gp-audio.c,  hdmi_codec will call
the function in dw-hdmi-gp-audio.c, dw-hdmi-gp-audio.c will call the
function in hdmi pai driver.

Aud2htx is cpu dai in ALSA
hdmi-codec.c is the codec dai in ALSA
Above is the dai link for ALSA, they already exist in the kernel.

The HDMI PAI is the bridge, which is covered by this patch set.

Best regards
Shengjiu Wang
>
> Best regards,
> Krzysztof
>

