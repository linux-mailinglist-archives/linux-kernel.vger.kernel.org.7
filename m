Return-Path: <linux-kernel+bounces-832036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C3B9E32D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F3C1BC43EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27080287267;
	Thu, 25 Sep 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsZ90d1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB922747B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791335; cv=none; b=IIcDRwm+2wTkqhyZcwwk97QCrTIj/8+cT58ht5Z1ZFN/ywaSg+NpjoPpnOpOXhc4RhVGqcMX/fKWsUgau8tz++NAhnwI0AUBP+S/mhMcCiqgQ12Y3vaWh9IUrVZGwaS8a3rujDV0sdZpxbZw5XtI/Vj9nLqPVYfJXdbAZyROGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791335; c=relaxed/simple;
	bh=MN9UTQqobGGE36nRluNDWAm6Q2RmK7fS8b+5yJPnglU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbfZH97q8MVNgtXQkg0Ym44AdEkAeNNkoh7AR1wcGqPj2q7WVqtF2OQ42jKfXSGKNMKhJOA/KoHET+56UJphsMxI7mwWQ7zZVrxM0nOST+oG4/iDpaPDBi5MzvK5FdzES2zMCx9niW1I0XRAgGfJP+ivIL/uiq/iJmvr+W355E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsZ90d1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C1DC113CF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758791335;
	bh=MN9UTQqobGGE36nRluNDWAm6Q2RmK7fS8b+5yJPnglU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PsZ90d1kSRIjrDYnVpaB3OQ9vNGMVrLXPvNYRBuFuP8srHGLnhXLF9NTQreDjgyKn
	 T221fXUXBEYsHdhp+OdKcdLi6wNyZ90Kgu9aLPuWrnYtjgP+wnCQqC2O247qMvMsxQ
	 ABwILOlHuwYPfWpwyOotTYY/oi1q1zTHT30HqVVlnwyqriQZd/JUMLcMt+QQbe+p+S
	 grSD5VOmewBgKSV6YcYN6aIMuui9td+ZABFYFgHQeWKnADqTlBe1HXnryvaVEPGTYH
	 pjd6/ciEQbRcB7PbyOjz5rGnLQUJNoZK4w2v5S5Gaz2pDCE5AGQr/DDyt+NNiEO71r
	 D1X525f2kiO8Q==
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so11550245ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:08:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP1D71mPabMtEpjjZyWWYC4hk1n21BVsjlY3ZTB3b2cjWbXmoE2Jyx0pNXw9p9sHNUa9GuiMsFkl37y0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+IbksJvrL4jgQn3AsL3BsCOe3ZYDDIuQDtx3T85YF3Ha/R7C
	ayoKNzdkHUJBkfg0IcO1/BvAB5hexzlKe+srBaS08UXDR5i/nifXqvbNKywbb6zfGoPZPYxBpdp
	sG2ws+0wXeXWMrQUKYr6CzasuetJMTJg=
X-Google-Smtp-Source: AGHT+IEIizXGGi8yFIW+fwIb4tiMszMpJuOKkTfgGT+BGmKBv8mKq66U911v71kx2DmswcPjLMyLNhtNULL2beASnoY=
X-Received: by 2002:a17:903:19f0:b0:276:9863:44da with SMTP id
 d9443c01a7336-27ed49c778amr29061865ad.8.1758791334768; Thu, 25 Sep 2025
 02:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com> <20250925-knp_video-v1-1-e323c0b3c0cd@oss.qualcomm.com>
In-Reply-To: <20250925-knp_video-v1-1-e323c0b3c0cd@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 18:08:42 +0900
X-Gmail-Original-Message-ID: <CAJKOXPekHM7qPuE=iZZv7QM=Du2PmQc8x4QT5OTy-jor82nbSA@mail.gmail.com>
X-Gm-Features: AS18NWDwttE9nsrSGrxEpjKdsbWpG4QVHp5QmtqOBkn-v3CafgF3qsW7oHp7Qmw
Message-ID: <CAJKOXPekHM7qPuE=iZZv7QM=Du2PmQc8x4QT5OTy-jor82nbSA@mail.gmail.com>
Subject: Re: [PATCH 1/8] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, "Bryan O'Donoghue" <bod@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishnu Reddy <quic_bvisredd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 08:16, Vikash Garodia
<vikash.garodia@oss.qualcomm.com> wrote:
>
> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
> compared to previous generation, iris3x, it has,
> - separate power domains for stream and pixel processing hardware blocks
>   (bse and vpp).
> - additional power domain for apv codec.
> - power domains for individual pipes (VPPx).
> - different clocks and reset lines.
>
> There are variants of this hardware, where only a single VPP pipe would
> be functional (VPP0), and APV may not be present. In such case, the
> hardware can be enabled without those 2 related power doamins, and
> corresponding clocks. This explains the min entries for power domains
> and clocks.
> Iommus include all the different stream-ids which can be possibly
> generated by vpu4 video hardware in both secure and non secure
> execution mode.
>
> This patch depends on following patches

No, it cannot.

Don't send such patches then. We gave you already clear guidance how
this is supposed to be solved.


> https://lore.kernel.org/all/20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com/
> https://lore.kernel.org/all/20250924-knp-clk-v1-3-29b02b818782@oss.qualcomm.com/
>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,kaanapali-iris.yaml        | 236 +++++++++++++++++++++
>  1 file changed, 236 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f3528d514fe29771227bee5f156962fedb1ea9cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
> @@ -0,0 +1,236 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,kaanapali-iris.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm kaanapali iris video encode and decode accelerators
> +
> +maintainers:
> +  - Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> +  - Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> +
> +description:
> +  The iris video processing unit is a video encode and decode accelerator
> +  present on Qualcomm platforms.
> +
> +properties:
> +  compatible:
> +    const: qcom,kaanapali-iris
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    minItems: 5
> +    maxItems: 7
> +
> +  power-domain-names:

Wrong constraints, see writing bindings.

> +    items:
> +      - const: venus
> +      - const: vcodec0
> +      - const: vpp0
> +      - const: vpp1
> +      - const: apv
> +      - const: mxc
> +      - const: mmcx
> +
> +  clocks:
> +    minItems: 8
> +    maxItems: 10

also wrong

> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: core
> +      - const: vcodec0_core
> +      - const: iface1
> +      - const: core_freerun
> +      - const: vcodec0_core_freerun
> +      - const: vcodec_bse
> +      - const: vcodec_vpp0
> +      - const: vcodec_vpp1
> +      - const: vcodec_apv
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: cpu-cfg
> +      - const: video-mem
> +
> +  resets:
> +    maxItems: 4
> +
> +  reset-names:
> +    items:
> +      - const: bus0
> +      - const: bus1
> +      - const: core_freerun_reset
> +      - const: vcodec0_core_freerun_reset
> +
> +  iommus:
> +    minItems: 3
> +    maxItems: 8

No, you need to list the items.

You've been told that already in that discussion.


> +
> +  memory-region:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +  operating-points-v2: true
> +
> +  opp-table:
> +    type: object
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - power-domains
> +  - power-domain-names
> +  - clocks
> +  - clock-names
> +  - interconnects
> +  - interconnect-names
> +  - resets
> +  - reset-names
> +  - iommus
> +  - dma-coherent
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,kaanapali-gcc.h>
> +    #include <dt-bindings/interconnect/qcom,icc.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
> +
> +    video-codec@2000000 {
> +      compatible = "qcom,kaanapali-iris";
> +

Please read dts coding style and look how dts for Qualcomm is written.

> +      reg = <0x02000000 0xf0000>;
> +
> +      interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +
> +      power-domains = <&video_cc_mvs0c_gdsc>,
,
Krzysztof

