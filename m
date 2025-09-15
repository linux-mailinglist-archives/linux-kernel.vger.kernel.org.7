Return-Path: <linux-kernel+bounces-817461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8641B58282
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE281781A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C92BDC02;
	Mon, 15 Sep 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR2CIY9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01822877F7;
	Mon, 15 Sep 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954835; cv=none; b=oyTUsiHLcx/PkNgfNg3/nlMvIWioQ7+G+vgd7gOanN32IMlZE9mHU8ChiOtxMi9E6dbcJllb29ftFqLVCUTDrh5gS7i6cY2sKnN6dLeNl0C365mdF15rnlgOtDcyX8cxXTpPAeBwyiGPsv9N0/2Zsh9gC25vYImYGJsFg7134DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954835; c=relaxed/simple;
	bh=AYGzSlRsXTSxiB0nCeZZldU8jcbwpn+7WX58ynn8QzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFDg55fezFRtkjU1iI6+qLMx5k7tJ/pYAv3qr7MHBY1XNXLmLx6U4pmY5k1gIizeMd8Xz3qUSfL9dhLJUU39phHKRsW5+J03MbXRev+lg4zcX1/CAOdgmde1RhA39KmxeHKDEedk73vc++BuILrwORzcRKbCXRIY6ZYNCucr+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR2CIY9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278ADC4CEFD;
	Mon, 15 Sep 2025 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954835;
	bh=AYGzSlRsXTSxiB0nCeZZldU8jcbwpn+7WX58ynn8QzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KR2CIY9kKmW1I2C+wNwOfFy1Cimq4ycroixQFv0gnodTaYRtelUrHsaV7Gsfrkvdd
	 TtagClzYFPTy25O34F+AscdKuRvYoQLUjBJehcEoE5o19eDrs+gaP/Mcv70bKkkgRq
	 12z6+y/aMyWoYlES+3K26xQDxN6W8AmwwwE87JnxwXnKVdjM27AZvyh0gKxBakfiSw
	 ZzqUbgT149Wlz6mLCF1GAqE9fVHn1YxzMdDptqK5uhUgRG8W6XXmzINLT4g6yE4faK
	 Q8aGTE7rUyPlWBBC8LLXll6Aw/pKfuVn+LEF2v4+sn5Ne2erVo99NzVTKuSQnnRa99
	 2AoGZhVTIKh7w==
Date: Mon, 15 Sep 2025 17:47:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>,
	Joel Stanley <jms@tenstorrent.com>, Joel Stanley <joel@jms.id.au>,
	Michael Neuling <mikey@neuling.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH 6/7] riscv: dts: Add Tenstorrent Blackhole A0 SoC PCIe
 cards
Message-ID: <20250915-mouth-banner-ddfb2e48bdb3@spud>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-6-ddb0d6860fe5@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iHNPxCzVrL8Nj8IA"
Content-Disposition: inline
In-Reply-To: <20250913-tt-bh-dts-v1-6-ddb0d6860fe5@tenstorrent.com>


--iHNPxCzVrL8Nj8IA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 13, 2025 at 02:31:05PM -0700, Drew Fustini wrote:
> new file mode 100644
> index 0000000000000000000000000000000000000000..b2b08023643a2cebd4f924579024290bb355c9b3
> --- /dev/null
> +++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/dts-v1/;
> +
> +#include "blackhole-a0.dtsi"
> +
> +/ {
> +	model = "Tenstorrent Blackhole A0 SoC PCIe card";
> +	compatible = "tenstorrent,blackhole-a0-card", "tenstorrent,blackhole-a0";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x4000 0x30000000 0x1 0x00000000>;

This isn't at address zero as the node address claims.

> +	};
> +};
> diff --git a/arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi b/arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..517b6442ff0fe61659069e29318ad3f01bc504e2
> --- /dev/null
> +++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright 2025 Tenstorrent AI ULC
> +/dts-v1/;
> +
> +/ {
> +	compatible = "tenstorrent,blackhole-a0";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;
> +		timebase-frequency = <50000000>;
> +
> +		cpu@0 {
> +			compatible = "sifive,x280", "sifive,rocket0", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			mmu-type = "riscv,sv57";

> +			riscv,isa = "rv64imafdcv_zicsr_zifencei_zfh_zba_zbb_sscofpmf";

What's the benefit of retaining this property?

> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicsr",
> +					       "zifencei", "zfh", "zba", "zbb", "sscofpmf";
> +			riscv,cboz-block-size = <0x40>;

cboz block size, but no zicboz in your extensions list?

--iHNPxCzVrL8Nj8IA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhDCAAKCRB4tDGHoIJi
0pMaAP9p1TqTxoGqAjuErcVPuS5xegEUGST8rXU3p5YRl2CUTAEAtTVesw+pKK3+
WxaX6WKQ5s5k4Ny2jsJ6byBiC4PHbQ4=
=+taw
-----END PGP SIGNATURE-----

--iHNPxCzVrL8Nj8IA--

