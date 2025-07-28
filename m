Return-Path: <linux-kernel+bounces-748420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C829B140FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CE3189A881
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F142750E8;
	Mon, 28 Jul 2025 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxAHBuzj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CBA2737E3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722667; cv=none; b=NUuiu3FBd1LlZwUFdq6iX3+Sbc/C19Wiu/G3wxtz7XDCztImxsnp9YkFvdpc+cmS9BSPehvQaoABl8ee6p1+/Lx1tg9mclBcvi3coLcnrc+0Xqh8qjW3dlWJeZmvqzqqxOD+tota/Tb09+JIJe+HFoH7tpxYEtklKC44Qc80FW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722667; c=relaxed/simple;
	bh=bKx7T1DLQcbdvNXKkdxjhh9o20FMdCO0YBI0USo5qRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mO9Qsk1kJCaXXxR7ToKtecfHFxt0PRV6Z+rI8EayxWmIKpHPF7xQdF+FQ/hTTei85zi5tHSi30SooVQ6tTBRA4A/o7RI2l24gE10NqMbLmZydYTEVPNGUxn0P7UjTGbp+UTSEQAtCV+61y+oyCJl3FCZ650Arr6qduNROH/v330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxAHBuzj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so911807366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753722664; x=1754327464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QR1arBx0XvaSp1oUXc3PyontAThuSk/8jS2zweGYDNE=;
        b=WxAHBuzj/5k9vPu0wCo7mPeSQvYKrJIm7erozXLuNjSfF4PmjuO+72WfufvbcrFhiI
         JfUCB+W8t0wtkf9OogyKUFcHiAMjTQlMAgG7sjW0DriH87kFpSC1Giv+5D+nB48ql+9+
         LdIc308cu3Sp7e28RA/kHTbHNOOXRRa/p6FIwlcFsTAqRg+4YHrfI2k6jMa7Yx/yZsPZ
         wmq351hrSbbf5sx7Ew3qor4YTG22RbC+GMvcKNkh1AOIj7xlED5HOJRQee9lNswW2Lhq
         fU3NaIbo3ZTejCgXB5oEn0Y8FTu4ImiZYjd7PnGzZ8bxvIF5URNuYTu5HrIIGStV9bQ7
         ywmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753722664; x=1754327464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR1arBx0XvaSp1oUXc3PyontAThuSk/8jS2zweGYDNE=;
        b=AUotSnFNtBhTzSucQ+1TcMoINmk8A56pAQammWciNL8FxNdk+R91sdGDQDbLGZ6MSe
         23N9BhXvpqAQTLaEYUtI0IjmCHQvURh0SdrzxU+PKI7MPdWujFw5oX1R8wU57Ge4lVpH
         yVF6hrIb1kOtVmZVK8XkrYOlRyr9oUoaOKz4yRf2xquAudzrAgu/87V8Nilm1j/aWboh
         vm7BKmt8xmsyUIhDrAsqtFeh796xz6+HHHHFWowf9EY3V01VhOXUyeJCeToyZX30IweI
         ZbAFynffHvTkanOa3kJ9p41l1M4kZ/5/ZrHsrJZ85JBOGWTEjSmNrDuUKhMPiVA7wUps
         a5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQT/yvm4bHl81QkAQzvAb1roxKJ7xFKRh/jtKknQA8jqmNM+iGxiwXWCxSiJrU9XS8UVFEp0h4p2T/ct4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHsUKTRA8jUVODwQcewnJ3uNWMXiGFNTSt8S4EtyEcSF6XAeC
	FECUaAFdXwEfM0TnFmFzxp1N8/n5JF5jZO5CvczgF8sYvAs+YUQhcMmcMS9hraIv3Ik=
X-Gm-Gg: ASbGncvk5xqJAANfQ67AX3SW30qcj73AU+5ZYYObfJxtvlpZA8ldRzFPeyCAVRKb7ng
	NfOjZ8JQIo7Qg0SHbwkVobXEHfUNQ6IefxAMSx4KNn33NZOF5usuW/fviBOrRDCp6D40CxrTODT
	82ZDP6T/XYnuWHIIl1hW/9MlZ3JPihVDAH+zZZeaxe+77WPINTAF2W8rDvuvyORfysmSvHczksJ
	pG9hgV4cKvUB1zaKn7UaKQps2wgIwoYPQ/2cXUNoJ1LOfnm0h31s+87pHTv/2o1ydwLclvD1oY6
	W69XqadguUWvyeaBph1AXF7r0zvcfR/GxREYE6PbddtgSmPwzg2bByQpbEBg1ki7baqYKUOJ3Nv
	15l0lMGJNHD94D1EAG482njNEBMzKmBWOag==
X-Google-Smtp-Source: AGHT+IFd/ukbJWEyAyiMoVr3cixjoIXsXy8y7hQtFjRtY748SHCa7Gi1Pqlg3oMU0d8uaJRO6rYQqw==
X-Received: by 2002:a17:907:1ca3:b0:ad4:d00f:b4ca with SMTP id a640c23a62f3a-af619a0795cmr1251448066b.50.1753722663537;
        Mon, 28 Jul 2025 10:11:03 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:e460:c4f3:f28e:97ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585ff5asm452983566b.11.2025.07.28.10.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 10:11:03 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:10:58 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Douglas Anderson <dianders@chromium.org>,
	Vinod Koul <vkoul@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Andy Gross <andy.gross@linaro.org>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC 24/24] arm64: dts: qcom: x1e80100: Describe GPU_CC
 power plumbing requirements
Message-ID: <aIevIuMDA5R8igmi@linaro.org>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-24-09c2480fe3e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-24-09c2480fe3e6@oss.qualcomm.com>

On Mon, Jul 28, 2025 at 06:16:24PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> A number of power rails must be powered on in order for GPU_CC to
> function. Ensure that's conveyed to the OS.
> 
> Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..6620517fbb0f3ed715c4901ec53dcbc6235be88f 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3928,6 +3928,12 @@ gpucc: clock-controller@3d90000 {
>  			clocks = <&bi_tcxo_div2>,
>  				 <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
>  				 <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
> +
> +			power-domains = <&rpmhpd RPMHPD_CX>,
> +					<&rpmhpd RPMHPD_MX>,
> +					<&rpmhpd RPMHPD_GFX>,
> +					<&rpmhpd RPMHPD_GMXC>;
> +
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> 

To repeat your own message from a couple of months back [1]:

> You shouldn't be messing with VDD_GFX on platforms with a GMU.
>
> Parts of the clock controller are backed by one of the MX rails,
> with some logic depending on CX/GFX, but handling of the latter is
> fully deferred to the GMU firmware.
>
> Konrad

Please describe somewhere in the cover letter or the individual patches
how this relates to the responsibilities of the GMU. I searched for
"GMU" in the patch series and couldn't find any note about this.

Also: How much is a plain "power on" votes (without a corresponding
"required-opps") really worth nowadays? An arbitrary low voltage level
on those rails won't be sufficient to make the GPU_CC actually
"function". Do you need "required-opps" here? In the videocc/camcc case
we have those.

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/2dae7d88-4b3e-452f-9555-05f10b42dabc@oss.qualcomm.com/

