Return-Path: <linux-kernel+bounces-825016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE915B8AB78
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5419D5A55D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC2322541;
	Fri, 19 Sep 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4hS36ry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88663164D0;
	Fri, 19 Sep 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302085; cv=none; b=f1Alh+mgRvnVLQPHRBZEeI3opfQnmowtOkrutxtKqKalzq0clZLrDYgO3TXUzSphFyGHrjVvYDfD0uRgCZLZNH82ajQhqOByVn1TvArtyjJfDZdAQGDe2Dt/K6x6VyZcsHQRY6gx2Yjb3mSR3eS2OTptMn9OFpreoCCcl8jPr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302085; c=relaxed/simple;
	bh=Wj/m644+t47KAw3LB4MKuqjLJmSbKJ/mTCXlvM4Q5NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQZVHHzxTFFYJH83+1VDvssHBeJuJSPjVAHJvy63JwOkLLjd/05/mw2nmDGw6Ere6IGRsGe0vFWVvHhdkpTqDeqTr+IV3MVWZR+ydVyBoGz1Vz1b+Q1vLl7XswWORvotzJH9QTIHrEPZBgPhLqoC8SAzJC1D/tABP8KcRNYnjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4hS36ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10572C4CEF0;
	Fri, 19 Sep 2025 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758302085;
	bh=Wj/m644+t47KAw3LB4MKuqjLJmSbKJ/mTCXlvM4Q5NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4hS36ry+QYbSYYmEtLZeosWU3x0Z4itK8GmXtBAYYmaFmi9RH01gYERfiCdenb1a
	 6RMyffkabKzw0nDDpwuf+qABO03smyYDKnWo7hjYYqUcVNcwlHOePxcMhVUq/syeQw
	 gjOmUnXR8OB5rPg9JM5WMf6mL7JWUYFJkhm8T9zkeUOqbVRBazugRT6/Z8IAzjxkCq
	 SLYm6CTTB78/e6ev5x1athG0v/oE/EIqfzgqaEqymCHjzCBSGb3mo/b+NF/WUxAp52
	 6DvQ18Tc5iWXawdyjZJFskbv5Rr337R8hfrMcX1nIFvCBZlsPQXhiGFBB/nN3UqZ2X
	 2uTGWDnRtCdgQ==
Date: Fri, 19 Sep 2025 18:14:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, peter.chen@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	peng.fan@nxp.com, jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: usbmisc-imx: add fsl,imx94-usbmisc
 compatible
Message-ID: <20250919-anemia-repressed-9d8ea950ecaf@spud>
References: <20250919071111.2558628-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fEb/lBhoMoWNWi/F"
Content-Disposition: inline
In-Reply-To: <20250919071111.2558628-1-xu.yang_2@nxp.com>


--fEb/lBhoMoWNWi/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--fEb/lBhoMoWNWi/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2PfwAKCRB4tDGHoIJi
0s4+AQCbK/8AUsOWCz+3KwYXizsLQGg7i0VwKgSPMS9KpKNUvgEAht/haKKbsye2
9I5raGzWfgrWOaZ+XbJyboPkFJS6pQs=
=8lcc
-----END PGP SIGNATURE-----

--fEb/lBhoMoWNWi/F--

