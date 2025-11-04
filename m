Return-Path: <linux-kernel+bounces-885235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD73C3257D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0F818915CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC78334379;
	Tue,  4 Nov 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StnnIrCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B347083C;
	Tue,  4 Nov 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277090; cv=none; b=X5CO7vIBxS5Adh98LecU2EbS/pZSQM4MmoZnOYsJkR/l++sJ7oYgDsVqeIgZgn9qDrr2gqvwIieTJBhL64QmtR+I5u8+4vfzmllGuByd5QzSzeTQdrQKKodDivlRxTo2aqbwgt7pipIPwkbUyhHZg7nEORg+gL+s3GJLtKw7MNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277090; c=relaxed/simple;
	bh=+TLOnLbCL5l5MRbrs9lE6WIYNLgYsCpPv21pat0QuSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eg1b+rC0YxvKAJTzcz23ougO6H/OH72DE8otKCtYVfON/nc49qNU6bticHHbWFjMQc0hvlq2dqxIXiFTkFV7+0xQqhsYLZ9ICr88LSwjrSBEtjiiny2J/KnLAjVPcFycGbJ8d0XQjmaBSHQhZBHb2GyUXivRsIx+DDu93bTkdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StnnIrCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A87C116B1;
	Tue,  4 Nov 2025 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762277090;
	bh=+TLOnLbCL5l5MRbrs9lE6WIYNLgYsCpPv21pat0QuSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StnnIrCpIfexi/XSVYxGF69H/0GE6GfX4k0z09VgVzz6spCyoC63cdDjQxX2Et2sC
	 DK12ugrCfT7NjtLoeCgPr68r2E/Ou8XvbluyT+GgSHgZHPAN/5LlEpM6sLarbwJGzA
	 9xFLcoxud8n3NyihCoucL/+JZj+y4ZxeUmVza7LlWQiubpBPS8Jkq7SQMjM4ikKprZ
	 e3Sybkc/3kEd9qnVjnzWcxiBRm6uU4ZgqZL8ds/aeQjp0pueUZtsGhiHPCxvdFLfZX
	 MNfuCVvRVwsHIsJ1u66oicV3hGIAcfRa3XxNCVFfboDEsywLYraCBz2PA02AHmYAWZ
	 PF+Un6+lVAXzA==
Date: Tue, 4 Nov 2025 17:24:45 +0000
From: Conor Dooley <conor@kernel.org>
To: zhangqing <zhangqing@rock-chips.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
	heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com, finley.xiao@rock-chips.com
Subject: Re: [PATCH v5 6/7] dt-bindings: clock: rockchip: Add RK3506 clock
 and reset unit
Message-ID: <20251104-nutty-lunchroom-36a5879db0b9@spud>
References: <20251027084147.4148739-1-zhangqing@rock-chips.com>
 <20251027084147.4148739-7-zhangqing@rock-chips.com>
 <20251027-await-wound-0aee2d20e0a3@spud>
 <6ff7370e-0e57-487d-a6d9-05958ab21e98@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GbKegIoFUbmOWI8i"
Content-Disposition: inline
In-Reply-To: <6ff7370e-0e57-487d-a6d9-05958ab21e98@rock-chips.com>


--GbKegIoFUbmOWI8i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 09:48:56AM +0800, zhangqing wrote:
>=20
> =E5=9C=A8 2025/10/28 0:47, Conor Dooley =E5=86=99=E9=81=93:
> > On Mon, Oct 27, 2025 at 04:41:46PM +0800, Elaine Zhang wrote:
> > > From: Finley Xiao<finley.xiao@rock-chips.com>
> > >=20
> > > Add device tree bindings for clock and reset unit on RK3506 SoC.
> > > Add clock and reset IDs for RK3506 SoC.
> > >=20
> > > Signed-off-by: Finley Xiao<finley.xiao@rock-chips.com>
> > > ---
> > >   .../bindings/clock/rockchip,rk3506-cru.yaml   |  51 ++++
> > >   .../dt-bindings/clock/rockchip,rk3506-cru.h   | 285 +++++++++++++++=
+++
> > >   .../dt-bindings/reset/rockchip,rk3506-cru.h   | 211 +++++++++++++
> > >   3 files changed, 547 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/clock/rockchip=
,rk3506-cru.yaml
> > >   create mode 100644 include/dt-bindings/clock/rockchip,rk3506-cru.h
> > >   create mode 100644 include/dt-bindings/reset/rockchip,rk3506-cru.h
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3506-=
cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
> > > new file mode 100644
> > > index 000000000000..ecb5fa497747
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
> > > @@ -0,0 +1,51 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id:http://devicetree.org/schemas/clock/rockchip,rk3506-cru.yaml#
> > > +$schema:http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Rockchip RK3506 Clock and Reset Unit (CRU)
> > > +
> > > +maintainers:
> > > +  - Finley Xiao<finley.xiao@rock-chips.com>
> > > +  - Heiko Stuebner<heiko@sntech.de>
> > > +
> > > +description: |
> > > +  The RK3506 CRU generates the clock and also implements reset for S=
oC
> > > +  peripherals.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: rockchip,rk3506-cru
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#clock-cells":
> > > +    const: 1
> > > +
> > > +  "#reset-cells":
> > > +    const: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > Can you explain somewhere why the input clock is not required?
> > Feels like it really should be required, if it is what the output clocks
> > are generated from, but I can also see why it might be optional either.
> > pw-bot: changes-requested
>=20
> Our default hardware input clock is 24M.
>=20
> =C2=A0Some Socs and hardware input clocks support 24M=E3=80=8124.576M=E3=
=80=8126M. For

Other SoCs get other compatibles, so that is not relevant.

> different input frequencies, there is a need to configure clocks.

That seems like it should be required, because there's always one being
provided.

--GbKegIoFUbmOWI8i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo23QAKCRB4tDGHoIJi
0s2JAQDVZlJVC+3VPu0Seil/rz3PFRN98sMD7cctohGiuYB3fgEAoRehJnbC+mUT
NA+BG6kXfU+6fIkftGl4HWzd5sYovQg=
=3/I5
-----END PGP SIGNATURE-----

--GbKegIoFUbmOWI8i--

