Return-Path: <linux-kernel+bounces-838076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB274BAE5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2CF19455C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023BB279780;
	Tue, 30 Sep 2025 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAdGxYHD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256E2264CD;
	Tue, 30 Sep 2025 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258485; cv=none; b=rfSw/1Sq9r5Lz/SFwNHBtTIRdiTN0ja7Wo6x5IC6RlhQaf8ugEV1VEgyM7h72xuZIuePWBq7L0SdZt/DgSh94ggnEXphCHj0l1YtapHfJjdMs4Hp679MI7ihdk4Wamlyax7zxlIuDOCosMQfstxzKuKziL7SthNOKzw95Yo2flY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258485; c=relaxed/simple;
	bh=xUGmTIz6u8GX3Wr3xEigoJleWwBWSEWZ7u+YpP3wnbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6zmlO4joW0q4KNzlhtABr4sqA/Zaibk8stMdMClDPHriWF7Us0HaAiXjIdtm4BDCZe8uJvDsV7zRVSedHmSc/M2w1ZNK+6P+m2S4XpTZkk3MFxVSgImW6w1rM3iloQaQF2BlZux2SF8FiquiOWV17eWTiq+nAg+HB4B6h408EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAdGxYHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FB9C4CEF7;
	Tue, 30 Sep 2025 18:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759258484;
	bh=xUGmTIz6u8GX3Wr3xEigoJleWwBWSEWZ7u+YpP3wnbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAdGxYHDxt425uCj5q7pFORNOFCshK50hngCZZMp0NoYrDS4H4DIuPlQd5+j79hsd
	 ii2OQ9MWX+5+nnZ1K7B/TG5bydoINZ+xgSKkq+e7OaA3XmNATJMn6EwujbehUM08ij
	 9hT5pccHwBUGjjnWoNcwugm1/SPgQHgJaVdVbDEhVcnCI/5nheEo+1azpd/fOgOoYs
	 vtaZEstgOFyulhr8dQGfuEEaeY0VjMjpzp10MO3EW43+zuEgnr7LBJ+nEeJwjkRa2/
	 wsvlJggIhcZx8s2Z8SG8ALpymc370CSJn7FdEg0flSg5dUjTJTOdvwRl+F3kh73u+H
	 VHGGUSroYb8tw==
Date: Tue, 30 Sep 2025 19:54:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pmbus: add max17616
Message-ID: <20250930-preoccupy-wikipedia-d84d8d4577ba@spud>
References: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
 <20250930-upstream-max17616-v1-1-1525a85f126c@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26hKMU1veQBw+I7e"
Content-Disposition: inline
In-Reply-To: <20250930-upstream-max17616-v1-1-1525a85f126c@analog.com>


--26hKMU1veQBw+I7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--26hKMU1veQBw+I7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNwncAAKCRB4tDGHoIJi
0iuIAQDGG8sD5uGW9jhA/pQ12M8Pf2HZ7sStv6PcwRQHhzOMMQD/cFyw7kCadlR0
+rDB0tGGeLV4mXFOKA8MShU9BWB/+QQ=
=6okX
-----END PGP SIGNATURE-----

--26hKMU1veQBw+I7e--

