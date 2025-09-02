Return-Path: <linux-kernel+bounces-795398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33814B3F168
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 02:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCAA1A86E63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 00:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78921E98E6;
	Tue,  2 Sep 2025 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uyhey97H"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EDD800;
	Tue,  2 Sep 2025 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756771245; cv=none; b=q/npTqEKfqpe4XQAGsgtboU2XyI6ySm2hmpO+PHgQkBwUDBOgtx/ZVCEU8QzFALCQ4u1VyNyREz234g97EnYLxUtBTGmLRJdGEFYUvKlBCPIQghyV6p5TicuV8zHpFZI0bve7ijsYYE02LR+CRYhVXEo4csEHiTcHmP3KeSruZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756771245; c=relaxed/simple;
	bh=lTx5ebup15L8Y8dWezY7Q+L8eTFTcPmG7X75AeaDG7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htqFhz5FjLQiDF4NYMTObuXh+jDEJmPuXQQbQbqpYFb1CCbNpz2jm4ueXFQCbbQfxZV8IHQfe0XLG9M95x6trmLyEiE/kv4I7hbd/pYfz8SB3pgNTkFbC1n6w53Ioj2MyBKzEhY6Kb31EePHdgEv9Rb5eKrXEoeYdt7vtixA9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uyhey97H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756771241;
	bh=lTx5ebup15L8Y8dWezY7Q+L8eTFTcPmG7X75AeaDG7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uyhey97Hq08CpJlD4ljK9VVtmMYrunawlcrse06eEGa8pTAZasj3E8hNswtF2a92d
	 iiqxAdfK055Cfczmv+fkX85vHvdfz6EQehT4M8SgQNIEIKvQNTx5WfgR7f00aG/kWd
	 saaI5J1aAkuYOIsCRtX8e1S4NaUFVynlWnZG1xwCbtihv2/GTC/BQ2sbugtx9gwZx+
	 JKo/st3OX8fxXuY8wma6YIVLBF2TsGywK+jB0MtOeTA0/ii/cv0p0eJSH3IUZhwsCk
	 9J+r0b/xQRbKwIoC/g4pUGaUS8mPelIVT9R+yp/2MjADokykyfDPLxavq+hFXXPB3B
	 KBZEfr57+g86w==
Received: from [10.40.0.100] (185-251-200-65.lampert.tv [185.251.200.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C7B9617E0488;
	Tue,  2 Sep 2025 02:00:40 +0200 (CEST)
Message-ID: <03182857-2d74-42f5-850f-d5edca9ad19c@collabora.com>
Date: Tue, 2 Sep 2025 02:00:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] arm64: dts: rockchip: add mipi csi-2 dphy nodes to
 rk3588
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Collabora Kernel Team <kernel@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
 <20250616-rk3588-csi-dphy-v3-7-a5ccd5f1f438@collabora.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v3-7-a5ccd5f1f438@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 9/1/25 22:47, Michael Riesch via B4 Relay wrote:
> From: Michael Riesch <michael.riesch@collabora.com>
> 
> The Rockchip RK3588 features two MIPI CSI-2 DPHYs. Add the device
> tree nodes for them.
> 
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 33 +++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> index 70f03e68ba55..eedf93247e9c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -621,6 +621,16 @@ php_grf: syscon@fd5b0000 {
>  		reg = <0x0 0xfd5b0000 0x0 0x1000>;
>  	};
>  
> +	csidphy0_grf: syscon@fd5b4000 {
> +		compatible = "rockchip,rk3588-csidphy-grf", "syscon";
> +		reg = <0x0 0xfd5b4000 0x0 0x1000>;
> +	};
> +
> +	csidphy1_grf: syscon@fd5b5000 {
> +		compatible = "rockchip,rk3588-csidphy-grf", "syscon";
> +		reg = <0x0 0xfd5b5000 0x0 0x1000>;
> +	};
> +
>  	pipe_phy0_grf: syscon@fd5bc000 {
>  		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
>  		reg = <0x0 0xfd5bc000 0x0 0x100>;
> @@ -3052,6 +3062,29 @@ mipidcphy1: phy@fedb0000 {
>  			 <&cru SRST_S_MIPI_DCPHY1>;
>  		reset-names = "m_phy", "apb", "grf", "s_phy";
>  		#phy-cells = <1>;

Not my day today, apparently. status = "disabled"; is removed from the
mipicdphy1 node.

Hence, there is going to be a v4 in which I fix this -- but maybe you
all can still review the series.

Best regards,
Michael

> +	};
> +
> +	csi_dphy0: phy@fedc0000 {
> +		compatible = "rockchip,rk3588-csi-dphy";
> +		reg = <0x0 0xfedc0000 0x0 0x8000>;
> +		clocks = <&cru PCLK_CSIPHY0>;
> +		clock-names = "pclk";
> +		#phy-cells = <0>;
> +		resets = <&cru SRST_P_CSIPHY0>, <&cru SRST_CSIPHY0>;
> +		reset-names = "apb", "phy";
> +		rockchip,grf = <&csidphy0_grf>;
> +		status = "disabled";
> +	};
> +
> +	csi_dphy1: phy@fedc8000 {
> +		compatible = "rockchip,rk3588-csi-dphy";
> +		reg = <0x0 0xfedc8000 0x0 0x8000>;
> +		clocks = <&cru PCLK_CSIPHY1>;
> +		clock-names = "pclk";
> +		#phy-cells = <0>;
> +		resets = <&cru SRST_P_CSIPHY1>, <&cru SRST_CSIPHY1>;
> +		reset-names = "apb", "phy";
> +		rockchip,grf = <&csidphy1_grf>;
>  		status = "disabled";
>  	};
>  
> 


