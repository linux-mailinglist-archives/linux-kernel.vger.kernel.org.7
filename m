Return-Path: <linux-kernel+bounces-728164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0A6B0240D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BB554731F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAEB1D7E41;
	Fri, 11 Jul 2025 18:45:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD22E13B590;
	Fri, 11 Jul 2025 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259531; cv=none; b=mIMG4+v22X/1b0CqunYUyU3k+29P3e3+s5vU1yrlhHwEkW1vNhdO0E4RaAuEM7DNlGCSA3+O1gfKzjFcASMoyXg1LL3Vx9JNkIOKXFBsde+NlozEGM4FQaRi4kBHYXlBLVs6QOgdeZ0ara4dWQT3dq/4mVKVmgqq87cLTbm3H7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259531; c=relaxed/simple;
	bh=TXAh5cyeJbfSOXxY8gFolHNGXXjw3jndn5t9U7NmQ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7AAQmHsCtULnnvp1dyHStQW/PJap23dn1vQGaFwdyhRD4K8VPMBlVBlmdoRI3/MP8lFH1pmLDK0XO+tdD7k4qb0Q1pFNQH/YbjQOkf8H1rlHuggDppd0FVEXtJR/gxv54vzunEBnObTZPgYUKainIG2WLJc6F7JvfrZRH3xiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BFCA16F8;
	Fri, 11 Jul 2025 11:45:18 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 037533F694;
	Fri, 11 Jul 2025 11:45:26 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:43:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: iuncuim <iuncuim@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.or>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: a523: enable Mali GPU for
 all boards
Message-ID: <20250711194338.52532eca@minigeek.lan>
In-Reply-To: <20250711035730.17507-4-iuncuim@gmail.com>
References: <20250711035730.17507-1-iuncuim@gmail.com>
	<20250711035730.17507-4-iuncuim@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 11:57:29 +0800
iuncuim <iuncuim@gmail.com> wrote:

> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> All devices based on the A523/A527/H728/T527 processors contain a G57 MC1 GPU.
> 
> Enable the DT nodes for this GPU and specify a regulator that supplies power
> to the SoC's VDD_GPU pins. The other parameters are set in the SoC dtsi,
> so are board independent.

Checked the schematics of the three boards where those are available,
and it's indeed DCDC2 there providing the voltage. For the X96QPro+,
regulators.txt in debugs confirms this as well.

> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts   | 5 +++++
>  arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts    | 5 +++++
>  arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts   | 5 +++++
>  arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts | 5 +++++
>  4 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> index 8bc0f2c72..553ad774e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
> @@ -66,6 +66,11 @@ &gmac0 {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	mali-supply = <&reg_dcdc2>;
> +	status = "okay";
> +};
> +
>  &mdio0 {
>  	ext_rgmii_phy: ethernet-phy@1 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
> index 59db10354..a96927fbd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
> @@ -54,6 +54,11 @@ &ehci1 {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	mali-supply = <&reg_dcdc2>;
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	vmmc-supply = <&reg_vcc3v3>;
>  	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> index 142177c1f..b9eeb6753 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> @@ -76,6 +76,11 @@ &gmac0 {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	mali-supply = <&reg_dcdc2>;
> +	status = "okay";
> +};
> +
>  &mdio0 {
>  	ext_rgmii_phy: ethernet-phy@1 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> index 5f97505ec..d07bb9193 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> @@ -95,6 +95,11 @@ &ehci1 {
>  	status = "okay";
>  };
>  
> +&gpu {
> +	mali-supply = <&reg_dcdc2>;
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	vmmc-supply = <&reg_cldo3>;
>  	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */


