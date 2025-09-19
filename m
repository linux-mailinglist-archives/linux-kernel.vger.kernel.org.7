Return-Path: <linux-kernel+bounces-824833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E74CB8A3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A598D163DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E3316919;
	Fri, 19 Sep 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGaPJcP5"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8B261B6D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295163; cv=none; b=OYNJiFb5JGav4ffJAOO/ukag8ed8KRDrFTi36hrXPyUV1pXSj6YDvFhCeL0pHDyG5bTOROFSV0zAhzYDn4HNWQ1eJrMyzHPKW4+kOShdjFityuiMxHL2RcqmMHtQEjAvoJpMIw/8n90vFXu+Hm82JTEuZjTz54yzsV+LwO42VpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295163; c=relaxed/simple;
	bh=88M6rHSLlPFVyAjo4HogX57EduLLErY+swc4NMImAKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzAq2eNJHWBWSFotH2jaK5j3IxBOW1Ai6Wxo3CD+Y3O63AS2w9FIg4yIEhjiTFdqtOqBzrzYbbh6pImNgfnAlxEtpQJFOGqhuZamw74Noi2glit2ml1s2emNv34pmQnONwfoZroDtF6bGQLa2Agc1t244gCGKh3QTgQm8r4ucIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGaPJcP5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so20460605e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758295160; x=1758899960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmIZQg/p+wsk73O/7IQ/2J8qTtcW5vWlRDzFnnbt5FE=;
        b=LGaPJcP51bo29jFvjZU+mJwwyz8cd3z8yWJbPZqwoYC1soFQPkFftfy36lKeqFN6oY
         ISzu+7uNDVxKeM/T414olbEsUUpbXV+H3J//JUHR9qMB2Vg1eNJzqcvVZLYeoQnwfGIc
         c/JzvdSI0OfNEqcMX4EqLRR+AoUgOajgPN5p9LFu4TvCab9ldByvB1ANyv15rqQIcVIY
         tA+fbB0TOZILH3ISg8yMLuQn/1w2ZWQN1fGeX9hgSI/pxQnmcQtWTqjvhl22ORmkxKAs
         WUNxNLVWVz7S5eJJfEZ/aQNbp/VC4lsc6sLVEdrbIQL9ghhiMqLO+BD7kMkFMlJ8fD8F
         +ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295160; x=1758899960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmIZQg/p+wsk73O/7IQ/2J8qTtcW5vWlRDzFnnbt5FE=;
        b=OfO9RobBUPkfo6iwdMSrPSkfCFNnT03dGxspoUjSL7xP/n18Ca/twVqGzGDob7u5yM
         qFJH/g+Iu1tVollyIQ1LIwetmJ9zEo/z6MvsEmsTUiMeLTUl4YHOVXiF7tSE7XMa2AC9
         Lg7zvXw0xYI62F+wFu7+soTU9RgroXOB87+wBHpPY6za9+6IoOxC1reE7TcFHZnXOeDw
         Rl1ciwxc3LhUsJNVYeMHa5T/18vkMGHVlEks7nhDJrv2Syk0HxCJCoOLefPlDHKkdk+/
         /dHudoYieu9iQtHmkHvi8UxyCbLfCUDzuLXahiaGgtA94C/E3kVOdSSym7v94mtA0MVb
         We+A==
X-Forwarded-Encrypted: i=1; AJvYcCV500C1xJDn4blRqn7gSoo298hWOSfXJ20xNh+2UxAA5YGtwXYGohXIcjtgktaqKov2L0w2oYRNvLrrudE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfE8DdQLiRKrWniI/aB2sEIx4ANL+4R9zwG70bTpIf18s+ve3S
	TfqJPVMJzzRbyPuH6O2cX3ziEUQ36yTWWPH+53HNgxURLSyMJ2Wek4kcnr39l2s3NDGeEA8XS3a
	PH3E1XyvVJ4Jx14YjMjLzhhrYRO6qHrg=
X-Gm-Gg: ASbGncvjE4/dGez1ygdCqMLq8YMzNF3yCZ38pNJl08bySYrr7Mft0rJGHvhCexG/+le
	C47aYvjbf2664kVqKK96jWdAmyWEnflSjOBXendQkHeo16ObGNNoyWXHLUzuzYPo4UGWU5Jwvga
	7LHxXAjonou66LVC08bDz4Orh+MN8wtzGV45kG9ECCtmaE2leOEgV15IqoP1Sk87Di0jTycc7Fo
	CDQtVZV
X-Google-Smtp-Source: AGHT+IEgDPEnhQPRnnEH3yzuZMEraGTWgDOPI/yCagFTF5k+zG5oUinI/JMOdDHldD4AWPJfCuYA6PY7j0z7U7Vj7PU=
X-Received: by 2002:a05:600c:8b4c:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-467a7f111camr42527475e9.7.1758295159374; Fri, 19 Sep 2025
 08:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912064253.26346-1-clamor95@gmail.com> <20250912064253.26346-2-clamor95@gmail.com>
 <bdd942ef-1ede-4f9f-ab90-ea7ac8995b92@linaro.org> <CAPVz0n1Ac=opNj=qAM5Rp0fpDo-6khCdmhoCwkztGLosKV31tw@mail.gmail.com>
In-Reply-To: <CAPVz0n1Ac=opNj=qAM5Rp0fpDo-6khCdmhoCwkztGLosKV31tw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Sep 2025 18:19:07 +0300
X-Gm-Features: AS18NWBYrUfprQab9kLOINFBMV1nhqiBixHyzPLKGA0f4GLaKH_9AlhIHvotelk
Message-ID: <CAPVz0n26P7Bb6MvaJ2S1-HN-0Oya2Z6SMCUXYjxxctFowuq-eg@mail.gmail.com>
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

=D0=BF=D1=82, 19 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:45 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BF=D1=82, 19 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:36 Ne=
il Armstrong <neil.armstrong@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi,
> >
> > On 12/09/2025 08:42, Svyatoslav Ryhel wrote:
> > > Document Sharp LQ079L1SX01 panel found in Xiaomi Mi Pad.
> >
> > The patch doesn't apply on drm-misc-next, please rebase.
> >

Ok, I see where conflict is, I will send rebased version within an hour.

>
> Sure, but I have synced with drm-misc-next right now and it applied clean=
ly.
>
> I am on top of 048deed5faf0 (drm/drm-misc-next) drm/panel: Add support
> for KD116N3730A12
>
> Top commit is correct on my side?
>
> > Neil
> >
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >   .../display/panel/sharp,lq079l1sx01.yaml      | 99 ++++++++++++++++=
+++
> > >   1 file changed, 99 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/display/panel/=
sharp,lq079l1sx01.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq=
079l1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq07=
9l1sx01.yaml
> > > new file mode 100644
> > > index 000000000000..08a35ebbbb3c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx=
01.yaml
> > > @@ -0,0 +1,99 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/sharp,lq079l1sx01.y=
aml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Sharp Microelectronics 7.9" WQXGA TFT LCD panel
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +description: >
> > > +  This panel requires a dual-channel DSI host to operate and it supp=
orts
> > > +  only left-right split mode, where each channel drives the left or =
right
> > > +  half of the screen and only video mode.
> > > +
> > > +  Each of the DSI channels controls a separate DSI peripheral.
> > > +  The peripheral driven by the first link (DSI-LINK1), left one, is
> > > +  considered the primary peripheral and controls the device.
> > > +
> > > +allOf:
> > > +  - $ref: panel-common-dual.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: sharp,lq079l1sx01
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  avdd-supply:
> > > +    description: regulator that supplies the analog voltage
> > > +
> > > +  vddio-supply:
> > > +    description: regulator that supplies the I/O voltage
> > > +
> > > +  vsp-supply:
> > > +    description: positive boost supply regulator
> > > +
> > > +  vsn-supply:
> > > +    description: negative boost supply regulator
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +
> > > +  backlight: true
> > > +  ports: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - avdd-supply
> > > +  - vddio-supply
> > > +  - ports
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +
> > > +    dsi {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        panel@0 {
> > > +            compatible =3D "sharp,lq079l1sx01";
> > > +            reg =3D <0>;
> > > +
> > > +            reset-gpios =3D <&gpio 59 GPIO_ACTIVE_LOW>;
> > > +
> > > +            avdd-supply =3D <&avdd_lcd>;
> > > +            vddio-supply =3D <&vdd_lcd_io>;
> > > +            vsp-supply =3D <&vsp_5v5_lcd>;
> > > +            vsn-supply =3D <&vsn_5v5_lcd>;
> > > +
> > > +            backlight =3D <&backlight>;
> > > +
> > > +            ports {
> > > +                #address-cells =3D <1>;
> > > +                #size-cells =3D <0>;
> > > +
> > > +                port@0 {
> > > +                    reg =3D <0>;
> > > +                    panel_in0: endpoint {
> > > +                        remote-endpoint =3D <&dsi0_out>;
> > > +                    };
> > > +                };
> > > +
> > > +                port@1 {
> > > +                    reg =3D <1>;
> > > +                    panel_in1: endpoint {
> > > +                        remote-endpoint =3D <&dsi1_out>;
> > > +                    };
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > +...
> >

