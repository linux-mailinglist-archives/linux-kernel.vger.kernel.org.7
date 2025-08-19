Return-Path: <linux-kernel+bounces-776284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E9AB2CB51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2D83A9DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A4830C359;
	Tue, 19 Aug 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHKIV8jU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D82E22A0;
	Tue, 19 Aug 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625577; cv=none; b=fXg7Nno5Y8snUmmO4U3L2d3eEIaO4ZB0kBgOqd/Hdu+HxBxreN9Ad07/PSgvXXyxvJtpGAFvUEgt295AO6xAbkEQL2/ofm2HO1RJUrnoQ9IuvnwAim/XDwl73SSU9qRVs8tfos5wmtUcI6Dns933DPc+vkGxRqzSzaYfG9dGes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625577; c=relaxed/simple;
	bh=ImNqnzWW+9w9BxQLnC3ZvD82tjRDoNDHtSzzNgeOCzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKCM0Kf8GTOM2/xQJA0wSJL2gZHDVXo+r4tzoFsi1o9ZPo6jvssOXoLaDmiLerFPZBWrF1Azm3hS+pXGq37jWQiFgj0/UpXPF5+K2eePAve+esqmdVw7/SBEo9acKOdOgwacEczmLiLjB2t3MwVGKiaa3zkwa6J7mEH2+dXmhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHKIV8jU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFD3C4CEF4;
	Tue, 19 Aug 2025 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755625577;
	bh=ImNqnzWW+9w9BxQLnC3ZvD82tjRDoNDHtSzzNgeOCzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHKIV8jUMwsAWVEyTRPQYe2JrqREOYrKKGYGK1/hucnGGtvuwJFic4n/fuu0J7AKa
	 eRY0GzENfilScdchr8j631HB0bsTdrctytdU00q3UeS6HnbKby0bPGc6DUk7apJ6EA
	 kOA1E5dnsPpejkY1sexURA1vT2GGaKtHZwXjDSYqCEGGT+m1N5v6CJIhgvDKtKt1mQ
	 hIskctxhLynmpvXLKhwjlRTD1CLFXetAO9BC6vSYd3tyRdLQM9gY3ESSF94qIZwcU6
	 QmMXOvrb79Nl8fcAamVHVobj3pZFgv/UcI4nVD1AfwhYpIpk6RzThVQRD9P2DPe+Y/
	 pwKtAUWZrlYhA==
Date: Tue, 19 Aug 2025 18:46:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Mateusz Koza <mateusz.koza@grinn-global.com>
Cc: angelogioacchino.delregno@collabora.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: mediatek: Add
 grinn,genio-700-sbc
Message-ID: <20250819-lash-overbid-dd5d5c365811@spud>
References: <20250819130231.181571-1-mateusz.koza@grinn-global.com>
 <20250819130231.181571-3-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jirkf6aWu6p0wybH"
Content-Disposition: inline
In-Reply-To: <20250819130231.181571-3-mateusz.koza@grinn-global.com>


--jirkf6aWu6p0wybH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Acked-by: Conor Dooley <conor.dooley@microchip.com>

--jirkf6aWu6p0wybH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKS4ZAAKCRB4tDGHoIJi
0mcPAQD9P5ITPsJbve0AaJea1vqiyF4opZjUDdaHv6LL4uGiOwD/YhOB8NAiCzSo
meW2/u8QMm0VL0EhdPfA8ww9sfRNsQo=
=15MS
-----END PGP SIGNATURE-----

--jirkf6aWu6p0wybH--

