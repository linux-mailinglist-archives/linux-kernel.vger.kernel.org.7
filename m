Return-Path: <linux-kernel+bounces-861430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2591DBF2B51
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA439421F52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE5331A5A;
	Mon, 20 Oct 2025 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZWlQqnh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245532860D;
	Mon, 20 Oct 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981271; cv=none; b=OdaWqa8y7KB+MJFx4B8GSI0UwYYar0Xhw/9sSPu0N3srbbobkbF5S3Z491xtQ4OXGcAAkaCl5AYM+ikFUM/hs5j5Eyupf7TtgV8zDulqcj4qdZbxYXHAZ7G23oskhSQGOMzwwThU9vwh/9ju4cCA5Ba36VcBGtlbTaX9KLhtoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981271; c=relaxed/simple;
	bh=5BENNYug8XWdW1sRlDCxLFbkXQ3SRgxDfRFcZP68nU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBq/RtAGDsOm4Q4HkL5Iup7Hzf5a7ohsLszbt1d+4TCWWI3tK/IKIvzBlxViEdjVJ8jZf35e5g0bJoKhZyBIHCWVF5FLRnsfANs3KrAug5K1adNH6MsATEV/J5GL3RvU1uWnqEC1qxdQtp5sM0oxWkC717MJyvO3x6UsAUL6Zu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZWlQqnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16131C4CEFE;
	Mon, 20 Oct 2025 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981270;
	bh=5BENNYug8XWdW1sRlDCxLFbkXQ3SRgxDfRFcZP68nU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZWlQqnhOTnejHM2lDjdNx9bZdkaSKeBvuSUWmPDoO75NqyF+zGtpp5J/jCZdFn+V
	 l+qIkc7RYKOHvTP+mG+ckUNd6YwtYMk3hzLl2xkJKrdJ5Wpk2W1fLupLwuFzcwlogH
	 fGCy3mMHMsu2StnL1PMyyVSANO94DUPlppuLCm3BhOQoF/3y/Yu9QSoL9VqudEKhjD
	 ALXMoHKmyAyNrJbqicL3BRsLye9p4bPcIL+kHuDE5PgRe5tztq4yNlettuBpPgZN+Z
	 P89Ndt56vztGV4lgnWD0qqfhgeb8lzYjnK/JKzLm2gJInlI8B3XZuaSSdgGQy5d4Q/
	 25nS6P7VSc/yA==
Date: Mon, 20 Oct 2025 18:27:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
	heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com
Subject: Re: [PATCH v3 2/5] dt-bindings: clock, reset: Add support for rv1126b
Message-ID: <20251020-glorify-stalling-784a52342283@spud>
References: <20251020023724.2723372-1-zhangqing@rock-chips.com>
 <20251020023724.2723372-3-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8jPfVFF+LsEAbTxS"
Content-Disposition: inline
In-Reply-To: <20251020023724.2723372-3-zhangqing@rock-chips.com>


--8jPfVFF+LsEAbTxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:37:21AM +0800, Elaine Zhang wrote:
> Add clock and reset ID defines for rv1126b.
> Also add documentation for the rv1126b CRU core.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rv1126b-cru.yaml  |  52 +++
>  .../dt-bindings/clock/rockchip,rv1126b-cru.h  | 392 +++++++++++++++++
>  .../dt-bindings/reset/rockchip,rv1126b-cru.h  | 405 ++++++++++++++++++
>  3 files changed, 849 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv11=
26b-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rv1126b-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rv1126b-cru.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru=
=2Eyaml b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
> new file mode 100644
> index 000000000000..61bfcde9b16a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rv1126b-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RV1126B Clock and Reset Unit
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description:
> +  The rv1126b clock controller generates the clock and also implements a
> +  reset controller for SoC peripherals.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rv1126b-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: xin24m
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cru: clock-controller@20000000 {

Drop this label, and then
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

Cheers,
Conor.

--8jPfVFF+LsEAbTxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZxEQAKCRB4tDGHoIJi
0kK8APsGDaDaPrNBh1llytFgMG6Li16PklHNduqnpWuyb+OT+AD9HLQrJ1te/veD
OlXvk1cf/bainZQeYTHLjwAfv3PzoQI=
=VlJd
-----END PGP SIGNATURE-----

--8jPfVFF+LsEAbTxS--

