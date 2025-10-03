Return-Path: <linux-kernel+bounces-841753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51205BB8244
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82724C232A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044D253951;
	Fri,  3 Oct 2025 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAaiiEFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA73987D;
	Fri,  3 Oct 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524545; cv=none; b=Ob+5Wsm1pqS971knFlFm3ct3k0WnqvSp4k+h51AjX/SDsojtrNi9bkMV/TcBC5+hmFcIqnK1IKrzmYaA3pWhUNOc+PwfbCaf50IEKgNh2IO1oq5RT/u7V2O/45aBPF0Dq879E7codGz3Njxc65VbGRtmixKP6Ut6rAkJiIwJokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524545; c=relaxed/simple;
	bh=HQTN2i+oT4JFL9hKIQWaUwNNbKsxDcq6rJFXHwtEikg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c99/oXXx39hCM6Las2ZwIZcWj2xXziXttd7HCucQ+IyF5izaZAFocN0I+0aG5sstlhKtxDcrxlX8S4mLjKz2YOYnvZ+YIpjgPdqmVL+F9R4BXUQFejDjbKsUHeJJTfOQNnCYjeGm1rS+y0fI4S6692vLARUPcCTmREN+z9qkJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAaiiEFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6CEC4CEF5;
	Fri,  3 Oct 2025 20:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524544;
	bh=HQTN2i+oT4JFL9hKIQWaUwNNbKsxDcq6rJFXHwtEikg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAaiiEFQHTfaCaOlYOkAF/OukCRWCchT3W9jx+D2mhrmILAFZaAcwRxrdNVXkRKj2
	 02qQ68YfCssAjZzlcxQHMGs0ihIJh7PwxYi5KZ1PId5HPNXwer3tBLvizJz8/sy0ad
	 3hEiWr2yv9L5aLWBfT/KNpTsPO91gcTjcqmGiNwHWW3b33XCWsm7y2Mvhw5Jljt6jN
	 wUrNkGUCfctJPguOmbZHWsEy9siTTuhk8oDCJK6Am1lYKfsiQkf+o6FNaVc09/SNA8
	 r8khxcmnPRXK74I44TylP+W4XepoACJ2hATZC4rp62J1VcFSKW8xdvCRPLHzDbrrk/
	 1gH0u83Ddh70A==
Date: Fri, 3 Oct 2025 21:49:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: aspeed: Add VIDEO reset
 definition
Message-ID: <20251003-paralyze-herald-f9ef464d43e2@spud>
References: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
 <20251003015845.2715538-2-jammy_huang@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0l94K67tftqusJJV"
Content-Disposition: inline
In-Reply-To: <20251003015845.2715538-2-jammy_huang@aspeedtech.com>


--0l94K67tftqusJJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 09:58:44AM +0800, Jammy Huang wrote:
> ASPEED clock controller provides a couple of resets. Add the define of
> video to allow referring to it.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  v2 changes:
>   - Update index of ASPEED_RESET_VIDEO

Ah, so here is the next version. I don't see how this can be correct if
21 was correct before. Was 21 wrong?
> ---
>  include/dt-bindings/clock/aspeed-clock.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindin=
gs/clock/aspeed-clock.h
> index 06d568382c77..671e5a476eae 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -53,5 +53,6 @@
>  #define ASPEED_RESET_AHB		8
>  #define ASPEED_RESET_CRT1		9
>  #define ASPEED_RESET_HACE		10
> +#define ASPEED_RESET_VIDEO		11
> =20
>  #endif
> --=20
> 2.25.1
>=20

--0l94K67tftqusJJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOA2uwAKCRB4tDGHoIJi
0kHxAP9tfxXaNJcuCWViceFs1gRlxpPvViWfAlgUUO4nMPglFQD/Y2wX2hhSzCcW
lX1Osw6hWMgsEj7CQ1ilQ4aTXa/d5QU=
=B5UU
-----END PGP SIGNATURE-----

--0l94K67tftqusJJV--

