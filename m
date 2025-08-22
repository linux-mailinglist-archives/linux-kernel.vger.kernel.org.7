Return-Path: <linux-kernel+bounces-782738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32789B3249C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B0962742F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B7127780C;
	Fri, 22 Aug 2025 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHol3RJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777A1531C8;
	Fri, 22 Aug 2025 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898348; cv=none; b=SFIAChaC+TDcvjkp/H1eZy6kY5AwFhawjwmuraFfHzEFurcd/v63w+Ie6zml8E/danlQIjsXgPvyqM3Vgpwc+K9H+J/+b4PYvoTKpON1UFIcLDFF4rTgb36oqDkOIxs4rf+DCiQT6mmYv5+BhpqLThk8crUSub3vi3MNJu3VOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898348; c=relaxed/simple;
	bh=LeSrXwZaADMtK37404XLtISL1PIAJ7ce7zI3rX1/TPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw7TwjCKoXd73FiQ+DaU+kElkXdkU5qdzd9bZhPKwHE5VHX09HkHhUvbDeizVe4gijGWf1oMtlqVayux4VFa2csi6SrlyZIv0xBIaH7alIYtDzMQo4Ig7Tl8oECn0lKEgNwaplCxIruR2dWch/i35FJL24FVNc3I56ngjLcWMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHol3RJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE28C4CEF1;
	Fri, 22 Aug 2025 21:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755898347;
	bh=LeSrXwZaADMtK37404XLtISL1PIAJ7ce7zI3rX1/TPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHol3RJ6EquQtHwVZq0nrk9+hlq6+jOft1pTk2RVAdHdRTwrOkIO+IUQrqf/pmJEg
	 1n6NQ/MtXiQokBc0Kjf24UdDebYVZLvqb9crhaX0mGRT2kUI3b1xzndF5+8WbuE14D
	 bSPzdOrt3VXitdVkEQuWJhmrRDZZ7v/lnmvHiCHwsl1mGYn+ErmXH4WpY8B9E/bUuC
	 bWKPe8NO+B9jAQ7VOYjJJuFmahxov/1InwJgVTFyS1SAcYejIbIuMZ18tAgFQ/6dL4
	 1voe4twkuiDZcxhQdjlAlD4f2b3Z0JlkDQsbgLRgVXIEd8Exzj4uFfPbTzoZXr6RGk
	 XcLRLj4oeM7bw==
Date: Fri, 22 Aug 2025 14:32:26 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: dts: thead: th1520: add soft PWM fan for
 Lichee Pi 4A
Message-ID: <aKjh6hrhrRqUvnSd@x1>
References: <20250816093209.2600355-1-uwu@icenowy.me>
 <20250816093209.2600355-4-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816093209.2600355-4-uwu@icenowy.me>

On Sat, Aug 16, 2025 at 05:32:09PM +0800, Icenowy Zheng wrote:
> Because of the SoM+Dock design of Lichee Pi 4A, heat dissipation does
> not work well; fortunately it comes with a fan port with PWM driving
> capability.
> 
> As the hardware PWM controller of Lichee Pi 4A isn't ready yet, drive it
> with pwm-gpio driver (software PWM) now.
> 
> A long PWM period is used, because not only software PWM is used, but
> also the fan port is a 2-pin one and fast PWM might confuse the BLDC
> driver on fans.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 53 +++++++++++++++++++
>  arch/riscv/boot/dts/thead/th1520.dtsi         |  2 +-
>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> index 4020c727f09e8..f696db01353c5 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> @@ -4,6 +4,7 @@
>   */
>  
>  #include "th1520-lichee-module-4a.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "Sipeed Lichee Pi 4A";
> @@ -28,6 +29,58 @@ aliases {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	gpio_pwm: gpio-pwm {
> +		#pwm-cells = <3>;
> +		compatible = "pwm-gpio";
> +		gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
> +	};

I think the node name needs to be 'pwm' instead of 'gpio-pwm' as dtbs_check
warns that:

gpio-pwm: $nodename:0: 'gpio-pwm' does not match '^pwm(@.*|-([0-9]|[1-9][0-9]+))?$'
from schema $id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#

Thanks,
Drew

