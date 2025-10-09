Return-Path: <linux-kernel+bounces-846571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C1BC8612
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C7124E1C59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D0D2D6E58;
	Thu,  9 Oct 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X86EFRVR"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E04277CB2
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003611; cv=none; b=mzZQ5jTIVNJBL7Eq3FGmzLbUVqwsed2l+4xb7OJYp0r7bGzSx9MdlHVY7QbAgCeYpohFPmhBOR/KaObCnYxqreaNQeQokZQBTrMaNaR3VZyWMIo8zjBWLwaqalAfL44SKVH0E0SzkT7bTZnscit/XGL1CdrspqUiop0a5z3QI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003611; c=relaxed/simple;
	bh=O9cayNh7nyMTio8IwgC75UyGQLN6c3TkWm0LycqPbIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6LvT0ax6RJTblI1h2+2VHYVe4ZRWpczzhK7ERvKvq1jX9U3SlyeifV2ZCxIWO3fLNyq3U+Lns//mSZTPzH+vBD5yQE1uA/uVDH/6UXRcBdOcVpGrjgyKOKJW4yQDmmZ0YtmQ0mKBhTIccJZzOBIbvzUalc5kTWQ9km90RGCIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X86EFRVR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so4502005e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760003608; x=1760608408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wkk9wTKAcqHKVQ7Lts2DPXd26laO6sEh4NcRLvzjus=;
        b=X86EFRVRO60y3a5JKk6RytnfUrVgFEoCX+9PfCUaeQRgml0OqiaR8kJUAwl8sDiHH5
         f1fFRORR2lGH+8no5rrWrF834mTzugiiG1VVnOCaVn70b3BOxeF50Vbq5WDMV99Py4NX
         6cNHH8kEl6yVPmGK5jtIUAC9YeE/n4WxpC7pzHfT3uASSXsLvzAW0Qj9ZvRbLM5czvn7
         ericL8ksxEUJK6L2uL78f44+zqmC5Xfrpf+icGcHIa1KWX5up7CpNMSTCKfREs5qcQxf
         8Ost6wWmreKd221/Wmc1+KiGYB5P48qp9dfpFdX4EeIAhjCBlHb6+4HRwMRtkAzSvzi7
         7Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760003608; x=1760608408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wkk9wTKAcqHKVQ7Lts2DPXd26laO6sEh4NcRLvzjus=;
        b=xQMaQSSiGwI4vrkS+WniaHUmUANOV2U92Vq4ZAPTZhEdqF2T5x9K/UHJWRy85Gkzmz
         zmtrYL/1FETMLPEe3o7ZRNn7O+Kg9IWko2R+xVpJjD97A+nCszUtBlkutZQ6towq/9V+
         DAS6ygfnzWuzg3PrbFxqqgn+LQUhVIERWaXjmsRpa/P5KK0jEV6BdiB/GXaYQbW47oCC
         6ygNI0g6QKYT2YsmGWJcSbbqWysimCWL4QhW5JVrtVN2OqZfCNYqckV4GfugoNFFhNQB
         hNq+lynEUuw4Pv0GpKVDT9c64C96w5ACtbnH+7mIcgj1Uan8EzqXGQB8fLIhe0+Z5mhu
         WcJg==
X-Forwarded-Encrypted: i=1; AJvYcCVR0x1MGz5d5w8XdEMqFJYelX6UsT0wnTcgCQ1kd3bS0q6gKWGyWDvlHVDDh1UsEsCPxdY3YQBXs8riZT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydpmYWGXXrbL7JroEMoZvmk6s9NJeeo31cidPLC1J3+U2lnCbg
	OMgPHLn7UcaWdHgkz9+hHx0CGcQWix7iw+dCZF6K5Rx7iLsjclzZlk9hLEvbmMfjCTU=
X-Gm-Gg: ASbGncvifOIqixVX3RfBAFie7TQ0mo7DMCpl0aV4m8SSQf3E6MIdOnqUEZ1M5JE+Mv7
	4WcgftVkC8HluYepokBjkGZ/ssAilLaSdOlULK+wtncJZm9IzmXSIShkWTxzetvcAbfZu3RmXgJ
	DE8KSM43B7plEYlOJ1Q+bK18qyqdTbO5x1qXV6tcSKW+fyutvEIgL2m7denzc5xbioyQ+D6Hc3j
	c6J2RCB5ZE9N13FSbB6L2qQV0OfNy10nDalXHvp9TJVfKdjF7jheYmcOJNsPT1HnXgofMAwb9hx
	NmGATlU33I3A8OnWmJc8jP0GieaKHqKXZ8yfbkV4NZtb1CdsHmUQ337ZdPMpvQEcUTmjKaDqgc8
	XuobY1P+yNoE37lndPRUstfofVaJg9H7F0rP5l82E1+5RzDQuVKQiA1eOjQ==
X-Google-Smtp-Source: AGHT+IHXnggF01KMLdLAYb6U3Qm1a/PpNv9gKJjLUmDiaJPWMKlXI5qvZtInlszm2rPCoHaFbQWHkA==
X-Received: by 2002:a05:600c:a105:b0:46d:83e7:45ec with SMTP id 5b1f17b1804b1-46fa29e1e0amr57776085e9.11.1760003607580;
        Thu, 09 Oct 2025 02:53:27 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07cbasm77804775e9.7.2025.10.09.02.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:53:26 -0700 (PDT)
Date: Thu, 9 Oct 2025 12:53:24 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 20/24] arm64: dts: qcom: glymur-crd: Add power supply and
 sideband signal for pcie5
Message-ID: <qudnwwle62rekkuaeriqhvkvk5xukl4fmkhkzjse5zud37vlxl@gek6nmscgvgs>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-20-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v1-20-24b601bbecc0@oss.qualcomm.com>

On 25-09-25 12:02:28, Pankaj Patil wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Add perst, wake and clkreq sideband signals and required regulators in
> PCIe5 controller and PHY device tree node.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 68 +++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> index 3f94bdf8b3ccfdff182005d67b8b3f84f956a430..03aacdb1dd7e2354fe31e63183519e53fa022829 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> @@ -107,6 +107,20 @@ port@1 {
>  			};
>  		};
>  	};
> +
> +	vreg_nvme: regulator-nvme {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_NVME_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmh0101_gpios 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&nvme_reg_en>;
> +		pinctrl-names = "default";
> +	};
>  };
>  
>  &tlmm {

so tlmm already exists in here, but ...

> @@ -461,3 +475,57 @@ vreg_l4h_e0_1p2: ldo4 {
>  &pmk8850_rtc {
>  	no-alarm;
>  };
> +
> +&pmh0101_gpios {
> +	nvme_reg_en: nvme-reg-en-state {
> +		pins = "gpio14";
> +		function = "normal";
> +		bias-disable;
> +	};
> +};
> +
> +&tlmm {

you add it here again.

> +	pcie5_default: pcie5-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio153";
> +			function = "pcie5_clk_req_n";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +

