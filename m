Return-Path: <linux-kernel+bounces-767212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81266B25081
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6307AC11C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0BF28FA9F;
	Wed, 13 Aug 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMas8frn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17E22DF9E;
	Wed, 13 Aug 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104462; cv=none; b=k77XuFCrnGlZC6DteOrOJ1G+ZnTW5NIIEy2eTjoR0Y1WmiSm1wCEfWMGaJhQz3Q5Tx1HqTT74Q3uUIW3/Ge8mEj9puIOjNJYc/q9fhUe3IR1VIE3aaitazFmnI7JEewS6zugF6fKU9nwgOSr6LCBQhU7hxggS28CTguDPoT4F+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104462; c=relaxed/simple;
	bh=hPgVOTOzVezoA5w3n5VtqQYo2mxCUXrIIYMmOg4FXV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Buv1yHiPF1s/+61nPq3BadikcGiUCdHpRX+8IZeGLpZPDSYsRqiu/ipaY65DJhTmxmkoagi9LC3gULHh7R1VTDwRn6FFkVt75gY1OTUZt+fyG4Z/xDrMUC/1Tsjt2ufcN5I8+cm+jpExkXIOj1A2ishIygSIArgj88vqpKF4axM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMas8frn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72301C4CEEF;
	Wed, 13 Aug 2025 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755104461;
	bh=hPgVOTOzVezoA5w3n5VtqQYo2mxCUXrIIYMmOg4FXV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMas8frntNXMrlTT99REIn0+lRenQk6+eTBfytsfAAY80CZSbPag8bJKBuyCTgldc
	 Q1N8eY4ndQ2hQ5GzTkCDGruW8ajBO4TRHU9qMN1BliATenKBTYM+kGxuBOo5ZyTa1X
	 VllOqWMpxzdgTBwuuVV3ijYARoxWHiuaIMLxQHHG2H7XcQoKYL9OugfZLKbCF9qast
	 Dsfu3ss55MUvIqhEiDZSz4ShdxnA8bKfSyNGbEACqOU7QHk+3FOY2MIRg0m94kHq5I
	 /yvtl7yAOdVwgivDRIpLD4RDP8kXamkAtyzX9IlXSPQvPmycoPz2f+ZtSCWsK84VoQ
	 H/qFCQ91dCzWA==
Date: Wed, 13 Aug 2025 18:00:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: reset: thead,th1520-reset: add more
 VOSYS resets
Message-ID: <20250813-upstage-identify-683582a03f7e@spud>
References: <20250813081716.2181843-1-uwu@icenowy.me>
 <20250813081716.2181843-2-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zLx+xFUkqdnSsKIv"
Content-Disposition: inline
In-Reply-To: <20250813081716.2181843-2-uwu@icenowy.me>


--zLx+xFUkqdnSsKIv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 04:17:15PM +0800, Icenowy Zheng wrote:
> VOSYS contains more resets for a display pipeline, includes ones for the
> display controller (called DPU in the manual), the HDMI controller and 2
> MIPI DSI controllers.
>=20
> Allocate IDs for these resets in the dt binding header file.
>=20
> Now all peripheral related VOSYS reset controls are here, only the bus
> matrix / IOPMP ones are missing, which shouldn't be messed with.
>=20
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--zLx+xFUkqdnSsKIv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJzEyAAKCRB4tDGHoIJi
0gxpAP0YBFmEYd0HAqrdEYHu+BQ+mClU/GfxdUwkKpFg61rWXAEAmjNCfBLWG/dz
s0ZdN1Q34+01iYJuldDj2Vwt5ry8MgE=
=VRmL
-----END PGP SIGNATURE-----

--zLx+xFUkqdnSsKIv--

