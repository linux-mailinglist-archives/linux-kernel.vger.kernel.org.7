Return-Path: <linux-kernel+bounces-839830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ECCBB2830
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA091C394E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F7287245;
	Thu,  2 Oct 2025 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM9W3bu+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC1267B00
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382078; cv=none; b=q98uw/7sxJVrcApW9XDNgu+4pVAHvBccmuThK6lqMjZOFtbvdt5kOmxsd3ju7m42CzJn7fKwQflxJY3MEO56G6czpwG6UnX/pQiuXPxNWuAdGale2ElHBbrFvZMGMkp/ouR7jfbCP95/ixKKezsVUUCGPGu7DDE7S6PLOu23pZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382078; c=relaxed/simple;
	bh=e8rPa43+g0cC8AQUFTt5/tjbOTK8At5/odqqFdlYePg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvFQjPrP4xvZpxrDGu/yYyBH000zjVedQsrt3PdItHev97D0NDBSSDpk7qn1JIjM0VScxwAZhtmuc/lJwdWEhwcOwN0JT6X8ip3RJr0luCWLVst8+hzCSiK+NcRY6qU2Kp1U1Mgje8VmZYfDCT/ur4fnCVOOra2S7DEch54d6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM9W3bu+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so5253545e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759382075; x=1759986875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSxj89clgP9/epwjX7kNoyqXr3MHcjlhiguFCD9is4k=;
        b=WM9W3bu+Di5VUyKk997dJCe6mXvCDO5rm7juS6Mt5h7RQvdUEQGjLxEriis6xZcrGG
         /eYPQvTtqc6cjt9z+GUfS6b53XnBzD03StNUFlB0gFhFPsDnKASjFo51TmYRMfAZuKWH
         0oxoNyAW9rJuyAFaUtnQp+fiLBtuByaYJB5NNd4FreMdSNCbtz0i77IR10Pp/MvVNQoy
         FkG+H/NQRs0vpxa4DN6Nxk/U5iia813YK4bPPAPbN2LsYLfpqEFPgjMY97fz5O4kXb7o
         NN/A6ojQxQWqMwK3/q5ds7jhLXSeq8PMrJJNR/DcBcCwghWENcbntdET0v8OQekLh42O
         fr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759382075; x=1759986875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSxj89clgP9/epwjX7kNoyqXr3MHcjlhiguFCD9is4k=;
        b=e9wb5VIsSzaxtGKFxM3CcBKAF/AnirBHMI+WzT6SiD/j+ID0v7rL7MjFAzU26qvr7s
         3QrnphFFoS70gaBnXwak4UueS66z8IK34xvBgLkAeyMCgOwUJvLP1Krb49sIBeIkQOwr
         vHsufKU6ENVWiwsGQaEw+AaRsEak6iecc6xCoT9mAWm6nefEeOoPUnPeou3qRBFN0xkG
         awDVCwuf19bE8AKk4q0wEX5HB6JbVRIdEnJabj4m/5mqD8m0isSEZJBUO72JQMyb7lLi
         nnD5wDFP/hf1JYo2cWyOCGQGLYbXyiuF+pP229ov846OUIwQTU015KfyLyPMt89jKlZI
         yMdg==
X-Forwarded-Encrypted: i=1; AJvYcCUj1blB2ZZM/TfgYtgfqQ7ir9mfRJ0rK6NlvNh/fyWZcPHL5T/MuoaMySN6JApA55VMaPfAbmO+TV7on5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhwd6HGV3oGZFNxd2nvqkDWYyS1fR/0xCYLRCjg4+p948WUOIN
	GLuS0T39RJtLhw0kRhEU3W5aIcCZCn7Lcl29LPg9lr6jEZObu4dkhFEpGGqR4u4u0VZOhf67Pl4
	kIg8nnmCgxoKAmUgUxt3//gSv8lqjETM=
X-Gm-Gg: ASbGncu8OWEhJWAHi7cxSwDJEQz7fI9WUUT2YgWWo8kw47GnkoU/7IVQod5FkP1Y9fi
	cXWHZLQCBlVIV1qY2OlsoeW3dQM2zn7Rt7vFBD8mpiZW/Rg4y0T/hpzu27dB2wpSi0xb31zfbMM
	4fKKMyRp0xtOrvZfLnN0JBWcJAVuTqe9pY912Rs1LKd1eF1WCt193JobocClBzwdOAK+AKfNWhF
	DMCg7Z2oTwfsecTtBUYuiEKJyO8SVbS7lWQRi4pZYo=
X-Google-Smtp-Source: AGHT+IESwbqiCSEMELDkv5LXWwnsK0WT95NSCj1MTb4h7Wf7kCcDY7VLOonc/BinFz92wRYlrHkbRf2OuiKNL3e3E08=
X-Received: by 2002:a05:6000:184e:b0:3ee:1461:1654 with SMTP id
 ffacd0b85a97d-4255781941amr3612172f8f.50.1759382074429; Wed, 01 Oct 2025
 22:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925151648.79510-1-clamor95@gmail.com> <20250925151648.79510-21-clamor95@gmail.com>
 <20251002015244.GA2836647-robh@kernel.org>
In-Reply-To: <20251002015244.GA2836647-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 2 Oct 2025 08:14:22 +0300
X-Gm-Features: AS18NWBsqgazmObYsbw3vrlzreHgRP08b1AuPJOMH1TaxhTxibrteaaRf04b8Cg
Message-ID: <CAPVz0n1By+akzp0t+GfF9nRzZ27NwYEikXxQ+=M=W2NEGpLNFw@mail.gmail.com>
Subject: Re: [PATCH v3 20/22] dt-bindings: display: tegra: document Tegra20
 and Tegra30 CSI
To: Rob Herring <robh@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Dmitry Osipenko <digetx@gmail.com>, Charan Pedumuru <charan.pedumuru@gmail.com>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Aaron Kling <webgeek1234@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 2 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 04:52=
 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Sep 25, 2025 at 06:16:46PM +0300, Svyatoslav Ryhel wrote:
> > Document CSI HW block found in Tegra20 and Tegra30 SoC.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../display/tegra/nvidia,tegra20-csi.yaml     | 135 ++++++++++++++++++
> >  1 file changed, 135 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvi=
dia,tegra20-csi.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra20-csi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegr=
a20-csi.yaml
> > new file mode 100644
> > index 000000000000..817b3097846b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-cs=
i.yaml
> > @@ -0,0 +1,135 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra20-csi.ya=
ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVIDIA Tegra20 CSI controller
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nvidia,tegra20-csi
> > +      - nvidia,tegra30-csi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks: true
> > +  clock-names: true
> > +
> > +  avdd-dsi-csi-supply:
> > +    description: DSI/CSI power supply. Must supply 1.2 V.
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  "#nvidia,mipi-calibrate-cells":
> > +    description:
> > +      The number of cells in a MIPI calibration specifier. Should be 1=
.
> > +      The single cell specifies an id of the pad that need to be
> > +      calibrated for a given device. Valid pad ids for receiver would =
be
> > +      0 for CSI-A; 1 for CSI-B; 2 for DSI-A and 3 for DSI-B.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    const: 1
>
> Sorry I didn't bring this up before, but is this ever not 1? If it is
> fixed, then you don't really need the property. I prefer it just be
> fixed rather than getting a bunch of vendor specific #foo-cells.
>

This is not an introduction of property, such property already exists
in Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yam=
l
and is used in multiple device trees. As I have told before, in case
of Tegra30 and Tegra20 CSI block combines mipi calibration function
and CSI function, in Tegra114+ mipi calibration got a dedicated
hardware block which is already supported. This property here is used
to align with mipi-calibration logic used by Tegra114+

>
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^channel@[0-1]$":
> > +    type: object
> > +    description: channel 0 represents CSI-A and 1 represents CSI-B
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        maximum: 1
> > +
> > +      nvidia,mipi-calibrate:
> > +        description: Should contain a phandle and a specifier specifyi=
ng
> > +          which pad is used by this CSI channel and needs to be calibr=
ated.
> > +        $ref: /schemas/types.yaml#/definitions/phandle-array
>
> Sounds like only one entry? Then 'maxItems: 1' is needed. If you drop
> #nvidia,mipi-calibrate-cells, then you need to define the arg size too:
>
> items:
>   - items:
>       - description: phandle to ...
>       - description: what the arg contains.
>

