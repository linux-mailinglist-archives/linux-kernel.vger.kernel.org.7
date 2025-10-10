Return-Path: <linux-kernel+bounces-847902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41324BCBFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D47904F3C25
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EDB27281C;
	Fri, 10 Oct 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtDPJxE9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA727586C
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082639; cv=none; b=Jn+8JWNgg5KyUftGgHbuCdihU1AM2zvhFfUq/pSyJguxoBervBataCgzSA+mtOultruWNCtCXBKoRB9eU6ui6OGPRak3Bo6G9lc6tum5LgIqhExlgm8LSGTh/T7TzObLjOSUX3S4nhCz6Fk/VdbIADFEadRzVwlRSc/lL2DJnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082639; c=relaxed/simple;
	bh=KkNMjL8I5fdybdUa1NjkYPfijA6UxDkbR3tLV/jCMZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXrDh15NPuro5Z81B0xKRPs0XRE6Ju1wKiGaCTn1NxjRU20WYoHR28OKRYXX+lXHzhrjjIb8Pz7AEvCfemXkOAK6d9SA6aMRyZCzRGfEabUfYBSWrNB6htsG7IvMEBTcUAZ1VHrSyYVN3oPH/rs3wmJmWDqAuqa7HwDC+aQ6xCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YtDPJxE9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso1286098f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760082635; x=1760687435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WijTXTd4CTE1aZK8+Efy77AvQqAMXLDdM08ln7br76Y=;
        b=YtDPJxE9w8Zbb9xUo2KupcUHBY2UTvKgECLsZSA9tmz8dlm0Kx78euUnqt92FVxIE2
         G11vKMZQ1+IzuBQ/DUdtwZW+inmi4ZqMj7q3VbJcT89sNFYe0GZJYTCrOHhhNmm15dvr
         N9OQiALIfiOBIqv/bZexK6ZpqSly7ef5hOjOoJ2UiHP5gsA5CgufN7sffUhUhM7rNzcF
         JC8hJkh7+7t/ZG4wngBr14aHepmi+MLk9wAAC/5XK90DUrVJFM2VgLgIRQNcdXQT7xyB
         EorFIpnVuyv8MmE33s6o/qehOrEUu/fxaJeHqNT6vbE+W3W/+ONigZl4ukR54OqidlfR
         UGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082635; x=1760687435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WijTXTd4CTE1aZK8+Efy77AvQqAMXLDdM08ln7br76Y=;
        b=LK2WcQ3mgjjHHjm7D18SSrnQw3vy0ImQ62P73sM1PgcMxuc5fZPa6exBtljBLzr1VV
         LDl5HDxxIr24+vNxTUfOhODXSKwreDi3GSie56dJ9uDjLFc+ksycM2KPo4gte+tloI5/
         grO3eDrEeCdH6toyGoLUssRYPawCIiWmM2FQyIhl1Of1e6WlZQl9oYS4OoSxxy07teyp
         EduPVyThcklRsu5zDU0DpJ6jNkiChBS/7na8hrKfG9xKuEW+xzyezcOg1HHxAuOx1/tJ
         oOyiN1q2giZUopN3XuggXxIeQJzzjMliNNNa1e80kzbBaR9PmJrhofhnc2QY6PmZ7Tdh
         FrCA==
X-Forwarded-Encrypted: i=1; AJvYcCWuLIjU+koE51+sdS965108ZY5nzsoy161dMDrpnJn7WmFI/V8Sy7mvfXvQCtg5JQM5YuJWmna3hZCnuwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmHAMfgHldu0YFJYL4tcZerHreEjGAxtbxGuN6aEmW9lGFLlM
	HKYt5raMmwp4L8Fj6GTlJEt130PRHT6jBw55NYf4QPtdKbSPGrNhFvmI4vKbB6yG2IA=
X-Gm-Gg: ASbGncvkv54km2IMW80jelLpaHKpUhegxcNdSSq4rsH5EWfGlZ3Gnsz7kWXUmeZv8gN
	doCTA4AZiNxJPEWNHL+rTbnF5LMvt4K7l8yebt6ByjwB6HtGSM4Pl2kRg2RcgUDxO/QJb4zWwDS
	6oOKa7MyjAMLXe9aGb/f/DKfBhmHXWtM0Z+FmHjRkolbRqxwSD+wlygaRGC0p4EVxO2cKzzTz9t
	DrQ0LzoQZ28Sz4RvPP0WweyBR203LFjuaqjYftk4t0pxHTbUS6lT1ti1sVYuU4fJUJ+zez4DTQA
	f9uvPmTUpLnO5Kt7jearTvub0GUmcbTG17n1girvXVjIZPGmovF+T8NLBl1eSeM4l8XQuHik+qY
	Wo+nPwtLJVrSPRq/20ojtDTySy/9ndyo6hYgwP5121WUViUPshUxs
X-Google-Smtp-Source: AGHT+IFk1hh63uQe7aB2By45OKK1hqXKawuG9jRmJUvZ+AvXgNz3fClrX5KDO3YUiqe4ZY+f2eE9QA==
X-Received: by 2002:a05:6000:4285:b0:3eb:5ff:cb2e with SMTP id ffacd0b85a97d-4266e7dfdd4mr6371755f8f.29.1760082634843;
        Fri, 10 Oct 2025 00:50:34 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d404sm2919503f8f.3.2025.10.10.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:50:32 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:50:30 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/24] arm64: dts: qcom: Introduce Glymur base dtsi and
 CRD dts
Message-ID: <uqbsxmx5kmbykfjn572nyihzp25e244hijniln4j4745cxgp56@ex7ji7na2icx>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>

On 25-09-25 12:02:11, Pankaj Patil wrote:
> Introduce initial device tree support for Glymur - Qualcomm's
> next-generation compute SoC and it's associated Compute Reference
> Device (CRD) platform.
> 
> The dt describes CPUs, CPU map, GCC and RPMHCC clock controllers,
> geni UART, interrupt controller, TLMM, reserved memory,
> interconnects, SMMU, firmware scm, watchdog, apps rsc, RPMHPD,
> SRAM, PSCI and pmu nodes.
> 
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |    1 +
>  arch/arm64/boot/dts/qcom/glymur-crd.dts |   25 +
>  arch/arm64/boot/dts/qcom/glymur.dtsi    | 1320 +++++++++++++++++++++++++++++++
>  3 files changed, 1346 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 296688f7cb26550f75bce65826f234bc24110356..15f31a7d3ac4a60224c43cfa52e9cc17dc28c49f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= glymur-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= hamoa-iot-evk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..a1714ec8492961b211ec761f16b39245007533b8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +
> +#include "glymur.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Glymur CRD";
> +	compatible = "qcom,glymur-crd", "qcom,glymur";
> +
> +	aliases {
> +		serial0 = &uart21;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <4 4>, <10 2>, <44 4>; /*Security SPI (TPM)*/
> +};
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..f1c5a0cb483670e9f8044e250950693b4a015479
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -0,0 +1,1320 @@

[...]

> +
> +		aggre1_noc: interconnect@16e0000 {
> +			compatible = "qcom,glymur-aggre1-noc";
> +			reg = <0x0 0x016e0000 0x0 0x14400>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			#interconnect-cells = <2>;
> +		};
> +
> +		aggre2_noc: interconnect@1720000 {
> +			compatible = "qcom,glymur-aggre2-noc";
> +			reg = <0x0 0x01720000 0x0 0x14400>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			#interconnect-cells = <2>;
> +			clocks = <&gcc GCC_AGGRE_USB3_TERT_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB4_2_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
> +		};
> +
> +		aggre3_noc: interconnect@1700000 {
> +			compatible = "qcom,glymur-aggre3-noc";
> +			reg = <0x0 0x01700000 0x0 0x1d400>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			#interconnect-cells = <2>;
> +		};

Nitpick: the sorting needs to be by address based, not label based.

So aggre3_noc needs to go before aggre2_noc.


