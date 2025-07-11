Return-Path: <linux-kernel+bounces-728114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0329B023C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052B71C847D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25A02F3C2A;
	Fri, 11 Jul 2025 18:34:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F82F19A5;
	Fri, 11 Jul 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258844; cv=none; b=WUm4fIIYHrs2FhukDNVLUcXVVuV8M44s/rgBimZcmliUhyl7IhtqS/ZyF87d58IR7iOoeDlI2g83S7jN7FqkxTycr6yx2V8KSJjYPaPpfFB5dsuvUljI9VO30K/q8JsdRw85r2bpZD1r89QA+pKX2/I7u/RJqrZ5QOB9ME6M9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258844; c=relaxed/simple;
	bh=kyfMSq/ZOk9KhCVjB6jQ16A833TFAdd4LBdq5IIWH9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHlR4IP6lfMqgBrq/0nvtSsfPyqWyhpBp0bOKVgzUOQB07MydR+1KZI4/aihBzD+3ecyKIJFKSpUqCE2CPkK+LB3jraXbkqCf0iBp/MGuYhMDDvV6txuEPAl84+OnJdc7tyDbjbfzDJs1XlBEK41PXN2qnqXcB2zJNE3LzM0cZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C48616F8;
	Fri, 11 Jul 2025 11:33:50 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7F7D3F694;
	Fri, 11 Jul 2025 11:33:58 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:32:10 +0100
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
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: a523: add Mali GPU node
Message-ID: <20250711193210.6b7f2875@minigeek.lan>
In-Reply-To: <20250711035730.17507-3-iuncuim@gmail.com>
References: <20250711035730.17507-1-iuncuim@gmail.com>
	<20250711035730.17507-3-iuncuim@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Jul 2025 11:57:28 +0800
iuncuim <iuncuim@gmail.com> wrote:

Hi,

> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>=20
> The Allwinner A523 SoC features the Mali-G57 MC1 GPU, which belongs
> to the Mali Valhall (v9) family. There is a power domain specifically
> for this GPU that needs to be enabled to utilize it.
>=20
> To enable in a specific device, we need to enable the gpu node and specify
> the =E2=80=9Cmali-supply=E2=80=9D regulator additionally in the device tr=
ee.

Checked the resources against the manual:=20

> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index dd6fa22f9..d3528d498 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -108,6 +108,21 @@ soc {
>  		#size-cells =3D <1>;
>  		ranges =3D <0x0 0x0 0x0 0x40000000>;
> =20
> +		gpu: gpu@1800000 {
> +			compatible =3D "allwinner,sun55i-a523-mali",
> +				     "arm,mali-valhall-jm";
> +			reg =3D <0x1800000 0x10000>;
> +			interrupts =3D <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "job", "mmu", "gpu";
> +			clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
> +			clock-names =3D "core", "bus";
> +			power-domains =3D <&pck600 PD_GPU>;
> +			resets =3D <&ccu RST_BUS_GPU>;
> +			status =3D "disabled";
> +		};
> +
>  		pio: pinctrl@2000000 {
>  			compatible =3D "allwinner,sun55i-a523-pinctrl";
>  			reg =3D <0x2000000 0x800>;


