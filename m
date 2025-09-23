Return-Path: <linux-kernel+bounces-829526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC82AB97456
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47BE4C6C90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05552FB0BF;
	Tue, 23 Sep 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMdqnmjJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F972F9DBC;
	Tue, 23 Sep 2025 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654192; cv=none; b=FmiouYGWAUHTtNhYnxMkoLXE0lXhDmYswpYuRYvveTh93l5CiXs7hBwD8LdLv8lJfY/K9a2rPP7WufeSJ7zJYn8cXT8x+cgyoco+cTllbrhs01pPLsIPQ4/EUORaMRwSoFvvFnRp+GX3FF5/Zd5UeKiSBEdkqntd/Vw6YCvmFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654192; c=relaxed/simple;
	bh=GQovJ+tNjnHEbtjE3fqhinsAq51XF59+L8jYl3tc8tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je8/ookVLMlqw10ONdpxj5gxf6/F5l7SJdA9Jbr+Je38qne6vpob6TQgnoxxDKR/4dpJKkdR0jOIxQ9qNGzR6T+CLZYN0pNtaz9SQ7h1vEC7U2MrvCjZ4O6/G00KM6eXT9gtmaRnLKhDQ4UCnsRWvHr67Wqf4CStmNG+S8Mam5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMdqnmjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CD1C4CEF7;
	Tue, 23 Sep 2025 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654191;
	bh=GQovJ+tNjnHEbtjE3fqhinsAq51XF59+L8jYl3tc8tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMdqnmjJvyst9mXKv2Oz/GqWT7PbqsHc6UskRZmBCjjacY7+s0lk3cpYky9J2vHWj
	 mlhFtSSj5mqSc9eMzNl0AcmFoH47Gt+PP57QLfa8nzRS2cLHBHmg2BaVfMQlwxlOeS
	 1Wdnb/HAuiySSR6S1QcFTFr62QC16QRnBh2BNAbviTAd0bOigJ1G93L4/y/wVzqsap
	 M5vP5eq0j2zX6Q00fP96gcG12I1L/Dk6xFPdysn493j4JEQt46KqmtSJSdDniQ1MmF
	 /HB9/aFuAjITmOiwHThjSbsI9bYeaWYjsl1QPFpFZf/kbgcScGv6j0Viq8u0RVGTsN
	 kT5IVQLjnoi6g==
Date: Tue, 23 Sep 2025 20:03:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, steen.hegelund@microchip.com,
	lars.povlsen@microchip.com, daniel.machon@microchip.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	luka.perkov@sartura.hr, benjamin.ryzman@canonical.com
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: microchip: Add LAN969x support
Message-ID: <20250923-unrefined-unending-46a18ade4e5f@spud>
References: <20250922142813.221586-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O81sTwabR1dHiVaj"
Content-Disposition: inline
In-Reply-To: <20250922142813.221586-1-robert.marko@sartura.hr>


--O81sTwabR1dHiVaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--O81sTwabR1dHiVaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLu6gAKCRB4tDGHoIJi
0v0ZAP0ZpyW9vIH0uwSc/iUk4ucE8reF6Uc88m0UG893Co8gOQEAn3D16kBXJfoZ
OPtu6rcckdIfyv9TbyZIc6cq6U2zMgk=
=WqRO
-----END PGP SIGNATURE-----

--O81sTwabR1dHiVaj--

