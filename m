Return-Path: <linux-kernel+bounces-885474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0744AC33034
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875DB18C2193
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540162EFDA2;
	Tue,  4 Nov 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZw2V5wm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6923A9AE;
	Tue,  4 Nov 2025 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762291192; cv=none; b=lzM06JmKKyiQqrSTkQX3e1cYRaeFc8jIgZDeVNLCcyNUH+iBTZgeiRZRTwcjr7EsWVObRFkQInEsuzO2lwgRMjIhZL9k08TQUQL+NnSZDd2U+QIC3H3GOP5l9zVYimBLAlU/NFmfoDv6UxK5RT2oVxybXcA2kNYqWttOAMeK6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762291192; c=relaxed/simple;
	bh=v+uO1hmDDwfrKUN43sgBzv3BYJCFsycp3kZmyNUQIbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rWkpgtcNWs5jc7Mv8i+gryzEELfeugy4+U7a8BrcMJ15nh1jPMU7Hm090N1LzphCC14fRHrIKDxSlN1hixih7ug2vYsElKLQEVhqk78rt5cRnxT/+3NunLsfWxVLpFk2n0KLi1gzjfAeSuSeXhJXFQndgnAJQugT0FFgQ2Tx1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZw2V5wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB98C4CEF7;
	Tue,  4 Nov 2025 21:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291192;
	bh=v+uO1hmDDwfrKUN43sgBzv3BYJCFsycp3kZmyNUQIbk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qZw2V5wm3hRir6bcBV/YH7d+TnoKzr9AIdhx3n3P/uBczmtRWGusEYW+Ss1m/KU+8
	 QlJdxh9ZoyYXvZUbX6J+fgXhYukm6tnVg+JF59na+60uoG3VQhV9fVsF4jgd8+bz2H
	 p4fvisIrfLJFFsK5BjAocnRmMMyuMo4yTjouQ3PTwJBTdjpnzKqDU4Nuy7MHjYI8F2
	 Ep9SVhp5rT2lxSd54I63kvO5lWtJS5zArWnAr33k8gu/AjjN/bncJli1atFlaScnCs
	 AkqjzqUk3H5dBKbgc2bHFjhVjWTDbCkOrMiKH7AJT4JI6sc31xrTW9VgWKgY+PQ9h8
	 VtrPXL/y4kUYQ==
Message-ID: <c9c9722b-ad7a-4a4c-85b7-410829dec957@kernel.org>
Date: Tue, 4 Nov 2025 15:19:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: socfpga: agilex5: Add SMMU-V3-PMCG nodes
To: adrianhoyin.ng@altera.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fd13839ae0d1d67f77b4cce8641bc241005797c2.1760426064.git.adrianhoyin.ng@altera.com>
 <1192765d18a1dd0886e2c5a7435dc0af922996ce.1760426064.git.adrianhoyin.ng@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <1192765d18a1dd0886e2c5a7435dc0af922996ce.1760426064.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/25 21:12, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> Add SMMU-V3 Performance Monitoring Counter Group (PMCG) nodes for
> Agilex5 to support SMMU performance event monitoring.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 62 +++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 19f55a02bd56..633eab69e1c9 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -151,6 +151,12 @@ usbphy0: usbphy {
>   		compatible = "usb-nop-xceiv";
>   	};
>   
> +	pmu0: pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupt-parent = <&intc>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
>   	soc: soc@0 {
>   		compatible = "simple-bus";
>   		ranges = <0 0 0 0xffffffff>;
> @@ -840,5 +846,61 @@ queue7 {
>   				};
>   			};
>   		};
> +
> +		pmu0_tcu: pmu@16002000 {
> +			compatible = "arm,smmu-v3-pmcg";
> +			reg = <0x16002000 0x1000>,
> +				<0x16022000 0x1000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +		pmu0_tbu0: pmu@16042000 {
> +			compatible = "arm,smmu-v3-pmcg";
> +			reg = <0x16042000 0x1000>,
> +				<0x16052000 0x1000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +		pmu0_tbu1: pmu@16062000 {
> +			compatible = "arm,smmu-v3-pmcg";
> +			reg = <0x16062000 0x1000>,
> +				<0x16072000 0x1000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +		pmu0_tbu2: pmu@16082000 {
> +			compatible = "arm,smmu-v3-pmcg";
> +			reg = <0x16082000 0x1000>,
> +				<0x16092000 0x1000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +		pmu0_tbu3: pmu@160a2000 {
> +			compatible = "arm,smmu-v3-pmcg";
> +			reg = <0x160A2000 0x1000>,
> +				<0x160B2000 0x1000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +		pmu0_tbu4: pmu@160c2000 {
> +			compatible = "arm,smmu-v3-pmcg";
> +			reg = <0x160C2000 0x1000>,
> +				<0x160D2000 0x1000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 146 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +		pmu0_tbu5: pmu@160e2000 {
> +			compatible = "arm,smmu-v3-pmcg";
> +			reg = <0x160E2000 0x1000>,
> +				<0x160F2000 0x1000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
> +		};
>   	};
>   };

Applied!

Thanks,
Dinh

