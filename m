Return-Path: <linux-kernel+bounces-813643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A90B548A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1998C3BCD94
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346AC2DF140;
	Fri, 12 Sep 2025 10:04:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099E2DE70C;
	Fri, 12 Sep 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671480; cv=none; b=Yl02qMpInz1XOw1iDcVPJ85cNSNw3EoYfeXBlj6VDC90EzvhN4dSs5BMhiXibqGPSVdotL07DSvfSfhG37Taee4s/7TrAPPCl1qIG7QCsajcrBOAWZUM7D39LwG51vZULKGSNRx8mP1GEk+Hv4+CgUDhLI0OjMx/Qbp2EGoUhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671480; c=relaxed/simple;
	bh=XElUX9esLbtxbckqyV9wGffWqX28r4dwpXWVkfhm/Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdOuA2xVplET5xn1WSymWVLlxBNNHw6/CRlSw5zm6WroAINYcVGeOWM097xNjXohxBUiPGHsUHHlM+8poNv2+yj/gVVwFmZp0pAP//pLh0BQ0Clx+iEU54F2zM114rF/4/YVC9IUG6oJ5pA77retxXffyR8TWPysQcLs0YER6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E2A716A3;
	Fri, 12 Sep 2025 03:04:30 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392C63F66E;
	Fri, 12 Sep 2025 03:04:37 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:04:34 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "J. =?UTF-8?B?TmV1c2Now6RmZXI=?= via B4 Relay"
 <devnull+j.ne.posteo.net@kernel.org>
Cc: j.ne@posteo.net, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Add Amediatech X96Q
Message-ID: <20250912110434.2a520acc@donnerap>
In-Reply-To: <20250912-x96q-v1-1-8471daaf39db@posteo.net>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
	<20250912-x96q-v1-1-8471daaf39db@posteo.net>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Sep 2025 01:52:09 +0200
J. Neusch=C3=A4fer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrote:

> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>=20
> The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> output, and infrared input.
>=20
>   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
>=20
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index c25a22fe4d25cbd8a8132689f1326548f7f43f2c..c9940b44bc888f7ab81ace671=
040bd663556c113 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -963,6 +963,11 @@ properties:
>            - const: hechuang,x96-mate
>            - const: allwinner,sun50i-h616
> =20
> +      - description: X96Q
> +        items:
> +          - const: amediatech,x96q
> +          - const: allwinner,sun50i-h616
> +
>        - description: X96Q Pro+
>          items:
>            - const: amediatech,x96q-pro-plus
>=20


