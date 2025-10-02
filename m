Return-Path: <linux-kernel+bounces-840665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C84BB4ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0889188AB1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78B27A919;
	Thu,  2 Oct 2025 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQhyisly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701E22DF95;
	Thu,  2 Oct 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430759; cv=none; b=fqNGqdtkRXSRFB1zjqdhEDMfSExixtvd+l3z9Yf4KuEmf0ZYWjsZJliTegr1QSBh+25P76R91s4+0ikWPcy+CCedfzBOiVuCaPdseTR9g39SGd2tF2IqUY8G1mPV8sC0s5pMsMIqecPl0u7JXHUUun2chGXq+17iFbC6EAlIgrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430759; c=relaxed/simple;
	bh=fTeswSATcB2l4kKFC+T/Jf728hFziZCZ/toefctXIrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnntCqtdCN7t2ycVOMKN/AfKyhaaYR0KKGlkf39qzmJzVyZFe71laYqsO0/Ycy/KYZZHrXLbsEwKwW/ayBG/tmBXE5yfg5Myu7LpRbn+DGMBk4iCm2zBpVMq+t1jxIIMkmek1bHLT9Irdp/O0KOV8eCePFN25OCQ/y6vlLmDENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQhyisly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DF9C4CEF4;
	Thu,  2 Oct 2025 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759430758;
	bh=fTeswSATcB2l4kKFC+T/Jf728hFziZCZ/toefctXIrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQhyisly4HVJjxG8UgkQns4wkNuHmaejeAERzdvdF1DOHjL+v6Bijl7RGahduUQX5
	 JryMYDLDa2za9Rm7NFm6dfYQHXByP2D0h1nFvvE9WTo/ylGOFSsUjXc2gLBZh2Uzsi
	 sOxvOaWgZfi78sMocLj7MC6NnndZTXtnjiv1Xhh0PLMCAswpJhAXjB6ITNlkE7Mphr
	 BJBpw0B+GERHJ99qcq6CblICTnd2PEShT0lrY23J0WX/rClzikI8YutFJ4Pg0m0Wyi
	 foVB+OzHWCWkoKDHaQIMQfQ2y11tjyk9sOrUh2+6ZXJH9fpu8hpnPEQZihVn0ou21l
	 zvYQquUQcBCzA==
Date: Thu, 2 Oct 2025 19:45:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset
 definition
Message-ID: <20251002-accuracy-gloomily-a3e46d5a3f02@spud>
References: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eQ5hYxmKmELL5wam"
Content-Disposition: inline
In-Reply-To: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>


--eQ5hYxmKmELL5wam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 05:56:51PM +0800, Jammy Huang wrote:
> Add VIDEO reset bit definition for AST2500/AST2600.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  include/dt-bindings/clock/aspeed-clock.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindin=
gs/clock/aspeed-clock.h
> index 06d568382c77..421ca577c1b2 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -53,5 +53,6 @@
>  #define ASPEED_RESET_AHB		8
>  #define ASPEED_RESET_CRT1		9
>  #define ASPEED_RESET_HACE		10
> +#define ASPEED_RESET_VIDEO		21

What's up with the gap here? Are there another 10 resets missing?

--eQ5hYxmKmELL5wam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN7IYQAKCRB4tDGHoIJi
0jpPAPoD3Ml/y5Zj0L/EgesLMAZ+GyKvd9Lokp4c6QrcNGpuVwD+JY5XO5FYrPik
Fl5hcgGgK1Zfdf1qYGlZVllML/j07Q8=
=ne6M
-----END PGP SIGNATURE-----

--eQ5hYxmKmELL5wam--

