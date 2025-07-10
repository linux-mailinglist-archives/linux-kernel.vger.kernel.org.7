Return-Path: <linux-kernel+bounces-725558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D6B000BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0FF7AD6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCBC24729D;
	Thu, 10 Jul 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Swqb+u8N"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D4193079;
	Thu, 10 Jul 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147953; cv=none; b=nnZbyqvMgkyLqVRdAe7nlwrTTLPRZ03I0cUlDvPh47pHqslWqagsHFWUrCDfReCV4Q8htiPhiD2yj3a5gYAa8Y0kE6fab+FJSGlT/wBCFRNxBp9nn5bQfiAS2IYjxbUKvygBNhCGsVh7paVOORpFVIXQoewG2brf0k1538YqJJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147953; c=relaxed/simple;
	bh=VzSbGFZbiAdg2Q2CosizHpRCWO4uJCXbAFHqKYELZ6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3eTT0iIZo2wFWH6z09ljp4WlqWV3y+H3nrdsxbixX31bZCa80B/KIUjZPmIRpxbVDBQ8y8FbZtOCNKe1+GnhgQWJM6MLrgDCV5f13p7EpDr02xO2cU58qGWmPc66pugyIZ7VHw3nfIfqRvUeoKS2tahhKpuhYBUl+N7wexieRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Swqb+u8N; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=reD0Z/OzeLLuQebkmfVULjQ6q5KpdwV263NNwktOYOs=; b=Swqb+u8NjwNq2ygF9l+WvV62ey
	Pkv9pnKzNdO83sVwKtwjQVXeOV6gSh8xMmgNz7fZfu1UJpupxMuQbVMWIYXUtAxjPi/8pAg2sMWbl
	PHOyY/G+UNhh/+ZUKngi4IC1BpfMnn+7VIttbB0C0UjFVDZzXbn25A/LRkYwvKFf6hDjFMBYgG+9g
	qkm3alOdWNgnzVVecL+xxKz7QbxfnPhsbidddS3TdgttvQxvr2KlGhsUcV/pVr31IGsOcfrF9DOW+
	no8FwUJHfq4Bj/eOSWV+0bCYbd3IOyUPozMYEA04UbE83UlTbsnID5V+mVr0woRc6WqWulZ3AfF+9
	cDS5fPSg==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZpih-0004ca-Op; Thu, 10 Jul 2025 13:45:43 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, Jonas Karlman <jonas@kwiboo.se>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH v2 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency scaling
 support
Date: Thu, 10 Jul 2025 13:45:43 +0200
Message-ID: <5025631.aeNJFYEL58@phil>
In-Reply-To: <20250620100010.1291658-2-amadeus@jmu.edu.cn>
References:
 <20250620100010.1291658-1-amadeus@jmu.edu.cn>
 <20250620100010.1291658-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 20. Juni 2025, 12:00:10 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Chukun Pan:
> By default, the CPUs on RK3528 operates at 1.5GHz. Add CPU frequency and
> voltage mapping to the device tree to enable dynamic scaling via cpufreq.
>=20
> The OPP values come from downstream kernel[1]. Both 408MHz and 600MHz
> frequencies use the normal PLL, so use the corresponding highest voltage.
>=20
> The voltage used for other frequencies can't be less than above (875mV).
> Therefore, 816MHz to 1200MHz also uses the corresponding highest voltage.

There has often been the argument that selecting a frequency that has the
same voltage as a faster frequency does not save any power.

Hence I remember that we dropped slower frequencies on other socs
that share the same voltage with a higher frequency.

>=20
> The remaining 1416MHz to 2016MHz use a voltage close to actual frequency.
>=20
> [1] https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64=
/boot/dts/rockchip/rk3528.dtsi
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 64 ++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3528.dtsi
> index 829f980ea353..5cb7f10b79ed 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -53,6 +53,7 @@ cpu0: cpu@0 {
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			clocks =3D <&scmi_clk SCMI_CLK_CPU>;
> +			operating-points-v2 =3D <&cpu_opp_table>;
>  		};
> =20
>  		cpu1: cpu@1 {
> @@ -61,6 +62,7 @@ cpu1: cpu@1 {
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			clocks =3D <&scmi_clk SCMI_CLK_CPU>;
> +			operating-points-v2 =3D <&cpu_opp_table>;
>  		};
> =20
>  		cpu2: cpu@2 {
> @@ -69,6 +71,7 @@ cpu2: cpu@2 {
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			clocks =3D <&scmi_clk SCMI_CLK_CPU>;
> +			operating-points-v2 =3D <&cpu_opp_table>;
>  		};
> =20
>  		cpu3: cpu@3 {
> @@ -77,6 +80,67 @@ cpu3: cpu@3 {
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			clocks =3D <&scmi_clk SCMI_CLK_CPU>;
> +			operating-points-v2 =3D <&cpu_opp_table>;
> +		};
> +	};
> +
> +	cpu_opp_table: opp-table-cpu {
> +		compatible =3D "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz =3D /bits/ 64 <408000000>;
> +			opp-microvolt =3D <875000 875000 1100000>;
> +			clock-latency-ns =3D <40000>;
> +			opp-suspend;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz =3D /bits/ 64 <600000000>;
> +			opp-microvolt =3D <875000 875000 1100000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-816000000 {
> +			opp-hz =3D /bits/ 64 <816000000>;
> +			opp-microvolt =3D <875000 875000 1100000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1008000000 {
> +			opp-hz =3D /bits/ 64 <1008000000>;
> +			opp-microvolt =3D <875000 875000 1100000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz =3D /bits/ 64 <1200000000>;
> +			opp-microvolt =3D <900000 900000 1100000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1416000000 {
> +			opp-hz =3D /bits/ 64 <1416000000>;
> +			opp-microvolt =3D <925000 925000 1100000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1608000000 {
> +			opp-hz =3D /bits/ 64 <1608000000>;
> +			opp-microvolt =3D <975000 975000 1100000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1800000000 {
> +			opp-hz =3D /bits/ 64 <1800000000>;
> +			opp-microvolt =3D <1037500 1037500 1100000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-2016000000 {
> +			opp-hz =3D /bits/ 64 <2016000000>;
> +			opp-microvolt =3D <1100000 1100000 1100000>;
> +			clock-latency-ns =3D <40000>;
>  		};
>  	};
> =20
>=20





