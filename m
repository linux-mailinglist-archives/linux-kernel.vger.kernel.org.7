Return-Path: <linux-kernel+bounces-886180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B72C34EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C90189B14C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD473043AD;
	Wed,  5 Nov 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ec94UAmH"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B71EA7FF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335827; cv=none; b=auu0qQrDB0C4Iwd2ep3aiW3xu2k7Jn/CkXbJ++5qo5kBmLCug5xW1pIzYd5LACfM8Uzt1MjbVeLeCPm5AGxokc+49iAqzuN5mvqwFYCaCH2q1T3WcB9vY5AgYFgLtnfkBcS2v3UCOzcrF+4MYrh0eIbmwtfaoqHjtL0J/+Lu5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335827; c=relaxed/simple;
	bh=ZPdvryT7qhw/t3FUbdnKt8pRhR93yULtLAF828uGlRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVWLBnro0M/lDJlxk5xzf0W0BpC+4Pp+HTrdaEcROI+LJqt+Snw8gZ4M1FrEBbCCD204uQ/OMmvwGT9kH0/PaRCpHz3lOcp8iFXLLQTHXY0xf1sOXW/YudNsaXP+rE6AL2jRansTrxNtecgN3FnKjs4WOVoxSUsUGE/jbiq35NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ec94UAmH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ZPdv
	ryT7qhw/t3FUbdnKt8pRhR93yULtLAF828uGlRY=; b=ec94UAmH+VfO0dljedGk
	I6WiKY3aoICKdt8Fc22R910vF/rt/YpoZXmZelzy/rllYeTmCbSRBh1KCHZhG5mP
	7ALQ9ntZ2JPmw3HOKyx1DfssYHnSDR9xyPyXPyzrQYg+YGTXd5PDP2DrEDAfzNA5
	hrkiPBhz6I8atYOdzZHg1AX5ko3hievUqIl0YDPbl7f3+aGmUapXlXoEhD24WZBe
	qzO4Y9Vhywl/n7GWpS8rBCUIW3/bprdPGokiki6PD+oKxw1hCYYpCm1Equ6zdhxo
	45SErOnACHSld2yb344/H2YEgMkKyDSSzjfpOyCh/PZkJZyJQzT4OJC0Q/BhB/Cu
	lg==
Received: (qmail 3007516 invoked from network); 5 Nov 2025 10:43:32 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Nov 2025 10:43:32 +0100
X-UD-Smtp-Session: l3s3148p1@mgwLyNVCcIoujntX
Date: Wed, 5 Nov 2025 10:43:31 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, kernel@pengutronix.de
Subject: Re: [PATCH] Revert "reset: always bail out on missing RESET_GPIO
 driver"
Message-ID: <aQscQ11833v-AxaL@ninjato>
References: <20251105093920.2345333-1-p.zabel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uFi3Jsp3NpXtxYvb"
Content-Disposition: inline
In-Reply-To: <20251105093920.2345333-1-p.zabel@pengutronix.de>


--uFi3Jsp3NpXtxYvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 10:39:20AM +0100, Philipp Zabel wrote:
> This reverts commit 25d4d4604d01eb0ce5254f0516826127dacb5015, which
> caused unexpected fallout:
>=20
> Drivers that handle optional reset GPIOs via the reset controller API,
> on platforms that have a reset-gpios property in the device tree node,
> would fail to probe instead of falling back to either ignoring the reset
> or handling it via the GPIO API, if the RESET_GPIO driver was disabled.
>=20
> Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you!


--uFi3Jsp3NpXtxYvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmkLHEAACgkQFA3kzBSg
KbamIQ/+N5XwQVTbhoDyyc1ntl1sOogEzBw1BPli1g5MowXfyuJ5LaA0R4g7NTX+
svGmwpPUCH+3h/UyDAQmpys+0xm3JgpLJ9q/edLkV7daLl4t2HQkiTpUZR9xMfeb
avtM7FG0ffceuA0F8C4QYTmQkb7icFRAxrw06hZi+w/BM/cBjtDPp+BO70Te15ZU
mLcW9CAzqrrBlTCqqoam328nsxSWIWsX4a2IwlOzHG2+SpN+fWhQYyES7oLhRCHG
r9qboDRHuarslk5iFmXHQoHxL3L/RxNg9FLheXBhf25K80CfjLhNvUiEqK0t6RdB
6EXz7M+rUZp/Rjb1wKg7q9mam7c5qnyFAzxN8th0gDzBU0x4V7TSYRZpAPWFG8RN
cTboTgBqbZTZj9j/lVtzBYvTSI8slJavYpRtmMJj0IBFSfWqTda8d6MpFho9sYQ5
WHxEAVAp7QZF2vXnaI0FSHt9i41Ra8jzvr2HQvz/VzyI1BVzE7cTrGvr/mCdNedL
XxyGj52ODA4ze3FteDdFKNAdu4LfPY/Ujz2lTV7GslbIMI+N5n74eTBAgwMrDSa1
c4uKcFdQD64Dge43sZAmUlgympdf6yGie/t3Z2Ce48WAAG7uOeWST+tiT0hX3V20
geZlDvDzjvgcAWu32L0olATal48hciaDOBhX00TR9lpQjStM7Ng=
=jAMh
-----END PGP SIGNATURE-----

--uFi3Jsp3NpXtxYvb--

