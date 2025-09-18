Return-Path: <linux-kernel+bounces-787119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEB8B371A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC07B042F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E17B29DB88;
	Tue, 26 Aug 2025 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ2kUkx1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366623BD04;
	Tue, 26 Aug 2025 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230409; cv=none; b=PmxRvpn5KY/fI6XaZ0MxPKRMSxI7HKdvBmxaN1NXpI2i2QR2lRPIafn1yRvhRAJAj+Jd4EkrLGL0mgCmFCZs4aBtqy8TQKy76lN0h4Uil+VROtL8CRb4MQxqUNRcdt/3xJINLeQlLKGwDV2REIqxlIceEF66l/wWwZYaB2vNjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230409; c=relaxed/simple;
	bh=3KcALkgM0uKITZAzs7T82minUod41zAeZiPW4uBaeiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbGU/fveQAsIFnSRMtMzQYSart7zKusw77Zp7CSXuPzchOCukwD3bq79qPAewG0YscWgLl7EjA828WAIxvmZfh0G420TL9lro7j6jMmE3DHTi+XrjCbhYNvHEnCEgMZ9NMIs6OhZw2LtyJUNKrYnnVk7ZKlgm5qwPz/Yj7e01mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ2kUkx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F8FC4CEF1;
	Tue, 26 Aug 2025 17:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756230408;
	bh=3KcALkgM0uKITZAzs7T82minUod41zAeZiPW4uBaeiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJ2kUkx1SdJMLsKsoxOnRVYB/71Ruk9EqCYq4aq1lL2OXaKCcSiMkfCQtDCOizUHc
	 BWmD+Cqvd2I2/R10OjQvpJpRn6RiU3FVwbyX52225gJekEvcxnTiqjMygUgqe/a320
	 xUtvEbsN8Y/nflVjP8szGelLRqDh6+s2awthAAGxL8Rx9WB083fOUG6K2XAiacbvYG
	 523ZcLSJnX/TKrPaBWFaxGtWQLu7HJf3FQBiGtlkVOYrKzwjRKbVdYddpMRjFEdRJs
	 m6k4dFoPEdBLX4gc2jyw4TK3NpX6EiIo8H7AyCvSZFkF/qqQKr2BWEgSxK33mxfpmU
	 VL6QzG50v6A0A==
Date: Tue, 26 Aug 2025 18:46:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/4] dt-bindings: omap: add AM335x-based TQMa335x SOM and
 MBa335x board
Message-ID: <20250826-sage-tinsmith-3f39cf4428ce@spud>
References: <20250826140853.2570528-1-alexander.stein@ew.tq-group.com>
 <20250826140853.2570528-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OpUx3LZqjKjS37ix"
Content-Disposition: inline
In-Reply-To: <20250826140853.2570528-2-alexander.stein@ew.tq-group.com>


--OpUx3LZqjKjS37ix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--OpUx3LZqjKjS37ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaK3zAwAKCRB4tDGHoIJi
0nckAQDXBIRM+YWOeoanzxGFDdwpLFKQcTKyiQegoUiHXhSMLAEAgpbnbD2pWsyz
MfdC+slgOCfriwX0i6d36j0JyLzwAAk=
=Os2L
-----END PGP SIGNATURE-----

--OpUx3LZqjKjS37ix--

