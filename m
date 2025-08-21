Return-Path: <linux-kernel+bounces-780124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F4B2FDED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710061BA186D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E027E1B1;
	Thu, 21 Aug 2025 15:08:17 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA26267729;
	Thu, 21 Aug 2025 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788896; cv=none; b=GMaQNt4Ep7cxKecrqjHdDCOaab8lLMKMZrfjVM6sn0tKU3qf9DKPeUUD0xehHZBjpHmN2YNcdy5NiQzjH4YfEbugRyp2W25i4KnTgooROIwa2JntTcNXEw3xPjbng1huH5mtOHtqSOpruMJfKetsmLtr8sSudOh/G4GBQ8YWDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788896; c=relaxed/simple;
	bh=TGvGGfv39AQnpMpmLvE3mmd5FvcT3FttZTFkgvHVX+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLOXyyqEhtq2fpY5d/fFgf1lJEWZv9AX4XN5nN1dRXpCYwyY72WElLSM9TmlZ/VShGFzcoYTgryCSfuH5uxsN5ewmfEO9gUU+VPlSexcN7tcYbPci+fO3yeEpTukENfbZZbfsHoO2cog47pz7kYa5cx7Dd2DNWAejinZczMkpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.63.12])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id B4381B4E29EB;
	Thu, 21 Aug 2025 17:08:01 +0200 (CEST)
Message-ID: <ec1c2ad0-7483-410e-8026-b09eb5e33ee4@freeshell.de>
Date: Thu, 21 Aug 2025 08:07:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] riscv: dts: starfive: jh7110-common: Move out some
 nodes to the board dts
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
 <20250821100930.71404-3-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250821100930.71404-3-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 03:09, Hal Feng wrote:
> Some node in this file are not used by the upcoming VisionFive 2 Lite
> board. Move them to the board dts to prepare for adding the new
> VisionFive 2 Lite device tree.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../boot/dts/starfive/jh7110-common.dtsi      | 22 ---------
>  .../jh7110-deepcomputing-fml13v01.dts         | 49 +++++++++++++++++++
>  .../boot/dts/starfive/jh7110-milkv-mars.dts   | 49 +++++++++++++++++++
>  .../dts/starfive/jh7110-pine64-star64.dts     | 49 +++++++++++++++++++
>  .../jh7110-starfive-visionfive-2.dtsi         | 46 +++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 16 ------
>  6 files changed, 193 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index 2eaf01775ef5..8332622420ca 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -281,15 +281,9 @@ &mmc0 {
>  	assigned-clock-rates = <50000000>;
>  	bus-width = <8>;
>  	bootph-pre-ram;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	cap-mmc-hw-reset;
>  	post-power-on-delay-ms = <200>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> -	vmmc-supply = <&vcc_3v3>;
> -	vqmmc-supply = <&emmc_vdd>;
>  	status = "okay";
>  };
>  
> @@ -299,12 +293,7 @@ &mmc1 {
>  	assigned-clock-rates = <50000000>;
>  	bus-width = <4>;
>  	bootph-pre-ram;

> -	no-sdio;

drop no-sdio, it is not there in riscv-dt-for-next branch
ref: https://lore.kernel.org/lkml/20250819-sushi-change-1254c2d2a08d@spud/

> -	no-mmc;

similar, I think we should now drop no-mmc unless you can say there is a
defect which requires it. I have tested with Star64 and Milk-V Mars
CM(/-Lite);  if you can confirm with boards you have access to that
'no-mmc' can be dropped then we should just drop it. The correct reason
for having this 'no-mmc' would only be if the controller has an error
when receiving these commands.

> -	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> -	disable-wp;
>  	cap-sd-highspeed;

> -	post-power-on-delay-ms = <200>;

I would like to know the reason for this delay configuration? Is it
described somewhere in technical documentation or discussion why we have
this?

>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins>;
>  	status = "okay";
> @@ -448,17 +437,6 @@ GPOEN_SYS_I2C6_DATA,
>  	};
>  
>  	mmc0_pins: mmc0-0 {
> -		 rst-pins {
> -			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> -					      GPOEN_ENABLE,
> -					      GPI_NONE)>;
> -			bias-pull-up;
> -			drive-strength = <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -
>  		mmc-pins {
>  			pinmux = <PINMUX(PAD_SD0_CLK, 0)>,
>  				 <PINMUX(PAD_SD0_CMD, 0)>,
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> index f2857d021d68..5a2a41a7e8c3 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> @@ -11,6 +11,55 @@ / {
>  	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
>  };
>  
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz = /bits/ 64 <375000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz = /bits/ 64 <500000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz = /bits/ 64 <750000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz = /bits/ 64 <1500000000>;
> +		opp-microvolt = <1040000>;
> +	};
> +};
> +
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
> +};
> +
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength = <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate = <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	post-power-on-delay-ms = <200>;
> +};
> +
>  &pcie1 {
>  	perst-gpios = <&sysgpio 21 GPIO_ACTIVE_LOW>;
>  	phys = <&pciephy1>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> index fdaf6b4557da..96f6b2f072d4 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> @@ -11,6 +11,25 @@ / {
>  	compatible = "milkv,mars", "starfive,jh7110";
>  };
>  
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz = /bits/ 64 <375000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz = /bits/ 64 <500000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz = /bits/ 64 <750000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz = /bits/ 64 <1500000000>;
> +		opp-microvolt = <1040000>;
> +	};
> +};
> +
>  &gmac0 {
>  	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>  	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> @@ -22,6 +41,36 @@ &i2c0 {
>  	status = "okay";
>  };
>  
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
> +};
> +
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength = <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate = <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	post-power-on-delay-ms = <200>;
> +};
> +
>  &pcie0 {
>  	status = "okay";
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> index 31e825be2065..c9677aef9ff0 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> @@ -14,6 +14,25 @@ aliases {
>  	};
>  };
>  
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz = /bits/ 64 <375000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz = /bits/ 64 <500000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz = /bits/ 64 <750000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz = /bits/ 64 <1500000000>;
> +		opp-microvolt = <1040000>;
> +	};
> +};
> +
>  &gmac0 {
>  	starfive,tx-use-rgmii-clk;
>  	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> @@ -44,6 +63,36 @@ &i2c0 {
>  	status = "okay";
>  };
>  
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
> +};
> +
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength = <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate = <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	post-power-on-delay-ms = <200>;
> +};
> +
>  &pcie1 {
>  	status = "okay";
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 5f14afb2c24d..d1e4206f1251 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -13,6 +13,25 @@ aliases {
>  	};
>  };
>  
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz = /bits/ 64 <375000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz = /bits/ 64 <500000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz = /bits/ 64 <750000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz = /bits/ 64 <1500000000>;
> +		opp-microvolt = <1040000>;
> +	};
> +};
> +
>  &gmac0 {
>  	status = "okay";
>  };
> @@ -38,9 +57,36 @@ &i2c0 {
>  };
>  
>  &mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
>  	non-removable;
>  };
>  
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength = <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate = <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	post-power-on-delay-ms = <200>;
> +};
> +
>  &pcie0 {
>  	status = "okay";
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 0ba74ef04679..d2463399b959 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -200,22 +200,6 @@ core4 {
>  	cpu_opp: opp-table-0 {
>  			compatible = "operating-points-v2";
>  			opp-shared;
> -			opp-375000000 {
> -					opp-hz = /bits/ 64 <375000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-500000000 {
> -					opp-hz = /bits/ 64 <500000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-750000000 {
> -					opp-hz = /bits/ 64 <750000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-1500000000 {
> -					opp-hz = /bits/ 64 <1500000000>;
> -					opp-microvolt = <1040000>;
> -			};
>  	};
>  
>  	thermal-zones {

With that,

Reviewed-by: E Shattow <e@freeshell.de>

