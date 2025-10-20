Return-Path: <linux-kernel+bounces-861426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758A3BF2B30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C73818A17B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21B330B38;
	Mon, 20 Oct 2025 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvFaRQws"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F58221FC8;
	Mon, 20 Oct 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981133; cv=none; b=QtDEPV0RvmVwOwbulZyKnBh8ycVGXcY7ULVIrI6tI2SUzzQZZPke2Xhfb7Ei2VW9iD7Qqt85J5AF+1fk4nqYVFgHBtf5VceKVIISYJ0DXA888Z/5+uHjLdr08Az6+clgX2XMmxZDURbuneR11V9+xlowtXqWWvLtJrPWBAk6OO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981133; c=relaxed/simple;
	bh=DuBiH9luvdFsYtFQDPaPHiGDRbY0ctxFlHUj5m7vjTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIOkkX1FWFFp90i70n9oihcZIu5BJqRPNWadpESzVatn0OScUFI0TnZUjFTxqEnEvrEn3nyu5/Wt8A49dwdEpVYlj8iY52u/A6/oYySqvrVNix3HHTkVQRrBdUpONnbUZBg8gW3aJHCUfXcb4iueZzPeSIuUuzgGHWm/SoDcZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvFaRQws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB16C4CEF9;
	Mon, 20 Oct 2025 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981132;
	bh=DuBiH9luvdFsYtFQDPaPHiGDRbY0ctxFlHUj5m7vjTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvFaRQws7bdXPnuSz/e9AOAPBP5vBrh4radRk3rQm+sefnQSGzRu3/alDZVhArAuJ
	 yqau7dOASZUNWselQ2tzgdz4BRYTmRsG8tR34AwICJaEHX/Ykdo+soiQJHDc9WUUwM
	 xKHW8fopijbL08IfGG3DQhUlvUTxbYi6nZgJi6g2Ws4TRclTKbt4NnZ0lVHp3C+uwV
	 rrZawovEREr+Y7GLeuGXQ8DGukbkIklwlmxAm81VJojIA/ghY/D5EDKX1U8ayM6JbW
	 s5k3AJECYx/FbjGxyKs8GhBxmxq0VEKeLzCE27bSgT5pFwyTF7O5Urv8HCQwB6SnKM
	 78qcZBhgNad0g==
Date: Mon, 20 Oct 2025 18:25:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
	sboyd@kernel.org, sugar.zhang@rock-chips.com, heiko@sntech.de,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com
Subject: Re: [PATCH v3 4/5] dt-bindings: clock: Add support for rockchip
 pvtpll
Message-ID: <20251020-pureness-portion-61cef49b6042@spud>
References: <20251020023724.2723372-1-zhangqing@rock-chips.com>
 <20251020023724.2723372-5-zhangqing@rock-chips.com>
 <DDN1RQB4LG0X.30F0A3IMJ4YI4@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zDbktCb2H3iO4Q0A"
Content-Disposition: inline
In-Reply-To: <DDN1RQB4LG0X.30F0A3IMJ4YI4@cknow-tech.com>


--zDbktCb2H3iO4Q0A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:38:02AM +0200, Diederik de Haas wrote:
> On Mon Oct 20, 2025 at 4:37 AM CEST, Elaine Zhang wrote:
> > Add pvtpll documentation for rockchip.
> >
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > ---
> >  .../bindings/clock/rockchip,clk-pvtpll.yaml   | 100 ++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,cl=
k-pvtpll.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpl=
l.yaml b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
> > new file mode 100644
>=20
> Should this file have the 'clk-' part in its name?
> In a way this is different from the other DT binding files, but none of
> the others have the 'clk-' part in their file name:

Normally we would ask for a filename matching the compatible, which IIRC
is what these -cru ones are doing.

>=20
> me@pc:~/linux/Documentation/devicetree/bindings/clock$ ls -lh rockchip,*
> -rw-rw-r-- 1 me me 2,9K okt 20 11:32 rockchip,px30-cru.yaml
> -rw-rw-r-- 1 me me 1,9K okt 20 11:32 rockchip,rk3036-cru.yaml
> -rw-rw-r-- 1 me me 1,8K okt 20 11:32 rockchip,rk3128-cru.yaml
> -rw-rw-r-- 1 me me 2,3K okt 20 11:32 rockchip,rk3188-cru.yaml
> -rw-rw-r-- 1 me me 2,1K okt 20 11:32 rockchip,rk3228-cru.yaml
> -rw-rw-r-- 1 me me 2,6K okt 20 11:32 rockchip,rk3288-cru.yaml
> -rw-rw-r-- 1 me me 2,2K okt 20 11:32 rockchip,rk3308-cru.yaml
> -rw-rw-r-- 1 me me 2,1K okt 20 11:32 rockchip,rk3328-cru.yaml
> -rw-rw-r-- 1 me me 2,4K okt 20 11:32 rockchip,rk3368-cru.yaml
> -rw-rw-r-- 1 me me 2,5K okt 20 11:32 rockchip,rk3399-cru.yaml
> -rw-rw-r-- 1 me me 1,5K okt 20 11:32 rockchip,rk3528-cru.yaml
> -rw-rw-r-- 1 me me 1,1K okt 20 11:32 rockchip,rk3562-cru.yaml
> -rw-rw-r-- 1 me me 1,8K okt 20 11:32 rockchip,rk3568-cru.yaml
> -rw-rw-r-- 1 me me 1,2K okt 20 11:32 rockchip,rk3576-cru.yaml
> -rw-rw-r-- 1 me me 1,6K okt 20 11:32 rockchip,rk3588-cru.yaml
> -rw-rw-r-- 1 me me 2,2K okt 20 11:32 rockchip,rv1108-cru.yaml
> -rw-rw-r-- 1 me me 1,3K okt 20 11:32 rockchip,rv1126-cru.yaml
>=20
> > index 000000000000..8be34bcde7b0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
> > @@ -0,0 +1,100 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/rockchip,clk-pvtpll.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip Pvtpll
> > +
> > +maintainers:
> > +  - Elaine Zhang <zhangqing@rock-chips.com>
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - rockchip,rv1103b-core-pvtpll
> > +          - rockchip,rv1103b-enc-pvtpll
> > +          - rockchip,rv1103b-isp-pvtpll
> > +          - rockchip,rv1103b-npu-pvtpll
> > +          - rockchip,rv1126b-core-pvtpll
> > +          - rockchip,rv1126b-isp-pvtpll
> > +          - rockchip,rv1126b-enc-pvtpll
> > +          - rockchip,rv1126b-aisp-pvtpll
> > +          - rockchip,rv1126b-npu-pvtpll
> > +          - rockchip,rk3506-core-pvtpll
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#clock-cells":
> > +    const: 0
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-output-names:
> > +    maxItems: 1
> > +
> > +  rockchip,cru:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> > +      Phandle to the main Clock and Reset Unit (CRU) controller.
> > +      Required for PVTPLLs that need to interact with the main CRU
> > +      for clock management operations.
> > +
> > +required:
> > +  - "#clock-cells"
> > +  - compatible
> > +  - reg
> > +  - clock-output-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pvtpll_core: pvtpll-core@20480000 {

Additionally, none of the labels are being used and should be removed.
"pvtpll-anything" is also not a generic node name, so those should get
changed too.

> > +      compatible =3D "rockchip,rv1126b-core-pvtpll", "syscon";
> > +      reg =3D <0x20480000 0x100>;
> > +      #clock-cells =3D <0>;
> > +      clock-output-names =3D "clk_core_pvtpll";
> > +    };
> > +
> > +  - |
> > +    pvtpll_isp: pvtpll-isp@21c60000 {
> > +      compatible =3D "rockchip,rv1126b-isp-pvtpll", "syscon";
> > +      reg =3D <0x21c60000 0x100>;
> > +      rockchip,cru =3D <&cru>;
> > +      #clock-cells =3D <0>;
> > +      clock-output-names =3D "clk_isp_pvtpll";
> > +    };
> > +
> > +  - |
> > +    pvtpll_enc: pvtpll-enc@21f00000 {
> > +      compatible =3D "rockchip,rv1126b-enc-pvtpll", "syscon";
> > +      reg =3D <0x21f00000 0x100>;
> > +      #clock-cells =3D <0>;
> > +      clock-output-names =3D "clk_vepu_pvtpll";
> > +    };
> > +
> > +  - |
> > +    pvtpll_aisp: pvtpll-aisp@21fc0000 {
> > +      compatible =3D "rockchip,rv1126b-aisp-pvtpll", "syscon";
> > +      reg =3D <0x21fc0000 0x100>;
> > +      rockchip,cru =3D <&cru>;
> > +      #clock-cells =3D <0>;
> > +      clock-output-names =3D "clk_vcp_pvtpll";
> > +    };
> > +
> > +  - |
> > +    pvtpll_npu: pvtpll-npu@22080000 {
> > +      compatible =3D "rockchip,rv1126b-npu-pvtpll", "syscon";
> > +      reg =3D <0x22080000 0x100>;
> > +      rockchip,cru =3D <&cru>;
> > +      #clock-cells =3D <0>;
> > +      clock-output-names =3D "clk_npu_pvtpll";
>=20
> rockchip,cru line as the last line?
>=20
> Cheers,
>   Diederik
>=20
> > +    };
> > +
> > +...
>=20

--zDbktCb2H3iO4Q0A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZwhwAKCRB4tDGHoIJi
0iLPAP94ZMFR0xuWCqtCuslKikrX4Ilvj42EKuYV0Wo1K3G3xgEA6RkNCbvO3yRX
ZW3mmydndwZgdwfiMuW03QLeH0FEnwI=
=Kr3S
-----END PGP SIGNATURE-----

--zDbktCb2H3iO4Q0A--

