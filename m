Return-Path: <linux-kernel+bounces-856516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FCEBE45EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E89A35902C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5134F499;
	Thu, 16 Oct 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCxMzPP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9001C84B2;
	Thu, 16 Oct 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630093; cv=none; b=nEiF/uWlkr0L/CsuD6/sqyVsW0ygvNYw7uqHRX1ikdmPlmAwM52FzbG0lj6cr/65H51CsbwHXYn6Lj6eBKO4j6vHnST5MRw8LdiS//oqbL5W5TOj3VVGCv38b3DZ9HC0HVE+pFznEgJFtnjWdraICiCf482KTzzwctpuKvabOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630093; c=relaxed/simple;
	bh=hCXJj2ZQQunKXdQtPbAlC5ujVXRGTPASQI8qWWbs9og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuxAu4EG9YjltR6jesXUV/AKrMqXTlfjBIZuqmsQPdQSG8YRkvE3pDI6/zMRv4+JF8jVfxKHnxfSHSB8ZfCMbIgfTq4qM7rzRSo5phdOXauEFekcXJJGhHP0Rol/jASliywSBLK/Ik9SO+jzARbKlLEqbzcWXGML3MrcVb/pGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCxMzPP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EDAC116C6;
	Thu, 16 Oct 2025 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630093;
	bh=hCXJj2ZQQunKXdQtPbAlC5ujVXRGTPASQI8qWWbs9og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCxMzPP9E2Q4/twNBfUJzZvw4nvroUq3wS6qnR0pcFqM06Am126/L52MQ3FaxejrW
	 lyAQUQNLXQKeCS1HftR1PtbJhEIjxgYVJhAIwQPqkDyp2EFBWOHvUl/yE6Lvd5yAIz
	 WQPMEAOXdLi7bKKPfb1fY/aiF0w64PkI5ERvz7rXl6GtwBYwMmKRL6vBfsS7YYZRi2
	 cKpt+3lH/FpYJZYWXXorKUEzhad1aShe0O0mWJO9xZQOZL0zrhCLa63I8bmDke40uo
	 70qyJhOCfLOZCuqFT8D1XH0FFtwdIQfmVNuWzXnBWbYcS3n0Zxgab6hbGggc/YE+Mb
	 u4OlqR4HQI+pw==
Date: Thu, 16 Oct 2025 16:54:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/7] riscv: dts: starfive: jh7110-common: Move out
 some nodes to the board dts
Message-ID: <20251016-portion-margarine-b79b9f366582@spud>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
 <20251016080054.12484-5-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="niEVM0SQyhIdNYKc"
Content-Disposition: inline
In-Reply-To: <20251016080054.12484-5-hal.feng@starfivetech.com>


--niEVM0SQyhIdNYKc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Emil,

On Thu, Oct 16, 2025 at 04:00:51PM +0800, Hal Feng wrote:
> Some node in this file are not used by the upcoming VisionFive 2 Lite
> board. Move them to the board dts to prepare for adding the new
> VisionFive 2 Lite device tree.

I definitely want your input as to whether these jh7110s devices should
share the same common file as the devices using the regular jh7110.

Cheers,
Conor.

>=20
> Reviewed-by: E Shattow <e@freeshell.de>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../boot/dts/starfive/jh7110-common.dtsi      | 19 --------
>  .../jh7110-deepcomputing-fml13v01.dts         | 46 +++++++++++++++++++
>  .../boot/dts/starfive/jh7110-milkv-mars.dts   | 46 +++++++++++++++++++
>  .../dts/starfive/jh7110-milkv-marscm-emmc.dts |  9 ++++
>  .../dts/starfive/jh7110-milkv-marscm-lite.dts |  1 +
>  .../dts/starfive/jh7110-milkv-marscm.dtsi     | 32 +++++++++++++
>  .../dts/starfive/jh7110-pine64-star64.dts     | 46 +++++++++++++++++++
>  .../jh7110-starfive-visionfive-2.dtsi         | 43 +++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 16 -------
>  9 files changed, 223 insertions(+), 35 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 5dc15e48b74b..8cfe8033305d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -281,14 +281,8 @@ &mmc0 {
>  	assigned-clock-rates =3D <50000000>;
>  	bus-width =3D <8>;
>  	bootph-pre-ram;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	cap-mmc-hw-reset;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&mmc0_pins>;
> -	vmmc-supply =3D <&vcc_3v3>;
> -	vqmmc-supply =3D <&emmc_vdd>;
>  	status =3D "okay";
>  };
> =20
> @@ -298,8 +292,6 @@ &mmc1 {
>  	assigned-clock-rates =3D <50000000>;
>  	bus-width =3D <4>;
>  	bootph-pre-ram;
> -	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> -	disable-wp;
>  	cap-sd-highspeed;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&mmc1_pins>;
> @@ -444,17 +436,6 @@ GPOEN_SYS_I2C6_DATA,
>  	};
> =20
>  	mmc0_pins: mmc0-0 {
> -		 rst-pins {
> -			pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> -					      GPOEN_ENABLE,
> -					      GPI_NONE)>;
> -			bias-pull-up;
> -			drive-strength =3D <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate =3D <0>;
> -		};
> -
>  		mmc-pins {
>  			pinmux =3D <PINMUX(PAD_SD0_CLK, 0)>,
>  				 <PINMUX(PAD_SD0_CMD, 0)>,
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.d=
ts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> index f2857d021d68..7535d62201f1 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> @@ -11,6 +11,52 @@ / {
>  	compatible =3D "deepcomputing,fml13v01", "starfive,jh7110";
>  };
> =20
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz =3D /bits/ 64 <375000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz =3D /bits/ 64 <500000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz =3D /bits/ 64 <750000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz =3D /bits/ 64 <1500000000>;
> +		opp-microvolt =3D <1040000>;
> +	};
> +};
> +
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply =3D <&vcc_3v3>;
> +	vqmmc-supply =3D <&emmc_vdd>;
> +};
> +
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength =3D <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate =3D <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +};
> +
>  &pcie1 {
>  	perst-gpios =3D <&sysgpio 21 GPIO_ACTIVE_LOW>;
>  	phys =3D <&pciephy1>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/ri=
scv/boot/dts/starfive/jh7110-milkv-mars.dts
> index fdaf6b4557da..c2e7a91e460a 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> @@ -11,6 +11,25 @@ / {
>  	compatible =3D "milkv,mars", "starfive,jh7110";
>  };
> =20
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz =3D /bits/ 64 <375000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz =3D /bits/ 64 <500000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz =3D /bits/ 64 <750000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz =3D /bits/ 64 <1500000000>;
> +		opp-microvolt =3D <1040000>;
> +	};
> +};
> +
>  &gmac0 {
>  	assigned-clocks =3D <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>  	assigned-clock-parents =3D <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> @@ -22,6 +41,33 @@ &i2c0 {
>  	status =3D "okay";
>  };
> =20
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply =3D <&vcc_3v3>;
> +	vqmmc-supply =3D <&emmc_vdd>;
> +};
> +
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength =3D <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate =3D <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +};
> +
>  &pcie0 {
>  	status =3D "okay";
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts b/=
arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
> index e568537af2c4..ce95496263af 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
> @@ -10,3 +10,12 @@ / {
>  	model =3D "Milk-V Mars CM";
>  	compatible =3D "milkv,marscm-emmc", "starfive,jh7110";
>  };
> +
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply =3D <&vcc_3v3>;
> +	vqmmc-supply =3D <&emmc_vdd>;
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts b/=
arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
> index 6c40d0ec4011..63aa94d65ab5 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
> @@ -14,6 +14,7 @@ / {
>  &mmc0 {
>  	bus-width =3D <4>;
>  	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
>  };
> =20
>  &mmc0_pins {
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi b/arch=
/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
> index 25b70af564ee..af01d3abde2f 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
> @@ -21,6 +21,25 @@ sdio_pwrseq: sdio-pwrseq {
>  	};
>  };
> =20
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz =3D /bits/ 64 <375000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz =3D /bits/ 64 <500000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz =3D /bits/ 64 <750000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz =3D /bits/ 64 <1500000000>;
> +		opp-microvolt =3D <1040000>;
> +	};
> +};
> +
>  &gmac0 {
>  	assigned-clocks =3D <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>  	assigned-clock-parents =3D <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> @@ -40,6 +59,19 @@ &i2c6 {
>  	status =3D "disabled";
>  };
> =20
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength =3D <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate =3D <0>;
> +	};
> +};
> +
>  &mmc1 {
>  	#address-cells =3D <1>;
>  	#size-cells =3D <0>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch=
/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> index 31e825be2065..6faf3826c5c3 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> @@ -14,6 +14,25 @@ aliases {
>  	};
>  };
> =20
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz =3D /bits/ 64 <375000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz =3D /bits/ 64 <500000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz =3D /bits/ 64 <750000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz =3D /bits/ 64 <1500000000>;
> +		opp-microvolt =3D <1040000>;
> +	};
> +};
> +
>  &gmac0 {
>  	starfive,tx-use-rgmii-clk;
>  	assigned-clocks =3D <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> @@ -44,6 +63,33 @@ &i2c0 {
>  	status =3D "okay";
>  };
> =20
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply =3D <&vcc_3v3>;
> +	vqmmc-supply =3D <&emmc_vdd>;
> +};
> +
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength =3D <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate =3D <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +};
> +
>  &pcie1 {
>  	status =3D "okay";
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 5f14afb2c24d..9cd79fe30d19 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -13,6 +13,25 @@ aliases {
>  	};
>  };
> =20
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz =3D /bits/ 64 <375000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz =3D /bits/ 64 <500000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz =3D /bits/ 64 <750000000>;
> +		opp-microvolt =3D <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz =3D /bits/ 64 <1500000000>;
> +		opp-microvolt =3D <1040000>;
> +	};
> +};
> +
>  &gmac0 {
>  	status =3D "okay";
>  };
> @@ -38,9 +57,33 @@ &i2c0 {
>  };
> =20
>  &mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply =3D <&vcc_3v3>;
> +	vqmmc-supply =3D <&emmc_vdd>;
>  	non-removable;
>  };
> =20
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength =3D <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate =3D <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +};
> +
>  &pcie0 {
>  	status =3D "okay";
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 6e56e9d20bb0..a380d3dabedd 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -205,22 +205,6 @@ core4 {
>  	cpu_opp: opp-table-0 {
>  			compatible =3D "operating-points-v2";
>  			opp-shared;
> -			opp-375000000 {
> -					opp-hz =3D /bits/ 64 <375000000>;
> -					opp-microvolt =3D <800000>;
> -			};
> -			opp-500000000 {
> -					opp-hz =3D /bits/ 64 <500000000>;
> -					opp-microvolt =3D <800000>;
> -			};
> -			opp-750000000 {
> -					opp-hz =3D /bits/ 64 <750000000>;
> -					opp-microvolt =3D <800000>;
> -			};
> -			opp-1500000000 {
> -					opp-hz =3D /bits/ 64 <1500000000>;
> -					opp-microvolt =3D <1040000>;
> -			};
>  	};
> =20
>  	thermal-zones {
> --=20
> 2.43.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--niEVM0SQyhIdNYKc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEVSAAKCRB4tDGHoIJi
0rwuAQDdyg5qJYxpjeK/5dNMDTVwgh87VryxXKs5D0N+6BUmVwEAzTA2ShRWUp/0
1TpXAy5SVGAkW4aaQaTR2/flh9qg8wg=
=oqXA
-----END PGP SIGNATURE-----

--niEVM0SQyhIdNYKc--

