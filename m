Return-Path: <linux-kernel+bounces-888076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889EC39C92
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B04188D678
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07FE30B519;
	Thu,  6 Nov 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMwSiCQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DCF26B95B;
	Thu,  6 Nov 2025 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420663; cv=none; b=ZQRkU2Z9QJUydZKDLCwHWQXJ4fwFLTXPMPRYpRYA4yzky/k9UDKBghyk6rB6hHFyQcwnVOBC75Gs1F3FsM3bs5eMQxW4YWHU7QLthsD6KI6hXoVXVeXonEmxHDFxE8bGJldRGYpuNyGdxNXLYbzA0Q6GQ46vRwsXtfDoMZyg5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420663; c=relaxed/simple;
	bh=RfYL95h+aYzfWMnATGWmDxw7GT+VNOPhsZev5AOYUVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7tCk0xNP1WHo1ALWG//iuIUXTnMqaFxHORWVez5gGKnurnXBwWmFHzKlKgxNI68jviPS5BHmPVWKC6s+rr7O3OmCHs4CK+bs+H7Te+7B5+fOEZ77PexoR8dUB17o5LhKrDbX3b89veaMIl0wCXD2HGe5T1cm0L9ZC+guGTw054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMwSiCQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B3FC116B1;
	Thu,  6 Nov 2025 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762420662;
	bh=RfYL95h+aYzfWMnATGWmDxw7GT+VNOPhsZev5AOYUVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMwSiCQjTT62XRyFxtHRwNzYYPo1DpbjNKflPaNWy/D6aoEDRjOuoFG8oh5qDWZD3
	 akZs0+AE70MS1xFuNRAzxpwZO8O0DCnfOaXV8bCftOZaE4cOADG/hphYqKuLnOa6/A
	 6im35QBDqfr2ayndpFO8ixO902WUvCt+g105mYPdshATQrXtHjZ4FbwHvHFadWht/t
	 9VORxgE0r+vEjV4ds9LpX5qNyLpOCA1AdWfFcTCAg+f2uzFwzq9MPbjQvpVGQ9G1k4
	 WW1Da7+18S91ghoQJi/3IsI913pwJEufDQuGSaJ761/U6WgtYBwtHqgM6mEDMOh9tl
	 74yFWbdeZMFPQ==
Date: Thu, 6 Nov 2025 09:17:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Enlin Mu <enlin.mu@linux.dev>, robh@kernel.org, saravanak@google.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	enlin.mu@unisoc.com
Subject: Re: [PATCH] of: print warning when cmdline overflows from bootargs
Message-ID: <20251106-twister-circle-39dc8e85748b@spud>
References: <20251105082717.4040-1-enlin.mu@linux.dev>
 <20251106-kiwi-of-total-valor-b27f5d@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rpd4xM12kh0gtezg"
Content-Disposition: inline
In-Reply-To: <20251106-kiwi-of-total-valor-b27f5d@kuoka>


--rpd4xM12kh0gtezg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 09:55:17AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Nov 05, 2025 at 04:27:17PM +0800, Enlin Mu wrote:
> > From: Enlin Mu <enlin.mu@uisoc.com>
> >=20
> > add debug info. sometimes cmdline in dts is too long,
>=20
> I don't see debug info here.
>=20
> Please use full sentences, starting with capital letter and ending with
> full stop.
>=20
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/su=
bmitting-patches.rst#L597
>=20
>=20
> > developers are not aware of the length limit of the
> > cmdline, resulting in some misjudgments.
> >=20
> > Signed-off-by: Enlin Mu <enlin.mu@uisoc.com>

Also, the email address here is wrong, there's previous submissions from
Enlin Mu <enlin.mu@unisoc.com> which I expect is the same person...

--rpd4xM12kh0gtezg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQxnsgAKCRB4tDGHoIJi
0snXAP961uID3hKt7MnqYlHQFFZh2OMo3vEi2QrfkqJQhOq3EgEAvCV1PHsyFjj2
MXt4lIFiWX6cPi6Ya/kiQ2vdnDpPHwU=
=5lkJ
-----END PGP SIGNATURE-----

--rpd4xM12kh0gtezg--

