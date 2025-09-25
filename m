Return-Path: <linux-kernel+bounces-832677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFD6BA0144
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1341639E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3536E2E0937;
	Thu, 25 Sep 2025 14:53:05 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0742DCF77
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811984; cv=none; b=lKfPF/U8At0abm8DPIX7bKFwTe/MveBbhn3p8nL8yN5cxl0erQQjj0juTdgEZ9sifC+xZ5tIL+SmOuU2aWJhA/ERmixFgyA9I4RtUaxpzqXajYj1qj2mYY/G4ZvYKjRCLyFrUtmsvFvEYgNGSpVLU3NifeJxoYvUDUNupERFERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811984; c=relaxed/simple;
	bh=ZXJMMFCZDGimdSoFUJxE3pUZd+JGKjmvs7+jQKpoKQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGFpXXZjWx93ts/zbDmmfqRB45nWKtKGehcpNGplfYIlsR+ryW+1jEb04MBHJpQkarG7QF1+qrAitKi4U9fJNA8arjGC+VnKIcluzKN7GUFzcWCF/HnQbBMtHWvP/1yWYT8bLO5aiGUQvM+mvUaM+wy2D7rEQbYyPlz/K4rlfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57ea78e0618so1002228e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758811979; x=1759416779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlO5HN86Kc6YrRTCW9kNidWKyaECOConDbUQtE/vSBs=;
        b=LFabxrM1P6IH7VcU57cXkfDuQcabtmhgXtLFAX6FEm8TyXuarswQVzCnBWKY/rtr3G
         TWkM/tEEXIAQF2ueo8ad+mWSPj68AAAxuMujx2QfkhnXKhilisD6H+JmRlBTKryb0FeJ
         UICUh3nrtW77k1cVmDqoV+sVcVauu9btf6PH1a8dabTruEE12ZtiwK/VKesNC8coF625
         gB5NEfDp26iNg08n57OFPtU6O2zED4FACNNs0Z4ODBJBugR4nMYcCL/q91s79k3XL8vs
         wuCTRzub8PkYAlU0i0GYWGTxg55Ngn/qN5u9kzogXfb3wJnMcvjqdFAeoDm+CrxyDzHZ
         OP2g==
X-Forwarded-Encrypted: i=1; AJvYcCU4qG1Z8gxVssoS4kdU2MjBtX99mdB4hD8jDdgZjpxtivd3pNettrlZNcbdPH6ibKeuO7IU4meDh9UFdFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEdDMQ+IxLDsu+k/sT9Fh3spmlZ2RIEkZWWIg6896cSXhfCZN
	TyiEFNzyY5WtbNNYournyc5Fe4ogmjqYjXVTyV5x8xwgcyT20+SdA4rO5ecaTN8X
X-Gm-Gg: ASbGncsvBco1oNtDLEfnVpYP5iIv/BpZUKLOic0RWNotRWBINX2bkLNyYkkcqDAUNju
	d3WDn0vApYtCgkUziodH0ATaVhHoTWOMFqir+NIcHbDLbutzXajPiACf2NcggHwlPF+RNscetjB
	Gf2STAa+40egJ7pi7hU6YerLdxr4gi4WKiBkH3YDA1zmYIG1elFmjjtCaaep9Rb5drrDvHQohyH
	Upn3eurAL3WjPViKDHTPMxSN+kgikXm35kO2vao4b0OvGeo9HcM1nWF0AaJjcWe2kfowvT4ZIda
	qT97ZmVHPKwHE/xmDQIuqV5v3HGcWujZJwkNVdhVU52qIqL0B6ctgQ2MvulaABBg1dPiZx/fSdF
	YVe0Zb5UQNpErG4Qb6S/8tTVtsBfBw+ZHhya+HMncOf1L01kVUHDxfxY=
X-Google-Smtp-Source: AGHT+IFe5pG0dfSLce3w18AatLggdwELlUpJgNjo52SZse9km6M5nLr/dInp9FkvmnK4AiUqLHteFg==
X-Received: by 2002:a05:6512:130b:b0:55f:5125:2d7b with SMTP id 2adb3069b0e04-582d330032emr1130444e87.51.1758811978807;
        Thu, 25 Sep 2025 07:52:58 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665624esm844623e87.69.2025.09.25.07.52.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:52:57 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-367444a3e2aso12077441fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:52:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWijn694k+qJuyR9j1SuBsL44FEDjKvL46tTs3Y06JaJ4RscU5iH5ztHB1irFfysQ/JPJB94G9qTKfK5eY=@vger.kernel.org
X-Received: by 2002:a05:651c:150b:b0:333:b6b1:a151 with SMTP id
 38308e7fff4ca-36f7cecce7emr13436431fa.7.1758811976957; Thu, 25 Sep 2025
 07:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919000020.16969-1-andre.przywara@arm.com>
 <20250919000020.16969-2-andre.przywara@arm.com> <20250922181611.GA567602-robh@kernel.org>
In-Reply-To: <20250922181611.GA567602-robh@kernel.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 25 Sep 2025 22:52:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64KvnvSy0-MYd7FBLVKeJQk=-=VWxRLsHXMP1+MFOPPfg@mail.gmail.com>
X-Gm-Features: AS18NWC5SLylzS53NFTh78yeOtaf2DKHmvxRwMULDvXeTqI87y6sQlGtbhqXD2w
Message-ID: <CAGb2v64KvnvSy0-MYd7FBLVKeJQk=-=VWxRLsHXMP1+MFOPPfg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] dt-bindings: mfd: x-powers,axp152: Add polyphased property
To: Rob Herring <robh@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Mikhail Kalashnikov <iuncuim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 2:16=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Sep 19, 2025 at 01:00:16AM +0100, Andre Przywara wrote:
> > Some X-Powers AXP PMICs can combine some of their DC/DC buck converter
> > outputs in a multi-phase fashion, to achieve higher currents and
> > decrease the output ripple. The datasheets call this poly-phase. This i=
s
> > programmable in the PMIC, although often set up as the PMIC's reset
> > default.
> >
> > Add the "x-powers,polyphased" property to the binding, to describe thos=
e
> > pairs or tuples of regulators that should work together. In the lead
> > regulator node, the property lists the phandles of the connected
> > regulators. Just an empty property means no poly-phasing.
>
> Don't we have a coupled regulator binding already?

That was my first thought as well.

Though on the driver side, I guess we would need to add a coupler to the
axp regulator driver to handle the polyphase case directly, or somehow
tell the regulator core to ignore this property.

Unlike separate regulators that are ganged together, in the AXP PMICs it
seems that when buck outputs are ganged, only the controls for the first
output have any actual effect. In such cases I don't know if we should
just ignore / leave out the secondary outputs from both the description
and the runtime state.


ChenYu


> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../devicetree/bindings/mfd/x-powers,axp152.yaml   | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml=
 b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > index 45f015d63df16..260c4c0afc475 100644
> > --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > @@ -304,6 +304,15 @@ properties:
> >                noise. This probably makes sense for HiFi audio related
> >                applications that aren't battery constrained.
> >
> > +          x-powers,polyphased:
> > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> > +            description:
> > +              A list of phandles pointing to other regulators that sho=
uld be
> > +              polyphased with this regulator. The linked regulators wi=
ll be
> > +              synchronised with this regulator, within the PMIC, but o=
nly if
> > +              supported by the PMIC. An empty list means this regulato=
r
> > +              should be configured in a single-phase setup.
>
> phandle-array is poorly named and is really a matrix because you can
> have arg cells. So you need:
>
> items:
>   maxItems: 1
>
> And is there an outer max for linked regulators?
>
> Rob
>

