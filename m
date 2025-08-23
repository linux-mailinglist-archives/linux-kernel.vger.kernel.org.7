Return-Path: <linux-kernel+bounces-783074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D7B32918
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4518AAA070E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682025B1FF;
	Sat, 23 Aug 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="AMgkdmbq"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCD15ECCC;
	Sat, 23 Aug 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958868; cv=none; b=TBoE/PsA8sxLJ8t6U50EtV62fLNrxT+LCls+F9fTTh7nquemz6VltaXlFR5AqzA28G7WrHX23gnDbf9K4vs7WwFLLmW9Lm443d8/Xo6uE7gZUZuh9cz0SGDJ4ghkexJxMDAnV1WeaNBi3JjRzij2cDDy5CfKduxlufRVEUDW44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958868; c=relaxed/simple;
	bh=JFft/FXSDO4ypbrVZyw9DalUpokF7DX877H6dzJtP5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFR16MU27yuXLabyq5yW4EAcZAxIUICP6MC5UjV02ySjPCblBugpnZX2Bm/77vqHEG+o25zMNdJZ8do/ySWppaxdnIUwe1/cmgcpZxd7lG3KmLP/4w2ld/tQIFka365mlXZ2b85lUOyjS/iq+5GAdl52yP3nidWTCots6fvUuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=AMgkdmbq; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1755958862; bh=JFft/FXSDO4ypbrVZyw9DalUpokF7DX877H6dzJtP5M=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=AMgkdmbqw9szbcTxLUoM0Fk6qJABiZaHCQDOw5kh3AvOHXt8XXdfaHQQvu6K2E8DU
	 r43TrBxW+re8qLO6i4qNvIDOVHOBXGbDx1wVCdHhnACiR/OgVKXImOZu6YKHNPGcOD
	 q3YD51V9w55J9q5XNGJOyK/hvX60iy6V2d3BGjH0=
Date: Sat, 23 Aug 2025 16:21:01 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: maud_spierings@hotmail.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Enable the NPU on the orangepi
 5 boards
Message-ID: <7mt62weitabjzhuqnqkfonztxzx4on23nbexw7xygl622r43bj@tfs47k6aohu6>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	maud_spierings@hotmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
 <20250823-orangepi5-v1-3-ae77dd0e06d7@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250823-orangepi5-v1-3-ae77dd0e06d7@hotmail.com>

Hello Maud,

On Sat, Aug 23, 2025 at 02:43:52PM +0200, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> Enable the NPU and the PMIC that powers it.

Reviewed-by: Ondřej Jirman <megi@xff.cz>

> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---
>  .../arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
> index 91d56c34a1e456e18db31e1bbe7252b7e4632588..ac1df223d6a25f3059ce33970953745e402ef695 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
> @@ -258,6 +258,28 @@ regulator-state-mem {
>  	};
>  };
>  
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1m2_xfer>;
> +	status = "okay";
> +
> +	vdd_npu_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_npu_s0";
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <950000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
>  &i2c6 {
>  	clock-frequency = <400000>;
>  	status = "okay";
> @@ -352,6 +374,40 @@ &pd_gpu {
>  	domain-supply = <&vdd_gpu_s0>;
>  };
>  
> +&pd_npu {
> +	domain-supply = <&vdd_npu_s0>;
> +};
> +
> +&rknn_core_0 {
> +	npu-supply = <&vdd_npu_s0>;
> +	sram-supply = <&vdd_npu_s0>;
> +	status = "okay";
> +};
> +
> +&rknn_core_1 {
> +	npu-supply = <&vdd_npu_s0>;
> +	sram-supply = <&vdd_npu_s0>;
> +	status = "okay";
> +};
> +
> +&rknn_core_2 {
> +	npu-supply = <&vdd_npu_s0>;
> +	sram-supply = <&vdd_npu_s0>;
> +	status = "okay";
> +};
> +
> +&rknn_mmu_0 {
> +	status = "okay";
> +};
> +
> +&rknn_mmu_1 {
> +	status = "okay";
> +};
> +
> +&rknn_mmu_2 {
> +	status = "okay";
> +};
> +
>  &saradc {
>  	vref-supply = <&vcc_1v8_s0>;
>  	status = "okay";
> 
> -- 
> 2.50.1
> 
> 

