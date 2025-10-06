Return-Path: <linux-kernel+bounces-843375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BDBBF0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1C4F0D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A224A074;
	Mon,  6 Oct 2025 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPxWcljH"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7601C3BFC
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777297; cv=none; b=pIWQJdRo7KGAcHHCyodJoOHAH7wQolCaHTz67I3tEXhp3vO6TXUmk3yQWQKYjtbuqXSey/mLEuMeAKByfXOWfUV7Gj6dluzC8xylmW1wMFvEi/ENgDTM3DFw63VDedW3JfJ/prFUlqGOcuwtXA8DHVSTPvTh++iGNA+i27iEMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777297; c=relaxed/simple;
	bh=TKc6LcA/O0wC2QX0fyGBva4WKaaRG2QZc1Of5qcREYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrV5vimtnmxEmBc5AnE2cSU++RSyGgE+ilRhI/FD3OvLFZ5mFWi9wR2sAgZxEEzTAiYrZA5KNjRtqRnv3PRxEvHtLvk8qNi6mQnGDz9/l8Na+urRIhI1xxHdNODng9Zz6SoVv2BETY8SQ+14hELYd+wVzDutkD0e6viK2IQx+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPxWcljH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso6205562a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777295; x=1760382095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYZ8UHayERgN9wwxms25R/WIMLPdiBWsn9w/tx9HKCQ=;
        b=KPxWcljHCb2VHa5ktipT+mGQjnlH5Mxvt49mFK0Rdz9fNYxrqdZAQCCrRzqFBmsULM
         3ZlkQJ9Zrh9kICiqwhq0F1U7DOPQL57TZ25i2AumFU/+td6wfag4l4XH2zjjZR5KWab5
         82a+j40cas5v227OnGc3RmmZlyPJPHf885PdIvv+jnykTzC6g40mDQYlb3bsT6ZNmof2
         lQD84hzvX5VM1NQLqi5SmdWoegKjo+eGiMcOLS8uXkD38pjXfmAYFQyurgyV5q18716e
         v7sXrL5hrLiJULBo1x6IN41rsWjTnhCZCMjkDBPdzVX+Vmlk+gA/qKaqApEjPzKbmwiI
         UT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777295; x=1760382095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYZ8UHayERgN9wwxms25R/WIMLPdiBWsn9w/tx9HKCQ=;
        b=N2AMGLDpvZizJbZlwNLUHxXZaSrX+71M6R9fd+ch0H6GdB3b259MCCfR6bOq0ddro8
         pVDfnxymOQ/5R8D7C7P5Jng2kjoTJ+X0rhZZWOcom/nADnbKJbYbLze+DGSthieL39mo
         x9bnC1xk3ad/btwkW1xoCWgWixeEFM9jL0al3Ce12TUqIIgdVTXnK7aKf1pbTRjOcJGY
         jkzqayoKHY2Og6oqrlRfxCP6mhvAuLcw8clv4W6wAn/6Wy+rtAVGYP+EC6wxjpP2ZhkD
         FHLTzbflkrjxC+o8zSuGKIs6a8wpbM+G22HYZZkkbs5tukiWH+xoAIG8VGaulw+uFJE/
         fmTg==
X-Forwarded-Encrypted: i=1; AJvYcCX30X7eINbmosoJQjcDfU2zqJwq/PRNH9STRXBFl4WETN9uzMfLqTz2YLilv30Wwve2BME/d3AMg+LWJdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVKguLyb85bCskcxCBpwa0dK6GoSbK8b//tQVeAGUK/izcbio
	NVMsJnQBaWzgQah4b+6STG2X8h41BkA+r8cocBarAuY6+cMfv1LcoXIHFJ1OpYyBzaPHXjK/9Gm
	+dWixAMOu999IP23H6ZIFucQllZ9O0BY=
X-Gm-Gg: ASbGncsb17i3qLTY5EEXvVL+5U8sCAk3hGYGQK8ac70j0Dzz1gTx6oU6DXlu8e5rPpL
	a5uvZIvivQgpTfzeZoL4R86X9r0GGsxKHhJ/q7R+FO7a6MhHrqSgaHPEgXfUkobA9I/C75suxYb
	FoIMSPdNv8gVTWck5MCo6VMp7E6Bu69E+8Govoh2PrQK8uHMyjuhZcoSX8mqTC11K0CIVU1t2n1
	8FhnWsXEKxZdDdDzmQwapZwatApa36CjUMqbhan
X-Google-Smtp-Source: AGHT+IHjbRQmxK9nItl2HffExFNwVAi7q3n9PoNqjUew1CuTn1djxW2xNlMPlH1OQdzQN2XzFyIHcR/X/BEeXf1S/Xs=
X-Received: by 2002:a17:90b:4d05:b0:329:e2b1:def3 with SMTP id
 98e67ed59e1d1-339c271e913mr18582984a91.10.1759777295000; Mon, 06 Oct 2025
 12:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921083446.790374-1-uwu@icenowy.me> <20250921083446.790374-3-uwu@icenowy.me>
 <20250922204349.GA1290045-robh@kernel.org> <1ac8c72206abf9f3e0a13e1fcf44be5c605f6372.camel@icenowy.me>
 <36040a0a40311cb1e871075f0c5ad175342ed5db.camel@icenowy.me>
 <CAH9NwWdx-Ut35RvhmNsdQbC4vfm3rH1VPN7H2uDBRsmsFjZU_Q@mail.gmail.com>
 <84566b33d0d08ad070c3aa8a01e07f3a0e3bff50.camel@icenowy.me> <c7d79542aedb6c074c4be21eaa15c71a53e87da4.camel@icenowy.me>
In-Reply-To: <c7d79542aedb6c074c4be21eaa15c71a53e87da4.camel@icenowy.me>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 6 Oct 2025 21:01:22 +0200
X-Gm-Features: AS18NWCjcsoivBsp8jaWAwEQpEhhNVJLV_pDpFJNQ8qKcsWUh9zL3A2T5EiSJg8
Message-ID: <CAH9NwWe+eStPai5baFY62RCUB=3c9qmOSXpFuAvyX2a7_v=0Vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: display: add verisilicon,dc
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Rob Herring <robh@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Russell King <linux+etnaviv@armlinux.org.uk>, 
	moderated for non-subscribers <etnaviv@lists.freedesktop.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Han Gao <rabenda.cn@gmail.com>, 
	Yao Zi <ziyao@disroot.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mo., 6. Okt. 2025 um 18:34 Uhr schrieb Icenowy Zheng <uwu@icenowy.me>:
>
> =E5=9C=A8 2025-09-25=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 13:57 +0800=EF=
=BC=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> > =E5=9C=A8 2025-09-24=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 20:15 +0200=EF=
=BC=8CChristian Gmeiner=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > Verisilicon has a series of display controllers prefixed
> > > > > > > with
> > > > > > > DC
> > > > > > > and
> > > > > > > with self-identification facility like their GC series
> > > > > > > GPUs.
> > > > > > >
> > > > > > > Add a device tree binding for it.
> > > > > > >
> > > > > > > Depends on the specific DC model, it can have either one or
> > > > > > > two
> > > > > > > display
> > > > > > > outputs, and each display output could be set to DPI signal
> > > > > > > or
> > > > > > > "DP"
> > > > > > > signal (which seems to be some plain parallel bus to HDMI
> > > > > > > controllers).
> > > > > > >
> > > > > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > > > > ---
> > > > > > > Changes in v2:
> > > > > > > - Fixed misspelt "versilicon" in title.
> > > > > > > - Moved minItems in clock properties to be earlier than
> > > > > > > items.
> > > > > > > - Re-aligned multi-line clocks and resets in example.
> > > > > > >
> > > > > > >  .../bindings/display/verisilicon,dc.yaml      | 127
> > > > > > > ++++++++++++++++++
> > > > > > >  1 file changed, 127 insertions(+)
> > > > > > >  create mode 100644
> > > > > > > Documentation/devicetree/bindings/display/verisilicon,dc.ya
> > > > > > > ml
> > > > > > >
> > > > > > > diff --git
> > > > > > > a/Documentation/devicetree/bindings/display/verisilicon,dc.
> > > > > > > ya
> > > > > > > ml
> > > > > > > b/Documentation/devicetree/bindings/display/verisilicon,dc.
> > > > > > > ya
> > > > > > > ml
> > > > > > > new file mode 100644
> > > > > > > index 0000000000000..07fedc4c7cc13
> > > > > > > --- /dev/null
> > > > > > > +++
> > > > > > > b/Documentation/devicetree/bindings/display/verisilicon,dc.
> > > > > > > ya
> > > > > > > ml
> > > > > > > @@ -0,0 +1,127 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id:
> > > > > > > http://devicetree.org/schemas/display/verisilicon,dc.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Verisilicon DC-series display controllers
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Icenowy Zheng <uwu@icenowy.me>
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  $nodename:
> > > > > > > +    pattern: "^display@[0-9a-f]+$"
> > > > > > > +
> > > > > > > +  compatible:
> > > > > > > +    const: verisilicon,dc
> > > > > >
> > > > > > This needs an SoC specific compatible. Generally licensed IP
> > > > > > compatibles
> > > > > > are useless because the specs aren't public and there's
> > > > > > always
> > > > > > integration quirks.
> > > > >
> > > > > This mimics the GPU IPs by the same vendor, see
> > > > > gpu/vivante,gc.yaml ,
> > > > > which contain the exact same set of identification registers
> > > > > (including
> > > > > a "customer id" one that can differienate the same configured
> > > > > IP
> > > > > on
> > > > > StarFive JH7110 and T-Head TH1520).
> > > > >
> > > > > If we can get vivante,gc to work w/o SoC specific compatible,
> > > > > then we
> > > > > should be able to get verisilicon,dc to work too.
> > > >
> > > > Well maybe I should add etnaviv people to the recipient list, to
> > > > allow
> > > > them to tell us the magic behind vivante,gc .
> > > >
> > >
> > > Vivante GPUs are special because they contain registers that allow
> > > them to
> > > be fully identified - see etnaviv_hw_identify(..).
> > >
> > > We can read out the following information:
> > >  - model
> > >  - revision
> > >  - product_id
> > >  - customer_id
> > >  - eco_id
> >
> > Well Verisilicon DCs (sometimes also called Vivante DCs because
> > Vivante
> > is now part of Verisilicon) except DCNano have the same set of ID
> > registers (In fact the registers before 0x1500 seem to have mostly
> > the
> > same meaning with GPUs, see [1], here the registers are even named
> > GC{,REG}_xxx), so it's why I assume "verisilicon,dc" will work here.
> >
> > An example of identification registers readout on TH1510 is shown
> > below: (the register names are from etnaviv state_hi.xml)
> > ```
> > root@lpi4a66 [ ~ ] # busybox devmem 0xffef600020 # MODEL
> > 0x00008200
> > root@lpi4a66 [ ~ ] # busybox devmem 0xffef600024 # REV
> > 0x00005720
> > root@lpi4a66 [ ~ ] # busybox devmem 0xffef600028 # DATE
> > 0x20210201
> > root@lpi4a66 [ ~ ] # busybox devmem 0xffef60002c # TIME
> > 0x11133000
> > root@lpi4a66 [ ~ ] # busybox devmem 0xffef600030 # CUSTOMER_ID
> > 0x0000030A
> > root@lpi4a66 [ ~ ] # busybox devmem 0xffef6000a8 # PRODUCT_ID
> > 0x02082000
> > root@lpi4a66 [ ~ ] # busybox devmem 0xffef6000e8 # ECO_ID
> > 0x00000000
> > ```
> >
>
> Rob,
>
> Is this an acceptable answer of not having a vendor-specific
> compatible?
>
> If it isn't, I will add vendor-specific compatible strings to the next
> revision of the binding, and maybe also try to add them for vivante,gc.
>

There is no need to touch anything for vivante,gc.

--=20
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

