Return-Path: <linux-kernel+bounces-833095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EBBBA1346
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC43C17F18B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE351DF27D;
	Thu, 25 Sep 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5CP6iNP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E902E8B8A;
	Thu, 25 Sep 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828828; cv=none; b=PuMJCAGC3ll+dRCoFKuwFGGOq1SVN9YF+Y/vW2IJojvyA7IKouvltPESGOc/1Sb8PrKAMmmvjf4zPwaI1VcORZpZBz2QasJWRCyLV/5bA3erS+f71QgrVe7w+EJCD6oLZTRCQ2jommme3UQzG1JJbpv+BxIZm3fxqVWuODtipwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828828; c=relaxed/simple;
	bh=EigWim/UCRyio9RFX5hRbRTRCkh1l+saIBXI4z48n2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maE9DwdMupcccwUGqC80DwihxVK9eGLuCrv6wlIKNUFkSEbYMZayRRe8RsLrnmiuN4fNjqcwkNUwvAIvNmy+FNDwSPwD31sYcuEkfMVAIliS2zkYkvzM2kWH4r6mw98HHw3uTQrxE2F6qxWzWw3jP07AHx0Z2gbY2DseIKb1zKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5CP6iNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BBEC4CEF0;
	Thu, 25 Sep 2025 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758828828;
	bh=EigWim/UCRyio9RFX5hRbRTRCkh1l+saIBXI4z48n2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5CP6iNPFDvReVrRJGzQGei305a35Ubk4kZ768shgeIOh6d/vQwmadmI5CfaanV4a
	 QNf9f9s2UAWX/scBvu3qbpzxzpBzQg+oPGWQE8XsKjI8VzQrzHKyaByw99JlWRdMtI
	 o9HNEX3lkNUw1MP5wAhlcGKSCehSRp4izvnBwXrEFZoCEfNT5weZAJgxkIWXGTRhW2
	 gh6sEcAEocM6FS+o191bVd9RwD62qYB2m8JhEd/zqkNotU605FD3qjFMwtWsg3CrXt
	 JXNwNjEDKAJkfdZkC/ekjuKH0O+8aaZiyLukPOdsEeu+B9gZOg1usAOA396EBMO5CE
	 EM473XJ6iAg1A==
Date: Thu, 25 Sep 2025 20:33:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Liangbin Lian <jjm2473@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
Message-ID: <20250925-renovate-willing-1913bce7d347@spud>
References: <20250925055906.83375-1-jjm2473@gmail.com>
 <20250925055906.83375-2-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6q46uqyUhMhBcI7Y"
Content-Disposition: inline
In-Reply-To: <20250925055906.83375-2-jjm2473@gmail.com>


--6q46uqyUhMhBcI7Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--6q46uqyUhMhBcI7Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNWZFQAKCRB4tDGHoIJi
0tPbAQDluKdmaxZQBuZPp5RSMdINmjfLQvVz3r2Pj5NC9W1UuQEA2gaDbkOjgB94
m4r3xrc2DT2pFCg3SgfT6s7+3UdRtAM=
=ZY2/
-----END PGP SIGNATURE-----

--6q46uqyUhMhBcI7Y--

