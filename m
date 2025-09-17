Return-Path: <linux-kernel+bounces-821557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43415B819F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166077B7739
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5AB3009E9;
	Wed, 17 Sep 2025 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o593B8bh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401E223DCE;
	Wed, 17 Sep 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137263; cv=none; b=dZSMmbEM/q/JgSPcd79pDF+6mKqhtYTj4sUjnSGQkVhN7eK4z603tBmxHwCdwRn/MM7+oRw/Wf3QXjXtWP4JGRXYW3qVTfQQ/v90UGmjloslgCnuGRdSa65C013pvwvbWw2JrVAayspqtkwViZImNRiiJoIaFqWKtMeJFUl9dJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137263; c=relaxed/simple;
	bh=gr3F9g/r13IbodjkbswahgoO+gHnOjod7V4voFnQTMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phBpMgCKCtyTHZThHxSRPP5FhcZp8HwGLHkLnjzMgagihlFDS3raqUXgt08qGLhX/82HBGsmCvZvpTkE+ozvqoCJN/3cZygOlDUfMW73kCM0iRtEusXnRG3s7aGMNr3rhDJ3OimGwJcmgKP7zrm2Vz+gTfT7y93JCQnsVVVkDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o593B8bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F9AC4CEE7;
	Wed, 17 Sep 2025 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137263;
	bh=gr3F9g/r13IbodjkbswahgoO+gHnOjod7V4voFnQTMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o593B8bhRSTEOjlj+wGHK1uCJ5fOkOv1NZ0b3Zc4xrlHoPteX4c8FuwXmyea3lKi0
	 xx4Dwqgc/qz0is2U2wsj6K2uyW0IfkZdxrOz1a+m3QlON7xkwZTo5XPQWL23hcA/pX
	 C8CO1Gc0z6eMH9Wr5wbL/RSqwzPcaEPsaiGkoZsuPPBvU3vDH6WzchAFrLtJi1h9ew
	 QhcszbpSHUUbMdf5boE60/ZJavCDUmmkYCf0xQn9KvjNe33vGFVpsZq5pLHup4hdSJ
	 OjR60akzeJssaNRF3Cu3RiOAIMUkrAwSaH7QGqdXTRO0bpfkazW16cOZUvDZ9Xo1W0
	 FWav0Up9PrmDg==
Date: Wed, 17 Sep 2025 20:27:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
Message-ID: <20250917-removed-grader-328f0a71bb73@spud>
References: <20250917075156.4043936-1-kevin.tung.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iJ0kmrmEVtt0EMQV"
Content-Disposition: inline
In-Reply-To: <20250917075156.4043936-1-kevin.tung.openbmc@gmail.com>


--iJ0kmrmEVtt0EMQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--iJ0kmrmEVtt0EMQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsLqwAKCRB4tDGHoIJi
0h+kAP47tu4UOEsK0a/6ISyjquXeGZE2vnuhAzzB52b1McFerwD8CfdmMddHrJuW
QtdHkVqKuD2OiurAWDrWSuXMWIdiEQ0=
=4008
-----END PGP SIGNATURE-----

--iJ0kmrmEVtt0EMQV--

