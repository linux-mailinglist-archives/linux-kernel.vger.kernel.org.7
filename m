Return-Path: <linux-kernel+bounces-866920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121EEC01094
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFD23A9DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA5311C07;
	Thu, 23 Oct 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtItQApN"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B22E2DDE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221689; cv=none; b=slkYKHhwZPlA/PfkbAVHx73vb3yStCJMQ8Yg0j6cLGneYQ4u48fKd2l4cABaDShmWazB98H6TObVPTWIuaIGIJbipeBrN2n5HTqWb0O7CtVI9PKGQtaqhNC/26PBeNlevZS7QxmHdzocRLFpzutA2a1smosVbeX74ZkkhYXsJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221689; c=relaxed/simple;
	bh=ZhystKoo43Dti+bpSBJIod4fu4Bu+YnvXyc3sQZGb9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8V6vexR/khs183ZvCtvvsDPPJX0DxZDKN+EJ9ppWD9KiRa/rjel4jX+Kbcn8OmrnndisoTxxhYUUSXFDSX7B2WkbnFBYGQ1Y9IN1gvU0oOLtA80uaflavP5fEQeBDm6fjR/AXYvOr192nFR9RCRnh1gYScVLckL1txIfhaRjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UtItQApN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so6063835e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761221681; x=1761826481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzSn/ofpSQ3cyLuuE3gy3xtWs7k4M2brzlRD1/+xzHg=;
        b=UtItQApNiPpb0l5qHWINiHPshhfGZXyPSdjAKSDTSS9SYTz5HDXXsVZu0EJoSONd/3
         HB8ztJ1Q1bn/plet/jmyWQgxt82UgGgE4OQOTIgTeotL64fgTmx3s/jSezhWCmjb0d+O
         tm81s38wbNbrxGIwiALsPAX4Mka9SiJtX/qI7Hm5uvk/aFeF/04Vm7bH1MTbGCboDDpw
         29wxQbspixRaFpUqiIDnUtokhQm3CfAADksbXzbklqmCIkORsn5HUclfWXVVRgk27tMF
         qMKpJA+0mAlx13XzDXZTwgELI4ZxIE/gUow1GugBNdzoGcW1JXY+CrzYEuTmq7N6xUjx
         dwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221681; x=1761826481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzSn/ofpSQ3cyLuuE3gy3xtWs7k4M2brzlRD1/+xzHg=;
        b=NJ4dAcL8m/QYx5hiNSmEjcAjwrjR4xaG51ZKIZt+JgVeO/32PDNH9HfEnlCnjhCQ6c
         5yBrwBjnoJcQGtaYoX/cVPw3dEoSe+mUpxmSPZVpznBMfpSdt3K74gleQljSfO3gBiI6
         Ni31ATjHNBLz0UIyXy8yajbFNMJwnpUktTsCZP47YIWighvCLEVU5eOg6lxyPK7jfzfr
         Z2xXU57IaArwaRngoOgtz2mOvA8Psc7B0KRzYD1AcH8hBSNUuCIajD6JqL6HIzMPj35E
         g+9XSTpUnxs+Uz/rLtmbnd3bgTTlWjUAYtaKsr+0HERNAUhhimpl8VH8e5Txnob4SY82
         kEwg==
X-Forwarded-Encrypted: i=1; AJvYcCV3DZstWOzF2ZQBl3fo4P43ow4Ntf5zEkFzfEQMXyZWCqCNjwG93cOlAiTreP3o+CXNRpai2iqJftATpEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64ylkUZFrDkXMVt2PC7NSHtBOOvQtGBuU2QyN65GznCyg+sjj
	DZjf6Y8JdCCT13mulF1vEN8/QWre2JmYAzR4Pm6qOXBx4rE2YlqHg9Q8wuxwV8g8jsE=
X-Gm-Gg: ASbGncsz+/E2ZV+dzG/ofYKriIF71sozirMZymuSP83xv8IZCbQ/MEnr8hlRQsrucNC
	PK8xLvMC2r3VnIeQTyH2nixESKW+JO5//e0zi1DovPZznUAgrIRvppaUEcLV7KWXgrbRmGAlsLx
	lNBPjbe4WRqniEds2SUaSA+WKnoXWVr4ZnPKQuIJO+5WBFhFCxeJJwImjFyrD9ULqqU0cDLqizz
	m3zhLaUbEHbofkuJX97nIPJZ25pS354Y31rTAre3C8ffR8bSt3sn+cbJ5RR/zEsSQR+SiPce7nn
	vcs0eGBno2/buDXfEFZOCfHi+gqwcgIWJIldy46W+bDICJNSW0tJ0VGlnRFm17gIxToES9zwGnt
	yh1y2Tin9ZZusfch/0ryaGvksNiHw2I7wret1pRlQTZxEdS345vJSBn6hXPe95W3Ql4Dwl5gYWP
	FRK/1CU2GMmDjrD6a0Qg==
X-Google-Smtp-Source: AGHT+IGa6YZVedfz0mGpkJYgXn+quvhlbpzP0Y7djJyWwUQrWVTgUOvmVrts9NVOpQ28SystD6Xtkg==
X-Received: by 2002:a05:600c:34c7:b0:46f:b42e:e360 with SMTP id 5b1f17b1804b1-47117931edcmr178691255e9.40.1761221680862;
        Thu, 23 Oct 2025 05:14:40 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccd88sm4402444f8f.36.2025.10.23.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:14:39 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:14:37 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH V2 2/4] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
Message-ID: <kbbebw2kr3hu6q3sb4z3i7yy7vv432rjx2ylp254cbifpcxe33@bhyldim36fff>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
 <20251023112924.1073811-3-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023112924.1073811-3-sarthak.garg@oss.qualcomm.com>

On 25-10-23 16:59:22, Sarthak Garg wrote:
> Add SD Card host controller for sm8750 soc.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 68 ++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index a82d9867c7cb..1070dc5ea196 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -2060,6 +2060,60 @@ ice: crypto@1d88000 {
>  			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
>  		};
>  
> +		sdhc_2: mmc@8804000 {
> +			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq",
> +					  "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface",
> +				      "core",
> +				      "xo";
> +
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "sdhc-ddr",
> +					     "cpu-sdhc";
> +
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			qcom,dll-config = <0x0007442c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			iommus = <&apps_smmu 0x540 0x0>;
> +			dma-coherent;
> +
> +			bus-width = <4>;
> +			max-sd-hs-hz = <37500000>;
> +
> +			resets = <&gcc GCC_SDCC2_BCR>;
> +
> +			status = "disabled";
> +
> +			sdhc2_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +			};
> +		};
> +
>  		cryptobam: dma-controller@1dc4000 {
>  			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>  			reg = <0x0 0x01dc4000 0x0 0x28000>;
> @@ -3121,6 +3175,13 @@ data-pins {
>  					drive-strength = <2>;
>  					bias-pull-up;
>  				};
> +
> +				card-detect-pins {
> +					pins = "gpio55";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};

These are board specific, so move them to the board dts.

>  			};
>  
>  			sdc2_default: sdc2-default-state {
> @@ -3141,6 +3202,13 @@ data-pins {
>  					drive-strength = <10>;
>  					bias-pull-up;
>  				};
> +
> +				card-detect-pins {
> +					pins = "gpio55";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};

Ditto.

>  			};
>  		};
>  
> -- 
> 2.34.1
> 

