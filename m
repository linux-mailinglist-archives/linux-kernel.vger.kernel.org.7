Return-Path: <linux-kernel+bounces-814231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBEFB55154
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8B15866FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE13168E3;
	Fri, 12 Sep 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="rMS6PkwE"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6F310635
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686965; cv=none; b=IIKkY/BMD9AoVJkZiZyZsgt1FitfsQXgTQF0ACZCtWMCi7Pn4OGJbaJLZbEkCx6UyHmUwqcRVBcq/VFxzJzaru3UCJT69UW1MtJme8e5cHbYb74d1U4aDATf+ejwrC+tx5gqkh7AvFhhbD8FygwB/vHvT7nGnd+o8UAgu/WxiNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686965; c=relaxed/simple;
	bh=3ySml07X4eIB4Y3wf1ZAXOTQ8QZKIJK+PA15hLAjM0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpNsN8sc9kB1qovbmZJVQKUL2gUrdqNTaty7DsiBymo1H8q8c2g/BRKCF1f4EJu49i6OCjV/rUuBsWJaGxKnJmqj8ebtNhBlOpLeP6DZGRV9yGtt8hlUahNafBfnN/e39WN2t3b34nkiBIMPgOl6mkGGadSMbc55eFFRzSCSKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=rMS6PkwE; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1757686956;
 bh=MDyH5E9yt2KIlNyz+7EVC5IwRslVr8Slgb7f8Q70L2o=;
 b=rMS6PkwE0EjLo0lpGw+TECskQqJjQZpiBHGO7El/4aXydZncMgvTd+tq2xXnGSelxoVafYCnm
 VNhpfdRmk1p/K2JvMiQUY1Y1OAhh2Uhb7OxYrNrrQAzZypHdJmSVPVjJ3Kw58Puv0nMkGYLfIbI
 A2LO1NLBuh5KCtBNH1vGqaPHDhtIeLVLg+WLj/vYtMgN8c7V/W2ALXPy06TqIN6mDV/exCiQcjc
 yerPYv1bywXvBtWSdwGloJ4RbiN8Iup/ysKUihyBV0FRAs4sCqJaDdT+7/0Zv0tHKxZEzOkVmjY
 4qR7cNfo3o+QTRW5iquRtqEOEW1FHEQt78HSIC43SOMg==
X-Forward-Email-ID: 68c42c9edab860ac3968c5ee
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.14
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6bd28aaf-aafd-436e-8799-fcdb07082660@kwiboo.se>
Date: Fri, 12 Sep 2025 16:22:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm64: dts: rockchip: RK356x: Add OTP description.
To: Andrey Leonchikov <andreil499@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, dsimic@manjaro.org, dmitry.osipenko@collabora.com,
 tglx@linutronix.de, amadeus@jmu.edu.cn, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250912135542.2304150-1-andreil499@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250912135542.2304150-1-andreil499@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrey,

On 9/12/2025 3:55 PM, Andrey Leonchikov wrote:
> Add OTP mapping, can be used on future by drivers.
> Contain a factory-programmed values for a various peripheral.
> U-Boot already use "CPU-ID" OTP value ("otp_id" on this patch).
> All values from original Rockchip sources tree on github.

Please do not blindly copy values from vendor tree, they do not always
match what is expected for mainline Linux.

There is also a series that adds the required dt-bindings and driver
support for OTP on RK3566, RK3568 and RK3562 pending at [1]. The
dt-bindings for rockchip,rk3568-otp is required before we can add any
otp node to the device tree.

Also we should place any nvmem cells inside a nvmem-layout node.

[1] https://lore.kernel.org/all/20250415103203.82972-1-kever.yang@rock-chips.com/

Regards,
Jonas

> 
> Signed-off-by: Andrey Leonchikov <andreil499@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> index fd2214b6fad4..74523efa8ecf 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> @@ -1057,6 +1057,111 @@ rng: rng@fe388000 {
>  		status = "disabled";
>  	};
>  
> +	otp_ns: otp@fe38c000 {
> +		compatible = "rockchip,rk3568-otp";
> +		reg = <0x00 0xfe38c000 0x00 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		clocks = <&cru CLK_OTPC_NS_USR>,
> +			<&cru CLK_OTPC_NS_SBPI>,
> +			<&cru PCLK_OTPC_NS>,
> +			<&cru PCLK_OTPPHY>;
> +		clock-names = "usr", "sbpi", "apb", "phy";
> +		resets = <&cru SRST_OTPPHY>;
> +		reset-names = "otp_phy";
> +
> +		cpu_code: cpu-code@2 {
> +			reg = <0x02 0x02>;
> +		};
> +
> +		specification_serial_number: specification-serial-number@7 {
> +			reg = <0x07 0x01>;
> +			bits = <0x00 0x05>;
> +		};
> +
> +		otp_cpu_version: cpu-version@8 {
> +			reg = <0x08 0x01>;
> +			bits = <0x03 0x03>;
> +		};
> +
> +		mbist_vmin: mbist-vmin@9 {
> +			reg = <0x09 0x01>;
> +			bits = <0x00 0x04>;
> +		};
> +
> +		otp_id: id@a {
> +			reg = <0x0a 0x10>;
> +		};
> +
> +		cpu_leakage: cpu-leakage@1a {
> +			reg = <0x1a 0x01>;
> +		};
> +
> +		log_leakage: log-leakage@1b {
> +			reg = <0x1b 0x01>;
> +		};
> +
> +		npu_leakage: npu-leakage@1c {
> +			reg = <0x1c 0x01>;
> +		};
> +
> +		gpu_leakage: gpu-leakage@1d {
> +			reg = <0x1d 0x01>;
> +		};
> +
> +		core_pvtm: core-pvtm@2a {
> +			reg = <0x2a 0x02>;
> +		};
> +
> +		cpu_tsadc_trim_l: cpu-tsadc-trim-l@2e {
> +			reg = <0x2e 0x01>;
> +		};
> +
> +		cpu_tsadc_trim_h: cpu-tsadc-trim-h@2f {
> +			reg = <0x2f 0x01>;
> +			bits = <0x00 0x04>;
> +		};
> +
> +		gpu_tsadc_trim_l: npu-tsadc-trim-l@30 {
> +			reg = <0x30 0x01>;
> +		};
> +
> +		gpu_tsadc_trim_h: npu-tsadc-trim-h@31 {
> +			reg = <0x31 0x01>;
> +			bits = <0x00 0x04>;
> +		};
> +
> +		tsadc_trim_base_frac: tsadc-trim-base-frac@31 {
> +			reg = <0x31 0x01>;
> +			bits = <0x04 0x04>;
> +		};
> +
> +		tsadc_trim_base: tsadc-trim-base@32 {
> +			reg = <0x32 0x01>;
> +		};
> +
> +		cpu_opp_info: cpu-opp-info@36 {
> +			reg = <0x36 0x06>;
> +		};
> +
> +		gpu_opp_info: gpu-opp-info@3c {
> +			reg = <0x3c 0x06>;
> +		};
> +
> +		npu_opp_info: npu-opp-info@42 {
> +			reg = <0x42 0x06>;
> +		};
> +
> +		dmc_opp_info: dmc-opp-info@48 {
> +			reg = <0x48 0x06>;
> +		};
> +
> +		remark_spec_serial_number: remark-spec-serial-number@56 {
> +			reg = <0x56 1>;
> +			bits = <0 5>;
> +		};
> +	};
> +
>  	i2s0_8ch: i2s@fe400000 {
>  		compatible = "rockchip,rk3568-i2s-tdm";
>  		reg = <0x0 0xfe400000 0x0 0x1000>;


