Return-Path: <linux-kernel+bounces-730565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77454B04658
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849557AE31E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8A264A9F;
	Mon, 14 Jul 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIMXThN8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66490264613;
	Mon, 14 Jul 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513636; cv=none; b=tDD5gdJkmFdJiLyCaLQdWdzUR28pgflQSstWGphT+K62yxSK0LS+vTLYZeyy8vyN4BcQTnioIOnlno1Gdak5Wkb2qxNmjzFrjN0EBGMtIAcIEENacp5cuBnBWtkLiEL/2I9ZXKrrGfcrFhXMUS1OoWg7rm7/mL4E01/5CGA6xqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513636; c=relaxed/simple;
	bh=ohJ9qrrQgWg3Rt90ioF48hQhw7zbjaMSDzigGC56xjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYhN1DwvECV3kSlxrDZD3b+4WlFBqHr+2OorMQYyA271vaWV69GAAyHCqrFyXSuyIgNsfdJjor/Rr0J9Hjj5bK5wbp53eg8CigjuYcmtX265SOv5judm8dQstRdpLP91ZOwKGJ1D8hH/6p1KpUIsFnRNtduYXWzb9JBys5mHzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIMXThN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15CBC4CEED;
	Mon, 14 Jul 2025 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752513636;
	bh=ohJ9qrrQgWg3Rt90ioF48hQhw7zbjaMSDzigGC56xjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIMXThN8Bj0Sr0dor3CLXP6DuXIC9EghZ3qncsfl91ShGbUyq750clKu7WviuLcoI
	 SwVjHOefCXl+sdvZ2KTGp7Dd707U8UQJdcZJHt+ZGDp/UwOCzYyhtKHqekj8bRa4pW
	 562o+SKo5AHibIR+72YIavCypNPR4c3/0p8cGgSJCir+r9wdneYKnlyjC+o7ys8m54
	 b4hvHHiqdhbJF3r23wdr4r7EM3D/9SROMo3oHeNb4apOv8E9PonZXQbMVLpVdmslng
	 idc+XDiU9swE81maPI2UyijBLhux57zP3+hiFybGoH3PLj9GN6rBcfKXa7jeTbdVNQ
	 7hdvZdGwxpJig==
Date: Mon, 14 Jul 2025 18:20:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] docs: dt: writing-bindings: Document discouraged
 instance IDs
Message-ID: <20250714-envision-pouncing-39a6a96ef2a4@spud>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
 <20250713-dt-bindings-docs-v2-3-672c898054ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V5+Nlubxho+Ac113"
Content-Disposition: inline
In-Reply-To: <20250713-dt-bindings-docs-v2-3-672c898054ae@linaro.org>


--V5+Nlubxho+Ac113
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 02:46:38PM +0200, Krzysztof Kozlowski wrote:
> Document established Devicetree bindings maintainers review practice:
> instance indexes, either as properties or as custom new OF alias, are
> not accepted.  Recommended way is to use, depending on the
> situation/hardware: different compatible, cell arguments or syscon
> phandle arguments.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--V5+Nlubxho+Ac113
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaHU8YAAKCRB4tDGHoIJi
0povAP4pRUpu8i25xIfA/tlizz5VVlf1wcMiz8CeKKmpQFENeQD9FqHMeNZo0C4L
EuLrzw/zYjwEubgjNwJd+WRQ6VTL7wA=
=10pq
-----END PGP SIGNATURE-----

--V5+Nlubxho+Ac113--

