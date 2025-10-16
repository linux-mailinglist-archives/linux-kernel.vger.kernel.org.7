Return-Path: <linux-kernel+bounces-856520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42358BE4612
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26226508716
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319634F48B;
	Thu, 16 Oct 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUZIYMRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871322DF12D;
	Thu, 16 Oct 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630156; cv=none; b=pQIcxiCD3BZIWnCT94Py41DZx8qJh90GlI+8myRT3qfByDqyKglRCa7pxiGz/vPxmSfyXgVFA9bNBoifjRqtmC275fkwDTYfQ1QzHOiQ3dCDnrnQNZsWauKu3LzYCJwxwi/Vh1bF4uT9pqHeyXWNlGRcuJmXhCsoI2u1DYkQf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630156; c=relaxed/simple;
	bh=5KcUDlbTdbW74JQlF/gkUuoB3c5EjVuwmuWrmgQ0ytU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9j6ylwFvitp2Eyyn9rrhtCyWEbLuItXBRpGEXfRgrAWyFjIonpdt12kXYeQCbvKRbz71grta2ZOikVX5QLnDxaYXXcoH9XcfiL8PVLRspxEG2wxCiGjvB1FjGtD+I6FOPNjvUmqx4en06sioUdEKhptOi597JfXqRBtYB/mZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUZIYMRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591F9C4CEF1;
	Thu, 16 Oct 2025 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630156;
	bh=5KcUDlbTdbW74JQlF/gkUuoB3c5EjVuwmuWrmgQ0ytU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUZIYMRy0SdlGPD8eIDi6ANT8yz3yB4ImLoUfBNc8S/JhPg8AVgq7LEYDvFNnvcar
	 2n3pFYlN82FiFsA1K7vZrxfgkqQkpiM8ngwAeSd0iWq1+hthKbQJ7KNYjg00ApGAev
	 hjV6WehY7BU2ZSfbfjL2050V+Rm+L7YRZCcXPoTJm5evWzNVcljqNS0dy9+tvcXkcT
	 ayf7ga3kJpExwa0BOPzc2JWIHo/E3bZcu27OJkuFSq8XEYHJ3Ht055ylJ5Zkx3v8ri
	 D/Woo0Seug91QwtLKCjqqXXIWS0myLVxkuzOYegVA6xTwzElnSGg6ccn7OThArLjdb
	 j0E9zBomPIO+w==
Date: Thu, 16 Oct 2025 16:55:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] dt-bindings: riscv: Add StarFive JH7110S SoC and
 VisionFive 2 Lite board
Message-ID: <20251016-scoundrel-engraved-8f0a8272db03@spud>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
 <20251016080054.12484-4-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yh82z3H7Pyc/9lAn"
Content-Disposition: inline
In-Reply-To: <20251016080054.12484-4-hal.feng@starfivetech.com>


--yh82z3H7Pyc/9lAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 04:00:50PM +0800, Hal Feng wrote:
> Add device tree bindings for the StarFive JH7110S SoC
> and the VisionFive 2 Lite board equipped with it.
>=20
> JH7110S SoC is an industrial SoC which can run at -40~85 degrees centigra=
de
> and up to 1.25GHz. Its CPU cores and peripherals are the same as
> those of the JH7110 SoC.
>=20
> VisionFive 2 Lite boards have SD card version (default) and eMMC version,
> which are called "VisionFive 2 Lite" and "VisionFive 2 Lite eMMC"
> respectively.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Since this is content for my tree,
pw-bot: not-applicable

> ---
>  Documentation/devicetree/bindings/riscv/starfive.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Docu=
mentation/devicetree/bindings/riscv/starfive.yaml
> index 04510341a71e..797d9956b949 100644
> --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -35,6 +35,12 @@ properties:
>                - starfive,visionfive-2-v1.3b
>            - const: starfive,jh7110
> =20
> +      - items:
> +          - enum:
> +              - starfive,visionfive-2-lite
> +              - starfive,visionfive-2-lite-emmc
> +          - const: starfive,jh7110s
> +
>  additionalProperties: true
> =20
>  ...
> --=20
> 2.43.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--yh82z3H7Pyc/9lAn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEVhwAKCRB4tDGHoIJi
0oexAQCif99aQHh/UjKJM4nxMrfp4HQJgyK5Hmr+jdvlb8QgdwEAyL1ewW3FsBVG
/RaB4LLH1Z+qUeksf39lUtWVd7oooAw=
=LQeZ
-----END PGP SIGNATURE-----

--yh82z3H7Pyc/9lAn--

