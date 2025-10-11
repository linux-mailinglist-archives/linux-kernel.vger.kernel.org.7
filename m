Return-Path: <linux-kernel+bounces-849124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF3BCF414
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAFAF4E0F98
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EC726561D;
	Sat, 11 Oct 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydMxZPQo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3319B3EC
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760180814; cv=none; b=rzArBPCIl/lo0whSyTdqOmo+pfAXHnf2V/+ME06mOW7JifSsEeuGQGLtPZLtx5pNlvt39DBUwfPoK3JaWNlLjUAn6PmztkQ8XEQMaUxn0PCBZ/zh77ldeS1UGMV18NS/Tfv0h5+5Vi9rOsSSlKRpf7bw6YkDem5MxoZ/Ra+Jio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760180814; c=relaxed/simple;
	bh=DFtPK8eRVHr4jByOoKRmS2GzzHVM9d7Kax895/EA/ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9iQInFYCzcdOjfYTObORv4LEC5meomsntD+VPpmVjl5SJ4J3iIXM8PMpP5qqftEO+oDytBK/XQzcu+glNaWsNxHfiogmNsLBiu14iqLI1y3t88S+dlKdFSiWWS4O2eb37D6Lx9tddJOv3oIMVCHKTXe8uRXQg5DKXUA7XnLUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydMxZPQo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso26254345e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760180807; x=1760785607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUM2/URIhgfzGfcKYQTjSM1umO6xjx3Kxpuxk6gO9mM=;
        b=ydMxZPQoVOFT3LP7//xVCQoQhrIDuSx77DVHOEHLILHf8VLDRy71a0qNVbqc3TJT7F
         rkKjX3u4H/j+OQnFd6ooORKGgaSvK7lpcYu4YK5SLXP9aeMMNEv+YafBIC0vxGRteKuF
         OkOf+1E0euv/1PNYk05oET/ivPsTpJZktr4owVGsFg1Er86ha/5O9sbUISSrZntx8ZcZ
         FhCaAkxmPDs3ZDnaJUOQGlfpLW3ZRSzmceId4vS0K/uaX77WX3UMWP0xsZt7g2RJ/EZN
         fjDXbVeOyxH1momBW8t1TCTZP/i3n9tGVQW8+Ek7aaI5NF+xY5itPXA90pX9FneR2ggj
         jaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760180808; x=1760785608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUM2/URIhgfzGfcKYQTjSM1umO6xjx3Kxpuxk6gO9mM=;
        b=kq2XRc1JWQ0ZUGnBRHX3uCT80UVlWmtbmJiNdQZM57Io1Qu8KtFUVlyQ2dmfwk7Z0F
         /ujTRGl3eedh7imTaB0hQlu3sMiXH9zqLIKvLMTOU2o5fKWkqHKw9a+m8W2SWpo3NKQJ
         Q+ssEaBff+U7fth5tvXm4SW0+KdFVLZeFg1JT6K2y0GVHsVg0dxJNWFMkXbr6yPI4W6/
         pnEjhpP9O3FeYroyzpMTu20LQyJospfS/JJtI/XBEuqXxaTW3aceiEggXXQYiqpwJ0u4
         b/ffLUi7eEDaaZy146jjLBixBpiMz6U2uN6YKlcIWvwARSi/ay/kmsdOIIWjQYEpnmGN
         xXSg==
X-Forwarded-Encrypted: i=1; AJvYcCVzJtBRfrf7fwu641sdYSvYb12lGwX1KDOtjoYLM3bMZKFiyP2wDHM1N86HQllBi5VwV0kl6Vj0FE9DR7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0jkEKHuKoanTTGvQ4K4ndxlL/CEH0/i3yeRYAMtkQnXQk4Ze
	g177uOP+ZdD2/kzVoglWoMLoYxc+HzvowdB6nHw7R39CxET78uYt53i5nLfYY8n1gjo=
X-Gm-Gg: ASbGncvnVAjEd39fKoHDzP1SrB5zx4oXbantE2wGYjDSpPFeJEc1JTZeENvBWf/PyTC
	fB3jNcgbTQm1ojQMPwnL3uqE0c449oSpCW+0xoVsmQIrLeB5Ryg85yu36sC3WQpgufUrqcKsNOm
	0EKFzMFB2CKy6t2+w3byMwypBJ+GD4U0xU/vYACVJifbHqjmnB0yIcKZfDJW8ORSRjOaMjoWdyC
	N+2WI+cNjGf4XPK5VAxTgKo8Hpao358CZxhW5fDSoUcovnV2WH1/lu5v3BEKqRp9dfsWUzMO5c9
	nVbDBbpAqVPAZgwlX65IeCztFkeuAUMelS9BOfZNG4tqXRvWzcO412VdV4g+9lNswufu7QKsZ1G
	xWZalkxCsufTMsnAmjmHFSdMf/ye1qAq0fFAyRZEPmTL1taO/h25Q
X-Google-Smtp-Source: AGHT+IHGR+So1TUHRFxgxBeilcnqZpteXvOpesOn1YzO553Yr7iIOWcb2MOwachFSdxEjwsl+4NDYQ==
X-Received: by 2002:a05:600c:34c2:b0:46e:502c:8d6a with SMTP id 5b1f17b1804b1-46fa9b06499mr93510435e9.25.1760180807403;
        Sat, 11 Oct 2025 04:06:47 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489ad27sm88785185e9.15.2025.10.11.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 04:06:45 -0700 (PDT)
Date: Sat, 11 Oct 2025 14:06:44 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Subject: Re: [PATCH 04/24] arm64: dts: qcom: glymur: Add QUPv3 configuration
 for serial engines
Message-ID: <3af57kktkwevbxkno4o54w3o2qajoco5x7dlj3ckepcutlzmdh@2bnqqxndbvf3>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>

On 25-09-25 12:02:12, Pankaj Patil wrote:
> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 
> Add device tree support for QUPv3 serial engine protocols on Glymur.
> Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
> support of GPI DMA engines.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts |   43 +
>  arch/arm64/boot/dts/qcom/glymur.dtsi    | 3041 +++++++++++++++++++++++++++++--
>  2 files changed, 2936 insertions(+), 148 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index f1c5a0cb483670e9f8044e250950693b4a015479..8674465b22707207523caa8ad635d95a3396497a 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -707,6 +707,32 @@ gcc: clock-controller@100000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		gpi_dma2: dma-controller@800000 {
> +			compatible = "qcom,glymur-gpi-dma", "qcom,sm6350-gpi-dma";
> +			reg = <0 0x00800000 0 0x60000>;
> +			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 596 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 599 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_ESPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_ESPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_ESPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_ESPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels = <16>;
> +			dma-channel-mask = <0x3f>;
> +			#dma-cells = <3>;
> +			iommus = <&apps_smmu 0xd76 0x0>;
> +			status = "ok";

s/ok/okay/

Everywhere actually.


