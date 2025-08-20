Return-Path: <linux-kernel+bounces-778657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A68B2E892
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C33A24D90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA52DCC17;
	Wed, 20 Aug 2025 23:19:24 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5D280312;
	Wed, 20 Aug 2025 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731964; cv=none; b=qDg8HVCLFAkuwL+NPZXLTiKRha0ajKS1nxwJ4WQgjAbQN8F3w+DNOu7jF9vC3kYBKrVl9OiQVO2NExtHzvaTO3iOUcXHwym4q9dg581PzzHc0eoujA/UzMhNqSr0m/PaWH6ajDSjCerObv8qULUYRLVE0tofsRHgvr6BrRvx3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731964; c=relaxed/simple;
	bh=OPrm5w5AdkT61ri9wEdzjMx15VSmDR3Jtu0GD6sZi5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQAUooMdFZjwgj0T3jQNuaQfegk8euwHHuAKFQMHXwD0Qm/sutyaClRIppAlILNXFsv3uqrIq2++c0EHGyPdI8HrrTKmsTOdMtziBRDppAOTVJ8nTjCmpYvURc8IPyvBPjP0CATuGazVSOstppZfNcNAB1kk9zCWZnuVisVM4nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D8A5D340E0E;
	Wed, 20 Aug 2025 23:19:21 +0000 (UTC)
Date: Thu, 21 Aug 2025 07:19:17 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: spacemit: add UART resets for Soc K1
Message-ID: <20250820231917-GYB1065530@gentoo>
References: <20250807191817.157494-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807191817.157494-1-hendrik.hamerlinck@hammernet.be>

Hi Hendrik, 

On 21:18 Thu 07 Aug     , Hendrik Hamerlinck wrote:
> Add reset control entries for all UARTs in the SpaceMIT K1 SoC Device Tree.
> UART0 was functional as it did not need a reset. But the other UARTs were
> unable to access their registers without the reset being applied.
> 
..
> Although perhaps not needed I did add the reset for UART0 as well,
> to ensure consistency across all UARTs. With the current-speed set to
> 112500 baud rate, it matches the factory U-Boot settings.
> This should not give issues with early console usage. But perhaps it could
> be a good idea to let somebody else confirm this as well.
> 
Adding reset to UART0 is just fine, so we don't need to presume it will
rely on bootloader to de-assert the controller

please write changelogs in imperative mood, you can follow
https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> Tested this locally on both Orange Pi RV2 and Banana Pi BPI-F3 boards. 
> I enabled the UART9 and was able to use it successfully.
> 
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index abde8bb07c95..7a5196a98085 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -667,6 +667,8 @@ uart0: serial@d4017000 {
>  				clocks = <&syscon_apbc CLK_UART0>,
>  					 <&syscon_apbc CLK_UART0_BUS>;
>  				clock-names = "core", "bus";
..
> +				current-speed = <115200>;
please drop this property, dtsi file should contain generic info for SoC,
even in real cases, all boards use UART0 as serial output and configured
at baudrate 115200, it still be able to alter to different frequency..

besides, if you really want to set baudrate, then I'd suggest to configure
it at board specific dts file, 
  stdout-path = "serial0:115200n8";

> +				resets = <&syscon_apbc RESET_UART0>;
>  				interrupts = <42>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -680,6 +682,7 @@ uart2: serial@d4017100 {
>  				clocks = <&syscon_apbc CLK_UART2>,
>  					 <&syscon_apbc CLK_UART2_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART2>;
>  				interrupts = <44>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -693,6 +696,7 @@ uart3: serial@d4017200 {
>  				clocks = <&syscon_apbc CLK_UART3>,
>  					 <&syscon_apbc CLK_UART3_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART3>;
>  				interrupts = <45>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -706,6 +710,7 @@ uart4: serial@d4017300 {
>  				clocks = <&syscon_apbc CLK_UART4>,
>  					 <&syscon_apbc CLK_UART4_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART4>;
>  				interrupts = <46>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -719,6 +724,7 @@ uart5: serial@d4017400 {
>  				clocks = <&syscon_apbc CLK_UART5>,
>  					 <&syscon_apbc CLK_UART5_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART5>;
>  				interrupts = <47>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -732,6 +738,7 @@ uart6: serial@d4017500 {
>  				clocks = <&syscon_apbc CLK_UART6>,
>  					 <&syscon_apbc CLK_UART6_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART6>;
>  				interrupts = <48>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -745,6 +752,7 @@ uart7: serial@d4017600 {
>  				clocks = <&syscon_apbc CLK_UART7>,
>  					 <&syscon_apbc CLK_UART7_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART7>;
>  				interrupts = <49>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -758,6 +766,7 @@ uart8: serial@d4017700 {
>  				clocks = <&syscon_apbc CLK_UART8>,
>  					 <&syscon_apbc CLK_UART8_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART8>;
>  				interrupts = <50>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -771,6 +780,7 @@ uart9: serial@d4017800 {
>  				clocks = <&syscon_apbc CLK_UART9>,
>  					 <&syscon_apbc CLK_UART9_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART9>;
>  				interrupts = <51>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)

