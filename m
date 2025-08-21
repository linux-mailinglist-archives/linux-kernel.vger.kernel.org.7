Return-Path: <linux-kernel+bounces-779018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9530B2EDF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E4B5C3425
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E82D47EE;
	Thu, 21 Aug 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="zONGa+v4"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FC4A32;
	Thu, 21 Aug 2025 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756793; cv=none; b=JTiveXfymz2C5VwI+xwqh5JKoL/1a6zBMKiwZotwyTQe6Jmm+pQ89J1OzZO1moCQjg1/3vDcs0BkibA+DLRm5u62sG2CXJ7s/b69qgWwXHLfozv6RE5UxUtaCrsBhEoo2+TwO6u1ALzNHvkI7/KW/geA6IcT36EUOZGhgEV20T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756793; c=relaxed/simple;
	bh=5Rd1KLtf8zQOsf+WxURU9WHlomXnffj+uLZyprYQBiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxMm8DGrdpe1HD8peQxs2clRoCOS1my2VL7jJnnVPOBMhZLLyHIOpNjip/89DHeG+IRMDqCMpH+RRSslwBQFoBWVr36z3sHjBEo4+XR/bI0y33UOsgHUL/y7XbKRX32fKX9WRVdlaidN2MJW1L7NiimDHFDD0IRFZs2ekfFKoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=zONGa+v4; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CA76C1F928;
	Thu, 21 Aug 2025 08:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1755756208;
	bh=FrScFWxwUweYwsRmH5bskazblTnrXR09gx4xHuFB8Kg=; h=From:To:Subject;
	b=zONGa+v4bwGNv4NkMlLXJBcl+T66Aubn6+uZeZqZRxlK6EgqdY9fErRukWmC0wcPt
	 pn+NE89+6dK+apL5q0hIvkumyummyYKvGo+21g+mKTaGmaVZcabaqZCg43Q/6fnbcd
	 QW/kncFmMvnikr+nvoWPZYcleJNZ36/AhUhEcGq8/2p+Y7wtNc9ujO35A0Uy3ZaTcm
	 pE3kSJCiUk+54u+aHTd813thKqqoG3Mud2to++HEWJM4axNNQkqSejgqDNRlXa3fY7
	 KR7xNojpleTwPv/DH5HtYZ8BIuAl1PSQ3o4AKlzatsaRjzSLfzyqjmmrwUPADRDzp6
	 xFoJWqyMOhsMw==
Date: Thu, 21 Aug 2025 08:03:24 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com,
	u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 20/33] arm64: dts: ti: k3-am62: Enable Mailbox nodes at
 the board level
Message-ID: <20250821060324.GA7503@francesco-nb>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-21-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814223839.3256046-21-b-padhi@ti.com>

On Fri, Aug 15, 2025 at 04:08:26AM +0530, Beleswar Padhi wrote:
> Mailbox nodes defined in the top-level AM62x SoC dtsi files are
> incomplete and may not be functional unless they are extended with a
> chosen interrupt and connection to a remote processor.
> 
> As the remote processors depend on memory nodes which are only known at
> the board integration level, these nodes should only be enabled when
> provided with the above information.
> 
> Disable the Mailbox nodes in the dtsi files and only enable the ones
> that are actually used on a given board.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi         | 1 +
>  arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts | 1 +
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi       | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 029380dc1a35..40fb3c9e674c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -808,6 +808,7 @@ mailbox0_cluster0: mailbox@29000000 {
>  		#mbox-cells = <1>;
>  		ti,mbox-num-users = <4>;
>  		ti,mbox-num-fifos = <16>;
> +		status = "disabled";
>  	};
>  
>  	ecap0: pwm@23100000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> index df2e1b0e74a1..2140e0cdec85 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> @@ -299,6 +299,7 @@ &epwm2 {
>  };
>  
>  &mailbox0_cluster0 {
> +	status = "okay";

add new line

>  	mbox_m4_0: mbox-m4-0 {
>  		ti,mbox-rx = <0 0 0>;
>  		ti,mbox-tx = <1 0 0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> index fba6f5c8d099..1c44d17281dd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -1335,6 +1335,7 @@ &main_i2c3 {
>  };
>  
>  &mailbox0_cluster0 {
> +	status = "okay";

add new line

>  	mbox_m4_0: mbox-m4-0 {
>  		ti,mbox-rx = <0 0 0>;
>  		ti,mbox-tx = <1 0 0>;
> -- 
> 2.34.1
> 

