Return-Path: <linux-kernel+bounces-827603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 611ECB92303
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 269F04E07BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD1311967;
	Mon, 22 Sep 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqfXrAFB"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228933112C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557896; cv=none; b=IA7lKyOuxry7EUElYvVBRqGHo6Ci7V2qf4tYGBfom4aKGcU/6iiFSick38mECjwR3jcyGOAE2vEJ0Ym9mbaMdrqW+BGYQ4jNYc6Hw+dnj8g3O85uYlqaELN6gmmZorsTE8x/IwXn+Vx4RKGmDskkCW1NU7gjpSXnXgvhnzcO5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557896; c=relaxed/simple;
	bh=YDDPtDS5PpaBUTtBuBODfZ787hS7fpBN2ZOWG34B3t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSgpeYIGhzs6pMmCpkg6kQMNLf1b0V3lLtJo3V7X6UWZi7DBa4wLAuVOfwOmnQjYk8QmS6fiDJAQPMPNXZaA5Bu+1UG6/7v88jvPptXYKtizhxl0S+EpNdiMUzrtni857Q/aP3HXaBUkwlL4VY7X/Cp3q+s3jCaR3lbLF1dWB8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqfXrAFB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso2362337f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758557892; x=1759162692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRWvsgj06ryKBVe+hXMBpBLtxOsCv8UUnSD06Qt2wRU=;
        b=CqfXrAFB3hpXtjltSFqS7U6yh8OPdIcytYtO+2v4cHcW69eTMI5BnhQmrBf+1IIw4Q
         IID1bSZoGHnL4v588s3YGOuAGbVzGOw0o7pgrPDi63hmSveYEkihfxdDTgW+n270NlN2
         LJbMA/mKTtKOssOevs7q6B6tIhp0YnNjYLN24g9v+egwin1Y6IlnOAK6i9JZljyVAH1y
         ZINb/LS8wei0A7ua7viogfFRLNy0Usco69ELWIbWmqaUPHRBhC6MuJ5KOLac/ZXhQFtE
         Rv+QaGbBWhK2acjR+b8/5tX+EE8jWNP9Yfpl0N8oBfAx0Z0O7LtWmBvy/osCcJp/GW1Y
         Ca+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557892; x=1759162692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRWvsgj06ryKBVe+hXMBpBLtxOsCv8UUnSD06Qt2wRU=;
        b=qBiXCSIiU9jounjgckFkHsUqu8XhGaLu4dfZV0k1QhdOErNyphLpLkIw03vzeYyBu+
         xEvfOGzfoNiwkVa0OYZocS6QqUIV/mgSTmgqbR6Mw+DsP9ZSmRFR2uuirHkN+L1F1F0l
         pRy1g872xf+UqMbWh+DLMaWAkmoRU12VPDXV4pmMPdJFsTuWKOsnTOyM90QDqBBVAv9p
         xTVZ7L+tRQ+vYU6+wrlXox8qALPTuLfIhORDxdn0MKSTzsOcJrU4gRaGDjA+9FDw/Awx
         JUFVOB7hSPQAh85tIhcttsqaWtWgksdRuspFMZrrKrDrivxIwLve6HM3hX5dtXUog6dj
         NSCg==
X-Forwarded-Encrypted: i=1; AJvYcCUVcZHmm8RgP67uTRurlW7IRFLXm+zzFdPHhHyobzwwNrz5ye09VZYsSsC0CodLENHC5PixKh73y83mPIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGzO8hcXQg4aXBfA/ISPBx1GpdIBBWaxhRuqrl31/4V9O7ZL5T
	qTRqvkkqHPgsNf2ejtUVVFEkwft36bpJ6fd7KCj/ubVyZL6Z6GLIb0bS332ij8Fq94msM/XPW3h
	m267lwfG8vp8RFQMyhlN8qcmV48/Fl8o=
X-Gm-Gg: ASbGncteKbxYuhydMRFR2Ou2XhP7op1LZULbY1C6pElvySVdForDQ10bFdRLC/NYfW4
	Q+8h6loLhaClj8HytJzIaU1IqLK15kLI4a9bgCP2L1ZNjtZrfztgKiSVOvcruap0/RsY+xtBPNS
	lGk98WilLo9n5dw7vfTBfUMDCodsNuoAn2wHwVoel1BpxrlQoHE+Nn5frcTgJxGkEgltv3YlSKy
	z11RJKJ
X-Google-Smtp-Source: AGHT+IF1OW4Uuo/M1UxtfnKg6qFJMuGj8u/gBh+HyDuVE8SlDhk6/kPaC4q40fTL9VF7L9Z5AE3joelyQN0VbpKBDt0=
X-Received: by 2002:a05:6000:610:b0:3e7:471c:1de3 with SMTP id
 ffacd0b85a97d-3ee7db4c459mr10915387f8f.14.1758557892173; Mon, 22 Sep 2025
 09:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915080157.28195-1-clamor95@gmail.com> <20250915080157.28195-4-clamor95@gmail.com>
 <20250922160040.GA92842-robh@kernel.org>
In-Reply-To: <20250922160040.GA92842-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 22 Sep 2025 19:18:00 +0300
X-Gm-Features: AS18NWDpKyD99LSDk4cdtlBB0rRoc7O4fFn4mETqSbvXEWtojMeCyyIIccv8Y9w
Message-ID: <CAPVz0n3cmFC1PdFnLJ0Vf60i3c6pDO9Lvi8dmAHzBgwgsrPXnA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] dt-bindings: memory: Document Tegra114 Memory Controller
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <treding@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Dmitry Osipenko <digetx@gmail.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 22 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 19:00 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Sep 15, 2025 at 11:01:49AM +0300, Svyatoslav Ryhel wrote:
> > Add Tegra114 support into existing Tegra124 MC schema with the most
> > notable difference in the amount of EMEM timings.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../nvidia,tegra124-mc.yaml                   | 97 ++++++++++++++-----
> >  1 file changed, 74 insertions(+), 23 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/n=
vidia,tegra124-mc.yaml
> > index 7b18b4d11e0a..9cc9360d3bd0 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra=
124-mc.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra=
124-mc.yaml
> > @@ -19,7 +19,9 @@ description: |
> >
> >  properties:
> >    compatible:
> > -    const: nvidia,tegra124-mc
> > +    enum:
> > +      - nvidia,tegra114-mc
> > +      - nvidia,tegra124-mc
> >
> >    reg:
> >      maxItems: 1
> > @@ -64,29 +66,10 @@ patternProperties:
> >
> >            nvidia,emem-configuration:
> >              $ref: /schemas/types.yaml#/definitions/uint32-array
> > -            description: |
> > +            description:
> >                Values to be written to the EMEM register block. See sec=
tion
> > -              "15.6.1 MC Registers" in the TRM.
> > -            items:
> > -              - description: MC_EMEM_ARB_CFG
> > -              - description: MC_EMEM_ARB_OUTSTANDING_REQ
> > -              - description: MC_EMEM_ARB_TIMING_RCD
> > -              - description: MC_EMEM_ARB_TIMING_RP
> > -              - description: MC_EMEM_ARB_TIMING_RC
> > -              - description: MC_EMEM_ARB_TIMING_RAS
> > -              - description: MC_EMEM_ARB_TIMING_FAW
> > -              - description: MC_EMEM_ARB_TIMING_RRD
> > -              - description: MC_EMEM_ARB_TIMING_RAP2PRE
> > -              - description: MC_EMEM_ARB_TIMING_WAP2PRE
> > -              - description: MC_EMEM_ARB_TIMING_R2R
> > -              - description: MC_EMEM_ARB_TIMING_W2W
> > -              - description: MC_EMEM_ARB_TIMING_R2W
> > -              - description: MC_EMEM_ARB_TIMING_W2R
> > -              - description: MC_EMEM_ARB_DA_TURNS
> > -              - description: MC_EMEM_ARB_DA_COVERS
> > -              - description: MC_EMEM_ARB_MISC0
> > -              - description: MC_EMEM_ARB_MISC1
> > -              - description: MC_EMEM_ARB_RING1_THROTTLE
> > +              "20.11.1 MC Registers" in the Tegea114 TRM or
> > +              "15.6.1 MC Registers" in the Tegra124 TRM.
> >
> >          required:
> >            - clock-frequency
> > @@ -109,6 +92,74 @@ required:
> >    - "#iommu-cells"
> >    - "#interconnect-cells"
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - nvidia,tegra114-mc
> > +    then:
> > +      patternProperties:
> > +        "^emc-timings-[0-9]+$":
> > +          patternProperties:
> > +            "^timing-[0-9]+$":
> > +              properties:
> > +                nvidia,emem-configuration:
> > +                  items:
> > +                    - description: MC_EMEM_ARB_CFG
> > +                    - description: MC_EMEM_ARB_OUTSTANDING_REQ
> > +                    - description: MC_EMEM_ARB_TIMING_RCD
> > +                    - description: MC_EMEM_ARB_TIMING_RP
> > +                    - description: MC_EMEM_ARB_TIMING_RC
> > +                    - description: MC_EMEM_ARB_TIMING_RAS
> > +                    - description: MC_EMEM_ARB_TIMING_FAW
> > +                    - description: MC_EMEM_ARB_TIMING_RRD
> > +                    - description: MC_EMEM_ARB_TIMING_RAP2PRE
> > +                    - description: MC_EMEM_ARB_TIMING_WAP2PRE
> > +                    - description: MC_EMEM_ARB_TIMING_R2R
> > +                    - description: MC_EMEM_ARB_TIMING_W2W
> > +                    - description: MC_EMEM_ARB_TIMING_R2W
> > +                    - description: MC_EMEM_ARB_TIMING_W2R
> > +                    - description: MC_EMEM_ARB_DA_TURNS
> > +                    - description: MC_EMEM_ARB_DA_COVERS
> > +                    - description: MC_EMEM_ARB_MISC0
> > +                    - description: MC_EMEM_ARB_RING1_THROTTLE
>
> Like I said before, I don't think it is worth enumerating the list of
> registers for every variant. If you want to define the length
> (minItems/maxItems), then that is fine.
>

It worth because position of value matters when reading and list above
provides a reference to the order in which register values should be
grouped.

> Rob

