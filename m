Return-Path: <linux-kernel+bounces-864791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D00BBFB8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F17F4F71F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58197328B5C;
	Wed, 22 Oct 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="bXI0pm5f"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFB325480;
	Wed, 22 Oct 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131360; cv=none; b=KRRBXqNp+hJyu8quXs+5IPPjHN8ToYPtBLuiuvi39xAL2cDQGJKZnVbylKmXrEtmQHHfy9bIOCrsgMPsd+jl49JuEb3vrYmIBOAC5CjtjTIL5g2O/SzL11hq1fbmUmM6P6eJIpwXHx5cUmb3FghxniAzmHeipBMT9Muw84/jZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131360; c=relaxed/simple;
	bh=T6ODlUJlWqezbW19E58MqGoWcwokpjzZaYfBY09YRm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b11YC4k+gwynI49qz/cKgBZ+69sZv/fn7yL/9saGUo+uAJdnbmEc+Km3SElktAljO762jibilL16vvqdLDETXnMcZ8vkSiH8r9Ehx0/JefEqhXLtp3+NnXonwvmHaWLJeLpUxSUcbOuoyaQ9sRwUQG0PhzcBXNjNL+mF4WTJLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=bXI0pm5f; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BCE621C007C; Wed, 22 Oct 2025 13:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1761131348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXWeJp8S/bE9DbKcDmsGycphOVF0L6UeyUVsirjFKfU=;
	b=bXI0pm5ffnL3+AJ1YDq6ByzhIzqDhW05PuGzaAdxOQGYl+Lm+AlDz3MdQi/I/eW7Tv6XzO
	RmC0EpXSaaCAwgwuNslZNdcqcGmnFxrXxXBX2D1AuAZ3qr75U/Xh8jhnIalx/tD8KlfQqj
	qS6ZLSXwMO9JYhBYy6XoND/5z/tWybw=
Date: Wed, 22 Oct 2025 13:09:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: guptarud@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
	Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
	"Leonardo G. Trombetta" <lgtrombetta@gmx.com>
Subject: Re: [PATCH v4 0/4] Upstreaming Pinephone Pro Patches
Message-ID: <aPi7VAZEDnbqdvG4@duo.ucw.cz>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="akbWoOZumakbWuit"
Content-Disposition: inline
In-Reply-To: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>


--akbWoOZumakbWuit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Throughout the years, many have contributed to the Pinephone Pro (ppp)
> development. Unfortunately, these patches are scattered around various
> repositories in different states.

Thanks for doing this.

You may want to cc phone-devel mailing list.

BR,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--akbWoOZumakbWuit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPi7VAAKCRAw5/Bqldv6
8tMBAKCVnJToNB6sKoye/rzIFyxpfw4XXwCgkvYgDCeaz2VqXgPd7DgxxwCy93A=
=MQHp
-----END PGP SIGNATURE-----

--akbWoOZumakbWuit--

