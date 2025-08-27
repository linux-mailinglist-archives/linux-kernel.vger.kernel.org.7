Return-Path: <linux-kernel+bounces-788675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9084CB3888C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EC51B61DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260362D640E;
	Wed, 27 Aug 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fnt7Pfmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EAD293C44;
	Wed, 27 Aug 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315624; cv=none; b=PjRgYeSdM7EK8N8fq143VETLt+7vvnZAledqtB3Rout6TDwgKzkAyb4hd26UT2FqHhOPABlUaUl5SzN2d7dHOKZ3k5/buROJOOHRQrW1JfYCICeECo14GiBp/uaQ/LpkmPna4T0O1YLMKlDysDQwpWVWHYb1jKR+GHlUurykCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315624; c=relaxed/simple;
	bh=R02be9EuV+jgifoEisvGEy2S81lZDpDwRAcvnCKgS7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQWxn78ZfteLCjsRmraVS8+s3KAnEp1/hdVA6ArKfVBjgErM5cxqoSm//r5cwNwb1anzhnHSf3nI/B44tKhqsJgAJXOS1+I9y/xmbPigq2qGFosEEelS8xO0fyObQwiqyTmhqSRzvWJFFfips3DJQcfB0nnCn2aN3S//0RvqHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fnt7Pfmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C15C4CEF0;
	Wed, 27 Aug 2025 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315624;
	bh=R02be9EuV+jgifoEisvGEy2S81lZDpDwRAcvnCKgS7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fnt7Pfmc/sg4F8vwC9cZpLIUnH24jiAwB+Tj1/VTcNjuwlgIVHSLV0mqjRl0EBKi1
	 PWO051Xqx0wC5v1NOz8X6ZI//B+TUFDwbZe/abmA0hK4T8nWBay6B91GX+UMZ9znmO
	 OC8aXHTdNmb1YZui+2C+fnU8JFYe5MmZ2iXiLkWxWT9wdfg26KqQXhqKvKwVhlHLCP
	 +3JnucJTo6G1CvzhiQPqEJCKZF29xFBFGV0dTWHwfSkl3va/sdaYfKajYApZvhSz8/
	 mJz8R8Z1ZYD9zbLSueDqLcakES3CxFXJKB874SQdUXfKiLhXr2aqpLeXeRnFQH0r3a
	 Utdl0V1lmZ9Kw==
Date: Wed, 27 Aug 2025 18:26:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, linaro-s32@linaro.org
Subject: Re: [PATCH V2 1/3] dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml
 file
Message-ID: <20250827-buckle-humbling-45ec6a4c0c16@spud>
References: <cover.1756219848.git.dan.carpenter@linaro.org>
 <eabdbf4c0b74136b77e16eaca5d5e64d5c4a97a0.1756219848.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4HV4zPw9LvC33tZP"
Content-Disposition: inline
In-Reply-To: <eabdbf4c0b74136b77e16eaca5d5e64d5c4a97a0.1756219848.git.dan.carpenter@linaro.org>


--4HV4zPw9LvC33tZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 07:38:03PM +0300, Dan Carpenter wrote:
> From: Ciprian Costea <ciprianmarian.costea@nxp.com>
>=20
> Add bindings to expose the On Chip One-Time Programmable Controller
> (OCOTP) for the NXP s32g chipset.  There are three versions of this
> chip but they're compatible so we can fall back to the nxp,s32g2-ocotp
> compatible.
>=20
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: dt_binding_check DT_SCHEMA_FILES=3Dnxp,s32g-ocotp-nvmem.yaml is clean
>     make CHECK_DTBS=3Dy freescale/*.dtb is clean.  Particularly the
>       freescale/s32g274a-evb.dtb file which Rob mentioned.
>     remove bogus include file
>     remove redundant "reg" description
>     remove #address-cells and #size-cells since they are already in
>     nvmem.yaml
>     Fix email From header
>=20
>  .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocot=
p-nvmem.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem=
=2Eyaml b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
> new file mode 100644
> index 000000000000..01adc6093c68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/nxp,s32g-ocotp-nvmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G OCOTP NVMEM driver
> +
> +maintainers:
> +  - Ciprian Costea <ciprianmarian.costea@nxp.com>
> +
> +description: |
> +  The drivers provides an interface to access One Time
> +  Programmable memory pages, such as TMU fuse values.
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,s32g2-ocotp
> +      - items:
> +          - enum:
> +              - nxp,s32r45-ocotp
> +              - nxp,s32g3-ocotp
> +          - const: nxp,s32g2-ocotp
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ocotp: nvmem@400a4000 {

If you respin, drop the "ocotp" label, since the example doesn't use it.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--4HV4zPw9LvC33tZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaK8/4wAKCRB4tDGHoIJi
0sR7AQD1QrPZKoUn+AwYQlHkr2HlzFt0/lW32LVbF05Z1USMYgD/cDqDM7Au+T5/
luXQ3BHByPV2meLHIQ+qqkj6hB7sJAs=
=KyxJ
-----END PGP SIGNATURE-----

--4HV4zPw9LvC33tZP--

