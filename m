Return-Path: <linux-kernel+bounces-586436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD52A79FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD4016333F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED642243953;
	Thu,  3 Apr 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RsuGgUnu"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49C24166B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671748; cv=none; b=pN1WxmTJ2wJid6VQXQLOONzeQGp9v5/W6Q9MBzN/X4KytUymAvRNnuQx5RwI3nfGoJIawWvmGwbCkzFKje1sCIWe7mYt7zWbWqbDLkI/gXWq+0y6ZbvsSirIl39/6z7hpQN91xDsPVHMElGFsOjrS5RHPzx7qFRC6kW906meffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671748; c=relaxed/simple;
	bh=/W6Oq+uRKx8sjmUE6WWpPpy7/9thm4C5AbkdqZ5kKkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRMG8ECQ/njG141/lPGzzecyJRKBJfI19UWeDq6DwhymWZWV39R+fWDvAG5AoZ4+019612WOVUehV6RLq7XLHhHg7/w6+74zt6n4ad5Rn9i4TxNuARhyfmBk6R2sGlfCksacqMgo/6eN/MIJE1JDTks3JwzLglY6Bzr3JT5fMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RsuGgUnu; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/W6O
	q+uRKx8sjmUE6WWpPpy7/9thm4C5AbkdqZ5kKkU=; b=RsuGgUnuGbtwWHL78EgP
	+ySFojXmVAGcAll1Cnxaeyhn4z4vXMxFOFJ1XVr/d+NoBpp87xEGmcUwIMhFO3+Z
	cPyV5DlwY8hsdXRkThMMlFv5Yv4dEAluWAg+jF00VOZao2iVsOm2WS2JHoty0W3G
	LGb8jjcTvkygPzriTEOwFALlQ5NIC0PUHVA77FjY+orhZb7o5q4fsBtlFRLkdvVl
	K3UWuZpe2s+CCYjh3zGzar0odTFBenKMg6/FGeKLjSfWBk5tMYAmFZjsXA9yBlUM
	W66zKQHwYOEARHkjfiMShtMl4Jhjkj/47n055JMMSFHJxtXJI1C2j5TdYjEQIzyQ
	Yw==
Received: (qmail 2315531 invoked from network); 3 Apr 2025 11:15:43 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Apr 2025 11:15:43 +0200
X-UD-Smtp-Session: l3s3148p1@EoLdNtwx0rMgAwDPXwaqAEtIN5mYkFJw
Date: Thu, 3 Apr 2025 11:15:43 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [RFC PATCH 0/3] i2c: Introduce i2c bus extensions
Message-ID: <Z-5Rv87HSWZjFDF8@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250205173918.600037-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="40GLeQpY9lJ2c9cE"
Content-Disposition: inline
In-Reply-To: <20250205173918.600037-1-herve.codina@bootlin.com>


--40GLeQpY9lJ2c9cE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2025 at 06:39:13PM +0100, Herve Codina wrote:
> The big picture behind this RFC series is to support a Linux device
> with a connector to physically add and remove an add-on to/from the
> main device to augment its features at runtime, adding devices on
> non-discoverable busses, using device tree overlays.

I didn't test the actual feature, but I did test this on my Renesas
Lager board (R-Car H2) including its use of the notorious
i2c-demux-pinctrl driver (Thanks for taking care of it!). No regressions
discovered, so for that part:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--40GLeQpY9lJ2c9cE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfuUb8ACgkQFA3kzBSg
KbY37Q/8D8upI0kPbeS1SAgVLmbeeZwspSig3qQL7kYXkxgTDuLNzaTIMyZOLVCe
XV8YINuDzqiEeczC+FEQv5tslU6vzb/2tA7+G9nkn/d5h07J+oojMnDPIqsOZ4Gf
KZXVKQqaBingERF4K7yYj6lAENdLo/loAri+Y3RVkSJIRxPekHzJppcfjibU13Gp
rmqB4hSS+/ie9DmqKLniOD3vsrLCI+BwarqOXUV17RS/YKEJsJye32ZI0djj3Uq8
ykHknStUi+xLtVm4fIu3aLvDWMUlrLceLzywsp4nBPwMECecLj8sm1lypQNxAlnl
VEhYlq8skt7zgNrl96TIdlQtW2jo66BEGaEbr/yq3w+q4sfjRhsB5bhGojfm9PQp
8zWTwJLGwfgtidM6GZppYZ62N26wBwuAHsaAoSbEkFHu46khxgPmn6Ffohx3skGF
gPcO3xE0SeYOCM4jmFUxZIyVI7vlKsPs5rzBA/2zG+Xbq0ALyT0TtbiPSMjp3Uz+
4cHq34vSzAc71WAsbYNuu+UY/qLSNUzf2HreQIJzVJ4UVJCH3OuQpXHuW2gfmSfN
E+Whn0aOCHRFeeIb5ujKr59xadSBtP48cNZ67HMlgncbh8cf7FSlWR2wJcUZhpGW
fQlZHNgYwEuWih384cQ7eg2BJhzgJjg92OC77Q5Wq0zQqOrncLk=
=wlZ8
-----END PGP SIGNATURE-----

--40GLeQpY9lJ2c9cE--

