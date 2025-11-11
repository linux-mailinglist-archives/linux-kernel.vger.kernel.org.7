Return-Path: <linux-kernel+bounces-895918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48827C4F434
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A64494EF277
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C33A1D13;
	Tue, 11 Nov 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRKLj1cx"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6AF3A1CF9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882597; cv=none; b=kPJsTulOojm4ZkoxPLfv0DsGDb8uIRtyZvUQqLQzghWLI4UcT+ouqtpDfOZZ6IgpDDjwR3sMDJvcF0R46pib60FtyfLaNwoTmpDMQ4/lh5zFTMTxkXKcC8B807H099YT4CCLya55ea+A/xSNoR6OfD688gh8sJ5MFhFm45DF/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882597; c=relaxed/simple;
	bh=xOKQOoM2AfNja8dsA/CxDG47x21cuiNISWWb8aEVEJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc7WNEvX9ZVZyQfiYyU3ypwBpcfxH2KKtfLLemUjrhZ8A3HYo1jziMUm0YdUSFWgwqwtXfRMsVcEVdWq1SReTa1j2GfnVsvoriHoNaT8sCqnOJ3N/XnvjMhNZd2ZpvxHuVvVGQhi0ROREjHJ0R54Vuo55sWOXs5Reo7AGR1z/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GRKLj1cx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7869deffb47so43351267b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882594; x=1763487394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=za1gdfyK3qzPGcN1dvu1lDNgvKHZXorLMMwhejsf9TA=;
        b=GRKLj1cx7hYkLoDKUIVhvq57O40wZyIcbs2vowstDhvLHyMjlmDpcPGy5gcSKtZugs
         qjciS3MlZ9M2xToRf1uje9yHpVPxHmijqGq7KvZ/E8Z3JohiCDQ3Wczhp0uH5/AicupE
         Ctd1IEOZAz/U0HceO/ppsBPPhOklr//JU3A+SVaj/xyzv5pw5KVAKZQcwsnYCMH2ARcq
         zpXUIPcCe32MbmoAdPz4HmHu1Exyxb11i58/p39oV++Ufpo+mJ0d1tGY6iPatVc3LUqt
         ynGAL5mGT0mzZ9VxIQ0cUjh3nP8ZUIHRS55XytbRvelxJWpaDmpeUNDim4Z9KmcYr56i
         l/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882594; x=1763487394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za1gdfyK3qzPGcN1dvu1lDNgvKHZXorLMMwhejsf9TA=;
        b=Y2MH5oLC/WXqY3cCw8N5L/Mn8AQukCkK0pQg4MTeIyTnE+KDDDqT0z+dnXki9gNSPr
         Z+y6QsKj0bGhwOlWnbR5+juR3YVCTDeUCAtYJE1x5gsp+kPU/YmZXNZeLCNn27ldZWDZ
         Yc1dP7D+W55zAX8fawuTOPEUZEvdbwYWnO9ktFFRHtP1JbzNZ1ZbmWXcsMAJvJ1TmrRe
         LpxOeQcKK1sfwsytxxndWepbPfYC9zCuqcKOPQ0bL+AG3BL6ogpRhsLwIvmzrRU9HsSn
         YWA2YWsq8q/9nZjyS3WbIp67ltRLhXndf0ZBNZhJ8Cj5vap8xZK1o4Tc+fChh+s5ENFN
         8mvw==
X-Forwarded-Encrypted: i=1; AJvYcCVoN7i098cNcYWj9MpvxVSq4s5Zc87vHJ7gKB+QbEDfBdGqim9vmU7VnnNsXeNERHJn74gXcGbmsJst1qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oPMwnhrAJMKOgReOy8JfNOepO96VVtOs1bqPrO0GC+V8Z/zG
	WW7DVK0yo9vqw5ZkSMDET1DG0VD+VDhe8aY+RVwstpAfdsFXtU2biAJTusWMku1u9q1WcLb/4IB
	Hn8xixOjMbp4/LjX3YBsWHZtnRow3kIICPTf+cvjK2A==
X-Gm-Gg: ASbGncuIZm08AizTYuf9fH2rf7OCCEHrujhlwP0zpdGn1OSGn3/jFIkTe0T+p7KXyXq
	idEYAfXKmX6YJlR+3gUmGgqjP7Po0jegD0iLcAgmR5cQsmQCCn05HKRtqu9gvaMO6c2N9dPtIvZ
	u+3/v1SVxcWD1aV+F9anmKpAZXLDoKQQteSGMyUCkdHho+55psaibBCDyNqHTPvPtlpD9naXJZD
	k2ja9ub3Qzh9Uj0/yMs1cafGTudF+kRLQ5irPSSFe6gUa2BuhZMitgrCaq4/fgV8M+dm6NI
X-Google-Smtp-Source: AGHT+IHCw1UcWzR9TPBE2DxyUpgbvAXRgMv7lWv2gMJ/bZXyLo3o561gH5tEFbtxTRBwtRHVUXKhCc7VU5xNaGwU2MA=
X-Received: by 2002:a05:690c:8b90:b0:768:70a1:46c2 with SMTP id
 00721157ae682-787d543a745mr98347307b3.48.1762882594490; Tue, 11 Nov 2025
 09:36:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-davinci-mmc-v3-1-5b27b9c9ecc4@gmail.com>
In-Reply-To: <20251023-davinci-mmc-v3-1-5b27b9c9ecc4@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:35:58 +0100
X-Gm-Features: AWmQ_bnvpism8NQxIoxTruBGzEdbb8m_Fhm8OHtqEgCF2-lTQKiQId72TAJ0VRU
Message-ID: <CAPDyKFr2TrHY6VAt_1y4jKOr1J5727_osx+75U9_=+LExYZJiw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 15:20, Charan Pedumuru <charan.pedumuru@gmail.com> wrote:
>
> Convert TI Highspeed MMC host controller binding to YAML format. Define
> 'clocks' and 'interrupts' properties to resolve errors identified by
> 'dt_check' and 'dtb_check'.
>
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Change the maintainer for the binding to "Kishon Vijay Abraham I".
> - Link to v2: https://lore.kernel.org/r/20251011-davinci-mmc-v2-1-355da3e25123@gmail.com
>
> Changes in v2:
> - Modified the commit message.
> - Removed 'interrupts' from required properties following the old binding.
> - Changed the maintainer for the binding to "Conor Dooley".
> - Link to v1: https://lore.kernel.org/r/20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com
> ---
>  .../devicetree/bindings/mmc/davinci_mmc.txt        | 32 ------------
>  .../devicetree/bindings/mmc/ti,da830-mmc.yaml      | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
> deleted file mode 100644
> index 516fb0143d4c..000000000000
> --- a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -* TI Highspeed MMC host controller for DaVinci
> -
> -The Highspeed MMC Host Controller on TI DaVinci family
> -provides an interface for MMC, SD and SDIO types of memory cards.
> -
> -This file documents the properties used by the davinci_mmc driver.
> -
> -Required properties:
> -- compatible:
> - Should be "ti,da830-mmc": for da830, da850, dm365
> - Should be "ti,dm355-mmc": for dm355, dm644x
> -
> -Optional properties:
> -- bus-width: Number of data lines, can be <1>, <4>, or <8>, default <1>
> -- max-frequency: Maximum operating clock frequency, default 25MHz.
> -- dmas: List of DMA specifiers with the controller specific format
> -       as described in the generic DMA client binding. A tx and rx
> -       specifier is required.
> -- dma-names: RX and TX  DMA request names. These strings correspond
> -       1:1 with the DMA specifiers listed in dmas.
> -
> -Example:
> -mmc0: mmc@1c40000 {
> -       compatible = "ti,da830-mmc",
> -       reg = <0x40000 0x1000>;
> -       interrupts = <16>;
> -       bus-width = <4>;
> -       max-frequency = <50000000>;
> -       dmas = <&edma 16
> -               &edma 17>;
> -       dma-names = "rx", "tx";
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
> new file mode 100644
> index 000000000000..36b33dde086b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/ti,da830-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI Highspeed MMC host controller for DaVinci
> +
> +description:
> +  The Highspeed MMC Host Controller on TI DaVinci family
> +  provides an interface for MMC, SD and SDIO types of memory cards.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,da830-mmc
> +      - ti,dm355-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    mmc@1c40000 {
> +        compatible = "ti,da830-mmc";
> +        reg = <0x40000 0x1000>;
> +        interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
> +                     <17 IRQ_TYPE_LEVEL_HIGH>;
> +        bus-width = <4>;
> +        max-frequency = <50000000>;
> +        dmas = <&edma 16>, <&edma 17>;
> +        dma-names = "rx", "tx";
> +    };
> +...
>
> ---
> base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
> change-id: 20250523-davinci-mmc-c704440c3dd0
>
> Best regards,
> --
> Charan Pedumuru <charan.pedumuru@gmail.com>
>

