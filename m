Return-Path: <linux-kernel+bounces-840649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB2BB4E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0E719E1856
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3EB27816B;
	Thu,  2 Oct 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCMIE4Of"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68A148830;
	Thu,  2 Oct 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430082; cv=none; b=LOT3WVvHljsyht7J4YVanW2AAUHJ7IHxsAuwUGFVVP/2aFpOaYgYcY1QvPLvkv1F6TTE7PyIxUrT23v4nhU00y9lW1elJIWBz7YbHfLk4t8riY9CBuNmHuqDMVpQ6ZkXr6MgrnWqSR2t2uy9aaIofqO3lKodGSrXuOQFUjf5XDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430082; c=relaxed/simple;
	bh=8QadHtK76xk4ojZ2I8UXgazGkZuKAIYzIorwaRYb/ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOf/7kO7dggleQfz6a7/CNOfaiF4Tw6uY/4XWJu6R3Rz9RnPFjQYBz/hzsKADflutzkD3ynoF+hRaDJUyO7aXp7SHraqB6IXNVVzoU7HSGgvj7Tqo0TPQgWkBaUbQuG2eqR6d2rAq+8nIjMdOvGnGmGSS1lVgqShflyYAwDuRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCMIE4Of; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38791C4CEF4;
	Thu,  2 Oct 2025 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759430082;
	bh=8QadHtK76xk4ojZ2I8UXgazGkZuKAIYzIorwaRYb/ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LCMIE4OfLvMtRR1Bmrrc49b2t+5fGcVe0ZqBlfoudDDHRBVbyLj6lUUbSk1Zo6Glg
	 YO2E9mFdonMQt9b9DP9X1yuGw2cuLofxarolf+oRBwuTy5L02Yto3SAjGtemg4svcP
	 LYdtnYjNldDairMa/p/5Pom/PE+DZMO7hXh9qWeseMYllDG51KTfmiFopd9kmxInNP
	 SuyEAGygk1bcn0OAigI9HazpeXIvymXHdR691hXpiANUp+EdVHEtDzMpa/no+4AJMV
	 0etEnbA0tNXh25ESaM0v+jZdk1feCvfvUiEbf9+S8UL74c+cnrDAkw9LOJygQwq4th
	 fWXN0rDew83rA==
Date: Thu, 2 Oct 2025 19:34:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: ntc-thermistor: Add Murata
 ncp18wm474 NTC
Message-ID: <20251002-atypical-volley-9f7a43ae0e72@spud>
References: <20251001-ntc-thermistor-ncp18wm474-v1-0-2c64b9b509ff@pengutronix.de>
 <20251001-ntc-thermistor-ncp18wm474-v1-2-2c64b9b509ff@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wEeOnHTcu7inyN5w"
Content-Disposition: inline
In-Reply-To: <20251001-ntc-thermistor-ncp18wm474-v1-2-2c64b9b509ff@pengutronix.de>


--wEeOnHTcu7inyN5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--wEeOnHTcu7inyN5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN7FvQAKCRB4tDGHoIJi
0j55AP4iY7j5aCsk9Ps+Hqg9dXmjJZHlM3onf3q9fe3TT/ihngEArTFF7yDGQo0J
V9mpv/2gS9C9UHBX32eWAv7DcN/h7wc=
=5Mtf
-----END PGP SIGNATURE-----

--wEeOnHTcu7inyN5w--

