Return-Path: <linux-kernel+bounces-780823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A984B309D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474331CC8FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C6F2EACFF;
	Thu, 21 Aug 2025 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtagFIkR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98222CBD9;
	Thu, 21 Aug 2025 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817240; cv=none; b=EhxWBmuNfsVpj5DaUuAEA0qMPBpk1nh6qv5zMD/Wn2OWV6FBX+wJhB40wGexmBBeydS2BY+uobZmXqrnEHph8k1QODsXQLw16SZV7pdpfIrtxR06QPEJLO2LuCP8vm+MP9jQO125jlRLj2AHTShfLAsEs5HEyrN3q9Gq1wsQDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817240; c=relaxed/simple;
	bh=7rA8qT8sloOt+Gomxv3Dk1liyMq9TmAjnM4+H4zgnNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCEz2w2Bj4Rxm9Xpd4pZvdidZk0cJEAIZSEFYgMoFeZK0Xvl6Ea7q3hgplsKOi+W7ZMEwyeHHTMfkzUPborKvwI6agN/+psW4fg7zhiUCQMJ5YBXUEnJo/ZA8uX33Uld7t/NMccqxS361/RjqI522NzeKI9XR2A1ZPGtKDu5PdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtagFIkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6998C4CEEB;
	Thu, 21 Aug 2025 23:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755817239;
	bh=7rA8qT8sloOt+Gomxv3Dk1liyMq9TmAjnM4+H4zgnNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZtagFIkRBhoOh73FBc0x7ALmgqNspRrbh6BmuUp6WEuXtyEux8yoMDvLnF7mWh4gZ
	 PXE49H392eRD9iyygMGGk/bRgRh/3fIq9WybGzxcJ58hueOJpf08zGfKgyhyKwv5fK
	 GSt5FuGAcA+rlzqgpfUYEL+Ii2zot892scxQtsyXnYub2/eZupTrCIDFY9o/5l2vMT
	 weR9WqrCgVZqfSQILqY52+eOQIEHmgWE9FLZpUZze5KkRVikfdG3Y0rF4dl3NAL7xt
	 4bhWYhO6PYpVy51nDJzd/ibMu0PsFE9UajxHXd0IOnbLX/4DG81W/ooKCDDMdjh2eq
	 uwCZbECdBkPVw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb731caaaso227066466b.0;
        Thu, 21 Aug 2025 16:00:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3Tp4It1mjMipQrbB8xXlLuR7JRa3Vk6ss2OUunRQcCyOF/dcSCoU/JH8p/7Lb1TXF62Eh38CaEIKV@vger.kernel.org, AJvYcCVKTUULhEE3Obvl0G1uL4/pIlArevuuHbwrZWFfXETv9MdUkenK4dYn6b6Au6dU0GqC4KYqVktJwpjK@vger.kernel.org, AJvYcCW1XpzvMR+HwTGfyIkYdLRmY6Ca/3g9/sA1Cp4MpU3PgM5O82EmHsAy8aEVUkqbGmR53S7zcZvI0UbgAfe9@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJAM0b1YPWoCUWm8iMhm40hDXFdwt6olk0B+5bDWp01Rx3awB
	ojWyc39TGK0oegMV9HR9xraMaIAKRkMGzxWMCuRPSskJ8c83pugLMCCExqJDTkRjEScV/B66qPr
	ANIfmGbg4fiNcHBQKWzkMat51GR6acQ==
X-Google-Smtp-Source: AGHT+IH5ReMKgM2/3Os0oHRo+pFjl/n9LIXHNBEW/4vyJJ36lhUYYD+Ni5LGTFHEdqrEFWxNcknX16jT/C8BnP/4Q+Q=
X-Received: by 2002:a17:907:72d2:b0:af9:8c20:145b with SMTP id
 a640c23a62f3a-afe28f7622amr76678966b.10.1755817238412; Thu, 21 Aug 2025
 16:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-3-172beda182b8@kernel.org> <20250821163320.GE1270980@robin.jannau.net>
In-Reply-To: <20250821163320.GE1270980@robin.jannau.net>
From: Rob Herring <robh@kernel.org>
Date: Thu, 21 Aug 2025 18:00:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=y2OT4YrzT8z0O0T2hpM5X1k2pFEb8XjBRPoNMdO5kw@mail.gmail.com>
X-Gm-Features: Ac12FXwdtTBi83iz9IiQlPSDZ_3W-XM65JsHn03GR3jMgiJWuYGJBjpjvfkth58
Message-ID: <CAL_JsqL=y2OT4YrzT8z0O0T2hpM5X1k2pFEb8XjBRPoNMdO5kw@mail.gmail.com>
Subject: Re: [PATCH RFC 03/22] dt-bindings: phy: Add Apple Type-C PHY
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Felipe Balbi <balbi@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:33=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> On Thu, Aug 21, 2025 at 03:38:55PM +0000, Sven Peter wrote:
> > Apple's Type-C PHY (ATCPHY) is a PHY for USB 2.0, USB 3.x,
> > USB4/Thunderbolt, and DisplayPort connectivity found in Apple Silicon
> > SoCs.
> >
> > The PHY handles muxing between these different protocols and also provi=
des
> > the reset controller for the attached dwc3 USB controller.
> >
> > Signed-off-by: Sven Peter <sven@kernel.org>
> > ---
> >  .../devicetree/bindings/phy/apple,atcphy.yaml      | 210 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 211 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/apple,atcphy.yaml b/=
Documentation/devicetree/bindings/phy/apple,atcphy.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..eb14010557c94f313b54b52=
8e2d4039fe540062a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/apple,atcphy.yaml
> > @@ -0,0 +1,210 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/apple,atcphy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Apple Type-C PHY (ATCPHY)
> > +
> > +maintainers:
> > +  - Sven Peter <sven@kernel.org>
> > +
> > +description:
> > +  The Apple Type-C PHY (ATCPHY) is a PHY for USB 2.0, USB 3.x,
> > +  USB4/Thunderbolt, and DisplayPort connectivity found in Apple Silico=
n SoCs.
> > +
> > +  The PHY handles muxing between these different protocols and also pr=
ovides the
> > +  reset controller for the attached dwc3 USB controller.
> > +
> > +  The PHY is designed for USB4 operation and does not handle individua=
l
> > +  differential pairs as distinct DisplayPort lanes. Any reference to l=
ane in
> > +  this binding hence refers to two differential pairs (RX and TX) as u=
sed in USB
> > +  terminology.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - apple,t6000-atcphy
> > +      - apple,t6000-atcphy-dp-only # PHY hardwired to DP-to-HDMI conve=
rter on M2 Pro MacBook
>
> The comment is misleading, "t6000-atcphy-dp-only" would be for M1
> Pro/Max Macbooks. M2 Pro/Max Macbooks use the same design so the
> corresponding "apple,t6020-atcphy-dp-only" compatible is missing.
> I'm not sure this is the correct design though as the HW block is
> identical to "apple,t6000-atcphy".
> I think it might be better to have either the DRM KMS driver or a
> custom DP->HDMI drm_bridge switch the mode to DP-only.
> Or atcphy could initialize itself to DP-only based on the available
> ports.

Doesn't sound like this should be a different compatible. There's a
'phy-mode' property or you can define the mode in the 'phys' cells for
the DP controller.

Rob

