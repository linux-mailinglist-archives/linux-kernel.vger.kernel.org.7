Return-Path: <linux-kernel+bounces-821533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF8B8192B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDB3720A43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE5330D47;
	Wed, 17 Sep 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW1GcNNW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A72FFF9E;
	Wed, 17 Sep 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136641; cv=none; b=t3qxmBfygiRCR2ZQN9euGvWDAxfs/JF4fYrJWARpzwPNZSUMPxiS7OQ8oNewqhzE70EYnLObma5/S5cM47E0rPHYFxdJapLWlp8zAS93mLWXtaY1PoHbjVoOV92kx6JDz6i8/tUDiTxBGNq8Pje0p+DnAEApc8pjSNFqRGTXi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136641; c=relaxed/simple;
	bh=u3Am9CZijzheAJRrJMo40O044w6jv7P7hbe11u4WcaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS5AcBDTISWO6aQYH6AYulUf56/32Sv9DsiBWWIfD+N1x51uiuJtULekHo70IL5kk8S9RJYbM1OXuv+SwyA2Ut85KAv1oG6vQMB9bOU4wW7r0s62qa89/k0dSTNeugkE3LOxEapp3JzOsMEKaAb8Abqwpe9/sqPPaSZMvfQsU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW1GcNNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74744C4CEE7;
	Wed, 17 Sep 2025 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758136640;
	bh=u3Am9CZijzheAJRrJMo40O044w6jv7P7hbe11u4WcaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MW1GcNNWlRPw0CLjtk7TbSRXrcmpzpiwCmx2qHA9ImM0Yt1nmMDeQ+uY8a5n25+RT
	 dRiEHOMjWeAJ1iY9m4uwgVdDzvpTANohnpo5ryFeX5LIdyT0Wh1H9KTLg6bURSNMH5
	 jz+XKpHrYLgwOX5G9Y4IjJJ5z9JWMdRWivyI/Cy4EYoec3+v9SiU8aK8u9a/3HB4uQ
	 fTFRSIaDvd/2T0z42yUwVHI10Gjm5q3hpKo0p1Dg/ngnGEtlJ4XFIuhwurrtKJsfi6
	 HG05sHoBZIs1Ghf4UIZSzyG/J7q1sHvRIsNXmLCki/8+sxc4jhAZ5jTVhzxmGrVuJK
	 OG0DdLL84hRqg==
Date: Wed, 17 Sep 2025 20:17:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8
 board
Message-ID: <20250917-upswing-paprika-515d88bdc6c9@spud>
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <20250917180428.810751-2-rebecca@bsdio.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="evQnuMst3vf9IghK"
Content-Disposition: inline
In-Reply-To: <20250917180428.810751-2-rebecca@bsdio.com>


--evQnuMst3vf9IghK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--evQnuMst3vf9IghK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsJPAAKCRB4tDGHoIJi
0oRPAP9UJ57vJwVYjF7FY8AiEeYNHjjJsfTgCjQb95se9aB1LgEAnwvvzR9O6Qev
0yJLKjluBiyy80DVqbCAxm8AgQTA9Q4=
=U7SI
-----END PGP SIGNATURE-----

--evQnuMst3vf9IghK--

