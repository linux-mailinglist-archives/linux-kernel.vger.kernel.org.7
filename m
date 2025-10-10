Return-Path: <linux-kernel+bounces-848365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F61CBCD8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B898355CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A252F60CD;
	Fri, 10 Oct 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuM9idKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29EB2F3C0C;
	Fri, 10 Oct 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106899; cv=none; b=TIqF62mWE4Q4nQBUUXLXO5PYNP6Gwd8+avnnMaoz3wc02GqsLWKDkVC1Rd+jbJ+HtPT1WsjfK7lndf87CiQqAzJBWYN0fbvlt4WuocrcAtFRc9JZ3Y2cyKVXvONXvtwNbuop/lQJ21pgG39yTu1ieT/BtpQaeFSpW8NL3b3ukzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106899; c=relaxed/simple;
	bh=tX2MX2Rqu4g/qCApJ10pxKsv/9FWn2QhZo8crhSgRyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAiyvyK8DSx/F2XrBBdmrJ9apxzrJ4qiwOWBJAmpKkh+TP3uvCjlwgy/oKefW9P3FykNuQMm/d7w9WC9bv6UTpLlUk/oHIBYRPe1b1fZED+Z2s0tVcE6npR744NaYj0m7clRSBVP03UjDFIj/ex1L+xk6ul0dYsv1J6uKq+n1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuM9idKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E593C4CEFE;
	Fri, 10 Oct 2025 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760106898;
	bh=tX2MX2Rqu4g/qCApJ10pxKsv/9FWn2QhZo8crhSgRyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZuM9idKyJ64Ns5XMFl5Nf1Vv7BWmSTuM0nOT1vs2jlozQ0nnbqG2FhNGe5ZvUyWkU
	 cagctN2vf50FllgByHsqBwRz6pX68f5fZTw3X1ucoLdNlRbq5TmW2EbWI00snUX5/x
	 YDtXzGGR+VBBSx0ITdgMtS1QGTbsUfvd21V7fai6qKRtvccTqvN+3I7ZIsex5dNU5i
	 T136wKWYHqi3wYGGfPrfzhqqGbcnE8fvKqQG/uTiBTX7GYieJk8xxJB/9QJGhrf0/v
	 ZOmcf25iSjh8pZKXS2ZIJUTOUQ9C4n66wliKl8SCKEcNRd42BfKp+U/ID3lVfjA9nv
	 zqvWdC1wCmzxg==
Date: Fri, 10 Oct 2025 15:34:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: riscv: spacemit: add MusePi Pro board
Message-ID: <20251010-headstand-gloomy-c7d702f978a9@spud>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
 <20251010-k1-musepi-pro-dts-v2-1-6e1b491f6f3e@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h8lD4lIYVpPgecKX"
Content-Disposition: inline
In-Reply-To: <20251010-k1-musepi-pro-dts-v2-1-6e1b491f6f3e@linux.spacemit.com>


--h8lD4lIYVpPgecKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 09:56:30AM +0800, Troy Mitchell wrote:
> Document the compatible string for the MusePi Pro [1]. It is a 1.8-inch
> single board computer based on the SpacemiT K1/M1 RISC-V SoC [2].
>=20
> Here's a refined list of its core features for consideration:
>   - SoC: SpacemiT M1/K1, 8-core 64-bit RISC-V with 2.0 TOPS AI power.
>          This suggests potential for light AI/ML workloads on-device.
>   - Memory: LPDDR4X @ 2400MT/s, available in 8GB & 16GB options.
>             Sufficient for various workloads.
>   - Storage: Onboard eMMC 5.1 (64GB/128GB options). M.2 M-Key for NVMe
>              SSD (2230 size), and a microSD slot (UHS-II) for expansion.
>              Good variety for boot and data.
>   - Display: HDMI 1.4 (1080P@60Hz) and 2-lane MIPI DSI FPC (1080P@60Hz).
>              Standard display options.
>   - Connectivity: Onboard Wi-Fi 6 & Bluetooth 5.2. A single Gigabit
>                   Ethernet port (RJ45). Given the stated markets,
>                   this should cover basic networking.
>   - USB: 4x USB 3.0 Type-A (host) and 1x USB 2.0 Type-C (device/OTG).
>          Decent host capabilities.
>   - Expansion: Full-size miniPCIe slot for assorted modules
>                (4G/5G, wireless etc.). A second M.2 M-Key (2230) for more
>                general PCIe devices (SSD, PCIe-to-SATA, comm boards).
>   - GPIO: Standard 40-pin GPIO interface, as expected for an SBC.
>   - MIPI: Includes 1x 4-lane MIPI CSI FPC and 2x MIPI DSI FPC interfaces
>           for cameras and displays.
>   - Clock: Onboard RTC with battery support.
>=20
> Link: https://developer.spacemit.com/documentation?token=3DYJtdwnvvViPVcm=
koPDpcvwfVnrh&type=3Dpdf [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
>=20
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

pw-bot: not-applicable

> ---
> Changelog in v2:
> - modify commit message
> - Link to v1: https://lore.kernel.org/all/20250928-k1-musepi-pro-dts-v1-1=
-5efcca0ce3ae@linux.spacemit.com/
> ---
>  Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Docu=
mentation/devicetree/bindings/riscv/spacemit.yaml
> index c56b62a6299ac24d3cdef7edcdfc407dc62a1846..52fe39296031f21d1c28c4f1e=
a5ca9fe28caf45a 100644
> --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> @@ -22,6 +22,7 @@ properties:
>            - enum:
>                - bananapi,bpi-f3
>                - milkv,jupiter
> +              - spacemit,musepi-pro
>                - xunlong,orangepi-rv2
>            - const: spacemit,k1
> =20
>=20
> --=20
> 2.51.0
>=20
>=20

--h8lD4lIYVpPgecKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOkZjgAKCRB4tDGHoIJi
0lJbAQCI1n2tmq/PHDkU8WxwsDfOyXgh61XIyz27ArEkr9KRzgD/aJWVigJcDUU+
bgAkMJ90tRNk6VJx28B6jm/5O7BqeQo=
=rlWN
-----END PGP SIGNATURE-----

--h8lD4lIYVpPgecKX--

