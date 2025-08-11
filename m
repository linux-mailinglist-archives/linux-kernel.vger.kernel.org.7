Return-Path: <linux-kernel+bounces-761730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2EB1FDCC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8967AB661
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C73594F;
	Mon, 11 Aug 2025 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Ue3W1p/0"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD262566F5;
	Mon, 11 Aug 2025 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754879026; cv=none; b=R+oU4WmS+lEhWD93dgQEL+pKYfaKhnj3YcvVqTK7RcmOxPad3rfWN+K9kNUkES4xpzwv/9Rl5gJ4txOzTojAo+Jf4St1lVc38wjr6GTMmgMWiIeETIecvBeK1GtHSHtNRyNztbalCyk2/CtM6LyWUmH3ocqCRtUkCpZ24RmfpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754879026; c=relaxed/simple;
	bh=vKwdokCSbfarr3tfiBIQ+v8PuIYAWoLWZBdsuWHTjX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjLKXCUIn4yLSkBi309+nwIULe9L/JdGLoLH07TzbCGVldx+t9DnkU9mSjUwjHfdsCvRODk26UqjvhF74OOIrD+kyPTnXDEkA/EtpRONXq2eUYVAbDeDosK5aQQQkSqizncraIAsosLIcMUkdvZ1ESiOCrHMCjtBbsPk3nL7C9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Ue3W1p/0; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id ABE3D2599D;
	Mon, 11 Aug 2025 04:23:34 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JdiyJLpcUReS; Mon, 11 Aug 2025 04:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754879014; bh=vKwdokCSbfarr3tfiBIQ+v8PuIYAWoLWZBdsuWHTjX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ue3W1p/0pXOBeNfkPwdtHjYymOU+XmuRgfcVr/kEmzNY9uYvjLpBkoWLmrYNehL8u
	 C2xey/68hv5zZCRvqPya6MwxSJ2qCQSrRbpcANklFrS6KSk/bSiecCc1eb3GrS2fNL
	 vEATL2MyhuptYyHpIBQB5kayIsU0+pvKd7b6WhUpzQlu0zYoGDTXIxKn5DzgkT0jxq
	 fbLmYYwxKGUCLX6X1vJXHWZQMN8DPXvNwK8bz9K8NpsxwPl+8QC9Q+76wCoUYqe4uv
	 f6U2hglawgZn0mkLxRJcTcGOTS66gDsmHUhg/C+TghkKXK1btEXZiQeo0E0e/OsxTY
	 M/VBEsJDPb1eg==
Date: Mon, 11 Aug 2025 02:23:14 +0000
From: Yao Zi <ziyao@disroot.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH] reset: thead: Scope TH1520 reset driver to VO subsystem
Message-ID: <aJlUErajSRZJexYa@pie>
References: <CGME20250810211419eucas1p173e5fefcfaae437d8b5531d1406ff6a6@eucas1p1.samsung.com>
 <20250810-fix_reset_2-v1-1-b0d1900ba578@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-fix_reset_2-v1-1-b0d1900ba578@samsung.com>

On Sun, Aug 10, 2025 at 11:14:19PM +0200, Michal Wilczynski wrote:
> The reset controller driver for the TH1520 was using the generic
> compatible string "thead,th1520-reset". However, the current
> implementation only manages the resets for the Video Output (VO)
> subsystem.
> 
> Using a generic compatible is incorrect as it implies control over all
> reset units on the SoC. This could lead to conflicts if support for
> other reset controllers on the TH1520 is added in the future like AP.
> 
> To ensure correctness and prevent future issues, this patch renames the
> compatible string to "thead,th1520-reset-vo". The device tree bindings,
> the th1520.dtsi file, and the driver itself are updated to use this new,
> more specific compatible. The device tree node label is also renamed
> from 'rst' to 'rst_vo' for clarity.
> 
> Fixes: 30e7573babdc ("dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller")
> Reported-by: Icenowy Zheng <uwu@icenowy.me>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml | 6 +++---
>  arch/riscv/boot/dts/thead/th1520.dtsi                           | 6 +++---
>  drivers/reset/reset-th1520.c                                    | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> index f2e91d0add7a60e12973c216bb5a989857c3c47c..f84c5ae8bc3569cb1d4e8f07999888ea26e175d0 100644
> --- a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> @@ -16,7 +16,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> -      - thead,th1520-reset
> +      - thead,th1520-reset-vo

I think we should mark thead,th1520-reset as deprecated instead of
removing it completely, to demonstrate the ABI problem and make the
situation clear.

>    reg:
>      maxItems: 1
> @@ -36,8 +36,8 @@ examples:
>      soc {
>        #address-cells = <2>;
>        #size-cells = <2>;
> -      rst: reset-controller@ffef528000 {
> -        compatible = "thead,th1520-reset";
> +      rst_vo: reset-controller@ffef528000 {
> +        compatible = "thead,th1520-reset-vo";
>          reg = <0xff 0xef528000 0x0 0x1000>;
>          #reset-cells = <1>;
>        };
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 42724bf7e90e08fac326c464d0f080e3bd2cd59b..9cc2f1adf489ac432b2f3fbb06b655490d9e14b3 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -235,7 +235,7 @@ aon: aon {
>  		compatible = "thead,th1520-aon";
>  		mboxes = <&mbox_910t 1>;
>  		mbox-names = "aon";
> -		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
> +		resets = <&rst_vo TH1520_RESET_ID_GPU_CLKGEN>;
>  		reset-names = "gpu-clkgen";
>  		#power-domain-cells = <1>;
>  	};
> @@ -500,8 +500,8 @@ clk: clock-controller@ffef010000 {
>  			#clock-cells = <1>;
>  		};
>  
> -		rst: reset-controller@ffef528000 {
> -			compatible = "thead,th1520-reset";
> +		rst_vo: reset-controller@ffef528000 {
> +			compatible = "thead,th1520-reset-vo";
>  			reg = <0xff 0xef528000 0x0 0x4f>;
>  			#reset-cells = <1>;
>  		};
> diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
> index 7874f0693e1b427a094a68f2b6d783985e789bf8..05ed11972774618df4512b7c9f9f12e71455e48b 100644
> --- a/drivers/reset/reset-th1520.c
> +++ b/drivers/reset/reset-th1520.c
> @@ -116,7 +116,7 @@ static int th1520_reset_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id th1520_reset_match[] = {
> -	{ .compatible = "thead,th1520-reset" },
> +	{ .compatible = "thead,th1520-reset-vo" },

And this change actually breaks compatibility with older devicetrees.
thead,th1520-reset has been part of the ABI, and we should keep the
compatible string to maintain the compatibility.

With these two changes, I think the changes could be seperated into
different patches, one for the dt-binding, one for the driver, and one
for the devicetree, which could make their scope more clear.

Thanks,
Yao Zi

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, th1520_reset_match);
> 
> ---
> base-commit: 561c80369df0733ba0574882a1635287b20f9de2
> change-id: 20250810-fix_reset_2-a618d7426534
> 
> Best regards,
> -- 
> Michal Wilczynski <m.wilczynski@samsung.com>
> 

