Return-Path: <linux-kernel+bounces-819463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82703B5A105
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C7D46017B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113712DF14A;
	Tue, 16 Sep 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xpoy/I++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619032D5D4;
	Tue, 16 Sep 2025 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049908; cv=none; b=PzihxJFzIChuiYQmUunrx1e9rNwVkQXXiqaCsWZ9bQTlzYhzPOrUk02PEU986LPCCDmrN4eBtE/WnMHJ34asRjfbKOtnwmLXm4HZcNQ/h9KLvJ9g60/AfYojNdfqS1P/m5cYVpiBJy1l7FrgPTHhaCJ84ekH/8zG6DJdi8AcfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049908; c=relaxed/simple;
	bh=77LfXigEtGlbgD9o+XCEovUBSCV7wv0QPbV2QyOTQ74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl0ktaAx2G2qbE37WTSBuF9Jc2VW8zC53JOl5QjQoxFtAJLuof+KyCICUaqMDaFdgySI+MY/FEHwrNMvsTJW4WS5JLF0bQXRuCN1ysjSBqLTfM/7uVYwl2DWcctpnNUgWORgwGf3e0RIjeEYYksi1YOGqaRQZAaK02dxITkRZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xpoy/I++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F31C4CEEB;
	Tue, 16 Sep 2025 19:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758049908;
	bh=77LfXigEtGlbgD9o+XCEovUBSCV7wv0QPbV2QyOTQ74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xpoy/I++lGP4rRlLa+mbG+YXAQcVFWba92OSiuz6fksltvX59u6uUZiU0MqRbTAK4
	 1bBEGJ5alG/ARQintuFBaRx1v6jb4L3uM0Go0xzo/kVYZPPhRDst4UV6WSA/dwwTdP
	 nO/PhE/kIHj66LcLqrfIG9I69x00Qs6nB+oQL8/7weTODHjg/H9m19IYSzU5DXpntC
	 3iAK7sufS9Bm5+zkzenff1IJb57AJMbWOqgRjtRQl4H0wFjNqDh6rITBoFnlV4tTvU
	 SHnrlYB+kV0ZGUOSKCU/ypaBBNX7DPRuLSXUtdHglNa/v74nG7lyib5pNTq//6E5Is
	 01JquE6PHMfuA==
Date: Tue, 16 Sep 2025 20:11:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
	Amir Dahan <system64fumo@protonmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: display: panel: panel-simple: Add
 lg,sw49410 compatible
Message-ID: <20250916-lazily-postage-f673a5cc6a26@spud>
References: <20250915-judyln-panel-v2-0-01ab2199fea5@postmarketos.org>
 <20250915-judyln-panel-v2-3-01ab2199fea5@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0DFJbOukSxWiYyHE"
Content-Disposition: inline
In-Reply-To: <20250915-judyln-panel-v2-3-01ab2199fea5@postmarketos.org>


--0DFJbOukSxWiYyHE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--0DFJbOukSxWiYyHE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMm2bgAKCRB4tDGHoIJi
0saIAP0Se5/ZuR1n68jiyM3j4srO+TBLhsWyZ2N+aqiYkKml6gEA2nMhDo+He3bJ
NbVdDObz6e5yqG1+j59AkbmHVZCkuwk=
=rbRy
-----END PGP SIGNATURE-----

--0DFJbOukSxWiYyHE--

