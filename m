Return-Path: <linux-kernel+bounces-780747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F843B308E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE041897C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5812EA165;
	Thu, 21 Aug 2025 22:04:37 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C6C2E88B2;
	Thu, 21 Aug 2025 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813877; cv=none; b=CDfsXXS6314n9FBY+/0lWmwvR7XFyVs8KHkzoDJoRlssJMCBsAlAnETpOy6YHWViNMzh0oe13/QmM9V+P4PaRlzbn32nqou4kFXwYl8Aq5gwWlwPg+afAhwThKJIHYDmA3E4cAQ+i4CE1UD2hE2jBySGCBnuV5ZMTupZXuDH8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813877; c=relaxed/simple;
	bh=hxkcY5eXcU0/SP9gOE+pjfJcCyy7BDyDchffTZglGEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly2IsZPH/S9Ij1ICyJCjAUvHwUHY/ALIwklP++UB5K/rtB4QmFXNmASv6q5FgSLcGhkTiYDG8f53gyeV0mpNI136gR9qo0Yq0eqthBMQkd6FThNasONYQeyMXS8loDBrQem9Ry93zJ+11WEZ3GlTP3wCoxNPwS2QtwdOk4ehNq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AD411340441;
	Thu, 21 Aug 2025 22:04:34 +0000 (UTC)
Date: Fri, 22 Aug 2025 06:04:30 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: spacemit: add UART resets for Soc K1
Message-ID: <20250821220430-GYA1070455@gentoo>
References: <20250821152619.597051-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821152619.597051-1-hendrik.hamerlinck@hammernet.be>

On 17:26 Thu 21 Aug     , Hendrik Hamerlinck wrote:
> The UARTs in the SpacemiT K1 device tree are probed by the 8250_of driver,
> but without reset lines they remain non-functional.
> 
> Add reset control entries so that the UARTs can operate when mapped to
> devices. UART0 is already de-asserted by the bootloader, but include its
> reset as well to avoid relying on bootloader state.
> 
> Tested on Orange Pi RV2 and Banana Pi BPI-F3 boards, with UART9 enabled
> and verified functional.
> 
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>

Reviewed-by: Yixun Lan <dlan@gentoo.org>
> ---
> Changes in v2:
> - Improved changelog
> - Omitted current-speed property for UART0
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index abde8bb07c95..6c68b2e54675 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -667,6 +667,7 @@ uart0: serial@d4017000 {
>  				clocks = <&syscon_apbc CLK_UART0>,
>  					 <&syscon_apbc CLK_UART0_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART0>;
>  				interrupts = <42>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -680,6 +681,7 @@ uart2: serial@d4017100 {
>  				clocks = <&syscon_apbc CLK_UART2>,
>  					 <&syscon_apbc CLK_UART2_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART2>;
>  				interrupts = <44>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -693,6 +695,7 @@ uart3: serial@d4017200 {
>  				clocks = <&syscon_apbc CLK_UART3>,
>  					 <&syscon_apbc CLK_UART3_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART3>;
>  				interrupts = <45>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -706,6 +709,7 @@ uart4: serial@d4017300 {
>  				clocks = <&syscon_apbc CLK_UART4>,
>  					 <&syscon_apbc CLK_UART4_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART4>;
>  				interrupts = <46>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -719,6 +723,7 @@ uart5: serial@d4017400 {
>  				clocks = <&syscon_apbc CLK_UART5>,
>  					 <&syscon_apbc CLK_UART5_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART5>;
>  				interrupts = <47>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -732,6 +737,7 @@ uart6: serial@d4017500 {
>  				clocks = <&syscon_apbc CLK_UART6>,
>  					 <&syscon_apbc CLK_UART6_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART6>;
>  				interrupts = <48>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -745,6 +751,7 @@ uart7: serial@d4017600 {
>  				clocks = <&syscon_apbc CLK_UART7>,
>  					 <&syscon_apbc CLK_UART7_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART7>;
>  				interrupts = <49>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -758,6 +765,7 @@ uart8: serial@d4017700 {
>  				clocks = <&syscon_apbc CLK_UART8>,
>  					 <&syscon_apbc CLK_UART8_BUS>;
>  				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_UART8>;
>  				interrupts = <50>;
>  				reg-shift = <2>;
>  				reg-io-width = <4>;
> @@ -771,6 +779,7 @@ uart9: serial@d4017800 {
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

