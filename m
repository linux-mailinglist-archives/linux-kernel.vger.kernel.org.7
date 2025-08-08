Return-Path: <linux-kernel+bounces-760527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741DB1EC74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218C81885B11
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80B2868B8;
	Fri,  8 Aug 2025 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxcxtoVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D99286413;
	Fri,  8 Aug 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668331; cv=none; b=GYzDZdjE+YhSYpO/EVj/O/12ha9WYVqmCIxFf6rfgjLhP4Ybc2eOg4aP6mKT3dej1ayIe+pKXhODK9v6lKGltDxLJFM415zj8FOwu9mioUPNuD6LyyjOjkEf/SHsAdb2kFZXD5b3A6cuZSIu39/cVqhIIi3gvJj83ywV9dOl5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668331; c=relaxed/simple;
	bh=Gs6NSTTW9TZES8wQNyVAdg6U2mX0mvlwLxDMZvmhOSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOIGvN5wMj0+d+/7UsG36QtD8s9TzV4U74iAOemOqc8cBx5crO8dH8aYQmaR8NMA30cMcLxMUK+SpOlp0amBUqhcLRyQCgRiaAJ98Z9+lPWIQRADeIl4ViZt4yhYcM4lUDk+P+OVYbF5yS+J3W5L5NSQROLUqSehHdslgmyC3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxcxtoVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB66C4CEED;
	Fri,  8 Aug 2025 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754668331;
	bh=Gs6NSTTW9TZES8wQNyVAdg6U2mX0mvlwLxDMZvmhOSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxcxtoVXvrsE1YfcZf1YFVIBpgAxVUufizVV3RjSG/AB2Arwhh3Nkwn/vVqHAx1pf
	 50riRRjAPxxkPTTgkCcpJ9FVfahOTO0BqJuUNh+9zj49+YYNyJfrQjKBhq5amX+jpk
	 pHJ1Vfq3WL050O0FO6G6IztnHCXAgv/BQLqhc+FXybKaxCtCbYXi2DEoV+Vve7SAhl
	 BbqpJtIIjVifMgJMcNd7shX1OsToB7tMIJ+crwKAXNwe3i/XF5dpfEVLd5H59rpphw
	 Z/J67krGV9uvwjc2AdGkQzSizkwSdqMCtRhLLn80ymBOsXEpP8sxSaLXR11YthKgVe
	 O3j9Bh6kU+vig==
Date: Fri, 8 Aug 2025 16:52:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ti,ina2xx: Add INA780 device
Message-ID: <20250808-demanding-upscale-821f23db6ea1@spud>
References: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
 <20250808030510.552724-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2FUh3mvXHkn/E7UG"
Content-Disposition: inline
In-Reply-To: <20250808030510.552724-2-chris.packham@alliedtelesis.co.nz>


--2FUh3mvXHkn/E7UG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 08, 2025 at 03:05:09PM +1200, Chris Packham wrote:
> Add a compatible string for the INA780 device.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--2FUh3mvXHkn/E7UG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJYdJgAKCRB4tDGHoIJi
0u/lAP4i/+m/kGSELzeD1XXcaFUfEL5ww6z9C/xi8We6nrFGKAEA9mdMwHA5+wVt
Gn5clIZRKg8jJZ1hCIGhRJ6UX020+wM=
=5HNm
-----END PGP SIGNATURE-----

--2FUh3mvXHkn/E7UG--

